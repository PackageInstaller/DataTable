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
local CommonItemCountLayer = class("CommonItemCountLayer", UIBase)

function CommonItemCountLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

local ShowType = {
  sauce = function(self)
    self:showSauceContent()
  end,
  moon = function(self)
    self:showMoonContent()
  end,
  special = function(self)
    self:showSpecialContent()
  end,
  level = function(self)
    self:showLevelContent()
  end
}

function CommonItemCountLayer:init(params)
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
  self.same = false
  self.curNum = 1
  self.data = params.data or {}
  self.maxCount = math.min(params.left or 99, self.data.overBuy or 99)
  self.showType = params.showType or "sauce"
  self.callback = params.callback
  self:initBtns()
end

function CommonItemCountLayer:showData(params)
  ShowType[self.showType](self)
  self:updateLabel()
end

function CommonItemCountLayer:updateLabel()
  self.name:setString(string.format("%sX%d", self.title, self.curNum * (self.same and self.unit or 1)))
  self.money:setString(self.curNum * self.price)
  self.count:setString(string.format("%sX%d", self.title, self.curNum * self.unit))
  self.num:setString(self.curNum)
end

function CommonItemCountLayer:showSauceContent()
  display.newSprite(ShopRes .. "cell_image_bg.png"):addTo(self.itemNode)
  local gift = self.data.gift:toArray("=", true)
  ItemIcon.new({
    type = gift[1],
    count = gift[2]
  }):addTo(self.itemNode)
  display.newSprite(ItemCsv[self.data.costId].icon):scale(0.3):pos(10, 13):addTo(self.moneyBg)
  self.title = self.data.title
  self.price = self.data.cost or 0
  self.unit = gift[2] or 1
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

function CommonItemCountLayer:showMoonContent()
  display.newSprite(ShopRes .. "cell_image_bg.png"):addTo(self.itemNode)
  local itemData = ItemCsv[self.data.itemId]
  display.newSprite(itemData.icon):anch(0.5, 0):pos(0, -49):addTo(self.itemNode)
  self.title = itemData.name
  self.price = 0
  self.unit = 1
  local cost = globalCsv.ActivitySpecialCost:toNumMap()
  self.desc:setString("花费四种资源各100购买，使用后，本场战斗中所有食灵攻击/命中+30%")
  self.moneyBg:hide()
  self.count:hide()
  self.confirm:setCallback(function()
    self.curNum = tonumber(self.curNum)
    if self.curNum < 1 or self.curNum > 99 then
      SysError(SYS_ERR_CLIENT_OPERATION)
      return
    end
    for itemId, value in pairs(globalCsv.ActivitySpecialCost:toNumMap()) do
      if (game.role["material" .. itemId] or 0) < self.curNum * value then
        SysError(SYS_ERR_MOON_CARBON_BUY_QUAN_SOURCE_NOT_ENOUGH)
        return
      end
    end
    self.callback(self.curNum)
    self:close()
  end)
end

function CommonItemCountLayer:showSpecialContent()
  display.newSprite(ShopRes .. "cell_image_bg.png"):addTo(self.itemNode)
  display.newSprite(ItemCsv[self.data.costId].icon):scale(0.3):pos(10, 13):addTo(self.moneyBg)
  local gift = self.data.gift:toArray("=", true)
  if self.data.icon and self.data.icon ~= "" then
    display.newSprite(self.data.icon):pos(0, 0):addTo(self.itemNode)
  else
    ItemIcon.new({
      type = gift[1]
    }):pos(0, 0):addTo(self.itemNode)
  end
  self.title = self.data.desc ~= "" and self.data.desc or self.data.title
  self.price = self.data.cost or 0
  self.unit = math.max(gift[2] or 1, 1)
  self.same = true
  self.desc:setString(self.data.detail)
  self.count:hide()
  self.confirm:setCallback(function()
    self.curNum = tonumber(self.curNum)
    if self.curNum < 1 or self.curNum > 99 then
      SysError(SYS_ERR_CLIENT_OPERATION)
      return
    end
    if self:getCurCount(self.data.costId) < self.curNum * self.price then
      SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_ENOUGH)
      return
    end
    self.callback(self.curNum)
    self:close()
  end)
end

function CommonItemCountLayer:getCurCount(itemId)
  local count = 0
  if itemId == 5 then
    count = game.role.diamond
  elseif itemId < 5 then
    count = game.role["material" .. itemId]
  else
    count = game.role.items[itemId] or 0
  end
  return count
end

function CommonItemCountLayer:showLevelContent()
  self.title = self.data.title
  self.price = self.data.cost or 0
  self.unit = 1
  self.desc:setString(self.data.desc)
  self.count:hide()
  display.newSprite(ItemCsv[5].icon):scale(0.5):pos(10, 13):addTo(self.moneyBg)
  display.newTTFLabel({
    text = "Rank",
    size = 47,
    color = UIHelper.hex2rgb("#FFFFFF")
  }):enableOutline(UIHelper.hex2rgb("#4A1406"), 2):pos(-100, 40):addTo(self.moneyBg)
  self.confirm:setCallback(function()
    self.curNum = tonumber(self.curNum)
    if self.curNum < 1 or self.curNum > 99 then
      SysError(SYS_ERR_CLIENT_OPERATION)
      return
    end
    self.callback(self.curNum)
    self:close()
  end)
end

function CommonItemCountLayer:initBtns()
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

function CommonItemCountLayer:changeNum(num)
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

return CommonItemCountLayer
