require("action_move_base")
_class("ActionMoveBackEscape", ActionMoveBase)
ActionMoveBackEscape = ActionMoveBackEscape

function ActionMoveBackEscape:Constructor()
  self.m_posFirst = nil
  self.m_nextPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByFar)
  self.m_nextPosList:AllowDuplicate()
end

function ActionMoveBackEscape:Reset()
  ActionMoveBackEscape.super.Reset(self)
  self.m_nextPosList:Clear()
end

function ActionMoveBackEscape:InitTargetPosList(listPosTarget)
  local posSelf = self.m_entityOwn:GridLocation().Position
  local nSkillID = self:GetLogicData(1)
  local nBodyAreaCount = self.m_entityOwn:BodyArea():GetAreaCount()
  local aiComponent = self.m_entityOwn:AI()
  local nWalkTotal = aiComponent:GetMobilityValid()
  if nWalkTotal == aiComponent:GetMobilityConfig() then
    self.m_posFirst = nil
  end
  local walkRange = self:ComputeWalkRange(posSelf, nWalkTotal, true)
  local bExcludeSelf = self:GetLogicData(-1) or 0
  self.m_nextPosList:Clear()
  for _, targetPos in ipairs(listPosTarget) do
    if bExcludeSelf <= 0 then
      AINewNode.InsertSortedArray(self.m_nextPosList, targetPos, posSelf, 0)
    end
    for i = 1, #walkRange do
      local posData = walkRange[i]
      local posWalk = posData:GetPos()
      if self:IsPosAccessible(posWalk) and (0 == bExcludeSelf or 0 < bExcludeSelf and posWalk ~= posSelf) then
        AINewNode.InsertSortedArray(self.m_nextPosList, targetPos, posWalk, i)
      end
    end
  end
end

function ActionMoveBackEscape:FindNewTargetPos()
  local posFind
  local bForgetFirstPos = self:GetLogicData(-2) or 0
  if 0 < bForgetFirstPos then
    local posDefault = self.m_entityOwn:GetGridPosition()
    posFind = self:FindPosValid(self.m_nextPosList, posDefault)
  else
    if self.m_posFirst and self:IsPosAccessible(self.m_posFirst) then
      posFind = self.m_posFirst
    end
    if nil == posFind then
      local posDefault = self.m_entityOwn:GetGridPosition()
      posFind = self:FindPosValid(self.m_nextPosList, posDefault)
      self.m_posFirst = posFind
    end
  end
  return posFind
end
