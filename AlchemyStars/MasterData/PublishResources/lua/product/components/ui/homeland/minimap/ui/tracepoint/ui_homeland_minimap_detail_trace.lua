_class("UIHomelandMinimapDetailTrace", UIHomelandMinimapDetailBase)
UIHomelandMinimapDetailTrace = UIHomelandMinimapDetailTrace

function UIHomelandMinimapDetailTrace:OnShow()
  self._nameTxt = self:GetUIComponent("UILocalizationText", "NameTxt")
  self._contentTxt = self:GetUIComponent("UILocalizationText", "ContentTxt")
end

function UIHomelandMinimapDetailTrace:OnInitDone()
  self.birthId = self:GetIconData():GetIndex()
  self.homeMD = GameGlobal.GetModule(HomelandModule)
  self.info = self.homeMD:GetTreasureBirthInfo(self.birthId)
  if self.info == nil then
    self._nameTxt:SetText("")
    self._contentTxt:SetText("")
  end
  self._titleRect = self:GetUIComponent("RectTransform", "Title")
  if self._titleRect then
    local titleWidth = self._nameTxt.preferredWidth
    if 350 < titleWidth then
      titleWidth = 350
    end
    self._titleRect.sizeDelta = Vector2(titleWidth, self._titleRect.sizeDelta.y)
  end
end

function UIHomelandMinimapDetailTrace:ExitOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapCloseDetailUI)
  self:OnClose()
end

function UIHomelandMinimapDetailTrace:BtnBGOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapCloseDetailUI)
  self:OnClose()
end
