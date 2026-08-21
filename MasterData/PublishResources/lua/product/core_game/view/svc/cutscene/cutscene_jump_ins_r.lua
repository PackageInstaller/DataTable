require("cutscene_base_ins_r")
_class("CutsceneJumpInstruction", BaseInstruction)
CutsceneJumpInstruction = CutsceneJumpInstruction

function CutsceneJumpInstruction:Constructor(paramList)
  self._condition = paramList.condition
  self._gotoLabel = paramList["goto"]
  local strResult = paramList.result
  if strResult then
    self._result = tonumber(strResult) == 1
  else
    self._result = true
  end
  self._conditionParam = paramList.param
end

function CutsceneJumpInstruction:DoInstruction(TT, casterEntity, phaseContext)
end
