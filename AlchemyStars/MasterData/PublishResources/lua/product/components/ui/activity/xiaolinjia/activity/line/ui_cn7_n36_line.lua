require("ui_activity_line_level_base")
_class("UICN7N36Line", UIActivityLineLevelBase)
UICN7N36Line = UICN7N36Line

function UICN7N36Line:OnShow(uiParams)
  self._isNormalUI = uiParams[1] and true
  self._mainShot = uiParams[2]
  local backBtns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self._backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    if self._isNormalUI then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityMainStatusRefreshEvent)
      self:CloseWindow()
    else
      self:SwitchMainUI()
    end
  end, nil, nil, false, nil, nil, nil)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._linesPool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._nodesPool = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._time = self:GetUIComponent("UILocalizationText", "Time")
  self._firstRedPoint = self:GetGameObject("RedPoint")
  self._bgLoader1 = self:GetUIComponent("RawImageLoader", "bg1")
  self._bgLoader2 = self:GetUIComponent("RawImageLoader", "bg2")
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
  self:AttachEvent(GameEventType.ItemCountChanged, self._ItemCountChanged)
end

function UICN7N36Line:_ItemCountChanged()
  local lotteryComponentInfo = self._campaign:GetComponentInfo(ECampaignCN7ComponentID.ECAMPAIGN_N7_LOTTERY)
  if lotteryComponentInfo then
    local curCount = ClientCampaignDrawShop.GetMoney(lotteryComponentInfo.m_cost_item_id)
    self._exChangeBtn:SetText("text", curCount)
  end
end

function UICN7N36Line:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N7
end

function UICN7N36Line:GetLineComponentType()
  return ECampaignCN7ComponentID.ECAMPAIGN_N7_LINE_MISSION
end

function UICN7N36Line:GetFirstMeetComponentType()
  return nil
end

function UICN7N36Line:GetLevelNodeName()
  return "UICN7N36LineMapNode"
end

function UICN7N36Line:GetLevelLineName()
  return "UICN7N36LineMapLine"
end

function UICN7N36Line:GetBgList()
  return nil
end

function UICN7N36Line:GetLineLevelState()
  return UIStateType.UICN7N36Line
end

function UICN7N36Line:GetCustomTimeStr()
  return "str_activity_day", "str_activity_hour", "str_activity_minus", "str_activity_less_one_minus"
end

function UICN7N36Line:GetCustomTimeTipsStr()
  return "str_cn7_n36_activity_mission_remaining_time"
end

function UICN7N36Line:GetLockName()
  return self:GetName()
end

function UICN7N36Line:CloseWindow()
  local lockName = "UICN7N36Line:AnimOut"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self:PlayAnim("uieff_UICN7N36Line_out")
    YIELD(TT, 500)
    self:UnLock(lockName)
    self:CloseDialog()
  end)
end

function UICN7N36Line:PlotEndCallback(stageId)
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

function UICN7N36Line:SwitchMainUI()
  self:SwitchState(UIStateType.UICN7N36MainController)
end

function UICN7N36Line:OnInit()
  self._anim = self:GetUIComponent("Animation", "anim")
  local lockName = "UICN7N36Line:AnimIN"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self:PlayAnim("uieff_UICN7N36Line_in")
    YIELD(TT, 1000)
    self:UnLock(lockName)
  end)
  self:_SetExchangeBtn()
end

function UICN7N36Line:PlayAnim(AnimName)
  self._anim:Play(AnimName)
end

function UICN7N36Line:_SetExchangeBtn()
  local compId = ECampaignCN7ComponentID.ECAMPAIGN_N7_LOTTERY
  local lotteryComponentInfo = self._campaign:GetComponentInfo(ECampaignCN7ComponentID.ECAMPAIGN_N7_LOTTERY)
  local pool = self:GetUIComponent("UISelectObjectPath", "exchangeBtn")
  self._exChangeBtn = pool:SpawnObject("UIActivityCommonComponentEnter")
  self._exChangeBtn:SetRed("red", function()
    return self._campaign:GetLocalProcess():ShopRedPoint()
  end)
  if lotteryComponentInfo then
    local curCount = ClientCampaignDrawShop.GetMoney(lotteryComponentInfo.m_cost_item_id)
    self._exChangeBtn:SetText("text", curCount)
  end
  self._exChangeBtn:SetData(self._campaign, function()
    self:ShowDialog("UICN7N36ShopController")
  end)
  local lockTr = self._exChangeBtn:GetUIComponent("RectTransform", "lock")
  lockTr.gameObject:SetActive(false)
end
