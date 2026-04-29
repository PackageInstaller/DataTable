_class("UIActivityN32MainController", UIActivityMainBase)
UIActivityN32MainController = UIActivityN32MainController

function UIActivityN32MainController:LoadDataOnEnter(TT, res, uiParams)
  UIActivityMainBase.LoadDataOnEnter(self, TT, res, uiParams)
end

function UIActivityN32MainController:OnInit(uiParams)
  self._missionModule = self:GetModule(MissionModule)
  self._shopCountLabel = self:GetUIComponent("UILocalizationText", "ShopCount")
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self.rt = self:GetUIComponent("RawImage", "Eff")
  self.imgRT = uiParams[1]
  self.showAni = uiParams[2]
  self:RefreshActivityRemainTime()
  if self.showAni then
    self:PlayAnim(true, function()
      self:_CheckGuide()
    end)
  else
    self:_CheckGuide()
  end
end

function UIActivityN32MainController:PlayAnim(isIn, callback)
  local key = "UIActivityN32MainController_in"
  if isIn then
    self:StartTask(function(TT)
      if self.imgRT and self.rt then
        self:Lock(key)
        self.rt.texture = self.imgRT
        self._anim:Play("UIActivityN32MainController_in")
        YIELD(TT, 1067)
        self:UnLock(key)
      end
      if callback then
        callback()
      end
    end, self)
  else
    self:StartTask(function(TT)
      self._anim:Play("UIActivityN32MainController_out")
      self:UnLock(key)
      if callback then
        callback()
      end
    end, self)
  end
end

function UIActivityN32MainController:OnUpdate(deltaTimeMS)
  self:RefreshActivityRemainTime()
end

function UIActivityN32MainController:RefreshActivityRemainTime()
  if not self._activityConst then
    return
  end
  if not self._activityConst:GetInitState() then
    return
  end
  if self._activityConst:IsActivityEnd() then
    self._timeLabel:SetText(StringTable.Get("str_n32_activity_end"))
    return
  end
  local endTime = self._activityConst:GetActiveEndTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  if seconds <= 0 then
    seconds = 0
  end
  local timeStr = UIActivityCustomHelper.GetTimeString(seconds, "str_n32_day", "str_n32_hour", "str_n32_minus", "str_n32_less_one_minus")
  local str = self._activityConst:GetComponentStatus(ECampaignN32ComponentID.ECAMPAIGN_N32_DIFFICULT_MISSION) == ActivityComponentStatus.Close and "str_n32_activity_getreward_remain_time" or "str_n32_activity_remain_time"
  local timeTips = StringTable.Get(str, timeStr)
  self._timeLabel:SetText(timeTips)
end

function UIActivityN32MainController:OnRefresh()
  local com, comInfo
  com, comInfo = self._activityConst:GetComponent(ECampaignN32ComponentID.ECAMPAIGN_N32_LOTTERY)
  local icon, count = com:GetLotteryCostItemIconText()
  if 9999999 < count then
    count = 9999999
  end
  self._shopCountLabel:SetText(UIActivityCustomHelper.GetItemCountStr(7, count, "#533d2f", "#f2f0e9"))
end

function UIActivityN32MainController:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N32
end

function UIActivityN32MainController:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN32ComponentID.ECAMPAIGN_N32_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN32ComponentID.ECAMPAIGN_N32_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN32ComponentID.ECAMPAIGN_N32_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignN32ComponentID.ECAMPAIGN_N32_BLACK_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignN32ComponentID.ECAMPAIGN_N32_LOTTERY
  componentIds[#componentIds + 1] = ECampaignN32ComponentID.ECAMPAIGN_N32_MULTILINE_MISSION
  return componentIds
end

function UIActivityN32MainController:GetLoginComponentId()
  return ECampaignN32ComponentID.ECAMPAIGN_N32_CUMULATIVE_LOGIN
end

function UIActivityN32MainController:GetCustomTimeStr()
  return "str_n32_day", "str_n32_hour", "str_n32_minus", "str_n32_less_one_minus"
end

function UIActivityN32MainController:GetButtonStatusConfig()
  local configs = {}
  local shop = {}
  shop.Name = "Shop"
  shop.ComponentId = ECampaignN32ComponentID.ECAMPAIGN_N32_LOTTERY
  shop.CheckRedComponentIds = nil
  
  function shop.Callback()
    self:SwitchState(UIStateType.UIN32ShopController)
  end
  
  shop.RemainTimeStr = "str_n32_activity_shop_remain_time"
  shop.UnlockTimeStr = "str_n32_shop_close_time_tips"
  shop.UnlockMissionStr = "str_n32_activity_shop_mission_lock"
  configs[#configs + 1] = shop
  local hard = {}
  hard.Name = "Hard"
  hard.ComponentId = ECampaignN32ComponentID.ECAMPAIGN_N32_DIFFICULT_MISSION
  hard.CheckRedComponentIds = nil
  
  function hard.Callback()
    self:SwitchState(UIStateType.UIActivityN32HardLevelMain)
  end
  
  hard.RemainTimeStr = "str_n32_activity_hard_remain_time"
  hard.UnlockTimeStr = "str_n32_activity_hard_level_lock_time_tips"
  hard.UnlockMissionStr = "str_n32_activity_hard_level_lock_mission_tips"
  configs[#configs + 1] = hard
  local login = {}
  login.Name = "Login"
  login.ComponentId = ECampaignN32ComponentID.ECAMPAIGN_N32_CUMULATIVE_LOGIN
  login.CheckRedComponentIds = nil
  
  function login.Callback()
    self:LoginOnClick()
  end
  
  login.RemainTimeStr = "str_n32_activity_shop_remain_time"
  login.UnlockTimeStr = "str_n32_shop_close_time_tips"
  login.UnlockMissionStr = "str_n32_activity_shop_mission_lock"
  configs[#configs + 1] = login
  local multiLine = {}
  multiLine.Name = "Multiline"
  multiLine.ComponentId = ECampaignN32ComponentID.ECAMPAIGN_N32_MULTILINE_MISSION
  multiLine.CheckRedComponentIds = nil
  
  function multiLine.Callback()
    self:PlayComponentPlot(ECampaignN32ComponentID.ECAMPAIGN_N32_MULTILINE_MISSION, function()
      self:SwitchState(UIStateType.UIN32MultiLineMain)
    end)
  end
  
  multiLine.RemainTimeStr = "str_n32_activity_hard_remain_time"
  multiLine.UnlockTimeStr = "str_n32_activity_hard_level_lock_time_tips"
  multiLine.UnlockMissionStr = "str_n32_activity_hard_level_lock_mission_tips"
  configs[#configs + 1] = multiLine
  return configs
end

function UIActivityN32MainController:LineOnClick()
  self:ClickButton("Peridales")
end

function UIActivityN32MainController:HardOnClick()
  self:ClickButton("Hard")
end

function UIActivityN32MainController:ShopOnClick()
  if self._activityConst:IsActivityEnd() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self:ClickButton("Shop")
end

function UIActivityN32MainController:MultilineOnClick()
  self:ClickButton("Multiline")
end

function UIActivityN32MainController:EventOnClick()
  if self._activityConst:IsActivityEnd() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  UIActivityBattlePassHelper.OpenMainController()
end

function UIActivityN32MainController:LoginOnClick()
  if self._activityConst:IsActivityEnd() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIMain)
    return
  end
  local status, time = self._activityConst:GetComponentStatus(self:GetLoginComponentId())
  if status == ActivityComponentStatus.Close or status == ActivityComponentStatus.ActivityEnd then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return
  end
  self:ShowDialog("UIActivityTotalLoginAwardController", false, self:GetCampaignType(), self:GetLoginComponentId())
end

function UIActivityN32MainController:SetPanelStatus(TT, isShow)
  self._showBtn:SetActive(not isShow)
  if isShow then
    self._anim:Play("UIActivityN32MainController_show")
  else
    self._anim:Play("UIActivityN32MainController_hide")
  end
end

function UIActivityN32MainController:OnRelease()
  if self.imgRT then
    self.imgRT:Release()
    self.imgRT = nil
  end
end

function UIActivityN32MainController:Close(TT)
  self:PlayAnim(false, function()
    self:SwitchState(UIStateType.UIMain)
  end)
end

function UIActivityN32MainController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN32MainController)
end
