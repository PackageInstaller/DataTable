local this = L_BevTree:registClass("composite", L_BevTree.baseBehaviorNode)

function this:ctor(params)
  this.super.ctor(self, params)
  self.childIndex = -1
  self.abortType = L_BevTree.abortType.none
  self.nodeType = L_BevTree.taskType.composite
  self.children = {}
end

function this:canRunParallelChildren()
  return false
end

function this:canRunChildren()
  return true
end

function this:onEnter()
  if self.lastResult ~= L_BevTree.taskResult.Running then
    self.lastResult = L_BevTree.taskResult.none
  end
end

function this:moveNext()
  return false
end

function this:getCurChild()
  return self.children[self.childIndex]
end

return this
