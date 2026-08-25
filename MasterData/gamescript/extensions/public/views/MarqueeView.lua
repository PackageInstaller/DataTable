local Vector3 = CS.UnityEngine.Vector3
local MarqueeView, Super = NewClass("MarqueeView", BaseView)
MarqueeView.uiResCls = UI_Common_Popup_NoticeResource

function MarqueeView:ctor(showTet)
  Super.ctor(self)
  self._showTet = showTet
end

function MarqueeView:OnBuildView()
end

function MarqueeView:RegisterNotifications()
end

function MarqueeView:RegisterEvents()
end

function MarqueeView:OnEnterView()
  Super.OnEnterView(self)
  self:SetText(self.ui.Text_Notice, LT.Text(self._showTet))
  self:_PlayMarqueeAnim()
end

function MarqueeView:OnExitView()
  if self._timer then
    self:StopTimer(self._timer)
    self._timer = nil
  end
  Super.OnExitView(self)
end

function MarqueeView:_PlayMarqueeAnim()
  local deltaDistance = 5
  local halfContentWidth = self.ui.Image_Mask:GetComponent(typeof(CS.UnityEngine.RectTransform)).sizeDelta.x / 2
  local textComp = self:GetTextComp(self.ui.Text_Notice)
  local textWidth = textComp.preferredWidth
  local startPos = halfContentWidth
  local endPos = -textWidth - halfContentWidth
  self._timer = self:BindTimer(0.025, -1, function()
    self.ui.Text_Notice.transform.localPosition = Vector3(startPos, 0, 0)
    startPos = startPos - deltaDistance
    if startPos <= endPos then
      self:StopTimer(self._timer)
      self._timer = nil
      self:_OnClose()
    end
  end, nil)
end

function MarqueeView:_OnClose()
  if self._timer then
    self:StopTimer(self._timer)
    self._timer = nil
  end
  self:Close()
end

return MarqueeView
