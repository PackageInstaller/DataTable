local this = L_BevTree:registClass("action", L_BevTree.baseBehaviorNode)

function this:ctor(params)
  this.super.ctor(self, params)
  self.nodeType = L_BevTree.taskType.action
  self.actionType = L_BevTree.actionType.none
end

function this:onEnter()
end

function this:execute()
  return L_BevTree.taskResult.Success
end

function this:onAbortSelf()
end

return this
