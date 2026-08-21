_class("UIS3GoBtn", UICustomWidget)
UIS3GoBtn = UIS3GoBtn

function UIS3GoBtn:OnShow()
  self._constBtnName = GameGlobal.GetUIModule(SeasonModule):GetGoBtnKey()
end

function UIS3GoBtn:OnHide()
end

function UIS3GoBtn:SetData(seasonId, component)
  self._seasonId = seasonId
  self._component = component
  local isOpen = component and component:ComponentIsOpen()
  self._state = isOpen and 1 or 2
  self:_SetState(self._state)
  self:_Refresh(component)
end

function UIS3GoBtn:_Refresh(component)
  local isShow = component ~= nil
  self:GetGameObject("_topTip"):SetActive(self._state ~= 2 and isShow)
  if not isShow then
    return
  end
  local cur, ceil = component:GetItemCount()
  local str = UIActivityHelper.GetColorText("#FFFFFF", cur, "#FFFFFF", "/" .. ceil)
  UIWidgetHelper.SetLocalizationText(self, "_text", str)
  local itemId = component:GetItemId()
  UIWidgetHelper.SetItemIconSprite(self, itemId, "_icon")
  self:_CheckPoint()
end

function UIS3GoBtn:_SetState(state)
  self:GetGameObject("_lock"):SetActive(state == 2)
  self:GetGameObject("_topTip"):SetActive(state ~= 2)
  local alpha = state == 2 and 0.5 or 1
  local obj = self:GetUIComponent("CanvasGroup", "_alphaGroup")
  obj.alpha = alpha
end

function UIS3GoBtn:_CalcNew()
  local isOpen = self._component and self._component:ComponentIsOpen()
  local isNew = not UISeasonLocalDBHelper.SeasonBtn_Has(self._constBtnName, "New")
  return isOpen and isNew
end

function UIS3GoBtn:_CalcRed()
  local isOpen = self._component and self._component:ComponentIsOpen()
  if not isOpen then
    return isOpen
  end
  local lastTime = UISeasonLocalDBHelper.SeasonBtn_Get(self._constBtnName, "Red")
  Log.debug("UIS3GoBtn:_CalcRed() lastTime = ", lastTime)
  local isCross = HelperProxy:IsCrossDayTo(lastTime)
  local cur, ceil = self._component:GetItemCount()
  local haveItem = 0 < cur
  local isCoinRed = isCross and haveItem
  local isTaskRed = GameGlobal.GameLogic():GetModule(SeasonTaskModule):TaskListRed()
  return isCoinRed or isTaskRed
end

function UIS3GoBtn:_CheckPoint()
  local new = self:_CalcNew()
  local red = self:_CalcRed()
  UIWidgetHelper.SetNewAndReds(self, new, red, "_new", "_red")
end

function UIS3GoBtn:BtnOnClick()
  Log.info("UIS3GoBtn:BtnOnClick")
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
