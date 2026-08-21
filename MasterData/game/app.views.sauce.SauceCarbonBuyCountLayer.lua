local ItemCsv = require("csvdata.item")
local HappyRes = "ui/carbon/happy/"
local uiData = {
  csbFile = "ui/carbon/CarbonBuyHappyCountLayer.csb",
  popup = true,
  mask = true,
  maskClick = function()
    BackManager:pop()
  end,
  widgets = {
    title = "title",
    node0 = "node0",
    node1 = "node1",
    node2 = "node2",
    confirm = "confirm",
    cancel = "cancel",
    btnAdd = "btnAdd",
    btnSub = "btnSub",
    num = "numBg/num"
  }
}
local SauceCarbonBuyCountLayer = class("SauceCarbonBuyCountLayer", UIBase)

function SauceCarbonBuyCountLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SauceCarbonBuyCountLayer:init(params)
  self.title:setString("补充次数")
  display.newTTFLabel({text = "取消", size = 22}):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(73, 23):addTo(self.cancel)
  display.newTTFLabel({text = "确定", size = 22}):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(73, 23):addTo(self.confirm)
  self.costId = params.costId or 5
  self.count = 0
  self.buy = params.buy or 0
  self:refreshCount(1)
  local texts = {
    "cancel",
    "confirm",
    "btnAdd",
    "btnSub"
  }
  for _, name in pairs(texts) do
    self[name]:setTouchScale()
  end
  self.btnAdd:setCallback(function()
    self:refreshCount(1)
  end)
  self.btnSub:setCallback(function()
    self:refreshCount(-1)
  end)
  self.cancel:setCallback(function()
    BackManager:pop()
  end)
  self.confirm:setCallback(function()
    if self.count < 1 then
      return
    end
    if (game.role.diamond or 0) < self:getCost() then
      UIHelper.showDiamondTip({
        parent = self,
        callback = function()
          self.curDiamond:setString(game.role.diamond or 0)
        end
      })
      return
    end
    game:sendData(actionCodes.Sauce_buyBossCountRpc, MsgPack.pack({
      count = self.count
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Sauce_buyBossCountRpc, function(event)
      UIHelper.removeWaiting()
      SysError(SYS_ERR_SAUCE_CARBON_BUY_SUCCESS)
      params.callback()
      BackManager:pop()
    end)
  end)
end

function SauceCarbonBuyCountLayer:showData(params)
  local countBg = display.newSprite("ui/diner/up/num_bg.png"):anch(1, 0.5):pos(0, 0):addTo(self.node0)
  display.newSprite(ItemCsv[self.costId].icon):scale(0.5):pos(5, 15):addTo(countBg)
  self.curDiamond = display.newTTFLabel({
    text = game.role.diamond or 0,
    size = 22
  }):pos(62, 15):addTo(countBg)
  display.newTTFLabel({
    text = "增加次数:",
    size = 22,
    color = UIHelper.hex2rgb("#753613")
  }):pos(80, 0):addTo(self.node2)
end

function SauceCarbonBuyCountLayer:refreshCount(dalte)
  self.count = self.count + dalte
  if self.count < 1 then
    self.count = 1
    return
  end
  if self.buy + self.count > #globalCsv.sauceExtraCost then
    self.count = #globalCsv.sauceExtraCost - self.buy
  end
  self.node1:removeAllChildren()
  local str = string.format("需要消耗 <img src='%s' scale=0.5 /> x%d ，是否确定？", ItemCsv[self.costId].icon, self:getCost())
  MRichText.new({
    text = str,
    size = 22,
    color = UIHelper.hex2rgb("#753613")
  }):anch(0.5, 0.5):pos(0, 0):addTo(self.node1)
  self.num:setString(self.count)
end

function SauceCarbonBuyCountLayer:getCost()
  local cost = 0
  for i = 1, self.count do
    cost = cost + globalCsv.sauceExtraCost[self.buy + i]
  end
  return cost
end

return SauceCarbonBuyCountLayer
