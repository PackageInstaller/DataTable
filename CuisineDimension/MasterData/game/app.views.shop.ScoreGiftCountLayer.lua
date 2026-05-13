local ShopRes = "ui/shop/main/"
local ItemCsv = require("csvdata.item")
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
local ScoreGiftCountLayer = class("ScoreGiftCountLayer", UIBase)

function ScoreGiftCountLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ScoreGiftCountLayer:init(params)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:setTouchScale()
  self.cancel:setTouchScale()
  self.btnAdd:hide()
  self.btnSub:hide()
  self.numBg:hide()
  self.cancel:setCallback(function()
    self:close()
  end)
  self.data = params.data
  self.desc:setString(self.data.detail)
  self.nameStr = self.data.desc
  self:refreshContent()
end

function ScoreGiftCountLayer:showData(params)
  display.newSprite(ItemCsv[self.data.costId].icon):scale(0.3):pos(10, 13):addTo(self.moneyBg)
  display.newSprite(ShopRes .. "cell_image_bg.png"):addTo(self.itemNode)
  local icon
  if not self.data.icon or self.data.icon == "" then
    icon = ItemIcon.new({
      type = self.data.gift:toArray("=", true)[1]
    })
  else
    icon = display.newSprite(self.data.icon)
  end
  icon:pos(0, 0):addTo(self.itemNode)
  self.itemNode:setPositionY(self.itemNode:getPositionY() - 25)
  self.moneyBg:setPositionY(self.moneyBg:getPositionY() - 25)
  self.name:setPositionY(self.name:getPositionY() - 25)
  self.count:setPositionY(self.count:getPositionY() - 25)
  self.descBg:setPositionY(self.descBg:getPositionY() - 35)
  self.confirm:setCallback(function()
    if not params.callback() then
      self:close()
    end
  end)
end

function ScoreGiftCountLayer:refreshContent()
  self.name:setString(self.data.title)
  self.money:setString(self.data.cost)
  self.count:setString(self.nameStr)
end

return ScoreGiftCountLayer
