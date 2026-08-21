_class("BuffViewRecordPetPowerAndWatch", BuffViewBase)
BuffViewRecordPetPowerAndWatch = BuffViewRecordPetPowerAndWatch

function BuffViewRecordPetPowerAndWatch:PlayView(TT)
  local result = self._buffResult
  local entityID = result:GetEntityID()
  local petPstID = result:GetPetPstID()
  local curPower = result:GetPower()
  local ready = result:GetReady()
  local grayWatch = result:GetGrayWatch()
  local notifyView = result:GetNotifyView()
  Log.debug("BuffViewRecordPetPowerAndWatch() pet entity=", entityID, " power=", curPower, " ready=", ready, " grayWatch=", grayWatch)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetPowerAndWatchChange, petPstID, curPower, ready, grayWatch)
  if ready then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, ready)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetPowerChange, petPstID, curPower, false)
  if notifyView then
    local notify = NTPowerReady:New(self._world:GetEntityByID(entityID))
    self._world:GetService("PlayBuff"):PlayBuffView(TT, notify)
  end
end
