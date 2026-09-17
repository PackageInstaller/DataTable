local this = class("rewardExtraParam")

function this:ctor()
  self.ignoreQueueCheck = false
  self.rewardShowType = L_Const.rewardShowType.none
end

return this
