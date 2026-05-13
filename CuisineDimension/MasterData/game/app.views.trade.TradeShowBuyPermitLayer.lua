local AchieveCsv = require("csvdata.achievement")
local BuyRes = "ui/trade/buy/"
local uiData = {
  csbFile = "ui/trade/TradeShowBuyPermitLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {popAction = "popAction", list = "list"}
}
local TradeShowBuyPermitLayer = class("TradeShowBuyPermitLayer", UIBase)

function TradeShowBuyPermitLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TradeShowBuyPermitLayer:init(params)
end

function TradeShowBuyPermitLayer:showData(params)
  local Set = {}
  for id, data in pairs(AchieveCsv) do
    if 10000 < id then
      table.insert(Set, data)
    end
  end
  table.sort(Set, function(a, b)
    return a.id < b.id
  end)
  local nodeSize = display.newSprite(BuyRes .. "red.png"):getContentSize()
  nodeSize.height = nodeSize.height + 4
  for _, data in pairs(Set) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(nodeSize):addTo(self.list)
    local all = data.condition1
    local cur = game.role.missionTaskStatus:getv(data.id, 0)
    if cur == -1 then
      cur = all + 1
    else
      cur = game.role.achievementTypeStatus:getv(data.type, 0)
    end
    local done = all <= cur
    local image = done and "green.png" or "red.png"
    local text = done and "可以购买" or "不可购买"
    local color = done and "#265100" or "#691705"
    local cell = display.newSprite(BuyRes .. image):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 18,
      color = UIHelper.hex2rgb("#703803")
    }):pos(75, 16):addTo(cell)
    display.newTTFLabel({
      text = text,
      size = 18,
      color = UIHelper.hex2rgb(color)
    }):pos(220, 16):addTo(cell)
    if done then
      display.newTTFLabel({
        text = "已开放",
        size = 18,
        color = UIHelper.hex2rgb("#265100")
      }):anch(0, 0.5):pos(330, 16):addTo(cell)
    else
      local goal = display.newTTFLabel({
        text = data.goal,
        size = 18,
        color = UIHelper.hex2rgb("#703803")
      }):anch(0, 0):pos(330, 8):addTo(cell)
      local size = goal:getContentSize()
      display.newTTFLabel({
        text = string.format("%d/%d 次", cur, all),
        size = 18,
        color = UIHelper.hex2rgb("#ce1e06")
      }):anch(0, 0):pos(340 + size.width, 8):addTo(cell)
    end
  end
end

return TradeShowBuyPermitLayer
