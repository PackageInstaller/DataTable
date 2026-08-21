local heroRes = "ui/hero/detail/"
local uiData = {
  csbFile = "ui/kitchen/StrengthUpLevelLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {popAction = "popAction", node = "node"}
}
local StrengthUpLevelLayer = class("StrengthUpLevelLayer", UIBase)

function StrengthUpLevelLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function StrengthUpLevelLayer:init(params)
end

function StrengthUpLevelLayer:showData(params)
  local attrs = {
    "atk",
    "hit",
    "miss",
    "phyDef"
  }
  local texts = {
    "攻击:",
    "命中:",
    "闪避:",
    "防御:"
  }
  local hero = game.role.heros[params.id]
  local old = params.old
  local new = hero:getTotalAttrValues()
  for i = 1, 4 do
    local yPos = (i - 1) * -25
    display.newSprite(heroRes .. attrs[i] .. ".png"):pos(0, yPos):addTo(self.node)
    display.newTTFLabel({
      text = texts[i],
      size = 18,
      color = UIHelper.hex2rgb("#713802")
    }):pos(50, yPos):addTo(self.node)
    display.newTTFLabel({
      text = old[attrs[i]] or 0,
      size = 18,
      color = UIHelper.hex2rgb("#713802")
    }):anch(0, 0.5):pos(90, yPos):addTo(self.node)
    for index = 1, 4 do
      display.newSprite("ui/kitchen/quality/arrow.png"):pos(160 + (index - 1) * 6, yPos):addTo(self.node)
    end
    display.newTTFLabel({
      text = new[attrs[i]] or 0,
      size = 18,
      color = UIHelper.hex2rgb("#3a9721")
    }):anch(0, 0.5):pos(220, yPos):addTo(self.node)
  end
end

return StrengthUpLevelLayer
