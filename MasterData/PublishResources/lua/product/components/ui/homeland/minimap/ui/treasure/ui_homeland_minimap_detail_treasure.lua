_class("UIHomelandMinimapDetailTreasure", UIHomelandMinimapDetailBase)
UIHomelandMinimapDetailTreasure = UIHomelandMinimapDetailTreasure

function UIHomelandMinimapDetailTreasure:OnShow()
  self._nameTxt = self:GetUIComponent("UILocalizationText", "NameTxt")
  self._contentTxt = self:GetUIComponent("UILocalizationText", "ContentTxt")
end

function UIHomelandMinimapDetailTreasure:OnInitDone()
  self.birthId = self:GetIconData():GetIndex()
  self.homeMD = GameGlobal.GetModule(HomelandModule)
  self.info = self.homeMD:GetTreasureBirthInfo(self.birthId)
  if self.info == nil then
    self._nameTxt:SetText("")
    self._contentTxt:SetText("")
    return
  end
  if self.info.content_view_id == TreasureViewType.TVT_NULL then
    self._nameTxt:SetText(StringTable.Get("str_homeland_minimap_treasure_null_title"))
    self._contentTxt:SetText(StringTable.Get("str_homeland_minimap_treasure_null_content"))
  elseif self.info.content_view_id == TreasureViewType.TVT_SIGN then
    self._nameTxt:SetText(StringTable.Get("str_homeland_minimap_treasure_sign_title"))
    self._contentTxt:SetText(StringTable.Get("str_homeland_minimap_treasure_sign_content"))
  elseif self.info.content_view_id == TreasureViewType.TVT_ASSO then
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

function UIHomelandMinimapDetailTreasure:ExitOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapCloseDetailUI)
  self:OnClose()
end

function UIHomelandMinimapDetailTreasure:BtnBGOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapCloseDetailUI)
  self:OnClose()
end

function UIHomelandMinimapDetailTreasure:GetCloseAnimtionName()
  return "UIHomelandMinimapDetailTreasure_out"
end
