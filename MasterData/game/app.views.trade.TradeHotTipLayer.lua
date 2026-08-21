local BuyRes = "ui/trade/buy/"
local uiData = {
  csbFile = "ui/trade/TradeHotTipLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {popAction = "popAction", node = "node"}
}
local TradeHotTipLayer = class("TradeHotTipLayer", UIBase)

function TradeHotTipLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TradeHotTipLayer:init(params)
  display.newTTFLabel({
    text = "活跃度高的主厨更容易接收到交易请求",
    size = 18,
    color = UIHelper.hex2rgb("#bd681d")
  }):pos(450, 40):addTo(self.popAction)
end

function TradeHotTipLayer:showData(params)
  local names = {
    "区域净化",
    "完成委托",
    "烹饪练习",
    "道场挑战",
    "装备采购",
    "食灵强化",
    "装备强化",
    "农场耕作",
    "异变净化"
  }
  local rows = math.ceil(table.nums(names) / 3)
  for row = 1, rows do
    local yPos = (row - 1) * -50
    for col = 1, 3 do
      local index = (row - 1) * 3 + col
      local name = names[index]
      if name then
        local bg = display.newSprite(BuyRes .. "path_bg.png"):anch(0, 0.5):pos((col - 1) * 145, yPos):addTo(self.node)
        display.newTTFLabel({
          text = name,
          size = 24,
          color = UIHelper.hex2rgb("#703838")
        }):center(bg):addTo(bg)
      end
    end
  end
end

return TradeHotTipLayer
