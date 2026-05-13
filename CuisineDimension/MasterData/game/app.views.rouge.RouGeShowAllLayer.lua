local rougeShopCsv = require("csvdata.rouge.rouge_shop")
local RouGeMainRes = "ui/rouge/main/"
local uiData = {
  csbFile = "ui/rouge/RouGeShowBossLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    infoBg = "infoBg",
    okBtn = "infoBg/okBtn"
  }
}
local RouGeShowAllLayer = class("RouGeShowAllLayer", UIBase)

function RouGeShowAllLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function RouGeShowAllLayer:init(params)
  game:playMusic(1022)
  display.newTTFLabel({
    text = "查看全部",
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(568, 280):addTo(self.infoBg)
  local size = cc.size(800, 250)
  local list = ccui.ListView:create():size(size)
  list:setInnerContainerSize(size)
  list:setClippingEnabled(true)
  list:setDirection(2)
  list:anch(0, 0):pos(168, 10):addTo(self.infoBg)
  for _, csvData in pairs(params.skills) do
    self:createBossCell(csvData):addTo(list)
  end
  list:doLayout()
  self.okBtn:setCallback(function()
    self:close()
  end)
end

function RouGeShowAllLayer:createBossCell(data)
  local viewNode = ccui.Widget:create():size(cc.size(139, 230))
  local bg = UIHelper.newImageView(RouGeMainRes .. "buySkill_desc.png"):center(viewNode):scale(0.75):addTo(viewNode)
  local mask = UIHelper.getClipNode({
    steRes = RouGeMainRes .. "buySkill_desc_mask.png"
  }):pos(102.5, 275.5):addTo(bg)
  display.newSprite(data.icon):center(mask):scale(0.706):addTo(mask)
  display.newTTFLabel({
    text = data.title,
    size = 15,
    align = cc.TEXT_ALIGNMENT_CENTER
  }):pos(102.5, 219):addTo(bg)
  local level = data.passiveLevel
  local xPos, interval = (level - 1) / 2 * -20, 20
  for index = 1, level do
    display.newSprite(RouGeMainRes .. "levelIcon.png"):pos(xPos + (index - 1) * interval + 102.5, 198):scale(0.7):addTo(bg)
  end
  display.newTTFLabel({
    text = data.detail,
    size = 14,
    color = UIHelper.hex2rgb("#bfbfbf"),
    dimensions = cc.size(138, 120)
  }):anch(0.5, 1):pos(104, 176):addTo(bg)
  return viewNode
end

return RouGeShowAllLayer
