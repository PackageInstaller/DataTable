local ItemCsv = require("csvdata.item")
local ShopRes = "ui/shop/main/"
local uiData = {
  csbFile = "ui/shop/ShopItemCountLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    btnAdd = "btnAdd",
    btnSub = "btnSub",
    cancel = "cancel",
    confirm = "confirm",
    itemNode = "itemNode",
    moneyBg = "moneyBg",
    descBg = "descBg",
    numBg = "numBg",
    money = "moneyBg/money",
    desc = "descBg/desc",
    num = "numBg/num",
    name = "name",
    count = "count"
  }
}
local SauceItemCountLayer = class("SauceItemCountLayer", UIBase)

function SauceItemCountLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

local ShowType = {
  sauce = function(self)
    self:showSauceContent()
  end
}

function SauceItemCountLayer:init(params)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  for _, name in pairs({
    "confirm",
    "cancel",
    "btnAdd",
    "btnSub"
  }) do
    self[name]:setTouchScale()
  end
  self.cancel:setCallback(function()
    self:close()
  end)
  self.curNum = 1
  self.data = params.data
  self.maxCount = math.min(params.left or 99, self.data.overBuy or 99)
  self.showType = params.showType or "sauce"
  self.callback = params.callback
  self:initBtns()
end

function SauceItemCountLayer:showData(params)
  ShowType[self.showType](self)
  self:updateLabel()
end

function SauceItemCountLayer:updateLabel()
  self.name:setString(string.format("%sX%d", self.title, self.curNum))
  self.money:setString(self.curNum * self.price)
  self.count:setString(string.format("%sX%d", self.title, self.curNum * self.unit))
  self.num:setString(self.curNum)
end

function SauceItemCountLayer:showSauceContent()
  display.newSprite(ShopRes .. "cell_image_bg.png"):addTo(self.itemNode)
  local gift = self.data.gift:toArray("=", true)
  ItemIcon.new({
    type = gift[1],
    count = gift[2]
  }):addTo(self.itemNode)
  display.newSprite(ItemCsv[self.data.costId].icon):scale(0.3):pos(10, 13):addTo(self.moneyBg)
  self.title = self.data.title
  self.price = self.data.cost
  self.unit = gift[2]
  self.desc:setString(self.data.detail)
  self.count:hide()
  self.confirm:setCallback(function()
    self.curNum = tonumber(self.curNum)
    if self.curNum < 1 or self.curNum > 99 then
      SysError(SYS_ERR_CLIENT_OPERATION)
      return
    end
    if (game.role.items[self.data.costId] or 0) < self.curNum * self.price then
      SysError(SYS_ERR_SHOP_SAUCE_MONEY_NOT_ENOUGH)
      return
    end
    self.callback(self.curNum)
    self:close()
  end)
end

function SauceItemCountLayer:initBtns()
  if self.hideChange or self.maxCount == 1 then
    self.numBg:hide()
    self.btnAdd:hide()
    self.btnSub:hide()
    self.itemNode:setPositionY(self.itemNode:getPositionY() - 25)
    self.moneyBg:setPositionY(self.moneyBg:getPositionY() - 25)
    self.name:setPositionY(self.name:getPositionY() - 25)
    self.count:setPositionY(self.count:getPositionY() - 25)
    self.descBg:setPositionY(self.descBg:getPositionY() - 35)
    return
  end
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
end

function SauceItemCountLayer:changeNum(num)
  self.curNum = self.curNum + num
  if self.curNum < 1 then
    self.curNum = 1
  end
  if self.curNum > self.maxCount then
    self.curNum = self.maxCount
    return
  end
  self:updateLabel()
end

return SauceItemCountLayer
