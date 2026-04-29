_class("UIActivityN29DetectiveClueItem", UICustomWidget)
UIActivityN29DetectiveClueItem = UIActivityN29DetectiveClueItem

function UIActivityN29DetectiveClueItem:OnShow(uiParams)
  self._delay = 0.05
  self:_GetComponent()
end

function UIActivityN29DetectiveClueItem:_GetComponent()
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._selcetObj = self:GetGameObject("select")
end

function UIActivityN29DetectiveClueItem:GetCfg()
  return self._data
end

function UIActivityN29DetectiveClueItem:SetData(data, index, callback)
  self._data = data
  self._callback = callback
  self:_SetAnimation(self._delay * (index - 1))
  self._icon:LoadImage(self._data.Icon)
end

function UIActivityN29DetectiveClueItem:SetSelect(isSelect)
  self._selcetObj:SetActive(isSelect)
end

function UIActivityN29DetectiveClueItem:_SetAnimation(delay)
  UIWidgetHelper.PlayAnimationInSequence(self, "anim", "anim", "uieff_UIN29DetectiveClueItem_in", delay, 300, nil)
end

function UIActivityN29DetectiveClueItem:ItemBtnOnClick()
  self:SetSelect(true)
  if self._callback then
    self._callback(self)
  end
end
