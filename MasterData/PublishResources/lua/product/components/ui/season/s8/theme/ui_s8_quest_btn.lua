_class("UIS8QuestBtn", UICustomWidget)
UIS8QuestBtn = UIS8QuestBtn

function UIS8QuestBtn:OnShow()
  self._constBtnName = self:GetName()
end

function UIS8QuestBtn:OnHide()
end

function UIS8QuestBtn:SetData(seasonId, component, playAnim)
  self._seasonId = seasonId
  self._component = component
  local isOpen = component and component:ComponentIsOpen()
  self._state = isOpen and 1 or 2
  self:_SetState(self._state)
  local cur, total = self:_Calc(component)
  self:_SetNum(cur, total)
  self:_SetFin(cur, total)
  self:_CheckPoint()
  if playAnim then
  end
end

function UIS8QuestBtn:_SetState(state)
  self:GetGameObject("_over"):SetActive(state == 2)
end

function UIS8QuestBtn:_SetNum(cur, total)
  local show = total ~= 0
  self:GetGameObject("_imgNum"):SetActive(show)
  local str = UIActivityHelper.GetColorText("#FFFFFF", cur, "#F5B62F", "/" .. total)
  UIWidgetHelper.SetLocalizationText(self, "_txtNum", str)
end

function UIS8QuestBtn:_SetFin(cur, total)
  local show = cur == total and total ~= 0
  self:GetGameObject("_fin"):SetActive(show)
end

function UIS8QuestBtn:_Calc(component)
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

function UIS8QuestBtn:_CalcNew()
  local isOpen = self._component and self._component:ComponentIsOpen()
  local isNew = not UISeasonLocalDBHelper.SeasonBtn_Has(self._constBtnName, "New")
  return isOpen and isNew
end

function UIS8QuestBtn:_CalcRed()
  local isRed = self._component and self._component:HaveRedPoint() or false
  return isRed
end

function UIS8QuestBtn:_CheckPoint()
  local new = self:_CalcNew()
  local red = self:_CalcRed()
  UIWidgetHelper.SetNewAndReds(self, new, red, "_new", "_red")
end

function UIS8QuestBtn:BtnOnClick()
  Log.info("UIS8QuestBtn:BtnOnClick")
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
