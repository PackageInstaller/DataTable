require("cutscene_base_ins_r")
_class("CutsceneWaitInstruction", CutsceneBaseInstruction)
CutsceneWaitInstruction = CutsceneWaitInstruction

function CutsceneWaitInstruction:Constructor(paramList)
  self._waitTime = tonumber(paramList.waitTime)
end

function CutsceneWaitInstruction:DoInstruction(TT, phaseContext)
  if self._waitTime > 0 then
    YIELD(TT, self._waitTime)
  else
    YIELD(TT)
  end
end
