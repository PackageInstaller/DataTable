require("action_move_base")
_class("ActionMoveFixTargetAttack", ActionMoveBase)
ActionMoveFixTargetAttack = ActionMoveFixTargetAttack

function ActionMoveFixTargetAttack:Constructor()
  self.m_posListFixTarget = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistanceAndDir._ComparerByNearAndDir)
  self.m_posListFixTarget:AllowDuplicate()
  self.m_posListFrontTarget = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
  self.m_posListFrontTarget:AllowDuplicate()
end

function ActionMoveFixTargetAttack:Reset()
  ActionMoveFixTargetAttack.super.Reset(self)
  self.m_posListFixTarget:Clear()
  self.m_posListFrontTarget:Clear()
end

function ActionMoveFixTargetAttack:InitTargetPosList(listPosTarget)
  local nSkillID = self:GetLogicData(1)
  if nSkillID == 0 then
    return
  end
  self.m_posListFixTarget:Clear()
  self.m_posListFrontTarget:Clear()
  local posSelf = self.m_entityOwn:GridLocation().Position
  local bodyArea = self.m_entityOwn:BodyArea():GetArea()
  local posFix = Vector2.New(self:GetLogicData(-1), self:GetLogicData(-2))
  local aiComponent = self.m_entityOwn:AI()
  local nWalkTotalStep = aiComponent:GetMobilityValid()
  local walkComputeRange = self:ComputeWalkRange(posSelf, nWalkTotalStep, true)
  local walkRange = {}
  for i = 1, #walkComputeRange do
    local posData = walkComputeRange[i]
    local posWalk = posData:GetPos()
    if self:IsPosAccessible(posWalk) then
      table.insert(walkRange, posWalk)
    end
  end
  for _, targetPos in ipairs(listPosTarget) do
    local skillRangeUp = self:_ComputeSkillRange(nSkillID, targetPos, bodyArea, Vector2.up)
    local skillRangeRight = self:_ComputeSkillRange(nSkillID, targetPos, bodyArea, Vector2.right)
    local skillRangeDown = self:_ComputeSkillRange(nSkillID, targetPos, bodyArea, Vector2.down)
    local skillRangeLeft = self:_ComputeSkillRange(nSkillID, targetPos, bodyArea, Vector2.left)
    local skillRange = {}
    table.appendArray(skillRange, skillRangeUp)
    table.appendArray(skillRange, skillRangeRight)
    table.appendArray(skillRange, skillRangeDown)
    table.appendArray(skillRange, skillRangeLeft)
    local workRange = table.union(walkRange, skillRange)
    for i = 1, #workRange do
      local posWork = workRange[i]
      if self:IsPosAccessible(posWork) then
        AINewNode.InsertSortedArrayDisAndDir(self.m_posListFixTarget, posFix, posWork, posSelf, i)
      end
    end
    for j = 1, #skillRange do
      local posSkill = skillRange[j]
      if self:IsPosAccessible(posSkill) then
        AINewNode.InsertSortedArray(self.m_posListFrontTarget, targetPos, posSkill, j)
      end
    end
  end
end

function ActionMoveFixTargetAttack:FindNewTargetPos()
  local posReturn
  if self.m_posListFixTarget and self.m_posListFixTarget:Size() > 0 then
    local target = self.m_posListFixTarget:GetAt(1)
    posReturn = target:GetPosData()
    self:PrintLog("选择可以靠近配置目标点且可攻击的位置，坐标(", posReturn.x, ",", posReturn.y, ")")
    return posReturn
  end
  if self.m_posListFrontTarget and 0 < self.m_posListFrontTarget:Size() then
    local target = self.m_posListFrontTarget:GetAt(1)
    posReturn = target:GetPosData()
    self:PrintLog("选择可攻击且距离攻击目标最近的位置，坐标(", posReturn.x, ",", posReturn.y, ")")
    return posReturn
  end
  local aiComponent = self.m_entityOwn:AI()
  posReturn = aiComponent:GetTargetPos()
  self:PrintLog("没有有效攻击位置，选择目标对象的坐标(", posReturn.x, ",", posReturn.y, ")")
  return posReturn
end
