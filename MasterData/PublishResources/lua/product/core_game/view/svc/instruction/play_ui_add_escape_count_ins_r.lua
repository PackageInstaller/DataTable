require("base_ins_r")
_class("PlayUIAddEscapeCountInstruction", BaseInstruction)
PlayUIAddEscapeCountInstruction = PlayUIAddEscapeCountInstruction

function PlayUIAddEscapeCountInstruction:Constructor(paramList)
  self._addNum = tonumber(paramList.addNum) or 1
end

function PlayUIAddEscapeCountInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  world:EventDispatcher():Dispatch(GameEventType.UIUpdateEscapeMonsterCount, self._addNum)
end
