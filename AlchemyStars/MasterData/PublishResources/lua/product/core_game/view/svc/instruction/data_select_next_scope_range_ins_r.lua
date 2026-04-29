require("base_ins_r")
_class("DataSelectNextScopeGridRangeInstruction", BaseInstruction)
DataSelectNextScopeGridRangeInstruction = DataSelectNextScopeGridRangeInstruction

function DataSelectNextScopeGridRangeInstruction:Constructor(paramList)
end

function DataSelectNextScopeGridRangeInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local scopeGridRange = phaseContext:GetScopeGridRange()
  if not scopeGridRange then
    phaseContext:SetCurScopeGridRangeIndex(-1)
    return
  end
  local curIndex = phaseContext:GetCurScopeGridRangeIndex()
  curIndex = curIndex + 1
  phaseContext:SetCurScopeGridRangeIndex(curIndex)
end
