local this = class("moduleRewardTipBtnA", G_UIModuleBase)

function this.bind()
  return {
    txt_number = "",
    go_rewardBg = false,
    go_redDot = false
  }
end

function this.methods()
  return {}
end

function this:open(options)
end

function this:refreshNumber(num)
  self.txt_number = num
end

function this:showRewardBg(show)
  self.go_rewardBg = show
end

function this:showRedDot(show)
  self.go_redDot = show
end

return this
