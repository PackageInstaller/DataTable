_class("UIPlotItem", UICustomWidget)
UIPlotItem = UIPlotItem

function UIPlotItem:OnShow()
  self._txtChapter = self:GetUIComponent("UILocalizationText", "txtChapter")
  self._txtChapterRect = self:GetUIComponent("RectTransform", "txtChapter")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._txtNameRect = self:GetUIComponent("RectTransform", "txtName")
  self._have3dGo = self:GetGameObject("have3d")
  self._have3dTr = self:GetUIComponent("Transform", "have3d")
  self._v = nil
  self:Select(false)
end

function UIPlotItem:Flush(v, have3d)
  if not v then
    return
  end
  self._v = v
  self._txtChapter:SetText(v.stageIdx)
  self._txtName:SetText(v.name)
  self._have3dGo:SetActive(have3d)
end

function UIPlotItem:bgOnClick(go)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIPlotClickItem, self._v.id)
end

function UIPlotItem:Select(select)
  if self.select == select then
    return
  end
  self.select = select
  if self.select then
    self._txtChapter.fontSize = 70
    self._txtName.fontSize = 32
    self._txtChapterRect.anchoredPosition = Vector2(0, 45)
    self._txtNameRect.sizeDelta = Vector2(315, 50)
    self._have3dTr.localScale = Vector3(1, 1, 1)
  else
    self._txtChapter.fontSize = 36
    self._txtName.fontSize = 22
    self._txtChapterRect.anchoredPosition = Vector2(0, 20)
    self._txtNameRect.sizeDelta = Vector2(222, 50)
    self._have3dTr.localScale = Vector3(0.5, 0.5, 0.5)
  end
end
