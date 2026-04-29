require("scope_filter_base")
_class("SkillScopeFilter_SkillTargetSelectionMode", SkillScopeFilter_Base)
SkillScopeFilter_SkillTargetSelectionMode = SkillScopeFilter_SkillTargetSelectionMode

function SkillScopeFilter_SkillTargetSelectionMode:DoModifyRange(scopeResult, filterParam, passParam)
  local skillTargetSelectionModea = filterParam:GetTargetSelectionMode()
  local world = passParam:GetWorld()
  if skillTargetSelectionModea == SkillTargetSelectionMode.Grid then
    local utilData = world:GetService("UtilData")
    local extraBoardPosRange = utilData:GetExtraBoardPosList()
    if extraBoardPosRange and table.count(extraBoardPosRange) > 0 then
      for _, pos in ipairs(extraBoardPosRange) do
        table.removev(scopeResult:GetAttackRange(), pos)
        table.removev(scopeResult:GetWholeGridRange(), pos)
      end
    end
  else
  end
end
