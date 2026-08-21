local GlobalRes = "ui/global/"
local uiData = {
  csbFile = "ui/pvp/PvpInfoLayer.csb",
  mask = true,
  widgets = {
    center = "center",
    infoBg = "center/infoBg",
    title = "center/infoBg/title",
    btnClose = "center/infoBg/btnClose",
    textBg = "center/infoBg/textBg"
  }
}
local InfoLayer = class("InfoLayer", UIBase)

function InfoLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function InfoLayer:init(params)
  self.btnClose:hide()
  self.title:hide()
  self.btnClose:setCallback(function()
    self:close()
  end)
  TopBar:show(TopBarType.back)
end

function InfoLayer:showData(params)
  self.textBg:removeAllChildren()
  display.newTTFLabel({
    text = params.title,
    size = 34,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0.5, 0.5):pos(self.title:getPosition()):addTo(self.infoBg)
  local path = cc.FileUtils:getInstance():fullPathForFilename(params.path)
  local str = io.readfile(path)
  local size = self.textBg:getContentSize()
  local text = MRichText.new({
    text = str,
    size = 22,
    color = UIHelper.hex2rgb("#ffffff"),
    maxWidth = size.width - 5
  }):anch(0, 1):addTo(self.textBg)
  text:pos(0, math.max(size.height, text:getSize().height))
  self.textBg:setSize(cc.size(650, text:getSize().height))
end

return InfoLayer
