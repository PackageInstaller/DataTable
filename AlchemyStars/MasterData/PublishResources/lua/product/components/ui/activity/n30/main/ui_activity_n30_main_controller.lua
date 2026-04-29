_class("UIActivityN30MainController", UIActivityMainBase)
UIActivityN30MainController = UIActivityN30MainController

function UIActivityN30MainController:LoadDataOnEnter(TT, res, uiParams)
  EntrustComponent:HookClientData(109301805, UIN30Entrust.RefreshClientData)
  UIActivityMainBase.LoadDataOnEnter(self, TT, res, uiParams)
end

function UIActivityN30MainController:OnInit()
  CutsceneManager.ExcuteCutsceneOut()
  self._missionModule = self:GetModule(MissionModule)
  self._shopCountLabel = self:GetUIComponent("UILocalizationText", "ShopCount")
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self:RefreshActivityRemainTime()
  self:StartTask(self.PlayAnimEnterCoro, self)
end

function UIActivityN30MainController:OnUpdate(deltaTimeMS)
  self:RefreshActivityRemainTime()
end

function UIActivityN30MainController:RefreshActivityRemainTime()
  if self._activityConst:IsActivityEnd() then
    self._timeLabel:SetText(StringTable.Get("str_n30_activity_end"))
    return
  end
  local endTime = self._activityConst:GetActiveEndTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  if seconds <= 0 then
    seconds = 0
  end
  local timeStr = UIActivityCustomHelper.GetTimeString(seconds, "str_n30_day", "str_n30_hour", "str_n30_minus", "str_n30_less_one_minus")
  local timeTips = StringTable.Get("str_n30_activity_remain_time", timeStr)
  self._timeLabel:SetText(timeTips)
end

function UIActivityN30MainController:OnRefresh()
  local com, comInfo
  com, comInfo = self._activityConst:GetComponent(ECampaignN30ComponentID.ECAMPAIGN_N30_LOTTERY)
  local icon, count = com:GetLotteryCostItemIconText()
  if 9999999 < count then
    count = 9999999
  end
  self._shopCountLabel:SetText(UIActivityCustomHelper.GetItemCountStr(7, count, "#74634F", "#F6ECD5"))
end

function UIActivityN30MainController:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N30
end

function UIActivityN30MainController:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_FIRST_MEET
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_LOTTERY
  componentIds[#componentIds + 1] = ECampaignN30ComponentID.ECAMPAIGN_N30_ENTRUST
  return componentIds
end

function UIActivityN30MainController:GetLoginComponentId()
  return ECampaignN30ComponentID.ECAMPAIGN_N30_CUMULATIVE_LOGIN
end

function UIActivityN30MainController:GetCustomTimeStr()
  return "str_n30_day", "str_n30_hour", "str_n30_minus", "str_n30_less_one_minus"
end

function UIActivityN30MainController:GetButtonStatusConfig()
  local configs = {}
  local shop = {}
  shop.Name = "Shop"
  shop.ComponentId = ECampaignN30ComponentID.ECAMPAIGN_N30_LOTTERY
  shop.CheckRedComponentIds = nil
  
  function shop.Callback()
    Log.error("直接打开商店，不需要判断组件是否开启")
  end
  
  shop.RemainTimeStr = "str_n30_activity_shop_remain_time"
  shop.UnlockTimeStr = ""
  shop.UnlockMissionStr = ""
  configs[#configs + 1] = shop
  local normalLevel = {}
  normalLevel.Name = "Game"
  normalLevel.ComponentId = ECampaignN30ComponentID.ECAMPAIGN_N30_ENTRUST
  normalLevel.CheckRedComponentIds = nil
  
  function normalLevel.Callback()
    self:SwitchState(UIStateType.UIN30Entrust)
  end
  
  normalLevel.RemainTimeStr = "str_n30_activity_game_remain_time"
  normalLevel.UnlockTimeStr = "str_n30_activity_game_lock_time_tips"
  normalLevel.UnlockMissionStr = "str_n30_activity_game_lock_mission_tips"
  configs[#configs + 1] = normalLevel
  return configs
end

function UIActivityN30MainController:GameOnClick()
  self:ClickButton("Game")
end

function UIActivityN30MainController:ShopOnClick()
  self:ClickButton("Shop")
  self:ShowDialog(UIStateType.UIN30ShopController)
end

function UIActivityN30MainController:ShowTryout()
  local campaign = self._activityConst:GetCampaign()
  self:ShowDialog("UIActivityPetTryController", ECampaignType.CAMPAIGN_TYPE_N30, ECampaignN30ComponentID.ECAMPAIGN_N30_FIRST_MEET, function(mid)
    local com, compInfo = self._activityConst:GetComponent(ECampaignN30ComponentID.ECAMPAIGN_N30_FIRST_MEET)
    local passInfo = compInfo.m_pass_mission_info or {}
    return passInfo[mid] ~= nil
  end, function(missionid)
    local ctx = self._missionModule:TeamCtx()
    local localProcess = campaign:GetLocalProcess()
    local missionComponent = localProcess:GetComponent(ECampaignN30ComponentID.ECAMPAIGN_N30_FIRST_MEET)
    local param = {
      missionid,
      missionComponent:GetCampaignMissionComponentId(),
      missionComponent:GetCampaignMissionParamKeyMap()
    }
    ctx:Init(TeamOpenerType.Campaign, param)
    ctx:ShowDialogUITeams(false)
  end)
end

function UIActivityN30MainController:SetPanelStatus(TT, isShow)
  self._showBtn:SetActive(not isShow)
  if isShow then
    self._anim:Play("uieff_UIActivityN30MainController_Show")
  else
    self._anim:Play("uieff_UIActivityN30MainController_Hide")
  end
end

function UIActivityN30MainController:PlayAnimEnterCoro(TT)
  self:Lock("UIActivityN30MainController_PlayAnimEnterCoro")
  YIELD(TT, 500)
  self:UnLock("UIActivityN30MainController_PlayAnimEnterCoro")
  self:CheckGuide()
end

function UIActivityN30MainController:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN30MainController)
end
