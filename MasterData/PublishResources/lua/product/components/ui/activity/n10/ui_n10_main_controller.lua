_class("UIN10MainController", UIController)
UIN10MainController = UIN10MainController

function UIN10MainController:Constructor()
  self._componentState = {}
  self._button = {}
  self._showSpine = false
end

function UIN10MainController:LoadDataOnEnter(TT, res, uiParams)
  self._loginModule = self:GetModule(LoginModule)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N10, ECampaignN10ComponentID.ECAMPAIGN_N10_STORY, ECampaignN10ComponentID.ECAMPAIGN_N10_LOTTERY, ECampaignN10ComponentID.ECAMPAIGN_N10_LEVEL_FIXTEAM, ECampaignN10ComponentID.ECAMPAIGN_N10_CUMULATIVE_LOGIN)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return
  end
  self._cfg_campaign = Cfg.cfg_campaign[self._campaign._id]
  self._story_componentInfo = self._campaign:GetComponentInfo(ECampaignN10ComponentID.ECAMPAIGN_N10_STORY)
  self._battlePassCampaign = UIActivityCampaign:New()
  self._battlePassCampaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_BATTLEPASS)
  if res and not res:GetSucc() then
    self._campaignModule:CheckErrorCode(res.m_result, self._battlePassCampaign._id, nil, nil)
    return
  end
  self._localProcess = self._campaignModule:GetCampaignLocalProcess(ECampaignType.CAMPAIGN_TYPE_N10)
end

function UIN10MainController:_GetComponentState(componentid)
  return self._campaign:CheckComponentOpen(componentid)
end

function UIN10MainController:OnShow(uiParams)
  self._isOpen = true
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.AfterUILayerChanged)
  self:AttachEvent(GameEventType.ItemCountChanged, self._OnItemCountChanged)
  self:_GetComponents()
  self:_OnValue()
  self:RefreshTryout()
  self:_SetTimer()
end

function UIN10MainController:OnHide()
  self._isOpen = false
  self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
  if self._clearNewTask then
    GameGlobal.TaskManager():KillTask(self._clearNewTask)
    self._clearNewTask = nil
  end
end

function UIN10MainController:AfterUILayerChanged()
  self:_RefreshComponentState()
  self:_RefreshButtonState()
  self:_RefreshStoryBtnState()
  self:_CheckRedPointAll()
end

function UIN10MainController:_CheckCampaignClose()
  return not self._campaign:CheckCampaignOpen()
end

function UIN10MainController:_GetComponents()
  self._bg = self:GetGameObject("bg")
  self._backBtn = self:GetUIComponent("UISelectObjectPath", "BackBtn")
  self._commonTopBtn = self._backBtn:SpawnObject("UICommonTopButton")
  self._commonTopBtn:SetData(function()
    self:_Close()
  end, nil, nil, false, function()
    if not self._showSpine then
      self:_ShowBgSpine(true, "uieff_Main_Hide")
    end
  end)
  self._remainTime = self:GetUIComponent("UILocalizationText", "RemainTime")
  self._moneyValue = self:GetUIComponent("UILocalizationText", "MoneyValue")
  self._petRedPoint = self:GetGameObject("PetRedPoint")
  self._shopRedPoint = self:GetGameObject("ShopRedPoint")
  self._loginAwardRedPoint = self:GetGameObject("LoginAwardRedPoint")
  self._battlePassBtnRedPoint = self:GetGameObject("BattlePassBtnRedPoint")
  self._activityIntroBtn = self:GetGameObject("ActivityIntroBtn")
  self._storyBtn = self:GetGameObject("StoryBtn")
  self._storyBtnRedpoint = self:GetGameObject("StoryBtnRedPoint")
  self._button[ECampaignN10ComponentID.ECAMPAIGN_N10_LOTTERY] = self:GetUIComponent("Button", "ShopBtn")
  self._button[ECampaignN10ComponentID.ECAMPAIGN_N10_LEVEL_FIXTEAM] = self:GetUIComponent("Button", "PetBtn")
  self._button[ECampaignN10ComponentID.ECAMPAIGN_N10_CUMULATIVE_LOGIN] = self:GetUIComponent("Button", "LoginAwardBtn")
  self._activityName = self:GetUIComponent("MaskableGraphic", "ActivityName")
  self._activityNameFakeRawImage = self:GetUIComponent("RawImage", "ActivityNameFake")
  self._activityName.materialForRendering:SetTexture("_MainTex", self._activityNameFakeRawImage.mainTexture)
  self._animation = self:GetUIComponent("Animation", "Animation")
end

function UIN10MainController:_OnValue()
  self:_RefreshMoney()
  self:_PlayStory()
end

function UIN10MainController:_OnItemCountChanged()
  self:_RefreshMoney()
end

function UIN10MainController:_RefreshMoney()
  if self._campaign then
    local lotteryComponentInfo = self._campaign:GetComponentInfo(ECampaignN10ComponentID.ECAMPAIGN_N10_LOTTERY)
    if lotteryComponentInfo then
      local curCount = ClientCampaignDrawShop.GetMoney(lotteryComponentInfo.m_cost_item_id)
      self._moneyValue:SetText(curCount)
    end
  end
end

function UIN10MainController:_RefreshComponentState()
  self._componentState[ECampaignN10ComponentID.ECAMPAIGN_N10_STORY] = self:_GetComponentState(ECampaignN10ComponentID.ECAMPAIGN_N10_STORY)
  self._componentState[ECampaignN10ComponentID.ECAMPAIGN_N10_LOTTERY] = self:_GetComponentState(ECampaignN10ComponentID.ECAMPAIGN_N10_LOTTERY)
  self._componentState[ECampaignN10ComponentID.ECAMPAIGN_N10_LEVEL_FIXTEAM] = self:_GetComponentState(ECampaignN10ComponentID.ECAMPAIGN_N10_LEVEL_FIXTEAM)
  self._componentState[ECampaignN10ComponentID.ECAMPAIGN_N10_CUMULATIVE_LOGIN] = self:_GetComponentState(ECampaignN10ComponentID.ECAMPAIGN_N10_CUMULATIVE_LOGIN)
end

function UIN10MainController:_RefreshButtonState()
  for key, value in pairs(self._button) do
    value.interactable = self._componentState[key]
  end
end

function UIN10MainController:_CheckRedPointAll()
  self._petRedPoint:SetActive(self._localProcess:PetStageRedPoint())
  self._shopRedPoint:SetActive(self._localProcess:ShopRedPoint())
  self._loginAwardRedPoint:SetActive(self._localProcess:LoginRewardRedPoint())
  self._battlePassBtnRedPoint:SetActive(self._localProcess:BattlePassRedPoint(self._battlePassCampaign))
  self._storyBtnRedpoint:SetActive(self._localProcess:CampaignEndStoryRedpoint())
end

function UIN10MainController:_Close()
  self:SwitchState(UIStateType.UIMain)
end

function UIN10MainController:_ShowActivityIntro(show)
  self._activityIntroBtn:SetActive(show)
end

function UIN10MainController:_SetRemainTime(pre_remaining, remaintime)
  self._remainTime:SetText(pre_remaining .. self:_GetRemainTime(remaintime))
end

function UIN10MainController:_SetTimer()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    return self:_SetRemainingTimer()
  end)
end

function UIN10MainController:_SetRemainingTimer()
  if not self._isOpen then
    return
  end
  local remaintime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local endtime = self._campaign:GetSample().end_time
  if self._story_componentInfo then
    remaintime = self._story_componentInfo.m_end_date_time - curtime
  end
  self:_ShowActivityIntro(0 < endtime - curtime)
  local pre_remaining = ""
  if 0 < remaintime then
    pre_remaining = StringTable.Get("str_n10_drop_time")
  else
    local sample = self._campaign:GetSample()
    remaintime = sample and sample.end_time - curtime or 0
    pre_remaining = StringTable.Get("str_n10_activity_remaining_time")
  end
  self:_SetRemainTime(pre_remaining, remaintime)
  if remaintime <= 0 then
    self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
    return true
  end
end

function UIN10MainController:_GetRemainTime(time)
  local day, hour, minute
  day = math.floor(time / 86400)
  hour = math.floor(time / 3600) % 24
  minute = math.floor(time / 60) % 60
  local timestring = ""
  if 0 < day then
    timestring = day .. StringTable.Get("str_activity_common_day") .. hour .. StringTable.Get("str_activity_common_hour")
  elseif 0 < hour then
    timestring = hour .. StringTable.Get("str_activity_common_hour") .. minute .. StringTable.Get("str_activity_common_minute")
  elseif 0 < minute then
    timestring = minute .. StringTable.Get("str_activity_common_minute")
  else
    timestring = StringTable.Get("str_activity_common_less_minute")
  end
  return string.format(StringTable.Get("str_activity_common_over"), timestring)
end

function UIN10MainController:_PlayStory()
  if not self._campaign:GetSample():GetStepStatus(ECampaignStep.CAMPAIGN_STEP_NEW) then
    return
  end
  if self._cfg_campaign ~= nil then
    if self._cfg_campaign.FirstEnterStoryID ~= nil and self._cfg_campaign.FirstEnterStoryID[1] ~= nil then
      GameGlobal.GetModule(StoryModule):StartStory(self._cfg_campaign.FirstEnterStoryID[1], function()
        self._clearNewTask = self:StartTask(function(TT)
          local res = AsyncRequestRes:New()
          GameGlobal.GetModule(CampaignModule):CampaignClearNewFlag(TT, res, self._campaign._id)
          if res:GetSucc() then
            Log.info("n10 play first enter story succ.")
            self:_CheckGuide()
          end
        end, self)
      end, true)
    else
      self._clearNewTask = self:StartTask(function(TT)
        local res = AsyncRequestRes:New()
        GameGlobal.GetModule(CampaignModule):CampaignClearNewFlag(TT, res, self._campaign._id)
        if res:GetSucc() then
          self:_CheckGuide()
          Log.info("n10 play first enter story succ.")
        end
      end, self)
    end
  end
end

function UIN10MainController:_ShowBgSpine(showSpine, animationName)
  self._showSpine = showSpine
  self._animation:Play(animationName)
end

function UIN10MainController:ActivityIntroBtnOnClick(go)
  self:ShowDialog("UIN10IntroController", "UIN10MainController")
end

function UIN10MainController:StoryRePlayBtnOnClick(go)
  if self._cfg_campaign ~= nil and self._cfg_campaign.FirstEnterStoryID ~= nil and self._cfg_campaign.FirstEnterStoryID[1] ~= nil then
    GameGlobal.GetModule(StoryModule):StartStory(self._cfg_campaign.FirstEnterStoryID[1], function()
      self:_PlayAnimationIn2()
    end, true)
  end
end

function UIN10MainController:RefreshTryout()
  local cmpInfo = self._campaign:GetComponentInfo(ECampaignN10ComponentID.ECAMPAIGN_N10_LEVEL_FIXTEAM)
  local passInfo = cmpInfo.m_pass_mission_info or {}
  
  function self._isTryoutLevelPass(mid)
    return passInfo[mid] ~= nil
  end
end

function UIN10MainController:PetBtnOnClick(go)
  if not self._componentState[ECampaignN10ComponentID.ECAMPAIGN_N10_LEVEL_FIXTEAM] then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  self:ShowDialog("UIActivityPetTryPlusController", ECampaignType.CAMPAIGN_TYPE_N10, ECampaignN10ComponentID.ECAMPAIGN_N10_LEVEL_FIXTEAM, self._isTryoutLevelPass, function(missionid)
    local missionModule = self:GetModule(MissionModule)
    local ctx = missionModule:TeamCtx()
    local localProcess = self._campaign:GetLocalProcess()
    local missionComponent = localProcess:GetComponent(ECampaignN10ComponentID.ECAMPAIGN_N10_LEVEL_FIXTEAM)
    local param = {
      missionid,
      missionComponent:GetCampaignMissionComponentId(),
      missionComponent:GetCampaignMissionParamKeyMap()
    }
    ctx:Init(TeamOpenerType.Campaign, param)
    ctx:ShowDialogUITeams(false)
  end)
end

function UIN10MainController:ShopBtnOnClick(go)
  if not self._componentState[ECampaignN10ComponentID.ECAMPAIGN_N10_LOTTERY] then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  self:ShowDialog("UIN10ShopController", function()
    self:_PlayAnimationIn2()
  end)
end

function UIN10MainController:BattlePassBtnOnClick(go)
  UIActivityBattlePassHelper.OpenMainController(function()
    self:_PlayAnimationIn2()
  end)
end

function UIN10MainController:LoginAwardBtnOnClick(go)
  if not self._componentState[ECampaignN10ComponentID.ECAMPAIGN_N10_CUMULATIVE_LOGIN] then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  self:ShowDialog("UIN10TotalLoginAwardController", true, ECampaignType.CAMPAIGN_TYPE_N10, ECampaignN10ComponentID.ECAMPAIGN_N10_CUMULATIVE_LOGIN)
end

function UIN10MainController:BgOnClick(go)
  if self._showSpine then
    self:_ShowBgSpine(false, "uieff_Main_Show")
  end
end

function UIN10MainController:StoryBtnOnClick()
  local cfg = Cfg.cfg_n10_campaign_end_story()
  GameGlobal.GetModule(StoryModule):StartStory(cfg[1].StoryID, function()
    LocalDB.SetInt("N10CampaignEndStory" .. self._loginModule:GetRoleShowID(), 1)
    self:_PlayAnimationIn2()
    self:_CheckRedPointAll()
  end, true)
end

function UIN10MainController:_RefreshStoryBtnState()
  self._storyBtn:SetActive(self:_GetCampaignEndStoryBtnState())
end

function UIN10MainController:_GetCampaignEndStoryBtnState()
  local cfg = Cfg.cfg_n10_campaign_end_story()
  if not cfg or not cfg[1] then
    return false
  end
  local endTime = self._loginModule:GetTimeStampByTimeStr(cfg[1].OpenTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local nowTime = self._svrTimeModule:GetServerTime() * 0.001
  return endTime <= nowTime
end

function UIN10MainController:_PlayAnimationIn2()
  self._animation:Play("uieff_Main_In2")
end

function UIN10MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIN10MainController)
end
