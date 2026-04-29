_class("UIS3QuestBtn", UICustomWidget)
UIS3QuestBtn = UIS3QuestBtn

function UIS3QuestBtn:OnShow()
  self._constBtnName = self:GetName()
end

function UIS3QuestBtn:OnHide()
end

function UIS3QuestBtn:SetData(seasonId, component)
  self._seasonId = seasonId
  self._component = component
  local isOpen = component and component:ComponentIsOpen()
  self._state = isOpen and 1 or 2
  self:_SetState(self._state)
  local cur, total = self:_Calc(component)
  self:_SetNum(cur, total)
  self:_SetFin(cur, total)
  self:_SummaryActive()
  self:_CheckPoint()
end

function UIS3QuestBtn:_SetState(state)
  self:GetGameObject("_over"):SetActive(state == 2)
  local alpha = state == 2 and 0.5 or 1
  local obj = self:GetUIComponent("CanvasGroup", "_alphaGroup")
  obj.alpha = alpha
end

function UIS3QuestBtn:_SetNum(cur, total)
  local show = total ~= 0
  self:GetGameObject("_imgNum"):SetActive(show)
  local str = UIActivityHelper.GetColorText("#FFFFFF", cur, "#FFFFFF", "/" .. total)
  UIWidgetHelper.SetLocalizationText(self, "_txtNum", str)
end

function UIS3QuestBtn:_SetFin(cur, total)
  local show = cur == total and total ~= 0
  self:GetGameObject("_fin"):SetActive(show)
end

function UIS3QuestBtn:_SummaryActive()
  local goNum = self:GetGameObject("_imgNum")
  local goFin = self:GetGameObject("_fin")
  local goOver = self:GetGameObject("_over")
  local showNum = goNum.activeSelf
  local showFin = goFin.activeSelf
  local showOver = self._state == 2
  goNum:SetActive(not showOver and not showFin and showNum)
  goFin:SetActive(not showOver and showFin)
  goOver:SetActive(showOver)
end

function UIS3QuestBtn:_Calc(component)
  if component == nil then
    return 0, 0
  end
  local questList = UIS1Helper.GetQuestInfo_BySeasonFilter(component)
  local questStatus = component:GetCampaignQuestStatus(questList)
  local cur, total = 0, table.count(questStatus)
  for _, v in pairs(questStatus) do
    if v == CampaignQuestStatus.CQS_Taken then
      cur = cur + 1
    end
  end
  return cur, total
end

function UIS3QuestBtn:_CalcNew()
  local isOpen = self._component and self._component:ComponentIsOpen()
  local isNew = not UISeasonLocalDBHelper.SeasonBtn_Has(self._constBtnName, "New")
  return isOpen and isNew
end

function UIS3QuestBtn:_CalcRed()
  local isRed = self._component and self._component:HaveRedPoint() or false
  return isRed
end

function UIS3QuestBtn:_CheckPoint()
  local new = self:_CalcNew()
  local red = self:_CalcRed()
  UIWidgetHelper.SetNewAndReds(self, new, red, "_new", "_red")
end

function UIS3QuestBtn:BtnOnClick()
  Log.info("UIS3QuestBtn:BtnOnClick")
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
  GameGlobal.UIStateManager():ShowDialog("UISeasonQuestController")
end
