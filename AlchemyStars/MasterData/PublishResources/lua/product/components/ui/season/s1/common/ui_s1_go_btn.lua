_class("UIS1GoBtn", UICustomWidget)
UIS1GoBtn = UIS1GoBtn

function UIS1GoBtn:OnShow()
  self._constBtnName = GameGlobal.GetUIModule(SeasonModule):GetGoBtnKey()
end

function UIS1GoBtn:OnHide()
end

function UIS1GoBtn:SetData(seasonId, component)
  self._seasonId = seasonId
  self._component = component
  local isOpen = component and component:ComponentIsOpen()
  self._state = isOpen and 1 or 2
  self:_SetState(self._state)
  self:_Refresh(component)
end

function UIS1GoBtn:_Refresh(component)
  local isShow = component ~= nil
  self:GetGameObject("_topTip"):SetActive(isShow)
  if not isShow then
    return
  end
  local cur, ceil = component:GetItemCount()
  local str = string.format("<color=#ff9d32>%s</color>/%s", cur, ceil)
  UIWidgetHelper.SetLocalizationText(self, "_text", str)
  local itemId = component:GetItemId()
  local atlasName = "UICommon.spriteatlas"
  local spriteName = "toptoon_" .. itemId
  UIWidgetHelper.SetImageSprite(self, "_icon", atlasName, spriteName)
  self:_CheckPoint()
end

function UIS1GoBtn:_SetState(state)
  self:GetGameObject("_lock"):SetActive(state == 2)
  local alpha = state == 2 and 0.5 or 1
  local obj = self:GetUIComponent("CanvasGroup", "_alphaGroup")
  obj.alpha = alpha
end

function UIS1GoBtn:_CalcNew()
  local isOpen = self._component and self._component:ComponentIsOpen()
  local isNew = not UISeasonLocalDBHelper.SeasonBtn_Has(self._constBtnName, "New")
  return isOpen and isNew
end

function UIS1GoBtn:_CalcRed()
  local isOpen = self._component and self._component:ComponentIsOpen()
  if not isOpen then
    return isOpen
  end
  local lastTime = UISeasonLocalDBHelper.SeasonBtn_Get(self._constBtnName, "Red")
  Log.debug("UIS1GoBtn:_CalcRed() lastTime = ", lastTime)
  local isRed = HelperProxy:IsCrossDayTo(lastTime)
  local cur, ceil = self._component:GetItemCount()
  return isOpen and isRed and 0 < cur
end

function UIS1GoBtn:_CheckPoint()
  local new = self:_CalcNew()
  local red = self:_CalcRed()
  UIWidgetHelper.SetNewAndReds(self, new, red, "_new", "_red")
end

function UIS1GoBtn:BtnOnClick()
  Log.info("UIS1GoBtn:BtnOnClick")
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  if seasonModule:CheckSeasonClose_ShowClientError(self._seasonId) then
    return
  end
  if self._state == 2 then
    ToastManager.ShowToast(StringTable.Get("str_season_s1_main_btn_over"))
    return
  end
  GameGlobal.GetUIModule(SeasonModule):EnterCurrentSeasonMainUI()
  UISeasonLocalDBHelper.SeasonBtn_Set(self._constBtnName, "New")
  local now = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
  UISeasonLocalDBHelper.SeasonBtn_Set(self._constBtnName, "Red", now)
  self:_CheckPoint()
end
