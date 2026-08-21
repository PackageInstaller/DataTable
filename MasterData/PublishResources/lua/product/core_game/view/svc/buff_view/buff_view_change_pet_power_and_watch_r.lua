_class("BuffViewChangePetPowerAndWatch", BuffViewBase)
BuffViewChangePetPowerAndWatch = BuffViewChangePetPowerAndWatch

function BuffViewChangePetPowerAndWatch:PlayView(TT)
  local petPowerStateList = self._buffResult:GetPetPowerList()
  for _, petPowerState in pairs(petPowerStateList) do
    self:_PlayView(TT, petPowerState)
  end
end

function BuffViewChangePetPowerAndWatch:_PlayView(TT, petPowerState)
  local entityID = petPowerState.petEntityID
  local petPstID = petPowerState.petPstID
  local curPower = petPowerState.power
  local ready = petPowerState.ready
  local requireNTPowerReady = petPowerState.requireNTPowerReady
  Log.debug("BuffViewChangePetPowerAndWatch() pet entity=", entityID, " power=", curPower, " ready=", ready)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetPowerChange, petPstID, curPower, true)
  if ready then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, ready)
  end
  if requireNTPowerReady then
    local notify = NTPowerReady:New(self._world:GetEntityByID(entityID))
    self._world:GetService("PlayBuff"):PlayBuffView(TT, notify)
  end
end
