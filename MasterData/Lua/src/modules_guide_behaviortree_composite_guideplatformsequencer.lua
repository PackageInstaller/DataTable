local this = L_BevTree:registClass("guide.guidePlatformSequencer", L_BevTree.composite)
local tag = this:getName()

function this:param()
  self.platformType = 1
end

function this:parse()
  self.platformType = self:getParam("platformType", true)
end

function this:onEnter()
  if self.platformType ~= L_DeviceTpl:getEquipment() then
    self.result = L_BevTree.taskResult.Abort
  else
    self.result = L_BevTree.taskResult.Running
  end
end

function this:canRunChildren()
  return self.platformType == L_DeviceTpl:getEquipment()
end

function this:execute(childResult)
  if self.platformType ~= L_DeviceTpl:getEquipment() then
    return L_BevTree.taskResult.Abort
  end
  if childResult == L_BevTree.taskResult.Failure or childResult == L_BevTree.taskResult.Running then
    return childResult
  end
  return L_BevTree.taskResult.Success
end

function this:moveNext()
  if self.lastResult == L_BevTree.taskResult.Failure or self.lastResult == L_BevTree.taskResult.Running then
    return false
  end
  self.childIndex = self.childIndex + 1
  return self.childIndex <= #self.children
end

return this
