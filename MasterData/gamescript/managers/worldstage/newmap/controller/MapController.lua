local MapController = NewClass("MapController", BaseController)

function MapController:OnInit()
  self:OnReset()
  self:RegisterMapNotify()
end

function MapController:OnReset()
  self.entity = nil
  self.model = nil
  self.triggerHandler = nil
end

function MapController:Setup(entity, model)
  self.entity = entity
  self.model = model
  self.triggerHandler = MapGearTriggerHandler
end

function MapController:ResetMap(entity)
  if entity and self.entity ~= entity then
    return
  end
  self:OnReset()
end

function MapController:RegisterMapNotify()
  if self.isNotifyRegistered then
    return
  end
  self.isNotifyRegistered = true
  self:RegisterNotify(NotifyId.OnNewMapGearClick, System.fn(self, self.OnGearClick))
  self:RegisterNotify(NotifyId.OnNewMapGearReqTrigger, System.fn(self, self.OnGearReqTrigger))
  self:RegisterNotify(NotifyId.OnNewMapGearTriggerData, System.fn(self, self.OnGearTriggerData))
  self:RegisterNotify(NotifyId.OnNewMapGearPreTrigger, System.fn(self, self.OnGearPreTrigger))
  self:RegisterNotify(NotifyId.OnNewMapGearDoTrigger, System.fn(self, self.OnGearDoTrigger))
  self:RegisterNotify(NotifyId.OnNewMapGearMoveAndTrigger, System.fn(self, self.OnGearMoveAndTrigger))
  self:RegisterNotify(NotifyId.OnNewMapGearTriggerAfterMonitorChoice, System.fn(self, self.OnGearTriggerAfterMonitorChoice))
  self:RegisterNotify(NotifyId.OnNewMapGearReqHandle, System.fn(self, self.OnGearReqHandle))
  self:RegisterNotify(NotifyId.OnNewMapGearOpenEventPanel, System.fn(self, self.OnGearOpenEventPanel))
  self:RegisterNotify(NotifyId.OnNewMapGearReqChoose, System.fn(self, self.OnGearReqChoose))
  self:RegisterNotify(NotifyId.OnNewMapGearAfterTrigger, System.fn(self, self.OnGearAfterTrigger))
  self:RegisterNotify(NotifyId.OnNewMapGearEventPanelClosed, System.fn(self, self.OnGearEventPanelClosed))
end

function MapController:IsReady()
  return self.entity ~= nil and nil ~= self.model
end

function MapController:GetComponent(compClass)
  if not self:IsReady() then
    return
  end
  return self.entity and self.entity:GetComponent(compClass)
end

function MapController:GetGearItem(uid)
  local gearMgr = self:GetComponent(MapGearManager)
  if gearMgr then
    do return gearMgr.GetGearByUid, gearMgr end
    return gearMgr.GetGearByUid, gearMgr, uid
  end
end

function MapController:StartGearTriggerByUid(uid)
  if not uid then
    return
  end
  self.model:SetGearInTrigger(uid)
  local guideMgr = self:GetComponent(MapGuideManager)
  if guideMgr then
    guideMgr:TriggerEvent(CommonDefine.GuideEvent.GearTrigger, self.model:GetGearTid(uid))
  end
end

function MapController:IsGearRoleHere(uid)
  local gearX, gearY = self.model:GetGearPos(uid)
  local roleX, roleY = self.model:GetCurrentPos()
  return nil ~= gearX and nil ~= gearY and gearX == roleX and gearY == roleY
end

function MapController:PlayGearAudio(uid)
  local gearItem = self:GetGearItem(uid)
  if gearItem then
    gearItem:AudioPlay()
  end
end

function MapController:RunGearBeginStory(uid, storyList, svrData)
  local gearItem = self:GetGearItem(uid)
  if gearItem and gearItem:_IsStorygListValid(storyList) then
    gearItem:_PlayStoryList(storyList, svrData)
    return true
  end
  return false
end

function MapController:RunGearEndStory(uid)
  local gearItem = self:GetGearItem(uid)
  local cfgData = self.model:GetGearConfigData(uid)
  local endStoryList = cfgData and cfgData.AfterDialogueId
  if gearItem and gearItem:_IsStorygListValid(endStoryList) then
    gearItem:_PlayStoryList(endStoryList)
    return true
  end
  return false
end

function MapController:RunGearChildTrigger(uid, svrData)
  local gearItem = self:GetGearItem(uid)
  if gearItem and gearItem.OnTriggerChild then
    gearItem.OnTriggerChild(gearItem, svrData)
    return true
  end
  return false
end

function MapController:NotifyGearHandleResult(uid, data)
  local gearItem = self:GetGearItem(uid)
  if gearItem then
    gearItem:OnGearItemHandle(data)
  end
end

function MapController:RunGearAfterChoose(uid, data)
  local gearItem = self:GetGearItem(uid)
  if gearItem then
    do return gearItem.AfterChoose, gearItem end
    return gearItem.AfterChoose, gearItem, data
  end
  return false
end

local SkipBattleCmdId = DT.GetConstant("SkipBattleCmd")

function MapController:IsSkipBattleEvent(index, eventId)
  local eventCfg = DT.Event[eventId]
  local cmdId = eventCfg and eventCfg["ChoiceEffect" .. index] and eventCfg["ChoiceEffect" .. index][1]
  return cmdId and cmdId == SkipBattleCmdId
end

function MapController:InsertBattleSettleTip()
  CopyDataUtils.Set_needShowBattleSettleTips(true)
end

function MapController:CanRequestGridAction()
  if not self:IsReady() then
    return false
  end
  if BattleManager.Instance:IsInBattle() then
    return false
  end
  local touchMgr = self:GetComponent(MapTouchManager)
  if touchMgr and not self:CanTouchGrid(touchMgr) then
    return false
  end
  if not self.entity:GetClickState() then
    Logger.Warn("[NewMap] 地图处于不可点击状态")
    return false
  end
  local moveMgr = self:GetComponent(MapMoveManager)
  if not moveMgr or not moveMgr:CanMove() then
    return false
  end
  return true
end

function MapController:CanTouchGrid(touchMgr)
  if touchMgr:GetIsMoving() or touchMgr:GetIsScaled() then
    Logger.Info("正在拖动地图~")
    return false
  end
  if not touchMgr:GetCanTouch() then
    Logger.Info("禁止点击~")
    return false
  end
  touchMgr:SetTouchAvailable(true)
  return true
end

function MapController:GetGridActionTarget(gridX, gridY)
  local terrainMgr = self:GetComponent(MapTerrainManager)
  local terrain
  if terrainMgr then
    terrain = terrainMgr:GetTerrainByPos(gridX, gridY)
  end
  if terrain and not terrain.isVisible then
    return nil, true
  end
  if terrain then
    terrain:PlayClickAnim()
  end
  local gearMgr = self:GetComponent(MapGearManager)
  if gearMgr then
    return gearMgr:GetGearByPos(gridX, gridY), false
  end
  return nil, false
end

function MapController:RequestGridAction(gridX, gridY)
  if not self:CanRequestGridAction() then
    return
  end
  local gear, isBlocked = self:GetGridActionTarget(gridX, gridY)
  if isBlocked then
    return
  end
  if gear and not gear:IsRemoved() then
    self:RequestGearActionByUid(gear:GetUid(), gridX, gridY)
  else
    Logger.Info("[NewMap] try to move to", gridX, gridY)
    EventMgr.Instance.GearRoleMove:Dispatch(gridX, gridY)
  end
end

function MapController:RequestGearAction(gear, gridX, gridY)
  if not gear then
    return
  end
  self:RequestGearActionByUid(gear:GetUid(), gridX, gridY)
end

function MapController:RequestGearActionByUid(uid, gridX, gridY)
  if not self:IsReady() then
    return
  end
  if self.model:IsGearTriggerInCooldown(uid, 0.3) then
    Logger.Warn("等待gear trigger")
    return
  end
  local nodeTypeCfg = self.model:GetGearNodeTypeConfig(uid)
  local triggerType = 0
  if nodeTypeCfg then
    triggerType = nodeTypeCfg.Trigger or 0
  end
  local gearType = self.model:GetGearType(uid)
  local tid = self.model:GetGearTid(uid)
  local nodeCfg = tid and DT.MapNode[tid]
  Logger.Info("点击到了: ", nodeCfg and nodeCfg.Name or "", gearType, "Trigger=", triggerType)
  if 2 == triggerType then
    Logger.Info("移动后触发，直接移动")
    EventMgr.Instance.GearRoleMove:Dispatch(gridX, gridY, function()
      self:OnGearClickByUid(uid)
    end)
  elseif 1 == triggerType or self.model:IsGearChoasNode(uid) or self.model:IsGearMonitored(uid) then
    Logger.Info("移动前触发，先触发")
    self.model:SetGearPendingMovePos(uid, gridX, gridY)
    self:OnGearClickByUid(uid)
  else
    Logger.Info("不触发，直接处理")
    self:OnGearClickByUid(uid)
  end
end

function MapController:OnGearClick(gearItem)
  if not self:IsReady() then
    return
  end
  if not gearItem then
    return
  end
  self:OnGearClickByUid(gearItem:GetUid())
end

function MapController:OnGearClickByUid(uid)
  if not self:IsReady() then
    return
  end
  if not uid then
    return
  end
  self.model:SetGearTriggerTime(uid, TimerManager.totalTime)
  local nodeTypeCfg = self.model:GetGearNodeTypeConfig(uid)
  local trigger = 0
  if nodeTypeCfg then
    trigger = nodeTypeCfg.Trigger or 0
  end
  if 0 == trigger then
    Logger.Warn("[NewMap] 节点不触发~")
  elseif 1 == trigger or self.model:IsGearChoasNode(uid) or self.model:IsGearMonitored(uid) then
    Logger.Info("移动前触发")
    self:StartGearTriggerByUid(uid)
    local triggerMonitor = self.model:IsGearMonitored(uid) and not self.model:IsGearChoasNode(uid)
    self:ReqTriggerByUid(uid, triggerMonitor)
  elseif 2 == trigger and self:MoveAndDoTriggerByUid(uid) then
    self:StartGearTriggerByUid(uid)
  end
end

function MapController:OnGearReqTrigger(gearItem, uid, triggerMonitor)
  self:ReqTriggerByUid(uid or gearItem and gearItem:GetUid(), triggerMonitor)
end

function MapController:ReqTrigger(gearItem, uid, triggerMonitor)
  self:ReqTriggerByUid(uid or gearItem and gearItem:GetUid(), triggerMonitor)
end

function MapController:ReqTriggerByUid(uid, triggerMonitor)
  if not self:IsReady() then
    return
  end
  if not uid then
    return
  end
  WorldStageManager.Instance:SetCurTriggeredGearType(self.model:GetGearType(uid))
  EventMgr.Instance.OpenReqMask:Dispatch()
  self.model:SetGearWaitingForProto(uid, true)
  ProtoManager.Instance:ReqServer("WorldRequest", "OnTrigger", function(data, errcode)
    self.model:SetGearWaitingForProto(uid, false)
    Logger.Info("OnTrigger Success", table.tostring(data), table.tostring(errcode))
  end, function(errorData)
    Logger.Warn("[NewMap] ReqTrigger Failed", table.tostring(errorData))
    self.model:SetGearWaitingForProto(uid, false)
    self.model:TakeGearPendingMovePos(uid)
    self.model:EndGearTrigger(uid)
    if GuideManager.Instance then
      GuideManager.Instance:SetDisabled(false)
    end
  end, uid, {triggerMonitor = triggerMonitor})
end

function MapController:OnGearTriggerData(gearItem, svrData)
  self:OnGearTriggerDataInternalByUid(gearItem and gearItem:GetUid(), svrData)
end

function MapController:EnterGearBattle(gearItem, battleData, options)
  do return self.EnterGearBattleByUid, self, gearItem and gearItem:GetUid(), battleData end
  return self.EnterGearBattleByUid, self, gearItem and gearItem:GetUid(), battleData, options
end

function MapController:EnterGearBattleByUid(uid, battleData, options)
  if not self:IsReady() then
    return false
  end
  if not battleData or not battleData.battleTid then
    return false
  end
  options = options or {}
  if options.closeEventPanel then
    UIManager.Instance:CloseByUrl(Urls.WorldStageEventPanel)
  end
  if options.clearWaiting and uid then
    self.model:SetGearWaitingForProto(uid, false)
  end
  BattleManager.Instance:EnterBattle(battleData, uid and self.model:IsGearRecovering(uid) or false)
  return true
end

function MapController:OnTriggerBattle(svrData)
  if not self:IsReady() then
    return
  end
  if not svrData then
    return
  end
  self:EnterGearBattleByUid(svrData.uid, svrData.data)
end

function MapController:OnTriggerGearData(svrData)
  if not self:IsReady() then
    return
  end
  if not svrData then
    return
  end
  Logger.Info("[NewMap] OnTriggerGearData", svrData.uid, svrData.tid)
  local uid = svrData.uid
  if not self.model:GetGearDataByUid(uid) then
    Logger.Warn("OnTriggerGearData not find Gear ", svrData.uid)
    self.model:ClearAllWaitingForProto()
    return
  end
  if self.model:IsGearRemovedMark(uid) then
    Logger.Warn("[NewMap] OnTriggerGearData skip removed gear", uid, svrData.tid)
    self.model:ClearAllWaitingForProto()
    self.model:EndGearTrigger(uid)
    local gearData = svrData.data
    if gearData and gearData.option and gearData.eventId then
      self:OpenEventPanelByUid(uid, svrData)
    end
    return
  end
  if svrData.data and svrData.data.battleTid and not CommonDefine.GearBattleType[self.model:GetGearType(uid)] then
    self:EnterGearBattleByUid(uid, svrData.data, {clearWaiting = true})
    return
  end
  self:OnGearTriggerDataInternalByUid(uid, svrData)
  local terrainMgr = self:GetComponent(MapTerrainManager)
  local x, y = self.model:GetGearPos(uid)
  local terrainItem
  if terrainMgr and x and y then
    terrainItem = terrainMgr:GetTerrainByPos(x, y)
  end
  if terrainItem then
    terrainItem:PlayTerrainTriggerEffect()
  end
  if svrData.data then
    LoginMgr.Instance.model:SetBattleServerNode(svrData.data.battleServerNode)
  end
end

function MapController:OnGearTriggerDataInternal(gearItem, svrData)
  self:OnGearTriggerDataInternalByUid(gearItem and gearItem:GetUid(), svrData)
end

function MapController:OnGearTriggerDataInternalByUid(uid, svrData)
  if not self:IsReady() then
    return
  end
  if not uid then
    return
  end
  self.model:SetGearSvrTriggerData(uid, svrData)
  WorldStageManager.Instance:SetCurTriggeredGearType(self.model:GetGearType(uid))
  self:PreTriggerByUid(uid, svrData)
end

function MapController:OnGearPreTrigger(gearItem, svrData)
  self:PreTriggerByUid(gearItem and gearItem:GetUid(), svrData)
end

function MapController:PreTrigger(gearItem, svrData)
  self:PreTriggerByUid(gearItem and gearItem:GetUid(), svrData)
end

function MapController:PreTriggerByUid(uid, svrData)
  if not self:IsReady() then
    return
  end
  if not uid then
    return
  end
  self.model:SetGearTriggerTime(uid, TimerManager.totalTime)
  if self.model:GetGearType(uid) == CommonDefine.GearItemType.ChangeAvatarRes then
    self:OnTriggerByUid(uid, svrData)
    return
  end
  local cfgData = self.model:GetGearConfigData(uid)
  local beginStoryList = cfgData and cfgData.BeginDialogueId
  if self:RunGearBeginStory(uid, beginStoryList, svrData) then
    return
  else
    self:OnTriggerByUid(uid, svrData)
  end
end

function MapController:OnGearDoTrigger(gearItem, svrData)
  self:OnTriggerByUid(gearItem and gearItem:GetUid(), svrData)
end

function MapController:OnTrigger(gearItem, svrData)
  self:OnTriggerByUid(gearItem and gearItem:GetUid(), svrData)
end

function MapController:OnTriggerByUid(uid, svrData)
  if not self:IsReady() then
    return
  end
  if not uid then
    return
  end
  Logger.Info("[Stage] GearItemBase OnTrigger uid, tid, type", uid, self.model:GetGearTid(uid), self.model:GetGearType(uid))
  local data = svrData and svrData.data
  if not data then
    Logger.Warn("[Stage] GearItemBase OnTrigger no data")
    return
  end
  if data.checkStartBattleAgain then
    data.checkStartBattleAgain = false
    Alert.Show(20068, function()
      self:ReqGearItemHandleByUid(uid, uid, {})
    end, function()
      self:EnterGearBattleByUid(uid, data)
    end, nil, nil, nil, true, {forbidBack = true})
    return
  end
  local handled = self.triggerHandler and self.triggerHandler:Handle(self, uid, svrData)
  if handled then
    self:MoveToPendingPosAfterTriggerDataByUid(uid)
    return
  end
  self:MoveToPendingPosAfterTriggerDataByUid(uid)
end

function MapController:MoveToPendingPosAfterTriggerData(gearItem)
  self:MoveToPendingPosAfterTriggerDataByUid(gearItem and gearItem:GetUid())
end

function MapController:MoveToPendingPosAfterTriggerDataByUid(uid)
  local movePos = self.model:TakeGearPendingMovePos(uid)
  if not movePos then
    return
  end
  if not self:IsGearRoleHere(uid) then
    Logger.Info("[NewMap] OnTrigger: 触发完成，移动到 Gear 位置", movePos.x, movePos.y)
    local moveMgr = self:GetComponent(MapMoveManager)
    if not moveMgr then
      return
    end
    moveMgr:MoveDuringGearTrigger(movePos.x, movePos.y, nil, uid)
  end
end

function MapController:OnGearMoveAndTrigger(gearItem)
  self:MoveAndDoTriggerByUid(gearItem and gearItem:GetUid())
end

function MapController:MoveAndDoTrigger(gearItem)
  do return self.MoveAndDoTriggerByUid, self end
  return self.MoveAndDoTriggerByUid, self, gearItem and gearItem:GetUid(), gearItem
end

function MapController:MoveAndDoTriggerByUid(uid)
  if not self:IsReady() then
    return false
  end
  if not uid then
    return false
  end
  Logger.Info("移动后触发")
  local x, y = self.model:GetGearPos(uid)
  if not x or not y then
    return false
  end
  if self:IsGearRoleHere(uid) then
    return false
  end
  local moveMgr = self:GetComponent(MapMoveManager)
  if moveMgr then
    do return moveMgr.DirectMoveDuringGearTrigger, moveMgr, x, y, nil end
    return moveMgr.DirectMoveDuringGearTrigger, moveMgr, x, y, nil, uid
  end
  return false
end

function MapController:OnGearTriggerAfterMonitorChoice(gearItem)
  self:TriggerAfterMonitorChoiceByUid(gearItem and gearItem:GetUid())
end

function MapController:TriggerAfterMonitorChoice(gearItem)
  self:TriggerAfterMonitorChoiceByUid(gearItem and gearItem:GetUid())
end

function MapController:TriggerAfterMonitorChoiceByUid(uid)
  if not self:IsReady() then
    return
  end
  if not uid then
    return
  end
  local nodeTypeCfg = self.model:GetGearNodeTypeConfig(uid)
  local trigger = 0
  if nodeTypeCfg then
    trigger = nodeTypeCfg.Trigger or 0
  end
  if 1 == trigger then
    self:ReqTriggerByUid(uid)
  elseif 2 == trigger then
    self:MoveAndDoTriggerByUid(uid)
  end
end

function MapController:OnGearOpenEventPanel(gearItem, userData, callBack)
  self:OpenEventPanelByUid(gearItem and gearItem:GetUid(), userData, callBack)
end

function MapController:OpenEventPanel(gearItem, userData, callBack)
  self:OpenEventPanelByUid(gearItem and gearItem:GetUid(), userData, callBack)
end

function MapController:OpenEventPanelByUid(uid, userData, callBack)
  if not self:IsReady() then
    return
  end
  if GuideManager.Instance then
    GuideManager.Instance:SetDisabled(true)
  end
  if not (userData and userData.data) or userData.data.eventId == nil or 0 == userData.data.eventId then
    Logger.Info("[NewMap] OpenEventPanel数据不对，eventId为0或者nil")
    self:AfterTriggerByUid(uid)
    return
  end
  if nil == callBack then
    function callBack(index, eventId)
      self:ReqChooseByUid(uid, index, eventId)
    end
  end
  self.model:SetGearEventPanelOpen(uid, true)
  local eventPanelComp = UIManager.Instance:GetWindow(Urls.WorldStageEventPanel)
  if eventPanelComp then
    eventPanelComp:SetCallFunc(callBack)
    eventPanelComp:RefreshDataByEventData(userData)
  else
    UIManager.Instance:OpenCopySceneUI(Urls.WorldStageEventPanel, userData, nil, callBack)
    self:PlayGearAudio(uid)
  end
end

function MapController:OnGearReqChoose(gearItem, index, eventId, callBack)
  self:ReqChooseByUid(gearItem and gearItem:GetUid(), index, eventId, callBack)
end

function MapController:ReqChoose(gearItem, index, eventId, callBack)
  self:ReqChooseByUid(gearItem and gearItem:GetUid(), index, eventId, callBack)
end

function MapController:ReqChooseByUid(uid, index, eventId, callBack)
  if not self:IsReady() then
    return
  end
  if not uid then
    return
  end
  if self:IsSkipBattleEvent(index, eventId) then
    self:InsertBattleSettleTip()
  end
  local isChoas = self.model:IsGearChoasNode(uid)
  local isMonitored = self.model:IsGearMonitored(uid)
  local evenCfg = DT.Event[eventId] or {}
  ProtoManager.Instance:ReqServer("WorldRequest", "OnGearChoose", function(data)
    data = data or {}
    local isClose = data.isClose
    if nil == isClose then
      isClose = nil == evenCfg["ChoiceJump" .. index]
    end
    Logger.Info("[NewMap] OnGearChooose Return", isClose, data.isCancel)
    local isAfterChooseHandled = self:RunGearAfterChoose(uid, data)
    if isClose then
      UIManager.Instance:CloseByUrl(Urls.WorldStageEventPanel)
      self.model:SetGearCancel(uid, data.isCancel)
      if not CommonDefine.GearBattleType[self.model:GetGearType(uid)] and not isAfterChooseHandled then
        self:AfterTriggerByUid(uid)
      end
      self.model:SetGearCancel(uid, nil)
    end
    if callBack then
      callBack(index)
    end
    if isMonitored and not isChoas and 1 ~= index then
      self:TriggerAfterMonitorChoiceByUid(uid)
    end
  end, function()
    UIManager.Instance:CloseByUrl(Urls.WorldStageEventPanel)
    self:AfterTriggerByUid(uid)
    if callBack then
      callBack(-1)
    end
  end, uid, index)
end

function MapController:OnGearReqHandle(gearItem, ...)
  self:ReqGearItemHandleByUid(gearItem and gearItem:GetUid(), ...)
end

function MapController:ReqGearItemHandle(gearItem, ...)
  self:ReqGearItemHandleByUid(gearItem and gearItem:GetUid(), ...)
end

function MapController:ReqGearItemHandleByUid(uid, ...)
  if not self:IsReady() then
    return
  end
  ProtoManager.Instance:ReqServer("WorldRequest", "OnGearHandle", function(data)
    EventMgr.Instance.OnGearHandle:Dispatch(data)
    self:NotifyGearHandleResult(uid, data)
  end, function(errorData)
    Logger.Warn("WorldRequest.OnGearHandle Error", table.tostring(errorData))
    self:NotifyGearHandleResult(uid)
  end, ...)
end

function MapController:OnGearAfterTrigger(gearItem)
  self:AfterTriggerByUid(gearItem and gearItem:GetUid())
end

function MapController:AfterTrigger(gearItem)
  self:AfterTriggerByUid(gearItem and gearItem:GetUid())
end

function MapController:AfterTriggerByUid(uid)
  if not self:IsReady() then
    return
  end
  if Main.isAppDestroyed then
    return
  end
  if not GuideManager.Instance then
    return
  end
  if not self.model:IsGearTriggering(uid) then
    self:RunGearEndStory(uid)
    return
  end
  WorldStageManager.Instance:SetCurTriggeredGearType(self.model:GetGearType(uid))
  Logger.Info("[NewMap] GearItemBase AfterTrigger", uid, self.model:GetGearTid(uid))
  self.model:EndGearTrigger(uid)
  GuideManager.Instance:SetDisabled(false)
  if self.model:IsGearCancel(uid) then
    return
  end
  if not SceneMgr.Instance:IsInCopies() then
    return
  end
  self:RunGearEndStory(uid)
  local movePos = self.model:TakeGearPendingMovePos(uid)
  if not movePos then
    return
  end
  if not self:IsGearRoleHere(uid) then
    Logger.Info("[NewMap] AfterTrigger: 移动到 Gear 位置", movePos.x, movePos.y)
    EventMgr.Instance.GearRoleMove:Dispatch(movePos.x, movePos.y)
  else
    Logger.Info("[NewMap] AfterTrigger: 角色已在 Gear 位置，不移动")
  end
end

function MapController:OnGearEventPanelClosed(gearItem, url)
  self:OnGearEventPanelClosedInternalByUid(gearItem and gearItem:GetUid(), url)
end

function MapController:OnGearEventPanelClosedInternal(gearItem, url)
  self:OnGearEventPanelClosedInternalByUid(gearItem and gearItem:GetUid(), url)
end

function MapController:OnGearEventPanelClosedInternalByUid(uid, url)
  if not self:IsReady() then
    return
  end
  if url ~= Urls.WorldStageEventPanel then
    return
  end
  self.model:SetGearEventPanelOpen(uid, nil)
  if self.model:IsGearTriggering(uid) and not self.model:IsGearWaitingForProto(uid) then
    Logger.Warn("[NewMap] EventPanel closed but gear still triggering, force end trigger", uid, self.model:GetGearTid(uid))
    self.model:EndGearTrigger(uid)
    if GuideManager.Instance then
      GuideManager.Instance:SetDisabled(false)
    end
  end
end

function MapController:OnGearBattleResult()
  if not self:IsReady() then
    return
  end
  local settleData = DataCenter and DataCenter.copiesData and DataCenter.copiesData.copiesSettleData
  local curStageId = self.model.stageData and self.model.stageData.stageId
  local isCurStageSettle = settleData and (not curStageId or settleData.stageId == curStageId or settleData.worldTid == curStageId)
  if isCurStageSettle then
    Logger.Info("[NewMap] OnGearBattleResult skip OnGearHandle, copiesSettleData existed")
    return
  end
  local gearMgr = self:GetComponent(MapGearManager)
  local gearItem
  if gearMgr then
    gearItem = gearMgr:GetTriggerObj()
  end
  if gearItem then
    self:ReqGearItemHandleByUid(gearItem:GetUid(), gearItem:GetUid(), {})
  end
end

return MapController
