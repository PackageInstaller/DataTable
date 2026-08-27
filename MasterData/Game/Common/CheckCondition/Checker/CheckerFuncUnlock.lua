local CheckerFuncUnlock = {}

function CheckerFuncUnlock.LengthCheck(param)
  if 2 <= #param then
    return true
  end
  return false
end

function CheckerFuncUnlock.ParamsCheck(param)
  local ok = FunctionUnlockMgr:ValidateUnlock(param[2])
  return ok
end

function CheckerFuncUnlock.GetUnlockInfo(param)
  local funcId = param[2]
  return FunctionUnlockMgr:GetFuncUnlockDecription(funcId)
end

return CheckerFuncUnlock
