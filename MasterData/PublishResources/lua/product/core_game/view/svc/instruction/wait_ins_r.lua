require("base_ins_r")
_class("WaitInstruction", BaseInstruction)
WaitInstruction = WaitInstruction

function WaitInstruction:Constructor(paramList)
  self._waitTime = tonumber(paramList.waitTime)
end

function WaitInstruction:DoInstruction(TT, casterEntity, phaseContext)
  if self._waitTime > 0 then
    YIELD(TT, self._waitTime)
  else
    YIELD(TT)
  end
end
