require("ui_activity_main_base")
_class("UIActivityCN6N35MainController", UIActivityMainBase)
UIActivityCN6N35MainController = UIActivityCN6N35MainController

function UIActivityCN6N35MainController:InitTopButton()
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtn = btns:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end, nil, nil, false, function()
    GameGlobal.TaskManager():StartTask(self.SetButtonShowStatusCoro, self, false)
  end)
end

function UIActivityCN6N35MainController:OnInit()
  self._playing = AudioHelperController.GetCurrentBgm()
  AudioHelperController.PlayBGM(CriAudioIDConst.BGMCN6N35)
  self._shopCountLabel = self:GetUIComponent("UILocalizationText", "ShopCount")
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self._rawImageLoader = self:GetUIComponent("RawImageLoader", "RawImage")
  self._rawImage = self:GetUIComponent("RawImage", "RawImage")
  self._photoImage = self:GetUIComponent("RawImage", "photo")
  self._screenShot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self:ReplaceMaterial()
  self:RefreshActivityRemainTime()
  self:StartTask(self.PlayAnimEnterCoro, self)
  self:AttachEvent(GameEventType.ItemCountChanged, self._ItemCountChanged)
end

function UIActivityCN6N35MainController:_ItemCountChanged()
  self:OnRefresh()
end

function UIActivityCN6N35MainController:OnUpdate(deltaTimeMS)
  self:RefreshActivityRemainTime()
end

function UIActivityCN6N35MainController:RefreshActivityRemainTime()
  if self._activityConst:IsActivityEnd() then
    self._timeLabel:SetText(StringTable.Get("str_cn6&n35_activity_end"))
    return
  end
  local endTime
  local tipsStr = ""
  local nowTime = self._timeModule:GetServerTime() / 1000
  endTime = math.floor(self._activityConst:GetActiveEndTime() - nowTime)
  tipsStr = "str_cn6&n35_activity_remain_time"
  local seconds = endTime
  if seconds <= 0 then
    seconds = 0
  end
  local timeStr = UIActivityCustomHelper.GetTimeString(seconds, "str_cn6&n35_day", "str_cn6&n35_hour", "str_cn6&n35_minus", "str_cn6&n35_less_one_minus")
  local timeTips = StringTable.Get(tipsStr, timeStr)
  self._timeLabel:SetText(timeTips)
end

function UIActivityCN6N35MainController:OnRefresh()
  local com, comInfo
  com, comInfo = self._activityConst:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP)
  local icon, count = com:GetCostItemIconText()
  if 9999999 < count then
    count = 9999999
  end
  self._shopCountLabel:SetText(UIActivityCustomHelper.GetItemCountStr(7, count, "#7E91B6", "#FFFFFF"))
end

function UIActivityCN6N35MainController:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N6
end

function UIActivityCN6N35MainController:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_LINE_MISSION
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_SHARED
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_SMELTITEM
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_QUEST
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_PERSON_PROCESS
  componentIds[#componentIds + 1] = ECampaignCN6ComponentID.ECAMPAIGN_N6_HEIXIA
  return componentIds
end

function UIActivityCN6N35MainController:GetLoginComponentId()
  return ECampaignCN6ComponentID.ECAMPAIGN_N6_CUMULATIVE_LOGIN
end

function UIActivityCN6N35MainController:GetCustomTimeStr()
  return "str_cn6&n35_day", "str_cn6&n35_hour", "str_cn6&n35_minus", "str_cn6&n35_less_one_minus"
end

function UIActivityCN6N35MainController:GetButtonStatusConfig()
  local configs = {}
  local normalLevel = {}
  normalLevel.Name = "NormalLevel"
  normalLevel.ComponentId = ECampaignCN6ComponentID.ECAMPAIGN_N6_LINE_MISSION
  normalLevel.CheckRedComponentIds = nil
  
  function normalLevel.Callback()
    self:ShowDialog("UICN6N35Line", 1, true)
  end
  
  normalLevel.RemainTimeStr = "str_cn6&n35_activity_normal_level_remain_time"
  normalLevel.UnlockTimeStr = "str_cn6&n35_activity_normal_level_lock_time_tips"
  normalLevel.UnlockMissionStr = "str_cn6&n35_activity_normal_level_lock_mission_tips"
  configs[#configs + 1] = normalLevel
  local hardLevel = {}
  hardLevel.Name = "HardLevel"
  hardLevel.ComponentId = ECampaignCN6ComponentID.ECAMPAIGN_N6_DIFFICULT_MISSION
  hardLevel.CheckRedComponentIds = {
    ECampaignCN6ComponentID.ECAMPAIGN_N6_DIFFICULT_MISSION,
    ECampaignCN6ComponentID.ECAMPAIGN_N6_HEIXIA
  }
  
  function hardLevel.Callback()
    self:ShowDialog("UIActivityCN6N35HardLevelMain", 2)
  end
  
  hardLevel.RemainTimeStr = "str_cn6&n35_activity_hard_level_remain_time"
  hardLevel.UnlockTimeStr = "str_cn6&n35_activity_hard_level_lock_time_tips"
  hardLevel.UnlockMissionStr = "str_cn6&n35_activity_hard_level_lock_mission_tips"
  configs[#configs + 1] = hardLevel
  local shop = {}
  shop.Name = "Shop"
  shop.ComponentId = ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP
  shop.CheckRedComponentIds = nil
  
  function shop.Callback()
    self:ShowDialog("UIActivityCN6N35Shop", 2, true)
  end
  
  shop.RemainTimeStr = "str_cn6&n35_activity_shop_remain_time"
  shop.UnlockTimeStr = "str_cn6&n35_activity_shop_lock_time_tips"
  shop.UnlockMissionStr = "str_cn6&n35_activity_shop_lock_mission_tips"
  configs[#configs + 1] = shop
  local game = {}
  game.Name = "Game"
  game.ComponentId = ECampaignCN6ComponentID.ECAMPAIGN_N6_SMELTITEM
  game.CheckRedComponentIds = {
    ECampaignCN6ComponentID.ECAMPAIGN_N6_SMELTITEM,
    ECampaignCN6ComponentID.ECAMPAIGN_N6_PERSON_PROCESS
  }
  
  function game.Callback()
    self:ShowDialog("UI_CN6_N35_GameController")
  end
  
  game.RemainTimeStr = "str_n33_activity_game_remain_time"
  game.UnlockTimeStr = "str_n33_activity_game_lock_time_tips"
  game.UnlockMissionStr = "str_n33_activity_game_lock_mission_tips"
  
  function game.ExtraCustomCheckRed()
    return UI_CN6_N35_GameController.CheckQuestRed()
  end
  
  configs[#configs + 1] = game
  return configs
end

function UIActivityCN6N35MainController:NormalLevelOnClick()
  self:ClickButton("NormalLevel")
end

function UIActivityCN6N35MainController:HardLevelOnClick()
  self:ClickButton("HardLevel")
end

function UIActivityCN6N35MainController:GameOnClick()
  self:ClickButton("Game")
end

function UIActivityCN6N35MainController:ShopOnClick()
  self:ClickButton("Shop")
end

function UIActivityCN6N35MainController:PlotOnClick()
end

function UIActivityCN6N35MainController:SetPanelStatus(TT, isShow)
  self._showBtn:SetActive(not isShow)
  if self._anim then
    if isShow then
      self._anim:Play("uieff_UIActivityCN6N35MainController_show")
    else
      self._anim:Play("uieff_UIActivityCN6N35MainController_hide")
    end
  else
    self._showBtn:SetActive(not isShow)
    self._btnPanel:SetActive(isShow)
  end
end

function UIActivityCN6N35MainController:PlayAnimEnterCoro(TT)
  self:CheckGuide()
end

function UIActivityCN6N35MainController:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityCN6N35MainController)
end

function UIActivityCN6N35MainController:InfoOnClick()
  local campaign = self._activityConst:GetCampaign()
  local sample = campaign:GetSample()
  if sample == nil then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  local campId = sample.id
  local introCfg = Cfg.cfg_activity_intro_in_discovery[campId]
  self:ShowDialog("UIIntroLoader", introCfg.IntroLoaderKey, MaskType.MT_BlurMask)
end

function UIActivityCN6N35MainController:ReplaceMaterial()
  self._lastMaterial = self._rawImage.material
  self._reqEffectMat = ResourceManager:GetInstance():SyncLoadAsset("uieff_N35N6_rongjie01" .. ".mat", LoadType.Mat)
  if not self._reqEffectMat then
    return
  end
  self._effectMat = self._reqEffectMat.Obj
  self._rawImageLoader:SetMat("uieff_N35N6_rongjie01", self._effectMat, false)
  self._rawImage.material:SetTexture("_MainTex", self._lastMaterial:GetTexture("_MainTex"))
end

function UIActivityCN6N35MainController:Close(TT)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCN6N35MainQuit)
  if GameGlobal.UIStateManager():CurUIStateType() == UIStateType.UIMain then
    self:Lock("UIActivityCN6N35MainController_Close")
    self._screenShot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local rt = self._screenShot:RefreshBlurTexture()
    local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    self._photoImage.texture = cache_rt
    self._anim:Play("uieff_UIActivityCN6N35MainController_out")
    YIELD(TT, 300)
    self:CloseDialog()
    AudioHelperController.PlayBGM(self._playing)
    self:UnLock("UIActivityCN6N35MainController_Close")
  else
    AudioHelperController.PlayBGM(self._playing)
    self:SwitchState(UIStateType.UIMain)
  end
end
