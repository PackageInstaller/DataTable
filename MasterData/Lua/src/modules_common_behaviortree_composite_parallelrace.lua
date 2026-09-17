local this = L_BevTree:registClass("parallelRace", L_BevTree.composite)
local resultNames = {
  [L_BevTree.taskResult.Success] = "Success",
  [L_BevTree.taskResult.Failure] = "Failure",
  [L_BevTree.taskResult.Running] = "Running",
  [L_BevTree.taskResult.Abort] = "Abort"
}

local function getResultName(result)
  return resultNames[result] or tostring(result)
end

function this:ctor()
  this.super.ctor(self)
  self.finalResult = L_BevTree.taskResult.none
end

function this:param()
end

function this:parse()
end

function this:canRunParallelChildren()
  return true
end

function this:onEnter()
  self.finalResult = L_BevTree.taskResult.none
  C_MJLog.LogInfo(string.format("[GuideRace] event=enter guideId=%s nodeId=%s childCount=%s frame=%s", tostring(self.tree.param.guideId), tostring(self.id), tostring(#self.children), tostring(self.tree.currentFrame)), C_ELogModule.Guide)
end

function this:execute(childResult)
  if childResult == L_BevTree.taskResult.Success then
    self.finalResult = L_BevTree.taskResult.Success
  elseif childResult == L_BevTree.taskResult.Failure or childResult == L_BevTree.taskResult.Abort then
    self.finalResult = L_BevTree.taskResult.Failure
  end
  if self.finalResult ~= L_BevTree.taskResult.none then
    local child = self.children[self.childIndex]
    C_MJLog.LogInfo(string.format("[GuideRace] event=resolved guideId=%s nodeId=%s childId=%s childClass=%s childResult=%s finalResult=%s frame=%s", tostring(self.tree.param.guideId), tostring(self.id), tostring(child and child.id), tostring(child and child.className), getResultName(childResult), getResultName(self.finalResult), tostring(self.tree.currentFrame)), C_ELogModule.Guide)
    return self.finalResult
  end
  return L_BevTree.taskResult.Running
end

function this:moveNext()
  if self.finalResult ~= L_BevTree.taskResult.none then
    return false
  end
  self.childIndex = self.childIndex + 1
  return self.childIndex <= #self.children
end

function this:onFinish()
  for _, child in ipairs(self.children) do
    if child.lastResult == L_BevTree.taskResult.Running then
      C_MJLog.LogInfo(string.format("[GuideRace] event=abortSibling guideId=%s nodeId=%s childId=%s childClass=%s childResult=%s", tostring(self.tree.param.guideId), tostring(self.id), tostring(child.id), tostring(child.className), getResultName(child.lastResult)), C_ELogModule.Guide)
      self.tree:abort(child)
    end
  end
end

return this
