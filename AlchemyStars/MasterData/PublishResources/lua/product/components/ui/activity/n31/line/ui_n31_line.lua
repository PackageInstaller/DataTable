_class("UIN31Line", UIActivityLineLevelBase)
UIN31Line = UIN31Line

function UIN31Line:OnShow(uiParams)
  self._isNormalUI = uiParams[1] and true
  self._mainShot = uiParams[2]
  local backBtns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    if self._isNormalUI then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityMainStatusRefreshEvent)
      self:CloseWindow()
    else
      self:SwitchMainUI()
    end
  end)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._linesPool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._nodesPool = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._shot.width = self._safeAreaSize.x
  self._shot.height = self._safeAreaSize.y
  self._time = self:GetUIComponent("UILocalizationText", "Time")
  self._firstRedPoint = self:GetGameObject("RedPoint")
  self._bgLoader1 = self:GetUIComponent("RawImageLoader", "bg1")
  self._bgLoader2 = self:GetUIComponent("RawImageLoader", "bg2")
  self.rt = self:GetUIComponent("RawImage", "Eff")
  self._isOpen = true
  self._timerHolder = UITimerHolder:New()
  self:OnInit()
  self:AttachEvents()
  self:FlushNodes()
  self:RefreshCountdown()
  self:RefreshTryout()
  local lockName = "UINP7Level_OnShow"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 500, function()
    self:UnLock(lockName)
  end)
end

function UIN31Line:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_N31
end

function UIN31Line:GetLineComponentType()
  return ECampaignN31ComponentID.ECAMPAIGN_N31_LINE_MISSION
end

function UIN31Line:GetFirstMeetComponentType()
  return nil
end

function UIN31Line:GetLevelNodeName()
  return "UIN31LineMapNode"
end

function UIN31Line:GetLevelLineName()
  return "UIN31LineMapLine"
end

function UIN31Line:GetBgList()
  return {
    "n31_xxg_bg01",
    "n31_xxg_bg02",
    "n31_xxg_bg03"
  }
end

function UIN31Line:GetLineLevelState()
  return UIStateType.UIN31Line
end

function UIN31Line:GetCustomTimeStr()
  return "str_n31_day", "str_n31_hour", "str_n31_minus", "str_n31_less_one_minus"
end

function UIN31Line:GetCustomTimeTipsStr()
  return "str_n31_activity_hard_level_remain_time"
end

function UIN31Line:GetLockName()
  return self:GetName()
end

function UIN31Line:CloseWindow()
  self:CloseDialog()
end

function UIN31Line:PlotEndCallback(stageId)
  local isActive = self._lineComponent:IsPassCamMissionID(stageId)
  if isActive then
    return
  end
  self:StartTask(function(TT)
    self._lineComponent:SetMissionStoryActive(TT, stageId, ActiveStoryType.ActiveStoryType_BeforeBattle)
    local res = AsyncRequestRes:New()
    local award = self._lineComponent:HandleCompleteStoryMission(TT, res, stageId)
    if not res:GetSucc() then
      self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    elseif table.count(award) ~= 0 then
      self:ShowDialog("UIGetItemController", award, function()
        self:FlushNodes()
      end)
    else
      self:FlushNodes()
    end
  end, self)
end

function UIN31Line:SwitchMainUI()
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local rt = self._shot:RefreshBlurTexture()
  local cache_rt = UnityEngine.RenderTexture:New(UnityEngine.Screen.width, UnityEngine.Screen.height, 16)
  self:StartTask(function(TT)
    YIELD(TT)
    UnityEngine.Graphics.Blit(rt, cache_rt)
    self:SwitchState(UIStateType.UIActivityN31MainController, cache_rt, true, true)
  end)
end

function UIN31Line:OnInit()
  if self._mainShot then
    self.rt.texture = self._mainShot
  else
    self.rt.gameObject:SetActive(false)
  end
  self._anim = self:GetUIComponent("Animation", "anim")
  self:PlayAnim("uieff_UIN31Line_in")
  self:_SetExchangeBtn()
end

function UIN31Line:PlayAnim(AnimName)
  self._anim:Play(AnimName)
end

function UIN31Line:_SetExchangeBtn()
  local compId = ECampaignN31ComponentID.ECAMPAIGN_N31_SHOP
  local localProcess = self._campaign:GetLocalProcess()
  local petComp = localProcess:GetComponent(ECampaignN31ComponentID.ECAMPAIGN_N31_SHOP)
  local pool = self:GetUIComponent("UISelectObjectPath", "exchangeBtn")
  local obj = pool:SpawnObject("UIActivityCommonComponentEnter")
  obj:SetRed("red", function()
    return self._campaign:CheckComponentOpen(compId) and self._campaign:CheckComponentRed(compId)
  end)
  local icon, count = petComp:GetCostItemIconText()
  if icon then
    obj:SetIcon("icon", icon)
  end
  obj:SetText("text", count)
  obj:SetText("txtNumbg", string.format("%.7d", count))
  obj:SetData(self._campaign, function()
    ClientCampaignShop.OpenCampaignShop(self._campaign._type, self._campaign._id, function()
      self._campaign._campaign_module:CampaignSwitchState(true, UIStateType.UIN31Line, UIStateType.UIMain, "", self._campaign._id, compId)
    end, true)
  end)
  local lockTr = obj:GetUIComponent("RectTransform", "lock")
  lockTr.gameObject:SetActive(false)
end
