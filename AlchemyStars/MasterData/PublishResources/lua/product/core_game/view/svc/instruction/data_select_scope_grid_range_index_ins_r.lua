require("base_ins_r")
_class("DataSelectScopeGridRangeIndexInstruction", BaseInstruction)
DataSelectScopeGridRangeIndexInstruction = DataSelectScopeGridRangeIndexInstruction

function DataSelectScopeGridRangeIndexInstruction:Constructor(paramList)
  self._index = tonumber(paramList.index)
end

function DataSelectScopeGridRangeIndexInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local scopeGridRange = phaseContext:GetScopeGridRange()
  if not scopeGridRange then
    return InstructionConst.PhaseEnd
  end
  if scopeGridRange[self._index] then
    phaseContext:SetCurScopeGridRangeIndex(self._index)
  end
end
