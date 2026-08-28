local View = require("UIStore/UIStoreView")
local DataModel = require("UIStore/UIStoreDataModel")
local CommonItem = require("Common/BtnItem")
local Controller = {}

function Controller:SetResetGroupElement(element, elementIndex)
  local idx = tonumber(elementIndex)
  if DataModel.isBatch then
    element.Group_Select.self:SetActive(DataModel.batchList[idx] ~= nil)
  else
    element.Group_Select.self:SetActive(false)
  end
  element.Group_Item.Btn_Item:SetClickParam(idx)
  local row = DataModel.ResetStroeList[idx]
  local data = PlayerData:GetFactoryData(row.id)
  element.Group_Item.Btn_Item.Txt_ItemName:SetText(data.commodityName)
  element.Group_Item.Btn_Item.Img_ResidueNum:SetActive(data.purchase ~= false)
  element.Group_Item.Btn_Item.Img_Sold.self:SetActive(false)
  CommonItem.SetItem(self, element.Group_Item.Btn_Item.Group_Item, {
    id = row.itemId,
    num = row.itemNum
  })
  if data.purchase then
    local textId = 0
    if data.limitBuyType == "Forever" then
      textId = 80600430
    elseif data.limitBuyType == "Daily" then
      textId = 80600798
    elseif data.limitBuyType == "Weekly" then
      textId = 80600800
    elseif data.limitBuyType == "Monthly" then
      textId = 80600801
    end
    local maxNum = DataModel:GetPurchaseNum(data)
    element.Group_Item.Btn_Item.Img_ResidueNum.Txt_ResidueNum:SetText(string.format(GetText(textId), row.residue, maxNum))
    if row.residue == 0 then
      element.Group_Item.Btn_Item.Img_Sold.self:SetActive(true)
    end
  end
  element.Group_Item.Btn_Item.Group_Discount.self:SetActive(0 < data.discountVariable)
  if 0 < data.discountVariable then
    element.Group_Item.Btn_Item.Group_Discount.Txt_Discount:SetText(string.format(GetText(80601651), data.discountVariable))
  end
  local money = data.moneyList[1]
  if money then
    element.Group_Item.Btn_Item.Group_Money.self:SetActive(true)
    local left_money = PlayerData:GetFactoryData(tonumber(data.moneyList[1].moneyID))
    local path = left_money.buyPath
    if path == "" then
      path = left_money.iconPath
    end
    element.Group_Item.Btn_Item.Group_Money.Img_Money:SetSprite(path)
    local moneyNum = data.moneyList[1].moneyNum
    if data.isChange and 0 < data.moneyList[1].correspondPrice then
      local listCA = PlayerData:GetFactoryData(data.moneyList[1].correspondPrice, "ListFactory")
      local buyCount = (row.py_cnt or 0) + 1
      local priceCount = #listCA.priceList
      if buyCount > priceCount then
        buyCount = priceCount
      end
      moneyNum = listCA.priceList[buyCount].num
    end
    element.Group_Item.Btn_Item.Group_Money.Txt_MoneyNum:SetText(moneyNum)
  else
    element.Group_Item.Btn_Item.Group_Money.self:SetActive(false)
  end
  element.Group_Item.Btn_Item.Img_Limit.self:SetActive(false)
  element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Rep:SetActive(false)
  element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Grade:SetActive(false)
  if row.buyLimit then
    if 0 < row.limitRep then
      element.Group_Item.Btn_Item.Img_Limit.self:SetActive(true)
      element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Rep:SetActive(true)
      element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Rep:SetText(string.format(GetText(80601109), row.limitRep))
    end
    if 0 < row.limitGrade then
      element.Group_Item.Btn_Item.Img_Limit.self:SetActive(true)
      element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Grade:SetActive(true)
      element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Grade:SetText(string.format(GetText(80601022), row.limitGrade))
    end
  end
  if DataModel.Shop_Id == DataModel.redPointShopId and DataModel.redPointCommodityIds[row.id] then
    element.Group_Item.Btn_Item.Img_RedPoint:SetActive(row.isRedState)
  else
    element.Group_Item.Btn_Item.Img_RedPoint:SetActive(false)
  end
end

function Controller:ClickResetGroupElemet(btn, str)
  local idx = tonumber(str)
  local row = DataModel.ResetStroeList[idx]
  local redPointInfo = DataModel.redPointCommodityIds[row.id]
  if DataModel.Shop_Id == DataModel.redPointShopId and redPointInfo then
    local key = "BarStoreShopRedPoint|" .. DataModel.Shop_Id .. "|" .. row.id
    if TimeUtil:GetServerTimeStamp() >= PlayerData:GetPlayerPrefs("int", key) then
      local nodeName = RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. DataModel.Shop_Id .. "|" .. row.id
      RedpointTree:ChangeRedpointCnt(nodeName, -1)
      local defaultConfig = DataModel.DefaultConfig
      local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
      local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
      local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
      local nextRefreshTime = 0
      if redPointInfo == 1 then
        nextRefreshTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
      elseif redPointInfo == 2 then
        nextRefreshTime = TimeUtil:GetNextWeekTime(1, h)
      elseif redPointInfo == 3 then
        nextRefreshTime = TimeUtil:GetNextMonthTime(1, h, m, s)
      end
      PlayerData:SetPlayerPrefs("int", key, nextRefreshTime)
    end
  end
  local data = PlayerData:GetFactoryData(row.id)
  if row.isRedState then
    DataModel:UpdateStoreRedState(DataModel.Now_ShopList.id, row.id)
    row.isRedState = false
    View.ScrollGrid_TopButton.grid.self:RefreshAllElement()
    View.Group_RestStore.ScrollGrid_List.grid.self:RefreshAllElement()
  end
  if row.residue == 0 then
    CommonTips.OpenTips(80600077)
    return
  end
  if row.buyLimit then
    CommonTips.OpenTips(80601023)
    return
  end
  View.Btn_BlackMoon.Img_Red:SetActive(DataModel.GetStoreRedState(DataModel.Shop_Id))
  if DataModel.isBatch then
    if row.residue == 0 then
      CommonTips.OpenTips(80608827)
    else
      local data = PlayerData:GetFactoryData(row.id)
      local moneyNum = 0
      if data.moneyList[1] then
        if data.moneyList[1].moneyID ~= 11400001 then
          CommonTips.OpenTips(80611083)
          return
        end
        if data.isChange and 0 < data.moneyList[1].correspondPrice then
          local listCA = PlayerData:GetFactoryData(data.moneyList[1].correspondPrice, "ListFactory")
          local buyCount = (row.py_cnt or 0) + 1
          local priceCount = #listCA.priceList
          if buyCount > priceCount then
            buyCount = priceCount
            moneyNum = row.residue * listCA.priceList[buyCount].num
          else
            local maxBuyCount = row.residue + buyCount - 1
            local minMax = math.min(priceCount, maxBuyCount)
            for i = buyCount, minMax do
              moneyNum = moneyNum + listCA.priceList[i].num
            end
            if priceCount < maxBuyCount then
              moneyNum = moneyNum + (maxBuyCount - priceCount) * listCA.priceList[buyCount].num
            end
          end
        else
          moneyNum = data.moneyList[1].moneyNum * row.residue
        end
      end
      if DataModel.batchList[idx] == nil then
        DataModel.batchList[idx] = row.residue
        DataModel.batchMoney = DataModel.batchMoney + moneyNum
      else
        DataModel.batchList[idx] = nil
        DataModel.batchMoney = DataModel.batchMoney - moneyNum
      end
      Controller:RefreshBatchMoney()
      local element = View.Group_RestStore.ScrollGrid_List.grid.self:GetElementByIndex(idx - 1)
      Controller:SetResetGroupElement(element, idx)
    end
    View.Group_RestStore.Group_PL.Group_SelectAll.Group_Off.self:SetActive(table.count(DataModel.batchList) ~= DataModel.ResetBatchCount)
    View.Group_RestStore.Group_PL.Group_SelectAll.Group_On.self:SetActive(table.count(DataModel.batchList) == DataModel.ResetBatchCount)
    return
  end
  row.shopid = DataModel.Shop_Id
  row.name = data.commodityName
  row.image = data.commodityView
  row.qualityInt = data.qualityInt + 1
  CommonTips.OpenBuyTips(row, function(cnt)
    Controller.OpenStorePage()
  end)
end

function Controller:ResetBatchInfo()
  DataModel.isBatch = false
  DataModel.batchMoney = 0
  DataModel.batchList = {}
  View.Group_RestStore.Btn_PL.Group_On.self:SetActive(DataModel.isBatch)
  View.Group_RestStore.Btn_PL.Group_Off.self:SetActive(not DataModel.isBatch)
  View.Group_RestStore.Group_PL.Group_SelectAll.Group_Off.self:SetActive(true)
  View.Group_RestStore.Group_PL.Group_SelectAll.Group_On.self:SetActive(false)
  Controller:RefreshBatchMoney()
end

function Controller:ClickBatchBtn()
  DataModel.isBatch = not DataModel.isBatch
  DataModel.batchMoney = 0
  if 0 < table.count(DataModel.batchList) then
    View.Group_RestStore.ScrollGrid_List.grid.self:RefreshAllElement()
  end
  DataModel.batchList = {}
  View.Group_RestStore.Btn_PL.Group_On.self:SetActive(DataModel.isBatch)
  View.Group_RestStore.Btn_PL.Group_Off.self:SetActive(not DataModel.isBatch)
  View.Group_RestStore.Group_PL.Group_SelectAll.Group_Off.self:SetActive(true)
  View.Group_RestStore.Group_PL.Group_SelectAll.Group_On.self:SetActive(false)
  Controller:RefreshBatchMoney()
end

function Controller:RefreshBatchMoney()
  View.Group_RestStore.Group_PL.Group_Money.Txt_Num:SetText(DataModel.batchMoney)
  local color = "#FFFFFF"
  if PlayerData:GetGoodsById(11400001).num < DataModel.batchMoney then
    color = "#FF0000"
  end
  View.Group_RestStore.Group_PL.Group_Money.Txt_Num:SetColor(color)
end

function Controller:ClickBatchAll()
  if not DataModel.isBatch then
    Controller:ClickBatchBtn()
  end
  local isRedRefresh = false
  if table.count(DataModel.batchList) == DataModel.ResetBatchCount then
    DataModel.batchList = {}
    DataModel.batchMoney = 0
    View.Group_RestStore.Group_PL.Group_SelectAll.Group_Off.self:SetActive(true)
    View.Group_RestStore.Group_PL.Group_SelectAll.Group_On.self:SetActive(false)
  else
    View.Group_RestStore.Group_PL.Group_SelectAll.Group_Off.self:SetActive(false)
    View.Group_RestStore.Group_PL.Group_SelectAll.Group_On.self:SetActive(true)
    DataModel.batchMoney = 0
    for idx, row in ipairs(DataModel.ResetStroeList) do
      if 0 < row.residue and not row.buyLimit then
        local data = PlayerData:GetFactoryData(row.id)
        local moneyNum = 0
        if data.moneyList[1] and data.moneyList[1].moneyID == 11400001 then
          if data.isChange and 0 < data.moneyList[1].correspondPrice then
            local listCA = PlayerData:GetFactoryData(data.moneyList[1].correspondPrice, "ListFactory")
            local buyCount = (row.py_cnt or 0) + 1
            local priceCount = #listCA.priceList
            if buyCount > priceCount then
              buyCount = priceCount
              moneyNum = row.residue * listCA.priceList[buyCount].num
            else
              local minMax = math.min(priceCount, row.residue)
              for i = buyCount, minMax do
                moneyNum = moneyNum + listCA.priceList[i].num
              end
              if priceCount < row.residue then
                moneyNum = moneyNum + (row.residue - priceCount) * listCA.priceList[buyCount].num
              end
            end
          else
            moneyNum = data.moneyList[1].moneyNum * row.residue
          end
          DataModel.batchList[idx] = row.residue
          DataModel.batchMoney = DataModel.batchMoney + moneyNum
          local redPointInfo = DataModel.redPointCommodityIds[row.id]
          if DataModel.Shop_Id == DataModel.redPointShopId and redPointInfo then
            local key = "BarStoreShopRedPoint|" .. DataModel.Shop_Id .. "|" .. row.id
            if TimeUtil:GetServerTimeStamp() >= PlayerData:GetPlayerPrefs("int", key) then
              local nodeName = RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. DataModel.Shop_Id .. "|" .. row.id
              RedpointTree:ChangeRedpointCnt(nodeName, -1)
              local defaultConfig = DataModel.DefaultConfig
              local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
              local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
              local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
              local nextRefreshTime = 0
              if redPointInfo == 1 then
                nextRefreshTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
              elseif redPointInfo == 2 then
                nextRefreshTime = TimeUtil:GetNextWeekTime(1, h)
              elseif redPointInfo == 3 then
                nextRefreshTime = TimeUtil:GetNextMonthTime(1, h, m, s)
              end
              PlayerData:SetPlayerPrefs("int", key, nextRefreshTime)
              DataModel:UpdateStoreRedState(DataModel.Now_ShopList.id, row.id)
              row.isRedState = false
              isRedRefresh = true
            end
          end
        end
      end
    end
  end
  Controller:RefreshBatchMoney()
  if isRedRefresh then
    View.ScrollGrid_TopButton.grid.self:RefreshAllElement()
  end
  View.Group_RestStore.ScrollGrid_List.grid.self:RefreshAllElement()
end

function Controller:ConfirmBatchBuy()
  if table.count(DataModel.batchList) == 0 then
    CommonTips.OpenTips(80609973)
    return
  end
  if PlayerData:GetGoodsById(11400001).num < DataModel.batchMoney then
    CommonTips.OpenTips(80600539)
    return
  end
  local batchBuyInfo = {}
  for idx, num in pairs(DataModel.batchList) do
    local row = DataModel.ResetStroeList[idx]
    table.insert(batchBuyInfo, row.index - 1 .. "_" .. row.id .. "_" .. num)
  end
  Net:SendProto("shop.buy_list", function(json)
    CommonTips.OpenShowItem(json.reward)
    DataModel.batchList = {}
    DataModel.batchMoney = 0
    DataModel.Now_ShopList.server = PlayerData.ServerData.shops[tostring(DataModel.Now_ShopList.id)]
    DataModel:GetRestStore()
    View.Group_RestStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    View.Group_RestStore.Btn_Record.Txt_Num:SetText(PlayerData:GetGoodsById(11400017).num)
    View.Group_RestStore.Btn_Coin.Txt_Num:SetText(PlayerData:GetGoodsById(11400001).num)
    View.Group_RestStore.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.ResetStroeList))
    View.Group_RestStore.ScrollGrid_List.grid.self:RefreshAllElement()
    Controller:RefreshBatchMoney()
  end, DataModel.Now_ShopList.id, table.concat(batchBuyInfo, ","))
end

function Controller:SetGiftStoreGroupGiftElement(element, elementIndex)
  local row = DataModel.GiftStoreList[tonumber(elementIndex)]
  if row == nil then
    return
  end
  local commoditData = row.commoditData
  row.name = commoditData.name
  row.image = commoditData.iconPath
  row.buyPath = commoditData.buyPath
  local Btn_Item = element.Btn_Item
  local Group_Bottom = Btn_Item.Group_Bottom
  Btn_Item.self:SetClickParam(elementIndex)
  Group_Bottom.Btn_Help:SetClickParam(elementIndex)
  Btn_Item.Img_icon:SetSprite(row.image)
  Group_Bottom.Txt_name:SetText(row.name)
  Group_Bottom.Img_chaozhi:SetActive(false)
  if commoditData.superValue ~= 0 then
    Group_Bottom.Img_chaozhi:SetActive(true)
    Group_Bottom.Img_chaozhi.Txt_shuzhi:SetText(string.format(GetText(80602486), commoditData.superValue))
  end
  Btn_Item.Group_Bottom.Txt_price:SetActive(false)
  Btn_Item.Group_Bottom.Txt_Free:SetActive(false)
  Btn_Item.Group_Bottom.Group_Cost:SetActive(false)
  local isFree = false
  if commoditData.buyType == "Money" then
    if commoditData.value ~= 0 then
      Btn_Item.Group_Bottom.Txt_price:SetActive(true)
      local displayPrice = PayProductHelper.GetProductDisplayPrice(commoditData.id, true)
      Btn_Item.Group_Bottom.Txt_price:SetText(displayPrice)
    else
      isFree = true
    end
  end
  if commoditData.buyType == "Item" then
    if commoditData.buyItemList[1] then
      Btn_Item.Group_Bottom.Group_Cost:SetActive(true)
      Btn_Item.Group_Bottom.Group_Cost.Img_Icon:SetSprite(PlayerData:GetFactoryData(commoditData.buyItemList[1].id).buyPath)
      Btn_Item.Group_Bottom.Group_Cost.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(commoditData.buyItemList[1].num, 2))
    else
      isFree = true
    end
  end
  if isFree == true then
    Btn_Item.Group_Bottom.Txt_Free:SetActive(true)
  end
  row.isFree = isFree
  Btn_Item.Group_Bottom.Group_Empty:SetActive(false)
  Btn_Item.Group_Bottom.Group_LimitNum:SetActive(false)
  Btn_Item.Group_Bottom.Group_LimitTime:SetActive(false)
  Btn_Item.Group_Bottom.Group_GradeLimit:SetActive(false)
  Btn_Item.Group_Bottom.Group_residueTime:SetActive(false)
  row.isMax = false
  if commoditData.purchase == true then
    local typeTxtId = DataModel.PurchaseTypeList(commoditData.limitBuyType)
    local maxNum = DataModel:GetPurchaseNum(commoditData)
    if typeTxtId ~= nil then
      Btn_Item.Group_Bottom.Group_LimitNum:SetActive(true)
      Btn_Item.Group_Bottom.Group_LimitNum.Txt_LimitNum:SetText(string.format(GetText(typeTxtId), math.max(maxNum - row.num, 0), maxNum))
      if maxNum <= row.num then
        row.isMax = true
        Btn_Item.Group_Bottom.Group_Empty:SetActive(true)
      end
    end
  end
  Btn_Item.Group_Bottom.Group_LimitTime:SetActive(0 < row.endTime)
  local time = TimeUtil:SecondToTable(row.endTime)
  Btn_Item.Group_Bottom.Group_LimitTime.Txt_Time:SetText(string.format(GetText(80601059), time.day, time.hour))
  if commoditData.isBuyCondition == true and PlayerData:GetUserInfo().lv < commoditData.gradeCondition then
    Btn_Item.Group_Bottom.Group_GradeLimit:SetActive(true)
    Btn_Item.Group_Bottom.Group_GradeLimit.Txt_Grade:SetText(string.format(GetText(80601022), commoditData.gradeCondition))
    row.isLock = true
  end
  Btn_Item.Group_Bottom.Btn_Help:SetActive(false)
  Btn_Item.Group_Bottom.Group_residueTime:SetActive(false)
  if commoditData.ismonthCard == true then
    Btn_Item.Group_Bottom.Btn_Help:SetActive(true)
    if PlayerData.ServerData.monthly_card and PlayerData.ServerData.monthly_card["11400018"] then
      local t = PlayerData.ServerData.monthly_card["11400018"]
      local diff = 0
      local curServerTime = TimeUtil:GetServerTimeStamp()
      local timeTable = TimeUtil:GetLogicServerDayTable(curServerTime)
      local year = timeTable.year
      local month = timeTable.month
      local day = timeTable.day
      local curDayStamp = os.time({
        year = year,
        month = month,
        day = day,
        hour = 5,
        minute = 0,
        second = 0
      }) + TimeUtil:GetLocalTimeZone() * 3600
      diff = t.deadline - curDayStamp
      if 0 < diff then
        local time = TimeUtil:SecondToTable(diff)
        Btn_Item.Group_Bottom.Group_residueTime:SetActive(true)
        Btn_Item.Group_Bottom.Group_residueTime.Txt_residueTime:SetText(string.format(GetText(80601102), time.day))
      end
    end
  end
  Btn_Item.Img_RedPoint:SetActive(row.isRedState)
  Group_Bottom.Group_Normal.self:SetActive(commoditData.isText and commoditData.showType == "Normal")
  Group_Bottom.Group_Awake.self:SetActive(commoditData.isText and commoditData.showType == "Awake")
  if Group_Bottom.Group_Normal.self.IsActive then
    Group_Bottom.Group_Normal.Txt_Title:SetText(GetText(commoditData.title))
    Group_Bottom.Group_Normal.Txt_Dec:SetText(GetText(commoditData.des))
    Group_Bottom.Group_Normal.Txt_Dec:SetColor(commoditData.desColor)
  end
  if Group_Bottom.Group_Awake.self.IsActive then
    Group_Bottom.Group_Awake.Txt_Title:SetText(GetText(commoditData.title))
    Group_Bottom.Group_Awake.Txt_Dec:SetText(GetText(commoditData.des))
    if commoditData.correspondCharacter > -1 then
      local name = PlayerData:GetFactoryData(commoditData.correspondCharacter).name
      Group_Bottom.Group_Awake.Txt_Dec:SetText(string.format(GetText(commoditData.des), name))
    end
    Group_Bottom.Group_Awake.Txt_Dec:SetColor(commoditData.desColor)
  end
  Btn_Item.Group_Bottom.Img_HuaBuy:SetActive(commoditData.isHuaBuy == true)
  Btn_Item.Group_Bottom.Img_HuaBuy:SetSprite(GetResPath(88300101))
end

function Controller:ClickGiftStoreGroupGiftElement(btn, str)
  local row = DataModel.GiftStoreList[tonumber(str)]
  local commoditData = row.commoditData
  if row.isLock then
    CommonTips.OpenTips(80601023)
    return
  end
  if row.isMax then
    CommonTips.OpenTips(80600077)
    return
  end
  if DataModel:ShopIsActive(row.id) == false then
    local function refersh()
      Net:SendProto("shop.info", function(json)
        View.Group_GiftStore.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.GiftStoreList))
        
        View.Group_GiftStore.NewScrollGrid_List.grid.self:RefreshAllElement()
        View.Group_GiftStore.NewScrollGrid_List.grid.self:MoveToTop()
      end)
    end
    
    CommonTips.OnPrompt(80601523, nil, nil, refersh)
    return
  end
  local params = {}
  params.name = row.name
  params.num = row.num
  params.weight = row.weight
  params.image = row.image
  params.id = row.id
  params.isFree = row.isFree
  params.isMoveEnergyOpen = DataModel.isMoveEnergyOpen
  
  local function callback()
    if DataModel:ShopIsActive(row.id) == false then
      local function refersh()
        Net:SendProto("shop.info", function(json)
          View.Group_GiftStore.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.GiftStoreList))
          
          View.Group_GiftStore.NewScrollGrid_List.grid.self:RefreshAllElement()
          View.Group_GiftStore.NewScrollGrid_List.grid.self:MoveToTop()
        end)
      end
      
      CommonTips.OnPrompt(80601523, nil, nil, refersh)
      return
    end
    local metaId = tostring(row.id)
    local shopId = DataModel.Shop_Id
    local name = row.commoditData.name
    local payAmount = row.commoditData.value
    local priceStr = PayProductHelper.GetProductDisplayPrice(metaId, true)
    local uiParams = Json.encode({
      name = name,
      price = priceStr,
      itemId = metaId,
      shopId = shopId,
      payAmount = payAmount
    })
    PayHelper.Buy(metaId, function(json)
      CommonTips.OpenShowItem(json.reward)
      local list = {}
      local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
      list.num = 1
      list.last_auto_refresh = TimeUtil:GetServerTimeStamp()
      if recharge then
        if recharge[tostring(row.id)] then
          local num = recharge[tostring(row.id)].num + 1
          list.num = num
          recharge[tostring(row.id)].num = num
        else
          recharge[tostring(row.id)] = list
        end
      else
        PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)] = {}
        PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)][tostring(row.id)] = list
      end
      Controller.OpenStorePage()
      if DataModel.isMoveEnergyOpen then
        UIManager:GoBack()
      end
    end, uiParams)
  end
  
  CommonTips.OnBuyGiftTips(params, callback)
  if row.commoditData.isRedPoint and PlayerData:GetPlayerPrefs("int", "StoreRed" .. row.id) == 0 then
    DataModel:UpdateStoreRedState(DataModel.Now_ShopList.id, row.id)
    row.isRedState = false
    if DataModel.isTabGiftSequence then
      local row_c = DataModel.GiftStoreListLabel[DataModel.GiftTopIndex]
      row_c.redCount = row_c.redCount - 1
      row_c.redCount = 0 > row_c.redCount and 0 or row_c.redCount
      View.Group_GiftStore.Group_Label.NewScrollGrid_List.grid.self:RefreshAllElement()
    end
    View.Group_GiftStore.NewScrollGrid_List.grid.self:RefreshAllElement()
    View.ScrollGrid_TopButton.grid.self:RefreshAllElement()
  end
  PlayerData:SetPlayerPrefs("int", "StoreRed" .. row.id, 1)
end

function Controller:SetSkinPreStoreGroupNewGiftElement(element, elementIndex)
  local row = DataModel.SkinPreStore[tonumber(elementIndex)]
  local commoditData = row.commoditData
  row.name = commoditData.name
  row.image = commoditData.iconPath
  row.buyPath = commoditData.buyPath
  local Btn_Item = element.Btn_Item
  local Group_Bottom = Btn_Item.Group_Bottom
  Btn_Item.self:SetClickParam(elementIndex)
  Group_Bottom.Btn_Help:SetClickParam(elementIndex)
  Btn_Item.Img_icon:SetSprite(row.image)
  Group_Bottom.Txt_name:SetText(row.name)
  Group_Bottom.Img_chaozhi:SetActive(false)
  if commoditData.superValue ~= 0 then
    Group_Bottom.Img_chaozhi:SetActive(true)
    Group_Bottom.Img_chaozhi.Txt_shuzhi:SetText(string.format(GetText(80602486), commoditData.superValue))
  end
  Btn_Item.Group_Bottom.Txt_price:SetActive(false)
  Btn_Item.Group_Bottom.Txt_Free:SetActive(false)
  Btn_Item.Group_Bottom.Group_Cost:SetActive(false)
  local isFree = false
  if commoditData.buyType == "Money" then
    if commoditData.value ~= 0 then
      Btn_Item.Group_Bottom.Txt_price:SetActive(true)
      local displayPrice = PayProductHelper.GetProductDisplayPrice(commoditData.id, true)
      Btn_Item.Group_Bottom.Txt_price:SetText(displayPrice)
    else
      isFree = true
    end
  end
  if commoditData.buyType == "Item" then
    if commoditData.buyItemList[1] then
      Btn_Item.Group_Bottom.Group_Cost:SetActive(true)
      Btn_Item.Group_Bottom.Group_Cost.Img_Icon:SetSprite(PlayerData:GetFactoryData(commoditData.buyItemList[1].id).buyPath)
      Btn_Item.Group_Bottom.Group_Cost.Txt_Num:SetText(PlayerData:GetPreciseDecimalFloor(commoditData.buyItemList[1].num, 2))
    else
      isFree = true
    end
  end
  if isFree == true then
    Btn_Item.Group_Bottom.Txt_Free:SetActive(true)
  end
  row.isFree = isFree
  Btn_Item.Group_Bottom.Group_Empty:SetActive(false)
  Btn_Item.Group_Bottom.Group_LimitNum:SetActive(false)
  Btn_Item.Group_Bottom.Group_LimitTime:SetActive(false)
  Btn_Item.Group_Bottom.Group_GradeLimit:SetActive(false)
  Btn_Item.Group_Bottom.Group_residueTime:SetActive(false)
  row.isMax = false
  if commoditData.purchase == true then
    local typeTxtId = DataModel.PurchaseTypeList(commoditData.limitBuyType)
    local maxNum = DataModel:GetPurchaseNum(commoditData)
    if typeTxtId ~= nil then
      Btn_Item.Group_Bottom.Group_LimitNum:SetActive(true)
      Btn_Item.Group_Bottom.Group_LimitNum.Txt_LimitNum:SetText(string.format(GetText(typeTxtId), math.max(maxNum - row.num, 0), maxNum))
      if maxNum <= row.num then
        row.isMax = true
        Btn_Item.Group_Bottom.Group_Empty:SetActive(true)
      end
    end
  end
  if commoditData.isTriggerTime then
    local continueTime = commoditData.continueTime
    local endTime = DataModel.GetStoreFirstLoginTime() + continueTime * 3600 - TimeUtil:GetServerTimeStamp()
    if 0 < endTime then
      local time = TimeUtil:SecondToTable(endTime)
      Btn_Item.Group_Bottom.Group_LimitTime:SetActive(true)
      Btn_Item.Group_Bottom.Group_LimitTime.Txt_Time:SetText(string.format(GetText(80601059), time.day, time.hour))
    end
  elseif commoditData.isTime == true then
    local lastTime = TimeUtil:LastTime(commoditData.endTime)
    if 0 < lastTime then
      local time = TimeUtil:SecondToTable(lastTime)
      Btn_Item.Group_Bottom.Group_LimitTime:SetActive(true)
      Btn_Item.Group_Bottom.Group_LimitTime.Txt_Time:SetText(string.format(GetText(80601059), time.day, time.hour))
    end
  end
  if commoditData.isBuyCondition == true and PlayerData:GetUserInfo().lv < commoditData.gradeCondition then
    Btn_Item.Group_Bottom.Group_GradeLimit:SetActive(true)
    Btn_Item.Group_Bottom.Group_GradeLimit.Txt_Grade:SetText(string.format(GetText(80601022), commoditData.gradeCondition))
    row.isLock = true
  end
  local haveDiamond = false
  local diamondNum = 0
  if 0 < table.count(commoditData.rewardList) then
    for k, v in pairs(commoditData.rewardList) do
      if v.id == 11400005 then
        haveDiamond = true
        diamondNum = v.num
        break
      end
    end
  end
  Group_Bottom.Group_Extra:SetActive(haveDiamond)
  if haveDiamond then
    Group_Bottom.Group_Extra.Txt_Num:SetText(string.format(GetText(80607589), diamondNum))
  end
  Btn_Item.Group_Bottom.Btn_Help:SetActive(false)
  Btn_Item.Group_Bottom.Group_residueTime:SetActive(false)
  Btn_Item.Img_RedPoint:SetActive(row.isRedState)
  if row.skinHomeSkillId then
    Btn_Item.Group_Bottom.Group_HomeSkill.Img_Des.Txt_Des:SetText(row.skinHomeSkillDesc)
  end
  Btn_Item.Group_Bottom.Group_HomeSkill.self:SetActive(row.skinHomeSkillId ~= nil)
  Btn_Item.Group_Bottom.Img_HuaBuy:SetActive(commoditData.isHuaBuy == true)
  Btn_Item.Group_Bottom.Img_HuaBuy:SetSprite(GetResPath(88300101))
end

function Controller:ClickSkinPreStoreGroupNewGiftElement(btn, str)
  local row = DataModel.SkinPreStore[tonumber(str)]
  if row.isLock then
    CommonTips.OpenTips(80601023)
    return
  end
  if row.isMax then
    CommonTips.OpenTips(80600077)
    return
  end
  local params = {}
  params.name = row.name
  params.commoditData = row.commoditData
  params.num = row.num
  params.weight = row.weight
  params.image = row.image
  params.id = row.id
  params.isFree = row.isFree
  params.isMoveEnergyOpen = DataModel.isMoveEnergyOpen
  params.skinHomeSkillId = row.skinHomeSkillId
  params.skinHomeSkillDesc = row.skinHomeSkillDesc
  
  local function callback()
    local metaId = tostring(row.id)
    local shopId = DataModel.Shop_Id
    local name = row.commoditData.name
    local payAmount = row.commoditData.value
    local priceStr = PayProductHelper.GetProductDisplayPrice(metaId, true)
    local uiParams = Json.encode({
      name = name,
      price = priceStr,
      itemId = metaId,
      shopId = shopId,
      payAmount = payAmount
    })
    PayHelper.Buy(metaId, function(json)
      CommonTips.OpenShowItem(json.reward)
      local list = {}
      local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
      list.num = 1
      if recharge then
        if recharge[tostring(row.id)] then
          local num = recharge[tostring(row.id)].num + 1
          list.num = num
          recharge[tostring(row.id)].num = num
        else
          recharge[tostring(row.id)] = list
        end
      else
        PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)] = {}
        PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)][tostring(row.id)] = list
      end
      Controller.OpenStorePage()
      if DataModel.isMoveEnergyOpen then
        UIManager:GoBack()
      end
    end, uiParams)
  end
  
  CommonTips.OnBuyGiftTips(params, callback)
  if row.commoditData.isRedPoint and PlayerData:GetPlayerPrefs("int", "StoreRed" .. row.id) == 0 then
    DataModel:UpdateStoreRedState(DataModel.Now_ShopList.id, row.id)
    row.isRedState = false
    if DataModel.isTabSkinSequence then
      local row_c = DataModel.SkinPreStoreLabel[DataModel.SkinTopIndex]
      row_c.redCount = row_c.redCount - 1
      row_c.redCount = 0 > row_c.redCount and 0 or row_c.redCount
      View.Group_SkinPreStore.Group_Label.NewScrollGrid_List.grid.self:RefreshAllElement()
    end
    View.Group_SkinPreStore.NewScrollGrid_List.grid.self:RefreshAllElement()
    View.ScrollGrid_TopButton.grid.self:RefreshAllElement()
  end
  PlayerData:SetPlayerPrefs("int", "StoreRed" .. row.id, 1)
end

function Controller:SetGroupGiftGroupLabelElement(element, elementIndex)
  local row = DataModel.GiftStoreListLabel[elementIndex]
  element.Img_Off:SetActive(true)
  element.Img_Off.Img_Icon:SetSprite(row.icon)
  element.Img_Off.Txt_Name:SetText(GetText(row.name))
  element.Img_On:SetActive(false)
  element.Img_On.Img_Icon:SetSprite(row.icon)
  element.Img_On.Txt_Name:SetText(GetText(row.name))
  element.Btn_:SetClickParam(elementIndex)
  if DataModel.GiftTopIndex and tonumber(elementIndex) == DataModel.GiftTopIndex then
    element.Img_On:SetActive(true)
  end
  element.Img_RedPoint:SetActive(row.redCount > 0)
end

function Controller:ClickGroupGiftGroupLabelElement(index, compel)
  index = tonumber(index)
  if compel == nil and index and index == DataModel.GiftTopIndex then
    return
  end
  DataModel.GiftTopIndex = index
  View.Group_GiftStore.Group_Label.NewScrollGrid_List.grid.self:RefreshAllElement()
  DataModel:GetGiftLabelList(index)
  if DataModel.isFirstGiftStore == true then
    View.Group_GiftStore.NewScrollGrid_List.grid.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      View.Group_GiftStore.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.GiftStoreList))
      View.Group_GiftStore.NewScrollGrid_List.grid.self:RefreshAllElement()
      View.Group_GiftStore.NewScrollGrid_List.grid.self:MoveToTop()
      View.Group_GiftStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    end))
    DataModel.isFirstGiftStore = false
  else
    View.Group_GiftStore.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.GiftStoreList))
    View.Group_GiftStore.NewScrollGrid_List.grid.self:RefreshAllElement()
    View.Group_GiftStore.NewScrollGrid_List.grid.self:MoveToTop()
    View.Group_GiftStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
  end
end

function Controller:SetGroupSkinLabelElement(element, elementIndex)
  local row = DataModel.SkinPreStoreLabel[elementIndex]
  element.Img_Off:SetActive(true)
  element.Img_Off.Img_Icon:SetSprite(row.icon)
  element.Img_Off.Txt_Name:SetText(GetText(row.name))
  element.Img_On:SetActive(false)
  element.Img_On.Img_Icon:SetSprite(row.icon)
  element.Img_On.Txt_Name:SetText(GetText(row.name))
  element.Btn_:SetClickParam(elementIndex)
  if DataModel.SkinTopIndex and tonumber(elementIndex) == DataModel.SkinTopIndex then
    element.Img_On:SetActive(true)
  end
  element.Img_RedPoint:SetActive(row.redCount > 0)
end

function Controller:ClickGroupSkinLabelElement(index, compel)
  index = tonumber(index)
  if compel == nil and index and index == DataModel.SkinTopIndex then
    return
  end
  DataModel.SkinTopIndex = index
  View.Group_SkinPreStore.Group_Label.NewScrollGrid_List.grid.self:RefreshAllElement()
  DataModel:GetSkinPreLabelList(index)
  if DataModel.isFirstSkinPreStore == true then
    View.Group_SkinPreStore.NewScrollGrid_List.grid.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      View.Group_SkinPreStore.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.SkinPreStore))
      View.Group_SkinPreStore.NewScrollGrid_List.grid.self:RefreshAllElement()
      View.Group_SkinPreStore.NewScrollGrid_List.grid.self:MoveToTop()
      View.Group_SkinPreStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    end))
    DataModel.isFirstSkinPreStore = false
  else
    View.Group_SkinPreStore.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.SkinPreStore))
    View.Group_SkinPreStore.NewScrollGrid_List.grid.self:RefreshAllElement()
    View.Group_SkinPreStore.NewScrollGrid_List.grid.self:MoveToTop()
    View.Group_SkinPreStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
  end
end

function Controller.InitTopList()
  View.ScrollGrid_TopButton.self:SetActive(true)
  View.ScrollGrid_TopButton.grid.self:SetDataCount(table.count(DataModel.mainStoreList))
  View.ScrollGrid_TopButton.grid.self:RefreshAllElement()
  View.ScrollGrid_TopButton.grid.self:MoveToTop()
  Controller.ChooseTopList(DataModel.TopIndex)
end

function Controller.ChooseTopList(index)
  if index == nil or index == "" then
    return
  end
  if index == DataModel.TopIndex and DataModel.RefreshState == 0 then
    return
  end
  View.ScrollGrid_TopButton.grid.self:MoveToPos(index or 1)
  DataModel.RefreshState = 0
  local row = DataModel.mainStoreList[tonumber(index)]
  if DataModel.TopIndex ~= nil then
    local old_element = View.ScrollGrid_TopButton.grid.self:GetElementByIndex(DataModel.TopIndex - 1)
    if old_element then
      old_element.Btn_Top.Img_pitchon:SetActive(false)
    end
  end
  DataModel.TopIndex = tonumber(index)
  local element = View.ScrollGrid_TopButton.grid.self:GetElementByIndex(DataModel.TopIndex - 1)
  if element then
    element.Btn_Top.Img_pitchon:SetActive(true)
  end
  View.StaticGrid_RightButton.self:SetActive(false)
  if DataModel.Now_ShopList then
    View[DataModel.Now_ShopList.showUI]:SetActive(false)
  end
  if table.count(row.ca.mainStoreList) == 1 then
    DataModel.Shop_Id = PlayerData:GetFactoryData(row.ca.mainStoreList[1].id).id
    DataModel.Now_ShopList = {}
    DataModel.Now_ShopList = PlayerData:GetFactoryData(row.ca.mainStoreList[1].id)
    DataModel.Now_ShopList.shopList = PlayerData:GetFactoryData(row.ca.mainStoreList[1].id).shopList
    DataModel.Now_ShopList.server = PlayerData.ServerData.shops[tostring(40300008)]
    Controller.OpenStorePage()
  end
end

function Controller.ShowPurchaseRole(data, index)
  local shopCA = PlayerData:GetFactoryData(data.id)
  local itemCA = PlayerData:GetFactoryData(shopCA.commodityItemList[1].id)
  local viewCA = PlayerData:GetFactoryData(itemCA.viewId)
  View.Group_RoleStore.Group_TimeCommodity.Group_Role.SpineAnimation_Character:SetData(viewCA.spineUrl)
  View.Group_RoleStore.Group_TimeCommodity.Group_Role.SpineAnimation_Character.transform.localPosition = Vector3(-80, -900, 0)
  View.Group_RoleStore.Group_TimeCommodity.Group_Role.Group_Character.Sprite_Character:SetActive(false)
  local lastTime = TimeUtil:LastTime(shopCA.endTime)
  local time = TimeUtil:SecondToTable(lastTime)
  DataModel.Choose_Purchase_Role = {}
  DataModel.Choose_Purchase_Role.index = index
  DataModel.Choose_Purchase_Role.id = data.id
  DataModel.Choose_Purchase_Role.shopCA = shopCA
  View.Group_RoleStore.Group_TimeCommodity.Group_Time.Txt_Time:SetText(TimeUtil:GetGachaDesc(time))
  View.Group_RoleStore.Group_TimeCommodity.Btn_Buy.Txt_Num:SetText(shopCA.moneyList[1].moneyNum)
  local left_money = PlayerData:GetFactoryData(tonumber(shopCA.moneyList[1].moneyID))
  View.Group_RoleStore.Group_TimeCommodity.Btn_Buy.Img_Money:SetSprite(left_money.iconPath)
  local roleCA = PlayerData:GetFactoryData(shopCA.commodityItemList[1].id)
  local Group_SkillColor = View.Group_RoleStore.Group_TimeCommodity.Group_Role.Group_SkillColor
  Group_SkillColor.self:SetActive(true)
  local cardList = PlayerData:GetRoleCardList(roleCA.id)
  for i = 1, table.count(cardList) do
    local obj = "Group_SkillColor" .. i
    local cardCA = PlayerData:GetFactoryData(cardList[table.count(cardList) - i + 1].id)
    local color = cardCA.color
    Group_SkillColor[obj].Img_Color:SetSprite(UIConfig.CharacterSkillColor[color])
  end
  local Group_Locate = View.Group_RoleStore.Group_TimeCommodity.Group_Role.Group_SkillColor.Group_Locate
  Group_Locate.Img_Line:SetSprite(UIConfig.CharacterLine[roleCA.line])
end

function Controller.OpenStorePage()
  if DataModel.Now_ShopList == nil or DataModel.Now_ShopList.showUI == nil then
    Debug.Log("[\229\149\134\229\186\151\229\188\130\229\184\184]UIStoreDataController--OpenStorePage() return:DataModel.Now_ShopList == nil or DataModel.Now_ShopList.showUI == nil")
    return
  end
  View[DataModel.Now_ShopList.showUI]:SetActive(true)
  if DataModel.Now_ShopList.showUI == "Group_DiamondStore" then
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_DiamondStore")
    for k, v in pairs(DataModel.Now_ShopList.shopList) do
      v.num = 0
      if PlayerData.RechargeGoods ~= nil then
        local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
        if recharge and recharge[tostring(v.id)] then
          local num = recharge[tostring(v.id)].num
          v.num = num
        end
      end
    end
    View.Group_DiamondStore.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.Now_ShopList.shopList))
    View.Group_DiamondStore.ScrollGrid_List.grid.self:RefreshAllElement()
    View.Group_DiamondStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
  end
  if DataModel.Now_ShopList.showUI == "Group_RoleStore" then
    DataModel.RoleStoreList = {}
    local count = 1
    for k, v in pairs(DataModel.Now_ShopList.shopList) do
      local ca = PlayerData:GetFactoryData(v.id)
      if ca.isTime and ca.isTime == true then
        if ca.startTime ~= "" and TimeUtil:IsActive(ca.startTime, ca.endTime) then
          Controller.ShowPurchaseRole(v, k)
        end
      else
        DataModel.RoleStoreList[count] = v
        DataModel.RoleStoreList[count].index = k
        DataModel.RoleStoreList[count].server = {}
        if PlayerData.ServerData.shops[tostring(DataModel.Shop_Id)] then
          for c, d in pairs(PlayerData.ServerData.shops[tostring(DataModel.Shop_Id)].items) do
            if tonumber(d.id) == tonumber(v.id) then
              DataModel.RoleStoreList[count].server = d
            end
          end
        end
        count = count + 1
      end
    end
    View.Group_RoleStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400017).num)
    View.Group_RoleStore.StaticGrid_List.grid.self:SetDataCount(table.count(DataModel.RoleStoreList))
    View.Group_RoleStore.StaticGrid_List.grid.self:RefreshAllElement()
  end
  DataModel.isFirstGiftStoreLabel = true
  DataModel.isFirstGiftStore = true
  if DataModel.Now_ShopList.showUI == "Group_GiftStore" then
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_GiftStore")
    DataModel:GetAllGiftList()
    View.Group_GiftStore.Group_Label.self:SetActive(DataModel.isTabGiftSequence)
    local element = View.ScrollGrid_TopButton.grid.self:GetElementByIndex(DataModel.TopIndex - 1)
    element.Btn_Top.Img_RedPoint:SetActive(DataModel.GetStoreRedState(DataModel.Shop_Id))
    if DataModel.isTabGiftSequence then
      if DataModel.isFirstGiftStoreLabel == true then
        View.Group_GiftStore.Group_Label.NewScrollGrid_List.grid.self:StartC(LuaUtil.cs_generator(function()
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          View.Group_GiftStore.Group_Label.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.GiftStoreListLabel))
          View.Group_GiftStore.Group_Label.NewScrollGrid_List.grid.self:RefreshAllElement()
          View.Group_GiftStore.Group_Label.NewScrollGrid_List.grid.self:MoveToTop()
          Controller:ClickGroupGiftGroupLabelElement(DataModel.GiftTopIndex or 1, true)
        end))
        DataModel.isFirstGiftStoreLabel = false
      else
        View.Group_GiftStore.Group_Label.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.GiftStoreListLabel))
        View.Group_GiftStore.Group_Label.NewScrollGrid_List.grid.self:RefreshAllElement()
        View.Group_GiftStore.Group_Label.NewScrollGrid_List.grid.self:MoveToTop()
        Controller:ClickGroupGiftGroupLabelElement(DataModel.GiftTopIndex or 1, true)
      end
    else
      DataModel:GetGiftList()
      if DataModel.isFirstGiftStore == true then
        View.Group_GiftStore.NewScrollGrid_List.grid.self:StartC(LuaUtil.cs_generator(function()
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          View.Group_GiftStore.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.GiftStoreList))
          View.Group_GiftStore.NewScrollGrid_List.grid.self:RefreshAllElement()
          View.Group_GiftStore.NewScrollGrid_List.grid.self:MoveToTop()
          View.Group_GiftStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
        end))
        DataModel.isFirstGiftStore = false
      else
        View.Group_GiftStore.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.GiftStoreList))
        View.Group_GiftStore.NewScrollGrid_List.grid.self:RefreshAllElement()
        View.Group_GiftStore.NewScrollGrid_List.grid.self:MoveToTop()
        View.Group_GiftStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
      end
    end
  end
  DataModel.isFirstSkinPreStore = true
  DataModel.isFirstSkinPreStoreLabel = true
  if DataModel.Now_ShopList.showUI == "Group_SkinPreStore" then
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_SkinPreStore")
    DataModel:GetAllSkinPreList()
    View.Group_SkinPreStore.Group_Label.self:SetActive(DataModel.isTabSkinSequence)
    if DataModel.isTabSkinSequence then
      if DataModel.isFirstSkinPreStoreLabel == true then
        View.Group_SkinPreStore.Group_Label.NewScrollGrid_List.grid.self:StartC(LuaUtil.cs_generator(function()
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          View.Group_SkinPreStore.Group_Label.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.SkinPreStoreLabel))
          View.Group_SkinPreStore.Group_Label.NewScrollGrid_List.grid.self:RefreshAllElement()
          View.Group_SkinPreStore.Group_Label.NewScrollGrid_List.grid.self:MoveToTop()
          Controller:ClickGroupSkinLabelElement(DataModel.SkinTopIndex or 1, true)
        end))
        DataModel.isFirstSkinPreStoreLabel = false
      else
        View.Group_SkinPreStore.Group_Label.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.SkinPreStoreLabel))
        View.Group_SkinPreStore.Group_Label.NewScrollGrid_List.grid.self:RefreshAllElement()
        View.Group_SkinPreStore.Group_Label.NewScrollGrid_List.grid.self:MoveToTop()
        Controller:ClickGroupSkinLabelElement(DataModel.SkinTopIndex or 1, true)
      end
    else
      DataModel:GetSkinPreList()
      if DataModel.isFirstSkinPreStore == true then
        View.Group_SkinPreStore.NewScrollGrid_List.grid.self:StartC(LuaUtil.cs_generator(function()
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          View.Group_SkinPreStore.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.SkinPreStore))
          View.Group_SkinPreStore.NewScrollGrid_List.grid.self:RefreshAllElement()
          View.Group_SkinPreStore.NewScrollGrid_List.grid.self:MoveToTop()
          View.Group_SkinPreStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
        end))
        DataModel.isFirstSkinPreStore = false
      else
        View.Group_SkinPreStore.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.SkinPreStore))
        View.Group_SkinPreStore.NewScrollGrid_List.grid.self:RefreshAllElement()
        View.Group_SkinPreStore.NewScrollGrid_List.grid.self:MoveToTop()
        View.Group_SkinPreStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
      end
    end
  end
  if DataModel.Now_ShopList.showUI == "Group_RecommendStore" then
    DataModel.RecommendList = {}
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_RecommendStore")
    for k, v in pairs(DataModel.Now_ShopList.recommendList) do
      if v.funcId then
        local commoditData = PlayerData:GetFactoryData(v.id) or {}
        local row = {}
        for c, d in pairs(v) do
          row[c] = d
        end
        row.commoditData = commoditData
        row.isMax = false
        local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
        row.num = 0
        if recharge and recharge[tostring(v.id)] then
          local num = recharge[tostring(v.id)].num
          row.num = num
        end
        if commoditData.purchase == true then
          local typeTxtId = DataModel.PurchaseTypeList(commoditData.limitBuyType)
          local maxNum = DataModel:GetPurchaseNum(commoditData)
          if typeTxtId ~= nil and maxNum <= row.num then
            row.isMax = true
          end
        end
        row.isLock = false
        if commoditData.isBuyCondition == true and PlayerData:GetUserInfo().lv < commoditData.gradeCondition then
          row.isLock = true
        end
        local isAdd = false
        local isStoreOpen = true
        if v.storeId == 80307398 then
          isStoreOpen = DataModel.GetStoreIsOpened(v.storeId)
        end
        if v.funcId ~= -1 then
          local funcCommon = require("Common/FuncCommon")
          local isUnlock = funcCommon.FuncActiveCheck(v.funcId, false)
          if isUnlock == true and isStoreOpen == true then
            table.insert(DataModel.RecommendList, row)
            isAdd = true
          end
        elseif isStoreOpen == true then
          table.insert(DataModel.RecommendList, row)
          isAdd = true
        end
        if row.isBattlePass then
          local isOpen, battleId = PlayerData:GetNowPassData()
          if battleId then
            local battlePassCA = PlayerData:GetFactoryData(battleId)
            row.png = battlePassCA.recommendStoreImg
            row.tabPng = battlePassCA.recommendStoreTabImg
            row.name = battlePassCA.topicName
          end
          if isOpen == false and isAdd then
            table.remove(DataModel.RecommendList, table.count(DataModel.RecommendList))
          end
        end
      end
    end
    View.Group_RecommendStore.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.RecommendList))
    View.Group_RecommendStore.ScrollGrid_List.grid.self:RefreshAllElement()
    View.Group_RecommendStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
    DataModel.RecommedIndex = nil
    DataModel.ChooseRecommedStore(1)
  end
  if DataModel.Now_ShopList.showUI == "Group_RestStore" then
    local function refresh()
      UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_RestStore")
      
      DataModel:GetRestStore()
      Controller:ResetBatchInfo()
      View.Group_RestStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
      View.Group_RestStore.Btn_Record.Txt_Num:SetText(PlayerData:GetGoodsById(11400017).num)
      View.Group_RestStore.Btn_Coin.Txt_Num:SetText(PlayerData:GetGoodsById(11400001).num)
      View.Group_RestStore.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.ResetStroeList))
      View.Group_RestStore.ScrollGrid_List.grid.self:RefreshAllElement()
    end
    
    if PlayerData.ServerData.shops[tostring(DataModel.Shop_Id)] ~= nil then
      refresh()
    else
      Net:SendProto("shop.info", function(json)
        refresh()
      end, DataModel.Shop_Id)
    end
    View.Btn_BlackMoon.Img_Red:SetActive(DataModel.GetStoreRedState(DataModel.Shop_Id))
  end
  if DataModel.Now_ShopList.showUI == "Group_Exchange" then
    local function refresh()
      UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_Exchange")
      
      DataModel:GetExchangeData()
      View.Group_Exchange.Group_Middle.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.ExchangeStoreList))
      View.Group_Exchange.Group_Middle.ScrollGrid_List.grid.self:RefreshAllElement()
      View.Group_Exchange.Group_Middle.ScrollGrid_List.grid.self:MoveToTop()
    end
    
    if PlayerData.ServerData.shops[tostring(DataModel.Shop_Id)] ~= nil then
      refresh()
    else
      Net:SendProto("shop.info", function(json)
        refresh()
      end, DataModel.Shop_Id)
    end
  end
  if DataModel.Now_ShopList.showUI == "Group_SignGift" then
    UIManager:LoadSplitPrefab(View, "UI/Store/Store", "Group_SignGift")
    if DataModel.Now_ShopList.shopList and DataModel.Now_ShopList.shopList[1] then
      require("UIStore/UIStoreController_SignGift").InitContentShow(DataModel.Now_ShopList.shopList[1].id)
    end
  end
end

function Controller:SetGroupConsume(groupConsume, moneyData, elementIndex)
  local moneyCA = PlayerData:GetFactoryData(moneyData.moneyID)
  groupConsume.Group_Item.Img_Item:SetSprite(moneyCA.iconPath or moneyCA.imagePath)
  local quality = moneyCA.qualityInt + 1
  groupConsume.Group_Item.Img_Bottom:SetSprite(UIConfig.BottomConfig[quality])
  groupConsume.Group_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[quality])
  groupConsume.Group_Item.Btn_Item:SetClickParam(moneyCA.id)
  local groupCost = groupConsume.Group_Cost
  local needNum = moneyData.moneyNum
  groupCost.Txt_Need.Txt.text = PlayerData:NumToFormatString(needNum, 1)
  local haveNum = PlayerData:GetGoodsById(moneyData.moneyID).num
  groupCost.Txt_Have.Txt.text = PlayerData:NumToFormatString(haveNum, 1)
  if needNum > haveNum then
    groupCost.Txt_Have:SetColor(UIConfig.Color.Red)
    if DataModel.notEnoughMap[tonumber(elementIndex)] ~= true then
      DataModel.notEnoughMap[tonumber(elementIndex)] = true
    end
  else
    groupCost.Txt_Have:SetColor(UIConfig.Color.White)
  end
end

function Controller.JumpOpenExchangeTip(giftId)
  local giftIndex
  for i, v in ipairs(DataModel.ExchangeStoreList) do
    if giftId == v.id then
      giftIndex = i
      break
    end
  end
  if giftIndex then
    local ca = PlayerData:GetFactoryData(giftId, "CommondityFactory")
    if ca.isBuyCondition then
      local gradeCondition = ca.gradeCondition
      if gradeCondition > PlayerData:GetUserInfo().lv then
        return
      end
    end
    if DataModel.notEnoughMap[tonumber(giftIndex)] then
      return
    end
    local maxNum = DataModel:GetPurchaseNum(ca)
    local remainBuyNum = ca.purchase and math.max(0, maxNum - (DataModel.itemBuyCount[tonumber(giftId)] or 0)) or -1
    if remainBuyNum == 0 then
      CommonTips.OpenTips(80609925)
      return
    end
    UIManager:Open("UI/Common/ExchangeTips", Json.encode({
      commodityId = giftId,
      remainNum = remainBuyNum,
      shopId = DataModel.Shop_Id,
      index = DataModel.ExchangeStoreList[tonumber(giftIndex)].commodityIndex
    }), function()
      Controller.OpenStorePage()
    end)
  end
end

function Controller:SetActivityRechargeElement(element, elementIndex)
  local row = DataModel.ActivityRechargeList[tonumber(elementIndex)]
  if row == nil then
    element:SetActive(false)
    return
  end
  local activeCA = row.activeCA
  element:SetActive(true)
  element.Btn_Item:SetClickParam(elementIndex)
  element.Btn_Item.Txt_Title:SetText(activeCA.name)
  local timeStamp = TimeUtil:LastTime(activeCA.endTime)
  local timeTable = TimeUtil:SecondToTable(timeStamp)
  element.Btn_Item.Txt_Time:SetText(string.format(GetText(80610478), timeTable.day, timeTable.hour))
  element.Btn_Item.Img_Red:SetActive(require("UIActivityRecharge/UIActivityRechargeController"):InitData(activeCA.id))
  if activeCA.storeBG ~= nil and activeCA.storeBG ~= "" then
    element.Btn_Item:SetSprite(activeCA.storeBG)
  end
end

function Controller:Recharge()
  local ActivityMainDataModel = require("UIActivityMain/UIActivityMainDataModel")
  local activityCAList = ActivityMainDataModel:GetActivityCAList()
  DataModel.ActivityRechargeList = {}
  for k, v in ipairs(activityCAList) do
    if TimeUtil:IsActive(v.startTime, v.endTime) then
      local activeCA = PlayerData:GetFactoryData(v.id)
      if activeCA ~= nil and activeCA.mod == "\231\180\175\229\133\133" then
        table.insert(DataModel.ActivityRechargeList, {
          index = k,
          id = v.id,
          activeCA = activeCA
        })
      end
    end
  end
  local rechargeCount = #DataModel.ActivityRechargeList
  local maxRechargeCount = 3
  if rechargeCount > maxRechargeCount then
    logError(string.format("\229\149\134\229\186\151\231\180\175\229\133\133\232\183\179\232\189\172\230\140\137\233\146\174\230\156\128\229\164\154\230\148\175\230\140\129%s\228\184\170\239\188\140\229\189\147\229\137\141\230\156\137\230\149\136\231\180\175\229\133\133\230\180\187\229\138\168\230\149\176\233\135\143\228\184\186%s", maxRechargeCount, rechargeCount))
    rechargeCount = maxRechargeCount
  end
  local showRechargeGroup = 0 < rechargeCount and not WitchData.inWitchMap
  View.Group_Recharge:SetActive(showRechargeGroup)
  View.Group_Recharge.StaticGrid_Btn.self:SetDataCount(showRechargeGroup and rechargeCount or 0)
  if showRechargeGroup then
    View.Group_Recharge.StaticGrid_Btn.self:RefreshAllElement()
  end
end

return Controller
