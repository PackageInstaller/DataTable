local this = class("jumpManager")

function this:jumpTo(jumpId, options, ignoreProxyType)
  local canJump = AzurWorld.JumpMgr:JumpTo(jumpId, options, ignoreProxyType)
  return canJump
end

function this:checkJumpEnable(jumpId)
  local res = AzurWorld.JumpMgr:CheckCanJump(jumpId)
  return res
end

function this:checkJumpFuncOpen(jumpId)
  local res = AzurWorld.JumpMgr:CheckJumpFuncOpen(jumpId)
  return res
end

function this:lockJump(lockState, tipWords)
  AzurWorld.JumpMgr:LockJump(lockState, tipWords)
end

return this
