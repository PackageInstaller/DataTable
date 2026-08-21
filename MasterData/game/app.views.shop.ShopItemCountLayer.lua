local ShopCsv = require("csvdata.shop")
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
local ShopItemCountLayer = class("ShopItemCountLayer", UIBase)

function ShopItemCountLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ShopItemCountLayer:init(params)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:setTouchScale()
  self.cancel:setTouchScale()
  self.btnAdd:setTouchScale()
  self.btnSub:setTouchScale()
  self.cancel:setCallback(function()
    self:close()
  end)
  self.curNum = 1
  self.data = ShopCsv[params.index]
  self.desc:setString(self.data.detail)
  local itemData = ItemCsv[self.data.itemid]
  self.nameStr = itemData.name
  self:refreshContent()
end

function ShopItemCountLayer:showData(params)
  display.newSprite("ui/global/base_diamond.png"):pos(10, 13):addTo(self.moneyBg)
  if self.data.type == 1 then
    ItemIcon.new({
      type = self.data.itemid
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
  else
    display.newSprite(ShopRes .. "cell_image_bg.png"):addTo(self.itemNode)
    local itemData = ItemCsv[self.data.itemid]
    display.newSprite(itemData.icon):anch(0.5, 0):pos(0, -49):addTo(self.itemNode)
  end
  if self.data.overBuy == 1 then
    self.numBg:hide()
    self.btnAdd:hide()
    self.btnSub:hide()
    self.itemNode:setPositionY(self.itemNode:getPositionY() - 25)
    self.moneyBg:setPositionY(self.moneyBg:getPositionY() - 25)
    self.name:setPositionY(self.name:getPositionY() - 25)
    self.count:setPositionY(self.count:getPositionY() - 25)
    self.descBg:setPositionY(self.descBg:getPositionY() - 35)
  end
  self.confirm:setCallback(function()
    self.curNum = tonumber(self.curNum)
    if self.curNum < 1 or self.curNum > 99 then
      SysError(SYS_ERR_CLIENT_OPERATION)
      return
    end
    if (game.role.diamond or 0) < self.curNum * self.data.cost then
      UIHelper.showDiamondTip({parent = self})
      return
    end
    if not self:specialCheck() then
      return
    end
    game:sendData(actionCodes.Store_diamondBuyRpc, MsgPack.pack({
      index = self.data.id,
      num = self.curNum
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Store_diamondBuyRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if self.data.type == 1 then
        MedalRewardLayer.new({
          items = msg.items
        })
      else
        MFlashMsg:show({
          text = self.data.tips
        })
      end
      if params.func then
        params.func()
      end
      self:close()
    end)
  end)
end

function ShopItemCountLayer:refreshContent()
  self.name:setString(string.format("%sX%d", self.data.title, self.curNum))
  self.money:setString(self.curNum * self.data.cost)
  local str = self.data.type == 1 and string.format("%sX%d", self.nameStr, self.curNum * self.data.count) or self.data.desc
  self.count:setString(str)
  self.num:setString(self.curNum)
end

function ShopItemCountLayer:changeNum(num)
  self.curNum = self.curNum + num
  if self.curNum < 1 then
    self.curNum = 1
  end
  if self.curNum > self.data.overBuy then
    self.curNum = self.data.overBuy
  end
  self:refreshContent()
end

function ShopItemCountLayer:specialCheck()
  local shakeKeyMap = globalCsv.keyMapping:toNumMap()
  if table.keyof(shakeKeyMap, self.data.itemid) then
    local status = game.role.activityStatus["55"] or {}
    status.open = status.open or "1=1"
    local beforeId = table.keyof(shakeKeyMap, self.data.itemid) - 1
    local keyCount = game.role.items[self.data.itemid] or 0
    if status.open:getv(beforeId, 0) ~= 0 and keyCount == 0 then
      return true
    elseif keyCount ~= 0 then
      SysError(SYS_ERR_SHOP_BUY_SHAKE_KEY_LIMIT2)
      return false
    else
      SysError(SYS_ERR_SHOP_BUY_SHAKE_KEY_LIMIT)
      return false
    end
  end
  return true
end

return ShopItemCountLayer
