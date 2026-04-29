_class("UIActivityN33MainController", UIActivityMainBase)
UIActivityN33MainController = UIActivityN33MainController

function UIActivityN33MainController:OnInit()
  self._shopCountLabel = self:GetUIComponent("UILocalizationText", "ShopCount")
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._receive = self:GetGameObject("Receive")
  self._story = self:GetGameObject("Story")
  self:RefreshActivityRemainTime()
  self:StartTask(self.PlayAnimEnterCoro, self)
end

function UIActivityN33MainController:OnUpdate(deltaTimeMS)
  self:RefreshActivityRemainTime()
  local isNew, canReceive, storyNum = UIActivityN33DateHelper.GetDateStatus(self._activityConst:GetCampaign())
  self._receive:SetActive(canReceive)
  if 0 < storyNum then
    local storyCountLabel = self:GetUIComponent("UILocalizationText", "StoryCount")
    storyCountLabel:SetText(storyNum .. "")
    self._story:SetActive(true)
  else
    self._story:SetActive(false)
  end
end

function UIActivityN33MainController:RefreshActivityRemainTime()
  if self._activityConst:IsActivityEnd() then
    self._timeLabel:SetText(StringTable.Get("str_n33_activity_end"))
    return
  end
  local status, endTime = self._activityConst:GetComponentStatus(ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION)
  local tipsStr = ""
  if status == ActivityComponentStatus.Open then
    tipsStr = "str_n33_activity_remain_time"
  else
    local nowTime = self._timeModule:GetServerTime() / 1000
    endTime = math.floor(self._activityConst:GetActiveEndTime() - nowTime)
    tipsStr = "str_n33_activity_exchange_remain_time"
  end
  local seconds = endTime
  if seconds <= 0 then
    seconds = 0
  end
  local timeStr = UIActivityCustomHelper.GetTimeString(seconds, "str_n33_day", "str_n33_hour", "str_n33_minus", "str_n33_less_one_minus")
  local timeTips = StringTable.Get(tipsStr, timeStr)
  self._timeLabel:SetText(timeTips)
end

function UIActivityN33MainController:OnRefresh()
  local com, comInfo
  com, comInfo = self._activityConst:GetComponent(ECampaignN33ComponentID.ECAMPAIGN_N33_LOTTERY)
  local icon, count = com:GetLotteryCostItemIconText()
  if 9999999 < count then
    count = 9999999
  end
  self._shopCountLabel:SetText(UIActivityCustomHelper.GetItemCountStr(7, count, "#BABDA3", "#C6DB2A"))
  local isNew, canReceive, storyNum = UIActivityN33DateHelper.GetDateStatus(self._activityConst:GetCampaign())
  local receive = self:GetGameObject("Receive")
  receive:SetActive(canReceive)
  local story = self:GetGameObject("Story")
  if 0 < storyNum then
    local storyCountLabel = self:GetUIComponent("UILocalizationText", "StoryCount")
    storyCountLabel:SetText(storyNum .. "")
    story:SetActive(true)
  else
    story:SetActive(false)
  end
end

function UIActivityN33MainController:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N33
end

function UIActivityN33MainController:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_LOTTERY
  componentIds[#componentIds + 1] = ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION
  return componentIds
end

function UIActivityN33MainController:GetLoginComponentId()
  return ECampaignN33ComponentID.ECAMPAIGN_N33_CUMULATIVE_LOGIN
end

function UIActivityN33MainController:GetCustomTimeStr()
  return "str_n33_day", "str_n33_hour", "str_n33_minus", "str_n33_less_one_minus"
end

function UIActivityN33MainController:GetButtonStatusConfig()
  local configs = {}
  local normalLevel = {}
  normalLevel.Name = "NormalLevel"
  normalLevel.ComponentId = ECampaignN33ComponentID.ECAMPAIGN_N33_LINE_MISSION
  normalLevel.CheckRedComponentIds = nil
  
  function normalLevel.Callback()
    self:ShowDialog("UIActivityN33LevelController", 1, true)
  end
  
  normalLevel.RemainTimeStr = "str_n33_activity_normal_level_remain_time"
  normalLevel.UnlockTimeStr = "str_n33_activity_normal_level_lock_time_tips"
  normalLevel.UnlockMissionStr = "str_n33_activity_normal_level_lock_mission_tips"
  configs[#configs + 1] = normalLevel
  local hardLevel = {}
  hardLevel.Name = "HardLevel"
  hardLevel.ComponentId = ECampaignN33ComponentID.ECAMPAIGN_N33_DIFFICULT_MISSION
  hardLevel.CheckRedComponentIds = nil
  
  function hardLevel.Callback()
    self:ShowDialog("UIActivityN33LevelController", 2, true)
  end
  
  hardLevel.RemainTimeStr = "str_n33_activity_hard_level_remain_time"
  hardLevel.UnlockTimeStr = "str_n33_activity_hard_level_lock_time_tips"
  hardLevel.UnlockMissionStr = "str_n33_activity_hard_level_lock_mission_tips"
  configs[#configs + 1] = hardLevel
  local shop = {}
  shop.Name = "Shop"
  shop.ComponentId = ECampaignN33ComponentID.ECAMPAIGN_N33_LOTTERY
  shop.CheckRedComponentIds = nil
  
  function shop.Callback()
    self:SwitchState(UIStateType.UIN33ShopController)
  end
  
  shop.RemainTimeStr = "str_n33_activity_shop_remain_time"
  shop.UnlockTimeStr = "str_n33_activity_shop_lock_time_tips"
  shop.UnlockMissionStr = "str_n33_activity_shop_lock_mission_tips"
  configs[#configs + 1] = shop
  local game = {}
  game.Name = "Game"
  game.ComponentId = ECampaignN33ComponentID.ECAMPAIGN_N33_SIMULATION_OPERATION
  game.CheckRedComponentIds = nil
  
  function game.Callback()
    self:ShowDialog("UIActivityN33DateMainController")
  end
  
  game.RemainTimeStr = "str_n33_activity_game_remain_time"
  game.UnlockTimeStr = "str_n33_activity_game_lock_time_tips"
  game.UnlockMissionStr = "str_n33_activity_game_lock_mission_tips"
  configs[#configs + 1] = game
  return configs
end

function UIActivityN33MainController:NormalLevelOnClick()
  self:ClickButton("NormalLevel")
end

function UIActivityN33MainController:HardLevelOnClick()
  self:ClickButton("HardLevel")
end

function UIActivityN33MainController:GameOnClick()
  self:ClickButton("Game")
end

function UIActivityN33MainController:ShopOnClick()
  self:ClickButton("Shop")
end

function UIActivityN33MainController:PlotOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIStoryController", self._activityConst:GetPlotId())
end

function UIActivityN33MainController:SetPanelStatus(TT, isShow)
  self._showBtn:SetActive(not isShow)
  if self._anim then
    if isShow then
      self._anim:Play("uieff_UIActivityN33MainController_Show")
    else
      self._anim:Play("uieff_UIActivityN33MainController_Hide")
    end
  else
    self._showBtn:SetActive(not isShow)
    self._btnPanel:SetActive(isShow)
  end
end

function UIActivityN33MainController:PlayAnimEnterCoro(TT)
  self:Lock("UIActivityN30MainController_PlayAnimEnterCoro")
  self:UnLock("UIActivityN30MainController_PlayAnimEnterCoro")
  self:CheckGuide()
end

function UIActivityN33MainController:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN33MainController)
end
