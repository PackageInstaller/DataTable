_class("UIActivityN24MainController", UIController)
UIActivityN24MainController = UIActivityN24MainController

function UIActivityN24MainController:LoadDataOnEnter(TT, res, uiParams)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._activityConst = UIActivityN24Const:New()
  self._activityConst:LoadData(TT, res)
  if res and not res:GetSucc() then
    local campModule = GameGlobal.GetModule(CampaignModule)
    campModule:CheckErrorCode(res.m_result, self._activityConst:GetCampaignId(), nil, nil)
  end
end

function UIActivityN24MainController:OnShow()
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._eventRed = self:GetGameObject("EventRed")
  self._loginRed = self:GetGameObject("LoginRed")
  self._petRed = self:GetGameObject("PetRed")
  self._fishRed = self:GetGameObject("FishRed")
  self._shopRed = self:GetGameObject("ShopRed")
  self._fishNew = self:GetGameObject("FishNew")
  self._fishLock = self:GetGameObject("FishLock")
  self._fishLockTipsPanel = self:GetGameObject("FishLockTipsPanel")
  self._fishLockTipsLabel = self:GetUIComponent("UILocalizationText", "FishLockTips")
  self._shopIconLoader = self:GetUIComponent("RawImageLoader", "ShopIcon")
  self._shopCountLabel = self:GetUIComponent("UILocalizationText", "ShopCount")
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._btnPanel = self:GetGameObject("BtnPanel")
  self._showBtn = self:GetGameObject("ShowBtn")
  self._showBtn:SetActive(false)
  self._topBtn = self:GetGameObject("TopBtn")
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end, nil, nil, false, function()
    self:SetButtonShowStatus(false)
  end)
  self:AttachEvent(GameEventType.OnActivityTotalAwardGot, self.ForceUpdate)
  self:AttachEvent(GameEventType.CampaignComponentStepChange, self.ForceUpdate)
  self:InitUI()
  UIActivityN24Const.ClearEnterNewStatus()
  self:StartTask(function(TT)
    local lockName = "UIActivityN25CheckGuide"
    self:Lock(localName)
    YIELD(TT, 500)
    self:UnLock(lockName)
    self:CheckGuide()
  end)
  self._anim = self:GetUIComponent("Animation", "Anim")
end

function UIActivityN24MainController:OnHide()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  self:DetachEvent(GameEventType.OnActivityTotalAwardGot, self.ForceUpdate)
  self:DetachEvent(GameEventType.CampaignComponentStepChange, self.ForceUpdate)
end

function UIActivityN24MainController:OnUpdate(deltaTimeMS)
  self:RefreshUI()
end

function UIActivityN24MainController:CloseCoro(TT)
  self:Lock("UIActivityN21CCMainController_CloseCoro")
  self:SwitchState(UIStateType.UIMain)
  self:UnLock("UIActivityN21CCMainController_CloseCoro")
end

function UIActivityN24MainController:SetButtonShowStatus(isShow)
  if isShow then
    self._anim:Play("uieffanim_UIActivityN24MainController_in2")
  else
    self._anim:Play("uieffanim_UIActivityN24MainController_middle")
  end
  self._showBtn:SetActive(not isShow)
end

function UIActivityN24MainController:PlayEnterAnim()
  self:StartTask(self.PlayEnterAnimCoro, self)
end

function UIActivityN24MainController:PlayEnterAnimCoro(TT)
  self:Lock("UIActivityN24MainController_PlayEnterAnimCoro")
  self:UnLock("UIActivityN24MainController_PlayEnterAnimCoro")
end

function UIActivityN24MainController:InitUI()
  self._fishNew:SetActive(self._activityConst:IsShowHomelandTaskNew())
  self:RefreshShopBtnStatus()
  self:RefreshUI()
  self:RefreshRedAndNew()
  self:PlayEnterAnim()
  self:RefreshButtonStatus()
end

function UIActivityN24MainController:RefreshUI()
  self:RefreshActivityRemainTime()
  self:RefreshButtonStatus()
end

function UIActivityN24MainController:RefreshButtonStatus()
  if self._activityConst:IsHomelandTaskEnable() then
    self._fishLock:SetActive(false)
    self._fishLockTipsPanel:SetActive(false)
  else
    self._fishLock:SetActive(true)
    self._fishLockTipsPanel:SetActive(true)
    if self._activityConst:IsHomelandTaskEnd() then
      self._fishLockTipsLabel:SetText(StringTable.Get("str_n24_activity_end"))
    else
      self._fishLockTipsLabel:SetText(UIActivityN24Const.GetTimeString(self._activityConst:GetHomelandRemaindOpenSeconds()))
    end
  end
end

function UIActivityN24MainController:RefreshShopBtnStatus()
  local com, comInfo = self._activityConst:GetShopComponent()
  local itemId = comInfo.m_cost_item_id
  local count = ClientCampaignDrawShop.GetMoney(itemId)
  local cfgItem = Cfg.cfg_item[itemId]
  self._shopIconLoader:LoadImage(cfgItem.Icon)
  self._shopCountLabel:SetText(UIActivityN24Const.GetItemCountStr(count, "#DD4D1", "#D9BF68"))
end

function UIActivityN24MainController:RefreshActivityRemainTime()
  local endTime = self._activityConst:GetActiveEndTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  if seconds <= 0 then
    seconds = 0
  end
  if self._activityConst:IsActivityEnd() then
    self._timeLabel:SetText(StringTable.Get("str_n24_activity_end"))
    return
  end
  local status = self._activityConst:GetStatus()
  if seconds == 0 and status == 1 then
    self._activityConst:SetStatus(2)
    return
  end
  local timeStr = UIActivityN24Const.GetTimeString(seconds)
  local timeTips = ""
  local status = self._activityConst:GetStatus()
  if status == 1 then
    timeTips = StringTable.Get("str_n24_activity_remain_time", timeStr)
  elseif status == 2 then
    timeTips = StringTable.Get("str_n24_activity_remain_get_reward_time", timeStr)
  end
  self._timeLabel:SetText(timeTips)
end

function UIActivityN24MainController:RefreshRedAndNew()
  self._eventRed:SetActive(self._activityConst:IsShowBattlePassRed())
  self._loginRed:SetActive(self._activityConst:IsShowLoginRed())
  self._petRed:SetActive(self._activityConst:IsShowTryPetRed())
  self._fishRed:SetActive(self._activityConst:IsShowHomelandTaskRed())
  self._shopRed:SetActive(self._activityConst:IsShowShopRed())
end

function UIActivityN24MainController:ForceUpdate()
  self:StartTask(self.ReLoadData, self)
end

function UIActivityN24MainController:ReLoadData(TT)
  self:Lock("UIActivityN24MainController_ReLoadData")
  local res = AsyncRequestRes:New()
  res:SetSucc(true)
  self._activityConst:LoadData(TT, res)
  self:RefreshRedAndNew()
  self:RefreshShopBtnStatus()
  self:UnLock("UIActivityN24MainController_ReLoadData")
end

function UIActivityN24MainController:ShowBtnOnClick()
  self:SetButtonShowStatus(true)
end

function UIActivityN24MainController:EventOnClick()
  UIActivityBattlePassHelper.OpenMainController()
end

function UIActivityN24MainController:LoginOnClick()
  if not self._activityConst:IsLoginEnable() then
    ToastManager.ShowToast(StringTable.Get("str_n24_activity_end"))
    return
  end
  self:ShowDialog("UIActivityTotalLoginAwardController", false, ECampaignType.CAMPAIGN_TYPE_N24, ECampaignN24ComponentID.ECAMPAIGN_N24_CUMULATIVE_LOGIN)
end

function UIActivityN24MainController:PetOnClick()
  if not self._activityConst:IsTryPetEnable() then
    ToastManager.ShowToast(StringTable.Get("str_n24_activity_end"))
    return
  end
  local com, comInfo = self._activityConst:GetTryPetComponent()
  local passInfo = comInfo.m_pass_mission_info or {}
  
  local function isTryoutLevelPass(mid)
    return passInfo[mid] ~= nil
  end
  
  local missionModule = self:GetModule(MissionModule)
  self:ShowDialog("UIActivityPetTryController", ECampaignType.CAMPAIGN_TYPE_N24, ECampaignN24ComponentID.ECAMPAIGN_N24_FIRST_MEET, isTryoutLevelPass, function(missionid)
    local ctx = missionModule:TeamCtx()
    local param = {
      missionid,
      com:GetCampaignMissionComponentId(),
      com:GetCampaignMissionParamKeyMap()
    }
    ctx:Init(TeamOpenerType.Campaign, param)
    ctx:ShowDialogUITeams(false)
  end)
end

function UIActivityN24MainController:FishOnClick()
  if not self._activityConst:IsHomelandTaskEnable() then
    if self._activityConst:IsHomelandTaskEnd() then
      ToastManager.ShowToast(StringTable.Get("str_n24_activity_end"))
    else
      local str = StringTable.Get("str_n24_open_tips", UIActivityN24Const.GetTimeString(self._activityConst:GetHomelandRemaindOpenSeconds()))
      ToastManager.ShowToast(str)
    end
    return
  end
  self:ShowDialog("UIHomelandStoryTaskSimpleController", 1, ECampaignType.CAMPAIGN_TYPE_N24, ECampaignN24ComponentID.ECAMPAIGN_N24_PANGOLIN)
  UIActivityN24Const.ClearHomelandTaskNewStatus()
  self._fishNew:SetActive(false)
end

function UIActivityN24MainController:ShopOnClick()
  if not self._activityConst:IsShopEnable() then
    ToastManager.ShowToast(StringTable.Get("str_n24_activity_end"))
    return
  end
  UIActivityHelper.Snap(self._shot, self:GetUIComponent("RectTransform", "SafeArea").rect.size, GameGlobal.UIStateManager():GetControllerCamera(self:GetName()), function(cache_rt)
    self:SwitchState(UIStateType.UIN24Shop, cache_rt)
  end)
end

function UIActivityN24MainController:InfoBtnOnClick()
  self:ShowDialog("UIIntroLoader", "UIN24Intro")
end

function UIActivityN24MainController:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN24MainController)
end
