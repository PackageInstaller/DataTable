local this = L_BevTree:registClass("guide.waitPopupWindowClean", L_BevTree.action)
local waitTime = 0.3

function this:param()
end

function this:parse()
end

function this:onEnter()
  self.checkTime = C_Time.time + waitTime
  self.popupWindowOpened = false
end

function this:execute()
  if self.popupWindowOpened then
    if C_UIMgr.CheckPriorityQueueClean() then
      return L_BevTree.taskResult.Success
    else
      return L_BevTree.taskResult.Running
    end
  elseif C_Time.time > self.checkTime then
    return L_BevTree.taskResult.Success
  else
    if C_UIMgr.CheckPriorityQueueClean() == false then
      self.popupWindowOpened = true
    end
    return L_BevTree.taskResult.Running
  end
end

return this
