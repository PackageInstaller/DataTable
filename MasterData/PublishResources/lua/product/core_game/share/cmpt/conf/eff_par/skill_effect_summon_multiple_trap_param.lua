require("skill_effect_param_base")
_class("SkillEffectSummonMultipleTrapParam", SkillEffectParamBase)
SkillEffectSummonMultipleTrapParam = SkillEffectSummonMultipleTrapParam

function SkillEffectSummonMultipleTrapParam:Constructor(t)
  local metaSrc = t.src
  local colorDic = {}
  if not metaSrc then
    colorDic = self:_GenerateFullColorTable()
  elseif "number" == type(metaSrc) then
    colorDic = {
      [tonumber(metaSrc)] = true
    }
  elseif #metaSrc == 0 then
    colorDic = self:_GenerateFullColorTable()
  else
    colorDic = {}
    for i = 1, #metaSrc do
      colorDic[tonumber(metaSrc[i])] = true
    end
  end
  self._colorDic = colorDic
  self._trapID = t.trapID
  self._maxCount = t.maxCount
  self._isRandom = t.random == 1
  self._absPosArray = t.absPos or {}
  self._emptyPieceOnly = t.emptyPieceOnly == 1
  self._ignoreBlock = t.ignoreBlock or false
  self._ignoreAbyss = t.ignoreAbyss or false
  self._maxRandCount = t.maxRandCount
  self._minRandCount = t.minRandCount
  self:CheckMinMaxRoundCount()
  self._additionalCountScopeType = t.additionalCountScopeType
  self._additionalCountScopeParam = t.additionalCountScopeParam
  self._additionalCountElementType = t.additionalCountElementType or {}
  self._additionalCountParam = t.additionalCountParam
  self._maxAdditionalCount = t.maxAdditionalCount
  self._transferDisabled = t.transferDisabled == 1
  self._isEmptyOrTrap = t.emptyOrTrap
  self._findPosTrapId = t.findPosTrapId
  self._useBoardRandom = t.useBoardRandom or 0
  self._blockSummonTrapType = t.blockSummonTrapType
  self._excludeTraps = t.excludeTraps
  self._isFindRandEmptyPosIfNoValid = t.isFindRandEmptyPosIfNoValid or false
  self._sortValidPosType = t.sortValidPosType
  self._teamLeaderElement = t.TeamLeaderElement
  self._colorPriorityDic = t.colorPriorityDic
  self._useTetrisFeatureCount = t.useTetrisFeatureCount
end

function SkillEffectSummonMultipleTrapParam:IsUseTetrisFeatureCount()
  return self._useTetrisFeatureCount
end

function SkillEffectSummonMultipleTrapParam:_GenerateFullColorTable()
  local t = {}
  for key, value in pairs(PieceType) do
    t[value] = true
  end
  return t
end

function SkillEffectSummonMultipleTrapParam:GetEffectType()
  return SkillEffectType.SummonMultipleTrap
end

function SkillEffectSummonMultipleTrapParam:GetSelectedColorTable()
  return self._colorDic
end

function SkillEffectSummonMultipleTrapParam:GetTrapID()
  return self._trapID
end

function SkillEffectSummonMultipleTrapParam:GetMaxCount()
  return self._maxCount
end

function SkillEffectSummonMultipleTrapParam:IsRandom()
  return self._isRandom
end

function SkillEffectSummonMultipleTrapParam:GetAbsPosArray()
  return self._absPosArray
end

function SkillEffectSummonMultipleTrapParam:IsEmptyPosOnly()
  return self._emptyPieceOnly
end

function SkillEffectSummonMultipleTrapParam:IgnoreBlock()
  return self._ignoreBlock
end

function SkillEffectSummonMultipleTrapParam:CheckMinMaxRoundCount()
  if self._minRandCount or self._maxRandCount then
    if not self._minRandCount or not self._maxRandCount then
      Log.fatal("Config Failed ,minRoundCount:", self._minRandCount, "maxRound", self._maxRandCount)
    elseif self._minRandCount > self._maxRandCount then
      Log.fatal("Config Failed ,minRoundCount:", self._minRandCount, "maxRound", self._maxRandCount)
    end
  end
end

function SkillEffectSummonMultipleTrapParam:GetRandCount()
  return self._minRandCount, self._maxRandCount
end

function SkillEffectSummonMultipleTrapParam:GetIgnoreAbyss()
  return self._ignoreAbyss
end

function SkillEffectSummonMultipleTrapParam:GetAdditionalCountScopeType()
  return self._additionalCountScopeType
end

function SkillEffectSummonMultipleTrapParam:GetAdditionalCountScopeParam()
  return self._additionalCountScopeParam
end

function SkillEffectSummonMultipleTrapParam:GetAdditionalCountElementType()
  return self._additionalCountElementType
end

function SkillEffectSummonMultipleTrapParam:GetAdditionalCountElementDic()
  local d = {}
  for _, element in ipairs(self._additionalCountElementType) do
    d[element] = true
  end
  return d
end

function SkillEffectSummonMultipleTrapParam:GetAdditionalCountParam()
  return self._additionalCountParam
end

function SkillEffectSummonMultipleTrapParam:GetMaxAdditionalCount()
  return self._maxAdditionalCount
end

function SkillEffectSummonMultipleTrapParam:IsTransferDisabled()
  return self._transferDisabled
end

function SkillEffectSummonMultipleTrapParam:IsEmptyOrTrap()
  return self._isEmptyOrTrap
end

function SkillEffectSummonMultipleTrapParam:GetFindPosTrapId()
  return self._findPosTrapId
end

function SkillEffectSummonMultipleTrapParam:IsUseBoardRandom()
  return self._useBoardRandom == 1
end

function SkillEffectSummonMultipleTrapParam:GetBlockSummonTrapType()
  return self._blockSummonTrapType
end

function SkillEffectSummonMultipleTrapParam:GetExcludeTraps()
  return self._excludeTraps
end

function SkillEffectSummonMultipleTrapParam:IsFindRandEmptyPosIfNoValid()
  return self._isFindRandEmptyPosIfNoValid
end

function SkillEffectSummonMultipleTrapParam:GetSortValidPosType()
  return self._sortValidPosType
end

function SkillEffectSummonMultipleTrapParam:GetTeamLeaderElement()
  return self._teamLeaderElement
end

function SkillEffectSummonMultipleTrapParam:GetColorPriorityDic()
  return self._colorPriorityDic
end
