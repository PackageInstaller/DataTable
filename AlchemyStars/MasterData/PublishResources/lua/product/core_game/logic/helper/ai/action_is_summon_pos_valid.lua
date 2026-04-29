require("ai_node_new")
local EnumAI_SummonType = {
  MonsterLand = 1,
  MonsterFly = 2,
  SummonTrap = 3
}
_enum("EnumAI_SummonType", EnumAI_SummonType)
_class("ActionIsSummonPosValid", AINewNode)
ActionIsSummonPosValid = ActionIsSummonPosValid

function ActionIsSummonPosValid:Constructor()
  self.m_nPosSource = 1
  self.m_nSummonType = EnumAI_SummonType.MonsterLand
end

function ActionIsSummonPosValid:Reset()
  ActionIsSummonPosValid.super.Reset(self)
  self.m_nPosSource = 1
  self.m_nSummonType = EnumAI_SummonType.MonsterLand
end

function ActionIsSummonPosValid:OnUpdate(dt)
  local nSummonType = self:GetLogicData(-1)
  local nBlockFlag = BlockFlag.MonsterLand
  if EnumAI_SummonType.MonsterLand == nSummonType then
    nBlockFlag = BlockFlag.MonsterLand
  elseif EnumAI_SummonType.MonsterFly == nSummonType then
    nBlockFlag = BlockFlag.MonsterFly
  elseif EnumAI_SummonType.SummonTrap == nSummonType then
    nBlockFlag = BlockFlag.SummonTrap
  end
  local bValid = true
  if 1 == self.m_nPosSource then
    local pos = self.m_entityOwn:GetGridPosition()
    local area = self.m_entityOwn:BodyArea():GetArea()
    local boardServiceLogic = self._world:GetService("BoardLogic")
    for _, value in ipairs(area) do
      if boardServiceLogic:IsPosBlock(pos + value, nBlockFlag) then
        bValid = false
        break
      end
    end
  end
  if not bValid then
    return AINewNodeStatus.Failure
  end
  return AINewNodeStatus.Success
end
