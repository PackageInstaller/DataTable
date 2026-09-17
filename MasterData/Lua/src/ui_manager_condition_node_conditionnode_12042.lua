local this = class("conditionNode_12042", require(L_R.condition .. "conditionNode"))

function this.checkFunc(condition)
  if table.isEmpty(condition) or math.isEmpty(condition[2]) then
    return false
  end
  local systemId = condition[2]
  local isOpen = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(systemId)
  return isOpen
end

return this
