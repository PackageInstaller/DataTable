local FrameCsv = require("csvdata.diner_bubbles")
local SpeakRes = "speakFrame/"
local uiData = {
  csbFile = "ui/diner/DinerBoxSpeakFrameLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {title = "title", node = "node"}
}
local DinerBoxSpeakFrameLayer = class("DinerBoxSpeakFrameLayer", UIBase)

function DinerBoxSpeakFrameLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DinerBoxSpeakFrameLayer:init(params)
  self.title:setString("对话框选择")
  self.callback = params.callback
  self.selected = params.selected or 1
end

function DinerBoxSpeakFrameLayer:showData(params)
  local xPos = (#FrameCsv - 1) / 2 * -110
  local group = MRadioGroup:create()
  for i, data in ipairs(FrameCsv) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(SpeakRes, {
      string.format("frame_%d_a.png", i),
      string.format("frame_%d_b.png", i)
    })
    btn:pos(xPos, 0):addTo(self.node):name("btn" .. i)
    btn:setGroup(group)
    btn:setCallback(function()
      if data.itemId ~= 0 and (game.role.items[data.itemId] or 0) == 0 then
        group:chooseByName("btn" .. self.selected)
        return
      end
      self.selected = i
      self.callback(i)
    end)
    xPos = xPos + 110
  end
  group:chooseByName("btn" .. self.selected)
end

return DinerBoxSpeakFrameLayer
