local Default_Awaiter_Timeout = 3
local MapNetEventManager, Super = System.NewClass("MapNetEventManager", Manager)

function MapNetEventManager:ctor()
  Super.ctor(self)
  self._isMapEntered = false
  self.stageAwaiters = {}
  self.stopAllStageAwaiters = {}
  self.allAwaiters = {}
end

function MapNetEventManager:Awake(binder)
  self.binder = binder
  self.protos = {
    OnGearDelete = System.fn(self, self.OnGearDelete),
    OnTriggerGearData = System.fn(self, self.OnTriggerGearData),
    OnTriggerBattle = System.fn(self, self.OnTriggerBattle),
    OnSyncView = System.fn(self, self.OnSyncView),
    OnDestructionGear = System.fn(self, self.OnDestructionGear),
    OnNewGearData = System.fn(self, self.OnNewGearData),
    OnSyncWorldDataByReconnect = System.fn(self, self.OnSyncWorldDataByReconnect),
    OnSyncWorldTaskFinish = System.fn(self, self.OnSyncWorldTaskFinish),
    OnSyncWorldTaskUnlock = System.fn(self, self.OnSyncWorldTaskUnlock),
    OnSyncWorldStats = System.fn(self, self.OnSyncWorldStats),
    OnSyncRailWayWorld = System.fn(self, self.OnSyncRailWayWorld),
    OnSyncRelic = System.fn(self, self.OnSyncRelic),
    OnChaosRelic = System.fn(self, self.OnChaosRelic),
    OnSyncGearInfo = System.fn(self, self.OnSyncGearInfo),
    OnSyncWorldPlayerPos = System.fn(self, self.OnSyncWorldPlayerPos),
    OnReviveChoose = System.fn(self, self.OnReviveChoose),
    OnSyncWorldAchivementData = System.fn(self, self.OnSyncWorldAchivementData),
    OnSyncWorldTaskData = System.fn(self, self.OnSyncWorldTaskData)
  }
  binder:BindEvent(EventMgr.Instance.BattleResult, System.fn(self, self.OnGearBattleResult))
  binder:BindEvent(EventMgr.Instance.StageAwaiterArise, System.fn(self, self.OnStageAwaiter))
  binder:BindTimer(0.05, -1, System.fn(self, self.ProcessMsgQueue), nil)
end

function MapNetEventManager:ProcessMsgQueue()
  if not self._netMsgComp then
    self._netMsgComp = self:GetNetMsgComp()
  end
  if not self._netMsgComp then
    return
  end
  if not self._isMapEntered then
    return
  end
  if bg.battleRender then
    return
  end
  if self:CheckIsHaveAwaiter() then
    return
  end
  local msg = self._netMsgComp:PopMsg()
  if not msg then
    return
  end
  while msg do
    self:DealProto(msg.protoName, msg.protoData)
    if self:CheckIsHaveAwaiter() then
      break
    end
    msg = self._netMsgComp:PopMsg()
  end
end

function MapNetEventManager:CheckIsHaveAwaiter()
  local curTime = TimerManager.totalTime
  for awaiter, timeoutInfo in pairs(self.stageAwaiters) do
    if curTime >= timeoutInfo.overTime then
      self.stageAwaiters[awaiter] = nil
      if not awaiter.completed then
        awaiter:SetCompleted()
      end
      awaiter:Recycle()
    end
  end
  return nil ~= table.next(self.stageAwaiters)
end

function MapNetEventManager:GetNetMsgComp()
  if not self.parent or not self.parent.owner then
    return nil
  end
  return self.parent.owner.netMsgComp
end

function MapNetEventManager:GetStageData()
  do return MapModel.Instance.GetStageData end
  return MapModel.Instance.GetStageData, MapModel.Instance
end

function MapNetEventManager:DealProto(protoName, protoData)
  local protoFunc = self.protos and self.protos[protoName]
  if protoFunc then
    protoFunc(protoData)
  end
end

function MapNetEventManager:OnInit()
  local stageData = self:GetStageData()
  if not stageData then
    return
  end
  if WorldRecoveryManager.Instance:IsRecovery() then
    self.binder:BindTimer(0.8, 0, nil, function()
      self:OnRecovery()
    end)
  elseif stageData.gearTriggerData then
    local netMsgComp = self:GetNetMsgComp()
    if netMsgComp then
      netMsgComp:PushMsg("OnTriggerGearData", stageData.gearTriggerData)
    else
      self:OnTriggerGearData(stageData.gearTriggerData)
    end
  end
end

function MapNetEventManager:OnAfterEnter()
  local stageData = self:GetStageData()
  if not stageData then
    return
  end
  if not WorldRecoveryManager.Instance:IsRecovery() and stageData.relic then
    local Type = DT.StageGroup[stageData.groupId].Type
    local title = self.ShowRelicTitle(Type)
    if "" ~= title then
      self:OpenGetRelicUI(stageData.relic, title)
    end
  end
  if stageData and stageData.choasRelics then
    local netMsgComp = self:GetNetMsgComp()
    local hasChoasRelicInQueue = false
    if netMsgComp then
      for _, msg in ipairs(netMsgComp.msgQueue) do
        if msg.protoName == "OnChaosRelic" then
          hasChoasRelicInQueue = true
          break
        end
      end
    end
    if not hasChoasRelicInQueue then
      self:OnChaosRelic(stageData.choasRelics)
    end
  end
  ProtoManager.Instance.GameRequest:OnWorldEnterSuccess()
  self._isMapEntered = true
end

local __ShowRelicList = {
  [CommonDefine.StageGroupType.WeeklyCopy] = "GetRelic",
  [CommonDefine.StageGroupType.WeeklyCopy2] = "GetRelic",
  [CommonDefine.StageGroupType.DailyChallenge] = "GetRelic"
}

function MapNetEventManager.ShowRelicTitle(groupType)
  local ret = __ShowRelicList[groupType]
  if not ret then
    return ""
  end
  if type(ret) == "string" then
    do return LT.Text end
    return LT.Text, "GetRelic"
  end
end

function MapNetEventManager:OpenGetRelicUI(relic, title, callFunc)
  if relic and 0 ~= #relic then
    local relicList = {}
    for _, value in pairs(relic) do
      table.insert(relicList, value.tid)
    end
    UIManager.Instance:OpenCopySceneUI(Urls.LevelUnlockRelicView, relicList, callFunc, title)
  end
end

function MapNetEventManager:OnRecovery()
  local curEventData = WorldRecoveryManager.Instance:GetRecoverEventData()
  if curEventData then
    self:OnRecoverGear(curEventData)
  end
  local itemsData = WorldRecoveryManager.Instance:GetItemsData()
  if itemsData then
    for _, v in pairs(itemsData) do
      if 3 == v.type then
        ShopDataUtils.OpenRuneCardSelectPanel(v.tid)
        break
      end
    end
  end
  local stageData = self:GetStageData()
  if stageData and stageData.map then
    local showViewDataList = stageData.map.showViewDataList
    if showViewDataList and #showViewDataList > 0 then
      for _, v in pairs(showViewDataList) do
        self:OnSyncView({showView = v})
      end
    end
  end
end

function MapNetEventManager:OnRecoverGear(gearData)
  if not gearData then
    return
  end
  local gearMgr = self:GetComponent(MapGearManager)
  if not gearMgr then
    return
  end
  local gearItem = gearMgr:GetGearByUid(gearData.uid)
  if gearItem then
    gearItem:SetIsRecovering(true)
    self:OnTriggerGearData(gearData)
    gearItem:SetIsRecovering(false)
  end
end

function MapNetEventManager:OnGearDelete(data)
  if not data then
    return
  end
  local gearMgr = self:GetComponent(MapGearManager)
  if not gearMgr then
    return
  end
  for _, uid in ipairs(data) do
    gearMgr:RemoveGearByUid(uid)
  end
end

function MapNetEventManager:IsEnabled()
  return true
end

function MapNetEventManager:IsPrevDropTerrain()
  local roleMgr = self:GetComponent(MapRoleManager)
  if not roleMgr or not roleMgr.role then
    return
  end
  local role = roleMgr.role
  local prevPosX, prevPosY = role:GetPrevPos()
  local gearMgr = self:GetComponent(MapGearManager)
  if not gearMgr then
    return
  end
  local curGear = gearMgr:GetGearByPos(prevPosX, prevPosY)
  if curGear and curGear:GetType() == CommonDefine.GearItemType.DropTerrain then
    return true
  end
end

function MapNetEventManager:OnTriggerGearData(svrData)
  if not svrData then
    return
  end
  if not self:IsEnabled() then
    return
  end
  if self:IsPrevDropTerrain() then
    local triggerFunc
    
    function triggerFunc()
      EventMgr.Instance.TerrainDropDone:RemoveEvent(triggerFunc)
      self:_OnTriggerGearData(svrData)
    end
    
    EventMgr.Instance.TerrainDropDone:RegisterEvent(triggerFunc)
    local triggerDelay = DT.GetConstant("GridTriggerDelay", 0.3)
    self.binder:BindTimer(triggerDelay, 0, nil, triggerFunc)
  else
    self:_OnTriggerGearData(svrData)
  end
end

function MapNetEventManager:_OnTriggerGearData(svrData)
  MapController.Instance:OnTriggerGearData(svrData)
end

function MapNetEventManager:OnTriggerBattle(svrData)
  if not svrData then
    return
  end
  if not self:IsEnabled() then
    return
  end
  Logger.Info("[NewMap] OnTriggerBattle", table.tostring(svrData))
  MapController.Instance:OnTriggerBattle(svrData)
end

function MapNetEventManager:OnGearBattleResult()
  if not self:IsEnabled() then
    return
  end
  MapController.Instance:OnGearBattleResult()
end

function MapNetEventManager:OnSyncView(svrData)
  if not svrData then
    return
  end
  if svrData.showView then
    if not (type(svrData.showView) == "table" and svrData.showView.range) or svrData.showView.range <= 0 then
      return
    end
    local roleMgr = self:GetComponent(MapRoleManager)
    if not roleMgr or not roleMgr.role then
      return
    end
    local posX, posY = roleMgr.role:GetGridPos()
    if svrData.showView.x then
      posX = svrData.showView.x
      posY = svrData.showView.y
    end
    roleMgr:SetMist(posX, posY, svrData.showView.range)
  elseif svrData.view then
    if self.parent then
      self.parent.roleFOV = svrData.view
    end
    MapModel.Instance:SetRoleFOV(svrData.view)
    local roleMgr = self:GetComponent(MapRoleManager)
    if not roleMgr or not roleMgr.role then
      return
    end
    local posX, posY = roleMgr.role:GetGridPos()
    roleMgr:SetMist(posX, posY, svrData.view)
    roleMgr:GetRole():SetFireParam(svrData.view)
  end
end

function MapNetEventManager:OnSyncWorldAchivementData(svrData)
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if not stageData or not stageData.achivement then
    return
  end
  for _, task in pairs(svrData) do
    if stageData.achivement[task.tid] then
      stageData.achivement[task.tid].count = task.count
    end
  end
end

function MapNetEventManager:OnSyncWorldTaskData(svrData)
  local stageData = WorldStageManager.Instance:GetCurStageData()
  if not (stageData and stageData.ChallengeScore and stageData.ChallengeScore.taskList) or not svrData then
    return
  end
  for tid, task in pairs(svrData) do
    if stageData.ChallengeScore.taskList[tid] then
      stageData.ChallengeScore.taskList[tid].count = task.count
    end
  end
end

function MapNetEventManager:OnDestructionGear(data)
  local terrainMgr = self:GetComponent(MapTerrainManager)
  if terrainMgr then
    terrainMgr:DestroyTerrain(data)
  end
end

function MapNetEventManager:OnNewGearData(data)
  if not data then
    return
  end
  local roleMgr = self:GetComponent(MapRoleManager)
  local gearMgr = self:GetComponent(MapGearManager)
  local terrainMgr = self:GetComponent(MapTerrainManager)
  for k, v in pairs(data) do
    Logger.Info("OnNewGearData AddGear", v.uid, v.tid)
    if 0 == v.type then
      if terrainMgr then
        terrainMgr:Create(v.x, v.y, nil, nil, true)
      end
    elseif v.type == CommonDefine.GearItemType.Wall then
      MapModel.Instance:AddGearData(v)
      if terrainMgr then
        terrainMgr:RemoveTerrain(v.x, v.y)
      end
    else
      if gearMgr then
        gearMgr:AddGear(v, v.x, v.y)
      end
      if terrainMgr then
        terrainMgr:Create(v.x, v.y, nil, nil, true)
      end
    end
  end
  if roleMgr and roleMgr:GetRole() and terrainMgr then
    local curPosX, curPosY = roleMgr.role:GetGridPos()
    terrainMgr:UpdateClickTip(curPosX, curPosY)
    terrainMgr:UpdateClickable()
  end
end

local function ReplaceData(srcData, destData, attrName)
  if not srcData then
    return
  end
  for _, v in pairs(srcData) do
    for index, info in pairs(destData) do
      if info[attrName] == v[attrName] then
        destData[index] = v
        break
      end
    end
  end
end

local function RemoveData(srcData, destData, attrName)
  if not srcData then
    return
  end
  for _, v in pairs(srcData) do
    for index, info in pairs(destData) do
      if info[attrName] == v then
        table.remove(destData, index)
        break
      end
    end
  end
end

function MapNetEventManager:CheckReconnectData()
  if self.reconnectData then
    self:OnSyncWorldDataByReconnect(self.reconnectData)
  end
end

function MapNetEventManager:OnSyncWorldDataByReconnect(data)
end

function MapNetEventManager:OnSyncWorldTaskFinish(finishList)
  if not finishList then
    return
  end
  local stageData = self:GetStageData()
  if not stageData then
    return
  end
  local tasks = stageData.tasks or {}
  for _, taskTid in ipairs(finishList) do
    if tasks[taskTid] then
      tasks[taskTid].state = CommonDefine.TaskState.Done
    end
  end
end

function MapNetEventManager:OnSyncWorldTaskUnlock(finishList)
  if not finishList then
    return
  end
  local stageData = self:GetStageData()
  if not stageData then
    return
  end
  local tasks = stageData.tasks or {}
  for _, taskTid in ipairs(finishList) do
    if tasks[taskTid] then
      tasks[taskTid].lock = false
    end
  end
end

function MapNetEventManager:OnSyncWorldStats(data)
  if not data then
    return
  end
  local stageData = self:GetStageData()
  if not stageData then
    return
  end
  stageData.stats = stageData.stats or {}
  for k, v in pairs(data) do
    stageData.stats[k] = v
  end
end

function MapNetEventManager:OnSyncRailWayWorld(data)
  if not data then
    return
  end
  local stageData = self:GetStageData()
  if not stageData then
    return
  end
  Logger.Proto("OnSyncRailWayWorld:Data", table.tostring(data))
  stageData.railWayData = stageData.railWayData or {}
  for k, v in pairs(data) do
    stageData.railWayData[k] = v
  end
end

function MapNetEventManager:OnSyncCard(data)
  if not data then
    return
  end
  for _, card in pairs(data) do
    if card.type == "add" then
      self:OnAddCard(card.uid, card.tid)
    end
  end
end

function MapNetEventManager:OpenCardFlyPanel(cardUid, cardTid)
  local stagePanel = UIManager.Instance:GetWindow(Urls.WorldStageMainPanel)
  if not stagePanel then
    return
  end
  local worldPos = stagePanel:GetCardBagWorldPos()
  UIManager.Instance:InsertCopyUIReopenQueue(Urls.WorldStageCardFlyPanel, {cardTid}, {cardUid}, worldPos)
end

function MapNetEventManager:OnAddCard(cardUid, cardTid)
  if not IntroductionDataUtils.IsFinish() then
    return
  end
  self.binder:BindTimer(0.2, 0, nil, function()
    self:OpenCardFlyPanel(cardUid, cardTid)
  end)
end

function MapNetEventManager:ShowRelicReward(relicTid)
  if not relicTid then
    return
  end
  local relicData = {
    uid = nil,
    relicTid = relicTid,
    itemType = CommonDefine.WorldStageShopItemType.Relic
  }
  if SceneMgr.Instance:IsInCopies() then
    UIManager.Instance:InsertCopyUIReopenQueue(Urls.WorldStageRelicShowPanel, relicData)
  else
    self.binder:BindTimer(0.2, 0, nil, function()
      UIManager.Instance:InsertCopyUIReopenQueue(Urls.WorldStageRelicShowPanel, relicData)
    end)
  end
end

function MapNetEventManager:OnSyncRelic(data)
  if not data then
    return
  end
  local worldEventPanel = UIManager.Instance:GetWindow(Urls.WorldStageEventPanel)
  if not worldEventPanel then
    return
  end
  for _, value in ipairs(data) do
    local relicData = value.relicData
    if not relicData then
    elseif relicData.tid == DT.GetConstant("RelicKey") then
      do
        local stageData = WorldStageManager.Instance:GetCurStageData()
        if not stageData then
        else
          if not stageData.specialItemBag then
            stageData.specialItemBag = {}
          end
          table.insert(stageData.specialItemBag, {
            tid = relicData.tid,
            uid = relicData.uid
          })
        end
      end
    elseif value.type == "add" then
      self:ShowRelicReward(relicData.tid)
    end
  end
end

function MapNetEventManager:OnChaosRelic(data)
  if not data then
    return
  end
  local relics = {}
  for _, tid in ipairs(data) do
    table.insert(relics, {tid = tid, uid = tid})
  end
  local userData = {
    confirmCb = function(uids, callFunc)
      Logger.Info("==OnChaosRelic====", uids[1], table.tostring(uids))
      callFunc = callFunc or function()
      end
      ProtoManager.Instance:ReqServer("WorldRequest", "SelectChaosRelic", function()
        callFunc()
      end, function()
        callFunc()
      end, uids[1])
    end,
    maxCount = 1,
    mustSelect = false,
    relics = relics,
    titleStr = LT.Textf("ChaosSchool_RelicTips")
  }
  UIManager.Instance:InsertCopyUIShowQueue(Urls.WorldStageRelicThreeSelectPanel, userData)
end

function MapNetEventManager:OnSyncGearInfo(gearInfo)
  if not gearInfo then
    return
  end
  local gearMgr = self:GetComponent(MapGearManager)
  for uid, data in pairs(gearInfo) do
    MapModel.Instance:SyncGearData(uid, data)
    local gearItem = gearMgr and gearMgr:GetGearByUid(data.uid)
    if gearItem then
      gearItem:OnSyncGearInfo(data)
    end
  end
end

function MapNetEventManager:OnSyncWorldPlayerPos(pos)
  if pos and pos.x and pos.y then
    local moveMgr = self:GetComponent(MapMoveManager)
    if moveMgr then
      moveMgr:TransToPos(pos.x, pos.y)
    end
  end
end

function MapNetEventManager.GetTreeSelectTitleDesc(desc, chooseNum)
  local rst = ""
  if desc and "" ~= desc then
    rst = LT.Text(desc)
  else
    rst = LT.Textf("Relic_Select", chooseNum or 1)
  end
  return rst
end

function MapNetEventManager:OnStageAwaiter(awaiter, desc, overTime, isStopAll)
  if not awaiter then
    return
  end
  self.stageAwaiters = self.stageAwaiters or {}
  self.stageAwaiters[awaiter] = {
    overTime = TimerManager.totalTime + (overTime or Default_Awaiter_Timeout),
    desc = desc,
    isStopAll = isStopAll
  }
  awaiter:OnCompleted(System.fn(self, self.OnStageAwaiterCompleted))
end

function MapNetEventManager:OnStageAwaiterCompleted(awaiter)
  if awaiter and self.stageAwaiters[awaiter] then
    self.stageAwaiters[awaiter] = nil
    awaiter:Recycle()
  end
end

function MapNetEventManager:RecycleAllStageAwaiters()
  if self.stageAwaiters then
    for awaiter in pairs(self.stageAwaiters) do
      awaiter:Recycle()
    end
    self.stageAwaiters = {}
  end
  if self.allAwaiters then
    self.allAwaiters = {}
  end
  if self.stopAllStageAwaiters then
    self.stopAllStageAwaiters = {}
  end
end

function MapNetEventManager:OnReviveChoose(data)
  if self.respawnQueue then
    self.respawnQueue:OnDestroy()
  end
  local queue = Z1Queue()
  self.respawnQueue = queue
  AudioManager.Instance:PostSoundEvent("Play_UI_Ft_Anim_Player_KO")
  queue:Insert("RespawnIn", function()
    UIManager.Instance:Reopen(Urls.TimelineVideoUIAdd, "Vx/DeadResistance_In_Rgb.mp4", "Vx/DeadResistance_In_Alpha.mp4", false, function()
      queue:Next()
    end, 1.33)
  end)
  queue:Insert("RespawnTip", function()
    local stageData = WorldStageManager.Instance:GetCurStageData()
    local stageCfg = DT.Stage[stageData.stageId]
    if not stageCfg.RevivalAllowed or 1 == stageCfg.RevivalAllowed then
      if data.respawnedNum <= 0 then
        local viewData = {
          confirmFunc = function()
            ProtoManager.Instance.WorldRequest:OnRevive(true)
          end,
          cancelFunc = function()
            ProtoManager.Instance.WorldRequest:OnRevive(false)
          end
        }
        BattleBackTrackUtils.OpenRebirthChargeView(viewData)
      else
        local tipsId = 20079
        if self.isIntro then
          tipsId = 20080
        end
        local cfg = DT.TipsType[tipsId]
        local maxNum = DT.Constant.RevivalItemNumLimit.Data[1]
        local detail = LT.Textf(cfg.Desc, data.respawnedNum, maxNum)
        Alert.Show(tipsId, function()
          ProtoManager.Instance.WorldRequest:OnRevive(false)
        end, function()
          ProtoManager.Instance.WorldRequest:OnRevive(true)
        end, nil, detail, nil, nil, nil, true)
      end
    else
      ProtoManager.Instance.WorldRequest:OnRevive(false)
      queue:OnDestroy()
      self.respawnQueue = nil
    end
  end)
  queue:Insert("ShowRespawn", function()
    queue:Next()
  end)
  queue:Insert("RespawnEnd", function()
    queue:OnDestroy()
    self.respawnQueue = nil
  end)
end

return MapNetEventManager
