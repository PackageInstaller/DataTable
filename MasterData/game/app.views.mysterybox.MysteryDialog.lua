local MysteryRes = "ui/mysterybox/"
local MysteryBoxCsv = require("csvdata.activity_84_diamondblindbox")
local uiData = {
  csbFile = "ui/mysterybox/MysteryDialog.csb",
  mask = true,
  popup = true,
  maskClick = false,
  widgets = {
    infoBg = "infoBg",
    titleBg = "infoBg/titleBg",
    content = "infoBg/content",
    cancelBtn = "infoBg/cancelBtn",
    okBtn = "infoBg/okBtn"
  }
}
local MysteryDialog = class("MysteryDialog", UIBase)

function MysteryDialog:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function MysteryDialog:init(params)
  game:playMusic(1022)
  display.newTTFLabel({
    text = params.title,
    size = 24,
    color = UIHelper.hex2rgb("#ffffff")
  }):center(self.titleBg):addTo(self.titleBg)
  display.newTTFLabel({
    text = params.cancelText,
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#a52bf5"), 1):center(self.cancelBtn):addTo(self.cancelBtn)
  display.newTTFLabel({
    text = params.okText,
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#dd7e6b"), 1):center(self.okBtn):addTo(self.okBtn)
  local richText = MRichText.new({
    text = params.text,
    color = UIHelper.hex2rgb("#57078c"),
    size = 26
  })
  richText:anch(0.5, 0.5):center(self.content):addTo(self.content)
  self.cancelBtn:setCallback(function()
    if params.cancelCallback then
      params.cancelCallback()
      self:close()
    end
  end)
  self.okBtn:setCallback(function()
    if params.okCallback then
      params.okCallback()
      self:close()
    end
  end)
end

return MysteryDialog
