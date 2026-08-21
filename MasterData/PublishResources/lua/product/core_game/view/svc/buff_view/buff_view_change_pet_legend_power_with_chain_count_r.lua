_class("BuffViewChangePetLegendPowerWithChainCount", BuffViewBase)
BuffViewChangePetLegendPowerWithChainCount = BuffViewChangePetLegendPowerWithChainCount

function BuffViewChangePetLegendPowerWithChainCount:PlayView(TT)
  local petPowerStateList = self._buffResult:GetPetPowerList()
  for _, petPowerState in pairs(petPowerStateList) do
    self:_PlayView(TT, petPowerState)
  end
end

function BuffViewChangePetLegendPowerWithChainCount:_PlayView(TT, petPowerState)
  local entityID = petPowerState.petEntityID
  local petPstID = petPowerState.petPstID
  local curPower = petPowerState.power
  local ready = petPowerState.ready
  local requireNTPowerReady = petPowerState.requireNTPowerReady
  local previouslyReady = petPowerState.previouslyReady
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetLegendPowerChange, petPstID, curPower, true)
  if ready then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, ready, previouslyReady)
  else
    GameGlobal:EventDispatcher():Dispatch(GameEventType.PetActiveSkillCancelReady, petPstID)
  end
  if requireNTPowerReady then
    local notify = NTPowerReady:New(self._world:GetEntityByID(entityID))
    self._world:GetService("PlayBuff"):PlayBuffView(TT, notify)
  end
end
