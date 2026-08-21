require("buff_logic_base")
_class("BuffLogicAccumulateChangePower", BuffLogicBase)
BuffLogicAccumulateChangePower = BuffLogicAccumulateChangePower

function BuffLogicAccumulateChangePower:Constructor(buffInstance, logicParam)
  self._accumulate = logicParam.accumulate or 6
  self._reducevalue = logicParam.reducevalue or 1
  self._buffComp = buffInstance:Entity():BuffComponent()
  self._buffComp:SetBuffValue("accumulateChain", 0)
end

function BuffLogicAccumulateChangePower:DoLogic()
  local petEntity = self._buffInstance:Entity()
  local attributeCmpt = petEntity:Attributes()
  local curPower = attributeCmpt:GetAttribute("Power")
  local afterPower = curPower
  local curAccumulateChain = self._buffComp:GetBuffValue("accumulateChain")
  curAccumulateChain = curAccumulateChain + 1
  local requireNTPowerReady = false
  local blsvc = self._world:GetService("BuffLogic")
  if curAccumulateChain >= self._accumulate then
    if curPower == 0 then
      return
    else
      self._buffComp:SetBuffValue("accumulateChain", 0)
      curAccumulateChain = 0
      afterPower = curPower - self._reducevalue
      if afterPower < 0 then
        afterPower = 0
      end
      self._world:GetSyncLogger():Trace({
        key = "BuffLogicAccumulateChangePower",
        petEntityID = petEntity:GetID(),
        AfterPower = afterPower
      })
      attributeCmpt:Modify("Power", afterPower)
      if afterPower == 0 then
        blsvc:ChangePetActiveSkillReady(petEntity, 1)
        local notify = NTPowerReady:New(petEntity)
        self._world:GetService("Trigger"):Notify(notify)
        requireNTPowerReady = true
      end
    end
  else
    self._buffComp:SetBuffValue("accumulateChain", curAccumulateChain)
  end
  local result = BuffResultAccumulateChangePower:New(curAccumulateChain, afterPower)
  if requireNTPowerReady then
    result:RequireNTPowerReady(petEntity:GetID())
  end
  return result
end
