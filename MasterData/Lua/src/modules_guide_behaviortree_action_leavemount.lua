local this = L_BevTree:registClass("guide.leaveMount", L_BevTree.action)

function this:param()
end

function this:parse()
end

function this:onEnter()
  self.curTime = C_Time.time
  self.time = 5
  AzurWorld.mountMgr:ReqLeaveMount(true)
end

function this:execute()
  if L_PlayerStore:playerInMountStatus() then
    if C_Time.time - self.curTime >= self.time then
      return L_BevTree.taskResult.Failure
    end
    return L_BevTree.taskResult.Running
  end
  return L_BevTree.taskResult.Success
end

return this
