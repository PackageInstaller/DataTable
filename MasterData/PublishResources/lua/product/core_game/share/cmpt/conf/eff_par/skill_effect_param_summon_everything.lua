local SkillEffectEnum_SummonBehavior = {
  START = 0,
  Nonrandom = 1,
  Random = 2,
  OutOfGridRange = 3,
  Cage = 4,
  RandomDifferent = 8,
  MirrorImage = 9,
  END = 10
}
_enum("SkillEffectEnum_SummonBehavior", SkillEffectEnum_SummonBehavior)
local SkillEffectEnum_SummonExceptionType = {
  None = 0,
  Around4 = 1,
  Ring9 = 2,
  Around4AndNearToFar = 3,
  Around4AndNearToFarNoRandom = 4
}
_enum("SkillEffectEnum_SummonExceptionType", SkillEffectEnum_SummonExceptionType)
local SkillEffectEnum_SummonUseAttributeType = {
  MonsterCfg = 0,
  CasterBaseAttribute = 1,
  CasterAttribute = 2,
  WorldBossCurStageCfg = 3
}
_enum("SkillEffectEnum_SummonUseAttributeType", SkillEffectEnum_SummonUseAttributeType)
_class("SkillEffectParam_SummonEverything", SkillEffectParamBase)
SkillEffectParam_SummonEverything = SkillEffectParam_SummonEverything

function SkillEffectParam_SummonEverything:Constructor(t)
  self.m_nSummonType = t.summonType
  self.m_nSummonBehavior = SkillEffectEnum_SummonBehavior.Nonrandom
  if t.SummonBehavior ~= nil and t.SummonBehavior > SkillEffectEnum_SummonBehavior.START and t.SummonBehavior < SkillEffectEnum_SummonBehavior.END then
    self.m_nSummonBehavior = t.SummonBehavior
  end
  self.m_nNumber = 1
  if t.Number ~= nil and type(t.Number) == "number" and 1 < t.Number then
    self.m_nNumber = t.Number
  end
  if t.NumberRange ~= nil and type(t.NumberRange) == "table" then
    local min = t.NumberRange[1]
    local max = t.NumberRange[2]
    self.m_nNumberRange = {}
    self.m_nNumberRange.min = min
    self.m_nNumberRange.max = max
  end
  self.m_InheritAttribute = {}
  if t.InheritAttribute ~= nil and type(t.InheritAttribute) == "table" then
    self.m_InheritAttribute = t.InheritAttribute
  end
  self.m_listSummonID = {}
  if type(t.summonID) == "number" then
    self.m_listSummonID[#self.m_listSummonID + 1] = t.summonID
  elseif type(t.summonID) == "table" then
    self.m_listSummonID = t.summonID
  end
  self.m_recordCasterCfgID = false
  if t.RecordCasterCfgID then
    self.m_recordCasterCfgID = true
  end
  self.m_useRecordIDAsSummonID = false
  if t.UseRecordIDAsSummonID then
    self.m_useRecordIDAsSummonID = true
  end
  self._force = t.force or false
  self.m_monsterLimitCount = t.monsterLimitCount or 0
  self.m_limitCheckID = {}
  if t.limitCheckID then
    if type(t.limitCheckID) == "number" then
      self.m_limitCheckID[#self.m_limitCheckID + 1] = t.limitCheckID
    elseif type(t.limitCheckID) == "table" then
      self.m_limitCheckID = t.limitCheckID
    end
  end
  self._useAttribute = t.useAttribute or 0
  self._inheritCheckSuperEntity = false
  if t.inheritCheckSuperEntity then
    self._inheritCheckSuperEntity = t.inheritCheckSuperEntity == 1
  end
  if t.direction and t.direction[1] and t.direction[2] then
    self._direction = Vector2(t.direction[1], t.direction[2])
  else
    self._direction = Vector2(0, 1)
    if self.m_nSummonType == SkillEffectEnum_SummonType.Monster then
      self._direction = nil
    end
  end
  if t.useRandomDirection then
    self._useRandomDirection = t.useRandomDirection == 1
  end
  self._ignoreBlock = false
  if t.ignoreBlock then
    self._ignoreBlock = t.ignoreBlock == 1
  end
  self._exceptionType = t.exceptionType or SkillEffectEnum_SummonExceptionType.None
  self._summonUseCasterDir = t.summonUseCasterDir or 0
  self._inheritElement = t.inheritElement or false
  self._initCasterBornBuff = t.initCasterBornBuff or 0
  self._summonCheckIgnoreBodyArea = false
  if t.summonCheckIgnoreBodyArea then
    self._summonCheckIgnoreBodyArea = t.summonCheckIgnoreBodyArea == 1
  end
  self._modifyMonsterBodyAreaByDir = false
  if t.modifyMonsterBodyAreaByDir then
    self._modifyMonsterBodyAreaByDir = t.modifyMonsterBodyAreaByDir == 1
  end
  if t.cageSumOffPosList then
    self._cageSumOffPosList = {}
    for index, value in ipairs(t.cageSumOffPosList) do
      local offPos = Vector2(value[1], value[2])
      table.insert(self._cageSumOffPosList, offPos)
    end
  end
  self._useBuffLayerAsTimes = t.useBuffLayerAsTimes
  self._summonTimesForEachID = t.summonTimesForEachID
  self._trapID = t.trapID
end

function SkillEffectParam_SummonEverything:GetEffectType()
  return SkillEffectType.SummonEverything
end

function SkillEffectParam_SummonEverything:GetSummonType()
  return self.m_nSummonType
end

function SkillEffectParam_SummonEverything:GetSummonList()
  return self.m_listSummonID
end

function SkillEffectParam_SummonEverything:IsRecordCasterCfgID()
  return self.m_recordCasterCfgID
end

function SkillEffectParam_SummonEverything:IsUseRecordIDAsSummonID()
  return self.m_useRecordIDAsSummonID
end

function SkillEffectParam_SummonEverything:GetLimitCheckID()
  return self.m_limitCheckID
end

function SkillEffectParam_SummonEverything:GetCpSummonList()
  local retSummonId = {}
  for key, value in pairs(self.m_listSummonID) do
    retSummonId[key] = value
  end
end

function SkillEffectParam_SummonEverything:GetForce()
  return self._force
end

function SkillEffectParam_SummonEverything:GetSummonBehavior()
  return self.m_nSummonBehavior
end

function SkillEffectParam_SummonEverything:GetSummonNumber()
  return self.m_nNumber
end

function SkillEffectParam_SummonEverything:GetSummonNumberRange()
  return self.m_nNumberRange
end

function SkillEffectParam_SummonEverything:GetInheritAttribute()
  return self.m_InheritAttribute
end

function SkillEffectParam_SummonEverything:GetSummonMonsterLimitCount()
  return self.m_monsterLimitCount
end

function SkillEffectParam_SummonEverything:GetUseAttribute()
  return self._useAttribute
end

function SkillEffectParam_SummonEverything:GetInheritCheckSuperEntity()
  return self._inheritCheckSuperEntity
end

function SkillEffectParam_SummonEverything:GetDirection()
  return self._direction
end

function SkillEffectParam_SummonEverything:GetUseRandomDirection()
  return self._useRandomDirection
end

function SkillEffectParam_SummonEverything:IsIgnoreBlock()
  return self._ignoreBlock
end

function SkillEffectParam_SummonEverything:GetSummonExceptionType()
  return self._exceptionType
end

function SkillEffectParam_SummonEverything:GetSummonUseCasterDir()
  return self._summonUseCasterDir
end

function SkillEffectParam_SummonEverything:GetInheritElement()
  return self._inheritElement
end

function SkillEffectParam_SummonEverything:GetInitCasterBornBuff()
  return self._initCasterBornBuff
end

function SkillEffectParam_SummonEverything:GetModifyMonsterBodyAreaByDir()
  return self._modifyMonsterBodyAreaByDir
end

function SkillEffectParam_SummonEverything:GetSummonCheckIgnoreBodyArea()
  return self._summonCheckIgnoreBodyArea
end

function SkillEffectParam_SummonEverything:GetCageSumOffPosList()
  return self._cageSumOffPosList
end

function SkillEffectParam_SummonEverything:GetUseBuffLayerAsTimes()
  return self._useBuffLayerAsTimes
end

function SkillEffectParam_SummonEverything:GetSummonTimesForEachID()
  return self._summonTimesForEachID
end

function SkillEffectParam_SummonEverything:GetTrapID()
  return self._trapID
end
