require("sp_base_inst")
_class("SkillPreviewPlaySkillCGEffectInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlaySkillCGEffectInstruction = SkillPreviewPlaySkillCGEffectInstruction

function SkillPreviewPlaySkillCGEffectInstruction:Constructor(paramList)
  self._cfgPetID = tonumber(paramList.petID)
  self._waitTime = tonumber(paramList.waitTime)
  self._offsetPos = Vector2.zero
  self._offsetScale = 1
end

function SkillPreviewPlaySkillCGEffectInstruction:_InitCgData(ePet)
  local world = ePet:GetOwnerWorld()
  local cPetPstID = ePet:PetPstID()
  if not cPetPstID then
    return
  end
  local pstID = cPetPstID:GetPstID()
  self._petTemplateID = cPetPstID:GetTemplateID()
  local matchPet = world:GetPetData(pstID)
  if not matchPet then
    Log.fatal("###[SkillPreviewPlaySkillCGEffectInstruction]InitCgData GetPetData is nil ! id --> ", pstID)
    return
  end
  local skinId = matchPet:GetSkinId()
  local cfg = Cfg.cfg_pet_skin[skinId]
  if not cfg then
    Log.fatal("### no skinId in cfg_pet_skin. skinId=", skinId)
    return
  end
  self._effectRes = cfg.ActiveSkillEff .. ".prefab"
  local petCG = cfg.SimpleCG
  petCG = petCG or cfg.StaticBody
  self._petCGMat = petCG .. ".mat"
  local logo = matchPet:GetPetLogo()
  self._petIconMat = logo .. ".mat"
  local cfg = Cfg.pet_cg_transform({
    ResName = petCG,
    UIName = "ActiveSkill"
  })
  cfg = cfg or Cfg.pet_cg_transform({
    ResName = petCG,
    UIName = "UIBattleResultComplete"
  })
  if cfg then
    local v = cfg[1]
    if v then
      local offposOri = Vector2(0, 400)
      local scaleOri = 1
      if v.CGTransform then
        self._offsetPos.x = offposOri.x + v.CGTransform[1]
        self._offsetPos.y = offposOri.y + v.CGTransform[2]
        self._offsetScale = scaleOri * v.CGTransform[3]
      else
        self._offsetPos.x = offposOri.x
        self._offsetPos.y = offposOri.y
        self._offsetScale = scaleOri
      end
    end
  end
  return true
end

function SkillPreviewPlaySkillCGEffectInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  if not self:_InitCgData(casterEntity) then
    return
  end
  local cBattleRenderConfig = world:BattleRenderConfig()
  local canPlayCG = cBattleRenderConfig:GetCanPlaySkillSpineInBattle(self._effectRes, self._petTemplateID)
  if not canPlayCG then
    return
  end
  local skillID = previewContext:GetPreviewActiveSkillID()
  GameGlobal.UIStateManager():ShowDialog("UIBattleUltraSkillCG", {
    effectRes = self._effectRes,
    petCGMat = self._petCGMat,
    offsetPos = self._offsetPos,
    offsetScale = self._offsetScale,
    petIconMat = self._petIconMat,
    skillID = skillID
  })
  YIELD(TT, self._waitTime)
  GameGlobal.UIStateManager():CloseDialog("UIBattleUltraSkillCG")
end
