require("action_move_base")
_class("ActionMoveBackAttackSimple", ActionMoveBase)
ActionMoveBackAttackSimple = ActionMoveBackAttackSimple

function ActionMoveBackAttackSimple:Constructor()
  self.m_posListFarTarget = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByFar)
  self.m_posListFarTarget:AllowDuplicate()
end

function ActionMoveBackAttackSimple:Reset()
  ActionMoveBackAttackSimple.super.Reset(self)
  self.m_posListFarTarget:Clear()
end

function ActionMoveBackAttackSimple:InitTargetPosList(listPosTarget)
  local posSelf = self.m_entityOwn:GridLocation().Position
  local nSkillID = self:GetLogicData(1)
  local bodyArea = self.m_entityOwn:BodyArea():GetArea()
  if nSkillID == 0 then
    return
  end
  self.m_posListFarTarget:Clear()
  for _, targetPos in ipairs(listPosTarget) do
    local dir = posSelf - targetPos
    local skillRange = self:_ComputeSkillRange(nSkillID, targetPos, bodyArea, dir)
    for i = 1, #skillRange do
      local posSkill = skillRange[i]
      if self:IsPosAccessible(posSkill) and self:IsPosConnected(targetPos, posSkill) then
        AINewNode.InsertSortedArray(self.m_posListFarTarget, targetPos, posSkill, i)
      end
    end
  end
end

function ActionMoveBackAttackSimple:FindNewTargetPos()
  local aiComponent = self.m_entityOwn:AI()
  local posTarget = aiComponent:GetTargetPos()
  local posSelf = self.m_entityOwn:GridLocation().Position
  if not self:_IsPosInSortedArray(posSelf, self.m_posListFarTarget) then
    return posSelf
  end
  return self:FindPosValidAndConnected(self.m_posListFarTarget, posTarget, posSelf)
end

function ActionMoveBackAttackSimple:_IsPosInSortedArray(posWork, posList)
  local nListCount = posList:Size()
  for i = 1, nListCount do
    local actionData = posList:GetAt(i)
    if actionData and posWork == actionData.data then
      return true
    end
  end
  return false
end
