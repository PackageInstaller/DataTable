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
local prices = {
  [36] = globalCsv.keyPrice,
  [190] = globalCsv.mantoubossPrice,
  [globalCsv.ShenYuanCostId] = globalCsv.ShenYuanPrice
}
local CarbonBuyHappyCountLayer = class("CarbonBuyHappyCountLayer", UIBase)

function CarbonBuyHappyCountLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function CarbonBuyHappyCountLayer:init(params)
  self.title:setString("补充次数")
  display.newTTFLabel({text = "取消", size = 22}):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(73, 23):addTo(self.cancel)
  display.newTTFLabel({text = "确定", size = 22}):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(73, 23):addTo(self.confirm)
  self.costId = params.costId or 36
  self.bossType = params.boseType or 1
  self.count = 0
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
    local cur = game.role.items[self.costId] or 0
    local need = self.count * prices[self.costId]
    if self.costId == 36 then
      if cur < need then
        SysError(SYS_ERR_CAEBON_HAPPY_MONEY_NOT_ENOUGH)
        return
      end
      game:sendData(actionCodes.Paradise_buyCountRpc, MsgPack.pack({
        type = params.diffType,
        count = self.count
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Paradise_buyCountRpc, function(event)
        UIHelper.removeWaiting()
        SysError(SYS_ERR_CAEBON_HAPPY_MONEY_BUY_SUCCESS)
        params.callback()
        BackManager:pop()
      end)
    elseif self.costId == 190 then
      if cur < need then
        SysError(SYS_ERR_CAEBON_MANTOU_MONEY_NOT_ENOUGH)
        return
      end
      game:sendData(actionCodes.Carbon_buyBossCarbonCountRpc, MsgPack.pack({
        count = self.count
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Carbon_buyBossCarbonCountRpc, function(event)
        UIHelper.removeWaiting()
        SysError(SYS_ERR_CAEBON_MANTOU_MONEY_BUY_SUCCESS)
        params.callback()
        BackManager:pop()
      end)
    elseif self.costId == globalCsv.ShenYuanCostId then
      if cur < need then
        SysError(SYS_ERR_CAEBON_SHENYUAN_MONEY_NOT_ENOUGH)
        return
      end
      game:sendData(actionCodes.Carbon_buyShenYuanCarbonCountRpc, MsgPack.pack({
        bossType = self.bossType,
        count = self.count
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Carbon_buyShenYuanCarbonCountRpc, function(event)
        UIHelper.removeWaiting()
        SysError(SYS_ERR_CAEBON_SHENYUAN_MONEY_BUY_SUCCESS)
        params.callback()
        BackManager:pop()
      end)
    end
  end)
end

function CarbonBuyHappyCountLayer:showData(params)
  local countBg = display.newSprite("ui/diner/up/num_bg.png"):anch(1, 0.5):pos(0, 0):addTo(self.node0)
  display.newSprite(ItemCsv[self.costId].icon):scale(0.5):pos(5, 15):addTo(countBg)
  display.newTTFLabel({
    text = game.role.items[self.costId] or 0,
    size = 22
  }):pos(62, 15):addTo(countBg)
  display.newTTFLabel({
    text = "增加次数:",
    size = 22,
    color = UIHelper.hex2rgb("#753613")
  }):pos(80, 0):addTo(self.node2)
end

function CarbonBuyHappyCountLayer:refreshCount(dalte)
  self.count = self.count + dalte
  if self.count < 1 then
    self.count = 1
    return
  end
  self.node1:removeAllChildren()
  local str = string.format("需要消耗 <img src='%s' scale=0.5 /> x%d ，是否确定？", ItemCsv[self.costId].icon, self.count * prices[self.costId])
  MRichText.new({
    text = str,
    size = 22,
    color = UIHelper.hex2rgb("#753613")
  }):anch(0.5, 0.5):pos(0, 0):addTo(self.node1)
  self.num:setString(self.count)
end

return CarbonBuyHappyCountLayer
