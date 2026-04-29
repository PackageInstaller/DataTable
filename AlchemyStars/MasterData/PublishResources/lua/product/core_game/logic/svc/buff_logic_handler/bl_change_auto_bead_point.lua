_class("BuffLogicChangeAutoBeadPoint", BuffLogicBase)
BuffLogicChangeAutoBeadPoint = BuffLogicChangeAutoBeadPoint

function BuffLogicChangeAutoBeadPoint:Constructor(buffInstance, logicParam)
  self._mulValue = logicParam.mulValue or 0
  self._addValue = logicParam.addValue or 0
end

function BuffLogicChangeAutoBeadPoint:DoLogic(notify)
  local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local pointEachPower = autoBeadServiceLogic:GetAutoBeadPointEachPower(teamEntity)
  if not pointEachPower then
    return
  end
  local oldVal = autoBeadServiceLogic:GetAutoBeadPoint(teamEntity)
  local modifyValue = math.floor(pointEachPower * self._mulValue) + self._addValue
  autoBeadServiceLogic:AddAutoBeadPoint(teamEntity, modifyValue)
  local curVal = autoBeadServiceLogic:GetAutoBeadPoint(teamEntity)
  local result = BuffResultChangeAutoBeadPoint:New(curVal, oldVal)
  return result
end
