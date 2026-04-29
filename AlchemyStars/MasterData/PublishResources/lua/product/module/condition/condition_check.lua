_class("ConditionCheck", Singleton)
ConditionCheck = ConditionCheck

function ConditionCheck:Constructor()
  self:_InitCheckFunction()
end

function ConditionCheck:_InitCheckFunction()
  self._CheckFunction = {
    [ConditionType.CT_PetGradeLevel] = self._CheckPetGradeLevel,
    [ConditionType.CT_PetAwakeLevel] = self._CheckPetAwakeLevel,
    [ConditionType.CT_PeAffinityLevel] = self._CheckPetAffinityLevel,
    [ConditionType.CT_PetEquipLv] = self._CheckPetEquipLv
  }
end

function ConditionCheck:Check(condition, outTxt, customeKey)
  if not condition or not condition[1] then
    Log.error("ConditionCheck err: " .. condition)
    return false
  end
  local conditionId = condition[1]
  local checkFunction = self._CheckFunction[conditionId]
  if checkFunction then
    return checkFunction(self, condition, outTxt, customeKey)
  else
    Log.error("ConditionCheck unsupport condition, need expand " .. conditionId)
    return false
  end
end

function ConditionCheck:_GenTxt(conditonId, customeKey, ...)
  local lanKey = customeKey
  if not lanKey then
    local cfg = Cfg.cfg_condition_common_show[conditonId]
    if not cfg then
      Log.error("ConditionCheck err: can't find cfg_condition_common_show with id = " .. conditonId)
      return nil
    end
    lanKey = cfg.Show
  end
  return StringTable.Get(lanKey, ...)
end

function ConditionCheck:_CheckPetGradeLevel(condition, outTxt, customeKey)
  local petModule = GameGlobal.GetModule(PetModule)
  local conditionId = condition[1]
  local nPetTemplateID = condition[2]
  local nLimitGrade = condition[3]
  local nLimitLevel = condition[4]
  nLimitGrade = nLimitGrade or 0
  local str
  local petFind = petModule:GetPetByTemplateId(nPetTemplateID)
  if nil == petFind then
    if outTxt then
      str = self:_GenTxt(conditionId, customeKey, nLimitGrade, nLimitLevel)
    end
    return false, str, 0, nLimitGrade, 0, nLimitLevel
  end
  local petGrade = petFind:GetPetGrade()
  if nLimitGrade > petGrade then
    if outTxt then
      str = self:_GenTxt(conditionId, customeKey, nLimitGrade, nLimitLevel)
    end
    return false, str, petGrade, nLimitGrade, 0, nLimitLevel
  end
  nLimitLevel = nLimitLevel or 0
  if nLimitLevel > petFind:GetPetLevel() then
    if outTxt then
      str = self:_GenTxt(conditionId, customeKey, nLimitGrade, nLimitLevel)
    end
    return false, str, petGrade, nLimitGrade, petFind:GetPetLevel(), nLimitLevel
  end
  if outTxt then
    str = self:_GenTxt(conditionId, customeKey, nLimitGrade, nLimitLevel)
  end
  return true, str, petGrade, nLimitGrade, petFind:GetPetLevel(), nLimitLevel
end

function ConditionCheck:_CheckPetAwakeLevel(condition, outTxt, customeKey)
  local petModule = GameGlobal.GetModule(PetModule)
  local conditionId = condition[1]
  local nPetTemplateID = condition[2]
  local nLimitAwake = condition[3]
  nLimitAwake = nLimitAwake or 0
  local str
  local petFind = petModule:GetPetByTemplateId(nPetTemplateID)
  if nil == petFind then
    if outTxt then
      str = self:_GenTxt(conditionId, customeKey, nLimitAwake)
    end
    return false, str, 0, nLimitAwake
  end
  local petAwaken = petFind:GetPetAwakening()
  local ret = nLimitAwake <= petAwaken
  if outTxt then
    str = self:_GenTxt(conditionId, customeKey, nLimitAwake)
  end
  return ret, str, petAwaken, nLimitAwake
end

function ConditionCheck:_CheckPetAffinityLevel(condition, outTxt, customeKey)
  local petModule = GameGlobal.GetModule(PetModule)
  local conditionId = condition[1]
  local nPetTemplateID = condition[2]
  local nLimitAffinity = condition[3]
  nLimitAffinity = nLimitAffinity or 0
  local str
  local petFind = petModule:GetPetByTemplateId(nPetTemplateID)
  if nil == petFind then
    if outTxt then
      str = self:_GenTxt(conditionId, customeKey, nLimitAffinity)
    end
    return false, str, 0, nLimitAffinity
  end
  local petAffinityLevel = petFind:GetPetAffinityLevel()
  local ret = nLimitAffinity <= petAffinityLevel
  if outTxt then
    str = self:_GenTxt(conditionId, customeKey, nLimitAffinity)
  end
  return ret, str, petAffinityLevel, nLimitAffinity
end

function ConditionCheck:_CheckPetEquipLv(condition, outTxt, customeKey)
  local petModule = GameGlobal.GetModule(PetModule)
  local conditionId = condition[1]
  local nPetTemplateID = condition[2]
  local nLimitEquipLevel = condition[3]
  nLimitEquipLevel = nLimitEquipLevel or 0
  local str
  local petFind = petModule:GetPetByTemplateId(nPetTemplateID)
  if nil == petFind then
    if outTxt then
      str = self:_GenTxt(conditionId, customeKey, nLimitEquipLevel)
    end
    return false, str, 0, nLimitEquipLevel
  end
  local petEquipLv = petFind:GetEquipLv()
  local ret = nLimitEquipLevel <= petEquipLv
  if outTxt then
    str = self:_GenTxt(conditionId, customeKey, nLimitEquipLevel)
  end
  return ret, str, petEquipLv, nLimitEquipLevel
end
