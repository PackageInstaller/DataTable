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
local priceList = globalCsv.WorldBossPrice:toArray("=", true)
local WorldBossBuyCountLayer = class("WorldBossBuyCountLayer", UIBase)

function WorldBossBuyCountLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function WorldBossBuyCountLayer:init(params)
  self.WorldBossBuyTimes = globalCsv.WorldBossTimes
  self.title:setString("购买次数")
  display.newTTFLabel({text = "取消", size = 22}):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(73, 23):addTo(self.cancel)
  display.newTTFLabel({text = "确定", size = 22}):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(73, 23):addTo(self.confirm)
  self.maxNum = params.maxNum
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
    game:sendData(actionCodes.World_buyTimesRpc, MsgPack.pack({
      times = self.count
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.World_buyTimesRpc, function(event)
      UIHelper.removeWaiting()
      BackManager:pop()
    end)
  end)
end

function WorldBossBuyCountLayer:refreshCount(num)
  self.count = self.count + num
  if self.count > self.maxNum then
    self.count = self.maxNum
    return
  elseif self.count < 1 then
    self.count = 1
    return
  end
  self.node1:removeAllChildren()
  local priceSum = 0
  print(self.count)
  if self.count == 0 then
    priceSum = 0
  else
    local firstPriceId = self.WorldBossBuyTimes + 1 - self.maxNum
    for i = firstPriceId, firstPriceId + self.count - 1 do
      priceSum = priceSum + priceList[i]
      print(priceSum)
    end
  end
  local str = string.format("购买世界Boss次数x%d，需要花费钻石x%d，是否确定？", self.count, priceSum)
  MRichText.new({
    text = str,
    size = 22,
    color = UIHelper.hex2rgb("#753613")
  }):anch(0.5, 0.5):pos(0, 0):addTo(self.node1)
  self.num:setString(self.count)
end

return WorldBossBuyCountLayer
