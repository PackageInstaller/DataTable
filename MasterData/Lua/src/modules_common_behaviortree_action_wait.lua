local this = L_BevTree:registClass("wait", L_BevTree.action)

function this:param()
  self.time = 1
end

function this:parse()
  self.time = self:getParam("time", true)
end

function this:onEnter()
  if self.time == -1 then
    return
  end
  self.curTime = C_Time.time
end

function this:execute()
  if self.time == -1 then
    return L_BevTree.taskResult.Running
  end
  if C_Time.time - self.curTime >= self.time then
    return L_BevTree.taskResult.Success
  else
    return L_BevTree.taskResult.Running
  end
end

return this
