require("buff_logic_base")
_class("BuffLogicAddAutoBeadPointByTeleportDistance", BuffLogicBase)
BuffLogicAddAutoBeadPointByTeleportDistance = BuffLogicAddAutoBeadPointByTeleportDistance

function BuffLogicAddAutoBeadPointByTeleportDistance:Constructor(buffInstance, logicParam)
  self._addValue = logicParam.addValue
end

function BuffLogicAddAutoBeadPointByTeleportDistance:DoLogic(notify)
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local currentRingNum = utilCalcSvc:GetGridRingNum(notify:GetPosNew(), notify:GetPosOld(), notify:GetNotifyEntity():BodyArea():GetArea())
  local addPoint = self._addValue * currentRingNum
  addPoint = math.floor(addPoint)
  local autoBeadServiceLogic = self._world:GetService("AutoBeadLogic")
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local pointEachPower = autoBeadServiceLogic:GetAutoBeadPointEachPower(teamEntity)
  if not pointEachPower then
    return
  end
  local oldVal = autoBeadServiceLogic:GetAutoBeadPoint(teamEntity)
  autoBeadServiceLogic:AddAutoBeadPoint(teamEntity, addPoint)
  local curVal = autoBeadServiceLogic:GetAutoBeadPoint(teamEntity)
  local result = BuffResultAddAutoBeadPointByTeleportDistance:New(curVal, oldVal)
  return result
end
