_class("UIN17DailyPlanController", UIController)
UIN17DailyPlanController = UIN17DailyPlanController

function UIN17DailyPlanController:_SetRawImageBtn(widgetName, size, urlNormal, urlClick, callback)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRawImageBtn")
  obj:SetData(size, urlNormal, urlClick, callback)
end

function UIN17DailyPlanController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N17
  self._componentCycleQuestId = ECampaignN17ComponentID.ECAMPAIGN_N17_CYCLE_QUEST
  self._componentStoryId = ECampaignN17ComponentID.ECAMPAIGN_N17_STORY
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentCycleQuestId, self._componentStoryId)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
end

function UIN17DailyPlanController:OnShow(uiParams)
  self._inHome = uiParams[1]
  self:_SetTabBtns()
  self:_SetTabPages()
  self:_SetTabSelect(self._inHome and 2 or 1)
  self:_SetInHomeMode()
  self._campaign:GetLocalProcess():OnOpenPlanList()
end

function UIN17DailyPlanController:OnHide()
end

function UIN17DailyPlanController:_Refresh()
  local index = self._tabIndex
  local components = {
    self._campaign:GetComponent(self._componentStoryId),
    self._campaign:GetComponent(self._componentCycleQuestId)
  }
  self._tabPages[index]:SetData(components[index], self._inHome, function()
    self:CloseDialog()
  end)
end

function UIN17DailyPlanController:_SetInHomeMode()
  if self._inHome then
    self._tabBtns[1]:GetGameObject():SetActive(false)
  end
end

function UIN17DailyPlanController:_SetTabBtns()
  local title = {
    "str_n17_daily_plan_tab_btn_explore",
    "str_n17_daily_plan_tab_btn_home"
  }
  self._tabBtns = UIWidgetHelper.SpawnObjects(self, "_tabBtns", "UIActivityCommonTextTabBtn", #title)
  for i, v in ipairs(self._tabBtns) do
    v:SetData(i, {
      indexWidgets = {},
      onoffWidgets = {
        {"OnBtn"},
        {"OffBtn"}
      },
      lockWidgets = {},
      titleWidgets = {
        "txtTitle_off",
        "txtTitle_on"
      },
      titleText = StringTable.Get(title[i]),
      callback = function(index, isOffBtnClick)
        if isOffBtnClick then
          self:_SetTabSelect(index)
        end
      end
    })
  end
end

function UIN17DailyPlanController:_SetTabSelect(index)
  if self._tabIndex == index then
    return
  end
  self._tabIndex = index
  for i = 1, #self._tabBtns do
    self._tabBtns[i]:SetSelected(i == index)
    self._tabPages[i]:GetGameObject():SetActive(i == index)
  end
  self:_Refresh()
end

function UIN17DailyPlanController:_SetTabPages()
  self._tabPages = {}
  self._tabPages[1] = UIWidgetHelper.SpawnObject(self, "_tab_Explore", "UIN17DailyPlanTabExplore")
  self._tabPages[2] = UIWidgetHelper.SpawnObject(self, "_tab_Home", "UIN17DailyPlanTabHome")
end

function UIN17DailyPlanController:CloseBtnOnClick(go)
  UIWidgetHelper.PlayAnimation(self, "_anim", "UIN17DailyPlanController_anim2", 500, function()
    self:CloseDialog()
  end)
end

function UIN17DailyPlanController:AssistantOnClick(go)
end
