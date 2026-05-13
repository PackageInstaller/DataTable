local ItemCsv = require("csvdata.item")
local passRes = "ui/pass/pass1/"
local uiData = {
  csbFile = "ui/shop/ShopChefPassLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    name = "name",
    itemNode = "itemNode",
    confirm = "confirm",
    cancel = "cancel",
    moneyBg = "moneyBg",
    money = "moneyBg/money"
  }
}
local ShopChefPassLayer = class("ShopChefPassLayer", UIBase)

function ShopChefPassLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ShopChefPassLayer:init(params)
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:setTouchScale()
  self.cancel:setTouchScale()
  
  local function createLayer(text1, text2, text3, giftList)
    self.name:setString(text1)
    display.newSprite(ItemCsv[60].icon):scale(0.4):pos(0, 12):addTo(self.moneyBg)
    self.money:setString(text2)
    display.newSprite(passRes .. text3):pos(0, -10):addTo(self.itemNode)
    local count = table.nums(giftList:toNumMap())
    local xInterval, scale = 80, 0.8
    if 8 < count then
      scale = scale * 8 / count
      xInterval = xInterval * 8 / count
    end
    local xPos = 100 + (count - 1) / 2 * -xInterval
    for k, v in pairs(giftList:toNumMap()) do
      ItemIcon.new({
        type = k,
        count = v,
        showTip = true
      }):scale(scale):pos(xPos, -105):addTo(self.itemNode)
      xPos = xPos + xInterval
    end
  end
  
  local cost = 9999
  if params.index == 1 then
    cost = globalCsv.RankBReward.cost
    createLayer("购买高级凭证", "X" .. cost, "senior.png", globalCsv.RankBReward.gift)
  elseif params.index == 2 then
    cost = globalCsv.RankAReward.cost
    createLayer("购买豪华凭证 + 直50级", "X" .. cost, "luxurious.png", globalCsv.RankAReward.gift)
  end
  self.cancel:setCallback(function()
    self:close()
  end)
  self.confirm:setCallback(function()
    if (game.role.items[60] or 0) < cost then
      SysError(SYS_ERR_SKIN_TICKET_ENOUGH)
      return
    end
    game:sendData(actionCodes.Activity_passTaskRpc, MsgPack.pack({
      index = params.index
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_passTaskRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      MedalRewardLayer.new({
        items = msg.reward
      })
      if params.func then
        params.func()
      end
      self:close()
    end)
  end)
end

return ShopChefPassLayer
