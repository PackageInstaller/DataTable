_class("UIHomeLandDiaryTipItem", UICustomWidget)
UIHomeLandDiaryTipItem = UIHomeLandDiaryTipItem

function UIHomeLandDiaryTipItem:LoadDataOnEnter(TT, res, uiParams)
end

function UIHomeLandDiaryTipItem:_InitWidget()
  self.iconLoader = self:GetUIComponent("RawImageLoader", "icon")
  self.msgText = self:GetUIComponent("UILocalizationText", "msgText")
  self.contentImg = self:GetUIComponent("Image", "content")
end

function UIHomeLandDiaryTipItem:SetData(data, atlas)
  self._data = data
  self._pageIndex = 1
  local timerName = "UIHomeLandDiaryTipItem"
  self._timerHolder:StartTimer(timerName, 3000, function()
    self:GetGameObject():SetActive(false)
  end)
end

function UIHomeLandDiaryTipItem:OnShow(uiParams)
  self._timerHolder = UITimerHolder:New()
  self:_InitWidget()
end

function UIHomeLandDiaryTipItem:Refresh()
end

function UIHomeLandDiaryTipItem:OnHide()
  if self._timerHolder then
    self._timerHolder:Dispose()
    self._timerHolder = nil
  end
end

function UIHomeLandDiaryTipItem:_AttachEvents()
end

function UIHomeLandDiaryTipItem:_DetachEvents()
end

function UIHomeLandDiaryTipItem:btnOnClick()
end
