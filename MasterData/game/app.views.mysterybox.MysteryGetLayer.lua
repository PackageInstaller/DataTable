local MysteryRes = "ui/mysterybox/"
local MysteryBoxCsv = require("csvdata.activity_84_diamondblindbox")
local uiData = {
  csbFile = "ui/mysterybox/MysteryGetLayer.csb",
  mask = true,
  popup = true,
  maskClick = function()
    BackManager:pop()
  end,
  widgets = {
    infoBg = "infoBg",
    content = "infoBg/content"
  }
}
local MysteryGetLayer = class("MysteryGetLayer", UIBase)

function MysteryGetLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function MysteryGetLayer:init(params)
  game:playMusic(1022)
  local mulNum = params.mulNum
  local select = params.select
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(MysteryRes, {
    "mystery_getbox_" .. select .. ".png",
    "mystery_getbox_" .. select .. ".png"
  })
  btn:pos(0, 0):addTo(self.content):setTouchScale()
  btn:setCallback(function()
    BackManager:pop()
  end)
  display.newTTFLabel({
    text = mulNum,
    size = 30,
    color = UIHelper.hex2rgb("#ffe348")
  }):enableOutline(UIHelper.hex2rgb("#c53800"), 2):pos(30, 55):addTo(btn)
  display.newTTFLabel({
    text = "倍",
    size = 16,
    color = UIHelper.hex2rgb("#ffe348")
  }):enableOutline(UIHelper.hex2rgb("#c53800"), 2):pos(57, 35):addTo(btn)
  local text2 = string.format("<div color=#ffe348>%s</div>倍盲盒", mulNum)
  MRichText.new({
    text = text2,
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0.5, 0.5):pos(454, 35):addTo(self.infoBg)
  local stars = UIHelper.createSpineNodeByRes("spine/ui/activity/star2")
  stars:setAnimation(0, "special", true)
  stars:pos(0, 0):addTo(self.content):name("star2")
end

return MysteryGetLayer
