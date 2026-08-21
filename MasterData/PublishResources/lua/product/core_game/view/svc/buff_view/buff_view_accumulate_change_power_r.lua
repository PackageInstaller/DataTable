_class("BuffViewAccumulateChangePower", BuffViewBase)
BuffViewAccumulateChangePower = BuffViewAccumulateChangePower

function BuffViewAccumulateChangePower:PlayView(TT)
  local result = self:GetBuffResult()
  local curAccumulateNum = result:GetAccChain()
  local curPower = result:GetPower()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self._entity:PetPstID():GetPstID(), curAccumulateNum)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetPowerChange, self._entity:PetPstID():GetPstID(), curPower, true)
  local entityID = self._buffResult:GetPetEntityID()
  local requireNTPowerReady = self._buffResult:IsNTPowerReadyRequired()
  if requireNTPowerReady then
    local notify = NTPowerReady:New(self._world:GetEntityByID(entityID))
    self._world:GetService("PlayBuff"):PlayBuffView(TT, notify)
  end
end
