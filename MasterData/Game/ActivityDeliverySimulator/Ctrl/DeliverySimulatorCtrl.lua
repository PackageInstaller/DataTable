local base = ControllerBase
local DeliverySimulatorCtrl = class("DeliverySimulatorCtrl", base)
local Cs_GSceneManager_Ins = CS.GSceneManager.Instance
local CS_ResLoader = CS.ResLoader
local CS_AnimationEffectController_Ins = CS.AnimationEffectController.Instance
local cs_MessageCommon = CS.MessageCommon
local util = require("XLua.Common.xlua_util")
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local ActLbCamCtrl = require("Game.ActivityLobby.Ctrl.ActLbCamCtrl")
local DeliverySimulatorInteractCtrl = require("Game.ActivityDeliverySimulator.Ctrl.DeliverySimulatorInteractCtrl")
local DeliverySimulatorBuffCtrl = require("Game.ActivityDeliverySimulator.Ctrl.DeliverySimulatorBuffCtrl")
local DeliverySimulatorPlayerEntity = require("Game.ActivityDeliverySimulator.Entity.DeliverySimulatorPlayerEntity")
local DeliveryOrder = require("Game.ActivityDeliverySimulator.Order.DeliverySimulatorOrder")
local DeliverySimulatorGameStage = {
  Init = 1,
  Ready = 2,
  Start = 3,
  Pause = 4,
  CancelPause = 5,
  WaittingToEnd = 6,
  End = 7
}

function DeliverySimulatorCtrl:ctor()
  ConfigData:LoadDynCfg(eDynConfigData.delivery_attribute)
  ConfigData:LoadDynCfg(eDynConfigData.delivery_interact_entity)
  ConfigData:LoadDynCfg(eDynConfigData.delivery_goods_spawn)
  ConfigData:LoadDynCfg(eDynConfigData.delivery_order_pool)
  ConfigData:LoadDynCfg(eDynConfigData.delivery_order)
  ConfigData:LoadDynCfg(eDynConfigData.delivery_buff)
  self.gameStage = DeliverySimulatorGameStage.Init
  self.totalMoney = 0
  self.lastHighScore = 0
end

function DeliverySimulatorCtrl:OnInit()
  self.ctrls = {}
  self.actLbCamCtrl = ActLbCamCtrl.New(self)
  self.dsInteractCtrl = DeliverySimulatorInteractCtrl.New(self)
  self.dsBuffCtrl = DeliverySimulatorBuffCtrl.New(self)
end

function DeliverySimulatorCtrl:EnterDeliverySimulatorGame(actId, levelId, skinId)
  UIManager:DeleteAllWindow()
  self.actId = actId
  self.dsSectorCfg = ConfigData.delivery_activity_sector_group[actId][levelId]
  self.dsRoleCfg = ConfigData.delivery_role[skinId]
  local orderPoolId = self.dsSectorCfg.order_pool
  self.orderPoolCfg = ConfigData.delivery_order_pool[orderPoolId]
  self:Reset()
  self.resLoader = CS_ResLoader.Create()
  local preLoadFunc = BindCallback(self, self._OnScenePreload)
  local sceneLoadedFunc = BindCallback(self, self._OnSceneLoaded)
  local sceneName = self.dsSectorCfg.scene_path
  Cs_GSceneManager_Ins:LoadSceneAsyncByABEx(sceneName, true, false, sceneLoadedFunc, util.cs_generator(preLoadFunc))
end

function DeliverySimulatorCtrl:Reset()
  self.genOrderId = 1
  self.deliveryOrdersList = {}
  self._animStartTimeWarning = false
  self._currentGoodsSpawnEntity = nil
  self.newOrderPublishTime = nil
  self._waittingToReStartTime = 4
  self.startOrderCount = self.dsSectorCfg.order_num
  self.maxOrderCount = self.dsSectorCfg.max_order_num
  self.totalMoney = 0
  self.lastHighScore = 0
  self.gameTime = self.dsSectorCfg.game_time
  self.handInGoodsList = {}
  self.completedOrderList = {}
end

function DeliverySimulatorCtrl:_OnScenePreload()
  self.preLoadRes = {}
  local cmderPrefabWait = self.resLoader:LoadABAssetAsyncAwait(PathConsts:GetCharacterActivityLobbyModelPath(self:GetMainRoleResPath()))
  local cmderHeadFxWait = self.resLoader:LoadABAssetAsyncAwait(PathConsts:GetDormPath("CommonPrefab/Fx_CmdHeadGem"))
  local deliveryGoodsAtlasWait = self.resLoader:LoadABAssetAsyncAwait(PathConsts:GetSpriteAtlasPath("DeliveryIcon"))
  local guideWait
  if self.dsSectorCfg.guide_path_list ~= nil then
    guideWait = self.resLoader:LoadABAssetAsyncAwait(PathConsts:GetUIPrefabPath(self.dsSectorCfg.guide_path_list))
  end
  coroutine.yield(cmderPrefabWait)
  self.preLoadRes.cmderPrefab = cmderPrefabWait.Result
  coroutine.yield(cmderHeadFxWait)
  self.preLoadRes.cmderHeadFxPrefab = cmderHeadFxWait.Result
  coroutine.yield(deliveryGoodsAtlasWait)
  self.preLoadRes.deliveryGoodsAtlas = deliveryGoodsAtlasWait.Result
  if guideWait ~= nil then
    coroutine.yield(guideWait)
    self.preLoadRes.guidePrefab = guideWait.Result
  end
end

function DeliverySimulatorCtrl:_OnSceneLoaded()
  local rootGo = CS.UnityEngine.GameObject.Find("ActLobboyRoot")
  if IsNull(rootGo) then
    error("Cant find ActLobboyRoot")
    return
  end
  self._bind = {}
  UIUtil.LuaUIBindingTable(rootGo.transform, self._bind)
  for k, v in ipairs(self.ctrls) do
    v:OnActLbSceneEnter(self._bind)
  end
  self:InstanceMainRoleEntity()
  self._camBind = {}
  UIUtil.LuaUIBindingTable(self._bind.cam, self._camBind)
  self._sceneBind = {}
  UIUtil.LuaUIBindingTable(self._camBind.sceneBind, self._sceneBind)
  if IsNull(self._sceneBind.tl_Start) then
    return
  end
  self._sceneBind.tl_Start.time = self._sceneBind.tl_Start.duration
  self._sceneBind.tl_Start:Evaluate()
  self.__UpdateHandle = BindCallback(self, self._OnUpdate)
  UpdateManager:AddUpdate(self.__UpdateHandle)
  self.__FixedUpdateHandle = BindCallback(self, self._OnFixedUpdate)
  UpdateManager:AddFixedUpdate(self.__FixedUpdateHandle)
  self.__LateUpdateHandle = BindCallback(self, self._OnLateUpdate)
  UpdateManager:AddLateUpdate(self.__LateUpdateHandle)
  UIManager:ShowWindowAsync(UIWindowTypeID.DeliverySimulatorMain, function(win)
    if win == nil then
      return
    end
    win:InitDeliverySimulatorMain(self.resLoader, self.dsPlayerEntity, self)
    self.mainWindow = win
    self.dsInteractCtrl:InitIntrctEntityUI(win)
    self.dsPlayerEntity:InitDSPlayerEntityUI(win)
    self.mainWindow:UpdateGameTime(self.dsSectorCfg.game_time)
    self:_TryInitGuideUI(function()
      self.state = DeliverySimulatorGameStage.Ready
      self._waittingToReStartTime = 4
      self.mainWindow:ShowStartCountDown(self._waittingToReStartTime - 1)
      self._bgmCallback = AudioManager:PlayAudioById(8000)
    end)
  end)
end

function DeliverySimulatorCtrl:InstanceMainRoleEntity()
  self.dsPlayerEntity = DeliverySimulatorPlayerEntity.New()
  local cmderGo = self.preLoadRes.cmderPrefab:Instantiate()
  cmderGo.transform.position = self:GetBornPos()
  local attributeId = self.dsRoleCfg.attribute_id
  self.dsPlayerEntity:InitDeliverySimulatorPlayerEntity(self, self.preLoadRes.cmderHeadFxPrefab, cmderGo, self._bind.playerRigidbodyTran, attributeId)
  self.dsPlayerEntity:SetActLbCmdRotation(self.recordTempRotation)
  self.actLbCamCtrl:SetActLbCamFollowTarget(cmderGo.transform)
end

function DeliverySimulatorCtrl:GetBornPos()
  return self.playerBornPos
end

function DeliverySimulatorCtrl:_TryInitGuideUI(callback)
  if self.preLoadRes.guidePrefab ~= nil then
    local guideObj = self.preLoadRes.guidePrefab:Instantiate(self.mainWindow.transform)
    UIUtil.AddButtonListener(guideObj:AddComponent(typeof(CS.ExButton)), self, function()
      DestroyUnityObject(guideObj)
      callback()
    end)
  else
    callback()
  end
end

function DeliverySimulatorCtrl:IsGameStart()
  return self.state == DeliverySimulatorGameStage.Start
end

function DeliverySimulatorCtrl:GetTouchGoodsSpawnEntity()
  return self._currentGoodsSpawnEntity
end

function DeliverySimulatorCtrl:GetMainRoleResPath()
  local skinId = self.dsRoleCfg.skin_id
  local skinCfg = ConfigData.skin[skinId]
  return skinCfg.src_id_pic
end

function DeliverySimulatorCtrl:GetActLbCfg()
  if ConfigData.activity_lobby == nil then
    ConfigData:LoadDynCfg(eDynConfigData.activity_lobby)
  end
  return ConfigData.activity_lobby[5600109]
end

function DeliverySimulatorCtrl:GetCameraBound()
  return self._bind.camera_bound
end

function DeliverySimulatorCtrl:GetDeliveryAtlas()
  return self.preLoadRes.deliveryGoodsAtlas
end

function DeliverySimulatorCtrl:CheckPublishNewOrder()
  if self.startOrderCount > 0 then
    self.startOrderCount = self.startOrderCount - 1
    self:PublishDeliveryOrders()
  end
  if self.nextNewOrder == nil then
    self.nextNewOrder = {}
    self.nextNewOrder.cd_time = self.orderPoolCfg.first_cd_time
  end
  if self.newOrderPublishTime == nil then
    self.newOrderPublishTime = self.gameTime - self.nextNewOrder.cd_time
  end
  if table.count(self.deliveryOrdersList) < self.maxOrderCount and self.newOrderPublishTime >= self.gameTime then
    self.newOrderPublishTime = self.gameTime - self.orderPoolCfg.cd_time
    self:PublishDeliveryOrders()
  end
end

function DeliverySimulatorCtrl:GetNextOrderProgress()
  if self.newOrderPublishTime == nil then
    return 1
  end
  return (self.gameTime - self.newOrderPublishTime) / self.orderPoolCfg.cd_time
end

function DeliverySimulatorCtrl:PublishDeliveryOrders()
  local orderPool = self.orderPoolCfg
  local orderList = orderPool.order_id_list
  local orderWeightList = orderPool.weight_value_list
  local totalWeight = 0
  for index, weight in pairs(orderWeightList) do
    totalWeight = totalWeight + weight
  end
  local randomWeight = Mathf.Random(0, totalWeight - 1)
  local curWeight = 0
  local newOrderId
  for index, weight in pairs(orderWeightList) do
    curWeight = curWeight + weight
    if randomWeight < curWeight then
      newOrderId = orderList[index]
      break
    end
  end
  local newOrderCfg = ConfigData.delivery_order[newOrderId]
  if newOrderCfg == nil then
    return
  end
  local newOrder = DeliveryOrder.New(newOrderCfg, self, self.genOrderId)
  self.deliveryOrdersList[self.genOrderId] = newOrder
  self.genOrderId = self.genOrderId + 1
  self.mainWindow:AddNewOrder(newOrder)
  if self.startOrderCount == 0 then
    self.mainWindow:PlayShowWattingOrderItemSwitchAnim()
  end
end

function DeliverySimulatorCtrl:UpdateDeliveryOrders()
  self:CheckPublishNewOrder()
  local needRefresh = false
  for orderIndex, order in pairs(self.deliveryOrdersList) do
    if order:IsOverTime() then
      order:OrderFail()
      self.deliveryOrdersList[orderIndex] = nil
      needRefresh = true
    end
  end
  if needRefresh and self.mainWindow ~= nil then
    self.mainWindow:UpdateOrderList(self.deliveryOrdersList)
  end
end

function DeliverySimulatorCtrl:SettlementPayment(goodsNumsDic)
  if not self:IsGameStart() then
    return
  end
  local money = self:CalculateMoneyEarned(goodsNumsDic)
  self.totalMoney = self.totalMoney + money
  if self.mainWindow ~= nil then
    self.mainWindow:UpdateOrderList(self.deliveryOrdersList)
    self.mainWindow:UpdateTotalMoney(self.totalMoney, money)
  end
end

function DeliverySimulatorCtrl:CalculateMoneyEarned(goodsNumsDic)
  for good_id, count in pairs(goodsNumsDic) do
    if self.handInGoodsList[good_id] == nil then
      self.handInGoodsList[good_id] = count
    else
      self.handInGoodsList[good_id] = self.handInGoodsList[good_id] + count
    end
  end
  local money = 0
  for orderIndex = 1, self.genOrderId do
    local order = self.deliveryOrdersList[orderIndex]
    if order ~= nil and not order:IsComplete() then
      for goodsIndex, good_id in ipairs(order.cfg.good_id_list) do
        local remainingRequiredCount = order:GetRemainingRequiredCount(goodsIndex)
        if goodsNumsDic[good_id] ~= nil and 0 < remainingRequiredCount then
          local handInCount = math.min(goodsNumsDic[good_id], remainingRequiredCount)
          order:HandInGoods(goodsIndex, handInCount)
          money = money + ConfigData.delivery_goods_spawn[good_id].price * handInCount
          goodsNumsDic[good_id] = goodsNumsDic[good_id] - handInCount
        end
      end
      if order:IsComplete() then
        self.deliveryOrdersList[orderIndex] = nil
        table.insert(self.completedOrderList, order)
        money = money + order:GetOredrReward()
      end
    end
  end
  for good_id, count in pairs(goodsNumsDic) do
    money = money + ConfigData.delivery_goods_spawn[good_id].price * count
  end
  return money
end

function DeliverySimulatorCtrl:UpdateCurrentGoodsSpawnEntity(goodsSpawnEntity, isTouch)
  if not self:IsGameStart() then
    return
  end
  if isTouch == true then
    if self._currentGoodsSpawnEntity ~= goodsSpawnEntity then
      self._currentGoodsSpawnEntity = goodsSpawnEntity
    end
  elseif self._currentGoodsSpawnEntity == goodsSpawnEntity then
    self._currentGoodsSpawnEntity = nil
  end
  if self.mainWindow ~= nil then
    self.mainWindow:UpdateBtnPickUpStage(self._currentGoodsSpawnEntity)
  end
end

function DeliverySimulatorCtrl:OnMove(moveData)
  if self.dsPlayerEntity == nil then
    return
  end
  self.moveData = moveData
  if moveData then
    self.joystickDown = true
    self.isMoveStop = false
  else
    self.joystickDown = false
  end
end

function DeliverySimulatorCtrl:Pause()
  Time.timeScale = 0
  self.state = DeliverySimulatorGameStage.Pause
  self.dsPlayerEntity:Pause()
end

function DeliverySimulatorCtrl:CancelPause()
  Time.timeScale = 1
  self.state = DeliverySimulatorGameStage.CancelPause
  self._waittingToReStartTime = 3
end

function DeliverySimulatorCtrl:Continue()
  self.state = DeliverySimulatorGameStage.Start
  self._waittingToReStartTime = nil
  self.mainWindow:Continue()
  self.dsPlayerEntity:Continue()
end

function DeliverySimulatorCtrl:GameEnd(showWarChessGameWin)
  Time.timeScale = 1
  self.dsPlayerEntity:StopMove()
  self.state = DeliverySimulatorGameStage.WaittingToEnd
  self._waittingToGameEndTime = 2
  if showWarChessGameWin then
    UIManager:ShowWindowAsync(UIWindowTypeID.WarChessGameWin, function(window)
      window:SetPlayOverCallback(function()
        window:Delete()
      end, 1)
    end)
  end
end

function DeliverySimulatorCtrl:ShowGameResult()
  self.state = DeliverySimulatorGameStage.End
  self:TrySendGameScore()
  AudioManager:PlayAudioById(8020)
  UIManager:ShowWindowAsync(UIWindowTypeID.DeliverySimulatorResult, function(win)
    if win == nil then
      return
    end
    win:InitPerformanceResult(self.handInGoodsList, self.completedOrderList, self)
  end)
end

function DeliverySimulatorCtrl:TrySendGameScore()
  local actCtrl = ControllerManager:GetController(ControllerTypeId.ActDeliverySimulator)
  if actCtrl == nil then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(6033))
    return
  end
  local actData = actCtrl:GetActDataByActId(self.actId)
  local lastHighScore = actData:GetHighestScore(self.dsSectorCfg.sector_id)
  self.lastHighScore = lastHighScore
  if lastHighScore < self.totalMoney then
    local actFrameNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
    local sector_id = self.dsSectorCfg.sector_id
    local newScore = self.totalMoney
    actFrameNetCtrl:CS_ACTIVITY_Delivery_Sector_Fin(self.actId, sector_id, newScore, self.handInGoodsList, self.completedOrderList, function()
      actData:UpdateHighestScore(sector_id, newScore)
    end)
  end
end

function DeliverySimulatorCtrl:OnRunClick()
  self.dsPlayerEntity:TryRun()
end

function DeliverySimulatorCtrl:OnPickUpClick()
  if self._currentGoodsSpawnEntity == nil then
    return
  end
  if not self._currentGoodsSpawnEntity:CouldPickUp() then
    return
  end
  if self.dsPlayerEntity ~= nil then
    local success, errorCode = self.dsPlayerEntity:TryPickUpGoods(self._currentGoodsSpawnEntity)
    if self.mainWindow ~= nil then
      self.mainWindow:UpdateBtnPickUpStage(self._currentGoodsSpawnEntity)
    end
    if success == false and errorCode ~= nil then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(errorCode), false)
    end
  end
end

function DeliverySimulatorCtrl:UpdateGameTime()
  local oldGameTime = self.gameTime
  local newGameTime = math.max(self.gameTime - Time.deltaTime, 0)
  local s = math.floor(newGameTime)
  if s ~= math.floor(oldGameTime) then
    self.mainWindow:UpdateGameTime(s)
  end
  self.gameTime = newGameTime
  if self.gameTime <= 5 and self._animStartTimeWarning == false then
    self.mainWindow:StartTimeWarningAnim()
    self._animStartTimeWarning = true
  end
  if self.gameTime <= 0 then
    self:GameEnd(true)
  end
end

function DeliverySimulatorCtrl:_OnUpdate()
  if self.state == DeliverySimulatorGameStage.Ready or self.state == DeliverySimulatorGameStage.CancelPause then
    self._waittingToReStartTime = self._waittingToReStartTime - Time.deltaTime
    if self._waittingToReStartTime > 1 then
      self.mainWindow:UpdateStartCountDown(Mathf.Ceil(self._waittingToReStartTime) - 1)
    else
      self.mainWindow:UpdateStartCountDown("GO!")
    end
    if self._waittingToReStartTime < 0 then
      self:Continue()
    end
  end
  if self.state == DeliverySimulatorGameStage.WaittingToEnd then
    self._waittingToGameEndTime = self._waittingToGameEndTime - Time.deltaTime
    if 0 > self._waittingToGameEndTime then
      self:ShowGameResult()
    end
  end
  if self.actLbCamCtrl ~= nil then
    self.actLbCamCtrl:OnLbCamUpdate()
  end
  if not self:IsGameStart() then
    return
  end
  self:UpdateGameTime()
  if self.dsPlayerEntity ~= nil then
    self.dsPlayerEntity:UpdateRunCd(Time.deltaTime)
  end
  self:UpdateDeliveryOrders()
  if self.mainWindow ~= nil then
    self.mainWindow:UpdateProgress()
  end
end

function DeliverySimulatorCtrl:_OnFixedUpdate()
  if not self:IsGameStart() then
    return
  end
  if self.dsPlayerEntity then
    self.dsPlayerEntity:UpdateMove(self.moveData, Time.fixedDeltaTime)
  end
  if self.dsBuffCtrl then
    self.dsBuffCtrl:UpdateBuff()
  end
end

function DeliverySimulatorCtrl:_OnLateUpdate()
  if self.dsInteractCtrl ~= nil then
    self.dsInteractCtrl:OnUpdate()
  end
  if not self:IsGameStart() then
    return
  end
  if self.actLbCamCtrl ~= nil then
    self.actLbCamCtrl:OnLbCamLateUpdate()
  end
  if self.dsPlayerEntity then
    self.dsPlayerEntity:UpdateMoveAnim()
  end
end

function DeliverySimulatorCtrl:Restart()
  self:Reset()
  self.dsBuffCtrl:Reset()
  self.dsPlayerEntity:Reset()
  self.mainWindow:Reset()
  self.mainWindow:UpdateGameTime(self.dsSectorCfg.game_time)
  self.dsPlayerEntity.rigidbody.transform.rotation = Quaternion.identity
  self.dsPlayerEntity.rigidbody.transform.position = self:GetBornPos()
  self.actLbCamCtrl:SetActLbCamFollowTarget(self.dsPlayerEntity.transform)
  self.dsInteractCtrl:Reset()
  self:CancelPause()
  self:Continue()
  self._waittingToReStartTime = 4
  self.state = DeliverySimulatorGameStage.Ready
  self.mainWindow:ShowStartCountDown(self._waittingToReStartTime - 1)
  if self._bgmCallback ~= nil then
    AudioManager:StopAudioByBack(self._bgmCallback)
  end
  AudioManager:PlayAudioById(8000)
end

function DeliverySimulatorCtrl:ExitDeliverySimulatorGame()
  UIManager:DeleteAllWindow()
  self:Delete()
  local actDSCtrl = ControllerManager:GetController(ControllerTypeId.ActDeliverySimulator)
  if actDSCtrl == nil then
    CS.GSceneManager.Instance:LoadSceneByAB(Consts.SceneName.Main, function()
      ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
      UIManager:CreateWindowAsync(UIWindowTypeID.Home, function(window)
        if window == nil then
          return
        end
      end)
    end)
  else
    actDSCtrl:TryOpenDeliverySimulator(self.actId)
  end
end

function DeliverySimulatorCtrl:OnDelete()
  Time.timeScale = 1
  self.dsPlayerEntity = nil
  for k, v in ipairs(self.ctrls) do
    v:Delete()
  end
  if self._bgmCallback ~= nil then
    AudioManager:StopAudioByBack(self._bgmCallback)
  end
  self.ctrls = nil
  self.resLoader:Put2Pool()
  self.resLoader = nil
  UpdateManager:RemoveUpdate(self.__UpdateHandle)
  UpdateManager:RemoveFixedUpdate(self.__FixedUpdateHandle)
  UpdateManager:RemoveLateUpdate(self.__LateUpdateHandle)
  ConfigData:ReleaseDynCfg(eDynConfigData.delivery_attribute)
  ConfigData:ReleaseDynCfg(eDynConfigData.delivery_interact_entity)
  ConfigData:ReleaseDynCfg(eDynConfigData.delivery_goods_spawn)
  ConfigData:ReleaseDynCfg(eDynConfigData.delivery_order_pool)
  ConfigData:ReleaseDynCfg(eDynConfigData.delivery_order)
  ConfigData:ReleaseDynCfg(eDynConfigData.delivery_buff)
  CS_AnimationEffectController_Ins:KillAllEffects()
  CS_AnimationEffectController_Ins:RecycleEffects()
  CS_AnimationEffectController_Ins:DisposeAllEffects()
end

return DeliverySimulatorCtrl
