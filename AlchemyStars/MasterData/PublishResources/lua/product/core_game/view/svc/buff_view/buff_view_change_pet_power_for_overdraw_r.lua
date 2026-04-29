_class("BuffViewChangePetPowerForOverdraw", BuffViewBase)
BuffViewChangePetPowerForOverdraw = BuffViewChangePetPowerForOverdraw

function BuffViewChangePetPowerForOverdraw:PlayView(TT)
  local petPowerStateList = self._buffResult:GetPetPowerList()
  if not petPowerStateList or table.count(petPowerStateList) == 0 then
    return
  end
  for _, petPowerState in pairs(petPowerStateList) do
    self:_PlayView(TT, petPowerState)
  end
end

function BuffViewChangePetPowerForOverdraw:_PlayView(TT, petPowerState)
  local entityID = petPowerState.petEntityID
  local petPstID = petPowerState.petPstID
  local curPower = petPowerState.power
  local ready = petPowerState.ready
  local cancelReady = petPowerState.cancelReady
  local addCdAnimation = petPowerState.addCdAnimation
  local requireNTPowerReady = petPowerState.requireNTPowerReady
  local readyNoRemind = petPowerState.readyNoRemind
  local skillID = petPowerState.skillID
  Log.debug("BuffViewChangePetPowerForOverdraw() pet entity=", entityID, " power=", curPower, " ready=", ready)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetPowerChange, petPstID, curPower, true)
end
