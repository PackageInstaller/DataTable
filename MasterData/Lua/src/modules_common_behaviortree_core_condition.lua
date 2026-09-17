local this = L_BevTree:registClass("condition", L_BevTree.baseBehaviorNode)

function this:ctor(params)
  this.super.ctor(self, params)
  self.nodeType = L_BevTree.taskType.condition
end

return this
