local this = L_BevTree:registClass("decorator", L_BevTree.baseBehaviorNode)

function this:ctor(params)
  this.super.ctor(self, params)
  self.nodeType = L_BevTree.taskType.decorator
  self.children = {}
  self.childIndex = -1
end

function this:getCurChild()
  return self.children[self.childIndex]
end

return this
