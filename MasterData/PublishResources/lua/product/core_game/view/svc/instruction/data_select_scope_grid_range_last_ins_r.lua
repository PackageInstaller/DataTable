require("base_ins_r")
_class("DataSelectScopeGridRangeLastInstruction", BaseInstruction)
DataSelectScopeGridRangeLastInstruction = DataSelectScopeGridRangeLastInstruction

function DataSelectScopeGridRangeLastInstruction:Constructor(paramList)
end

function DataSelectScopeGridRangeLastInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local scopeGridRange = phaseContext:GetScopeGridRange()
  if not scopeGridRange then
    return InstructionConst.PhaseEnd
  end
  if 0 < #scopeGridRange and 0 < #scopeGridRange[1] then
    phaseContext:SetCurScopeGridRangeIndex(#scopeGridRange[1])
  end
end
