local ItemCsv = require("csvdata.item")
local uiData = {
  csbFile = "ui/newyear/NewYearItemLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    btnAdd = "btnAdd",
    btnSub = "btnSub",
    cancel = "cancel",
    confirm = "confirm",
    itemNode = "itemNode",
    name = "name",
    costNode = "costNode",
    num = "numBg/num",
    desc = "descBg/desc"
  }
}
local BuyItemLayer = class("BuyItemLayer", UIBase)

function BuyItemLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function BuyItemLayer:init(params)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:setTouchScale()
  self.cancel:setTouchScale()
  self.btnAdd:setTouchScale()
  self.btnSub:setTouchScale()
  self.cancel:setCallback(function()
    self:close()
  end)
  self.itemId = params.itemId
  self.costId = params.costId
  self.limit = params.limit or 99
  self.count = params.count or 1
  self.price = params.price
  self.curNum = 1
  self.desc:setString(params.desc and params.desc ~= "" and params.desc or ItemCsv[self.itemId].desc)
  self.nameStr = ItemCsv[self.itemId].name
  self.name:setPositionY(self.name:getPositionY() - 15)
  self:refreshContent()
end

function BuyItemLayer:showData(params)
  ItemIcon.new({
    type = self.itemId
  }):addTo(self.itemNode)
  self.btnAdd:setCallbackTotal(function()
    self.addHandler = scheduler.scheduleGlobal(function()
      self:changeNum(1)
    end, 0.1)
  end, nil, function()
    if self.addHandler then
      scheduler.unscheduleGlobal(self.addHandler)
    end
    self:changeNum(1)
  end, function()
    if self.addHandler then
      scheduler.unscheduleGlobal(self.addHandler)
    end
    self:changeNum(1)
  end)
  self.btnSub:setCallbackTotal(function()
    self.addHandler = scheduler.scheduleGlobal(function()
      self:changeNum(-1)
    end, 0.2)
  end, nil, function()
    if self.addHandler then
      scheduler.unscheduleGlobal(self.addHandler)
    end
    self:changeNum(-1)
  end, function()
    if self.addHandler then
      scheduler.unscheduleGlobal(self.addHandler)
    end
    self:changeNum(-1)
  end)
  if self.limit == 1 then
    self.btnAdd:hide()
    self.btnSub:hide()
  end
  self.confirm:setCallback(function()
    self.curNum = tonumber(self.curNum)
    if self.curNum < 1 or self.curNum > 99 then
      SysError(SYS_ERR_CLIENT_OPERATION)
      return
    end
    if self.curNum > self.limit then
      SysError(SYS_ERR_CLIENT_OPERATION)
      return
    end
    local result
    if params.callback then
      result = params.callback(self.curNum)
    end
    if result then
      self:close()
    end
  end)
end

function BuyItemLayer:refreshContent()
  self.costNode:removeAllChildren()
  self.name:setString(string.format("%sX%d", self.nameStr, self.curNum * self.count))
  display.newSprite("ui/shop/main/money_bg.png"):anch(0, 0.5):pos(0, 0):addTo(self.costNode)
  display.newSprite(ItemCsv[self.costId].icon):scale(0.5):pos(0, 0):addTo(self.costNode)
  display.newTTFLabel({
    text = self.price * self.curNum,
    size = 20,
    color = UIHelper.hex2rgb("#703902")
  }):pos(54, 0):addTo(self.costNode)
  self.num:setString(self.curNum)
end

function BuyItemLayer:changeNum(num)
  self.curNum = self.curNum + num
  if self.curNum < 1 then
    self.curNum = 1
  end
  if self.curNum > self.limit then
    self.curNum = self.limit
  end
  self:refreshContent()
end

return BuyItemLayer
