local View = require("UIHYOrderStation/UIHYOrderStationView")
local NPCDialog = require("Common/NPCDialog")
local HomeCommon = require("Common/HomeCommon")
local HyOrderStationData = require("UIHYOrderStation/UIHYOrderStationDataModel")
local OrderData = require("UIHYOrderStation/PrisonHyOrderData")
local WeekOrderData = require("UIHYOrderStation/PrisonHyWeekOrderData")
local CommonBtn = require("Common/BtnItem")
local Controller = {}

function Controller.RefreshOnShow()
  if HyOrderStationData.curMenuTab == HyOrderStationData.MenuTab.Order then
    OrderData.InitData()
    OrderData.SortOrderList()
    OrderData.SetOrderIndex()
    Controller.RefreshOrderPanel()
    View.self:PlayAnim("OrderList")
  elseif HyOrderStationData.curMenuTab == HyOrderStationData.MenuTab.WeekOrder then
    Controller.RefreshWeekOrderPanel()
    View.self:PlayAnim("WeekOrder")
  else
    Controller.RefreshMainPanel()
    View.self:PlayAnim("In")
  end
end

function Controller.RefreshMainPanel()
  View.Group_Main:SetActive(true)
  View.Group_Quest:SetActive(false)
  View.Group_WeekOrder:SetActive(false)
  View.Group_Exchange:SetActive(false)
  local buildCA = HyOrderStationData.buildCA
  NPCDialog.SetNPC(View.Group_NPC, buildCA.npcId)
  HomeCommon.SetReputationElement(View.Group_Reputation, HyOrderStationData.StationId)
  Controller.NpcTalk()
  View.Img_BG:SetSprite(buildCA.bgPath)
  View.Group_Main.Btn_Order.Img_RedPoint:SetActive(OrderData.GetRedPoint())
  local stationCA = PlayerData:GetFactoryData(HyOrderStationData.StationId, "HomeStationFactory")
  View.Group_Main.Group_NpcInfo.Group_Station.Txt_Station:SetText(stationCA.name)
  local prisonCA = PrisonData.GetPrisonCA()
  View.Group_Main.Btn_WeekOrder.Img_Rep:SetActive(PrisonData.GetPrisonLv() < prisonCA.weekOrderLevel)
end

function Controller.ClickOrderMenu()
  if not PrisonData.GetSeverPrisonData() then
    CommonTips.OpenTips(80608796)
    return
  end
  if HyOrderStationData.curMenuTab == HyOrderStationData.MenuTab.Order then
    return
  end
  HyOrderStationData.curMenuTab = HyOrderStationData.MenuTab.Order
  OrderData.InitData()
  OrderData.SortOrderList()
  OrderData.SetOrderIndex()
  Controller.RefreshOrderPanel()
  View.self:PlayAnim("OrderList")
end

function Controller.RefreshOrderPanel()
  View.Group_Main:SetActive(false)
  View.Group_Quest:SetActive(true)
  View.Group_WeekOrder:SetActive(false)
  View.Group_Exchange:SetActive(false)
  OrderData.orderTabTimeList = {}
  local prisonCA = PrisonData.GetPrisonCA()
  View.Group_Quest.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetGoodsById(11400001).num)
  View.Group_Quest.Group_PrisonLv.Txt_Num:SetText(string.format(GetText(80608100), PrisonData.GetPrisonLv()))
  local count = prisonCA.lvList[#prisonCA.lvList] and prisonCA.lvList[#prisonCA.lvList].refreshNum or 8
  View.Group_Quest.ScrollGrid_Tab.grid.self:SetDataCount(count)
  View.Group_Quest.ScrollGrid_Tab.grid.self:RefreshAllElement()
  Controller.RefreshOrderInfo()
  View.Group_Quest.Btn_Produce.Img_RedPoint:SetActive(HyOrderStationData.GetManufactureRedPoint())
end

function Controller.RefreshOrderInfo()
  local orderIndex = OrderData.orderIndex
  local orderData = OrderData.orders[tonumber(orderIndex)]
  local inRefresh = OrderData.GetRemainRefreshTime(orderIndex) > 0
  View.Group_Quest.Img_BG.Group_Order:SetActive(not inRefresh)
  View.Group_Quest.Img_BG.Group_NoOrder:SetActive(inRefresh)
  if inRefresh then
    View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Diamond.Group_On:SetActive(OrderData.refreshType == OrderData.RefreshType.Diamond)
    View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Diamond.Group_off:SetActive(OrderData.refreshType ~= OrderData.RefreshType.Diamond)
    View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Item.Group_On:SetActive(OrderData.refreshType == OrderData.RefreshType.Other)
    View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Item.Group_off:SetActive(OrderData.refreshType ~= OrderData.RefreshType.Other)
    Controller.RefreshDiamond()
    Controller.RefreshOtherItem()
    local time = OrderData.GetRemainRefreshTime(orderIndex)
    local timeTbl = TimeUtil:SecondToTableHMS(time)
    View.Group_Quest.Img_BG.Group_NoOrder.Txt_Time:SetText(string.format("%02d:%02d:%02d", timeTbl.hour, timeTbl.minute, timeTbl.second))
  else
    local orderInfo = OrderData.orders[tonumber(orderIndex)]
    local orderId = orderInfo.data.oid
    local orderCA = PlayerData:GetFactoryData(orderId, "PrisonProcurementFactory")
    View.Group_Quest.Img_BG.Group_Order.Txt_Name:SetText(orderCA.name)
    View.Group_Quest.Img_BG.Group_Order.StaticGrid_Requirements.grid.self:SetParentParam(orderId)
    View.Group_Quest.Img_BG.Group_Order.StaticGrid_Requirements.grid.self:SetDataCount(#orderCA.requireItemList)
    View.Group_Quest.Img_BG.Group_Order.StaticGrid_Requirements.grid.self:RefreshAllElement()
    View.Group_Quest.Img_BG.Group_Order.ScrollGrid_Rewards.grid.self:SetParentParam(orderId)
    View.Group_Quest.Img_BG.Group_Order.ScrollGrid_Rewards.grid.self:SetDataCount(#orderCA.rewardsList)
    View.Group_Quest.Img_BG.Group_Order.ScrollGrid_Rewards.grid.self:RefreshAllElement()
    local canDeliver = OrderData.IsOrderCanDeliver(orderIndex)
    View.Group_Quest.Img_BG.Group_Order.Btn_Deliver:SetActive(canDeliver)
    View.Group_Quest.Img_BG.Group_Order.Btn_CannotDeliver:SetActive(not canDeliver)
    local recorded = OrderData.recordOrders[orderInfo.serverIndex]
    View.Group_Quest.Img_BG.Group_Order.Btn_Note.Img_Noted:SetActive(recorded)
    View.Group_Quest.Img_BG.Group_Order.Btn_Note.Img_Note:SetActive(not recorded)
    View.Group_Quest.Img_BG.Group_Order.Btn_Deliver:SetActive(canDeliver)
    View.Group_Quest.Img_BG.Group_Order.Btn_CannotDeliver:SetActive(not canDeliver)
    View.Group_Quest.Img_BG.Group_Order.ScrollGrid_Materials.grid.self:SetActive(0 < orderCA.requireProduction)
    if 0 < orderCA.requireProduction then
      local formulaCA = PlayerData:GetFactoryData(orderCA.requireProduction, "ProductionFactory")
      View.Group_Quest.Img_BG.Group_Order.ScrollGrid_Materials.grid.self:SetDataCount(#formulaCA.costList)
      View.Group_Quest.Img_BG.Group_Order.ScrollGrid_Materials.grid.self:RefreshAllElement()
    end
    local itemId = orderCA.requireItemList[1] and orderCA.requireItemList[1].id
    local itemCA = PlayerData:GetFactoryData(itemId, "HomeGoodsFactory")
    View.Group_Quest.Img_BG.Group_Order.Img_Owned.Img_:SetSprite(itemCA.imagePath)
    View.Group_Quest.Img_BG.Group_Order.Img_Owned.Img_Num.Txt_:SetText(PrisonData.GetGoodsById(itemId))
  end
end

function Controller.DiamondClick()
  if OrderData.refreshType == OrderData.RefreshType.Diamond then
    return
  end
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Diamond.Group_On:SetActive(true)
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Diamond.Group_off:SetActive(false)
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Item.Group_On:SetActive(false)
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Item.Group_off:SetActive(true)
  OrderData.refreshType = OrderData.RefreshType.Diamond
end

function Controller.RefreshDiamond()
  local diamondCost = OrderData.buildCA.orderPrisonRefreshDiamondList[1]
  local itemCA = PlayerData:GetFactoryData(diamondCost.id, "ItemFactory")
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Diamond.Group_On.Txt_Num:SetText(diamondCost.num)
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Diamond.Group_off.Txt_Num:SetText(diamondCost.num)
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Diamond.Img_Item:SetSprite(itemCA.iconPath)
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Diamond.Txt_Name:SetText(itemCA.name)
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Diamond:SetClickParam(OrderData.RefreshType.Diamond)
  Controller.RefreshDiamondUseNum()
end

function Controller.RefreshDiamondUseNum()
  local useTime = OrderData.useTime
  local remainTime = OrderData.buildCA.orderPrisonRefreshDiamondTimes - useTime
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Diamond.Group_On.Txt_Times:SetText(string.format(GetText(80608849), remainTime))
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Diamond.Group_off.Txt_Times:SetText(string.format(GetText(80608849), remainTime))
end

function Controller.OtherItemClick()
  if OrderData.refreshType == OrderData.RefreshType.Other then
    return
  end
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Diamond.Group_On:SetActive(false)
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Diamond.Group_off:SetActive(true)
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Item.Group_On:SetActive(true)
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Item.Group_off:SetActive(false)
  OrderData.refreshType = OrderData.RefreshType.Other
end

function Controller.RefreshOtherItem()
  local otherItemCost = OrderData.buildCA.orderPrisonRefreshItemList[1]
  local itemCA = PlayerData:GetFactoryData(otherItemCost.id, "ItemFactory")
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Item.Group_On.Txt_Num:SetText(otherItemCost.num)
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Item.Group_off.Txt_Num:SetText(otherItemCost.num)
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Item.Img_Item:SetSprite(itemCA.iconPath)
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Item.Txt_Name:SetText(itemCA.name)
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Item:SetClickParam(OrderData.RefreshType.Other)
  Controller.RefreshOtherItemNum()
end

function Controller.RefreshOtherItemNum()
  local otherItemCost = OrderData.buildCA.orderPrisonRefreshItemList[1]
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Item.Group_On.Txt_Times:SetText(string.format(GetText(80608847), PlayerData:GetGoodsById(otherItemCost.id).num))
  View.Group_Quest.Img_BG.Group_NoOrder.Group_Pick.Btn_Item.Group_off.Txt_Times:SetText(string.format(GetText(80608847), PlayerData:GetGoodsById(otherItemCost.id).num))
end

function Controller.ClickOrderTab(orderIndex)
  orderIndex = tonumber(orderIndex)
  local orderInfo = OrderData.orders[orderIndex]
  if not orderInfo then
    return
  end
  if OrderData.orderIndex == orderIndex then
    return
  end
  OrderData.SetOrderState(orderIndex, 1)
  OrderData.SetOrderIndex(orderIndex)
  OrderData.orderTabTimeList = {}
  View.Group_Quest.ScrollGrid_Tab.grid.self:RefreshAllElement()
  Controller.RefreshOrderInfo()
end

function Controller.NpcTalk()
  local HomeCocDataModel = require("UIHomeCOC/UIHomeCOCDataModel")
  local dialogEnum = HomeCocDataModel.NPCDialogEnum.talkText
  local buildCA = HyOrderStationData.buildCA
  local npcConfig = PlayerData:GetFactoryData(buildCA.npcId, "NPCFactory")
  local textTable = npcConfig[dialogEnum]
  if textTable == nil then
    return
  end
  NPCDialog.SetNPCText(View.Group_NPC, textTable, dialogEnum)
end

function Controller.DeliverOrderClick()
  local selectIndex = OrderData.orderIndex
  local orderInfo = OrderData.orders[selectIndex]
  if orderInfo then
    local serverIndex = orderInfo.serverIndex
    local recorded = OrderData.recordOrders[serverIndex]
    Net:SendProto("prison.deliver", function(json)
      local reqList = PlayerData:GetFactoryData(orderInfo.data.oid).requireItemList
      for i, v in ipairs(reqList) do
        local itemId = tostring(v.id)
        local productInfo = PrisonData.GetProduct(itemId)
        local productNum = productInfo and productInfo.num or 0
        if productNum < v.num then
          if productInfo then
            productInfo.num = 0
          end
          local remainNum = v.num - productNum
          local rawInfo = PrisonData.GetRawMaterial(itemId)
          local rawNum = rawInfo and rawInfo.num or 0
          if remainNum > rawNum then
            if rawInfo then
              rawInfo.num = 0
            end
            remainNum = remainNum - rawNum
            PlayerData.ServerData.user_home_info.warehouse[itemId].num = PlayerData.ServerData.user_home_info.warehouse[itemId].num - remainNum
          else
            rawInfo.num = rawInfo.num - remainNum
          end
        else
          productInfo.num = productInfo.num - v.num
        end
      end
      if json.prison_orders then
        OrderData.orders[selectIndex].data = json.prison_orders
        OrderData.SetOrderState(selectIndex, 0)
      end
      OrderData.SortOrderList()
      if json.reward then
        CommonTips.OpenShowItem(json.reward)
      end
      if recorded then
        OrderData.recordOrders[serverIndex] = nil
        View.Group_Quest.Img_BG.Group_Order.Btn_Note.Img_Noted:SetActive(false)
        View.Group_Quest.Img_BG.Group_Order.Btn_Note.Img_Note:SetActive(true)
      end
      OrderData.SetOrderIndex()
      OrderData.orderTabTimeList = {}
      View.Group_Quest.ScrollGrid_Tab.grid.self:RefreshAllElement()
      Controller.RefreshOrderInfo()
    end, 84400137, serverIndex)
  end
end

function Controller.DeleteOrderClick()
  local selectIndex = OrderData.orderIndex
  local orderInfo = OrderData.orders[selectIndex]
  if orderInfo then
    local remainTime = OrderData.GetRemainRefreshTime(selectIndex)
    if 0 < remainTime then
      return
    end
    local serverIndex = orderInfo.serverIndex
    local recorded = OrderData.recordOrders[serverIndex]
    Net:SendProto("prison.refresh_order", function(json)
      if json.prison_orders then
        OrderData.orders[selectIndex].data = json.prison_orders
        OrderData.SetOrderState(selectIndex, 0)
      end
      if recorded then
        OrderData.recordOrders[serverIndex] = nil
        View.Group_Quest.Img_BG.Group_Order.Btn_Note.Img_Noted:SetActive(false)
        View.Group_Quest.Img_BG.Group_Order.Btn_Note.Img_Note:SetActive(true)
      end
      OrderData.SortOrderList()
      OrderData.orderTabTimeList = {}
      View.Group_Quest.ScrollGrid_Tab.grid.self:RefreshAllElement()
      Controller.RefreshOrderInfo()
    end, 84400137, serverIndex)
  end
end

function Controller.RecordOrderClick()
  local selectIndex = OrderData.orderIndex
  local orderInfo = OrderData.orders[selectIndex]
  if orderInfo then
    local serverIndex = orderInfo.serverIndex
    local recorded = OrderData.recordOrders[serverIndex]
    if recorded then
      OrderData.recordOrders[serverIndex] = nil
    else
      OrderData.recordOrders[serverIndex] = orderInfo.data
    end
    local status = recorded and 0 or 1
    Net:SendProto("prison.record", function(json)
      OrderData.orderTabTimeList = {}
      View.Group_Quest.ScrollGrid_Tab.grid.self:RefreshAllElement()
    end, 84400137, serverIndex, status)
  end
end

function Controller.GetOrderImmediately()
  local selectIndex = OrderData.orderIndex
  local serverIndex = OrderData.orders[selectIndex].serverIndex
  local costType = OrderData.refreshType == OrderData.RefreshType.Other and "item" or ""
  local useTime = OrderData.useTime
  local remainTime = HyOrderStationData.buildCA.orderPrisonRefreshDiamondTimes - useTime
  if OrderData.refreshType == OrderData.RefreshType.Diamond and remainTime == 0 then
    CommonTips.OpenTips(80607781)
    return
  end
  
  local function delayDo()
    Net:SendProto("prison.order_cost", function(json)
      if json.prison_orders then
        OrderData.orders[selectIndex].data = json.prison_orders
      end
      OrderData.SortOrderList()
      local orderIndex = 1
      for i, v in ipairs(OrderData.orders) do
        if OrderData.GetRemainRefreshTime(i) > 0 then
          orderIndex = i
          break
        end
      end
      OrderData.SetOrderIndex(orderIndex)
      OrderData.orderTabTimeList = {}
      View.Group_Quest.ScrollGrid_Tab.grid.self:RefreshAllElement()
      Controller.RefreshOrderInfo()
      if OrderData.refreshType == OrderData.RefreshType.Diamond then
        OrderData.useTime = OrderData.useTime + 1
        Controller.RefreshDiamondUseNum()
      end
      if OrderData.refreshType == OrderData.RefreshType.Other then
        local useItems = {}
        local otherItemCost = HyOrderStationData.buildCA.orderPrisonRefreshItemList[1]
        useItems[otherItemCost.id] = otherItemCost.num
        PlayerData:RefreshUseItems(useItems)
        Controller.RefreshOtherItemNum()
      end
    end, 84400137, serverIndex, costType)
    OrderData.orderTabTimeList[tonumber(selectIndex)] = nil
  end
  
  if OrderData.refreshType == OrderData.RefreshType.Diamond then
    if not PlayerData:GetNoPrompt("HyOrderStationDiamondRefresh", 1) then
      local checkTipParam = {}
      checkTipParam.isCheckTip = true
      checkTipParam.checkTipKey = "HyOrderStationDiamondRefresh"
      checkTipParam.checkTipType = 1
      local cost = OrderData.buildCA.orderPrisonRefreshDiamondList[1]
      local haveNum = PlayerData:GetGoodsById(cost.id).num
      local textIcon = PlayerData:GetFactoryData(cost.id, "ItemFactory").textIcon
      local content = string.format(GetText(80609987), textIcon, cost.num, textIcon, haveNum)
      CommonTips.OnPrompt(content, nil, nil, delayDo, nil, nil, nil, nil, checkTipParam)
    else
      delayDo()
    end
  else
    delayDo()
  end
end

function Controller.ClickWeekOrderMenu()
  if not PrisonData.GetSeverPrisonData() then
    CommonTips.OpenTips(80608796)
    return
  end
  local prisonCA = PrisonData.GetPrisonCA()
  if PrisonData.GetPrisonLv() < prisonCA.weekOrderLevel then
    return
  end
  if HyOrderStationData.curMenuTab == HyOrderStationData.MenuTab.WeekOrder then
    return
  end
  HyOrderStationData.curMenuTab = HyOrderStationData.MenuTab.WeekOrder
  Net:SendProto("prison.big_orders_mian", function(json)
    if json.reward then
      CommonTips.OpenShowItem(json.reward)
    end
    if json.all_big_order_list then
      WeekOrderData.orders = json.all_big_order_list
    end
    WeekOrderData.SetNewOrders()
    WeekOrderData.SortOrders()
    if json.big_orders_record then
      WeekOrderData.deliverRecordOrders = json.big_orders_record
    end
    if json.big_orders_remark then
      WeekOrderData.recordOrders = json.big_orders_remark
    end
    WeekOrderData.totalRewardCanGet = json.big_orders_reward
    WeekOrderData.SetOrderIndex()
    Controller.RefreshWeekOrderPanel()
    View.self:PlayAnim("WeekOrder")
  end)
  View.Group_WeekOrder.Group_BuyTips:SetActive(false)
end

function Controller.RefreshWeekOrderPanel()
  View.Group_Main:SetActive(false)
  View.Group_Quest:SetActive(false)
  View.Group_WeekOrder:SetActive(true)
  View.Group_Exchange:SetActive(false)
  View.Group_WeekOrder.Group_GoldCoin.Txt_Num:SetText(PlayerData:GetGoodsById(11400001).num)
  View.Group_WeekOrder.Group_PrisonLv.Txt_Num:SetText(string.format(GetText(80608100), PrisonData.GetPrisonLv()))
  local count = table.count(WeekOrderData.orders)
  View.Group_WeekOrder.ScrollGrid_Tab.grid.self:SetDataCount(count)
  View.Group_WeekOrder.ScrollGrid_Tab.grid.self:RefreshAllElement()
  Controller.RefreshWeekOrderInfo()
end

function Controller.RefreshWeekOrderInfo()
  local orderIndex = WeekOrderData.orderIndex
  local orderId = WeekOrderData.orders[orderIndex]
  local orderCA = PlayerData:GetFactoryData(orderId, "PrisonProcurementFactory")
  View.Group_WeekOrder.Img_BG.Txt_OrderName:SetText(orderCA.name)
  local itemCfg = orderCA.weekRequireItemList[1]
  if not itemCfg then
    return
  end
  WeekOrderData.perNum = itemCfg.perNum
  local haveNum = PrisonData.GetGoodsById(itemCfg.id)
  local maxDeliverNum = itemCfg.perNum * math.modf(haveNum / itemCfg.perNum)
  local deliverNum = WeekOrderData.deliverRecordOrders[tostring(orderId)] or 0
  local remainDeliverNum = itemCfg.totalNum - deliverNum
  maxDeliverNum = maxDeliverNum > remainDeliverNum and remainDeliverNum or maxDeliverNum
  WeekOrderData.maxDeliverNum = maxDeliverNum
  local remainSecond = TimeUtil:GetNextWeekTime(1, 5)
  local timeTable = TimeUtil:SecondToTable(remainSecond - PlayerData:GetSeverTime())
  if 1 <= timeTable.day then
    View.Group_WeekOrder.Img_BG.Group_Time.Txt_Time:SetText(timeTable.day)
    View.Group_WeekOrder.Img_BG.Group_Time.Txt_TimeDay:SetText(GetText(80609081))
  else
    View.Group_WeekOrder.Img_BG.Group_Time.Txt_Time:SetText(timeTable.hour)
    View.Group_WeekOrder.Img_BG.Group_Time.Txt_TimeDay:SetText(GetText(80609162))
  end
  local goodsCA = PlayerData:GetFactoryData(itemCfg.id, "HomeGoodsFactory")
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_target.Img_:SetSprite(goodsCA.imagePath)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_target.Txt_:SetText(goodsCA.name)
  local totalNum = itemCfg.totalNum
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_Progress.Group_ProgressNum.Txt_Num:SetText(deliverNum)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_Progress.Group_ProgressNum.Txt_Total:SetText(totalNum)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_Progress.Img_bar:SetFilledImgAmount(deliverNum / totalNum)
  local productCA = PlayerData:GetFactoryData(orderCA.weekRequireProduction, "ProductionFactory")
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_Material.ScrollGrid_Materials.grid.self:SetDataCount(table.count(productCA.costList))
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_Material.ScrollGrid_Materials.grid.self:RefreshAllElement()
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_CompleteRewards.ScrollGrid_Rewards.grid.self:SetDataCount(#orderCA.weekTotalRewardsList)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_CompleteRewards.ScrollGrid_Rewards.grid.self:RefreshAllElement()
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_PerRewards.Txt_TitleRewards:SetText(string.format(GetText(80609074), itemCfg.perNum))
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_PerRewards.ScrollGrid_Rewards.grid.self:SetDataCount(#orderCA.weekPerRewardsList)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_PerRewards.ScrollGrid_Rewards.grid.self:RefreshAllElement()
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Img_Owned.Img_:SetSprite(goodsCA.imagePath)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Img_Owned.Img_Num.Txt_:SetText(haveNum)
  local accepted = WeekOrderData.deliverRecordOrders[tostring(orderId)]
  local recorded = WeekOrderData.IsOrderRecorded(orderId)
  local canDeliver = WeekOrderData.IsOrderCanDeliver(orderId)
  local completed = WeekOrderData.IsOrderCompleted(orderId)
  local itemEnough = WeekOrderData.IsDeliverItemEnough(orderId)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_Unaccept:SetActive(not accepted)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Btn_Note:SetActive(accepted)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_Unaccept.Txt_RecommendedLevel:SetText(string.format(GetText(80609176), orderCA.recommendedLevel))
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Btn_Note.Img_Noted:SetActive(recorded)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Btn_Note.Txt_Delete:SetActive(recorded)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Btn_Note.Img_Note:SetActive(not recorded)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Btn_Note.Txt_:SetActive(not recorded)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Btn_Deliver:SetActive(canDeliver)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Btn_CannotDeliver:SetActive(not completed and not itemEnough)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_OrderComplete:SetActive(completed)
  local completedNum = WeekOrderData.GetCompletedOrderNum()
  local prisonCA = PrisonData.GetPrisonCA()
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_TotalRewards.Txt_Num:SetText(completedNum .. "/" .. prisonCA.weekOrdercompleteNum)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Btn_Get:SetActive(WeekOrderData.totalRewardCanGet == 1)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_Uncomplete:SetActive(WeekOrderData.totalRewardCanGet == 0 and completedNum < prisonCA.weekOrdercompleteNum)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_Get:SetActive(WeekOrderData.totalRewardCanGet == 0 and completedNum == prisonCA.weekOrdercompleteNum)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_TotalRewards.ScrollGrid_Rewards.grid.self:SetDataCount(#prisonCA.weekOrderRewardsList)
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Group_TotalRewards.ScrollGrid_Rewards.grid.self:RefreshAllElement()
  local acceptedCount = WeekOrderData.deliverRecordOrders and table.count(WeekOrderData.deliverRecordOrders) or 0
  local canAcceptCount = prisonCA.weekOrdercompleteNum
  View.Group_WeekOrder.Img_BG.Group_WeekOrder.Img_AcceptNum.Txt_AcceptNum:SetText(string.format(GetText(80609180), acceptedCount, canAcceptCount))
end

function Controller.ClickWeekOrderTab(orderIndex)
  orderIndex = tonumber(orderIndex)
  if WeekOrderData.orderIndex == orderIndex then
    return
  end
  WeekOrderData.SetOrderState(orderIndex, 0)
  WeekOrderData.SetOrderIndex(orderIndex)
  View.Group_WeekOrder.ScrollGrid_Tab.grid.self:RefreshAllElement()
  Controller.RefreshWeekOrderInfo()
end

function Controller.ClickWeekOrderSelect()
  local orderIndex = WeekOrderData.orderIndex
  local orderId = WeekOrderData.orders[orderIndex]
  local orderCA = PlayerData:GetFactoryData(orderId, "PrisonProcurementFactory")
  local productCA = PlayerData:GetFactoryData(orderCA.weekRequireProduction, "ProductionFactory")
  local unLock = false
  if productCA.unlock and productCA.unlock > 0 then
    local ownList = PlayerData.ServerData.formula_items or {}
    for k1, v1 in pairs(ownList) do
      if v1 == tostring(productCA.unlock) then
        unLock = true
        break
      end
    end
  else
    unLock = true
  end
  local promoteTxtId = unLock and 80609178 or 80609179
  
  local function yesFun()
    local function cb()
      WeekOrderData.SetOrderState(orderIndex, 0)
      
      View.Group_WeekOrder.ScrollGrid_Tab.grid.self:RefreshAllElement()
      Controller.RefreshWeekOrderInfo()
    end
    
    Controller.SelectWeekOrder(orderId, cb)
  end
  
  CommonTips.OnPrompt(promoteTxtId, nil, nil, yesFun)
end

function Controller.SelectWeekOrder(orderId, cb)
  Net:SendProto("prison.select_big_orders", function(json)
    if json.big_orders_record then
      WeekOrderData.deliverRecordOrders = json.big_orders_record
    end
    if cb then
      cb()
    end
  end, orderId)
end

function Controller.ClickRecordWeekOrder()
  local orderIndex = WeekOrderData.orderIndex
  local orderId = WeekOrderData.orders[orderIndex]
  if not WeekOrderData.deliverRecordOrders[tostring(orderId)] then
    CommonTips.OpenTips(80609170)
    return
  end
  
  local function cb()
    View.Group_WeekOrder.ScrollGrid_Tab.grid.self:RefreshAllElement()
    Controller.RefreshWeekOrderInfo()
  end
  
  Controller.RecordWeekOrder(orderId, cb)
end

function Controller.RecordWeekOrder(orderId, cb)
  local recorded = WeekOrderData.IsOrderRecorded(orderId)
  local op = recorded and "" or "remark"
  Net:SendProto("prison.remark_big_orders", function(json)
    if json.big_orders_remark then
      WeekOrderData.recordOrders = json.big_orders_remark
    end
    if cb then
      cb()
    end
  end, op, orderId)
end

function Controller.ClickWeekOrderDeliver()
  local orderIndex = WeekOrderData.orderIndex
  local orderId = WeekOrderData.orders[orderIndex]
  local orderCA = PlayerData:GetFactoryData(orderId, "PrisonProcurementFactory")
  local itemCfg = orderCA.weekRequireItemList[1]
  if not itemCfg then
    return
  end
  local perNum = itemCfg.perNum
  local haveNum = PrisonData.GetGoodsById(itemCfg.id)
  if perNum > haveNum then
    return
  end
  CommonBtn.SetItem(self, View.Group_WeekOrder.Group_BuyTips.Group_Item, {
    id = itemCfg.id
  })
  local goodsCA = PlayerData:GetFactoryData(itemCfg.id, "HomeGoodsFactory")
  View.Group_WeekOrder.Group_BuyTips.Txt_Name:SetText(goodsCA.name)
  View.Group_WeekOrder.Group_BuyTips.Group_Item.Txt_Num:SetText(haveNum)
  View.Group_WeekOrder.Group_BuyTips.Group_Item.Btn_Item:SetClickParam(tostring(itemCfg.id))
  WeekOrderData.deliverNum = perNum
  View.Group_WeekOrder.Group_BuyTips.Btn_Dec.Txt_:SetText("-" .. perNum)
  View.Group_WeekOrder.Group_BuyTips.Btn_Add.Txt_:SetText("+" .. perNum)
  View.Group_WeekOrder.Group_BuyTips.Txt_Tips:SetText(string.format(GetText(80609161), perNum))
  View.Group_WeekOrder.Group_BuyTips.Group_Slider.Group_Num.Txt_Possess:SetText(WeekOrderData.maxDeliverNum)
  View.Group_WeekOrder.Group_BuyTips.Group_Slider.Slider_Value:SetMinAndMaxValue(0, WeekOrderData.maxDeliverNum / perNum)
  View.Group_WeekOrder.Group_BuyTips.Group_Slider.Slider_Value:SetSliderValue(1)
  View.Group_WeekOrder.Group_BuyTips:SetActive(true)
end

function Controller.ClickDeliverConfirm()
  local orderIndex = WeekOrderData.orderIndex
  local orderId = WeekOrderData.orders[orderIndex]
  
  local function cb(json)
    if json.reward then
      CommonTips.OpenShowItem(json.reward)
    end
    View.Group_WeekOrder.Group_BuyTips:SetActive(false)
    View.Group_WeekOrder.ScrollGrid_Tab.grid.self:RefreshAllElement()
    Controller.RefreshWeekOrderInfo()
  end
  
  Controller.DeliverWeekOrder(orderId, WeekOrderData.deliverNum, cb)
end

function Controller.DeliverWeekOrder(orderId, deliverNum, cb)
  if not WeekOrderData.IsOrderCanDeliver(orderId) then
    return
  end
  Net:SendProto("prison.big_deliver", function(json)
    if json.last_cost then
      for i, useList in pairs(json.last_cost) do
        local useItems = {}
        for itemId, v in pairs(useList) do
          useItems[itemId] = v.num
        end
        PlayerData:RefreshUseItems(useItems)
      end
    end
    if json.product and json.product then
      PlayerData.ServerData.user_prison_info.product = json.product
    end
    if json.raw_material then
      PlayerData.ServerData.user_prison_info.raw_material = json.raw_material
    end
    if json.big_orders_record then
      WeekOrderData.deliverRecordOrders = json.big_orders_record
    end
    WeekOrderData.totalRewardCanGet = json.big_orders_reward
    if cb then
      cb(json)
    end
  end, orderId, deliverNum)
end

function Controller.ClickWeekOrderTotalReward()
  local function cb(json)
    if json.reward then
      CommonTips.OpenShowItem(json.reward)
    end
    Controller.RefreshWeekOrderInfo()
  end
  
  Controller.GetTotalWeekReward(cb)
end

function Controller.GetTotalWeekReward(cb)
  local completedNum = WeekOrderData.GetCompletedOrderNum()
  local prisonCA = PrisonData.GetPrisonCA()
  if completedNum < prisonCA.weekOrdercompleteNum then
    return
  end
  Net:SendProto("prison.recv_big_orders", function(json)
    WeekOrderData.totalRewardCanGet = json.big_orders_reward
    if cb then
      cb(json)
    end
  end)
end

function Controller.ShowRecordPanel()
  Net:SendProto("prison.orders", function(json)
    local normalOrders = json.prison_orders or {}
    local prisonCA = PrisonData.GetPrisonCA()
    if PrisonData.GetPrisonLv() >= prisonCA.weekOrderLevel then
      Net:SendProto("prison.big_orders_mian", function(json)
        local weekOrders = json.big_orders_remark or {}
        UIManager:Open("UI/Prison/HYOrderStation/Record/HYOrderRecord", Json.encode({normalOrders = normalOrders, weekOrders = weekOrders}))
      end)
    else
      UIManager:Open("UI/Prison/HYOrderStation/Record/HYOrderRecord", Json.encode({normalOrders = normalOrders}))
    end
  end)
end

function Controller.RefreshExchange()
  View.Group_Main:SetActive(false)
  View.Group_Quest:SetActive(false)
  View.Group_WeekOrder:SetActive(false)
  View.Group_Exchange:SetActive(true)
  local goldNum = PlayerData:GetUserInfo().gold
  View.Group_Exchange.Group_GoldCoin.Txt_Num:SetText(goldNum)
  HyOrderStationData.shopList = {}
  local buildCA = HyOrderStationData.buildCA
  for i, v in ipairs(buildCA.exchangeStoreList) do
    local shopCA = PlayerData:GetFactoryData(v.id, "StoreFactory")
    local data = {
      shopId = v.id,
      shopItems = {}
    }
    for i, v1 in ipairs(shopCA.shopList) do
      if v1.id > 0 then
        table.insert(data.shopItems, {
          commodityId = v1.id
        })
      end
    end
    HyOrderStationData.shopList[v.id] = data
  end
  HyOrderStationData.notEnoughMap = {}
  HyOrderStationData.currentShop = HyOrderStationData.shopList[40300017] or {}
  local dataCount = HyOrderStationData.currentShop.shopItems and #HyOrderStationData.currentShop.shopItems or 0
  View.Group_Exchange.Group_Middle.ScrollGrid_List.grid.self:SetDataCount(dataCount)
  View.Group_Exchange.Group_Middle.ScrollGrid_List.grid.self:RefreshAllElement()
end

return Controller
