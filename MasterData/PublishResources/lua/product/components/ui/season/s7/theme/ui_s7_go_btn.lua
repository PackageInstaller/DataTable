_class("UIS7GoBtn", UICustomWidget)
UIS7GoBtn = UIS7GoBtn

function UIS7GoBtn:OnShow()
  self._constBtnName = GameGlobal.GetUIModule(SeasonModule):GetGoBtnKey()
end

function UIS7GoBtn:OnHide()
end

function UIS7GoBtn:SetData(seasonId, component, playAnim)
  self._seasonId = seasonId
  self._component = component
  local isOpen = component and component:ComponentIsOpen()
  self._state = isOpen and 1 or 2
  self:_SetState(self._state)
  self:_Refresh(component)
  if playAnim then
    UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_anim", "uieffanim_UIS7_GoBtn_in", 0, 667)
  end
end

function UIS7GoBtn:_Refresh(component)
  local isShow = component ~= nil
  self:GetGameObject("_topTip"):SetActive(isShow)
  if not isShow then
    return
  end
  local cur, ceil = component:GetItemCount()
  local str = cur .. "/" .. ceil
  UIWidgetHelper.SetLocalizationText(self, "_text", str)
  local itemId = component:GetItemId()
  UIWidgetHelper.SetItemIconSprite(self, itemId, "_icon")
  self:_CheckPoint()
end

function UIS7GoBtn:_SetState(state)
  self:GetGameObject("_lock"):SetActive(state == 2)
end

function UIS7GoBtn:_CalcNew()
  local isOpen = self._component and self._component:ComponentIsOpen()
  local isNew = not UISeasonLocalDBHelper.SeasonBtn_Has(self._constBtnName, "New")
  local sample = GameGlobal.GetModule(SeasonModule):GetCurSeasonSample()
  local talentNew = false
  if isOpen and sample then
    talentNew = UISeasonHelper.TalentTreeNew(sample)
  end
  local TradeNew = false
  if isOpen and sample then
    TradeNew = UISeasonHelper.TradeGameNew(sample)
  end
  local OnceMissonNew = false
  if isOpen and sample then
    OnceMissonNew = UISeasonHelper.SeasonOnceMissonNew(sample)
  end
  return isOpen and (isNew or talentNew or TradeNew)
end

function UIS7GoBtn:_CalcRed()
  local isOpen = self._component and self._component:ComponentIsOpen()
  if not isOpen then
    return isOpen
  end
  local lastTime = UISeasonLocalDBHelper.SeasonBtn_Get(self._constBtnName, "Red")
  Log.debug("UIS7GoBtn:_CalcRed() lastTime = ", lastTime)
  local isCross = HelperProxy:IsCrossDayTo(lastTime)
  local cur, ceil = self._component:GetItemCount()
  local haveItem = 0 < cur
  local isCoinRed = isCross and haveItem
  local isTaskRed = GameGlobal.GameLogic():GetModule(SeasonTaskModule):TaskListRed()
  local sample = GameGlobal.GetModule(SeasonModule):GetCurSeasonSample()
  local talentRed = false
  if isOpen and sample then
    talentRed = UISeasonHelper.TalentTreeRed(sample)
  end
  local TradeRed = false
  if isOpen and sample then
    TradeRed = UISeasonHelper.TradeGameRed(sample)
  end
  return isCoinRed or isTaskRed or talentRed or TradeRed
end

function UIS7GoBtn:_CheckPoint()
  local new = self:_CalcNew()
  local red = self:_CalcRed()
  UIWidgetHelper.SetNewAndReds(self, new, red, "_new", "_red")
end

function UIS7GoBtn:BtnOnClick()
  Log.info("UIS7GoBtn:BtnOnClick")
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
