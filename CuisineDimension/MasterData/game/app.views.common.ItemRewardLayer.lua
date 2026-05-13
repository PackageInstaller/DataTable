local ItemCsv = require("csvdata.item")
local uiData = {
  csbFile = "ui/global/ItemRewardLayer.csb",
  maskClick = true,
  popup = true,
  mask = true,
  widgets = {
    content = "content",
    title = "title",
    okBtn = "okBtn"
  }
}
local ItemRewardLayer = class("ItemRewardLayer", UIBase)

function ItemRewardLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ItemRewardLayer:init(params)
  if UIHelper.isiPhoneX() then
    self:setPositionX(UIHelper.getMoveXForX(true))
  end
  self.items = params.items
  self.preView = params.preView
  self.ignore = params.ignore or false
  self.okBtn:setTouchScale()
  self.okBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.okBtn:setCallback(function()
    self:close()
  end)
end

function ItemRewardLayer:showData(params)
  if self.preView then
    self.title:setString("奖励预览")
  end
  local coinTypes = {
    [ItemType.Material1] = true,
    [ItemType.Material2] = true,
    [ItemType.Material3] = true,
    [ItemType.Material4] = true
  }
  local coins = {}
  for _, item in ipairs(self.items) do
    local itemSet = ItemCsv[tonumber(item[1])]
    if coinTypes[itemSet.type] and not self.ignore then
      coins[itemSet.type] = tonumber(item[2])
    end
  end
  if next(coins) then
    display.newTTFLabel({
      text = "获得资源:",
      size = 22,
      color = UIHelper.hex2rgb("#633c25")
    }):anch(0, 1):pos(0, 145):addTo(self.content)
    for base = 1, 4 do
      local item = coins[base + 2]
      local count = item and item or 0
      HuoBiIcon.new({count = count, base = base}):anch(0, 1):pos(100 + (base - 1) * 125, 145):addTo(self.content)
    end
    display.newTTFLabel({
      text = "获得物品:",
      size = 22,
      color = UIHelper.hex2rgb("#633c25")
    }):anch(0, 1):pos(0, 60):addTo(self.content)
    local index = 1
    for _, item in ipairs(self.items) do
      local itemSet = ItemCsv[tonumber(item[1])]
      if not coinTypes[itemSet.type] then
        ItemIcon.new({
          type = tonumber(item[1]),
          count = tonumber(item[2]),
          showTip = true
        }):scale(0.8):addTo(self.content):pos(135 + (index - 1) * 100, 25)
        index = index + 1
      end
    end
  else
    local scale = #self.items > 6 and 6 / #self.items or 1
    local interval = 105 * scale
    local xBegin = (self.content:getContentSize().width - (#self.items - 1) * interval) / 2
    for index, item in ipairs(self.items) do
      ItemIcon.new({
        type = tonumber(item[1]),
        count = tonumber(item[2]),
        showTip = true
      }):scale(scale):pos(xBegin + (index - 1) * interval, 70):addTo(self.content)
    end
  end
end

return ItemRewardLayer
