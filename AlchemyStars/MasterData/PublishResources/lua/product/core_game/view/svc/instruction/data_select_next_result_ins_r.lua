require("data_select_result_ins_r")
_class("DataSelectNextResultInstruction", DataSelectResultInstruction)
DataSelectNextResultInstruction = DataSelectNextResultInstruction

function DataSelectNextResultInstruction:GetIndex()
  local currentIndex = self._currentPhaseContext:GetCurResultIndexByType(self:GetEffectType())
  if currentIndex ~= -1 then
    currentIndex = currentIndex + 1
  end
  return currentIndex
end
