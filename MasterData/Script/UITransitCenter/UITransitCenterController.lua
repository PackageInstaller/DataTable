local DataModel = require("UITransitCenter/UITransitCenterDataModel")
local View = require("UITransitCenter/UITransitCenterView")
local CommonItem = require("Common/BtnItem")
local Controller = {}

function Controller:Init()
  DataModel.InitData()
  Controller:InitUI()
  Controller:RefreshTipPanel()
  Controller:RefreshRoutePanel()
  Controller:RefreshFleetPanel()
  Controller:CheckNeedRefresh()
end

function Controller:InitUI()
  View.Group_TransitGoods:SetActive(false)
  View.Group_TransitPrisoners:SetActive(false)
  View.Group_Transit.Btn_GoodsUnavailable:SetActive(not DataModel.CheckCanTransGoods())
  View.Group_Transit.Btn_PrisonerUnavailable:SetActive(not DataModel.CheckCanTransPrisoner())
  View.Group_title.Txt_lv:SetText("Lv" .. DataModel.RoomLevel)
end

function Controller:CheckNeedRefresh()
  local needRefresh = false
  for i = 1, DataModel.MaxFleetCount do
    local fleetData = PlayerData.ServerData.user_prison_info.fleet_work_info[tostring(i)]
    if fleetData ~= nil then
      local finishTime = fleetData.start_ts + fleetData.a_way_ts * 2
      if finishTime <= TimeUtil:GetServerTimeStamp() then
        needRefresh = true
        break
      end
    end
  end
  if needRefresh then
    Net:SendProto("prison.refresh", function(json)
      if json.user_prison_info then
        PlayerData.ServerData.user_prison_info = json.user_prison_info
      end
      DataModel.InitCarryingPrisonerData()
      DataModel.InitFleetData()
      Controller:RefreshFleetPanel()
      Controller:InitUI()
    end)
  end
end

function Controller:SetUnlockRouteElement(element, elementIndex)
  local row = DataModel.UnlockRouteList[elementIndex]
  if row then
    local stationCfg = PlayerData:GetFactoryData(row.id)
    element.Group_placeTxt.Txt_:SetText(stationCfg.name)
    element.Group_Warehouse:SetActive(true)
    element.Group_Warehouse.Txt_:SetText(row.curSpace .. "/" .. row.maxSpace)
    element.Group_lock:SetActive(false)
    element.Group_placeTxt.Txt_Current:SetActive(not DataModel.InTravel and tonumber(row.id) == tonumber(DataModel.CurStation))
  end
end

function Controller:SetLockRouteElement(element, elementIndex)
  local row = DataModel.LockRouteList[elementIndex]
  if row then
    local stationCfg = PlayerData:GetFactoryData(row.id)
    element.Group_placeTxt.Txt_:SetText(stationCfg.name)
    element.Group_lock:SetActive(true)
    element.Group_lock.Img_UnavailableLock:SetActive(DataModel.GetCanUnlockRouteCount() <= 0)
    element.Group_lock.Img_AvailableLock:SetActive(DataModel.GetCanUnlockRouteCount() > 0)
    element.Group_Warehouse:SetActive(false)
    element.Group_placeTxt.Txt_Current:SetActive(not DataModel.InTravel and tonumber(row.id) == tonumber(DataModel.CurStation))
    element.Group_lock.Btn_:SetClickParam(elementIndex)
  end
end

function Controller:RefreshRoutePanel()
  View.Group_Route.ScrollView_.Viewport.Content.Txt_:SetText(string.format(string.format(GetText(80607687), DataModel.GetCanUnlockRouteCount())))
  View.Group_Route.ScrollView_.Viewport.Content.StaticGrid_Locked.grid.self:SetDataCount(table.count(DataModel.UnlockRouteList))
  View.Group_Route.ScrollView_.Viewport.Content.StaticGrid_Locked.grid.self:RefreshAllElement()
  View.Group_Route.ScrollView_.Viewport.Content.StaticGrid_Unlocked.grid.self:SetDataCount(table.count(DataModel.LockRouteList))
  View.Group_Route.ScrollView_.Viewport.Content.StaticGrid_Unlocked.grid.self:RefreshAllElement()
  View.Group_Route.Group_Tip1.Txt_:SetText(string.format(GetText(80607729), table.count(DataModel.UnlockRouteList), DataModel.LevelCfg.routeLimited))
end

function Controller:SetFleetElement(element, elementIndex)
  local row = DataModel.FleetList[elementIndex]
  if row then
    element.Group_FleetNum.Group_Locked:SetActive(not row.isUnlock)
    element.Group_FleetNum.Group_Unlocked:SetActive(row.isUnlock)
    element.Group_Locked.Group_Unavailable:SetActive(not row.isUnlock)
    element.Group_Locked.Group_Available:SetActive(row.isUnlock)
    element.Group_Locked:SetActive(not row.isUnlock)
    if not row.isUnlock then
      local canUnlock = DataModel.RoomLevel >= DataModel.FleetCount2LevelRecord[row.idx]
      element.Group_Locked.Group_Unavailable:SetActive(not canUnlock)
      element.Group_Locked.Group_Available:SetActive(canUnlock)
      if not canUnlock then
        element.Group_Locked.Group_Unavailable.Btn_Unavailable.Txt_:SetText(string.format(GetText(80607636), DataModel.FleetCount2LevelRecord[row.idx]))
      end
    elseif row.isUnlock then
      element.Group_FleetNum.Group_Unlocked.Txt_Num:SetText(string.format("%02d", elementIndex))
    end
    element.Group_Available:SetActive(row.isFree)
    element.Group_Transit:SetActive(not row.isFree)
    if not row.isFree then
      local transData = PlayerData.ServerData.user_prison_info.fleet_work_info[tostring(elementIndex)]
      if transData then
        local remainTime = transData.start_ts + transData.a_way_ts * 2 - TimeUtil:GetServerTimeStamp()
        if 0 < remainTime then
          local isGo = TimeUtil:GetServerTimeStamp() - transData.start_ts < transData.a_way_ts
          local departureStr, destinationStr, statusStr
          local statusFormat = "%s-%s"
          if transData.type == "goods" then
            statusStr = isGo and string.format(statusFormat, GetText(80607641), GetText(80607642)) or string.format(statusFormat, GetText(80607641), GetText(80607643))
            departureStr = isGo and PlayerData:GetFactoryData(83000017).name or PlayerData:GetFactoryData(transData.city_id).name
            destinationStr = isGo and PlayerData:GetFactoryData(transData.city_id).name or PlayerData:GetFactoryData(83000017).name
            element.Group_Transit.Img_IconGoods:SetActive(true)
            element.Group_Transit.Img_IconPrisoners:SetActive(false)
          elseif transData.type == "prisoner" then
            statusStr = isGo and string.format(statusFormat, GetText(80607640), GetText(80607642)) or string.format(statusFormat, GetText(80607640), GetText(80607643))
            departureStr = not isGo and PlayerData:GetFactoryData(transData.city_id).name or PlayerData:GetFactoryData(83000017).name
            destinationStr = not isGo and PlayerData:GetFactoryData(83000017).name or PlayerData:GetFactoryData(transData.city_id).name
            element.Group_Transit.Img_IconGoods:SetActive(false)
            element.Group_Transit.Img_IconPrisoners:SetActive(true)
          end
          element.Group_Transit.Group_Departure.Txt_:SetText(departureStr)
          element.Group_Transit.Group_Destination.Txt_:SetText(destinationStr)
          element.Group_Transit.Txt_StatusDes:SetText(statusStr)
          local timeTable = {
            min = remainTime // 60,
            sec = remainTime % 60
          }
          element.Group_Transit.Group_Time.Txt_TimeNum:SetText(string.format("%02d:%02d", timeTable.min, timeTable.sec))
          local timePer = isGo and (TimeUtil:GetServerTimeStamp() - transData.start_ts) / transData.a_way_ts or (TimeUtil:GetServerTimeStamp() - transData.start_ts - transData.a_way_ts) / transData.a_way_ts
          element.Group_Transit.Group_Time.Img_BarProcess:SetFilledImgAmount(timePer)
          local countDownCtr = {
            startTime = isGo and transData.start_ts or transData.start_ts + transData.a_way_ts,
            finishTimeStamp = isGo and transData.start_ts + transData.a_way_ts or transData.start_ts + transData.a_way_ts * 2,
            isGo = isGo,
            timeStrCtr = element.Group_Transit.Group_Time.Txt_TimeNum,
            timeFillCtr = element.Group_Transit.Group_Time.Img_BarProcess
          }
          table.insert(DataModel.FleetCountDownHandler, countDownCtr)
        else
          element.Group_Available:SetActive(true)
          element.Group_Transit:SetActive(false)
        end
      end
    end
    element.Group_Locked.Group_Unavailable.Btn_Unavailable:SetClickParam(elementIndex)
    element.Group_Locked.Group_Available.Btn_Available:SetClickParam(elementIndex)
  end
end

function Controller:RefreshFleetPanel()
  DataModel.FleetCountDownHandler = {}
  if DataModel.isFirst then
    View.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01))
      View.Group_Fleet.ScrollGrid_.grid.self:SetDataCount(DataModel.MaxFleetCount)
      View.Group_Fleet.ScrollGrid_.grid.self:RefreshAllElement()
      DataModel.IsFirst = false
    end))
  else
    View.Group_Fleet.ScrollGrid_.grid.self:SetDataCount(DataModel.MaxFleetCount)
    View.Group_Fleet.ScrollGrid_.grid.self:RefreshAllElement()
  end
end

function Controller:SetPickRouteElement(element, elementIndex)
  local row = DataModel.RouteList[elementIndex]
  if row then
    local stationCfg = PlayerData:GetFactoryData(row.id)
    element.Group_Unlocked:SetActive(row.unlock)
    element.Group_Locked:SetActive(not row.unlock)
    element.GroupInfo.Group_Picked:SetActive(tostring(DataModel.CurSelectRouteId) == tostring(row.id))
    element.GroupInfo.Group_Unpicked:SetActive(tostring(DataModel.CurSelectRouteId) ~= tostring(row.id))
    element.GroupInfo.Group_Unpicked.Group_Name.Txt_Name:SetText(stationCfg.name)
    element.GroupInfo.Group_Picked.Group_Name.Txt_Name:SetText(stationCfg.name)
    element.GroupInfo.Group_Unpicked.Img_PlaceIcon:SetSprite(stationCfg.cityMapIconPath)
    element.GroupInfo.Group_Picked.Img_PlaceIcon:SetSprite(stationCfg.cityMapIconPath)
    if row.unlock then
      element.Group_Unlocked.Group_Warehouse.Txt_:SetText(row.curSpace .. "/" .. row.maxSpace)
      element.Group_Unlocked.Group_CapacityVisual.Img_Ratio:SetFilledImgAmount(row.spacePer / 100)
      element.Group_Unlocked.Group_CapacityVisual.Txt_Ratio:SetText(row.spacePer .. "%")
    end
    element.GroupInfo.Btn_Pick:SetClickParam(elementIndex)
  end
end

function Controller:RefreshPickRoutePanel()
  View.Group_TransitGoods.Group_PickRoute.ScrollGrid_.grid.self:SetDataCount(table.count(DataModel.RouteList))
  View.Group_TransitGoods.Group_PickRoute.ScrollGrid_.grid.self:RefreshAllElement()
end

function Controller:RefreshItem(info, element)
  local show
  if info.info then
    show = info.info
  end
  element.Img_Item:SetSprite(string.nilorempty(info.info.imagePath) and info.info.iconPath or info.info.imagePath)
  element.Img_Bottom:SetSprite(UIConfig.BottomConfig[show.qualityInt + 1])
  element.Img_Mask:SetSprite(UIConfig.MaskConfig[show.qualityInt + 1])
  element.Txt_Num:SetText(info.num)
end

function Controller:SetWarehouseElement(element, elementIndex)
  local data = DataModel.CurWarehouseTab == 1 and DataModel.MaterialGoods or DataModel.ProductGoods
  CommonItem:SetItem(element, data[elementIndex].info)
  local selectData = DataModel.CurWarehouseTab == 1 and DataModel.SelectMaterialGoods or DataModel.SelectProductGoods
  if selectData[tostring(data[elementIndex].info.id)] then
    local itemId = data[elementIndex].info.id
    element.Txt_Num:SetText(selectData[tostring(itemId)].num .. "/" .. data[elementIndex].num)
    element.Img_Pick:SetActive(true)
  else
    element.Txt_Num:SetText(data[elementIndex].num)
    element.Img_Pick:SetActive(false)
  end
  element.Btn_Item:SetClickParam(elementIndex)
end

function Controller:RefreshWarehousePanel()
  local count = DataModel.CurWarehouseTab == 1 and #DataModel.MaterialGoods or #DataModel.ProductGoods
  if count == 0 then
    View.Group_TransitGoods.Group_Warehouse.Img_Kong:SetActive(true)
    View.Group_TransitGoods.Group_Warehouse.ScrollGrid_Item.self:SetActive(false)
  else
    View.Group_TransitGoods.Group_Warehouse.Img_Kong:SetActive(false)
    View.Group_TransitGoods.Group_Warehouse.ScrollGrid_Item.self:SetActive(true)
    View.Group_TransitGoods.Group_Warehouse.ScrollGrid_Item.grid.self:SetDataCount(count)
    View.Group_TransitGoods.Group_Warehouse.ScrollGrid_Item.grid.self:RefreshAllElement()
  end
end

function Controller:RefreshTipPanel()
  View.Group_Tip.Group_Time.Txt_TipTime:SetText(string.format(GetText(80607731), DataModel.TransitTime))
  View.Group_Tip.Group_GoodsCost.Txt_TipTime:SetText(string.format(GetText(80607730), PlayerData:GetFactoryData(11400001).textIcon, DataModel.TransitGoodsCost))
  View.Group_Tip.Group_PrisonerCost.Txt_TipTime:SetText(string.format(GetText(80607730), PlayerData:GetFactoryData(11400001).textIcon, DataModel.TransitPrisonerCost))
  View.Group_Tip.Group_RouteMax.Txt_TipTime:SetText(DataModel.LevelCfg.routeLimited)
  View.Group_Tip.Group_FleetMax.Txt_TipTime:SetText(DataModel.LevelCfg.fleetLimited)
end

function Controller:SetPrisonerElement(element, elementIndex)
  local row = DataModel.CarryingPrisoner[elementIndex]
  if row then
    local cfg = PlayerData:GetFactoryData(row.id)
    element.Group_Normal.Img_Side:SetSprite(PlayerData:GetFactoryData(cfg.prisonerSide).iconPath)
    element.Group_Normal.Txt_Name:SetText(cfg.prisonerName)
    element.Group_Normal.Img_Pic:SetSprite(cfg.prisonerIconPath)
    element.Group_Normal.Group_Personality.Txt_:SetText(PlayerData:GetFactoryData(row.personalityId).prisonerPersonalityName)
    element.Group_Normal.Group_Personality.Img_:SetSprite(PlayerData:GetFactoryData(row.personalityId).icon)
    element.Group_Normal.Group_GoodAt.Txt_:SetText(PlayerData:GetFactoryData(row.specialityId).prisonerSpeciality)
    element.Group_Normal.Group_GoodAt.Img_:SetSprite(PlayerData:GetFactoryData(row.specialityId).icon)
    element.Group_Normal.Group_ID.Img_Rarity:SetSprite(PlayerData:GetFactoryData(cfg.prisonerRarity).prisonerRarity)
    element.Group_Right.Img_Picked:SetActive(DataModel.SelectPrisoner[row.u_pid])
    element.Btn_Pick:SetClickParam(elementIndex)
    element.Btn_Release:SetClickParam(elementIndex)
  end
end

function Controller:RefreshPrisonerList()
  local carryCount = table.count(DataModel.CarryingPrisoner)
  View.Group_TransitPrisoners.Group_NoPrisoner:SetActive(carryCount == 0)
  View.Group_TransitPrisoners.ScrollGrid_Coach.grid.self:SetDataCount(table.count(DataModel.CarryingPrisoner))
  View.Group_TransitPrisoners.ScrollGrid_Coach.grid.self:RefreshAllElement()
  local canUseFleetId = DataModel.GetCanUseFleet()
  local canTransit = 0 < canUseFleetId
  View.Group_TransitPrisoners.Btn_CantConfirm:SetActive(not canTransit)
  View.Group_TransitPrisoners.Btn_All:SetActive(canTransit)
  View.Group_TransitPrisoners.Btn_Confirm:SetActive(canTransit)
  Controller:RefreshPrisonerCostValue()
end

function Controller:TryUnlockRoute(idx)
  local row = DataModel.LockRouteList[idx]
  if row.unlock then
    return
  end
  if DataModel.GetCanUnlockRouteCount() <= 0 then
    CommonTips.OpenTips(string.format(GetText(80607636), DataModel.RoomLevel + 1))
    return
  end
  local cost = PrisonData.GetPrisonCA().routeCost[DataModel.TotalRouteNum + 1]
  CommonTips.OnPrompt(string.format(GetText(80607635), PlayerData:GetFactoryData(cost.id).textIcon, cost.num), nil, nil, function()
    Net:SendProto("prison.unlock_route", function(json)
      if json.routes then
        PlayerData.ServerData.user_prison_info.routes = json.routes
      end
      DataModel.InitRouteData()
      Controller:RefreshRoutePanel()
      Controller:InitUI()
    end, tostring(row.id))
  end)
end

function Controller:TryUnlockFleet()
  local maxFleet = DataModel.GetMaxFleetCount()
  local curFleet = DataModel.GetFleetCount()
  if maxFleet <= curFleet then
    CommonTips.OpenTips(string.format(GetText(80607636), DataModel.RoomLevel + 1))
    return
  end
  local cost = PrisonData.GetPrisonCA().fleetCost[DataModel.GetFleetCount() + 1]
  CommonTips.OnPrompt(string.format(GetText(80607637), PlayerData:GetFactoryData(cost.id).textIcon, cost.num), nil, nil, function()
    Net:SendProto("prison.unlock_fleet", function(json)
      if json.fleet_list then
        PlayerData.ServerData.user_prison_info.fleet_list = json.fleet_list
      end
      DataModel.InitFleetData()
      Controller:RefreshFleetPanel()
      Controller:InitUI()
    end)
  end)
end

function Controller:EnterTransGoods()
  local can, code = DataModel.CheckCanTransGoods()
  if not can then
    local txt = DataModel.GoodsFailTips[code]
    if txt then
      CommonTips.OpenTips(GetText(txt))
    end
    return
  end
  View.Group_TransitGoods:SetActive(true)
  View.Group_TransitGoods.Group_Warehouse.Group_Batch:SetActive(false)
  Controller:SelectPickRoute(1)
  Controller:SwitchWarehouseTab(1)
  Controller:SwitchBatchType(1)
end

function Controller:SelectPickRoute(index)
  local row = DataModel.RouteList[index]
  if row then
    DataModel.SelectMaterialGoods = {}
    DataModel.SelectProductGoods = {}
    DataModel.SelectMaterialGoodsSpace = 0
    DataModel.SelectProductGoodsSpace = 0
    DataModel.CurSelectRouteId = tostring(row.id)
    DataModel.CurSelectRouteIndex = index
    Controller:RefreshPickRoutePanel()
    Controller:RefreshCapacityPanel()
    Controller:RefreshWarehousePanel()
    Controller:RefreshCostValues()
  end
end

function Controller:RefreshCapacityPanel()
  View.Group_TransitGoods.Group_Warehouse.Group_Cpacity.Group_DestinationCapacity:SetActive(DataModel.CurSelectRouteId ~= "")
  View.Group_TransitGoods.Group_Warehouse.Group_Cpacity.Group_MaterialCapacity.Txt_S:SetText(DataModel.CurWarehouseTab == 1 and GetText(80600214) or GetText(80607086))
  if DataModel.CurWarehouseTab == 1 then
    View.Group_TransitGoods.Group_Warehouse.Group_Cpacity.Group_MaterialCapacity.Txt_Space:SetText(DataModel.MaterialGoodsSpace - DataModel.SelectMaterialGoodsSpace .. "/" .. PrisonData.GetRawMaterialWarehouseMaxCapacity())
    View.Group_TransitGoods.Group_Warehouse.Group_Cpacity.Group_MaterialCapacity.Img_PBAfter:SetFilledImgAmount(DataModel.MaterialGoodsSpace / PrisonData.GetRawMaterialWarehouseMaxCapacity())
    View.Group_TransitGoods.Group_Warehouse.Group_Cpacity.Group_MaterialCapacity.Img_PBNow:SetFilledImgAmount((DataModel.MaterialGoodsSpace - DataModel.SelectMaterialGoodsSpace) / PrisonData.GetRawMaterialWarehouseMaxCapacity())
  elseif DataModel.CurWarehouseTab == 2 then
    View.Group_TransitGoods.Group_Warehouse.Group_Cpacity.Group_MaterialCapacity.Txt_Space:SetText(DataModel.ProductGoodsSpace - DataModel.SelectProductGoodsSpace .. "/" .. PrisonData.GetProductWarehouseMaxCapacity())
    View.Group_TransitGoods.Group_Warehouse.Group_Cpacity.Group_MaterialCapacity.Img_PBAfter:SetFilledImgAmount(DataModel.ProductGoodsSpace / PrisonData.GetProductWarehouseMaxCapacity())
    View.Group_TransitGoods.Group_Warehouse.Group_Cpacity.Group_MaterialCapacity.Img_PBNow:SetFilledImgAmount((DataModel.ProductGoodsSpace - DataModel.SelectProductGoodsSpace) / PrisonData.GetProductWarehouseMaxCapacity())
  end
  View.Group_TransitGoods.Group_Warehouse.Group_Cpacity.Group_DestinationCapacity.Txt_S:SetText(PlayerData:GetFactoryData(DataModel.CurSelectRouteId).name)
  local stationData = DataModel.RouteList[DataModel.CurSelectRouteIndex]
  if stationData then
    View.Group_TransitGoods.Group_Warehouse.Group_Cpacity.Group_DestinationCapacity.Txt_Space:SetText(stationData.curSpace + DataModel.SelectMaterialGoodsSpace + DataModel.SelectProductGoodsSpace .. "/" .. stationData.maxSpace)
    View.Group_TransitGoods.Group_Warehouse.Group_Cpacity.Group_DestinationCapacity.Img_PBNow:SetFilledImgAmount(stationData.curSpace / stationData.maxSpace)
    View.Group_TransitGoods.Group_Warehouse.Group_Cpacity.Group_DestinationCapacity.Img_PBAfter:SetFilledImgAmount((stationData.curSpace + DataModel.SelectMaterialGoodsSpace + DataModel.SelectProductGoodsSpace) / stationData.maxSpace)
  end
end

function Controller:RefreshCostValues()
  local distance = DataModel.GetDistanceFromPrison(DataModel.CurSelectRouteId)
  local timeCost = distance / 100 * DataModel.TransitTime
  local min = math.floor(timeCost // 60)
  local sec = math.floor(timeCost % 60)
  View.Group_TransitGoods.Group_PickRoute.Group_Des.Group_Time.Txt_Time:SetText(string.format("%02d:%02d", min, sec))
  local moneyCost = math.floor((DataModel.SelectProductGoodsSpace + DataModel.SelectMaterialGoodsSpace) * DataModel.TransitGoodsCost * (distance / 100) + 0.5)
  View.Group_TransitGoods.Group_PickRoute.Group_Des.Group_Cost.Txt_Time:SetText(moneyCost)
end

function Controller:SwitchBatchType(type)
  DataModel.CurBatchType = type
  View.Group_TransitGoods.Group_Warehouse.Group_Choose.Btn_Batch.Group_On:SetActive(DataModel.CurBatchType == 1)
  View.Group_TransitGoods.Group_Warehouse.Group_Choose.Btn_Max.Group_On:SetActive(DataModel.CurBatchType == 2)
end

function Controller:SwitchWarehouseTab(tab)
  if DataModel.CurWarehouseTab == tab then
    return
  end
  DataModel.CurWarehouseTab = tab
  View.Group_TransitGoods.Group_Warehouse.Group_Switch.Group_Material.Btn_Off:SetActive(DataModel.CurWarehouseTab ~= 1)
  View.Group_TransitGoods.Group_Warehouse.Group_Switch.Group_Material.Group_On:SetActive(DataModel.CurWarehouseTab == 1)
  View.Group_TransitGoods.Group_Warehouse.Group_Switch.Group_Product.Btn_Off:SetActive(DataModel.CurWarehouseTab ~= 2)
  View.Group_TransitGoods.Group_Warehouse.Group_Switch.Group_Product.Group_On:SetActive(DataModel.CurWarehouseTab == 2)
  Controller:RefreshWarehousePanel()
  Controller:RefreshCapacityPanel()
end

function Controller:ChooseTransGoods(idx, num)
  local row = DataModel.CurWarehouseTab == 1 and DataModel.MaterialGoods or DataModel.ProductGoods
  if row[idx] then
    local routeData = DataModel.RouteList[DataModel.CurSelectRouteIndex]
    local emptySpace = routeData.maxSpace - routeData.curSpace - DataModel.SelectMaterialGoodsSpace - DataModel.SelectProductGoodsSpace
    if num > emptySpace then
      num = emptySpace
    end
    if num > row[idx].num then
      num = row[idx].num
    end
    if num < 0 then
      num = 0
    end
    local itemId = row[idx].info.id
    if DataModel.CurWarehouseTab == 1 then
      if DataModel.SelectMaterialGoods[tostring(itemId)] == nil then
        DataModel.SelectMaterialGoods[tostring(itemId)] = {}
        DataModel.SelectMaterialGoods[tostring(itemId)].num = num
        DataModel.SelectMaterialGoodsSpace = DataModel.SelectMaterialGoodsSpace + num
      end
    elseif DataModel.CurWarehouseTab == 2 and DataModel.SelectProductGoods[tostring(itemId)] == nil then
      DataModel.SelectProductGoods[tostring(itemId)] = {}
      DataModel.SelectProductGoods[tostring(itemId)].num = num
      DataModel.SelectProductGoodsSpace = DataModel.SelectProductGoodsSpace + num
    end
    Controller:RefreshWarehousePanel()
    Controller:RefreshCapacityPanel()
    Controller:RefreshCostValues()
  end
end

function Controller:ClickWarehouseGoods(idx)
  local data = DataModel.CurWarehouseTab == 1 and DataModel.MaterialGoods[idx] or DataModel.ProductGoods[idx]
  if DataModel.CurSelectRouteIndex == -1 then
    return
  end
  local itemId = data.info.id
  if DataModel.CurWarehouseTab == 1 then
    if DataModel.SelectMaterialGoods[tostring(itemId)] then
      DataModel.SelectMaterialGoodsSpace = DataModel.SelectMaterialGoodsSpace - DataModel.SelectMaterialGoods[tostring(itemId)].num
      DataModel.SelectMaterialGoods[tostring(itemId)] = nil
      Controller:RefreshWarehousePanel()
      Controller:RefreshCapacityPanel()
      Controller:RefreshCostValues()
      return
    end
  elseif DataModel.CurWarehouseTab == 2 and DataModel.SelectProductGoods[tostring(itemId)] then
    DataModel.SelectProductGoodsSpace = DataModel.SelectProductGoodsSpace - DataModel.SelectProductGoods[tostring(itemId)].num
    DataModel.SelectProductGoods[tostring(itemId)] = nil
    Controller:RefreshWarehousePanel()
    Controller:RefreshCapacityPanel()
    Controller:RefreshCostValues()
    return
  end
  local stationData = DataModel.RouteList[DataModel.CurSelectRouteIndex]
  if stationData.curSpace + DataModel.SelectMaterialGoodsSpace + DataModel.SelectProductGoodsSpace >= stationData.maxSpace then
    CommonTips.OpenTips(GetText(80600598))
    return
  end
  if DataModel.CurBatchType == 1 then
    Controller:OpenBatchPanel(data, idx)
  else
    Controller:ChooseTransGoods(idx, data.num)
  end
end

function Controller:ConfirmBatchClick()
  Controller:ChooseTransGoods(DataModel.BatchIdx, DataModel.BatchNum)
  View.Group_TransitGoods.Group_Warehouse.Group_Batch.self:SetActive(false)
end

function Controller:ConfirmTransit()
  local stationCfg = PlayerData:GetFactoryData(DataModel.CurSelectRouteId)
  if not stationCfg then
    return
  end
  if not stationCfg.isOpen then
    CommonTips.OpenTips(80612358)
    return
  end
  local totalSpace = DataModel.SelectMaterialGoodsSpace + DataModel.SelectProductGoodsSpace
  if totalSpace <= 0 then
    return
  end
  local canUseFleetId = DataModel.GetCanUseFleet()
  if canUseFleetId < 0 then
    return
  end
  local materialArr = 0 < table.count(DataModel.SelectMaterialGoods) and Json.encode(DataModel.SelectMaterialGoods) or "{}"
  local productArr = 0 < table.count(DataModel.SelectProductGoods) and Json.encode(DataModel.SelectProductGoods) or "{}"
  local totalCost = math.floor(DataModel.TransitGoodsCost * (DataModel.SelectRouteDistance / 100) * totalSpace + 0.5)
  CommonTips.OnPrompt(string.format(GetText(80607794), PlayerData:GetFactoryData(11400001).textIcon, totalCost, totalSpace, PlayerData:GetFactoryData(DataModel.CurSelectRouteId).name), nil, nil, function()
    Net:SendProto("prison.transport_goods", function(json)
      if json.fleet_work_info then
        PlayerData.ServerData.user_prison_info.fleet_work_info = json.fleet_work_info
      end
      if json.product then
        PlayerData.ServerData.user_prison_info.product = json.product
      end
      if json.raw_material then
        PlayerData.ServerData.user_prison_info.raw_material = json.raw_material
      end
      if json.warehouse_cache then
        PlayerData.ServerData.user_home_info.warehouse_cache = json.warehouse_cache
      end
      DataModel.InitWarehouseData()
      DataModel.InitFleetData()
      DataModel.InitRouteData()
      View.Group_TransitGoods:SetActive(false)
      Controller:RefreshFleetPanel()
      Controller:RefreshRoutePanel()
      Controller:InitUI()
    end, DataModel.CurSelectRouteId, tostring(canUseFleetId), materialArr, productArr)
  end)
end

function Controller:OpenBatchPanel(info, idx)
  local batchUICtr = View.Group_TransitGoods.Group_Warehouse.Group_Batch
  batchUICtr.self:SetActive(true)
  DataModel.BatchInfo = info
  DataModel.BatchIdx = idx
  Controller:RefreshItem(info, batchUICtr.Group_Panel.Group_Item)
  batchUICtr.Group_Panel.Txt_Name:SetText(info.name or info.info.name)
  batchUICtr.Group_Panel.ScrollView_Describe.Viewport.Txt_Describe:SetText(info.des or info.info.des)
  batchUICtr.Group_Panel.Img_Flat:SetActive(false)
  batchUICtr.Group_Panel.Img_Up:SetActive(false)
  batchUICtr.Group_Panel.Img_Down:SetActive(false)
  batchUICtr.Group_Panel.Img_TrendFlat:SetActive(false)
  batchUICtr.Group_Panel.Img_TrendUp:SetActive(false)
  batchUICtr.Group_Panel.Img_TrendDown:SetActive(false)
  batchUICtr.Group_Panel.Txt_Quotation:SetActive(false)
  batchUICtr.Group_Panel.self:SetAnchoredPositionY(-200)
  local maxNum, minNum
  maxNum = info.num
  minNum = maxNum <= 0 and 0 or 1
  batchUICtr.Group_Panel.Group_Slider.Group_Num.Txt_Select:SetText(minNum)
  batchUICtr.Group_Panel.Group_Slider.Group_Num.Txt_Possess:SetText(maxNum)
  batchUICtr.Group_Panel.Group_Slider.Slider_Value.self:SetMinAndMaxValue(minNum, maxNum, true)
  batchUICtr.Group_Panel.Group_Slider.Slider_Value.self:SetSliderValue(minNum)
  DataModel.BatchNum = minNum
  View.Group_TransitGoods.Group_Warehouse.Group_Batch.Group_Panel.Group_Gold.Txt_Num:SetText(math.floor(DataModel.BatchNum * DataModel.TransitGoodsCost * (DataModel.SelectRouteDistance / 100)))
end

function Controller:EnterTransPrisoner()
  local can, code = DataModel.CheckCanTransPrisoner()
  if not can then
    local txt = DataModel.PrisonerFailTips[code]
    if txt then
      CommonTips.OpenTips(GetText(txt))
    end
    return
  end
  DataModel.SelectPrisoner = {}
  View.Group_TransitPrisoners:SetActive(true)
  View.self:StartC(LuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01))
    Controller:RefreshPrisonerList()
  end))
end

function Controller:RefreshPrisonerCostValue()
  local distance = DataModel.GetDistanceToPrison()
  local timeCost = distance / 100 * DataModel.TransitTime
  local min = math.floor(timeCost // 60)
  local sec = math.floor(timeCost % 60)
  View.Group_TransitPrisoners.Group_Des.Group_Time.Txt_Time:SetText(string.format("%02d:%02d", min, sec))
  local moneyCost = math.floor(table.count(DataModel.SelectPrisoner) * DataModel.TransitPrisonerCost * (distance / 100) + 0.5)
  View.Group_TransitPrisoners.Group_Des.Group_Cost.Txt_Time:SetText(moneyCost)
  View.Group_TransitPrisoners.Group_Des.Group_PrisonerCapacity.Img_PBNow:SetFilledImgAmount((DataModel.CurPrisonerCount + DataModel.TempPrisonerCount) / DataModel.MaxPrisonerCount)
  View.Group_TransitPrisoners.Group_Des.Group_PrisonerCapacity.Img_PBAfter:SetFilledImgAmount((DataModel.CurPrisonerCount + table.count(DataModel.SelectPrisoner) + DataModel.TempPrisonerCount) / DataModel.MaxPrisonerCount)
  View.Group_TransitPrisoners.Group_Des.Group_PrisonerCapacity.Txt_Space:SetText(DataModel.CurPrisonerCount + DataModel.TempPrisonerCount + table.count(DataModel.SelectPrisoner) .. "/" .. DataModel.MaxPrisonerCount)
end

function Controller:ReleasePrisoner(idx)
  local row = DataModel.CarryingPrisoner[idx]
  if row then
    CommonTips.OnPrompt("80607091", "80600068", "80600067", function()
      local u_pid_list = {
        row.u_pid
      }
      Net:SendProto("prison.release", function(json)
        DataModel.InitCarryingPrisonerData()
        if DataModel.SelectPrisoner[row.u_pid] ~= nil then
          DataModel.SelectPrisoner[row.u_pid] = nil
        end
        Controller:RefreshPrisonerList()
      end, u_pid_list)
    end)
  end
end

function Controller:ClickPrisonerElement(idx)
  local row = DataModel.CarryingPrisoner[idx]
  if row then
    if DataModel.SelectPrisoner[row.u_pid] then
      DataModel.SelectPrisoner[row.u_pid] = nil
    else
      if DataModel.CurPrisonerCount + table.count(DataModel.SelectPrisoner) + DataModel.TempPrisonerCount >= DataModel.MaxPrisonerCount then
        CommonTips.OpenTips(GetText(80608717))
        return
      end
      DataModel.SelectPrisoner[row.u_pid] = true
    end
  end
  Controller:RefreshPrisonerList()
end

function Controller:TrySelectAllPrisoner()
  local totalCount = table.count(DataModel.CarryingPrisoner)
  local alreadySelect = table.count(DataModel.SelectPrisoner)
  local canAllSelectCount = DataModel.MaxPrisonerCount - DataModel.TempPrisonerCount - DataModel.CurPrisonerCount - alreadySelect
  if canAllSelectCount <= 0 then
    return
  end
  for i = 1, totalCount do
    local row = DataModel.CarryingPrisoner[i]
    if not DataModel.SelectPrisoner[row.u_pid] then
      DataModel.SelectPrisoner[row.u_pid] = true
      canAllSelectCount = canAllSelectCount - 1
      if canAllSelectCount <= 0 then
        break
      end
    end
  end
  Controller:RefreshPrisonerList()
end

function Controller:ConfirmTransitPrisoner()
  if table.count(DataModel.SelectPrisoner) == 0 then
    return
  end
  local canUseFleetId = DataModel.GetCanUseFleet()
  if canUseFleetId < 0 then
    return
  end
  local distance = DataModel.GetDistanceToPrison()
  local moneyCost = math.floor(table.count(DataModel.SelectPrisoner) * DataModel.TransitPrisonerCost * (distance / 100) + 0.5)
  CommonTips.OnPrompt(string.format(GetText(80607847), PlayerData:GetFactoryData(11400001).textIcon, moneyCost, table.count(DataModel.SelectPrisoner), PlayerData:GetFactoryData(83000017).name), nil, nil, function()
    Net:SendProto("prison.transport_prisoner", function(json)
      if json.fleet_work_info then
        PlayerData.ServerData.user_prison_info.fleet_work_info = json.fleet_work_info
      end
      if json.carrying_backpack then
        PlayerData.ServerData.user_prison_info.carrying_backpack = json.carrying_backpack
      end
      if json.temporary_backpack then
        PlayerData.ServerData.user_prison_info.temporary_backpack = json.temporary_backpack
      end
      DataModel.InitFleetData()
      DataModel.InitCarryingPrisonerData()
      DataModel.InitFleetData()
      View.Group_TransitPrisoners:SetActive(false)
      Controller:RefreshFleetPanel()
      Controller:InitUI()
    end, tostring(canUseFleetId), Json.encode(DataModel.SelectPrisoner))
  end)
end

return Controller
