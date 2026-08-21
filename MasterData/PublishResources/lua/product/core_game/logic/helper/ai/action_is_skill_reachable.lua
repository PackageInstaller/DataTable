require("action_is_base")
_class("ActionIsSkillReachable", ActionIsBase)
ActionIsSkillReachable = ActionIsSkillReachable

function ActionIsSkillReachable:_GetConfigData(nIndex)
  return self:_GetLogicData(self.m_configData, nIndex)
end

local function _InsertV2ArrayNonDumplicate(a, b, valueMap)
  for _, v in ipairs(b) do
    local integerV2 = Vector2(v.x // 1, v.y // 1)
    local posIndex = v:PosIndex()
    if not valueMap[posIndex] then
      valueMap[posIndex] = true
      table.insert(a, v)
    end
  end
end

function ActionIsSkillReachable:OnUpdate()
  local skillGroup, skillIndex = self:_GetConfigData(1), self:_GetConfigData(2)
  local skillID = self:GetConfigSkillID(skillGroup, skillIndex)
  local notMove = self:_GetConfigData(3) == 1
  if not skillID then
    return AINewNodeStatus.Failure
  end
  local entityCaster = self.m_entityOwn
  local selfPos = entityCaster:GetGridPosition()
  local dir = entityCaster:GridLocation().Direction
  local selfBodyArea = entityCaster:BodyArea():GetArea()
  local world = entityCaster:GetOwnerWorld()
  local monsterID = self.m_entityOwn:MonsterID()
  local raceType = monsterID:GetMonsterRaceType()
  local cfgService = world:GetService("Config")
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local effectCalcSvc = world:GetService("SkillEffectCalc")
  local blockFlag = effectCalcSvc:_TransBlockByRaceType(raceType)
  local aiComponent = self.m_entityOwn:AI()
  local nMobilityValid = aiComponent:GetMobilityValid()
  local reachableRange = {}
  local reachableRangeValueMap = {}
  if notMove then
    local skillRangeData = self:CalculateSkillRange(skillID, selfPos, dir, selfBodyArea)
    _InsertV2ArrayNonDumplicate(reachableRange, skillRangeData, reachableRangeValueMap)
  else
    local cbFilter = Callback:New(1, self.IsPosAccessible, self)
    local walkRange = ComputeScopeRange.ComputeRange_WalkMathPos(selfPos, #selfBodyArea, nMobilityValid, cbFilter)
    for _, walkPos in ipairs(walkRange) do
      local skillRangeData = self:CalculateSkillRange(skillID, walkPos:GetPos(), dir, selfBodyArea)
      _InsertV2ArrayNonDumplicate(reachableRange, skillRangeData, reachableRangeValueMap)
    end
  end
  local entityTarget = aiComponent:GetTargetEntity()
  local bSuccess = self:_IsTargetInSkillRange(entityTarget, reachableRange)
  self:PrintLog("skillID=", skillID)
  return bSuccess and AINewNodeStatus.Success or AINewNodeStatus.Failure
end
