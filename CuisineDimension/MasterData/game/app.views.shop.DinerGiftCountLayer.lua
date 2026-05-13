local DinerCsv = require("csvdata.shop_diner")
local ItemCsv = require("csvdata.item")
local ShopRes = "ui/shop/main/"
local GlobalRes = "ui/global/"
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
    desc = "descBg/desc",
    numBg = "numBg",
    money = "moneyBg/money",
    num = "numBg/num",
    name = "name",
    count = "count"
  }
}
local DinerGiftCountLayer = class("DinerGiftCountLayer", UIBase)

function DinerGiftCountLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DinerGiftCountLayer:init(params)
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
  self.data = DinerCsv[params.index]
  self.desc:setString(self.data.detail)
  self.nameStr = self.data.desc
  self:refreshContent()
end

function DinerGiftCountLayer:showData(params)
  display.newSprite(ItemCsv[self.data.costId].icon):scale(0.3):pos(10, 13):addTo(self.moneyBg)
  display.newSprite(ShopRes .. "cell_image_bg.png"):addTo(self.itemNode)
  local gift = self.data.gift:toArray("=", true)
  if self.data.icon and self.data.icon ~= "" then
    display.newSprite(self.data.icon):pos(0, 0):addTo(self.itemNode)
  else
    ItemIcon.new({
      type = gift[1]
    }):pos(0, 0):addTo(self.itemNode)
  end
  self.numBg:hide()
  self.btnAdd:hide()
  self.btnSub:hide()
  self.itemNode:setPositionY(self.itemNode:getPositionY() - 25)
  self.moneyBg:setPositionY(self.moneyBg:getPositionY() - 25)
  self.name:setPositionY(self.name:getPositionY() - 25)
  self.count:setPositionY(self.count:getPositionY() - 25)
  self.descBg:setPositionY(self.descBg:getPositionY() - 35)
  self.confirm:setCallback(function()
    if (game.role.items[self.data.costId] or 0) < self.data.cost then
      SysError(SYS_ERR_SHOP_DINER_POINT_IS_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Diner_shopBuyRpc, MsgPack.pack({
      id = self.data.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Diner_shopBuyRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      MedalRewardLayer.new({
        items = msg.dropItems
      })
      if params.func then
        params.func()
      end
      if not tolua.isnull(self) then
        self:close()
      end
    end)
  end)
end

function DinerGiftCountLayer:refreshContent()
  self.name:setString(string.format("%sX%d", self.data.title, self.curNum))
  self.money:setString(self.data.cost)
  self.count:setString(self.nameStr)
  self.num:setString(self.curNum)
end

function DinerGiftCountLayer:changeNum(num)
  self.curNum = self.curNum + num
  if self.curNum < 1 then
    self.curNum = 1
  end
  if self.curNum > self.data.limit then
    self.curNum = self.data.limit
  end
  self:refreshContent()
end

return DinerGiftCountLayer
