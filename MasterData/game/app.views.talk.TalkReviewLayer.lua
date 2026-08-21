local StoryCsv = require("csvdata.story")
local Story2Csv = require("csvdata.story2")
local UnitCsv = require("csvdata.unit")
local TalkRes = "ui/talk/main/"
local uiData = {
  csbFile = "ui/talk/TalkReviewLayer.csb",
  mask = true,
  maskClick = function()
    BackManager:pop()
  end,
  widgets = {listView = "listView", closeBtn = "closeBtn"}
}
local TalkReviewLayer = class("TalkReviewLayer", UIBase)

function TalkReviewLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TalkReviewLayer:init(params)
  self.talkId = params.talkId
  self.step = params.step
  self.csvNo = params.csvNo
  self.actors = {}
  self.closeBtn:setCallback(function()
    BackManager:pop()
  end)
end

function TalkReviewLayer:showData()
  self.listView:removeAllChildren()
  local size = display.newSprite(TalkRes .. "review_cell.png"):getContentSize()
  local storySet = self.csvNo and self.csvNo == 1 and Story2Csv[self.talkId] or StoryCsv[self.talkId]
  for step, story in ipairs(storySet) do
    if step <= self.step then
      local data = story.content:toArray("=")
      if story.type == 1 and tonumber(data[1]) == 1 then
        self.actors[tonumber(data[2])] = tonumber(data[3])
      end
      if story.type == 1 and tonumber(data[1]) == 6 then
        self.actors[tonumber(data[2])] = tonumber(data[3])
      end
      if story.type == 2 and tonumber(data[1]) == 1 then
        local viewNode = ccui.Widget:create()
        viewNode:setContentSize(size):addTo(self.listView)
        local content = UIHelper.newImageView(TalkRes .. "review_cell.png"):center(viewNode):addTo(viewNode)
        local id = tonumber(data[2])
        local actor = self.actors[id]
        display.newTTFLabel({
          text = UnitCsv[actor].name,
          size = 22,
          color = display.COLOR_WHITE
        }):anch(0, 1):pos(15, size.height - 15):addTo(content)
        MRichText.new({
          text = string.gsub(data[3], "%[name%]", string.format("<div color=#77eb6e>%s</div>", game.role.name)),
          color = display.COLOR_WHITE,
          size = 20,
          maxWidth = 860
        }):pos(15, size.height - 40):addTo(content)
      end
    end
  end
  self.listView:requestDoLayout()
end

return TalkReviewLayer
