_class("UIS2QuestBtn", UICustomWidget)
UIS2QuestBtn = UIS2QuestBtn

function UIS2QuestBtn:OnShow()
  self._constBtnName = self:GetName()
end

function UIS2QuestBtn:OnHide()
end

function UIS2QuestBtn:SetData(seasonId, component)
  self._seasonId = seasonId
  self._component = component
  local isOpen = component and component:ComponentIsOpen()
  self._state = isOpen and 1 or 2
  self:_SetState(self._state)
  local obj = UIWidgetHelper.SpawnObject(self, "_iconGroup", "UIS2BtnIcon")
  obj:SetData(self:GetName())
  local cur, total = self:_Calc(component)
  self:_SetNum(cur, total)
  self:_SetFin(cur, total)
  self:_CheckPoint()
end

function UIS2QuestBtn:_SetState(state)
  self:GetGameObject("_over"):SetActive(state == 2)
  local alpha = state == 2 and 0.5 or 1
  local obj = self:GetUIComponent("CanvasGroup", "_alphaGroup")
  obj.alpha = alpha
end

function UIS2QuestBtn:_SetNum(cur, total)
  local show = total ~= 0
  self:GetGameObject("_imgNum"):SetActive(show)
  local str = UIActivityHelper.GetColorText("#FFFFFF", cur, "#F5B62F", "/" .. total)
  UIWidgetHelper.SetLocalizationText(self, "_txtNum", str)
end

function UIS2QuestBtn:_SetFin(cur, total)
  local show = cur == total and total ~= 0
  self:GetGameObject("_fin"):SetActive(show)
end

function UIS2QuestBtn:_Calc(component)
  if component == nil then
    return 0, 0
  end
  local questList = UIS1Helper.GetQuestInfo_BySeasonFilter(component)
  questList = UIS1Helper.HideQuest(questList)
  local questStatus = component:GetCampaignQuestStatus(questList)
  local cur, total = 0, table.count(questStatus)
  for _, v in pairs(questStatus) do
    if v == CampaignQuestStatus.CQS_Taken then
      cur = cur + 1
    end
  end
  return cur, total
end

function UIS2QuestBtn:_CalcNew()
  local isOpen = self._component and self._component:ComponentIsOpen()
  local isNew = not UISeasonLocalDBHelper.SeasonBtn_Has(self._constBtnName, "New")
  return isOpen and isNew
end

function UIS2QuestBtn:_CalcRed()
  local isRed = self._component and self._component:HaveRedPoint() or false
  return isRed
end

function UIS2QuestBtn:_CheckPoint()
  local new = self:_CalcNew()
  local red = self:_CalcRed()
  UIWidgetHelper.SetNewAndReds(self, new, red, "_new", "_red")
end

function UIS2QuestBtn:BtnOnClick()
  Log.info("UIS2QuestBtn:BtnOnClick")
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
