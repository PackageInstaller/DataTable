require("base_ins_r")
_class("UiBattleVisibleInstruction", BaseInstruction)
UiBattleVisibleInstruction = UiBattleVisibleInstruction

function UiBattleVisibleInstruction:Constructor(paramList)
  self._visible = tonumber(paramList.visible)
  self._time = 0
  local timeStr = paramList.time
  if timeStr then
    self._time = tonumber(timeStr)
  end
end

function UiBattleVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UiBattleVisible, self._visible, self._time)
end
