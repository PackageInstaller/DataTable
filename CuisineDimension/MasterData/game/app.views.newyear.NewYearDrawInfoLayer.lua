local DrawCsv = require("csvdata.loop_activity.loop_drawgift")
local uiData = {
  csbFile = "ui/newyear/NewYearDrawInfoLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    btnClose = "btnClose",
    node1 = "node1",
    node2 = "node2"
  }
}
local NewYearDrawInfoLayer = class("NewYearDrawInfoLayer", UIBase)

function NewYearDrawInfoLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function NewYearDrawInfoLayer:init(params)
  self.group = params.group
  self.btnClose:setTouchScale()
  self.btnClose:setCallback(function()
    self:removeFromParent()
  end)
end

function NewYearDrawInfoLayer:showData(params)
  local now, all, group = {}, {}, {
    {},
    {}
  }
  for _, data in pairs(DrawCsv) do
    if data.group == self.group then
      local itemId, count = data.gift:match("(%d+)=(%d+)")
      if not all[tonumber(itemId)] then
        if data.prize == 1 then
          table.insert(group[1], tonumber(itemId))
        else
          table.insert(group[2], tonumber(itemId))
        end
      end
      now[tonumber(itemId)] = (now[tonumber(itemId)] or 0) + game.role.midAutDailyTask:getv(data.id, 0)
      all[tonumber(itemId)] = (all[tonumber(itemId)] or 0) + data.limit
    end
  end
  local xPos, yPos = 6, 0
  for i, itemId in ipairs(group[1]) do
    if 6 < i then
      break
    end
    ItemIcon.new({type = itemId, showTip = true}):scale(0.8):pos(xPos, 10):addTo(self.node1)
    display.newTTFLabel({
      text = string.format("剩余%d", all[itemId] - now[itemId]),
      size = 18,
      color = UIHelper.hex2rgb("#630c07")
    }):pos(xPos, -35):addTo(self.node1)
    xPos = xPos + 110
  end
  xPos, yPos = 6, -5
  for i, itemId in ipairs(group[2]) do
    if 18 < i then
      break
    end
    ItemIcon.new({type = itemId, showTip = true}):scale(0.8):pos(xPos, 10 + yPos):addTo(self.node2)
    display.newTTFLabel({
      text = string.format("剩余%d", all[itemId] - now[itemId]),
      size = 18,
      color = UIHelper.hex2rgb("#630c07")
    }):pos(xPos, -35 + yPos):addTo(self.node2)
    xPos = xPos + 110
    if i % 6 == 0 then
      xPos = 6
      yPos = yPos - 100
    end
  end
end

return NewYearDrawInfoLayer
