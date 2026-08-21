_class("BuffViewChangeTrapPower", BuffViewBase)
BuffViewChangeTrapPower = BuffViewChangeTrapPower

function BuffViewChangeTrapPower:PlayView(TT)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TrapPowerChange)
end
