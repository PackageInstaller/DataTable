local FactoryController = class("FactoryController", ControllerBase)
local base = ControllerBase
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local FactoryEnum = require("Game.Factory.FactoryEnum")
local FactoryRoomEntity = require("Game.Factory.Entity.FactoryRoomEntity")
local UIN3DFactoryCanvas = require("Game.Factory.UI3D.UIN3DFactoryCanvas")
local FactoryOrderData = require("Game.Factory.Data.FactoryOrderData")
local JumpManager = require("Game.Jump.JumpManager")
local NoticeData = require("Game.Notice.NoticeData")
local FactoryProcessingData = require("Game.Factory.Data.FactoryProcessingData")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local cs_MessageCommon = CS.MessageCommon
local FactoryCalcSendOrder = require("Game.Factory.Data.FactoryCalcSendOrder")

function FactoryController:OnInit()
  self.networkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Factory)
  self.unlockedRoom = {}
  self.unlockedCondicton = {}
  self.notOpenedRoom = {}
  self.enteredHero = {}
  self.factoryEnterArgs = ConfigData.game_config.FactoryEnterArgs
  self.roomType = {}
  self.OrderDataDic = nil
  self.ProcessingOrders = {}
  self._lastOrders = {}
  self.OrderDataListDic = nil
  self.cameraDefaultPos = nil
  self.digOrderIds = nil
  self.produceOrderIds = nil
  self.roomEntityDic = nil
  self.roomBind = nil
  self.factoryMainUI = nil
  self.ui3DCanvas = nil
  self.resloader = nil
  self.Order4SendData = nil
  self:InitAllData(function()
    self:AddNoticePreconditionData()
  end)
  self.m_OnUpdateARG = BindCallback(self, self.OnUpdateARG)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.m_OnUpdateARG)
end

function FactoryController:FadeFactory()
  self.roomBind.factoryToHome:Play()
end

function FactoryController:OpenFactory()
  UIManager:DeleteAllWindow()
  UIUtil.AddOneCover("openFactory", SafePack(nil, nil, nil, Color.black, false))
  self:InitAllData()
  CS.GSceneManager.Instance:LoadSceneByAB(Consts.SceneName.Factory, function()
    UIUtil.CloseOneCover("openFactory")
    AudioManager:PlayAudioById(3003)
    AudioManager:PlayAudioById(1088)
    self.resloader = CS.ResLoader.Create()
    self:CheckUnlockCondiction()
    UIManager:ShowWindowAsync(UIWindowTypeID.Factory, function(win)
      self.factoryMainUI = win
      self:InitBindingData()
      self:InitRoomEntities()
      self:OnUpdateProduceLineTime()
    end)
    self.lineTimerId = TimerManager:StartTimer(1, self.OnUpdateProduceLineTime, self, false, nil, true)
  end)
end

function FactoryController:CloseFactory(notNeedBack2Home)
  if self.ui3DCanvas ~= nil then
    self.ui3DCanvas:Delete()
    self.ui3DCanvas = nil
  end
  if self.factoryMainUI ~= nil then
    self.factoryMainUI:Delete()
    self.factoryMainUI = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.lineTimerId ~= nil then
    TimerManager:StopTimer(self.lineTimerId)
    self.lineTimerId = nil
  end
  AudioManager:RemoveAllVoice()
  if notNeedBack2Home ~= true then
    UIManager:DeleteAllWindow()
    CS.GSceneManager.Instance:LoadSceneByAB(Consts.SceneName.Main, function()
      ControllerManager:GetController(ControllerTypeId.HomeController, true):OnEnterHome()
      UIManager:HideWindow(UIWindowTypeID.ClickContinue)
      UIManager:CreateWindowAsync(UIWindowTypeID.Home, function(window)
        if window == nil then
          return
        end
        window:SetFrom2Home(AreaConst.FactoryDorm, true)
      end)
    end)
  end
end

function FactoryController:InitAllData(callback)
  self.networkCtrl:CS_FACTORY_Detail(function()
    self:CheckUnlockCondiction()
    self.OrderDataDic = {}
    self.OrderDataListDic = {}
    self:InitOrderDatas()
    if callback ~= nil then
      callback()
    end
  end)
end

local ROOM_SLOT_NUM = 7

function FactoryController:CheckUnlockCondiction()
  self.unlockedRoom = {}
  self.unlockedCondicton = {}
  self.notOpenedRoom = {}
  local factoryCfgs = ConfigData.factory
  for roomId, factoryCfg in pairs(factoryCfgs) do
    if factoryCfg.is_open == 0 then
      self.notOpenedRoom[roomId] = true
    else
      local isUnlcok = CheckCondition.CheckLua(factoryCfg.pre_condition, factoryCfg.pre_para1, factoryCfg.pre_para2)
      if isUnlcok then
        self.unlockedRoom[roomId] = isUnlcok
      else
        self.unlockedCondicton[roomId] = CheckCondition.GetUnlockInfoLua(factoryCfg.pre_condition, factoryCfg.pre_para1, factoryCfg.pre_para2)
      end
    end
  end
  for roomId = 1, ROOM_SLOT_NUM do
    if self.unlockedRoom[roomId] == nil and self.unlockedCondicton[roomId] == nil then
      self.notOpenedRoom[roomId] = true
    end
  end
end

function FactoryController:AddNoticePreconditionData()
  local factoryCfgs = ConfigData.factory
  for index, _ in pairs(self.unlockedCondicton) do
    local factoryCfg = factoryCfgs[index]
    for index, pre_conditionId in ipairs(factoryCfg.pre_condition) do
      local pre_para1 = factoryCfg.pre_para1[index]
      local pre_para2 = factoryCfg.pre_para2[index]
      NoticeManager:Add2PreConditionDic(pre_conditionId, pre_para1, pre_para2, function()
        if CheckCondition.CheckLua(factoryCfg.pre_condition, factoryCfg.pre_para1, factoryCfg.pre_para2) then
          NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.FactoryUnlockNewFactory, {
            jumpType = JumpManager.eJumpTarget.Factory,
            argList = nil
          }, {
            LanguageUtil.GetLocaleText(factoryCfg.name)
          }, {
            id = factoryCfg.id
          }))
          return true
        end
      end)
    end
  end
  for orderId, factoryOrderData in pairs(self.OrderDataDic) do
    if not factoryOrderData.isUnlock then
      local orderCfg = factoryOrderData:GetOrderCfg()
      for index, pre_conditionId in ipairs(orderCfg.pre_condition) do
        local pre_para1 = orderCfg.pre_para1[index]
        local pre_para2 = orderCfg.pre_para2[index]
        NoticeManager:Add2PreConditionDic(pre_conditionId, pre_para1, pre_para2, function()
          if CheckCondition.CheckLua(orderCfg.pre_condition, orderCfg.pre_para1, orderCfg.pre_para2) then
            NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.FactoryUnlockNewOrder, {
              jumpType = JumpManager.eJumpTarget.Factory,
              argList = nil
            }, {
              LanguageUtil.GetLocaleText(orderCfg.name)
            }, nil))
            return true
          end
        end)
      end
    end
  end
end

function FactoryController:GetRoomEnegeyByIndex(index)
  local factoryEnergyItemId = ConfigData.game_config.factoryEnergyItemId
  local totalCeiling = PlayerDataCenter.playerBonus:GetWarehouseCapcity(factoryEnergyItemId)
  local totalValue = PlayerDataCenter:GetItemCount(factoryEnergyItemId)
  return totalValue, totalCeiling
end

function FactoryController:GetRoomEnegeyBaseSpeedByIndex(index)
  local factoryEnergyItemId = ConfigData.game_config.factoryEnergyItemId
  local speed = PlayerDataCenter.allEffectorData:GetCurrentARGSpeed(factoryEnergyItemId, true)
  return speed
end

function FactoryController:OnRecRoomHeroList(linesInfo)
  for roomIndex, workshopGroup in pairs(linesInfo) do
    self.enteredHero[roomIndex] = {}
    if workshopGroup.heroIds ~= nil then
      for heroId, _ in pairs(workshopGroup.heroIds) do
        table.insert(self.enteredHero[roomIndex], heroId)
      end
    end
    self.ProcessingOrders[roomIndex] = {}
    if workshopGroup.process ~= nil then
      for uid, processOrderMsg in pairs(workshopGroup.process) do
        local factoryProcessData = FactoryProcessingData.CreateProcessOrderData(roomIndex, uid, processOrderMsg)
        self.ProcessingOrders[roomIndex][uid] = factoryProcessData
      end
    end
    if workshopGroup.lastOrder ~= nil then
      self._lastOrders[roomIndex] = workshopGroup.lastOrder
    end
  end
  for roomIndex, heroIdList in pairs(self.enteredHero) do
    self:ChangeEnergyGenSpeed(roomIndex, heroIdList)
  end
  PlayerDataCenter.allEffectorData:OnUpdateItemGenerateSpeed()
  self:OnUpdateARG()
  self:OnUpdateProduceLine()
end

function FactoryController:HandleFactoryDiff(diffMsg)
  if diffMsg.update ~= nil then
    for mixId, workshopGroup in pairs(diffMsg.update) do
      local roomIndex = mixId >> 32
      local uid = mixId & CommonUtil.UInt32Max
      if self.ProcessingOrders[roomIndex] == nil then
        self.ProcessingOrders[roomIndex] = {}
      end
      if workshopGroup.process ~= nil then
        for uid, processOrderMsg in pairs(workshopGroup.process) do
          local factoryProcessData = FactoryProcessingData.CreateProcessOrderData(roomIndex, uid, processOrderMsg)
          self.ProcessingOrders[roomIndex][uid] = factoryProcessData
        end
      end
    end
  end
  if diffMsg.delete ~= nil then
    for mixId, _ in pairs(diffMsg.delete) do
      local roomIndex = mixId >> 32
      local uid = mixId & CommonUtil.UInt32Max
      self.ProcessingOrders[roomIndex][uid] = nil
    end
  end
  for roomIndex, workShop in pairs(diffMsg.updateLastOrder) do
    self._lastOrders[roomIndex] = workShop.lastOrder
  end
  self:OnUpdateProduceLine()
end

function FactoryController:SetRoomHeroList(lineId, heroList, callBack)
  self.networkCtrl:CS_FACTORY_DispatchHero(lineId, heroList, function()
    if 0 < #heroList then
      local voHeroId = heroList[math.random(#heroList)]
      local voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.InFactory, nil, voHeroId)
      local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
      cvCtr:PlayCv(voHeroId, voiceId)
    end
    local needRefreshRoomDic = {}
    needRefreshRoomDic[lineId] = true
    for lineId, heroIds in pairs(self.enteredHero) do
      for i = #heroIds, 1, -1 do
        local heroId = heroIds[i]
        if table.contain(heroList, heroId) then
          table.remove(heroIds, i)
          needRefreshRoomDic[lineId] = true
        end
      end
    end
    self.enteredHero[lineId] = heroList
    for roomIndex, heroIdList in pairs(self.enteredHero) do
      self:ChangeEnergyGenSpeed(roomIndex, heroIdList)
    end
    PlayerDataCenter.allEffectorData:OnUpdateItemGenerateSpeed()
    self:OnUpdateARG()
    if callBack ~= nil then
      callBack()
    end
    for roomIndex, _ in pairs(needRefreshRoomDic) do
    end
  end)
end

function FactoryController:GetRoomHeroList()
  return self.enteredHero
end

function FactoryController:GetHeroEnterAccrate(roomIndex, heroIdList)
  local accRate = 0
  local _, _, baseSpeed = self:GetRoomEnegeyByIndex(roomIndex)
  for _, heroId in ipairs(heroIdList) do
    local heroData = PlayerDataCenter.heroDic[heroId]
    local level = heroData.level
    local rank = heroData.rank
    local starScore = ConfigData.star_score[rank].score
    local FriendShiplevel = PlayerDataCenter.allFriendshipData:GetLevel(heroId)
    accRate = accRate + (starScore + level * self.factoryEnterArgs[1] + FriendShiplevel * self.factoryEnterArgs[2]) / (self.factoryEnterArgs[3] * 1000)
  end
  return accRate
end

function FactoryController:GetOneHeroAccrateDetail(roomIndex, heroId)
  local levelRate = 0
  local friendshipRate = 0
  local RankRate = 0
  local dliverNum = self.factoryEnterArgs[3] * 1000
  local heroData = PlayerDataCenter.heroDic[heroId]
  local level = heroData.level
  local rank = heroData.rank
  local starScore = ConfigData.star_score[rank].score
  local FriendShiplevel = PlayerDataCenter.allFriendshipData:GetLevel(heroId)
  levelRate = level * self.factoryEnterArgs[1] / dliverNum
  friendshipRate = FriendShiplevel * self.factoryEnterArgs[2] / dliverNum
  RankRate = starScore / dliverNum
  return levelRate, friendshipRate, RankRate
end

function FactoryController:ChangeEnergyGenSpeed(roomIndex, heroIdList)
end

function FactoryController:OnHeroDataChange()
end

function FactoryController:InitBindingData()
  self.roomEntityDic = {}
  self.roomBind = {}
  local cameraRoot = CS.UnityEngine.GameObject.Find("CameraRoot").transform
  UIUtil.LuaUIBindingTable(cameraRoot, self.roomBind)
  self.cameraDefaultPos = self.roomBind.camera.transform.position
  self.ui3DCanvas = UIN3DFactoryCanvas.New()
  self.ui3DCanvas:Init(self.roomBind.uICanvas)
  self.ui3DCanvas:SetClickBackgroundCallback(self.factoryMainUI.m_OnClick3DBGWithPop)
  self.__CloseFactory = BindCallback(self, self.CloseFactory)
  self.roomBind.factoryToHome:stopped("+", self.__CloseFactory)
end

function FactoryController:RefreshFactoryEnergyRedDot()
  local factoryEnergyItemId = ConfigData.game_config.factoryEnergyItemId
  local totalCeiling = PlayerDataCenter.playerBonus:GetWarehouseCapcity(factoryEnergyItemId)
  local totalValue = PlayerDataCenter:GetItemCount(factoryEnergyItemId)
  local ok, factoryNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Factory, RedDotStaticTypeId.FactoryEnerage)
  if ok then
    if totalCeiling <= totalValue then
      factoryNode:SetRedDotCount(1)
    else
      factoryNode:SetRedDotCount(0)
    end
  end
end

function FactoryController:OnUpdateARG(changedItemNumDic)
  if changedItemNumDic ~= nil and changedItemNumDic[ConfigData.game_config.factoryEnergyItemId] ~= nil then
    self:RefreshFactoryEnergyRedDot()
    if self.factoryMainUI ~= nil then
      self.factoryMainUI:UpdateEnergy()
    end
    local lineWin = UIManager:GetWindow(UIWindowTypeID.FactoryProduceLine)
    if lineWin ~= nil then
      lineWin:InitAllLines()
    end
  end
end

function FactoryController:OnUpdateProduceLine()
  if self.ui3DCanvas ~= nil then
    self.ui3DCanvas:RefreshProcessLines(self.ProcessingOrders)
  end
  local productLineWin = UIManager:GetWindow(UIWindowTypeID.FactoryProduceLine)
  if productLineWin ~= nil then
    productLineWin:InitAllLines()
  end
  if self.factoryMainUI ~= nil then
    self.factoryMainUI:RefreshProduceLineInfo()
  end
end

function FactoryController:OnUpdateProduceLineTime()
  if self.ui3DCanvas ~= nil then
    self.ui3DCanvas:RefreshProcessLines(self.ProcessingOrders)
  end
  local productLineWin = UIManager:GetWindow(UIWindowTypeID.FactoryProduceLine)
  if productLineWin ~= nil then
    productLineWin:OnTimeRefresh()
  end
  if self.factoryMainUI ~= nil then
    self.factoryMainUI:RefreshProduceLineInfo()
  end
  self:RefreshFactoryRedDot()
end

function FactoryController:RefreshFactoryRedDot()
  local finishedOrderNum = 0
  for roomIndex, processingDataDic in pairs(self.ProcessingOrders) do
    for uid, processingData in pairs(processingDataDic) do
      if processingData:GetIsFinish() then
        finishedOrderNum = finishedOrderNum + 1
      end
    end
  end
  local nodeOk, heroNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Factory, RedDotStaticTypeId.FactoryProcessLine)
  if nodeOk then
    heroNode:SetRedDotCount(finishedOrderNum)
  end
end

function FactoryController:InitOrderDatas()
  for _, orderCfg in pairs(ConfigData.factory_order) do
    local isRoomUnlock = self.unlockedRoom[orderCfg.type]
    self.OrderDataDic[orderCfg.id] = FactoryOrderData.CreateOrderData(orderCfg, isRoomUnlock)
  end
end

function FactoryController:GetOrders(roomIndex)
  if self.OrderDataListDic[roomIndex] == nil then
    local orders = {}
    for orderId, orderData in pairs(self.OrderDataDic) do
      if orderData:GetOrderRoomIndex() == roomIndex then
        table.insert(orders, orderData)
      end
    end
    table.sort(orders, function(a, b)
      if a:GetIsUnlock() == b:GetIsUnlock() then
        return a:GetOrderCfg().id < b:GetOrderCfg().id
      else
        return a:GetIsUnlock()
      end
    end)
    self.OrderDataListDic[roomIndex] = orders
  end
  for orderId, orderData in pairs(self.OrderDataDic) do
    orderData:UpdateOrderData()
  end
  return self.OrderDataListDic[roomIndex]
end

function FactoryController:InitRoomEntities()
  local m_OnClickRoom = self.factoryMainUI.m_OnClickRoom
  for index, _ in pairs(self.unlockedRoom) do
    local roomType = ConfigData.factory[index].model
    local obj = self:GetRoomModelGo(index, roomType)
    local roomEntity = FactoryRoomEntity.New()
    roomEntity:InitRoomObject(obj, m_OnClickRoom, FactoryEnum.eRoomType.normal, index, nil)
    self.roomEntityDic[index] = roomEntity
  end
  for index, unlcokDes in pairs(self.unlockedCondicton) do
    local roomPath = PathConsts:GetFactoryPath("FactoryRoom_empty")
    self.resloader:LoadABAssetAsync(roomPath, function(prefab)
      local roomType = ConfigData.factory[index].model
      local obj = self:GetRoomModelGo(index, roomType)
      local roomEntity = FactoryRoomEntity.New()
      roomEntity:InitRoomObject(obj, m_OnClickRoom, FactoryEnum.eRoomType.locked, index, unlcokDes)
      self.roomEntityDic[index] = roomEntity
    end)
  end
  for index, _ in pairs(self.notOpenedRoom) do
    local roomPath = PathConsts:GetFactoryPath("FactoryRoom_empty")
    self.resloader:LoadABAssetAsync(roomPath, function(prefab)
      local obj = prefab:Instantiate(self.roomBind.rooms)
      obj.transform.position = self.roomBind.rooms_normal[index].transform.position
      if CS.ClientConsts.IsAudit then
        local meshRender = obj:FindComponent(eUnityComponentID.MeshRenderer)
        meshRender.reflectionProbeUsage = CS.UnityEngine.Rendering.ReflectionProbeUsage.Off
        return
      end
      local roomEntity = FactoryRoomEntity.New()
      roomEntity:InitRoomObject(obj, m_OnClickRoom, FactoryEnum.eRoomType.notOpen, index)
      self.roomEntityDic[index] = roomEntity
    end)
  end
end

function FactoryController:ChangeRoomModelGo(index, type)
  local entity = self.roomEntityDic[index]
  if entity.type == type then
    return
  end
  self.roomType[index] = type
  local go = self:GetRoomModelGo(index, type)
  if go ~= nil then
    entity:ChangeRoomModelGo(go, type)
  end
end

function FactoryController:GetRoomModelGo(index, type)
  if type == FactoryEnum.eRoomType.normal then
    return self.roomBind.rooms_normal[index]
  elseif type == FactoryEnum.eRoomType.dig then
    return self.roomBind.rooms_dig[index]
  elseif type == FactoryEnum.eRoomType.present then
    return self.roomBind.rooms_present[index]
  elseif type == FactoryEnum.eRoomType.locked then
    error("commonly a unlocked room can't switch to lock")
  else
    return self.roomBind.rooms_normal[index]
  end
end

function FactoryController:GetOrder4Send()
  return self.Order4SendData
end

function FactoryController:GetResItemDic4Order4Send()
  if self.Order4SendData == nil then
    return nil
  end
  local dic = {}
  if self.Order4SendData.curOrderId == nil then
    return nil
  end
  local orderCfg = ConfigData.factory_order[self.Order4SendData.curOrderId]
  for itemId, cost in pairs(orderCfg.raw_material) do
    dic[itemId] = true
  end
  if self.Order4SendData.assistOrderDic == nil then
    return dic
  end
  for assOrderId, assOrderNum in pairs(self.Order4SendData.assistOrderDic) do
    local orderCfg = ConfigData.factory_order[assOrderId]
    for itemId, cost in pairs(orderCfg.raw_material) do
      dic[itemId] = true
    end
  end
  return dic
end

function FactoryController:ClearOrder()
  self.Order4SendData = nil
  self.productOrderAddDic = nil
end

local MAX_TIME_COST = ConfigData.game_config.factoryTimeCostLimit

function FactoryController:TryAddOneOrder(lindIndex, orderData, usedBagItem)
  local orderCfg = orderData:GetOrderCfg()
  local orderId = orderCfg.id
  if self.Order4SendData ~= nil and (self.Order4SendData.lineIndex ~= lindIndex or self.Order4SendData.curOrderId ~= orderId) then
    error("doesn't clean old orderData")
    return false
  end
  if orderData:GetOrderType() == FactoryEnum.eOrderType.dig then
    if self.Order4SendData == nil then
      local warehouseNotFull = orderData:GetIsWhareHouseNotFull(0)
      local couldAdd = MAX_TIME_COST / orderData:GetTimeCost() >= 1
      if couldAdd then
        if not warehouseNotFull then
          return false, FactoryEnum.eCannotAddReason.warehouseFull
        end
        self.Order4SendData = FactoryCalcSendOrder.CreateSendOrderDig(orderId, 1, lindIndex, orderData)
        self.Order4SendData.isOrderMax = false
        return true
      else
        return false, FactoryEnum.eCannotAddReason.timeBeyountLimit
      end
    else
      local warehouseNotFull = orderData:GetIsWhareHouseNotFull(self.Order4SendData.curOrderNum)
      local couldAdd = 1 <= (MAX_TIME_COST - self.Order4SendData.usedTime) / orderData:GetTimeCost()
      if couldAdd then
        if not warehouseNotFull then
          return false, FactoryEnum.eCannotAddReason.warehouseFull
        end
        self.Order4SendData.curOrderNum = self.Order4SendData.curOrderNum + 1
        self.Order4SendData.usedTime = orderData:GetTimeCost() * self.Order4SendData.curOrderNum
        return true
      else
        return false, FactoryEnum.eCannotAddReason.timeBeyountLimit
      end
    end
  elseif orderData:GetOrderType() == FactoryEnum.eOrderType.product then
    if self.Order4SendData == nil then
      local couldCreate, value = FactoryCalcSendOrder.TryCreateSendOrderProduct(orderData, lindIndex, MAX_TIME_COST, usedBagItem)
      if couldCreate then
        self.Order4SendData = value
        if self.Order4SendData:HasSubOrder() then
          if self.productOrderAddDic == nil then
            self.productOrderAddDic = {}
          end
          self.productOrderAddDic[self.Order4SendData.curOrderNum] = table.deepCopy(self.Order4SendData)
        end
        return true
      else
        return false, value
      end
    else
      local couldAdd, value = self.Order4SendData:CheckNextProductOrder(MAX_TIME_COST, usedBagItem)
      if couldAdd then
        if self.Order4SendData:HasSubOrder() then
          if self.productOrderAddDic == nil then
            self.productOrderAddDic = {}
          end
          self.productOrderAddDic[self.Order4SendData.curOrderNum] = table.deepCopy(self.Order4SendData)
        end
        return true
      else
        return false, value
      end
    end
  end
end

function FactoryController:TryMinOneOrder(lindIndex, orderData)
  local orderCfg = orderData:GetOrderCfg()
  local orderId = orderCfg.id
  if self.Order4SendData ~= nil and (self.Order4SendData.lineIndex ~= lindIndex or self.Order4SendData.curOrderId ~= orderId) then
    error("doesn't clean old orderData")
    return false
  end
  if orderData:GetOrderType() == FactoryEnum.eOrderType.dig then
    if self.Order4SendData == nil or self.Order4SendData.curOrderNum < 1 then
      return false
    else
      self.Order4SendData.isOrderMax = false
      self.Order4SendData.curOrderNum = self.Order4SendData.curOrderNum - 1
      self.Order4SendData.usedTime = orderData:GetTimeCost() * self.Order4SendData.curOrderNum
      return true
    end
  elseif orderData:GetOrderType() == FactoryEnum.eOrderType.product then
    if self.Order4SendData == nil or self.Order4SendData.curOrderNum < 1 then
      return false
    end
    self.Order4SendData.isOrderMax = false
    local curNum = self.Order4SendData.curOrderNum
    if self.productOrderAddDic ~= nil and self.productOrderAddDic[curNum - 1] ~= nil then
      self.Order4SendData = table.deepCopy(self.productOrderAddDic[curNum - 1])
      return true
    else
      if 0 < curNum then
        self.Order4SendData.curOrderNum = self.Order4SendData.curOrderNum - 1
        self.Order4SendData.usedTime = orderData:GetTimeCost() * self.Order4SendData.curOrderNum
        local usedMat = {}
        for itemId, cost in pairs(orderCfg.raw_material) do
          usedMat[itemId] = cost * self.Order4SendData.curOrderNum
        end
        self.Order4SendData.assistOrderDic = {}
        self.Order4SendData.usedMat = usedMat
        return true
      end
      return false
    end
  end
end

function FactoryController:TryAddMaxOrder(lindIndex, orderData, usedBagItem)
  local orderCfg = orderData:GetOrderCfg()
  local orderId = orderCfg.id
  if self.Order4SendData ~= nil and (self.Order4SendData.lineIndex ~= lindIndex or self.Order4SendData.curOrderId ~= orderId) then
    error("doesn't clean old orderData")
    return false
  end
  if orderData:GetOrderType() == FactoryEnum.eOrderType.dig then
    local couldAddNum = MAX_TIME_COST // orderData:GetTimeCost()
    local warehouseCapacity = PlayerDataCenter.playerBonus:GetWarehouseCapcity(orderCfg.outPutItemId)
    if warehouseCapacity == 0 then
      local itemCfg = ConfigData.item[orderCfg.outPutItemId]
      if itemCfg == nil or itemCfg.holdlimit == nil then
        error("can't read itemCfg/itemCfg.holdlimit with id = " .. tostring(orderCfg.outPutItemId))
      else
        warehouseCapacity = itemCfg.holdlimit
      end
    end
    local curwarehouseNum = PlayerDataCenter:GetItemCount(orderCfg.outPutItemId, false)
    if warehouseCapacity ~= 0 then
      local num = (warehouseCapacity - curwarehouseNum) // orderCfg.outPutItemNum
      if num <= 0 then
        couldAddNum = 0
      else
        couldAddNum = math.min(couldAddNum, num)
      end
    end
    if 0 < couldAddNum then
      self.Order4SendData = FactoryCalcSendOrder.CreateSendOrderDig(orderId, couldAddNum, lindIndex, orderData)
      self.Order4SendData.isOrderMax = true
      return true
    else
      return false
    end
  elseif orderData:GetOrderType() == FactoryEnum.eOrderType.product then
    local couldAdd = true
    local reason
    while couldAdd do
      couldAdd, reason = self:TryAddOneOrder(lindIndex, orderData, usedBagItem)
    end
    if self.Order4SendData == nil then
      return false, reason
    end
    self.Order4SendData.isOrderMax = true
    local result = 0 < self.Order4SendData.curOrderNum
    if result then
      return true
    end
    return false, reason
  end
end

function FactoryController:SendOrder(callback, isUseTime)
  if self.Order4SendData == nil or self.Order4SendData.curOrderNum < 1 then
    return
  end
  if self.Order4SendData.assistOrderDic ~= nil then
    for assOrderId, assOrderNum in pairs(self.Order4SendData.assistOrderDic) do
      local orderCfg = ConfigData.factory_order[assOrderId]
      local outPutItemId = orderCfg.outPutItemId
      local outPutItemNum = orderCfg.outPutItemNum
      local warehouseCapacity = PlayerDataCenter.playerBonus:GetWarehouseCapcity(outPutItemId)
      local curwarehouseNum = PlayerDataCenter:GetItemCount(outPutItemId, false)
      if 0 < warehouseCapacity and warehouseCapacity < outPutItemNum * assOrderNum + curwarehouseNum then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Factory_WarehousFull))
        return
      end
    end
  end
  local Order4SendData = table.deepCopy(self.Order4SendData)
  self:ClearOrder()
  if isUseTime then
    self.networkCtrl:CS_FACTORY_ConsumeTimeProduct(Order4SendData, function()
      callback()
    end)
  else
    self.networkCtrl:CS_FACTORY_WorkshopProduct(Order4SendData, function()
      callback()
    end)
  end
end

function FactoryController:CancleOrder(processingData)
  local roomIndex, uid = processingData:GetIndexAndUid()
  self.networkCtrl:CS_FACTORY_CancelOrder(roomIndex, uid, function()
    self.ProcessingOrders[roomIndex][uid] = nil
    self:OnUpdateProduceLine()
  end)
end

function FactoryController:QuickFinishOrder(processingData)
  local roomIndex, uid = processingData:GetIndexAndUid()
  self.networkCtrl:CS_FACTORY_ImmediatelyComplete(roomIndex, uid, function()
    local processingOrderData = processingData
    local rewardIds = {
      processingOrderData:GetOutputItemCfg().id
    }
    local rewardNums = {
      processingOrderData:GetOutputItemProduceNum()
    }
    self.ProcessingOrders[roomIndex][uid] = nil
    self:OnUpdateProduceLine()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums)
      window:AddAndTryShowReward(CRData)
    end)
  end)
end

function FactoryController:PickOrderReward(processingData)
  local roomIndex, uid = processingData:GetIndexAndUid()
  self.networkCtrl:CS_FACTORY_Collect(roomIndex, uid, function()
    local processingOrderData = processingData
    local rewardIds = {
      processingOrderData:GetOutputItemCfg().id
    }
    local rewardNums = {
      processingOrderData:GetOutputItemProduceNum()
    }
    self.ProcessingOrders[roomIndex][uid] = nil
    self:OnUpdateProduceLine()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums)
      window:AddAndTryShowReward(CRData)
    end)
  end)
end

function FactoryController:GetCurOrderAndMaxOrderNum()
  local curOrderNum = 0
  local maxOrderNum = 0
  local isHaveFinished = false
  for roomindex, isuNlock in pairs(self.unlockedRoom) do
    if isuNlock then
      maxOrderNum = maxOrderNum + 1
    end
  end
  for roomIndex, orderDic in pairs(self.ProcessingOrders) do
    for uid, processingData in pairs(orderDic) do
      curOrderNum = curOrderNum + 1
      if processingData:GetIsFinish() then
        isHaveFinished = true
      end
    end
  end
  return curOrderNum, maxOrderNum, isHaveFinished
end

function FactoryController:FactoryQuickPickAllState()
  for roomIndex, orderDic in pairs(self.ProcessingOrders) do
    for uid, processingData in pairs(orderDic) do
      if processingData:GetIsFinish() then
        return true
      end
    end
  end
  return false
end

function FactoryController:FactoryReqQuickPickAll()
  local pickAll = self:FactoryQuickPickAllState()
  if not pickAll then
    return
  end
  local rewardIds = {}
  local rewardNums = {}
  for k, orderDic in pairs(self.ProcessingOrders) do
    for uid, processingData in pairs(orderDic) do
      if processingData:GetIsFinish() then
        table.insert(rewardIds, processingData:GetOutputItemCfg().id)
        table.insert(rewardNums, processingData:GetOutputItemProduceNum())
      end
    end
  end
  self.networkCtrl:CS_FACTORY_OneKeyCollect(function()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums)
      window:AddAndTryShowReward(CRData)
    end)
  end)
end

function FactoryController:FactoryQuickTimeProductState()
  for roomIndex, value in pairs(self.unlockedRoom) do
    if value then
      local orderDic = self.ProcessingOrders[roomIndex]
      if orderDic == nil or table.IsEmptyTable(orderDic) then
        return true
      end
    end
  end
  return false
end

function FactoryController:FactoryReqQuickTimeProduct()
  local enableQuick = self:FactoryQuickTimeProductState()
  if not enableQuick then
    return
  end
  local usedTempBag = {}
  local sendOrders = {}
  local failReasonType
  for roomIndex, value in pairs(self.unlockedRoom) do
    failReasonType = nil
    if value then
      local orderDic = self.ProcessingOrders[roomIndex]
      if orderDic ~= nil and not table.IsEmptyTable(orderDic) then
        failReasonType = FactoryEnum.eCannotAddReason.curOrderIsBusy
      else
        local lastOrder = self._lastOrders[roomIndex]
        if lastOrder == nil then
          failReasonType = FactoryEnum.eCannotAddReason.noLastOrder
        else
          local orderData = self.OrderDataDic[lastOrder.id]
          if orderData ~= nil then
            if orderData:GetOrderType() == FactoryEnum.eOrderType.dig then
              if lastOrder.isOrderMax then
                if not self:TryAddMaxOrder(roomIndex, orderData) then
                  failReasonType = FactoryEnum.eCannotAddReason.warehouseFull
                  goto lbl_202
                end
              else
                if lastOrder.num <= 0 then
                  goto lbl_202
                end
                local couldAdd = true
                local addNum = 0
                while couldAdd and addNum < lastOrder.num do
                  couldAdd = self:TryAddOneOrder(roomIndex, orderData)
                  addNum = addNum + 1
                end
                if self.Order4SendData == nil or 0 >= self.Order4SendData.curOrderNum then
                  failReasonType = FactoryEnum.eCannotAddReason.warehouseFull
                  goto lbl_202
                end
              end
            elseif orderData:GetOrderType() == FactoryEnum.eOrderType.product then
              if lastOrder.isOrderMax then
                local result, reason = self:TryAddMaxOrder(roomIndex, orderData, usedTempBag)
                if not result then
                  failReasonType = reason
                  goto lbl_202
                end
              else
                if lastOrder.num <= 0 then
                  goto lbl_202
                end
                local couldAdd = true
                local addNum = 0
                local reason
                while couldAdd and addNum < lastOrder.num do
                  couldAdd, reason = self:TryAddOneOrder(roomIndex, orderData, usedTempBag)
                  addNum = addNum + 1
                end
                if self.Order4SendData == nil or 0 >= self.Order4SendData.curOrderNum then
                  failReasonType = reason
                  goto lbl_202
                end
              end
            end
            if self.Order4SendData ~= nil then
              if orderData:GetOrderType() == FactoryEnum.eOrderType.product then
                local useBagMat = self.Order4SendData.useBagMat
                for itemId, value in pairs(useBagMat) do
                  if 0 <= value then
                    usedTempBag[itemId] = (usedTempBag[itemId] or 0) + value
                  else
                    usedTempBag[itemId] = PlayerDataCenter:GetItemCount(itemId)
                  end
                end
              end
              table.insert(sendOrders, {
                workshopId = self.Order4SendData.lineIndex,
                orderId = self.Order4SendData.curOrderId,
                orderNum = self.Order4SendData.curOrderNum,
                assistOrders = self.Order4SendData.assistOrderDic,
                isMax = self.Order4SendData.isOrderMax
              })
              local roomName = LanguageUtil.GetLocaleText(ConfigData.factory[roomIndex].name)
              cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(512, roomName), true)
            end
          end
        end
      end
    end
    ::lbl_202::
    local roomName = LanguageUtil.GetLocaleText(ConfigData.factory[roomIndex].name)
    if failReasonType ~= nil then
      if failReasonType == FactoryEnum.eCannotAddReason.matInsufficeient then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Factory_MatInsufficient, roomName), true)
      elseif failReasonType == FactoryEnum.eCannotAddReason.warehouseFull then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(513, roomName), true)
      elseif failReasonType == FactoryEnum.eCannotAddReason.noLastOrder then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(511, roomName), true)
      elseif failReasonType == FactoryEnum.eCannotAddReason.curOrderIsBusy then
        cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Factory_AlreadyHaveOrder, roomName), true)
      end
    end
    self:ClearOrder()
  end
  if 0 < #sendOrders then
    self.networkCtrl:CS_FACTORY_MultProduct(sendOrders)
    local factoryWindow = UIManager:GetWindow(UIWindowTypeID.Factory)
    if factoryWindow ~= nil then
      factoryWindow:CloseOrderNodesSafe()
    end
  end
end

local COS_45 = math.cos(45)
local CAMERA_TARGET_POS = Vector3.New(47.64, 42, 52.36)

function FactoryController:StartMoveRoomToLeftMin(orderUI, roomIndex, isFromOtherRoom)
  self.cameraTargetPos = CAMERA_TARGET_POS
end

function FactoryController:OnMoveRoomToLeftMin(onMoveCallback, playrate, isFromOtherRoom)
  if isFromOtherRoom then
    self.roomBind.camera.transform.position = Vector3.Lerp(self.cameraPos, self.cameraTargetPos, playrate)
  else
    self.roomBind.camera.transform.position = Vector3.Lerp(self.cameraDefaultPos, self.cameraTargetPos, playrate)
  end
  if onMoveCallback ~= nil then
    onMoveCallback()
  end
end

function FactoryController:ForceMoveToLeft(onMoveCallback)
  self.roomBind.camera.transform.position = self.cameraTargetPos
  if onMoveCallback ~= nil then
    onMoveCallback()
  end
end

function FactoryController:MoveRoomToMid(onMoveCallback)
  self.roomBind.camera.transform.position = self.cameraDefaultPos
  if onMoveCallback ~= nil then
    onMoveCallback()
  end
end

function FactoryController:IsCouldOpenQuickProduceUI(itemId, callback)
  if self.factoryMainUI ~= nil then
    return false
  end
  self:InitAllData(function()
    local targetOrderData
    for orderId, orderData in pairs(self.OrderDataDic) do
      if orderData:GetOrderCfg().outPutItemId == itemId then
        targetOrderData = orderData
        break
      end
    end
    local isOk
    if targetOrderData == nil then
      isOk = false
    elseif targetOrderData:GetIsUnlock() then
      isOk = true
    else
      isOk = false
    end
    if callback ~= nil then
      callback(isOk, targetOrderData)
    end
  end)
end

function FactoryController:OpenQuickProduceUI(targetOrderData, closeCallback)
  UIManager:ShowWindowAsync(UIWindowTypeID.FactoryQuickProduce, function(win)
    if win == nil then
      return
    end
    win:OpenQuickProduce(targetOrderData, closeCallback)
  end)
end

function FactoryController:OnDelete()
  if self.lineTimerId ~= nil then
    TimerManager:StopTimer(self.lineTimerId)
    self.lineTimerId = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.m_OnUpdateARG)
  base.OnDelete(self)
end

return FactoryController
