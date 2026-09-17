local this = class("moduleRewardTipBtn", G_UIModuleBase)
local showType = {number = 1, rome = 2}

function this.bind()
  return {
    go_rewardBg = true,
    go_numBg = false,
    go_rewardNum = true,
    go_romeNum = false,
    txt_rewardNum = "",
    txt_romeNum = "",
    img_Box = "",
    img_Star = ""
  }
end

function this.methods()
  return {}
end

function this:open(options)
end

function this:initData(options)
  self.canReward = options.canReward
  self.rewardNum = options.rewardNum
  self.romeNum = options.romeNum
  self.action = options.action
end

function this:refresh()
end

function this:refreshState(canReward)
  self.bind.go_rewardBg = canReward
  self.bind.go_numBg = not canReward
  self:refreshAnim(canReward)
end

function this:refreshAnim(canReward)
  self.bindComponents.rewardsTipBtn_B:SetBool("full", canReward)
end

function this:setNumBgState(state)
  self.bind.go_numBg = state
end

function this:setrewardBgState(state)
  self.bind.go_rewardBg = state
end

function this:refreshNumberState(type, num)
  if type == showType.number then
    self.bind.go_rewardNum = true
    self.bind.go_romeNum = false
    self:refreshNum(num)
  elseif type == showType.rome then
    self.bind.go_rewardNum = false
    self.bind.go_romeNum = true
    self:refreshRomeNum(num)
  end
end

function this:refreshNum(rewardNum)
  self.bind.txt_rewardNum = tostring(rewardNum)
end

function this:refreshRomeNum(romeNum)
  self.bind.txt_romeNum = tostring(romeNum)
end

function this:setBoxImage(path)
  self.bind.img_Box = path
end

function this:setStarImage(path)
  self.bind.img_Star = path
end

return this
