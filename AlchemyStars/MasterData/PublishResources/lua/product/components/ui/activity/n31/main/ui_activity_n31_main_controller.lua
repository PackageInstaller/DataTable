_class("UIActivityN31MainController", UIActivityMainBase)
UIActivityN31MainController = UIActivityN31MainController

function UIActivityN31MainController:LoadDataOnEnter(TT, res, uiParams)
  UIActivityMainBase.LoadDataOnEnter(self, TT, res, uiParams)
end

function UIActivityN31MainController:OnInit(uiParams)
  self._missionModule = self:GetModule(MissionModule)
  self._shopCountLabel = self:GetUIComponent("UILocalizationText", "ShopCount")
  self._timeLabel = self:GetUIComponent("UILocalizationText", "Time")
  self._anim = self:GetUIComponent("Animation", "Anim")
  self.rt = self:GetUIComponent("RawImage", "Eff")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._shot.width = self._safeAreaSize.x
  self._shot.height = self._safeAreaSize.y
  self.imgRT = uiParams[1]
  self.showAni = uiParams[2]
  self.line = uiParams[3]
  self:RefreshActivityRemainTime()
  if self.showAni then
    self:PlayAnim(true)
  else
    self:CheckGuide()
  end
end

function UIActivityN31MainController:InitTopButton(uiParams)
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UICommonTopButton")
  if uiParams and not uiParams[2] then
    local anim = backBtn:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
    anim:Stop()
  end
  backBtn:SetData(function()
    GameGlobal.TaskManager():StartTask(self.CloseCoro, self)
  end, nil, nil, false, function()
    GameGlobal.TaskManager():StartTask(self.SetButtonShowStatusCoro, self, false)
  end)
end

function UIActivityN31MainController:PlayAnim(isIn, callback)
  local key = "UIN31MainPlayAnim"
  if isIn then
    self:StartTask(function(TT)
      if self.imgRT and self.rt then
        self:Lock(key)
        self.rt.texture = self.imgRT
        if self.line then
          self._anim:Play("UIActivityN31MainController_switch")
        else
          self._anim:Play("UIActivityN31MainController_in")
        end
        YIELD(TT, 1067)
        self:UnLock(key)
      end
      if callback then
        callback()
      end
      self:CheckGuide()
    end, self)
  else
    self:StartTask(function(TT)
      self:UnLock(key)
      if callback then
        callback()
      end
    end, self)
    self:CheckGuide()
  end
end

function UIActivityN31MainController:OnUpdate(deltaTimeMS)
  self:RefreshActivityRemainTime()
end

function UIActivityN31MainController:RefreshActivityRemainTime()
  if not self._activityConst then
    return
  end
  if not self._activityConst:GetInitState() then
    return
  end
  if self._activityConst:IsActivityEnd() then
    self._timeLabel:SetText(StringTable.Get("str_n31_activity_end"))
    return
  end
  local endTime = self._activityConst:GetActiveEndTime()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local seconds = math.floor(endTime - nowTime)
  if seconds <= 0 then
    seconds = 0
  end
  local str = self._activityConst:GetComponentStatus(ECampaignN31ComponentID.ECAMPAIGN_N31_DIFFICULT_MISSION) == ActivityComponentStatus.Close and "str_n31_activity_getreward_remain_time" or "str_n31_activity_remain_time"
  local timeStr = UIActivityCustomHelper.GetTimeString(seconds, "str_n31_day", "str_n31_hour", "str_n31_minus", "str_n31_less_one_minus")
  local timeTips = StringTable.Get(str, timeStr)
  self._timeLabel:SetText(timeTips)
end

function UIActivityN31MainController:OnRefresh()
  local com, comInfo
  com, comInfo = self._activityConst:GetComponent(ECampaignN31ComponentID.ECAMPAIGN_N31_SHOP)
  local icon, count = com:GetCostItemIconText()
  if 9999999 < count then
    count = 9999999
  end
  self._shopCountLabel:SetText(UIActivityCustomHelper.GetItemCountStr(7, count, "#9e8970", "#ffe673"))
end

function UIActivityN31MainController:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N31
end

function UIActivityN31MainController:GetComponentIds()
  local componentIds = {}
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_CUMULATIVE_LOGIN
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_POWER2ITEM
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_LINE_MISSION
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_DIFFICULT_MISSION
  componentIds[#componentIds + 1] = ECampaignN31ComponentID.ECAMPAIGN_N31_SHOP
  return componentIds
end

function UIActivityN31MainController:GetLoginComponentId()
  return ECampaignN31ComponentID.ECAMPAIGN_N31_CUMULATIVE_LOGIN
end

function UIActivityN31MainController:GetCustomTimeStr()
  return "str_n31_day", "str_n31_hour", "str_n31_minus", "str_n31_less_one_minus"
end

function UIActivityN31MainController:ScreenShot()
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local rt = self._shot:RefreshBlurTexture()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  return rt, cache_rt
end

function UIActivityN31MainController:GetButtonStatusConfig()
  local configs = {}
  local shop = {}
  shop.Name = "Shop"
  shop.ComponentId = ECampaignN31ComponentID.ECAMPAIGN_N31_SHOP
  shop.CheckRedComponentIds = nil
  
  function shop.Callback()
    self:ShowDialog("UIActivityN31Shop")
  end
  
  shop.RemainTimeStr = "str_n31_activity_shop_remain_time"
  shop.UnlockTimeStr = "str_n31_shop_close_time_tips"
  shop.UnlockMissionStr = "str_n31_activity_shop_mission_lock"
  configs[#configs + 1] = shop
  local line = {}
  line.Name = "Line"
  line.ComponentId = ECampaignN31ComponentID.ECAMPAIGN_N31_LINE_MISSION
  line.CheckRedComponentIds = nil
  
  function line.Callback()
    local rt, cache_rt = self:ScreenShot()
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(UIStateType.UIN31Line, false, cache_rt)
    end)
  end
  
  line.RemainTimeStr = "str_n31_activity_normal_level_remain_time"
  line.UnlockTimeStr = "str_n31_activity_line_time_lock"
  line.UnlockMissionStr = "str_n31_activity_line_mission_lock"
  configs[#configs + 1] = line
  local hard = {}
  hard.Name = "Hard"
  hard.ComponentId = ECampaignN31ComponentID.ECAMPAIGN_N31_DIFFICULT_MISSION
  hard.CheckRedComponentIds = nil
  
  function hard.Callback()
    local rt, cache_rt = self:ScreenShot()
    self:StartTask(function(TT)
      YIELD(TT)
      UnityEngine.Graphics.Blit(rt, cache_rt)
      self:SwitchState(UIStateType.UIN31HardLevel, false, cache_rt)
    end)
  end
  
  hard.RemainTimeStr = "str_n31_activity_hard_remain_time"
  hard.UnlockTimeStr = "str_n31_activity_hard_level_lock_time_tips"
  hard.UnlockMissionStr = "str_n31_activity_hard_level_lock_mission_tips"
  configs[#configs + 1] = hard
  local login = {}
  login.Name = "Login"
  login.ComponentId = ECampaignN31ComponentID.ECAMPAIGN_N31_CUMULATIVE_LOGIN
  login.CheckRedComponentIds = nil
  
  function login.Callback()
    self:LoginOnClick()
  end
  
  login.RemainTimeStr = "str_n31_activity_shop_remain_time"
  login.UnlockTimeStr = "str_n31_shop_close_time_tips"
  login.UnlockMissionStr = "str_n31_activity_shop_mission_lock"
  configs[#configs + 1] = login
  return configs
end

function UIActivityN31MainController:LineOnClick()
  self:ClickButton("Line")
end

function UIActivityN31MainController:HardOnClick()
  self:ClickButton("Hard")
end

function UIActivityN31MainController:ShopOnClick()
  self:ClickButton("Shop")
end

function UIActivityN31MainController:SetPanelStatus(TT, isShow)
  self._showBtn:SetActive(not isShow)
  if isShow then
    self._anim:Play("UIActivityN31MainController_show")
  else
    self._anim:Play("UIActivityN31MainController_hide")
  end
end

function UIActivityN31MainController:OnRelease()
  if self.imgRT then
    self.imgRT:Release()
    self.imgRT = nil
  end
end

function UIActivityN31MainController:Close(TT)
  self:PlayAnim(false, function()
    self:SwitchState(UIStateType.UIMain)
  end)
end

function UIActivityN31MainController:CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivityN31MainController)
end
