_class("BuffViewAddPetLegendPowerByHP", BuffViewBase)
BuffViewAddPetLegendPowerByHP = BuffViewAddPetLegendPowerByHP

function BuffViewAddPetLegendPowerByHP:PlayView(TT)
  local result = self._buffResult
  local petPstID = result:GetPetPstID()
  local curPower = result:GetCurrentPower()
  local isReady = result:IsSkillReady()
  local previouslyReady = result:IsPreviouslyReady()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetLegendPowerChange, petPstID, curPower, true)
  if isReady then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, isReady, previouslyReady)
  end
  local entityID = result:GetPetEntityID()
  local requireNTPowerReady = result:IsNTPowerReadyRequired()
  if requireNTPowerReady then
    local notify = NTPowerReady:New(self._world:GetEntityByID(entityID))
    self._world:GetService("PlayBuff"):PlayBuffView(TT, notify)
  end
end
