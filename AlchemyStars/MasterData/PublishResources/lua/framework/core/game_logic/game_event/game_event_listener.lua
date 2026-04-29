_class("GameEventListener", Object)

function GameEventListener:Constructor(world)
  if GameGlobal and GameGlobal.GameEventListenerIDGenerator then
    self.listenerID = GameGlobal.GameEventListenerIDGenerator():GenID()
  end
end

function GameEventListener:GetListenerID()
  return self.listenerID
end

function GameEventListener:OnGameEvent(gameEventType, ...)
end
