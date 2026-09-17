local this = L_BevTree:registClass("guide.setScreenTouch", L_BevTree.action)
local tag = this:getName()

function this:param()
  self.isLockScreenTouch = 0
end

function this:parse()
  self.isLockScreenTouch = self:getParam("isLockScreenTouch", true)
end

function this:execute()
  C_ScreenTouch.SetEnabled(math.isEmpty(self.isLockScreenTouch))
  return L_BevTree.taskResult.Success
end

return this
