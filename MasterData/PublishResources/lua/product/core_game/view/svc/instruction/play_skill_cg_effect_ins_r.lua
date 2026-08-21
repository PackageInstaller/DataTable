require("base_ins_r")
_class("PlaySkillCGEffectInstruction", BaseInstruction)
PlaySkillCGEffectInstruction = PlaySkillCGEffectInstruction

function PlaySkillCGEffectInstruction:Constructor(paramList)
  self._waitTime = tonumber(paramList.waitTime)
  self._offsetPos = Vector2.zero
  self._offsetScale = 1
  self._cfgPetID = tonumber(paramList.petID)
end

function PlaySkillCGEffectInstruction:_InitCgData(ePet)
  local world = ePet:GetOwnerWorld()
  local cPetPstID = ePet:PetPstID()
  if not cPetPstID then
    return
  end
  local pstID = cPetPstID:GetPstID()
  self._petID = cPetPstID:GetTemplateID()
  local matchPet = world:GetPetData(pstID)
  if not matchPet then
    Log.fatal("###[PlaySkillCGEffectInstruction]InitCgData GetPetData is nil ! id --> ", pstID)
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

function PlaySkillCGEffectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  if not self:_InitCgData(casterEntity) then
    return
  end
  local cBattleRenderConfig = world:BattleRenderConfig()
  local canPlayCG = cBattleRenderConfig:GetCanPlaySkillSpineInBattle(self._effectRes, self._petID)
  if not canPlayCG then
    return
  end
  if GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    return
  end
  local skillID = self:GetSkillID(casterEntity)
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

function PlaySkillCGEffectInstruction:GetCacheResource(skillConfig, skinId)
  local t = {}
  if self._cfgPetID then
    local curSkinId = 0
    if skinId and 0 < skinId then
      curSkinId = skinId
    end
    self:_CollectRes(t, self._cfgPetID, curSkinId)
  end
  return t
end

function PlaySkillCGEffectInstruction:_CollectRes(t, petTemplateId, skinId)
  if GameGlobal.GetModule(SkillPerfModule):IsBeginPerf() then
    return
  end
  local cfg = Cfg.cfg_pet_skin[skinId]
  if not cfg then
    return
  end
  if cfg.ActiveSkillEff then
    local effectRes = cfg.ActiveSkillEff .. ".prefab"
    table.insert(t, {effectRes, 1})
  end
  local petCG = cfg.SimpleCG
  petCG = petCG or cfg.StaticBody
  if petCG then
    local petCGMat = petCG .. ".mat"
    table.insert(t, {petCGMat, 1})
  end
  local cfg_pet = Cfg.cfg_pet[petTemplateId]
  if cfg_pet then
    local logo = cfg_pet.Logo
    if logo then
      local petIconMat = logo .. ".mat"
      table.insert(t, {petIconMat, 1})
    end
  end
end
