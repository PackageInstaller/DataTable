_class("BuffViewChangePetPowerForExtraSkill", BuffViewBase)
BuffViewChangePetPowerForExtraSkill = BuffViewChangePetPowerForExtraSkill

function BuffViewChangePetPowerForExtraSkill:PlayView(TT)
  local petPowerStateList = self._buffResult:GetPetPowerList()
  for _, petPowerState in pairs(petPowerStateList) do
    self:_PlayView(TT, petPowerState)
  end
end

function BuffViewChangePetPowerForExtraSkill:_PlayView(TT, petPowerState)
  local entityID = petPowerState.petEntityID
  local petPstID = petPowerState.petPstID
  local curPower = petPowerState.power
  local ready = petPowerState.ready
  local cancelReady = petPowerState.cancelReady
  local addCdAnimation = petPowerState.addCdAnimation
  local requireNTPowerReady = petPowerState.requireNTPowerReady
  local readyNoRemind = petPowerState.readyNoRemind
  local skillID = petPowerState.skillID
  if self._buffResult:GetNotifyView() == 0 then
    return
  end
  Log.debug("BuffViewChangePetPowerForExtraSkill() pet entity=", entityID, " power=", curPower, " ready=", ready)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetExtraPowerChange, petPstID, skillID, curPower, true)
  if ready then
    local playReminder = ready
    if readyNoRemind then
      playReminder = false
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PetExtraActiveSkillGetReady, petPstID, skillID, playReminder)
  end
  if cancelReady then
    GameGlobal:EventDispatcher():Dispatch(GameEventType.PetExtraActiveSkillCancelReady, petPstID, skillID, addCdAnimation)
  end
  if requireNTPowerReady then
    local notify = NTPowerReady:New(self._world:GetEntityByID(entityID))
    self._world:GetService("PlayBuff"):PlayBuffView(TT, notify)
  end
end
