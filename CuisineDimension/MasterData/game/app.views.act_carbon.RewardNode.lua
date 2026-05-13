local RewardNode = class("RewardNode")
local ActCarbonRes = "ui/act_carbon/"
local itemCsv = require("csvdata.item")
local itemPadding = 25
local RewardState = {
  LOCKED = 1,
  AVAILABLE = 2,
  CLAIMED = 3
}

function RewardNode:ctor(params)
  self.rewardId = params.rewardId
  self.itemId = params.itemId
  self.itemCount = params.itemCount
  self.unlockCondition = params.unlockCondition or "通关1-" .. self.rewardId
  self.state = params.state or RewardState.LOCKED
  self.callback = params.callback
  self.itemData = itemCsv[self.itemId]
  self:createNode()
end

function RewardNode:createNode()
  self.background = UIHelper.extend(ccui.ImageView:create()):anch(0, 0):pos((self.rewardId - 1) * (60 + itemPadding), 0)
  self.background:setImage(ActCarbonRes .. "reward_bg.png")
  if self.itemData then
    self.icon = UIHelper.extend(ccui.ImageView:create())
    self.icon:setImage(self.itemData.icon):center(self.background):scale(0.5):addTo(self.background):setCallback(function()
      self:onIconClick()
    end)
  end
  self.countLabel = MRichText.new({
    text = "x" .. tostring(self.itemCount),
    size = 15,
    color = UIHelper.hex2rgb("#999999")
  })
  self.countLabel:anch(1, 0)
  self.countLabel:pos(60, 0)
  self.countLabel:addTo(self.background)
  self.conditionLabel = MRichText.new({
    text = self.unlockCondition,
    size = 15,
    color = UIHelper.hex2rgb("#d9d9d9")
  })
  self.conditionLabel:anch(0.5, 1)
  self.conditionLabel:pos(30, -5)
  self.conditionLabel:addTo(self.background)
  self.claimedIcon = display.newSprite(ActCarbonRes .. "reward_claimed.png")
  if self.claimedIcon then
    self.claimedIcon:center(self.background)
    self.claimedIcon:addTo(self.background)
    self.claimedIcon:hide()
  end
  self:updateState()
end

function RewardNode:updateState()
  print("updateState", self.state)
  if self.state == RewardState.LOCKED then
    self.background:setColor(cc.c3b(150, 150, 150))
    if self.icon then
      self.icon:setColor(cc.c3b(150, 150, 150))
    end
    if self.claimedIcon then
      self.claimedIcon:hide()
    end
  elseif self.state == RewardState.AVAILABLE then
    self.background:setColor(cc.c3b(255, 255, 255))
    if self.icon then
      self.icon:setColor(cc.c3b(255, 255, 255))
    end
    if self.claimedIcon then
      self.claimedIcon:hide()
    end
  elseif self.state == RewardState.CLAIMED then
    self.background:setColor(cc.c3b(200, 200, 200))
    if self.icon then
      self.icon:setColor(cc.c3b(100, 100, 100))
    end
    if self.claimedIcon then
      self.claimedIcon:show()
    end
  end
end

function RewardNode:onIconClick()
  if self.state == RewardState.AVAILABLE then
    if self.callback then
      self.callback(self.rewardId, self.itemId, self.itemCount)
    end
  elseif self.state == RewardState.LOCKED then
    MFlashMsg:show({
      text = "通关1-" .. self.rewardId .. "后可领取"
    })
  elseif self.state == RewardState.CLAIMED then
    MFlashMsg:show({
      text = "奖励已领取"
    })
  end
end

function RewardNode:setState(newState)
  self.state = newState
  self:updateState()
end

function RewardNode:getState()
  return self.state
end

function RewardNode:getNode()
  return self.background
end

RewardNode.State = RewardState
return RewardNode
