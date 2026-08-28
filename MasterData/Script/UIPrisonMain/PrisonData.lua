local PrisonData = {}
local this = PrisonData
PrisonData.roomIndex = 1
PrisonData.cellRoomIndex = 1
PrisonData.cellRoomAreaIndex = 1
PrisonData.ProductRoomTypeIdToIndexMap = {
  [87500013] = 1,
  [87500022] = 2,
  [87500023] = 3,
  [87500024] = 4,
  [87500025] = 5,
  [87500026] = 6
}
PrisonData.CellRoomTypeIdToRoomIndexMap = {
  [87500027] = 1,
  [87500028] = 2,
  [87500029] = 3,
  [87500030] = 4,
  [87500031] = 5,
  [87500032] = 6
}
PrisonData.CellRoomAreaIndexToAreaIdMap = {
  80303881,
  80303882,
  80303883,
  80303884,
  80303885,
  80303886
}

function PrisonData.GetPrisonCA()
  return PlayerData:GetFactoryData(86800014, "PrisonFactory")
end

function PrisonData.GetSeverPrisonData()
  return PlayerData.ServerData.user_prison_info
end

function PrisonData.GetPrisonerBag()
  return PlayerData.ServerData.user_prison_info.carrying_backpack
end

function PrisonData.GetPrisonerBagMaxCapacity()
  local prisonCA = PrisonData.GetPrisonCA()
  return prisonCA.arrestBag + TrainWeaponTag.GetWeaponTagAttributes(EnumDefine.TrainWeaponTagEnum.PrisonerBackPack)[2]
end

function PrisonData.GetProductRoomList()
  return PlayerData.ServerData.user_prison_info.workshops_front
end

function PrisonData.GetCellRoomList()
  return PlayerData.ServerData.user_prison_info.cell_front
end

function PrisonData.GetPrisonPrisoners()
  return PlayerData.ServerData.user_prison_info.prison_backpack
end

function PrisonData.GetPrisoner(u_pid, inBag)
  if inBag then
    return PlayerData.ServerData.user_prison_info.carrying_backpack[u_pid]
  else
    return PlayerData.ServerData.user_prison_info.prison_backpack[u_pid]
  end
end

function PrisonData.GetPrisonMasterList()
  return PlayerData.ServerData.user_prison_info.workshops_master
end

function PrisonData.GetPrisonLv()
  return PlayerData.ServerData.user_prison_info and PlayerData.ServerData.user_prison_info.lv or 1
end

function PrisonData.GetPrisonExp()
  return PlayerData.ServerData.user_prison_info.exp
end

function PrisonData.GetPurchaseOrderList()
  return PlayerData.ServerData.user_prison_info.orders
end

function PrisonData.GetPurchaseOrder(orderUid)
  return PlayerData.ServerData.user_prison_info.orders[orderUid]
end

function PrisonData.GetRawMaterialWarehouse()
  return PlayerData.ServerData.user_prison_info.raw_material
end

function PrisonData.GetRawMaterial(id)
  return PlayerData.ServerData.user_prison_info.raw_material[tostring(id)]
end

function PrisonData.GetRawMaterialWarehouseMaxCapacity()
  return PlayerData:GetUserInfo().space_info.max_prison_material_num or 0
end

function PrisonData.GetRawMaterialWarehouseCapacity()
  return PlayerData:GetUserInfo().space_info.now_prison_material_num or 0
end

function PrisonData.GetProductWareHouse()
  return PlayerData.ServerData.user_prison_info.product or 0
end

function PrisonData.GetProduct(id)
  return PlayerData.ServerData.user_prison_info.product[id]
end

function PrisonData.GetProductWarehouseMaxCapacity()
  return PlayerData:GetUserInfo().space_info.max_prison_product_num or 0
end

function PrisonData.GetProductWarehouseCapacity()
  return PlayerData:GetUserInfo().space_info.now_prison_product_num or 0
end

function PrisonData.GetRoomProducts(roomIndex)
  return PlayerData.ServerData.user_prison_info.workshops_product_plant[tostring(roomIndex)]
end

function PrisonData.GetCellProduct(roomIndex, cellIndex)
  local allProducts = this.GetRoomProducts(roomIndex)
  local product = allProducts and allProducts[tostring(cellIndex)]
  return product
end

function PrisonData.GetMargin()
  return PlayerData.ServerData.user_prison_info.margin
end

function PrisonData.GetMarginSwitch()
  return PlayerData.ServerData.user_prison_info.margin_switch
end

function PrisonData.GetBuildList()
  return PlayerData.ServerData.user_prison_info.rooms
end

function PrisonData.GetFurniture(ufid)
  return PlayerData.ServerData.user_prison_info.furniture[tostring(ufid)]
end

PrisonData.placedPrisonerList = {}
PrisonData.sceneAnimList = {}
PrisonData.productEvent = {}

function PrisonData.SetTimeEvent(cellIndex, eventType, invokeTime, func, params)
  if not this.productEvent[tonumber(cellIndex)] then
    this.productEvent[tonumber(cellIndex)] = {}
  end
  local eventList = this.productEvent[tonumber(cellIndex)]
  eventList[eventType] = {
    invokeTime = invokeTime,
    func = func,
    params = params
  }
end

function PrisonData.RefreshEventInvokeTime(cellIndex, eventType, time)
  local data = this.productEvent[tonumber(cellIndex)]
  if data then
    local eventData = data[eventType]
    if eventData then
      eventData.invokeTime = time
    end
  end
end

function PrisonData.SetCurRoomIndex(roomIndex)
  this.roomIndex = tonumber(roomIndex)
end

function PrisonData.SetCurCellRoomIndex(roomIndex)
  this.cellRoomIndex = tonumber(roomIndex)
end

function PrisonData.SetCurCellRoomAreaIndex(areaIndex)
  this.cellRoomAreaIndex = tonumber(areaIndex)
end

function PrisonData.GetAreaIndexAndPosIndex(cellIndex)
  local areaIndex, posIndex
  cellIndex = math.floor(tonumber(cellIndex))
  if cellIndex % 3 == 0 then
    areaIndex = cellIndex / 3
  else
    areaIndex = cellIndex // 3 + 1
  end
  posIndex = cellIndex - (areaIndex - 1) * 3
  return math.floor(areaIndex), math.floor(posIndex)
end

function PrisonData.GetCellIndex(areaIndex, posIndex)
  return 3 * (areaIndex - 1) + posIndex
end

function PrisonData.GetRoomData(roomIndex)
  return PlayerData.ServerData.user_prison_info.workshops_front[tostring(roomIndex)]
end

function PrisonData.CheckCanEditAndProduct()
  if not PlayerData.ServerData.user_prison_info or not PlayerData.ServerData.user_prison_info.rooms then
    return false
  end
  local roomData = PlayerData.ServerData.user_prison_info.rooms
  local preRoomReqList = PrisonData.GetPrisonCA().interceptRoomList
  for i, v in ipairs(preRoomReqList) do
    local serverData = roomData[tostring(v.id)]
    if not serverData then
      return false
    end
    local UIPrisonDataModel = require("UIPrison/UIPrisonDataModel")
    local remainTime = UIPrisonDataModel.GetRoomBuildRemainTime(v.id)
    if 0 < remainTime and serverData.lv == 1 then
      return false
    end
  end
  return true
end

function PrisonData.CheckAreaPosUnLock(roomIndex, cellIndex)
  local roomData = PlayerData.ServerData.user_prison_info.workshops_front[tostring(roomIndex)]
  return roomData and roomData[tostring(cellIndex)]
end

function PrisonData.GetFurPosInfo(areaIndex, posIndex)
  return 13 + (areaIndex - 1) * 5, (posIndex - 1) * 5
end

PrisonData.OrderStatus = {
  NoStart = 0,
  Working = 1,
  Completed = 2
}

function PrisonData.GetPurchaseOrderStatus(orderUid)
  local orderList = this.GetPurchaseOrderList()
  local orderData = orderList[orderUid]
  local startTime = orderData.purchase_ts
  if startTime == 0 then
    return this.OrderStatus.NoStart
  end
  local orderCA = PlayerData:GetFactoryData(orderData.prison_oid, "PrisonProcurementFactory")
  local remainTime = startTime + orderCA.costTime - TimeUtil.GetServerTimeStamp()
  return 0 < remainTime and this.OrderStatus.Working or this.OrderStatus.Completed
end

function PrisonData.GetPurchaseOrderQuality(orderId)
  local qualityMap = {}
  local prisonCA = PrisonData.GetPrisonCA()
  local prisonLv = this.GetPrisonLv()
  local orderListCA = PlayerData:GetFactoryData(prisonCA.lvList[prisonLv].PrisonProcurementList, "ListFactory")
  for i, v in ipairs(orderListCA.starWeightList) do
    qualityMap[v.id] = i
  end
  for key, quality in pairs(qualityMap) do
    if orderListCA[key] then
      for _, v in pairs(orderListCA[key]) do
        if v.id == tonumber(orderId) then
          return quality
        end
      end
    end
  end
  return 0
end

function PrisonData.CloseRoom()
  this.roomIndex = 1
  this.placedPrisonerList = {}
  this.npcCharacter = nil
  this.sceneAnimList = {}
  this.productEvent = {}
  this.curStationPlace = nil
end

function PrisonData.GetPlacedPrisonerList(roomIndex)
  local list = {}
  local data = PlayerData.ServerData.user_prison_info.workshops_front[tostring(roomIndex)]
  for cellIndex, u_pid in pairs(data) do
    if u_pid ~= "" then
      list[cellIndex] = u_pid
    end
  end
  return list
end

function PrisonData.GetPrisonerMaster(roomIndex)
  local dataList = this.GetPrisonMasterList()
  local upid = dataList[tostring(roomIndex)]
  return this.GetPrisoner(upid)
end

function PrisonData.GetPlacedFurList(roomIndex)
  local list = {}
  if PlayerData.ServerData.user_prison_info then
    local data = PlayerData.ServerData.user_prison_info.workshops_furniture[tostring(roomIndex)]
    if data then
      local program = PlayerData.ServerData.user_prison_info.workshops_programme[tostring(roomIndex)] or "1"
      for cellIndex, cellData in pairs(data) do
        local u_fid = cellData[program]
        if u_fid ~= "" then
          list[cellIndex] = u_fid
        end
      end
    end
  end
  return list
end

function PrisonData.SetPrisonModify(masterList, frontList, programList, callBack)
  Net:SendProto("prison.modify_front", function(json)
    if json.workshops_front then
      PlayerData.ServerData.user_prison_info.workshops_front = json.workshops_front
    end
    if json.workshops_master then
      PlayerData.ServerData.user_prison_info.workshops_master = json.workshops_master
    end
    if json.workshops_programme then
      PlayerData.ServerData.user_prison_info.workshops_programme = json.workshops_programme
    end
    if json.workshops_product_plant then
      PlayerData.ServerData.user_prison_info.workshops_product_plant = json.workshops_product_plant
    end
    if callBack then
      callBack(json)
    end
  end, Json.encode(masterList), Json.encode(frontList), Json.encode(programList))
end

function PrisonData.AddPurchaseOrder(callBack)
  local prisonCA = PrisonData.GetPrisonCA()
  local costInfo = prisonCA.addProcurementList[1]
  local costNum = PlayerData.TempCache.ItemPromptBatchNum
  if costNum > PlayerData:GetGoodsById(costInfo.id).num then
    CommonTips.OpenTips(80600062)
    return
  end
  local useItemTable = {
    {
      id = tostring(costInfo.id),
      num = PlayerData.TempCache.ItemPromptBatchNum
    }
  }
  local useItems = {}
  useItems[tostring(costInfo.id)] = PlayerData.TempCache.ItemPromptBatchNum
  Net:SendProto("prison.add_purchase_order", function(json)
    PlayerData:RefreshUseItems(useItems)
    PlayerData.ServerData.user_prison_info.orders = json.orders
    if callBack then
      callBack(json)
    end
  end, Json.encode(useItemTable))
end

function PrisonData.StartPurchaseOrder(orderUidList, callBack)
  local canGetList = {}
  local tempCostList = {}
  for i, orderUid in ipairs(orderUidList) do
    local orderData = this.GetPurchaseOrder(orderUid)
    local orderId = orderData.prison_oid
    local orderCA = PlayerData:GetFactoryData(orderId, "PrisonProcurementFactory")
    for i, v in pairs(orderCA.costList) do
      local tempCost = tempCostList[v.id] == nil and 0 or tempCostList[v.id]
      if this.GetGoodsById(v.id) - tempCost >= v.num then
        table.insert(canGetList, orderUid)
        tempCostList[orderUid] = v.num
      end
    end
  end
  if table.count(canGetList) == 0 then
    CommonTips.OpenTips(80600062)
    return
  end
  local uidListStr = ""
  for i, v in ipairs(canGetList) do
    if i < table.count(canGetList) then
      uidListStr = uidListStr .. v .. ","
    else
      uidListStr = uidListStr .. v
    end
  end
  Net:SendProto("prison.gen_order", function(json)
    if json.orders then
      PlayerData.ServerData.user_prison_info.orders = json.orders
    end
    if json.raw_material then
      PlayerData.ServerData.user_prison_info.raw_material = json.raw_material
    end
    if json.product then
      PlayerData.ServerData.user_prison_info.product = json.product
    end
    if json.last_cost then
      for i, useList in pairs(json.last_cost) do
        local useItems = {}
        for itemId, v in pairs(useList) do
          useItems[itemId] = v.num
        end
        PlayerData:RefreshUseItems(useItems)
      end
    end
    if callBack then
      callBack(json)
    end
  end, uidListStr, 1)
end

function PrisonData.ReceivePurchaseOrder(orderUidList, callBack)
  local canGetList = {}
  local canGetOrderIdList = {}
  local remainCapacity = this.GetRawMaterialWarehouseMaxCapacity() - this.GetRawMaterialWarehouseCapacity()
  for i, orderUid in ipairs(orderUidList) do
    local orderData = this.GetPurchaseOrder(orderUid)
    local orderId = orderData.prison_oid
    local orderCA = PlayerData:GetFactoryData(orderId, "PrisonProcurementFactory")
    if remainCapacity >= orderCA.targetNum then
      table.insert(canGetList, orderUid)
      table.insert(canGetOrderIdList, orderId)
      remainCapacity = remainCapacity - orderCA.targetNum
    end
  end
  if table.count(canGetList) == 0 then
    CommonTips.OpenTips(80600598)
    return
  end
  local uidListStr = ""
  for i, v in ipairs(canGetList) do
    if i < table.count(canGetList) then
      uidListStr = uidListStr .. v .. ","
    else
      uidListStr = uidListStr .. v
    end
  end
  Net:SendProto("prison.gen_order", function(json)
    PlayerData.ServerData.user_prison_info.orders = json.orders
    PlayerData.ServerData.user_prison_info.raw_material = json.raw_material
    if json.warehouse then
      PlayerData.ServerData.user_home_info.warehouse = json.warehouse
    end
    if callBack then
      callBack(json, canGetOrderIdList)
    end
  end, uidListStr, 2)
  return canGetList
end

function PrisonData.PurchaseOrderAddSpeed(orderUid, callBack)
  local orderData = this.GetPurchaseOrder(orderUid)
  local orderId = orderData.prison_oid
  local orderCA = PlayerData:GetFactoryData(orderId, "PrisonProcurementFactory")
  local time = orderData.purchase_ts + orderCA.costTime - TimeUtil.GetServerTimeStamp()
  local useNum = 0
  local prisonCA = PrisonData.GetPrisonCA()
  for i, v in ipairs(prisonCA.accelerationCostList) do
    if time >= v.stage then
      useNum = useNum + v.cost * math.ceil(v.stage / v.time)
      time = time - v.stage
    else
      useNum = useNum + v.cost * math.ceil(time / v.time)
      break
    end
  end
  if 0 < useNum then
    if useNum > PlayerData:GetGoodsById(11400005).num then
      CommonTips.OpenTips(80600062)
      return
    end
    Net:SendProto("prison.gen_order", function(json)
      PlayerData.ServerData.user_prison_info.orders = json.orders
      PlayerData.ServerData.user_prison_info.raw_material = json.raw_material
      if callBack then
        callBack(json)
      end
    end, orderUid, 3)
  end
end

function PrisonData.PrisonRefresh(callBack)
  Net:SendProto("prison.refresh", function(json)
    if json.user_prison_info then
      PlayerData.ServerData.user_prison_info = json.user_prison_info
    end
    if callBack then
      callBack(json)
    end
  end)
end

function PrisonData.OpenPrison(callBack)
  local prisonCA = PrisonData.GetPrisonCA()
  if PlayerData:GetHomeInfo().trade_lv < prisonCA.initialTradeLevel then
    CommonTips.OpenTips(80610974)
    return
  end
  if PlayerData:GetGoodsById(prisonCA.initialPriceItem).num < prisonCA.initialPrice then
    CommonTips.OpenTips(80600062)
    return
  end
  Net:SendProto("prison.open", function(json)
    local useItems = {
      [prisonCA.initialPriceItem] = prisonCA.initialPrice
    }
    PlayerData:RefreshUseItems(useItems)
    if json.user_prison_info then
      PlayerData.ServerData.user_prison_info = json.user_prison_info
    end
    if json.furniture then
      PlayerData.ServerData.user_prison_info.furniture = json.furniture
    end
    if callBack then
      callBack()
    end
  end)
end

function PrisonData.OpenWorkShop(callBack)
  local prisonCA = PrisonData.GetPrisonCA()
  if this.GetCurPower() < this.GetUsePower() + prisonCA.initialRoomNum * prisonCA.workshopSpaceOccupyPower then
    CommonTips.OpenTips(80608140)
    return
  end
  local useItems = {}
  for k, v in pairs(prisonCA.buyWorkshopPrice) do
    if PlayerData:GetGoodsById(v.id).num < v.num then
      CommonTips.OpenTips(80600062)
      return
    end
    useItems[v.id] = v.num
  end
  Net:SendProto("prison.unlock_workshop", function(json)
    PlayerData:RefreshUseItems(useItems)
    if json.workshops_front then
      PlayerData.ServerData.user_prison_info.workshops_front = json.workshops_front
    end
    if json.workshops_furniture then
      PlayerData.ServerData.user_prison_info.workshops_furniture = json.workshops_furniture
    end
    if json.furniture then
      PlayerData.ServerData.user_prison_info.furniture = json.furniture
    end
    if callBack then
      callBack(json)
    end
  end)
end

function PrisonData.OpenPrisonerRoom(callBack)
  local prisonCA = PrisonData.GetPrisonCA()
  if this.GetCurPower() < this.GetUsePower() + prisonCA.initialRoomNum * prisonCA.cellSpaceOccupyPower then
    CommonTips.OpenTips(80608140)
    return
  end
  local useItems = {}
  for k, v in pairs(prisonCA.buyWorkshopPrice) do
    if PlayerData:GetGoodsById(v.id).num < v.num then
      CommonTips.OpenTips(80600062)
      return
    end
    useItems[v.id] = v.num
  end
  Net:SendProto("prison.unlock_cell", function(json)
    PlayerData:RefreshUseItems(useItems)
    if json.cell_front then
      PlayerData.ServerData.user_prison_info.cell_front = json.cell_front
    end
    if json.furniture then
      PlayerData.ServerData.user_prison_info.furniture = json.furniture
    end
    if callBack then
      callBack(json)
    end
  end)
end

function PrisonData.OpenPrisonerRoomCell(callBack, roomIndex, areaId)
  local prisonCA = PrisonData.GetPrisonCA()
  if this.GetCurPower() < this.GetUsePower() + prisonCA.cellSpaceOccupyPower then
    CommonTips.OpenTips(80608140)
    return
  end
  local useItems = {}
  for k, v in pairs(prisonCA.buySpacePrice) do
    if PlayerData:GetGoodsById(v.id).num < v.num then
      CommonTips.OpenTips(80600062)
      return
    end
    useItems[v.id] = v.num
  end
  Net:SendProto("prison.unlock_cell_room", function(json)
    PlayerData:RefreshUseItems(useItems)
    if json.cell_front then
      PlayerData.ServerData.user_prison_info.cell_front = json.cell_front
    end
    if json.furniture then
      PlayerData.ServerData.user_prison_info.furniture = json.furniture
    end
    if callBack then
      callBack(json)
    end
  end, roomIndex, areaId)
end

function PrisonData.SetMargin(callBack, addNum, isAuto)
  if addNum > PlayerData:GetGoodsById(11400001).num then
    CommonTips.OpenTips(80600260)
    return
  end
  Net:SendProto("prison.margin", function(json)
    if json.margin then
      PlayerData.ServerData.user_prison_info.margin = json.margin
    end
    if callBack then
      callBack()
    end
  end, addNum)
end

function PrisonData.SetMarginSwitch(callBack, switch)
  Net:SendProto("prison.margin_switch", function(json)
    if json.margin_switch then
      PlayerData.ServerData.user_prison_info.margin_switch = json.margin_switch
    end
    if callBack then
      callBack()
    end
  end, switch)
end

function PrisonData.UpgradeRoom(callBack, roomTypeId, upgradeRoomId)
  local updateRoomCA = PlayerData:GetFactoryData(upgradeRoomId, "PrisonRoomFactory")
  if not this.IsPowerEnoughToUpgrade(roomTypeId, upgradeRoomId) then
    CommonTips.OpenTips(80608140)
    return
  end
  local useItems = {}
  for k, v in pairs(updateRoomCA.lvUpCost) do
    if PlayerData:GetGoodsById(v.id).num < v.num then
      CommonTips.OpenTips(80600062)
      return
    end
    useItems[v.id] = v.num
  end
  Net:SendProto("prison.start_build_room", function(json)
    PlayerData:RefreshUseItems(useItems)
    if json.rooms then
      PlayerData.ServerData.user_prison_info.rooms = json.rooms
    end
    if callBack then
      callBack()
    end
  end, roomTypeId, updateRoomCA.roomLevel)
end

function PrisonData.UpgradeRoomImmediately(callBack, roomTypeId, upgradeRoomId, diamondCost)
  if not this.IsPowerEnoughToUpgrade(roomTypeId, upgradeRoomId) then
    CommonTips.OpenTips(80608140)
    return
  end
  if PlayerData:GetGoodsById(diamondCost.diamond).num < diamondCost.diamondNum then
    CommonTips.OpenTips(80608052)
    return
  end
  Net:SendProto("prison.complete_build_room", function(json)
    if json.rooms then
      PlayerData.ServerData.user_prison_info.rooms = json.rooms
    end
    if callBack then
      callBack()
    end
  end, roomTypeId, diamondCost.timeFaster)
end

function PrisonData.UpgradeRoomFaster(callBack, roomType, cardItem)
  Net:SendProto("prison.faster_build_room", function(json)
    local useItems = {}
    useItems[cardItem.id] = cardItem.num
    PlayerData:RefreshUseItems(useItems)
    if json.rooms then
      PlayerData.ServerData.user_prison_info.rooms = json.rooms
    end
    if callBack then
      callBack()
    end
  end, roomType, Json.encode({cardItem}))
end

function PrisonData.ProductFaster(callBack, roomIndex, cardItem)
  Net:SendProto("prison.speed_product_plant", function(json)
    local useItems = {}
    useItems[cardItem.id] = cardItem.num
    PlayerData:RefreshUseItems(useItems)
    if json.workshops_product_plant then
      PlayerData.ServerData.user_prison_info.workshops_product_plant = json.workshops_product_plant
    end
    local allProducts = PrisonData.GetRoomProducts(roomIndex)
    for cellIndex, product in pairs(allProducts) do
      local finishTime = this.GetProductFinishTime(roomIndex, cellIndex)
      this.RefreshEventInvokeTime(cellIndex, "ProductDone", finishTime)
    end
    if callBack then
      callBack()
    end
  end, roomIndex, Json.encode({cardItem}))
end

function PrisonData.CompleteProductImmediately(callBack, workShopId, diamondCost)
  if PlayerData:GetGoodsById(diamondCost.diamond).num < diamondCost.diamondNum then
    CommonTips.OpenTips(80608052)
    return
  end
  Net:SendProto("prison.complete_product_plant", function(json)
    PlayerData.ServerData.user_prison_info.workshops_product_plant = json.workshops_product_plant
    local roomIndex = this.roomIndex
    local allProducts = PrisonData.GetRoomProducts(roomIndex)
    for cellIndex, product in pairs(allProducts) do
      local finishTime = this.GetProductFinishTime(roomIndex, cellIndex)
      this.RefreshEventInvokeTime(cellIndex, "ProductDone", finishTime)
    end
    if callBack then
      callBack(json)
    end
  end, workShopId, diamondCost.timeFaster)
end

function PrisonData.ProductCellFaster(callBack, roomIndex, cellIndex, cardItem)
  Net:SendProto("prison.speed_per_product_plant", function(json)
    local useItems = {}
    useItems[cardItem.id] = cardItem.num
    PlayerData:RefreshUseItems(useItems)
    if json.workshops_product_plant then
      PlayerData.ServerData.user_prison_info.workshops_product_plant = json.workshops_product_plant
    end
    local finishTime = this.GetProductFinishTime(roomIndex, cellIndex)
    this.RefreshEventInvokeTime(cellIndex, "ProductDone", finishTime)
    if callBack then
      callBack()
    end
  end, roomIndex, cellIndex, Json.encode({cardItem}))
end

function PrisonData.PreReceiveProduct(yesFun, roomIndex, cellIndexList, tipsId)
  roomIndex = tostring(roomIndex)
  local remainCapacity = this.GetProductWarehouseMaxCapacity() - this.GetProductWarehouseCapacity()
  Net:SendProto("prison.pre_receive_product_plant", function(json)
    local totalCount = 0
    if json.workshops_product_plant then
      local roomData = json.workshops_product_plant[roomIndex] or {}
      for i, cellIndex in pairs(cellIndexList) do
        cellIndex = tostring(cellIndex)
        if roomData[cellIndex] and roomData[cellIndex].product_detail then
          for _, num in pairs(roomData[cellIndex].product_detail) do
            totalCount = totalCount + num
          end
        end
      end
      if totalCount > remainCapacity then
        CommonTips.OnPrompt(tipsId, nil, nil, yesFun)
      else
        yesFun()
      end
    end
  end, roomIndex, Json.encode(cellIndexList))
end

function PrisonData.ReceiveProduct(callBack, roomIndex, cellIndexList)
  roomIndex = tostring(roomIndex)
  Net:SendProto("prison.receive_product_plant", function(json)
    if json.grad_product then
      PrisonController.OpenProductReceiveTips(roomIndex, json.grad_product)
    end
    if json.workshops_product_plant then
      PlayerData.ServerData.user_prison_info.workshops_product_plant = json.workshops_product_plant
    end
    if json.power then
      PlayerData.ServerData.user_prison_info.power = json.power
    end
    if json.product then
      PlayerData.ServerData.user_prison_info.product = json.product
    end
    if json.warehouse then
      PlayerData.ServerData.user_home_info.warehouse = json.warehouse
    end
    if callBack then
      callBack(json)
    end
  end, roomIndex, Json.encode(cellIndexList))
end

function PrisonData.SetPowerSocket(callBack)
  local useItems = {}
  local installedNum = PlayerData.ServerData.user_prison_info.power_socket_num
  local prisonCA = PrisonData.GetPrisonCA()
  for i, installCfg in ipairs(prisonCA.prisonBuyElectricList) do
    if i > installedNum then
      local costListCA = PlayerData:GetFactoryData(installCfg.consumeMaterial, "ListFactory")
      for _, v in pairs(costListCA.electricMaterialList) do
        if PlayerData:GetGoodsById(v.id).num < v.num then
          CommonTips.OpenTips(80600062)
          return
        end
        useItems[v.id] = v.num
      end
      break
    end
  end
  Net:SendProto("prison.set_power_socket", function(json)
    PlayerData:RefreshUseItems(useItems)
    PlayerData.ServerData.user_prison_info.power_socket_num = json.power_socket_num
    if callBack then
      callBack(json)
    end
  end)
end

function PrisonData.ReleasePrisoner(callBack)
  Net:SendProto("prison.release_settlement", function(json)
    if json.prison_backpack then
      PlayerData.ServerData.user_prison_info.prison_backpack = json.prison_backpack
    end
    if json.workshops_master then
      PlayerData.ServerData.user_prison_info.workshops_master = json.workshops_master
    end
    if json.raw_material_workshops then
      PlayerData.ServerData.user_prison_info.raw_material_workshops = json.raw_material_workshops
    end
    if json.workshops_front then
      PlayerData.ServerData.user_prison_info.workshops_front = json.workshops_front
    end
    if callBack then
      callBack(json)
    end
  end)
end

function PrisonData.EscapePrisoner(callBack)
  Net:SendProto("prison.escape", function(json)
    if json.prison_backpack then
      PlayerData.ServerData.user_prison_info.prison_backpack = json.prison_backpack
    end
    if json.workshops_master then
      PlayerData.ServerData.user_prison_info.workshops_master = json.workshops_master
    end
    if json.raw_material_workshops then
      PlayerData.ServerData.user_prison_info.raw_material_workshops = json.raw_material_workshops
    end
    if json.workshops_front then
      PlayerData.ServerData.user_prison_info.workshops_front = json.workshops_front
    end
    if json.detention_room then
      PlayerData.ServerData.user_prison_info.detention_room = json.detention_room
    end
    if callBack then
      callBack(json)
    end
  end)
end

function PrisonData.GetProductUsePower()
  local usePower = 0
  local allProducts = PlayerData.ServerData.user_prison_info.workshops_product_plant
  for roomIndex, roomData in pairs(allProducts) do
    for cellIndex, cellData in pairs(roomData) do
      local formulaCA = PlayerData:GetFactoryData(cellData.formula_group_id, "ProductionFactory")
      usePower = usePower + formulaCA.electricityOccupation
    end
  end
  return usePower
end

function PrisonData.GetMaterialProductUsePower()
  local usePower = 0
  local materialProducts = PlayerData.ServerData.user_prison_info.raw_material_workshops
  for roomTypeId, v in pairs(materialProducts) do
    if 0 < v.start_ts then
      local formulaCA = PlayerData:GetFactoryData(v.formula_group_id, "ProductionFactory")
      usePower = usePower + formulaCA.electricityOccupation * table.count(v.u_pid_list)
    end
  end
  return usePower
end

function PrisonData.GetProductMachineUsePower()
  local usePower = 0
  local prisonCA = PrisonData.GetPrisonCA()
  local productRoomList = this.GetProductRoomList() or {}
  for i, cellList in pairs(productRoomList) do
    usePower = usePower + math.ceil(table.count(cellList) / 3) * prisonCA.workshopSpaceOccupyPower
  end
  local cellRoomList = this.GetCellRoomList() or {}
  for i, roomData in pairs(cellRoomList) do
    usePower = usePower + table.count(roomData) * prisonCA.cellSpaceOccupyPower
  end
  return usePower
end

function PrisonData.GetNormalMachineUsePower()
  local usePower = 0
  local prisonCA = PrisonData.GetPrisonCA()
  local buildList = this.GetBuildList()
  for i, v in pairs(prisonCA.prison) do
    if not this.ProductRoomTypeIdToIndexMap[v.id] and not this.CellRoomTypeIdToRoomIndexMap[v.id] then
      local buildTypeCA = PlayerData:GetFactoryData(v.id, "PrisonRoomTypeFactory")
      if buildTypeCA.isInitial then
        local roomInfo = buildTypeCA.roomList[1]
        local roomCA = PlayerData:GetFactoryData(roomInfo.config, "PrisonRoomFactory")
        usePower = usePower + roomCA.occupyPower
      else
        local roomData = buildList[tostring(v.id)]
        if roomData then
          for _, roomInfo in ipairs(buildTypeCA.roomList) do
            local roomCA = PlayerData:GetFactoryData(roomInfo.config, "PrisonRoomFactory")
            if roomCA.roomLevel == roomData.lv then
              usePower = usePower + roomCA.occupyPower
              break
            end
          end
        end
      end
    end
  end
  return usePower
end

function PrisonData.GetPowerSocketPower()
  local installedNum = this.GetSeverPrisonData().power_socket_num
  if installedNum == 0 then
    return 0
  end
  local prisonCA = PrisonData.GetPrisonCA()
  local extraPower = 0
  for i = 1, installedNum do
    extraPower = extraPower + prisonCA.prisonBuyElectricList[i].extraPower
  end
  return extraPower
end

function PrisonData.GetUsePower()
  return this.GetProductUsePower() + this.GetMaterialProductUsePower() + this.GetProductMachineUsePower() + this.GetNormalMachineUsePower()
end

function PrisonData.GetCurPower()
  local power = 0
  local buildList = this.GetBuildList()
  local powerBuild = buildList and buildList["87500012"]
  if powerBuild then
    local roomTypeCA = PlayerData:GetFactoryData(87500012, "PrisonRoomTypeFactory")
    for i, v in ipairs(roomTypeCA.roomList) do
      local roomCA = PlayerData:GetFactoryData(v.config, "PrisonRoomFactory")
      if powerBuild.lv == roomCA.roomLevel then
        power = roomCA.prisonPower
        break
      end
    end
  else
    power = this.GetProductMachineUsePower() + this.GetNormalMachineUsePower()
  end
  power = power + this.GetPowerSocketPower()
  return power
end

function PrisonData.GetProductWorkTime(roomIndex, cellIndex)
  local workTime = 0
  local product = this.GetCellProduct(roomIndex, cellIndex)
  if product then
    local formulaCA = PlayerData:GetFactoryData(product.formula_group_id, "ProductionFactory")
    local totalCostTime = formulaCA.perTime * product.count * 60
    if product.sts == 0 then
      workTime = product.tts + product.speed_ts
      if totalCostTime < workTime then
        workTime = totalCostTime
      end
    elseif 0 < product.sts then
      local nowTime = TimeUtil:GetServerTimeStamp()
      local endTime = product.start_ts + totalCostTime - product.speed_ts
      if endTime < product.start_ts then
        endTime = product.start_ts
      end
      if nowTime > endTime then
        nowTime = endTime
      end
      workTime = nowTime - product.sts + product.tts + product.speed_ts
      if totalCostTime < workTime then
        workTime = totalCostTime
      end
    end
  end
  return workTime
end

function PrisonData.GetProductRemainTime(roomIndex, cellIndex)
  local product = this.GetCellProduct(roomIndex, cellIndex)
  if product then
    local remainTime = this.GetProductFinishTime(roomIndex, cellIndex) - TimeUtil:GetServerTimeStamp()
    return remainTime < 0 and 0 or remainTime
  end
  return 0
end

function PrisonData.GetProductFinishTime(roomIndex, cellIndex)
  local product = this.GetCellProduct(roomIndex, cellIndex)
  if product then
    local formulaCA = PlayerData:GetFactoryData(product.formula_group_id, "ProductionFactory")
    local totalCostTime = formulaCA.perTime * product.count * 60
    return product.start_ts + totalCostTime - product.speed_ts
  end
  return 0
end

function PrisonData.IsIllHappen(u_pid)
  if u_pid and u_pid ~= "" then
    local prisonerData = this.GetPrisoner(u_pid)
    if prisonerData and prisonerData.ill_id and prisonerData.ill_id ~= "" then
      return prisonerData.disease_ts <= TimeUtil:GetServerTimeStamp()
    end
  end
  return false
end

function PrisonData.IsIllHappenInProduct(roomIndex, cellIndex)
  local product = this.GetCellProduct(roomIndex, cellIndex)
  if product then
    local productRoomList = this.GetProductRoomList()
    local u_pid = productRoomList[tostring(roomIndex)][tostring(cellIndex)]
    if u_pid and u_pid ~= "" then
      local prisonerData = this.GetPrisoner(u_pid)
      if prisonerData.ill_id and prisonerData.ill_id ~= "" then
        local finishTime = this.GetProductFinishTime(roomIndex, cellIndex)
        return finishTime > prisonerData.disease_ts
      end
    end
  end
  return false
end

function PrisonData.GetAccidentCfg(roomIndex, cellIndex)
  local eventCA = PlayerData:GetFactoryData(88000001, "PrisonerEventFactory")
  local productData = this.GetCellProduct(roomIndex, cellIndex)
  if productData then
    local prisonerData = this.GetPrisoner(productData.u_pid)
    if prisonerData then
      local personalityId = prisonerData.personality_id
      if productData.event_trammels then
        local otherPersonalityId = productData.event_trammels.other_personality_id
        for i, v in pairs(eventCA.personalityFetterList) do
          if v.firstPrisonerId == tonumber(personalityId) and v.secondPrisonerId == tonumber(otherPersonalityId) or v.firstPrisonerId == tonumber(otherPersonalityId) and v.secondPrisonerId == tonumber(personalityId) then
            return v
          end
        end
      end
      if productData.event_halo then
        for i, v in pairs(eventCA.haloFetterList) do
          if v.prisonerId == tonumber(personalityId) then
            return v
          end
        end
      end
    end
  end
end

function PrisonData.IsAccidentHappen(roomIndex, cellIndex)
  local eventsHappen = false
  local product = this.GetCellProduct(roomIndex, cellIndex)
  if product then
    if product.event_trammels then
      eventsHappen = TimeUtil:GetServerTimeStamp() >= product.event_trammels.happen_ts
    elseif product.event_halo then
      eventsHappen = TimeUtil:GetServerTimeStamp() >= product.event_halo.happen_ts
    end
  end
  return eventsHappen
end

local questList = {}

local function SetNextQuest(questId)
  local questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
  local state = PlayerData.GetQuestState(questId)
  if state ~= EnumDefine.EQuestState.Lock and this.GetPrisonLv() >= questCA.startPrisonLevel then
    table.insert(questList, questId)
  end
  if state == EnumDefine.EQuestState.Receive then
    for i, v in ipairs(questCA.nextQuest) do
      SetNextQuest(v.id)
    end
  end
end

function PrisonData.GetShowQuest()
  questList = {}
  local prisonCA = PrisonData.GetPrisonCA()
  for i, v in ipairs(prisonCA.taskInitialList) do
    local questCA = PlayerData:GetFactoryData(v.id, "QuestFactory")
    if this.GetPrisonLv() >= questCA.startPrisonLevel then
      table.insert(questList, v.id)
    end
    local state = PlayerData.GetQuestState(v.id)
    if state == EnumDefine.EQuestState.Receive then
      for _, v1 in ipairs(questCA.nextQuest) do
        SetNextQuest(v1.id)
      end
    end
  end
  return questList
end

function PrisonData.IsHaveCanReceiveQuest()
  local showQuest = this.GetShowQuest()
  for i, v in ipairs(showQuest) do
    local state = PlayerData.GetQuestState(v)
    if state == EnumDefine.EQuestState.Finish then
      return true
    end
  end
  return false
end

function PrisonData.IsProductCanReceive(roomIndex, cellIndex)
  local product = this.GetCellProduct(roomIndex, cellIndex)
  if product then
    local remainTime = this.GetProductRemainTime(roomIndex, cellIndex)
    if remainTime <= 0 then
      return not this.IsAccidentHappen(roomIndex, cellIndex)
    end
  end
  return false
end

function PrisonData.SolveProductAccident(callBack, roomIndex, cellIndex)
  Net:SendProto("prison.solve_event", function(json)
    if json.grad_product then
      PrisonController.OpenProductReceiveTips(roomIndex, json.grad_product)
    end
    if json.medical_room then
      PlayerData.ServerData.user_prison_info.medical_room = json.medical_room
    end
    if json.medical_room_temporary then
      PlayerData.ServerData.user_prison_info.medical_room_temporary = json.medical_room_temporary
    end
    if json.prison_backpack then
      PlayerData.ServerData.user_prison_info.prison_backpack = json.prison_backpack
    end
    if json.workshops_product_plant then
      PlayerData.ServerData.user_prison_info.workshops_product_plant = json.workshops_product_plant
    end
    if json.detention_room then
      PlayerData.ServerData.user_prison_info.detention_room = json.detention_room
    end
    if json.workshops_front then
      PlayerData.ServerData.user_prison_info.workshops_front = json.workshops_front
    end
    if json.workshops_master then
      PlayerData.ServerData.user_prison_info.workshops_master = json.workshops_master
    end
    if callBack then
      callBack(json)
    end
  end, roomIndex, cellIndex)
end

function PrisonData.SolveProductAccidentAll(callBack)
  local count = PrisonData.GetPrisonerIllOrEventCount(2)
  if count == 0 then
    return
  end
  Net:SendProto("prison.solve_event_all", function(json)
    if json.medical_room then
      PlayerData.ServerData.user_prison_info.medical_room = json.medical_room
    end
    if json.medical_room_temporary then
      PlayerData.ServerData.user_prison_info.medical_room_temporary = json.medical_room_temporary
    end
    if json.prison_backpack then
      PlayerData.ServerData.user_prison_info.prison_backpack = json.prison_backpack
    end
    if json.workshops_product_plant then
      PlayerData.ServerData.user_prison_info.workshops_product_plant = json.workshops_product_plant
    end
    if json.detention_room then
      PlayerData.ServerData.user_prison_info.detention_room = json.detention_room
    end
    if json.workshops_front then
      PlayerData.ServerData.user_prison_info.workshops_front = json.workshops_front
    end
    if json.workshops_master then
      PlayerData.ServerData.user_prison_info.workshops_master = json.workshops_master
    end
    CommonTips.OpenTips(string.format(GetText(80611303), count))
    if callBack then
      callBack(json)
    end
  end)
end

function PrisonData.SolveIll(callBack, u_pidList)
  Net:SendProto("prison.see_the_doctor", function(json)
    if json.grad_product then
      local roomIndex = this.roomIndex
      PrisonController.OpenProductReceiveTips(roomIndex, json.grad_product)
    end
    if json.medical_room then
      PlayerData.ServerData.user_prison_info.medical_room = json.medical_room
    end
    if json.medical_room_temporary then
      PlayerData.ServerData.user_prison_info.medical_room_temporary = json.medical_room_temporary
    end
    if json.workshops_front then
      PlayerData.ServerData.user_prison_info.workshops_front = json.workshops_front
    end
    if json.workshops_master then
      PlayerData.ServerData.user_prison_info.workshops_master = json.workshops_master
    end
    if UIManager:IsPanelOpened("UI/Prison/Main/PrisonMain") then
      local UIPrisonMainData = require("UIPrisonMain/UIPrisonMainDataModel")
      UIPrisonMainData.RefreshOneButton()
    end
    if callBack then
      callBack(json)
    end
  end, Json.encode(u_pidList))
end

function PrisonData.IsPrisonerInMedicalRoom(u_pid)
  u_pid = tostring(u_pid)
  local medical_room = PlayerData.ServerData.user_prison_info.medical_room or {}
  if not medical_room[u_pid] then
    local medical_room_temporary = PlayerData.ServerData.user_prison_info.medical_room_temporary or {}
    return medical_room_temporary[u_pid]
  end
  return true
end

function PrisonData.IsPrisonerInDetentionRoom(u_pid)
  u_pid = tostring(u_pid)
  local detention_room = PlayerData.ServerData.user_prison_info.detention_room or {}
  return detention_room[u_pid]
end

function PrisonData.IsPrisonerInMaterialRoom(u_pid)
  u_pid = tostring(u_pid)
  local material_room = PlayerData.ServerData.user_prison_info.raw_material_workshops or {}
  for i, v in pairs(material_room) do
    for _, u_pid1 in ipairs(v.u_pid_list) do
      if u_pid == u_pid1 then
        return true
      end
    end
  end
  return false
end

function PrisonData.IsPrisonerInMaterialRoomPreList(u_pid)
  u_pid = tostring(u_pid)
  local material_room = PlayerData.ServerData.user_prison_info.raw_material_workshops or {}
  for i, v in pairs(material_room) do
    if v.pre_u_pid_list then
      for _, u_pid1 in ipairs(v.pre_u_pid_list) do
        if u_pid == u_pid1 then
          return true
        end
      end
    end
  end
  return false
end

function PrisonData.IsPrisonerInProductRoom(u_pid)
  u_pid = tostring(u_pid)
  local workshops_front = PlayerData.ServerData.user_prison_info.workshops_front or {}
  for i, roomData in pairs(workshops_front) do
    for cellIndex, u_pid1 in pairs(roomData) do
      if u_pid == u_pid1 then
        return true
      end
    end
  end
  return false
end

function PrisonData.IsPrisonerShowInCell(u_pid)
  local inMedical = this.IsPrisonerInMedicalRoom(u_pid)
  if inMedical then
    return false
  end
  local inDetention = this.IsPrisonerInDetentionRoom(u_pid)
  if inDetention then
    return false
  end
  local inProduct = this.IsPrisonerInProductRoom(u_pid)
  if inProduct then
    return false
  end
  local inMaterial = this.IsPrisonerInMaterialRoom(u_pid)
  if inMaterial then
    return false
  end
  local inMaterialPre = this.IsPrisonerInMaterialRoomPreList(u_pid)
  if inMaterialPre then
    return false
  end
  return true
end

function PrisonData.GetLivePrisonerList(cellRoomIndex, areaId)
  cellRoomIndex = tostring(cellRoomIndex)
  areaId = tostring(areaId)
  local livePrisonerList = {}
  local prisonerList = this.GetPrisonPrisoners()
  for u_pid, v in pairs(prisonerList) do
    if v.bed_id and v.bed_id ~= "" then
      local splitT = string.split(v.bed_id, "_")
      if splitT[1] == cellRoomIndex and splitT[2] == areaId then
        livePrisonerList[u_pid] = {
          roomIndex = tonumber(splitT[1]),
          areaId = tonumber(splitT[2]),
          u_fid = splitT[3],
          opIndex = tonumber(splitT[4])
        }
      end
    end
  end
  return livePrisonerList
end

function PrisonData.GetPrisonerListInCell(cellRoomIndex)
  cellRoomIndex = tostring(cellRoomIndex)
  local livePrisonerList = {}
  local prisonerList = this.GetPrisonPrisoners()
  for u_pid, v in pairs(prisonerList) do
    if v.bed_id and v.bed_id ~= "" then
      local splitT = string.split(v.bed_id, "_")
      if splitT[1] and splitT[1] == cellRoomIndex then
        livePrisonerList[u_pid] = {
          cellRoomIndex = tonumber(splitT[1]),
          areaId = tonumber(splitT[2]),
          u_fid = splitT[3],
          opIndex = tonumber(splitT[4])
        }
      end
    end
  end
  return livePrisonerList
end

function PrisonData.GetIllPrisonerInCell(cellRoomIndex)
  cellRoomIndex = tostring(cellRoomIndex)
  local livePrisonerList = {}
  local prisonerList = this.GetPrisonPrisoners()
  for u_pid, v in pairs(prisonerList) do
    if v.bed_id and v.bed_id ~= "" and this.IsPrisonerShowInCell(u_pid) and this.IsIllHappen(u_pid) then
      local splitT = string.split(v.bed_id, "_")
      if 0 < #splitT and splitT[1] == cellRoomIndex then
        local areaId = splitT[2]
        local u_fid = splitT[3]
        local opIndex = splitT[4]
        table.insert(livePrisonerList, {
          u_pid = u_pid,
          cellRoomIndex = cellRoomIndex,
          areaId = areaId,
          u_fid = u_fid,
          opIndex = opIndex
        })
      end
    end
  end
  return livePrisonerList
end

function PrisonData.IsPowerEnoughToUpgrade(roomTypeId, upgradeRoomId)
  local roomTypeCA = PlayerData:GetFactoryData(roomTypeId, "PrisonRoomTypeFactory")
  local curRoomData = PlayerData.ServerData.user_prison_info.rooms[tostring(roomTypeId)]
  local curOccupyPower = 0
  if curRoomData then
    local isCreateRoom = roomTypeId == 87500017 or roomTypeId == 87500018 or roomTypeId == 87500019 or roomTypeId == 87500020
    local lvCfgList = isCreateRoom and roomTypeCA.creatRoomList or roomTypeCA.roomList
    if lvCfgList then
      for i, v in ipairs(lvCfgList) do
        local roomCA = PlayerData:GetFactoryData(v.config, "PrisonRoomFactory")
        if roomCA.roomLevel == curRoomData.lv then
          curOccupyPower = roomCA.occupyPower
          break
        end
      end
    end
  end
  local updateRoomCA = PlayerData:GetFactoryData(upgradeRoomId, "PrisonRoomFactory")
  return this.GetUsePower() + updateRoomCA.occupyPower - curOccupyPower <= this.GetCurPower()
end

function PrisonData.GetGoodsById(itemId)
  itemId = tostring(itemId)
  local num = 0
  local productInfo = this.GetProduct(itemId)
  local productNum = productInfo and productInfo.num or 0
  num = num + productNum
  local rawInfo = PrisonData.GetRawMaterial(itemId)
  local rawNum = rawInfo and rawInfo.num or 0
  num = num + rawNum
  local warehouseInfo = PlayerData.ServerData.user_home_info.warehouse[itemId]
  local warehouseNum = warehouseInfo and warehouseInfo.num or 0
  num = num + warehouseNum
  return num
end

function PrisonData.GetPrisonExpRefresh(reward)
  local data = reward and reward.prison_exp
  if not data then
    return
  end
  PlayerData.ServerData.user_prison_info.exp = PlayerData.ServerData.user_prison_info.exp + data["11400114"].num
  local prisonCfg = PrisonData.GetPrisonCA()
  local maxLevel = table.count(prisonCfg.lvList)
  local exp = PlayerData.ServerData.user_prison_info.exp
  local lv = PlayerData.ServerData.user_prison_info.lv
  if maxLevel <= lv then
    return
  end
  local targetLv = lv
  for i = tonumber(lv), #prisonCfg.lvList do
    local curLvCfg = prisonCfg.lvList[i]
    if exp >= curLvCfg.exp then
      exp = exp - curLvCfg.exp
    else
      targetLv = curLvCfg.level
      break
    end
  end
  if PlayerData.ServerData.user_prison_info.lv ~= targetLv then
    UIManager:Open("UI/Prison/Overview/PrisonUpgradeSuccess", Json.encode({level = targetLv}))
  end
  PlayerData.ServerData.user_prison_info.exp = exp
  PlayerData.ServerData.user_prison_info.lv = targetLv
  if UIManager:IsPanelOpened("UI/Prison/Overview/Prison") then
    local UIPrisonDataModel = require("UIPrison/UIPrisonDataModel")
    UIPrisonDataModel.RefreshPrisonLV()
  end
  if UIManager:IsPanelOpened("UI/Prison/Main/PrisonMain") then
    local UIPrisonMainDataModel = require("UIPrisonMain/UIPrisonMainDataModel")
    UIPrisonMainDataModel.RefreshPrisonLV()
  end
  if UIManager:IsPanelOpened("UI/Prison/Main/PrisonAccomodation/PrisonAccomodation") then
    local UIPrisonAccomodationDataModel = require("UIPrisonAccomodation/UIPrisonAccomodationDataModel")
    UIPrisonAccomodationDataModel.RefreshPrisonLV()
  end
  if UIManager:IsPanelOpened("UI/Prison/Manage/PrisonEdit") then
    local UIPrisonEditController = require("UIPrisonEdit/UIPrisonEditController")
    UIPrisonEditController:RefreshLevel()
  end
  if UIManager:IsPanelOpened("UI/Prison/PrisonTask/PrisonTask") then
    local UIPrisonTaskDataModel = require("UIPrisonTask/UIPrisonTaskDataModel")
    UIPrisonTaskDataModel.RefreshPrisonLV()
  end
  if UIManager:IsPanelOpened("UI/Prison/PrisonShop/PrisonShop") then
    local UIPrisonShopDataModel = require("UIPrisonShop/UIPrisonShopDataModel")
    UIPrisonShopDataModel.RefreshLevel()
  end
end

function PrisonData.QuestRefresh()
  if UIManager:IsPanelOpened("UI/Prison/Overview/Prison") then
    local UIPrisonDataModel = require("UIPrison/UIPrisonDataModel")
    UIPrisonDataModel.RefreshQuestRed()
    UIPrisonDataModel.QuestTraceRefresh()
  end
  if UIManager:IsPanelOpened("UI/Prison/Main/PrisonMain") then
    local UIPrisonMainDataModel = require("UIPrisonMain/UIPrisonMainDataModel")
    UIPrisonMainDataModel.RefreshQuestRed()
    UIPrisonMainDataModel.QuestTraceRefresh()
  end
  if UIManager:IsPanelOpened("UI/Prison/Main/PrisonAccomodation/PrisonAccomodation") then
    local UIPrisonAccomodationDataModel = require("UIPrisonAccomodation/UIPrisonAccomodationDataModel")
    UIPrisonAccomodationDataModel.RefreshQuestRed()
    UIPrisonAccomodationDataModel.QuestTraceRefresh()
  end
end

function PrisonData.GetAllCanStartPurchaseOrder(isLogic)
  local canGetList = {}
  local tempCostList = {}
  local orderList = {}
  for uid, v in pairs(PrisonData.GetPurchaseOrderList()) do
    local data = Clone(PrisonData.GetPurchaseOrder(uid))
    data.uid = uid
    data.status = PrisonData.GetPurchaseOrderStatus(uid)
    if data.status == PrisonData.OrderStatus.NoStart then
      table.insert(orderList, data)
    end
  end
  for i, data in ipairs(orderList) do
    local orderUid = data.uid
    local orderId = data.prison_oid
    local orderCA = PlayerData:GetFactoryData(orderId, "PrisonProcurementFactory")
    for costI, v in pairs(orderCA.costList) do
      if isLogic then
        if tempCostList[v.id] == nil then
          tempCostList[v.id] = 0
        end
        local tempCost = tempCostList[v.id]
        if this.GetGoodsById(v.id) - tempCost >= v.num then
          table.insert(canGetList, orderUid)
          tempCostList[v.id] = v.num + tempCostList[v.id]
        end
      else
        table.insert(canGetList, orderUid)
      end
    end
  end
  return canGetList
end

function PrisonData.GetAllCanReceivePurchaseOrder(isLogic)
  local canGetList = {}
  local orderList = {}
  for uid, v in pairs(PrisonData.GetPurchaseOrderList()) do
    local data = Clone(PrisonData.GetPurchaseOrder(uid))
    data.uid = uid
    data.status = PrisonData.GetPurchaseOrderStatus(uid)
    if data.status == PrisonData.OrderStatus.Completed then
      table.insert(orderList, data)
    end
  end
  local remainCapacity = this.GetRawMaterialWarehouseMaxCapacity() - this.GetRawMaterialWarehouseCapacity()
  for i, data in ipairs(orderList) do
    local orderUid = data.uid
    local orderId = data.prison_oid
    local orderCA = PlayerData:GetFactoryData(orderId, "PrisonProcurementFactory")
    if isLogic then
      if remainCapacity >= orderCA.targetNum then
        table.insert(canGetList, orderUid)
        remainCapacity = remainCapacity - orderCA.targetNum
      end
    else
      table.insert(canGetList, orderUid)
    end
  end
  return canGetList
end

function PrisonData.GetPrisonerIllOrEventCount(type)
  local count = 0
  local productRoomList = PrisonData.GetProductRoomList() or {}
  local list = PrisonData.GetProductRoomList()
  for index, data in pairs(list) do
    local roomData = productRoomList[tostring(index)] or {}
    for cellIndex, v in pairs(roomData) do
      local u_pid = productRoomList[tostring(index)][cellIndex]
      if type == 1 then
        local illHappen = PrisonData.IsIllHappen(u_pid)
        if illHappen then
          count = count + 1
        end
      elseif type == 2 then
        local eventHappen = PrisonData.IsAccidentHappen(index, cellIndex)
        if eventHappen then
          count = count + 1
        end
      end
    end
  end
  return count
end

function PrisonData.CheckProductRoomRedPoint(roomIndex)
  local roomList = PrisonData.GetProductRoomList()
  local roomData = roomList[tostring(roomIndex)]
  for cellIndex, data in pairs(roomData) do
    local curUPid = roomData[cellIndex] or ""
    if curUPid and curUPid == "" then
      local prisonerList = PrisonData.GetPrisonPrisoners()
      for u_pid, v in pairs(prisonerList) do
        if v.bed_id and v.bed_id ~= "" and not PrisonData.IsPrisonerInMedicalRoom(u_pid) and not PrisonData.IsPrisonerInProductRoom(u_pid) and not PrisonData.IsPrisonerInDetentionRoom(u_pid) and not PrisonData.IsPrisonerInMaterialRoom() and not PrisonData.IsIllHappen(u_pid) then
          return true
        end
      end
    end
  end
  return false
end

function PrisonData.CheckPrisonerListRedPoint()
  local backpackCount = table.count(PlayerData.ServerData.user_prison_info.carrying_backpack)
  local curNum = table.count(PlayerData.ServerData.user_prison_info.prison_backpack) + table.count(PlayerData.ServerData.user_prison_info.temporary_backpack)
  local prisonCfg = PrisonData.GetPrisonCA()
  local cellRoomList = PrisonData.GetCellRoomList()
  local totalNum = 0
  for i, v in pairs(cellRoomList) do
    totalNum = totalNum + table.count(v) * prisonCfg.roomPrisonerNum
  end
  if 168 <= curNum then
    return false
  end
  if curNum >= totalNum then
    return false
  end
  if 0 < backpackCount then
    return true
  end
  return false
end

PrisonData.cellFurList = {}
PrisonData.cellPrisonerList = {}

function PrisonData.CloseCellRoom()
  this.cellRoomIndex = 1
  this.cellFurList = {}
  this.cellPrisonerList = {}
  this.curCellRoomPlaceId = nil
end

return PrisonData
