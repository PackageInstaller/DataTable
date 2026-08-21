local uiData = {
  csbFile = "ui/activity/NoticeLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    btnClose = "btnClose",
    content = "content",
    tipNode = "tipNode"
  }
}
local NoticeLayer = class("NoticeLayer", UIBase)

function NoticeLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function NoticeLayer:init(params)
  self.btnClose:setTouchScale(true)
  self.closeCallback = params.callback
  self.btnClose:setCallback(function()
    if self.closeCallback then
      self.closeCallback()
    end
    self:close()
  end)
  self.noticeUrl = game.noticeUrl .. string.format("?random=%s", math.randomFloat(0, 1))
  self.content:hide()
  self.content:runAction(transition.sequence({
    cc.DelayTime:create(0.8),
    cc.Show:create()
  }))
end

function NoticeLayer:showData(params)
  if device.platform == "android" or device.platform == "ios" then
    self:loadURL()
  else
    display.newTTFLabel({
      text = "只支持在android或ios上显示"
    }):enableOutline(display.COLOR_BLACK, 1):addTo(self.tipNode)
  end
end

function NoticeLayer:loadURL(reLoad)
  local size = self.content:getContentSize()
  local webView = ccexp.WebView:create()
  webView:size(864, 472)
  webView:anch(0, 0):addTo(self.content):hide()
  webView:loadURL(self.noticeUrl)
  self.tipNode:show()
  self.tipNode:removeAllChildren()
  if reLoad then
    UIHelper.createJeteWord({
      text = "加载失败，正在重新加载...",
      outline = display.COLOR_BLACK
    }):addTo(self.tipNode)
  else
    UIHelper.createJeteWord({
      text = "加载中...",
      outline = display.COLOR_BLACK
    }):addTo(self.tipNode)
  end
  webView:setOnDidFinishLoading(function()
    self.content:runAction(transition.sequence({
      cc.DelayTime:create(0.5),
      cc.CallFunc:create(function()
        webView:show()
        self.tipNode:hide()
      end)
    }))
  end)
  webView:setOnDidFailLoading(function()
    self.content:removeAllChildren()
    self:loadURL()
  end)
end

return NoticeLayer
