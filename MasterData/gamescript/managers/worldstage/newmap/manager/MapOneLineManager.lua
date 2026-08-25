local MapOneLineManager, Super = System.NewClass("MapOneLineManager", MapNetEventManager)
MapOneLineManager.BeforeEnterUid = nil
MapOneLineManager.PrintInterval = 15
local BlockTriggerUrls = {
  Urls.AlertConfirm2Panel,
  Urls.WorldStageRelicSelectPanel,
  Urls.WorldStageRelicThreeSelectPanel,
  Urls.WorldStageRelicShowPanel,
  Urls.WorldStageSelectSingleCardPanel,
  Urls.WorldStageCardSelectPanel,
  Urls.WorldStageBattleRewardPanel,
  Urls.WorldStageCardFlyPanel,
  Urls.CardFeatureInfoPanel,
  Urls.WorldStageNewShopPanel,
  Urls.CopySpecialShopView,
  Urls.WorldStageAwakerSelectPanel,
  Urls.DbgMainCopyAwakerSelectionPanel,
  Urls.WorldStageCurseCardPanel,
  Urls.WorldStageRemoveCardConfirm,
  Urls.WorldStageShopCardPanel,
  Urls.WorldStageShopConfirmPanel
}

function MapOneLineManager:ctor()
  Super.ctor(self)
  self.gears = nil
  self.allData = {}
  self._TriggerDatas = {}
  self._triggerVersionByUid = {}
  self._markTriggeredUidDict = {}
  self.deleteUids = {}
  self._isNeedTrigger = false
  self._lastPrintTime = 0
  print("[MapOneLineManager] ctor - 管理器创建")
end

function MapOneLineManager:Awake(binder)
  Super.Awake(self, binder)
  binder:SetAssetTarget(self)
  self.rootNode = CS.UnityEngine.GameObject.Find("mapRoot/roleRoot")
  self.rootTransform = self.rootNode.transform
  self.isRecovering = WorldRecoveryManager.Instance:IsRecovery()
  binder:BindEvent(EventMgr.Instance.MapEnterFinished, System.fn(self, self.OnMapEnterFinished))
  binder:BindEvent(EventMgr.Instance.BattleFinish, System.fn(self, self.OnGearBattleFinish))
  binder:BindEvent(EventMgr.Instance.WorldReadyExit, System.fn(self, self.OnWorldReadyExit))
  binder:BindEvent(EventMgr.Instance.WorldExitFailed, System.fn(self, self.OnWorldExitFailed))
  binder:BindEvent(EventMgr.Instance.OnWorldExit, System.fn(self, self.OnWorldExit))
  binder:BindResponse(self, "World", "OnGmWorldExit", System.fn(self, self.OnGmWorldExit))
  self:StartTick()
  if WorldRecoveryManager.Instance:IsRecovery() then
    self:CheckReviveTips()
  end
end

function MapOneLineManager:_PrintState(prefix)
  prefix = prefix or "[MapOneLineManager]"
  local gearCount = self.gears and #self.gears or 0
  local finishedCount = 0
  local triggerDataCount = 0
  for _ in pairs(self._TriggerDatas) do
    triggerDataCount = triggerDataCount + 1
  end
  local finishedNames = {}
  local nextGearName = "none"
  if self.gears then
    for _, gear in ipairs(self.gears) do
      if gear.isFinished or gear.state == cd.GearState.Finished then
        finishedCount = finishedCount + 1
        local name = self:GetGearNameByUid(gear.uid)
        table.insert(finishedNames, name)
      end
    end
    for _, gear in ipairs(self.gears) do
      if not gear.isFinished and gear.state ~= cd.GearState.Finished then
        nextGearName = self:GetGearNameByUid(gear.uid)
        break
      end
    end
  end
  local curUidName = self.curUid and self:GetGearNameByUid(self.curUid)
  local curGearIndex = self.curUid and self:GetGearIndexByUid(self.curUid)
  if curUidName then
    if curGearIndex then
      curUidName = string.format("%s[%d/%d,uid:%s]", curUidName, curGearIndex, gearCount, self.curUid)
    else
      curUidName = string.format("%s[uid:%s]", curUidName, self.curUid)
    end
  end
  local finishedNamesStr = #finishedNames > 0 and table.concat(finishedNames, ",") or "none"
  print(string.format("%s State - curGear:%s, needTrigger:%s, gears:%d/%d finished, triggerDatas:%d, isRecovering:%s", prefix, curUidName or "nil", self._isNeedTrigger and "true" or "false", finishedCount, gearCount, triggerDataCount, self.isRecovering and "true" or "false"))
  print(string.format("%s NextNode: [%s], FinishedNodes: [%s]", prefix, nextGearName, finishedNamesStr))
end

function MapOneLineManager:_TryPrintDebug(reason)
  local now = TimeUtils.GetServerTime()
  if now - self._lastPrintTime >= MapOneLineManager.PrintInterval then
    self._lastPrintTime = now
    print(string.format("[MapOneLineManager] OnTick return: %s", reason or "unknown"))
    self:_PrintState("[MapOneLineManager] OnTick")
  end
end

function MapOneLineManager:DoTickImmediate()
  self:OnTick()
end

function MapOneLineManager:OnTick()
  if not self._tickTimer then
    return
  end
  if bg.battleRender or bg.battleScene then
    self:_TryPrintDebug("[MapOneLineManager]Stop by battle")
    return
  end
  for _, url in ipairs(BlockTriggerUrls) do
    if UIManager.Instance:GetWindow(url) then
      self:_TryPrintDebug("[MapOneLineManager]Stop by window open" .. url)
      return
    end
  end
  if self:IsHaveCmdData() then
    self:_TryPrintDebug("[MapOneLineManager]Stop by cmd data")
    return
  end
  local now = TimeUtils.GetServerTime()
  if self._delayDoTriggerTime and now < self._delayDoTriggerTime then
    self:_TryPrintDebug("[MapOneLineManager]Stop by delay do trigger time")
    return
  end
  local triggerData = table.next(self._TriggerDatas)
  if triggerData then
    self:_DoGearTrigger(triggerData)
    self:_TryPrintDebug("[MapOneLineManager]Process trigger data")
    return
  end
  if UIManager.Instance:GetWindow(Urls.WorldStageEventPanel) then
    self:_TryPrintDebug("[MapOneLineManager]Stop by event panel open")
    return
  end
  if not self:GetNeedTrigger() then
    self:_TryPrintDebug("[MapOneLineManager]Stop by not need trigger")
    return
  end
  self:TriggerNextGear()
end

function MapOneLineManager:StartTick()
  self:StopTick()
  self._tickTimer = self.binder:BindTimer(0.7, -1, System.fn(self, self.OnTick))
end

function MapOneLineManager:StopTick()
  if self._tickTimer then
    self.binder:StopTimer(self._tickTimer)
    self._tickTimer = nil
  end
end

function MapOneLineManager:OnWorldReadyExit()
  print("[MapOneLineManager] OnWorldReadyExit - 准备退出副本")
  self:StopTick()
end

function MapOneLineManager:OnWorldExitFailed()
  print("[MapOneLineManager] OnWorldExitFailed - 退出副本失败")
end

function MapOneLineManager:OnWorldExit(data)
  print("[MapOneLineManager] OnWorldExit - 退出副本，停止定时器")
  self:StopTick()
end

function MapOneLineManager:OnGmWorldExit(data)
  print("[MapOneLineManager] OnGmWorldExit - GM退出副本，停止定时器")
  self:StopTick()
end

function MapOneLineManager:OnInit()
  self.gears = self.parent:GetGearData()
  print("[MapOneLineManager] OnInit - 初始化节点数据, gears count:", self.gears and #self.gears or 0)
  table.sort(self.gears, function(a, b)
    return a.x < b.x
  end)
  self.allData = self.parent.stageData
  if self.gears and #self.gears > 0 then
    local gearNames = {}
    for i, gear in ipairs(self.gears) do
      local name = self:GetGearNameByUid(gear.uid)
      local stateStr = gear.isFinished and "finished" or gear.state and tostring(gear.state) or "none"
      table.insert(gearNames, string.format("%d.%s[uid:%s,state:%s]", i, name, gear.uid, stateStr))
    end
    print(string.format("[MapOneLineManager] OnInit - 所有节点列表: \n %s", table.concat(gearNames, ",\n")))
  end
  self:_PrintState("[MapOneLineManager] OnInit")
end

function MapOneLineManager:OnAfterEnter()
  ProtoManager.Instance.GameRequest:OnWorldEnterSuccess()
  self._isMapEntered = true
end

function MapOneLineManager:CheckReviveTips()
  local stageData = self.parent.stageData
  local role = stageData.role
  if role and role.hp and role.hp <= 0 then
    self:OnReviveChoose({
      respawnedNum = stageData.respawnedNum
    })
  end
end

function MapOneLineManager:DealCacheProtoData()
  print("[MapOneLineManager] DealCacheProtoData - 开始处理缓存协议数据")
  local ProtoOnChaosRelic = "OnChaosRelic"
  local isHaveChoasRelicProto = false
  if MapNetEventManager.protoCacheData then
    local protoCount = 0
    for _ in pairs(MapNetEventManager.protoCacheData) do
      protoCount = protoCount + 1
    end
    print(string.format("[MapOneLineManager] DealCacheProtoData - 缓存协议数量:%d", protoCount))
    for protoName, cacheData in pairs(table.clone(MapNetEventManager.protoCacheData)) do
      if "OnGearDelete" == protoName then
        print(string.format("[MapOneLineManager] DealCacheProtoData - 处理删除节点协议"))
        MapNetEventManager.protoCacheData[protoName] = nil
        self:DealProto(protoName, cacheData)
      end
    end
    for protoName, cacheData in pairs(MapNetEventManager.protoCacheData) do
      local data = cacheData.data or {}
      if "OnTriggerGearData" == protoName and cacheData.uid == MapOneLineManager.BeforeEnterUid and data.battleTid then
        print("-------------已经在 before battle 中处理过", table.tostring(cacheData))
      else
        print(string.format("[MapOneLineManager] DealCacheProtoData - 处理协议:%s, uid:%s", protoName, cacheData.uid))
        self:DealProto(protoName, cacheData)
        if protoName == ProtoOnChaosRelic then
          isHaveChoasRelicProto = true
        end
      end
    end
    MapNetEventManager.protoCacheData = nil
  end
  local stageData = self.parent.stageData
  if stageData and stageData.choasRelics and not isHaveChoasRelicProto then
    print(string.format("[MapOneLineManager] DealCacheProtoData - 处理混沌遗物，数量:%d", #stageData.choasRelics))
    self:OnChaosRelic(stageData.choasRelics)
    return
  end
  if not table.next(self._TriggerDatas) then
    print("[MapOneLineManager] DealCacheProtoData - 无触发数据，设置需要触发")
    self:SetNeedTrigger(true)
  else
    print(string.format("[MapOneLineManager] DealCacheProtoData - 仍有触发数据，数量:%d", self:_GetTriggerDataCount()))
  end
  self:_PrintState("[MapOneLineManager] DealCacheProtoData")
end

function MapOneLineManager:SetNeedTrigger(isNeedTrigger)
  if self._isNeedTrigger ~= isNeedTrigger then
    print(string.format("[MapOneLineManager] SetNeedTrigger - %s -> %s", self._isNeedTrigger and "true" or "false", isNeedTrigger and "true" or "false"))
  end
  self._isNeedTrigger = isNeedTrigger
end

function MapOneLineManager:GetNeedTrigger()
  return self._isNeedTrigger
end

function MapOneLineManager:OnShow()
end

function MapOneLineManager:OnMapEnterFinished()
  print("[MapOneLineManager] OnMapEnterFinished - 地图进入完成")
  self:_RemoveGearDelete(self.protoCacheData)
  if self.protoCacheData and table.next(self.protoCacheData) then
    print("[MapOneLineManager] OnMapEnterFinished - 处理缓存协议数据")
    self:DealCacheProtoData()
  else
    print("[MapOneLineManager] OnMapEnterFinished - 无缓存数据，设置需要触发")
    self:SetNeedTrigger(true)
  end
  self:_PrintState("[MapOneLineManager] OnMapEnterFinished")
end

function MapOneLineManager:_RemoveGearDelete(protoCacheData)
  if protoCacheData then
    protoCacheData.OnGearDelete = nil
  end
end

function MapOneLineManager:TriggerNextGear()
  print("[MapOneLineManager] TriggerNextGear - 开始查找下一个未完成的节点")
  local found = false
  local gearCount = self.gears and #self.gears or 0
  for i, gear in ipairs(self.gears) do
    if not gear.isFinished and gear.state ~= cd.GearState.Finished then
      self.curUid = gear.uid
      local gearName = self:GetGearNameByUid(gear.uid)
      print(string.format("[MapOneLineManager] TriggerNextGear - 找到节点 [%d/%d] %s, uid:%s, type:%s, tid:%s, state:%s", i, gearCount, gearName, gear.uid, gear.type, gear.tid, gear.state))
      self:ReqTrigger(gear.uid)
      found = true
      break
    end
  end
  if not found then
    print("[MapOneLineManager] TriggerNextGear - 未找到未完成的节点，所有节点已完成")
  end
end

function MapOneLineManager:OnChaosRelic(data)
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
        self:TriggerNextGear()
      end, function()
        callFunc()
        self:TriggerNextGear()
      end, uids[1])
    end,
    maxCount = 1,
    mustSelect = false,
    relics = relics,
    titleStr = LT.Textf("ChaosSchool_RelicTips")
  }
  UIManager.Instance:InsertCopyUIShowQueue(Urls.WorldStageRelicThreeSelectPanel, userData)
end

function MapOneLineManager:IsHaveCmdData()
  local wordStageComp = WorldStageManager.Instance:GetCurStageComp()
  if not wordStageComp then
    return
  end
  if wordStageComp.cmdDataComp:IsHaveCmdData() then
    return true
  end
end

function MapOneLineManager:IsEnabled()
  return self._tickTimer ~= nil
end

function MapOneLineManager:OnGearTrigger(svrData)
  if not self:IsEnabled() then
    return
  end
  print(string.format("[MapOneLineManager] OnGearTrigger - 收到节点触发数据 uid:%s triggerVersion:%s data:%s", svrData.uid, tostring(svrData.triggerVersion), table.tostring(svrData.data)))
  if self:IsHaveSameShop(svrData.uid) then
    print(string.format("[MapOneLineManager] OnGearTrigger - 跳过，已有相同商店 uid:%s", svrData.uid))
    return
  end
  if self._markTriggeredUidDict[svrData.uid] then
    print(string.format("[MapOneLineManager] OnGearTrigger - 跳过，已标记触发 uid:%s", svrData.uid))
    return
  end
  local gear = self:GetGearInfo(svrData.uid)
  if gear then
    gear.state = cd.GearState.Running
    print(string.format("[MapOneLineManager] OnGearTrigger - 设置节点状态为Running uid:%s, type:%s", svrData.uid, gear.type))
  end
  self._TriggerDatas[svrData] = true
  self:SetNeedTrigger(false)
  print(string.format("[MapOneLineManager] OnGearTrigger - 添加到触发队列，当前队列数量:%d", self:_GetTriggerDataCount()))
end

function MapOneLineManager:OnTriggerGearData(svrData)
  self:OnGearTrigger(svrData)
end

function MapOneLineManager:_GetTriggerDataCount()
  local count = 0
  for _ in pairs(self._TriggerDatas) do
    count = count + 1
  end
  return count
end

function MapOneLineManager:_DoGearTrigger(svrData)
  print(string.format("[MapOneLineManager] _DoGearTrigger - 执行节点触发 uid:%s", svrData.uid))
  self._TriggerDatas[svrData] = nil
  local data = svrData and svrData.data
  if not data then
    print("[MapOneLineManager] _DoGearTrigger - 数据为空，返回")
    return
  end
  local gearType = self:GetGearType(svrData.uid)
  self.curUid = svrData.uid
  print(string.format("[MapOneLineManager] _DoGearTrigger - 节点类型:%s, battleTid:%s, eventId:%s", gearType, data.battleTid or "nil", data.eventId or "nil"))
  if data.battleTid then
    print(string.format("[MapOneLineManager] _DoGearTrigger - 进入战斗 battleTid:%s", data.battleTid))
    data.triggerVersion = svrData.triggerVersion
    self:EnterBattle(data)
  elseif data.option then
    if 0 ~= data.eventId then
      print(string.format("[MapOneLineManager] _DoGearTrigger - 打开事件面板 eventId:%s", data.eventId))
      self:OpenEventPanel(svrData)
    end
  elseif self:IsShop(svrData.uid) then
    print(string.format("[MapOneLineManager] _DoGearTrigger - 打开商店 uid:%s", svrData.uid))
    self:OpenShop(svrData)
  elseif self:IsSpecialShop(svrData.uid) then
    print(string.format("[MapOneLineManager] _DoGearTrigger - 打开特殊商店 uid:%s", svrData.uid))
    self:OpenSpecialShop(svrData)
  elseif self:IsTreasure(svrData.uid) then
    print(string.format("[MapOneLineManager] _DoGearTrigger - 打开宝箱 uid:%s", svrData.uid))
    self:OpenTreasure(svrData)
  else
    print(string.format("[MapOneLineManager] _DoGearTrigger - 处理其他类型节点 uid:%s", svrData.uid))
    local sceneType = cd.SceneType.Copies
    CopyDataUtils.HandleGearBattleResult(data, sceneType)
  end
  self:MarkTriggeredUid(svrData.uid)
end

function MapOneLineManager:MarkTriggeredUid(uid)
  if self:IsShop(uid) or self:IsSpecialShop(uid) then
    self._markTriggeredUidDict[uid] = true
  end
end

function MapOneLineManager:IsHaveSameShop(uid)
  if not self:IsShop(uid) and not self:IsSpecialShop(uid) then
    return false
  end
  for triggerData in pairs(self._TriggerDatas) do
    if triggerData.uid == uid then
      return true
    end
  end
  return false
end

function MapOneLineManager:IsLastBattle(uid)
  local lastGear = self.gears[#self.gears]
  if uid ~= lastGear.uid then
    return
  end
  local gearType = self:GetGearType(uid)
  return cd.GearBattleType[gearType]
end

function MapOneLineManager:IsShop(uid)
  local gearType = self:GetGearType(uid)
  if gearType == CommonDefine.GearItemType.Shop or gearType == CommonDefine.GearItemType.RelicShop or gearType == CommonDefine.GearItemType.EnchantShop or gearType == CommonDefine.GearItemType.CustomizeRelicShop or gearType == CommonDefine.GearItemType.CustomizeEnchantShop then
    return true
  end
end

function MapOneLineManager:IsSpecialShop(uid)
  local gearType = self:GetGearType(uid)
  if gearType == CommonDefine.GearItemType.SpecialShop then
    return true
  end
end

function MapOneLineManager:OpenShop(svrData)
  local uid = svrData.uid
  local gearType = self:GetGearType(uid)
  print(string.format("[MapOneLineManager] OpenShop - 打开商店 uid:%s, type:%s", uid, gearType))
  ShopDataUtils.OnShopData(svrData.data)
  local nodeTypeCfg = self:GetNodeTypeConfig(uid)
  local shopName = nodeTypeCfg and nodeTypeCfg.Name or ""
  UIManager.Instance:Show(Urls.WorldStageNewShopPanel, uid, function()
    print(string.format("[MapOneLineManager] OpenShop - 商店关闭回调 uid:%s", uid))
    self:ReqGearItemHandle(uid, {closeWindow = true}, function()
      self:ReqCloseGear(uid, function()
        self:SetNeedTrigger(true)
      end)
    end)
  end, gearType, shopName)
end

function MapOneLineManager:OpenSpecialShop(svrData)
  local uid = svrData.uid
  print(string.format("[MapOneLineManager] OpenSpecialShop - 打开特殊商店 uid:%s", uid))
  ShopDataUtils.OnShopData(svrData.data)
  local gear = self:GetGearInfo(uid)
  local mapNodeTid = gear and gear.tid
  local viewData = {
    shopUid = uid,
    closeCb = function()
      print(string.format("[MapOneLineManager] OpenSpecialShop - 特殊商店关闭回调 uid:%s", uid))
      self:ReqGearItemHandle(uid, {closeWindow = true}, function()
        self:ReqCloseGear(uid, function()
          self:SetNeedTrigger(true)
        end)
      end)
    end,
    mapNodeTid = mapNodeTid
  }
  UIManager.Instance:OpenCopySceneUI(Urls.CopySpecialShopView, viewData)
end

function MapOneLineManager:IsTreasure(uid)
  local gearType = self:GetGearType(uid)
  if gearType == CommonDefine.GearItemType.Treasure or gearType == CommonDefine.GearItemType.BoxDrop or gearType == CommonDefine.GearItemType.StoneDrop or gearType == CommonDefine.GearItemType.Relic then
    return true
  end
end

function MapOneLineManager:OpenTreasure(svrData)
  local uid = svrData.uid
  local data = svrData.data or {}
  local itemCount = data.items and #data.items or 0
  print(string.format("[MapOneLineManager] OpenTreasure - 打开宝箱 uid:%s, itemCount:%d", uid, itemCount))
  if itemCount > 0 then
    UIManager.Instance:Show(Urls.WorldStageGetAwardTip, data, function()
      print(string.format("[MapOneLineManager] OpenTreasure - 宝箱奖励展示完成 uid:%s", uid))
    end)
  end
end

function MapOneLineManager:MoveToGear()
end

function MapOneLineManager:ReqTrigger(uid)
  local gearType = self:GetGearType(uid)
  local gearIndex = self:GetGearIndexByUid(uid)
  local gearName = self:GetGearNameByUid(uid)
  local gearCount = self.gears and #self.gears or 0
  local indexStr = gearIndex and string.format("[%d/%d]", gearIndex, gearCount) or ""
  print(string.format("[MapOneLineManager] ReqTrigger - 请求触发节点 %s %s, uid:%s, type:%s", indexStr, gearName, uid, gearType))
  WorldStageManager.Instance:SetCurTriggeredGearType(gearType)
  EventMgr.Instance.OpenReqMask:Dispatch()
  local gear = self:GetGearInfo(uid)
  if not gear then
    Logger.Error("找不到节点", uid)
    return
  end
  ProtoManager.Instance:ReqServer("WorldRequest", "OnTrigger", function()
    print(string.format("[MapOneLineManager] ReqTrigger - 请求成功返回 %s %s, uid:%s", indexStr, gearName, uid))
  end, function(errorData, code)
    print(string.format("[MapOneLineManager] ReqTrigger - 请求失败 %s %s, uid:%s, error:%s, code:%s", indexStr, gearName, uid, table.tostring(errorData), code))
  end, uid, {})
end

function MapOneLineManager:ReqGearItemHandle(uid, data, callback)
  ProtoManager.Instance:ReqServer("WorldRequest", "OnGearHandle", function(responseData)
    if callback then
      callback()
    end
  end, function(errorData)
    Logger.Warn("WorldRequest.OnGearHandle Error", table.tostring(errorData))
  end, uid, data)
end

function MapOneLineManager:ReqCloseGear(uid, callback)
  print(string.format("[MapOneLineManager] ReqCloseGear - 请求关闭节点 uid:%s", uid))
  ProtoManager.Instance:ReqServer("WorldRequest", "OnGearClose", function(data)
    local curGear = self.curUid and self:GetGearInfo(uid)
    if curGear then
      curGear.isFinished = true
      print(string.format("[MapOneLineManager] ReqCloseGear - 节点关闭成功，标记为完成 uid:%s", uid))
    end
    if callback then
      callback()
    end
  end, function(errorData)
    Logger.Warn("WorldRequest.OnGearClose Error", table.tostring(errorData))
    print(string.format("[MapOneLineManager] ReqCloseGear - 节点关闭失败 uid:%s, error:%s", uid, table.tostring(errorData)))
  end, uid)
end

function MapOneLineManager:ReqChoose(uid, index, eventId, callBack)
  print(string.format("[MapOneLineManager] ReqChoose - 请求选择事件 uid:%s, index:%s, eventId:%s", uid, index, eventId))
  if self:CheckIsSkipBattleEvent(index, eventId) then
    print("[MapOneLineManager] ReqChoose - 检测到跳过战斗事件")
    self:InsertBattleSettleTip()
  end
  local errorTimes = 0
  EventMgr.Instance.OpenReqMask:Dispatch()
  local evenCfg = DT.Event[eventId]
  ProtoManager.Instance:ReqServer("WorldRequest", "OnGearChoose", function(data)
    local isClose = data and data.isClose
    if nil == isClose then
      isClose = nil == evenCfg["ChoiceJump" .. index]
    end
    Logger.Info("[NewMap] OnGearChooose Return", isClose, data.isCancel)
    print(string.format("[MapOneLineManager] ReqChoose - 选择返回 uid:%s, index:%s, isClose:%s, isCancel:%s", uid, index, isClose and "true" or "false", data.isCancel and "true" or "false"))
    if isClose then
      UIManager.Instance:CloseByUrl(Urls.WorldStageEventPanel)
      self._isCancel = data.isCancel
      if self.__name ~= "GearItemMonster" then
        self:AfterTrigger()
      end
      self._isCancel = nil
    end
    if callBack then
      callBack(index)
    end
    self:SetNeedTrigger(true)
  end, function()
    errorTimes = errorTimes + 1
    print(string.format("[MapOneLineManager] ReqChoose - 请求失败 uid:%s, index:%s, errorTimes:%s", uid, index, errorTimes))
    if callBack then
      callBack(-1)
    end
    if errorTimes > 5 then
      print("[MapOneLineManager] ReqChoose - 错误次数过多，关闭面板并触发下一个节点")
      UIManager.Instance:CloseByUrl(Urls.WorldStageEventPanel)
      self:TriggerNextGear()
    end
  end, uid, index)
end

function MapOneLineManager:AfterTrigger()
end

function MapOneLineManager:GetGearType(uid)
  for _, gear in pairs(self.gears) do
    if gear.uid == uid then
      return gear.type
    end
  end
end

function MapOneLineManager:GetGearInfo(uid)
  for _, gear in pairs(self.gears) do
    if gear.uid == uid then
      return gear
    end
  end
end

function MapOneLineManager:GetNodeTypeConfig(uid)
  local gear = self:GetGearInfo(uid)
  if not gear then
    return
  end
  local tid = gear.tid
  local nodeCfg = DT.MapNode[tid]
  local nodeTypeCfg = nodeCfg.NodeType and DT.MapNodeType[nodeCfg.NodeType]
  return nodeTypeCfg
end

function MapOneLineManager:GetGearNameByUid(gearUid)
  local nodeTypeCfg = self:GetNodeTypeConfig(gearUid)
  if nodeTypeCfg and nodeTypeCfg.Name then
    return nodeTypeCfg.Name
  end
  return "uid:" .. tostring(gearUid)
end

function MapOneLineManager:GetGearIndexByUid(gearUid)
  if not self.gears then
    return nil
  end
  for i, gear in ipairs(self.gears) do
    if gear.uid == gearUid then
      return i
    end
  end
  return nil
end

function MapOneLineManager:GetGearTriggerType(uid)
  local nodeTypeCfg = self:GetNodeTypeConfig(uid)
  return nodeTypeCfg and nodeTypeCfg.Trigger
end

function MapOneLineManager:GetCurrentTriggeringGearData()
  if self.curUid then
    local curGear = self:GetGearInfo(self.curUid)
    if curGear and (curGear.state == cd.GearState.Running or not curGear.isFinished) then
      return curGear
    end
  end
  local triggerData = table.next(self._TriggerDatas)
  if triggerData and triggerData.uid then
    local gear = self:GetGearInfo(triggerData.uid)
    if gear then
      return gear
    end
  end
  return nil
end

function MapOneLineManager:OpenEventPanel(userData)
  local eventId = userData.data and userData.data.eventId
  print(string.format("[MapOneLineManager] OpenEventPanel - 打开事件面板 uid:%s, eventId:%s", userData.uid, eventId))
  if nil == eventId or 0 == eventId then
    Logger.Error("[NewMap] OpenEventPanel数据不对，eventId为0或者nil")
    return
  end
  
  local function callBack(index, selectedEventId)
    print(string.format("[MapOneLineManager] OpenEventPanel - 事件选择回调 uid:%s, index:%s, eventId:%s", userData.uid, index, selectedEventId))
    self:ReqChoose(userData.uid, index, selectedEventId)
  end
  
  self.isEventPanelOpen = true
  local eventPanelComp = UIManager.Instance:GetWindow(Urls.WorldStageEventPanel)
  if eventPanelComp then
    print("[MapOneLineManager] OpenEventPanel - 刷新已有事件面板")
    eventPanelComp:SetCallFunc(callBack)
    eventPanelComp:RefreshDataByEventData(userData)
  else
    print("[MapOneLineManager] OpenEventPanel - 打开新事件面板")
    UIManager.Instance:OpenCopySceneUI(Urls.WorldStageEventPanel, userData, nil, callBack)
    self:AudioPlay()
  end
end

function MapOneLineManager:AudioPlay()
  local gearItemType = self:GetType()
  local audioEvent = GearAudioDefine.GearTypeAudio[gearItemType]
  if audioEvent then
    local eventId = self:SpecialTypeFix(audioEvent, gearItemType)
    AudioManager.Instance:PostSoundEvent(eventId)
  end
end

function MapOneLineManager:OnGearBattle(svrData)
  if not self:IsEnabled() then
    return
  end
  if svrData.data and svrData.data.battleTid then
    self:EnterBattle(svrData.data)
    self.isRecovering = false
  end
end

function MapOneLineManager:OnTriggerBattle(svrData)
  self:OnGearBattle(svrData)
end

function MapOneLineManager:EnterBattle(battleData)
  print(string.format("[MapOneLineManager] EnterBattle - 进入战斗 battleTid:%s, isRecovering:%s, curUid:%s, triggerVersion:%s", battleData.battleTid, self.isRecovering and "true" or "false", self.curUid, tostring(battleData.triggerVersion)))
  local uid = self.curUid
  local incomingVersion = battleData.triggerVersion
  if uid and incomingVersion and incomingVersion > 0 then
    local lastVersion = self._triggerVersionByUid[uid] or 0
    if incomingVersion <= lastVersion then
      print(string.format("[MapOneLineManager] EnterBattle - 跳过重复战斗 uid:%s version:%s <= %s", uid, tostring(incomingVersion), tostring(lastVersion)))
      return
    end
    self._triggerVersionByUid[uid] = incomingVersion
  end
  UIManager.Instance:CloseByUrl(Urls.WorldStageEventPanel)
  BattleManager.Instance:EnterBattle(battleData, self.isRecovering)
end

function MapOneLineManager:OnGearBattleResult(result)
end

function MapOneLineManager:OnGearBattleFinish(result)
  print(string.format("[MapOneLineManager] OnGearBattleFinish - 战斗结束 result:%s, curUid:%s", result, self.curUid))
  if self.curUid then
    local isLastBattle = self:IsLastBattle(self.curUid)
    print(string.format("[MapOneLineManager] OnGearBattleFinish - 是否最后战斗:%s", isLastBattle and "true" or "false"))
    if result == cd.BattleResult.Fail then
      print("[MapOneLineManager] OnGearBattleFinish - 战斗失败，请求处理节点")
      self:ReqGearItemHandle(self.curUid, {})
    end
    if isLastBattle then
      print("[MapOneLineManager] OnGearBattleFinish - 最后战斗，不继续触发")
      return
    end
    local beforeCount = self:_GetTriggerDataCount()
    local afterCount = self:_GetTriggerDataCount()
    if beforeCount ~= afterCount then
      print(string.format("[MapOneLineManager] OnGearBattleFinish - 清除重复触发，队列数量 %d -> %d", beforeCount, afterCount))
    end
    self:SetNeedTrigger(true)
    self:_PrintState("[MapOneLineManager] OnGearBattleFinish")
  end
end

function MapOneLineManager:_ClearDuplicateBattleTrigger(uid)
  local data
  for svrData in pairs(table.clone(self._TriggerDatas)) do
    data = svrData.data
    if svrData.uid == uid and data and data.battleTid then
      self._TriggerDatas[svrData] = nil
    end
  end
end

function MapOneLineManager:OnGearDelete(data)
  print(string.format("[MapOneLineManager] OnGearDelete - 收到删除节点数据，数量:%d, uids:%s", #data, table.tostring(data)))
  local isAlreadyDelete = true
  for _, uid in ipairs(data) do
    if not self.deleteUids[uid] then
      isAlreadyDelete = false
      print(string.format("[MapOneLineManager] OnGearDelete - 标记删除节点 uid:%s", uid))
    else
      print(string.format("[MapOneLineManager] OnGearDelete - 节点已删除过 uid:%s", uid))
    end
    self.deleteUids[uid] = true
    self._triggerVersionByUid[uid] = nil
    local gearInfo = self:GetGearInfo(uid)
    if gearInfo then
      gearInfo.isFinished = true
    end
  end
  local beforeCount = self:_GetTriggerDataCount()
  for svrData in pairs(table.clone(self._TriggerDatas)) do
    if self.deleteUids[svrData.uid] then
      print(string.format("[MapOneLineManager] OnGearDelete - 从触发队列移除已删除节点 uid:%s", svrData.uid))
      self._TriggerDatas[svrData] = nil
    end
  end
  local afterCount = self:_GetTriggerDataCount()
  if beforeCount ~= afterCount then
    print(string.format("[MapOneLineManager] OnGearDelete - 触发队列数量变化 %d -> %d", beforeCount, afterCount))
  end
  if isAlreadyDelete then
    print("[MapOneLineManager] OnGearDelete - 所有节点都已删除过，忽略")
    return
  end
  UIManager.Instance:CloseByUrl(Urls.WorldStageEventPanel)
  self:SetNeedTrigger(true)
  self:_PrintState("[MapOneLineManager] OnGearDelete")
  self:DoTickImmediate()
end

function MapOneLineManager:AddTriggerDelay(delay)
  self._delayDoTriggerTime = math.max(self._delayDoTriggerTime or 0, TimeUtils.GetServerTime() + (delay or 0.6))
end

function MapOneLineManager:OnDestroy()
  print("[MapOneLineManager] OnDestroy - 管理器销毁")
  self:_PrintState("[MapOneLineManager] OnDestroy")
  Super.OnDestroy(self)
  ResLoadMgr.UnloadAssetByTarget(self)
  MapOneLineManager.BeforeEnterUid = nil
end

local SkipBattleCmdId = DT.GetConstant("SkipBattleCmd")

function MapOneLineManager:CheckIsSkipBattleEvent(index, eventId)
  local eventCfg = DT.Event[eventId]
  local cmdId = eventCfg and eventCfg["ChoiceEffect" .. index] and eventCfg["ChoiceEffect" .. index][1]
  return cmdId and cmdId == SkipBattleCmdId
end

function GearItemBase:InsertBattleSettleTip()
  CopyDataUtils.Set_needShowBattleSettleTips(true)
end

function MapOneLineManager:OnSyncView(_)
end

function MapOneLineManager:OnDropTerrain(_)
end

function MapOneLineManager:OnNewGear(_)
end

function MapOneLineManager:OnNewGearData(_)
end

function MapOneLineManager:OnDestructionGear(_)
end

function MapOneLineManager:OnSyncGearInfo(_)
end

function MapOneLineManager:OnSyncWorldPlayerPos(_)
end

return MapOneLineManager
