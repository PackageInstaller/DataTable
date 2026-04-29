require("action_move_base")
_class("ActionMoveFrontAttack", ActionMoveBase)
ActionMoveFrontAttack = ActionMoveFrontAttack

function ActionMoveFrontAttack:Constructor()
  self.m_nextPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
  self.m_nextPosList:AllowDuplicate()
end

function ActionMoveFrontAttack:Reset()
  ActionMoveFrontAttack.super.Reset(self)
  self.m_nextPosList:Clear()
end

function ActionMoveFrontAttack:InitTargetPosList(listPosTarget)
  local posSelf = self.m_entityOwn:GetGridPosition()
  local nSkillID = self:GetLogicData(1)
  local cSkillID = self:GetLogicData(-1)
  if cSkillID then
    nSkillID = cSkillID
  end
  local selfBodyArea = self.m_entityOwn:BodyArea():GetArea()
  if nSkillID <= 0 then
    return
  end
  local range = {}
  self.m_nextPosList:Clear()
  for _, targetPos in ipairs(listPosTarget) do
    local walkRange = self:_ComputeSkillRange(nSkillID, targetPos, selfBodyArea)
    for i = 1, #walkRange do
      local posWork = walkRange[i]
      if self:IsPosAccessible(posWork) then
        range[#range + 1] = Vector2.Pos2Index(posWork)
        AINewNode.InsertSortedArray(self.m_nextPosList, posSelf, posWork, i)
      end
    end
  end
  self:PrintDebugLog("MoveRange=", table.concat(range, " "))
end

function ActionMoveFrontAttack:FindNewTargetPos()
  local posDefault = self.m_entityOwn:AI():GetTargetPos()
  return self:FindPosValid(self.m_nextPosList, posDefault)
end
