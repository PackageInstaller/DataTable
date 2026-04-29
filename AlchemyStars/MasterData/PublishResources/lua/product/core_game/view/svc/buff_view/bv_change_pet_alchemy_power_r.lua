_class("BuffViewChangePetAlchemyPower", BuffViewBase)
BuffViewChangePetAlchemyPower = BuffViewChangePetAlchemyPower

function BuffViewChangePetAlchemyPower:IsNotifyMatch(notify)
  if notify.GetAttackPos and notify.GetTargetPos and self._buffResult.attackPos and self._buffResult.targetPos then
    return self._buffResult.attackPos == notify:GetAttackPos() and self._buffResult.targetPos == notify:GetTargetPos()
  else
    return true
  end
end

function BuffViewChangePetAlchemyPower:PlayView(TT)
  local petPowerStateList = self._buffResult:GetPetPowerList()
  for _, petPowerState in pairs(petPowerStateList) do
    self:_PlayView(TT, petPowerState)
  end
end

function BuffViewChangePetAlchemyPower:_PlayView(TT, petPowerState)
  local entityID = petPowerState.petEntityID
  local petPstID = petPowerState.petPstID
  local curPower = petPowerState.power
  local ready = petPowerState.ready
  local requireNTPowerReady = petPowerState.requireNTPowerReady
  local maxValue = petPowerState.maxValue
  local extraSkillID = petPowerState.extraSkillID
  local previouslyReady = petPowerState.previouslyReady
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetAlchemyPowerChange, petPstID, curPower, true, false, maxValue)
  if ready then
    if extraSkillID and extraSkillID ~= 0 then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PetExtraActiveSkillGetReady, petPstID, extraSkillID, ready, previouslyReady)
    else
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PetActiveSkillGetReady, petPstID, ready, previouslyReady)
    end
  elseif extraSkillID and extraSkillID ~= 0 then
    GameGlobal:EventDispatcher():Dispatch(GameEventType.PetExtraActiveSkillCancelReady, petPstID, extraSkillID)
  else
    GameGlobal:EventDispatcher():Dispatch(GameEventType.PetActiveSkillCancelReady, petPstID)
  end
  if requireNTPowerReady then
    local notify = NTPowerReady:New(self._world:GetEntityByID(entityID))
    self._world:GetService("PlayBuff"):PlayBuffView(TT, notify)
  end
end
