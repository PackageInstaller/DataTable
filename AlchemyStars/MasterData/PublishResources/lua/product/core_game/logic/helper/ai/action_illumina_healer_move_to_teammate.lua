require("action_move_base")
_class("ActionIlluminaHealerMoveToTeammate_CandidatePos", Object)
ActionIlluminaHealerMoveToTeammate_CandidatePos = ActionIlluminaHealerMoveToTeammate_CandidatePos

function ActionIlluminaHealerMoveToTeammate_CandidatePos:Constructor(movePos, targetEntity, targetDistance, hpPercent, sortIndex)
  self.movePos = movePos
  self.targetEntity = targetEntity
  self.targetDistance = targetDistance
  self.hpPercent = hpPercent
  self.sortIndex = sortIndex
end

function ActionIlluminaHealerMoveToTeammate_CandidatePos.Compare(a, b)
  if a.hpPercent ~= b.hpPercent then
    return a.hpPercent < b.hpPercent
  end
  if a.targetDistance ~= b.targetDistance then
    return a.targetDistance < b.targetDistance
  end
  return a.sortIndex < b.sortIndex
end

_class("ActionIlluminaHealerMoveToTeammate", ActionMoveBase)
ActionIlluminaHealerMoveToTeammate = ActionIlluminaHealerMoveToTeammate

function ActionIlluminaHealerMoveToTeammate:FindNewTargetPos()
  local nSkillID = self:GetLogicData(-1)
  if nSkillID == nil or nSkillID <= 0 then
    self:PrintLog("[ActionIlluminaHealerMoveToTeammate] Can not find skill,move failed", self.m_entityOwn:GetID())
    return
  end
  local posSelf = self.m_entityOwn:GetGridPosition()
  local aiComponent = self.m_entityOwn:AI()
  local nWalkTotal = aiComponent:GetMobilityValid()
  local selfBodyArea = self.m_entityOwn:BodyArea():GetArea()
  local cbFilter = Callback:New(1, self.IsPosAccessible, self)
  local walkRange = ComputeScopeRange.ComputeRange_WalkMathPos(posSelf, #selfBodyArea, nWalkTotal, cbFilter)
  local targetSelector = SkillScopeTargetSelector:New(self._world)
  local candidates = {}
  local movePosBlock = BlockFlag.MonsterLand
  if self.m_entityOwn:HasMonsterID() then
    local cMonsterID = self.m_entityOwn:MonsterID()
    movePosBlock = cMonsterID:GetMonsterBlockData()
  end
  local utilData = self._world:GetService("UtilData")
  table.insert(walkRange, ComputeWalkPos:New(posSelf, 0))
  for _, walkPos in ipairs(walkRange) do
    local centerPos = walkPos:GetPos()
    if centerPos == posSelf or not utilData:IsPosBlock(centerPos, movePosBlock) then
      local fullRange = {}
      local fullRangeIndexDict = {}
      self:_AppendVector2Array(fullRange, fullRangeIndexDict, self:CalculateSkillRange(nSkillID, centerPos, Vector2.up, selfBodyArea))
      self:_AppendVector2Array(fullRange, fullRangeIndexDict, self:CalculateSkillRange(nSkillID, centerPos, Vector2.down, selfBodyArea))
      self:_AppendVector2Array(fullRange, fullRangeIndexDict, self:CalculateSkillRange(nSkillID, centerPos, Vector2.left, selfBodyArea))
      self:_AppendVector2Array(fullRange, fullRangeIndexDict, self:CalculateSkillRange(nSkillID, centerPos, Vector2.right, selfBodyArea))
      local scopeResult = SkillScopeResult:New(SkillScopeType.None, centerPos, fullRange, fullRange)
      local targetArray = targetSelector:DoSelectSkillTarget(self.m_entityOwn, SkillTargetType.SingleGridMonsterLowestHPPercent, scopeResult)
      if 0 < #targetArray then
        local eid = targetArray[1]
        local e = self._world:GetEntityByID(eid)
        local cAttributes = e:Attributes()
        local maxHP = cAttributes:CalcMaxHp()
        local currentHP = cAttributes:GetCurrentHP()
        local percent = currentHP / maxHP
        local distance = Vector2.Distance(posSelf, e:GetGridPosition())
        local candidateInfo = ActionIlluminaHealerMoveToTeammate_CandidatePos:New(centerPos, e, distance, percent, #candidates)
        table.insert(candidates, candidateInfo)
      end
    end
  end
  if 0 < #candidates then
    table.sort(candidates, ActionIlluminaHealerMoveToTeammate_CandidatePos.Compare)
    local winner = candidates[1]
    return winner.movePos
  end
  local distance = 2147483647
  local nearestTargetEntity
  local selfEntityID = self.m_entityOwn:GetID()
  local globalMonsterEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(globalMonsterEntities) do
    if e:GetID() ~= selfEntityID and not e:HasDeadMark() and #e:BodyArea():GetArea() == 1 then
      local dis = Vector2.Distance(e:GetGridPosition(), posSelf)
      if distance > dis then
        distance = dis
        nearestTargetEntity = e
      end
    end
  end
  if nearestTargetEntity then
    return nearestTargetEntity:GetGridPosition()
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local checkCenterPos = posSelf
  if teamEntity then
    checkCenterPos = teamEntity:GetGridPosition()
  end
  local posList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByFar)
  for i = 1, #walkRange - 1 do
    local v2 = walkRange[i]:GetPos()
    AINewNode.InsertSortedArray(posList, checkCenterPos, v2, i)
  end
  return self:FindPosValid(posList, posSelf)
end

function ActionIlluminaHealerMoveToTeammate:_AppendVector2Array(array, dict, source)
  for _, v2 in ipairs(source) do
    local idx = Vector2.Pos2Index(v2)
    if not dict[idx] then
      dict[idx] = true
      table.insert(array, v2)
    end
  end
end
