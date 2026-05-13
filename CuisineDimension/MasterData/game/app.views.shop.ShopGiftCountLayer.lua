local ShopCsv = require("csvdata.shop")
local RechargeCsv = require("csvdata.recharge")
local ItemCsv = require("csvdata.item")
local ShopRes = "ui/shop/main/"
local uiData = {
  csbFile = "ui/shop/ShopGiftCountLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    popAction = "popAction",
    cancel = "cancel",
    confirm = "confirm",
    itemNode = "itemNode",
    moneyBg = "moneyBg",
    content = "content",
    name = "name"
  }
}
local ShopGiftCountLayer = class("ShopGiftCountLayer", UIBase)

function ShopGiftCountLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ShopGiftCountLayer:init(params)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:setTouchScale()
  self.cancel:setTouchScale()
  self.cancel:setCallback(function()
    self:close()
  end)
end

function ShopGiftCountLayer:showData(params)
  local data = ShopCsv[params.index]
  self.name:setString(data.title)
  local special = data.id > 3800 and data.id <= 3900 or data.id > 20000 and data.id < 20100
  if data.id == globalCsv.homeBoxId then
    special = true
  end
  if data.reward ~= "" then
    local items = data.reward:toNumMap()
    local yPos = 219
    display.newSprite(ShopRes .. (table.nums(items) > 1 and "image_extra_2.png" or "image_extra_1.png")):anch(0.5, 1):pos(525, 280):addTo(self.popAction)
    for itemId, num in pairs(items) do
      local circle = display.newSprite(ShopRes .. "extra_item_bg.png"):pos(525, yPos):addTo(self.popAction)
      display.newSprite(ItemCsv[itemId].icon):scale(0.45):center(circle):addTo(circle)
      display.newTTFLabel({text = num, size = 20}):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(24, 12):addTo(circle)
      yPos = yPos - 50
    end
  end
  local diamondBuy = true
  if data.rechargeId == 0 then
    if data.id > 10000 then
      display.newSprite(ItemCsv[60].icon):scale(0.3):pos(10, 13):addTo(self.moneyBg)
    else
      display.newSprite("ui/global/base_diamond.png"):pos(10, 13):addTo(self.moneyBg)
    end
    local cost = data.cost
    if data.unlock ~= 0 then
      lastTime = game.role.levelGiftStatus:getv(data.id, 0) + data.saleTime * 3600 - game:nowTime()
      if 0 < lastTime then
        cost = data.sale
      end
    end
    display.newTTFLabel({
      text = cost,
      size = 22,
      color = UIHelper.hex2rgb("#703902")
    }):pos(60, 13):addTo(self.moneyBg)
  else
    diamondBuy = false
    data = RechargeCsv[data.rechargeId]
    display.newTTFLabel({
      text = "￥" .. data.rmb,
      size = 22,
      color = UIHelper.hex2rgb("#703902")
    }):pos(50, 14):addTo(self.moneyBg)
  end
  if special then
    self.name:setPositionX(327)
    self.moneyBg:setPositionX(327)
  else
    display.newSprite(data.icon):scale(0.7):addTo(self.itemNode)
  end
  local items = data.gift2see and data.gift2see ~= "" and data.gift2see:toTableArray() or data.gift:toTableArray()
  local count = table.nums(items)
  local xInterval = 80
  local scale = 0.8
  if 8 < count then
    scale = scale * 8 / count
    xInterval = xInterval * 8 / count
  end
  local xPos = (count - 1) / 2 * -xInterval
  for _, itemSet in pairs(items) do
    ItemIcon.new({
      type = tonumber(itemSet[1]),
      count = tonumber(itemSet[2]),
      showTip = true
    }):scale(scale):pos(xPos, 0):addTo(self.content)
    xPos = xPos + xInterval
  end
  local boxId
  for itemId, num in pairs(data.gift:toNumMap()) do
    if ItemCsv[itemId].type == ItemType.ChooseBox then
      boxId = itemId
      break
    end
  end
  self.confirm:setCallback(function()
    if diamondBuy then
      if ShopCsv[data.pre] and game.role.shopStatus:getv(data.pre, 0) == 0 then
        MFlashMsg:show({
          text = string.format("购买 %s 后才能购买此礼包", ShopCsv[data.pre].title)
        })
        return
      end
      if data.id > 10000 then
        if (game.role.items[60] or 0) < data.cost then
          SysError(SYS_ERR_SHOP_SAUCE_MONEY_NOT_ENOUGH)
          return
        end
      else
        local leftT = game.role.levelGiftStatus:getv(data.id, 0) + data.saleTime * 3600 - game:nowTime()
        if game.role.diamond < (data.unlock ~= 0 and 0 < leftT and data.sale or data.cost) then
          UIHelper.showDiamondTip({parent = self})
          return
        end
      end
    end
    
    local function send(itemId)
      if params.func then
        params.func(itemId)
      end
      self:close()
    end
    
    if boxId then
      local item = ItemCsv[boxId]
      local layer = game:createView("shop.ChooseItemLayer", {
        items = item.content,
        callback = function(itemId)
          if itemId ~= 0 then
            send(itemId)
          end
        end
      })
    else
      send()
    end
  end)
end

return ShopGiftCountLayer
