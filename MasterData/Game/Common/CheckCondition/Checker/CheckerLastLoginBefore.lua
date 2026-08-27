local CheckerLastLoginBefore = {}

function CheckerLastLoginBefore.LengthCheck(param)
  if 2 <= #param then
    return true
  end
  return false
end

function CheckerLastLoginBefore.ParamsCheck(param)
  return true
end

function CheckerLastLoginBefore.GetUnlockInfo(param)
  return ""
end

return CheckerLastLoginBefore
