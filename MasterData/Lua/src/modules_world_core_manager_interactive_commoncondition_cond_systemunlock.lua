local condSystemUnlock = {}
local systemUnlockTpl = L_GameTpl:getSystemUnlockTpl()

function condSystemUnlock:canButtonShow(param)
  if not C_IntegrateMgr.SystemUnlockModule:getOnlySystemUnlock(param) then
    return C_IntegrateMgr.SystemUnlockModule:CanButtonShow(param)
  end
  return true
end

function condSystemUnlock:isLocked(param)
  return not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(param)
end

function condSystemUnlock:isCondFit(param)
  return C_IntegrateMgr.SystemUnlockModule:CheckAndTip(param)
end

return condSystemUnlock
