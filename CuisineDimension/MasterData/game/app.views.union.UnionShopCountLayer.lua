local ShopCsv = require("csvdata.union_shop")
local ItemCsv = require("csvdata.item")
local ShopRes = "ui/shop/main/"
local GlobalRes = "ui/global/"
local IconRes = "icon/union_shop/"
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
local UnionShopCountLayer = class("UnionShopCountLayer", UIBase)

function UnionShopCountLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionShopCountLayer:init(params)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:setTouchScale()
  self.cancel:setTouchScale()
  self.btnAdd:setTouchScale()
  self.btnSub:setTouchScale()
  self.unionCost = params.money
  self.cancel:setCallback(function()
    self:close()
  end)
  self.curNum = 1
  self.data = ShopCsv[params.index]
  for i, data in pairs(self.data.gift:toNumMap()) do
    self.curNum = data
  end
  self.desc:setString(self.data.detail)
  self.nameStr = self.data.desc
  self:refreshContent()
end

function UnionShopCountLayer:showData(params)
  local costStr = self.data.costId == 1 and IconRes .. "caifu.png" or IconRes .. "gongxian.png"
  display.newSprite(costStr):scale(0.5):pos(10, 13):addTo(self.moneyBg)
  display.newSprite(ShopRes .. "cell_image_bg.png"):addTo(self.itemNode)
  if self.data.icon and self.data.icon ~= "" then
    display.newSprite(self.data.icon):pos(0, 0):addTo(self.itemNode)
  else
    ItemIcon.new({
      type = self.data.itemId
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
  self.callback = params.func
  self.confirm:setCallback(function()
    if self.unionCost < self.data.cost then
      if self.data.costId == 1 then
        SysError(SYS_ERR_UNION_WEALTH_NOT_ENOUGT)
      else
        SysError(SYS_ERR_UNION_COUNT_NOT_ENOUGT)
      end
      return
    end
    game:sendData(actionCodes.Union_shopRpc, MsgPack.pack({
      id = self.data.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Union_shopRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if msg.code then
        SysError(msg.code)
      else
        SysError(SYS_ERR_UNION_EXCHANGE_DONE)
      end
      if msg.items then
        MedalRewardLayer.new({
          items = msg.items
        })
      end
      self.callback()
      self:close()
    end)
  end)
end

function UnionShopCountLayer:refreshContent()
  self.name:setString(string.format("%sX%d", self.data.title, self.curNum))
  self.money:setString(self.data.cost)
  self.count:setString(self.nameStr)
end

return UnionShopCountLayer
