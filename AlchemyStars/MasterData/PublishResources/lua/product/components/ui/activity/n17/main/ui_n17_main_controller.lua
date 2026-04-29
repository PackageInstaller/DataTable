_class("UIN17MainController", UIController)
UIN17MainController = UIN17MainController

function UIN17MainController:_SetRemainingTime(widgetName, extraId, descId, endTime, customTimeStr)
  local obj = UIWidgetHelper.SpawnObject(self, widgetName, "UIActivityCommonRemainingTime")
  if customTimeStr then
    obj:SetCustomTimeStr_Common_1()
  end
  obj:SetExtraText("txtDesc", nil, extraId)
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, function()
    self:_UpdateTime()
  end)
end

function UIN17MainController:_SetCommonTopButton()
  local obj = UIWidgetHelper.SpawnObject(self, "_backBtns", "UICommonTopButton")
  obj:SetData(function()
    self:_Back()
  end, nil, nil, false, function()
    self:_HideUI()
  end)
end

function UIN17MainController:_Back()
  self:SwitchState(UIStateType.UIMain)
end

function UIN17MainController:_HideUI()
  self:GetGameObject("_backBtns"):SetActive(false)
  self:GetGameObject("_showBtn"):SetActive(true)
  self:GetGameObject("_uiElements"):SetActive(false)
end

function UIN17MainController:_ShowUI()
  self:GetGameObject("_backBtns"):SetActive(true)
  self:GetGameObject("_showBtn"):SetActive(false)
  self:GetGameObject("_uiElements"):SetActive(true)
end

function UIN17MainController:_SetBg()
  local url = UIActivityHelper.GetCampaignMainBg(self._campaign, 1)
  if url then
    UIWidgetHelper.SetRawImage(self, "_mainBg", url)
  end
end

function UIN17MainController:_SetSpine()
  local obj = self:GetUIComponent("SpineLoader", "_spine")
  obj:LoadSpine("n17_kv_1_spine_idle")
end

function UIN17MainController:_SetImgRT(imgRT)
  if imgRT ~= nil then
    local rt = self:GetUIComponent("RawImage", "rt")
    rt.texture = imgRT
    return true
  end
  return false
end

function UIN17MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN17MainController)
end

function UIN17MainController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N17
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, ECampaignN17ComponentID.ECAMPAIGN_N17_CYCLE_QUEST, ECampaignN17ComponentID.ECAMPAIGN_N17_LOTTERY, ECampaignN17ComponentID.ECAMPAIGN_N17_CUMULATIVE_LOGIN, ECampaignN17ComponentID.ECAMPAIGN_N17_STORY, ECampaignN17ComponentID.ECAMPAIGN_N17_MINI_GAME, ECampaignN17ComponentID.ECAMPAIGN_N17_LEVEL_FIXTEAM)
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
    return
  end
  self._campaign:ClearCampaignNew(TT)
  self._bp_campaign = UIActivityCampaign:New()
  local bp_res = AsyncRequestRes:New()
  self._bp_campaign:LoadCampaignInfo(TT, bp_res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
end

function UIN17MainController:OnShow(uiParams)
  self:_AttachEvents()
  self._isOpen = true
  self:_SetBg()
  self:_SetCommonTopButton()
  self:_SetSpine()
  self:_UpdateTime()
  self:_SetIntroBtn()
  self:_SetReviewBtn()
  self:_Refresh()
  if self:_SetImgRT(uiParams[1]) then
    UIWidgetHelper.PlayAnimation(self, "_anim", "UIN17MainController_anim", 1667, function()
      self:_CheckGuide()
      self:_CheckNewsignal()
    end)
  else
    self:_CheckGuide()
    self:_CheckNewsignal()
  end
end

function UIN17MainController:OnHide()
  self:_DetachEvents()
  self._isOpen = false
end

function UIN17MainController:Destroy()
  self._matReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq)
end

function UIN17MainController:_Refresh()
  self:_SetTryoutBtn()
  self:_SetBattlePassBtn(self._bp_campaign)
  self:_SetLoginRewardBtn()
  self:_SetMiniGameBtn()
  self:_SetLotteryBtn()
  self:_SetDailyPlanBtn()
end

function UIN17MainController:_CheckNewsignal()
  local localProcess = self._campaign:GetLocalProcess()
  if localProcess:HaveNewHighEquip() then
    self:ShowDialog("UIN17MainTipsController")
    localProcess:OnEnterMiniGame()
  end
end

function UIN17MainController:_UpdateTime()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local info1 = self._campaign:GetComponentInfo(ECampaignN17ComponentID.ECAMPAIGN_N17_CYCLE_QUEST)
  local info2 = self._campaign:GetComponentInfo(ECampaignN17ComponentID.ECAMPAIGN_N17_STORY)
  local stop1 = math.max(info1.m_close_time, info2.m_close_time)
  local stop2 = self._campaign:GetSample().end_time
  if curTime < stop1 then
    self:_SetRemainingTime("_remainingTimePool", "", "str_n17_main_remaining_time", stop1, true)
  elseif curTime < stop2 then
    self:_SetRemainingTime("_remainingTimePool", "", "str_n17_main_remaining_time_2", stop2, false)
  end
end

function UIN17MainController:_SetIntroBtn()
  self._matReq = UIWidgetHelper.SetLocalizedTMPMaterial(self, "_introTitle", "UIN17_Material.mat", self._matReq)
end

function UIN17MainController:_SetReviewBtn()
end

function UIN17MainController:_SetTryoutBtn()
  local componentId = ECampaignN17ComponentID.ECAMPAIGN_N17_LEVEL_FIXTEAM
  local obj = UIWidgetHelper.SpawnObject(self, "_tryoutBtn", "UIActivityCommonComponentEnterLock")
  obj:SetRed("red", function()
    return self._campaign:GetLocalProcess():GetFixMissionRedDot()
  end)
  local component = self._campaign:GetComponent(componentId)
  obj:SetData(self._campaign, componentId, function()
    self:ShowDialog("UIActivityPetTryController", self._campaignType, componentId, function(mid)
      return component:IsPassCamMissionID(mid)
    end, function(missionid)
      local missionModule = self:GetModule(MissionModule)
      local ctx = missionModule:TeamCtx()
      local missionComponent = self._campaign:GetComponent(componentId)
      local param = {
        missionid,
        missionComponent:GetCampaignMissionComponentId(),
        missionComponent:GetCampaignMissionParamKeyMap()
      }
      ctx:Init(TeamOpenerType.Campaign, param)
      ctx:ShowDialogUITeams(false)
    end)
  end)
end

function UIN17MainController:_SetBattlePassBtn(bp_campaign)
  local widgetName = "_battlePassBtn"
  local className = "UIActivityCommonCampaignEnter"
  local useStateUI = false
  local open_sample = bp_campaign:CheckCampaignOpen()
  if open_sample then
    local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
    local obj = pool:SpawnObject(className)
    obj:SetData(bp_campaign, useStateUI)
  end
  local obj = self:GetGameObject(widgetName)
  obj:SetActive(open_sample)
end

function UIN17MainController:_SetLoginRewardBtn()
  local componentId = ECampaignN17ComponentID.ECAMPAIGN_N17_CUMULATIVE_LOGIN
  local obj = UIWidgetHelper.SpawnObject(self, "_loginRewardBtn", "UIActivityCommonComponentEnter")
  obj:SetRed("red", function()
    return self._campaign:GetLocalProcess():AccumulateLoginReddot()
  end)
  obj:SetData(self._campaign, function()
    self:ShowDialog("UIActivityTotalLoginAwardController", false, self._campaignType, componentId)
  end)
end

function UIN17MainController:_SetMiniGameBtn()
  local componentId = ECampaignN17ComponentID.ECAMPAIGN_N17_MINI_GAME
  local component = self._campaign:GetComponent(componentId)
  local obj = UIWidgetHelper.SpawnObject(self, "_miniGameBtn", "UIActivityCommonComponentEnterLock")
  obj:SetNew("_new", function()
    return self._campaign:GetLocalProcess():WeiSiExploreReddot()
  end)
  obj:SetRedCount("_redCount", "_redCountTxt", function()
    local primaryCount, seniorCount = HomelandFindTreasureConst.GetSingleCount()
    return seniorCount
  end)
  local unlockTime = component and component:ComponentUnLockTime() or 0
  obj:SetActivityCommonRemainingTime("_timePool_lock", "str_n17_minigame_remaining_time", unlockTime, true)
  local tb = {
    {"state_lock", "time_lock"},
    {"state_lock"},
    {
      "state_unlock"
    },
    {
      "state_close"
    }
  }
  obj:SetWidgetNameGroup(tb)
  obj:SetData(self._campaign, componentId, function()
    self:ShowDialog("UIFindTreasureDetail", true, ECampaignType.CAMPAIGN_TYPE_N17, ECampaignN17ComponentID.ECAMPAIGN_N17_MINI_GAME)
  end)
end

function UIN17MainController:_SetLotteryBtn()
  local componentId = ECampaignN17ComponentID.ECAMPAIGN_N17_LOTTERY
  local obj = UIWidgetHelper.SpawnObject(self, "_lotteryBtn", "UIActivityCommonComponentEnterLock")
  obj:SetNew("new", function()
    return self._campaign:GetLocalProcess():GetIntegratedCalculation()
  end)
  obj:SetRed("red", function()
    return self._campaign:GetLocalProcess():LotteryShopReddot()
  end)
  local component = self._campaign:GetComponent(componentId)
  local icon, count = component:GetLotteryCostItemIconText()
  UIN17LotteryController.SetLotteryIconText(obj, "icon", "text", icon, count)
  local tb = {
    {"Btn"},
    {"Btn"},
    {"Btn"},
    {"Btn_Close"}
  }
  obj:SetWidgetNameGroup(tb)
  obj:SetData(self._campaign, componentId, function()
    self._campaign._campaign_module:CampaignSwitchState(true, UIStateType.UIN17LotteryController, UIStateType.UIMain, nil, self._campaign._id)
  end)
end

function UIN17MainController:_SetDailyPlanBtn()
  local componentId = ECampaignN17ComponentID.ECAMPAIGN_N17_CYCLE_QUEST
  local obj = UIWidgetHelper.SpawnObject(self, "_dailyPlanBtn", "UIActivityCommonComponentEnterLock")
  obj:SetNew("new", function()
    return self._campaign:GetLocalProcess():GetPlanListRedDot()
  end)
  local tb = {
    {"Btn"},
    {"Btn"},
    {"Btn"},
    {"Btn_Close"}
  }
  obj:SetWidgetNameGroup(tb)
  obj:SetData(self._campaign, componentId, function()
    self:ShowDialog("UIN17DailyPlanController")
  end)
end

function UIN17MainController:ShowBtnOnClick(go)
  self:_ShowUI()
end

function UIN17MainController:IntroBtnOnClick(go)
  self:ShowDialog("UIN17IntroController", "UIN17IntroController_Main")
end

function UIN17MainController:ReviewBtnOnClick(go)
  local story_id = UIActivityHelper.GetCampaignFirstEnterStoryID(self._campaign, 1)
  self:ShowDialog("UIStoryController", story_id)
end

function UIN17MainController:_AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._Refresh)
end

function UIN17MainController:_DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  self:DetachEvent(GameEventType.AfterUILayerChanged, self._Refresh)
end

function UIN17MainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN17MainController:_GetRoleId()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local pstId = roleModule:GetPstId()
  return pstId
end

function UIN17MainController:_SetEffect()
  self:_SetMainTex()
end

function UIN17MainController:_SetMainTex()
  local rawImage = self:GetUIComponent("RawImage", "TitleImg_RawImage")
  local obj = self:GetGameObject("TitleImg")
  local meshRender = obj:GetComponent(typeof(UnityEngine.MeshRenderer))
  meshRender.material:SetTexture("_MainTex", rawImage.material:GetTexture("_MainTex"))
end

function UIN17MainController:_SetSpineEffect(widgetName)
end

function UIN17MainController:_HandelSpineMaterial(material)
end

function UIN17MainController:_HandelRawImageMaterial(widgetName)
end
