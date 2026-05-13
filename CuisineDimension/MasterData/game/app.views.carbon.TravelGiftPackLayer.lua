local GiftCsv = require("csvdata.tour_gift")
local ItemCsv = require("csvdata.item")
local uiData = {
  csbFile = "ui/carbon/TravelGiftPackLayer.csb",
  popup = true,
  mask = true,
  maskClick = function()
    BackManager:pop()
  end,
  widgets = {
    popAction = "popAction",
    buyBtn = "buyBtn",
    money = "moneyBg/money",
    node1 = "node1",
    node2 = "node2"
  }
}
local TravelGiftPackLayer = class("TravelGiftPackLayer", UIBase)

function TravelGiftPackLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TravelGiftPackLayer:init(params)
  self.buyBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
end

function TravelGiftPackLayer:showData(params)
  self.money:setString(globalCsv.tourExtraCost)
  local data = GiftCsv[params.id]
  local heros = data.show:toArray("=", true)
  for index, itemId in pairs(heros) do
    local xPos = (index - 1) * 95
    local itemData = ItemCsv[itemId]
    local icon = UIHelper.getClipNode({
      steRes = "ui/global/mask_2.png",
      clipRes = itemData.icon
    }):scale(0.69):pos(xPos, -10):addTo(self.node1)
    display.newSprite("ui/carbon/chooseTravel/circle.png"):scale(0.69):pos(xPos, -10):addTo(self.node1)
  end
  for i = 1, 3 do
    local xPos = (i - 1) * 125
    local bg = display.newSprite("ui/global/item_bg.png"):pos(xPos, 0):addTo(self.node2)
    display.newSprite(string.format("ui/carbon/chooseTravel/unknown_gift%d.png", i)):center(bg):addTo(bg)
    display.newSprite("ui/global/item_frame.png"):center(bg):addTo(bg)
    for index = 1, 4 - i do
      local x = 10 + (index - 1) * 15
      display.newSprite("ui/carbon/chooseTravel/worth.png"):anch(0.5, 1):pos(x, 92):addTo(bg)
    end
  end
  self.buyBtn:setTouchScale()
  self.buyBtn:setCallback(function()
    if game.role.diamond < globalCsv.tourExtraCost then
      SysError(SYS_ERR_DIAMOND_SHORTAGE)
      return
    end
    game:sendData(actionCodes.Explore_buyGiftRpc, MsgPack.pack({
      index = params.index
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Explore_buyGiftRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      MedalRewardLayer.new({
        items = msg,
        callback = function()
          BackManager:pop()
        end
      })
    end)
  end)
end

return TravelGiftPackLayer
