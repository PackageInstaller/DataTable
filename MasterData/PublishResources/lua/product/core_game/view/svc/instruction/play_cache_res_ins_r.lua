require("base_ins_r")
_class("PlayCacheResInstruction", BaseInstruction)
PlayCacheResInstruction = PlayCacheResInstruction

function PlayCacheResInstruction:Constructor(paramList)
  self._cfgPetID = tonumber(paramList.petID)
  self._effectIDList = {}
  local str = paramList.effectIDs
  local strIDs = string.split(str, "|")
  for _, strID in ipairs(strIDs) do
    table.insert(self._effectIDList, tonumber(strID))
  end
end

function PlayCacheResInstruction:DoInstruction(TT, casterEntity, phaseContext)
end

function PlayCacheResInstruction:GetCacheResource(skillConfig, skinId)
  local t = {}
  if self._cfgPetID then
    local curSkinId = 0
    if skinId and 0 < skinId then
      curSkinId = skinId
    end
    self:_CollectRes(t, self._cfgPetID, curSkinId)
  end
  for _, effID in ipairs(self._effectIDList) do
    if effID and 0 < effID then
      table.insert(t, {
        Cfg.cfg_effect[effID].ResPath,
        1
      })
    end
  end
  return t
end

function PlayCacheResInstruction:_CollectRes(t, petTemplateId, skinId)
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
