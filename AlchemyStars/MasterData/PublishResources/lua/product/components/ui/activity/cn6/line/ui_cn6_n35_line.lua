require("ui_activity_line_level_base")
_class("UICN6N35Line", UIActivityLineLevelBase)
UICN6N35Line = UICN6N35Line

function UICN6N35Line:OnShow(uiParams)
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

function UICN6N35Line:_ItemCountChanged()
  local localProcess = self._campaign:GetLocalProcess()
  local petComp = localProcess:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP)
  local icon, count = petComp:GetCostItemIconText()
  if icon then
    self._exChangeBtn:SetIcon("icon", icon)
  end
  self._exChangeBtn:SetText("text", UIActivityCustomHelper.GetItemCountStr(7, count, "#4C618A", "#FFFFFF"))
end

function UICN6N35Line:GetCampaignType()
  return ECampaignType.CAMPAIGN_TYPE_INLAND_N6
end

function UICN6N35Line:GetLineComponentType()
  return ECampaignCN6ComponentID.ECAMPAIGN_N6_LINE_MISSION
end

function UICN6N35Line:GetFirstMeetComponentType()
  return nil
end

function UICN6N35Line:GetLevelNodeName()
  return "UICN6N35LineMapNode"
end

function UICN6N35Line:GetLevelLineName()
  return "UICN6N35LineMapLine"
end

function UICN6N35Line:GetBgList()
  return {
    "n35_xxg_bg01",
    "n35_xxg_bg02",
    "n35_xxg_bg03"
  }
end

function UICN6N35Line:GetLineLevelState()
  return UIStateType.UICN6N35Line
end

function UICN6N35Line:GetCustomTimeStr()
  return "str_cn6&n35_day", "str_cn6&n35_hour", "str_cn6&n35_minus", "str_cn6&n35_less_one_minus"
end

function UICN6N35Line:GetCustomTimeTipsStr()
  return "str_cn6&n35_remain_time_in_activity"
end

function UICN6N35Line:GetLockName()
  return self:GetName()
end

function UICN6N35Line:CloseWindow()
  self:CloseDialog()
end

function UICN6N35Line:PlotEndCallback(stageId)
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

function UICN6N35Line:SwitchMainUI()
  self:SwitchState(UIStateType.UIActivityCN6N35MainController)
end

function UICN6N35Line:OnInit()
  self._anim = self:GetUIComponent("Animation", "anim")
  self:_SetExchangeBtn()
end

function UICN6N35Line:PlayAnim(AnimName)
  self._anim:Play(AnimName)
end

function UICN6N35Line:_SetExchangeBtn()
  local compId = ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP
  local localProcess = self._campaign:GetLocalProcess()
  local petComp = localProcess:GetComponent(ECampaignCN6ComponentID.ECAMPAIGN_N6_SHOP)
  local pool = self:GetUIComponent("UISelectObjectPath", "exchangeBtn")
  self._exChangeBtn = pool:SpawnObject("UIActivityCommonComponentEnter")
  self._exChangeBtn:SetRed("red", function()
    return self._campaign:CheckComponentOpen(compId) and self._campaign:CheckComponentRed(compId)
  end)
  local icon, count = petComp:GetCostItemIconText()
  if icon then
    self._exChangeBtn:SetIcon("icon", icon)
  end
  self._exChangeBtn:SetText("text", UIActivityCustomHelper.GetItemCountStr(7, count, "#7E91B6", "#FFFFFF"))
  self._exChangeBtn:SetData(self._campaign, function()
    self:ShowDialog("UIActivityCN6N35Shop", 2, true)
  end)
  local lockTr = self._exChangeBtn:GetUIComponent("RectTransform", "lock")
  lockTr.gameObject:SetActive(false)
end
