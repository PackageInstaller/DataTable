_class("UIS8ExchangeBtn", UICustomWidget)
UIS8ExchangeBtn = UIS8ExchangeBtn

function UIS8ExchangeBtn:OnShow()
  self._constBtnName = self:GetName()
  self:_AttachEvents()
end

function UIS8ExchangeBtn:OnHide()
  self:_DetachEvents()
end

function UIS8ExchangeBtn:SetData(seasonId, component, playAnim)
  self._seasonId = seasonId
  self._component = component
  local isOpen = component and component:ComponentIsOpen()
  self._state = isOpen and 1 or 2
  self:_SetState(self._state)
  self:_Refresh()
  if playAnim then
  end
end

function UIS8ExchangeBtn:_Refresh()
  if self._component == nil then
    return
  end
  local id1, id2 = self._component:GetCostItemId(true), self._component:GetCostItemId(false)
  self:_SetIconText(id1, "_icon1", "_text1")
  self:_SetIconText(id2, "_icon2", "_text2")
  self:_CheckPoint()
end

function UIS8ExchangeBtn:_SetState(state)
  self:GetGameObject("_over"):SetActive(state == 2)
end

function UIS8ExchangeBtn:_SetIconText(itemId, widgetIcon, widgetText)
  local atlasName = "UICommon.spriteatlas"
  local spriteName = "toptoon_" .. itemId
  UIWidgetHelper.SetImageSprite(self, widgetIcon, atlasName, spriteName)
  UIWidgetHelper.SetItemCount(self, itemId, widgetText)
end

function UIS8ExchangeBtn:_CalcNew()
  local isNew = not UISeasonLocalDBHelper.SeasonBtn_Has(self._constBtnName, "New")
  return isNew
end

function UIS8ExchangeBtn:_CalcRed()
  local isRed = self._component and self._component:HaveRedPoint()
  return isRed
end

function UIS8ExchangeBtn:_CheckPoint()
  local new = self:_CalcNew()
  local red = self:_CalcRed()
  UIWidgetHelper.SetNewAndReds(self, new, red, "_new", "_red")
end

function UIS8ExchangeBtn:BtnOnClick()
  Log.info("UIS8ExchangeBtn:BtnOnClick")
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  if seasonModule:CheckSeasonClose_ShowClientError(self._seasonId) then
    return
  end
  if self._state == 2 then
    ToastManager.ShowToast(StringTable.Get("str_season_s1_main_btn_over"))
    return
  end
  UISeasonLocalDBHelper.SeasonBtn_Set(self._constBtnName, "New")
  self:_CheckPoint()
  UISeasonHelper.ShowCurSeasonExchange()
end

function UIS8ExchangeBtn:_AttachEvents()
  self:AttachEvent(GameEventType.ItemCountChanged, self._Refresh)
end

function UIS8ExchangeBtn:_DetachEvents()
  self:DetachEvent(GameEventType.ItemCountChanged, self._Refresh)
end
