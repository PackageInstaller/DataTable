_class("UIActivityN29MainController", UIActivityMainBase)
UIActivityN29MainController = UIActivityN29MainController

function UIActivityN29MainController:OnInit()
  self._shopCountLabel = self:GetUIComponent("UILocalizationText", "ShopCount")
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self:RefreshActivityRemainTime()
  self:StartTask(self.PlayAnimEnterCoro, self)
end

function UIActivityN29MainController:OnUpdate(deltaTimeMS)
  self:RefreshActivityRemainTime()
end

function UIActivityN29MainController:RefreshActivityRemainTime()
  if self._activityConst:IsActivityEnd() then
    self._timeLabel:SetText(StringTable.Get("str_n29_activity_end"))
    return
  end
  local timeTips = ""
  local status, time = self._activityConst:GetComponentStatus(ECampaignN29ComponentID.ECAMPAIGN_N29_LINE_MISSION)
  if status == ActivityComponentStatus.Open then
    local timeStr = UIActivityCustomHelper.GetTimeString(time, "str_n29_day", "str_n29_hour", "str_n29_minus", "str_n29_less_one_minus")
    timeTips = StringTable.Get("str_n29_activity_remain_time", timeStr)
  else
    local endTime = self._activityConst:GetActiveEndTime()
    local nowTime = self._timeModule:GetServerTime() / 1000
    local seconds = math.floor(endTime - nowTime)
    if seconds <= 0 then
      seconds = 0
    end
    local timeStr = UIActivityCustomHelper.GetTimeString(seconds, "str_n29_day", "str_n29_hour", "str_n29_minus", "str_n29_less_one_minus")
    timeTips = StringTable.Get("str_n29_activity_get_reward_remain_time", timeStr)
  end
  self._timeLabel:SetText(timeTips)
end

function UIActivityN29MainController:OnRefresh()
  local com, comInfo
  com, comInfo = self._activityConst:GetComponent(ECampaignN29ComponentID.ECAMPAIGN_N29_LOTTERY)
  local icon, count = com:GetLotteryCostItemIconText()
  self._shopCountLabel:SetText(UIActivityCustomHelper.GetItemCountStr(7, count, "#2B2218", "#F2E6DA"))
end

function UIActivityN29MainController:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N29
end

function UIActivityN29MainController:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_FIRST_MEET
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_LINE_MISSION
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_LOTTERY
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_CHESS
  componentIds[#componentIds + 1] = ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE
  return componentIds
end

function UIActivityN29MainController:GetLoginComponentId()
  return ECampaignN29ComponentID.ECAMPAIGN_N29_CUMULATIVE_LOGIN
end

function UIActivityN29MainController:GetCustomTimeStr()
  return "str_n29_day", "str_n29_hour", "str_n29_minus", "str_n29_less_one_minus"
end

function UIActivityN29MainController:GetButtonStatusConfig()
  local configs = {}
  local normalLevel = {}
  normalLevel.Name = "Normal"
  normalLevel.ComponentId = ECampaignN29ComponentID.ECAMPAIGN_N29_LINE_MISSION
  normalLevel.CheckRedComponentIds = {
    ECampaignN29ComponentID.ECAMPAIGN_N29_FIRST_MEET
  }
  
  function normalLevel.Callback()
    self:ShowDialog("UIActivityN29LineLevel")
  end
  
  normalLevel.RemainTimeStr = "str_n29_activity_normal_level_remain_time"
  normalLevel.UnlockTimeStr = ""
  normalLevel.UnlockMissionStr = ""
  configs[#configs + 1] = normalLevel
  local hardLevel = {}
  hardLevel.Name = "Hard"
  hardLevel.ComponentId = ECampaignN29ComponentID.ECAMPAIGN_N29_DIFFICULT_MISSION
  hardLevel.CheckRedComponentIds = {
    ECampaignN29ComponentID.ECAMPAIGN_N29_BLACK_DIFFICULT_MISSION
  }
  
  function hardLevel.Callback()
    self:ShowDialog("UIActivityN29HardLevelMain")
  end
  
  hardLevel.RemainTimeStr = "str_n29_activity_hard_level_remain_time"
  hardLevel.UnlockTimeStr = "str_n29_activity_hard_level_lock_time_tips"
  hardLevel.UnlockMissionStr = "str_n29_activity_hard_level_lock_mission_tips"
  configs[#configs + 1] = hardLevel
  local chess = {}
  chess.Name = "ChessGame"
  chess.ComponentId = ECampaignN29ComponentID.ECAMPAIGN_N29_CHESS
  chess.CheckRedComponentIds = nil
  
  function chess.Callback()
    self:SwitchState("UIN29ChessController")
  end
  
  chess.RemainTimeStr = "str_n29_activity_chess_game_remain_time"
  chess.UnlockTimeStr = "str_n29_activity_chess_game_lock_time_tips"
  chess.UnlockMissionStr = "str_n29_activity_chess_game_lock_mission_tips"
  configs[#configs + 1] = chess
  local detective = {}
  detective.Name = "DetectiveGame"
  detective.ComponentId = ECampaignN29ComponentID.ECAMPAIGN_N29_DETECTIVE
  detective.CheckRedComponentIds = nil
  
  function detective.Callback()
    self:SwitchState(UIStateType.UIN29DetectiveLogin)
  end
  
  detective.RemainTimeStr = "str_n29_activity_detective_game_remain_time"
  detective.UnlockTimeStr = "str_n29_activity_detective_game_lock_time_tips"
  detective.UnlockMissionStr = "str_n29_activity_detective_game_lock_mission_tips"
  configs[#configs + 1] = detective
  local shop = {}
  shop.Name = "Shop"
  shop.ComponentId = ECampaignN29ComponentID.ECAMPAIGN_N29_LOTTERY
  shop.CheckRedComponentIds = nil
  
  function shop.Callback()
    self:SwitchState(UIStateType.UIN29Shop, cache_rt)
  end
  
  shop.RemainTimeStr = "str_n29_activity_shop_remain_time"
  shop.UnlockTimeStr = ""
  shop.UnlockMissionStr = ""
  configs[#configs + 1] = shop
  return configs
end

function UIActivityN29MainController:NormalLevelOnClick()
  self:ClickButton("Normal")
end

function UIActivityN29MainController:HardLevelOnClick()
  self:ClickButton("Hard")
end

function UIActivityN29MainController:ChessGameOnClick()
  self:ClickButton("ChessGame")
end

function UIActivityN29MainController:DetectiveGameOnClick()
  self:ClickButton("DetectiveGame")
end

function UIActivityN29MainController:ShopOnClick()
  self:ClickButton("Shop")
end

function UIActivityN29MainController:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN29MainController)
end

function UIActivityN29MainController:SetPanelStatus(TT, isShow)
  self._showBtn:SetActive(not isShow)
  if isShow then
    self._anim:Play("uieff_UIActivityN29MainController_chuxian")
  else
    self._anim:Play("uieff_UIActivityN29MainController_yincang")
  end
end

function UIActivityN29MainController:PlayAnimEnterCoro(TT)
  self:PlayPlot(function()
    self:Lock("UIActivityN29MainController_PlayAnimEnterCoro")
    local loader = self:GetUIComponent("RawImageLoader", "Loader")
    local loaderImg = self:GetUIComponent("RawImage", "Loader")
    local nameImg = "n29_kng_bg03"
    loader:LoadImage(nameImg)
    local mat = loaderImg.material
    local mainTex = mat:GetTexture("_MainTex")
    local quad = self:GetUIComponent("MeshRenderer", "Quad")
    local quadmat = quad.sharedMaterial
    if quadmat then
      quadmat:SetTexture("_MainTex", mainTex)
    end
    self._anim:Play("UIActivityN29MainController_in")
    YIELD(TT, 1700)
    self:CheckGuide()
    self:UnLock("UIActivityN29MainController_PlayAnimEnterCoro")
  end)
end

function UIActivityN29MainController:OnPlayPlot()
end
