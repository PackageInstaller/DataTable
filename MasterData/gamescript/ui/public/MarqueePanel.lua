local Vector3 = CS.UnityEngine.Vector3
local MarqueePanel, Super = System.NewClass("MarqueePanel", UIBasePanel)
MarqueePanel.uiResCls = UI_Common_Popup_NoticeResource

function MarqueePanel:ctor(showTet)
  Super.ctor(self)
  self.showTet = showTet
end

function MarqueePanel:OnBind(binder)
  self.binder = binder
  binder:BindToText(self.ui.Text_Notice, function()
    do return LT.Text end
    return LT.Text, self.showTet
  end)
  self:PlayMarqueeAnim()
end

function MarqueePanel:PlayMarqueeAnim()
  local deltaDistance = 5
  local halfContentWidth = self.ui.Image_Mask:GetComponent(typeof(CS.UnityEngine.RectTransform)).sizeDelta.x / 2
  local textWidth = self.binder:GetTextComp(self.ui.Text_Notice).preferredWidth
  local startPos = halfContentWidth
  local endPos = -textWidth - halfContentWidth
  self.timer = self.binder:BindTimer(0.025, -1, function()
    self.ui.Text_Notice.transform.localPosition = Vector3(startPos, 0, 0)
    startPos = startPos - deltaDistance
    if startPos <= endPos then
      self.binder:StopTimer(self.timer)
      self.timer = nil
      self:OnClose()
    end
  end)
end

function MarqueePanel:OnClose()
  if self.timer then
    self.binder:StopTimer(self.timer)
    self.timer = nil
  end
  self:Close()
end

return MarqueePanel
