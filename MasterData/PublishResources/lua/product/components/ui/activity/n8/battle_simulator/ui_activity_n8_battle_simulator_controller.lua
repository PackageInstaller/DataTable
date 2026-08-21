_class("UIActivityN8BattleSimulatorController", UIController)
UIActivityN8BattleSimulatorController = UIActivityN8BattleSimulatorController

function UIActivityN8BattleSimulatorController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIActivityN8BattleSimulatorController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = self:_SpawnObject(widgetName, "UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr_Common_1()
  obj:SetExtraRollingText()
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UIActivityN8BattleSimulatorController:InitWidget()
  self._mainBg = self:GetUIComponent("RawImageLoader", "_mainBg")
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIActivityN8MainController, UIStateType.UIMain, nil, self._campaign._id)
  end, function()
    self:ShowDialog("UIHelpController", "UIActivityN8BattleSimulatorController")
  end)
  self._empty = self:GetGameObject("empty")
end

function UIActivityN8BattleSimulatorController:LoadDataOnEnter(TT, res, uiParams)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_N8, ECampaignN8ComponentID.ECAMPAIGN_N8_CUMULATIVE_LOGIN, ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION, ECampaignN8ComponentID.ECAMPAIGN_N8_LINE_MISSION_FIXTEAM, ECampaignN8ComponentID.ECAMPAIGN_N8_PERSON_PROGRESS, ECampaignN8ComponentID.ECAMPAIGN_N8_COMBAT_SIMULATOR)
  local componentId = ECampaignN8ComponentID.ECAMPAIGN_N8_COMBAT_SIMULATOR
  if not self._campaign:CheckComponentOpen(componentId) then
    res.m_result = self._campaign:CheckComponentOpenClientError(componentId) or res.m_result
    self._campaign:ShowErrorToast(res.m_result, true)
    return
  end
  if res and not res:GetSucc() then
    self._campaign:CheckErrorCode(res.m_result, nil, nil)
  end
end

function UIActivityN8BattleSimulatorController:OnShow(uiParams)
  self._timeModule = self:GetModule(SvrTimeModule)
  self._isOpen = true
  self:InitWidget()
  self:_SetPersonProgressBtn()
  local component = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_CombatSimulator, 1)
  local endTime = component:GetComponentInfo().m_close_time
  self:_SetRemainingTime("_remainingTimePool", "str_activity_n8_main_time_desc_3", endTime)
  self._timerHolder = UITimerHolder:New()
  self._timerHolder:StartTimerInfinite("CallPerSecond", 1000, function()
    self:CallPerSecond()
  end)
  self:AttachEvent(GameEventType.AircraftTacticRefreshTapeList, self._SetTape)
  self:Refresh()
  self:Lock("WaitForAnim")
  self._timerHolder:StartTimer("WaitForAnim", 1500, function()
    self:UnLock("WaitForAnim")
  end)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N8EnterTatic)
end

function UIActivityN8BattleSimulatorController:OnHide()
  self._timerHolder:Dispose()
  self._isOpen = false
  self:DetachEvent(GameEventType.AircraftTacticRefreshTapeList, self._SetTape)
end

function UIActivityN8BattleSimulatorController:Destroy()
  self._matReq = UIWidgetHelper.DisposeLocalizedTMPMaterial(self._matReq)
end

function UIActivityN8BattleSimulatorController:Refresh(afterReq)
  self:_SetTape()
  self:CallPerSecond(afterReq)
end

function UIActivityN8BattleSimulatorController:_SetPersonProgressBtn()
  local componentId = ECampaignN8ComponentID.ECAMPAIGN_N8_PERSON_PROGRESS
  local obj = self:_SpawnObject("_personProgressBtn", "UIActivityCommonComponentEnterLock")
  obj:SetRed_RedDotModule("red", RedDotType.RDT_N8_SIMULATOR_PRESTIGE)
  self._matReq = UIWidgetHelper.SetLocalizedTMPMaterial(obj, "titleText", "N8Material_02.mat", self._matReq)
  local tb = {
    {"bg_lock"},
    {"bg_lock"},
    {"bg_unlock"},
    {"bg_lock"}
  }
  obj:SetWidgetNameGroup(tb)
  obj:SetData(self._campaign, componentId, function()
    self:ShowDialog("UIActivityN8PersonProgressController")
  end)
  local iconText = self:_SpawnObject("_personProgressIconTextPool", "UIActivityN8PersonProgressIconText")
  iconText:SetData(self._campaign)
end

function UIActivityN8BattleSimulatorController:_SetTape()
  local component = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_CombatSimulator, 1)
  self.time = self:GetUIComponent("UISelectObjectPath", "time")
  self._tapeTime = self.time:SpawnObject("UIAircraftTacticTapeTime")
  self.tapes = self:GetUIComponent("UISelectObjectPath", "tapes")
  self._tapePool = self.tapes:SpawnObject("UIAircraftTacticTapeList")
  self._tapeList = component:GetCartridgeItemList()
  component:SortCartridgeItemList(self._tapeList)
  self._curTapeCount = #self._tapeList
  self._packCount = component:GetCartridgeGiftCount()
  local activityN8 = true
  self._tapeTime:SetData(self._curTapeCount + self._packCount, activityN8)
  self._tapePool:SetData(self._tapeList, self._packCount, activityN8)
  self._empty:SetActive(self._curTapeCount + self._packCount == 0)
end

function UIActivityN8BattleSimulatorController:CallPerSecond(afterReq)
  local component = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_CombatSimulator, 1)
  local now = math.floor(self._timeModule:GetServerTime() / 1000)
  local tapeCeiling = component:GetCartridgeCeiling()
  local tapeCount = component:GetCartridgeGiftCount() + self._curTapeCount
  local tapeRefresh = false
  if tapeCeiling > tapeCount then
    local time = component:GetCartridgeNextGiftTime() - now
    self._tapeTime:Tick(time)
    if time < 0 then
      tapeRefresh = true
    end
  end
  if tapeRefresh then
    if afterReq then
      Log.exception("战术室时间错误,引发死循环")
      self._timerHolder:StopTimer("CallPerSecond")
      return
    end
    self:StartTask(self.reqRefresh, self, tapeRefresh)
  end
end

function UIActivityN8BattleSimulatorController:reqRefresh(TT, isTapeChanged)
  local component = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_CombatSimulator, 1)
  self:Lock(self:GetName())
  local res = AsyncRequestRes:New()
  component:HandleCombatSimulatorComponentRefresh(TT, res)
  self:UnLock(self:GetName())
  if not res or not res:GetSucc() then
    self._campaign:CheckErrorCode(res)
    return
  end
  self:Refresh(true)
end
