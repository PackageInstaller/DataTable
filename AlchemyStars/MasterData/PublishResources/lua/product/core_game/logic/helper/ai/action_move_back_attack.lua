require("action_move_base")
_class("ActionMoveBackAttack", ActionMoveBase)
ActionMoveBackAttack = ActionMoveBackAttack

function ActionMoveBackAttack:Constructor()
  self.m_posListNearSelf = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
  self.m_posListNearSelf:AllowDuplicate()
  self.m_posListMoveAttack = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByFar)
  self.m_posListMoveAttack:AllowDuplicate()
end

function ActionMoveBackAttack:Reset()
  ActionMoveBackAttack.super.Reset(self)
  self.m_posListNearSelf:Clear()
  self.m_posListMoveAttack:Clear()
end

function ActionMoveBackAttack:InitTargetPosList(listPosTarget, targetEntityPosCenter)
  local posSelf = self.m_entityOwn:GridLocation().Position
  local dirSelf = self.m_entityOwn:GridLocation().Direction
  local nSkillID = self:GetLogicData(1)
  local bodyArea = self.m_entityOwn:BodyArea():GetArea()
  if nSkillID == 0 then
    return
  end
  local aiComponent = self.m_entityOwn:AI()
  local nWalkTotal = aiComponent:GetMobilityValid()
  local walkRange = self:ComputeWalkRange(posSelf, nWalkTotal, true)
  self.m_posListNearSelf:Clear()
  self.m_posListMoveAttack:Clear()
  for key, targetPos in ipairs(listPosTarget) do
    local skillRange = self:ComputeSkillRange(nSkillID, targetPos, bodyArea, dirSelf)
    local bCheckObstacle = self:GetLogicData(-1) or 0
    for i = 1, #skillRange do
      local posAttack = skillRange[i]
      local bValidPos = self:IsPosAccessible(posAttack)
      local bValidAttackPos = true
      if 0 < bCheckObstacle and bValidPos then
        bValidAttackPos = self:IsPosConnected(targetPos, posAttack)
      end
      AINewNode.InsertSortedArray(self.m_posListNearSelf, posSelf, posAttack, i)
      if bValidPos and bValidAttackPos then
        for j = 1, #walkRange do
          local posData = walkRange[j]
          local posWalk = posData:GetPos()
          if posWalk == posAttack then
            AINewNode.InsertSortedArray(self.m_posListMoveAttack, targetEntityPosCenter, posWalk, j)
          end
        end
      end
    end
  end
end

function ActionMoveBackAttack:ComputeSkillRange(skillID, centerPos, bodyArea, dir)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local scopeType = skillConfigData:GetSkillScopeType()
  if scopeType == SkillScopeType.DirectLineExpand then
    local ret1 = self:_ComputeSkillRange(skillID, centerPos, bodyArea, Vector2(0, 1))
    local ret2 = self:_ComputeSkillRange(skillID, centerPos, bodyArea, Vector2(0, -1))
    local ret3 = self:_ComputeSkillRange(skillID, centerPos, bodyArea, Vector2(1, 0))
    local ret4 = self:_ComputeSkillRange(skillID, centerPos, bodyArea, Vector2(-1, 0))
    local ret = {}
    table.appendArray(ret, ret1)
    table.appendArray(ret, ret2)
    table.appendArray(ret, ret3)
    table.appendArray(ret, ret4)
    return ret
  else
    return self:_ComputeSkillRange(skillID, centerPos, bodyArea, dir)
  end
end

function ActionMoveBackAttack:FindNewTargetPos()
  local aiComponent = self.m_entityOwn:AI()
  local posTarget = aiComponent:GetTargetPosCenter()
  local posSelf = self.m_entityOwn:GridLocation().Position
  local posReturn
  if self.m_posListMoveAttack and self.m_posListMoveAttack:Size() > 0 then
    local aiSortByDistance = self.m_posListMoveAttack:GetAt(1)
    posReturn = aiSortByDistance.data
  end
  if nil ~= posReturn then
    self:PrintLog("选择可以到达的有效进攻出发点，坐标(", posReturn.x, ",", posReturn.y, ")")
    return posReturn
  end
  posReturn = self:FindPosValidAndConnected(self.m_posListNearSelf, posTarget, nil)
  if nil ~= posReturn then
    self:PrintLog("选择距离自己最近的有效进攻出发点，坐标(", posReturn.x, ",", posReturn.y, ")")
    return posReturn
  end
  posReturn = aiComponent:GetTargetPos()
  self:PrintLog("没有有效进攻出发点，选择玩家坐标(", posReturn.x, ",", posReturn.y, ")")
  return posReturn
end

function ActionMoveBackAttack:_IsPosInList(posWork, posList)
  local nListCount = table.count(posList)
  for i = 1, nListCount do
    if posWork == posList[i] then
      return true
    end
  end
  return false
end
