local View = require("UIStore/UIStoreView")
local DataModel = {
  TopIndex = nil,
  GiftTopIndex = nil,
  SkinTopIndex = nil,
  isFirstGiftStoreLabel = true,
  isFirstGiftStore = true,
  isTabGiftSequence = false,
  isTabSkinSequence = false,
  redPointShopId = 40300012,
  redPointCommodityIds = {
    [40200454] = 1,
    [40200293] = 2,
    [40200028] = 3
  }
}
DataModel.Choose_List = {}
DataModel.Choose_Button = {}
DataModel.GiftStoreList = {}
DataModel.GiftStoreListLabel = {}
DataModel.RoleStoreList = {}
DataModel.SkinPreStore = {}
DataModel.SkinPreStoreLabel = {}
DataModel.ResetStroeList = {}
DataModel.ResetBatchCount = 0
DataModel.TriggerTimeList = {}
DataModel.TagPanel = {}
DataModel.DefaultConfig = {}
DataModel.NextRefreshTime = 0
DataModel.IsNextRefresh = false
local gird_dimond, grid_role, grid_gift, grid_gift_label, grid_skinPre, grid_skinPre_label, grid_recommend, grid_daily_reward, grid_gold_reward, grid_reset
DataModel.tagindex = nil
DataModel.rightindex = nil
DataModel.isBatch = false
DataModel.batchMoney = 0
DataModel.batchList = {}
DataModel.ActivityRechargeList = {}

function DataModel.Init()
  DataModel.GiftTopIndex = nil
  DataModel.SkinTopIndex = nil
  DataModel.IsNextRefresh = false
  DataModel.mainStoreList = DataModel.InitAllMainStoreList()
  View.Btn_BlackMoon:SetActive(true)
end

function DataModel.InitAllMainStoreList()
  local mainStoreList = {}
  DataModel.TagPanel = {}
  local signGiftValId = DataModel.GetSignGiftValuableId()
  if signGiftValId and PlayerData.ServerData.sign_award then
    for id, v in pairs(PlayerData.ServerData.sign_award) do
      if id == tostring(signGiftValId) then
        DataModel.SignGiftProto = v
      end
    end
  end
  DataModel.DefaultConfig = PlayerData:GetFactoryData(99900001)
  if DataModel.DefaultConfig and DataModel.DefaultConfig.mainStoreList then
    local ca_mainStoreList = DataModel.DefaultConfig.mainStoreList
    for i = 1, #ca_mainStoreList do
      local isStoreOpen = DataModel.GetStoreIsOpened(ca_mainStoreList[i].id)
      if isStoreOpen then
        table.insert(mainStoreList, ca_mainStoreList[i])
        local ca = PlayerData:GetFactoryData(ca_mainStoreList[i].id, "ListFactory")
        if ca and ca.mainStoreList then
          for j = 1, #ca.mainStoreList do
            local storeCA = PlayerData:GetFactoryData(ca.mainStoreList[j].id, "StoreFactory")
            if storeCA then
              table.insert(DataModel.TagPanel, storeCA.showUI)
            end
          end
        end
      end
    end
  end
  return mainStoreList
end

function DataModel:GetAllGiftList()
  DataModel.GiftStoreList = {}
  DataModel.GiftStoreListLabel = {}
  DataModel.TriggerTimeList = {}
  DataModel.isTabGiftSequence = DataModel.Now_ShopList.isTab
  if DataModel.isTabGiftSequence then
    for k, v in pairs(DataModel.Now_ShopList.shopList) do
      local storeCA = PlayerData:GetFactoryData(v.id)
      local row = {}
      row.icon = storeCA.classifyIcon
      row.name = storeCA.classifyName
      row.redCount = 0
      row.shopList = {}
      for c, d in pairs(storeCA.commodityList) do
        if d.id > -1 then
          local commoditData = DataModel:GetLocalValuableConfig(d.id)
          if commoditData then
            local isAdd = not commoditData.isTime and not commoditData.isActGift and not commoditData.isTriggerTime
            local row_c = {}
            local continueTime = commoditData.continueTime or 0
            local endTimeStore = ""
            local startTimeStore = ""
            local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
            row_c.num = 0
            row_c.id = d.id
            row_c.last_auto_refresh = -1
            if recharge and recharge[tostring(d.id)] then
              local server = recharge[tostring(d.id)]
              row_c.num = server.num
              row_c.last_auto_refresh = server.last_auto_refresh
            end
            local isMax_index = 1
            local index = c
            local maxNum = DataModel:GetPurchaseNum(commoditData)
            if commoditData.purchase == true and DataModel.PurchaseTypeList(commoditData.limitBuyType) ~= nil and maxNum <= row_c.num then
              isMax_index = 2
            end
            row_c.index = index
            row_c.isMax_index = isMax_index
            row_c.isMax = isMax_index == 2
            row_c.commoditData = commoditData
            row_c.isRedState = false
            row_c.endTime = 0
            row_c.begin = ""
            row_c.deadline = ""
            if commoditData.isActGift and row_c.last_auto_refresh ~= -1 and row_c.last_auto_refresh < TimeUtil:GetServerTimeStamp() and row_c.last_auto_refresh + continueTime * 3600 > TimeUtil:GetServerTimeStamp() then
              local endTime = row_c.last_auto_refresh + continueTime * 3600
              endTimeStore = endTime
              row_c.endTime = endTimeStore - TimeUtil:GetServerTimeStamp()
              startTimeStore = row_c.last_auto_refresh
            end
            if commoditData.isTime == false then
              if commoditData.isTriggerTime then
                local endTime = DataModel.GetStoreFirstLoginTime() + continueTime * 3600
                endTimeStore = endTime
                row_c.endTime = endTimeStore - TimeUtil:GetServerTimeStamp()
                startTimeStore = DataModel.GetStoreFirstLoginTime()
              end
            else
              if endTimeStore ~= "" then
                endTimeStore = math.max(endTimeStore, TimeUtil:TimeStamp(commoditData.endTime))
              else
                endTimeStore = TimeUtil:TimeStamp(commoditData.endTime)
              end
              row_c.endTime = endTimeStore - TimeUtil:GetServerTimeStamp()
              if startTimeStore ~= "" then
                startTimeStore = math.max(startTimeStore, TimeUtil:TimeStamp(commoditData.startTime))
              else
                startTimeStore = TimeUtil:TimeStamp(commoditData.startTime)
              end
              row_c.begin = startTimeStore
              row_c.deadline = endTimeStore
            end
            if endTimeStore ~= "" and startTimeStore ~= "" and startTimeStore < TimeUtil:GetServerTimeStamp() and endTimeStore > TimeUtil:GetServerTimeStamp() then
              isAdd = true
            end
            if PlayerData:GetPlayerPrefs("int", "StoreRed" .. d.id) == 5 and isAdd then
              PlayerData:SetPlayerPrefs("int", "StoreRed" .. d.id, 0)
              DataModel:AddStoreRedState(DataModel.Shop_Id, d.id)
            end
            if commoditData.isRedPoint and PlayerData:GetPlayerPrefs("int", "StoreRed" .. d.id) == 0 then
              row_c.isRedState = true
              row.redCount = row.redCount + 1
            end
            if isAdd then
              table.insert(row.shopList, row_c)
              if DataModel.TriggerTimeList[row_c.id] == nil and endTimeStore ~= "" then
                DataModel.TriggerTimeList[row_c.id] = {
                  time = row_c.endTime
                }
              end
            end
            if row_c.isMax or 0 > row_c.endTime then
              if row_c.isRedState == true then
                row_c.isRedState = false
                row.redCount = row.redCount - 1
              end
              if PlayerData:GetPlayerPrefs("int", "StoreRed" .. d.id) == 0 then
                PlayerData:SetPlayerPrefs("int", "StoreRed" .. d.id, 1)
              end
            end
          end
        end
      end
      table.insert(DataModel.GiftStoreListLabel, row)
    end
  else
    for k, v in pairs(DataModel.Now_ShopList.shopList) do
      local commoditData = DataModel:GetLocalValuableConfig(v.id)
      if commoditData then
        local isAdd = not commoditData.isTime and not commoditData.isActGift and not commoditData.isTriggerTime
        local row_c = {}
        local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
        local continueTime = commoditData.continueTime or 0
        local endTimeStore = ""
        local startTimeStore = ""
        row_c.num = 0
        row_c.id = v.id
        row_c.last_auto_refresh = -1
        if recharge and recharge[tostring(v.id)] then
          local server = recharge[tostring(v.id)]
          row_c.num = server.num
          row_c.last_auto_refresh = server.last_auto_refresh
        end
        local isMax_index = 1
        local index = k
        local maxNum = DataModel:GetPurchaseNum(commoditData)
        if commoditData.purchase == true and DataModel.PurchaseTypeList(commoditData.limitBuyType) ~= nil and maxNum <= row_c.num then
          isMax_index = 2
        end
        row_c.index = index
        row_c.isMax_index = isMax_index
        row_c.isMax = isMax_index == 2
        row_c.commoditData = commoditData
        row_c.endTime = 0
        row_c.begin = ""
        row_c.deadline = ""
        row_c.isRedState = false
        if commoditData.isActGift and row_c.last_auto_refresh ~= -1 and row_c.last_auto_refresh < TimeUtil:GetServerTimeStamp() and row_c.last_auto_refresh + continueTime * 3600 > TimeUtil:GetServerTimeStamp() then
          local endTime = row_c.last_auto_refresh + continueTime * 3600
          endTimeStore = endTime
          row_c.endTime = endTimeStore - TimeUtil:GetServerTimeStamp()
          startTimeStore = row_c.last_auto_refresh
        end
        if commoditData.isTime == false then
          if commoditData.isTriggerTime then
            local endTime = DataModel.GetStoreFirstLoginTime() + continueTime * 3600
            endTimeStore = endTime
            row_c.endTime = endTimeStore - TimeUtil:GetServerTimeStamp()
            startTimeStore = DataModel.GetStoreFirstLoginTime()
          end
        else
          if endTimeStore ~= "" then
            endTimeStore = math.max(endTimeStore, TimeUtil:TimeStamp(commoditData.endTime))
          else
            endTimeStore = TimeUtil:TimeStamp(commoditData.endTime)
          end
          row_c.endTime = endTimeStore - TimeUtil:GetServerTimeStamp()
          if startTimeStore ~= "" then
            startTimeStore = math.max(startTimeStore, TimeUtil:TimeStamp(commoditData.startTime))
          else
            startTimeStore = TimeUtil:TimeStamp(commoditData.startTime)
          end
          row_c.begin = startTimeStore
          row_c.deadline = endTimeStore
        end
        if endTimeStore ~= "" and startTimeStore ~= "" and startTimeStore < TimeUtil:GetServerTimeStamp() and endTimeStore > TimeUtil:GetServerTimeStamp() then
          isAdd = true
        end
        if PlayerData:GetPlayerPrefs("int", "StoreRed" .. v.id) == 5 and isAdd then
          PlayerData:SetPlayerPrefs("int", "StoreRed" .. v.id, 0)
          DataModel:AddStoreRedState(DataModel.Shop_Id, v.id)
        end
        if commoditData.isRedPoint and PlayerData:GetPlayerPrefs("int", "StoreRed" .. v.id) == 0 then
          row_c.isRedState = true
        end
        if isAdd then
          if table.count(DataModel.GiftStoreListLabel) == 0 then
            DataModel.GiftStoreListLabel.shopList = {}
          end
          table.insert(DataModel.GiftStoreListLabel.shopList, row_c)
          if DataModel.TriggerTimeList[row_c.id] == nil and commoditData.endTime ~= "" and commoditData.isTime then
            DataModel.TriggerTimeList[row_c.id] = {
              time = row_c.endTime
            }
          end
        end
        if row_c.isMax or 0 > row_c.endTime then
          row_c.isRedState = false
          if PlayerData:GetPlayerPrefs("int", "StoreRed" .. v.id) == 0 then
            PlayerData:SetPlayerPrefs("int", "StoreRed" .. v.id, 1)
          end
        end
      end
    end
  end
  if DataModel.isTabGiftSequence then
    for k, v in pairs(DataModel.GiftStoreListLabel) do
      if table.count(v.shopList) == 0 then
        table.remove(DataModel.GiftStoreListLabel, k)
      end
    end
  end
end

function DataModel:GetGiftLabelList(index)
  local row = DataModel.GiftStoreListLabel[index]
  DataModel.GiftStoreList = {}
  for k, v in pairs(row.shopList) do
    table.insert(DataModel.GiftStoreList, v)
  end
  table.sort(DataModel.GiftStoreList, function(a, b)
    if a.isMax_index == b.isMax_index then
      return a.index < b.index
    end
    return a.isMax_index < b.isMax_index
  end)
end

function DataModel:GetGiftList()
  local row = DataModel.GiftStoreListLabel.shopList
  DataModel.GiftStoreList = row
  table.sort(DataModel.GiftStoreList, function(a, b)
    if a.isMax_index == b.isMax_index then
      return a.index < b.index
    end
    return a.isMax_index < b.isMax_index
  end)
end

local function SetSkinHomeSkillInfo(row, commoditData)
  if PlayerData.IsSkinHomeSkillOpen() then
    local skinSkillId
    if commoditData.rewardList then
      for k, v in pairs(commoditData.rewardList) do
        local preThreeNum = math.modf(v.id / 100000)
        if preThreeNum == 110 then
          skinSkillId = v.id
        end
      end
    end
    if skinSkillId then
      local ca = PlayerData:GetFactoryData(skinSkillId)
      if ca.homeSkill > 0 then
        local homeSkillCa = PlayerData:GetFactoryData(ca.homeSkill)
        row.skinHomeSkillId = skinSkillId
        local desc = homeSkillCa.descStore
        if homeSkillCa.isReplace then
          local param = homeSkillCa.param
          if homeSkillCa.isPCT then
            param = param * 100
          else
            param = math.floor(param + 0.5)
          end
          desc = string.format(desc, param)
        end
        row.skinHomeSkillDesc = desc
      end
    end
  end
end

function DataModel:GetAllSkinPreList()
  DataModel.SkinPreStore = {}
  DataModel.SkinPreStoreLabel = {}
  DataModel.TriggerTimeList = {}
  DataModel.isTabSkinSequence = DataModel.Now_ShopList.isTab
  if DataModel.isTabSkinSequence then
    for k, v in pairs(DataModel.Now_ShopList.shopList) do
      local storeCA = PlayerData:GetFactoryData(v.id)
      local row = {}
      row.icon = storeCA.classifyIcon
      row.name = storeCA.classifyName
      row.redCount = 0
      row.shopList = {}
      table.insert(DataModel.SkinPreStoreLabel, row)
      for c, d in pairs(storeCA.commodityList) do
        if d.id > -1 then
          local commoditData = DataModel:GetLocalValuableConfig(d.id)
          if commoditData then
            local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
            local row_c = {}
            SetSkinHomeSkillInfo(row_c, commoditData)
            row_c.num = 0
            if recharge and recharge[tostring(d.id)] then
              local num = recharge[tostring(d.id)].num
              row_c.num = num
            end
            local isMax_index = 1
            local index = k
            local maxNum = DataModel:GetPurchaseNum(commoditData)
            if commoditData.purchase == true and DataModel.PurchaseTypeList(commoditData.limitBuyType) ~= nil and maxNum <= row_c.num then
              isMax_index = 2
            end
            row_c.id = d.id
            row_c.index = index
            row_c.isMax_index = isMax_index
            row_c.isMax = isMax_index == 2
            row_c.isRedState = false
            row_c.commoditData = commoditData
            if commoditData.isRedPoint and PlayerData:GetPlayerPrefs("int", "StoreRed" .. row_c.id) == 0 then
              row_c.isRedState = true
              row.redCount = row.redCount + 1
            end
            row_c.endTime = 0
            if commoditData.isTriggerTime then
              local continueTime = commoditData.continueTime
              local endTime = DataModel.GetStoreFirstLoginTime() + continueTime * 3600 - TimeUtil:GetServerTimeStamp()
              row_c.endTime = endTime
              if 0 < endTime and DataModel.TriggerTimeList[row_c.id] == nil then
                DataModel.TriggerTimeList[row_c.id] = {time = endTime}
              end
            end
            if row_c.isMax or 0 > row_c.endTime then
              if row_c.isRedState == true then
                row_c.isRedState = false
                row.redCount = row.redCount - 1
              end
              if PlayerData:GetPlayerPrefs("int", "StoreRed" .. row_c.id) == 0 then
                PlayerData:SetPlayerPrefs("int", "StoreRed" .. row_c.id, 1)
              end
            end
            if commoditData.isTime == false or commoditData.isTime and TimeUtil:TimeIsActive(commoditData.startTime, commoditData.endTime) then
              table.insert(row.shopList, row_c)
              if 0 > row_c.endTime then
                table.remove(row.shopList, table.count(row.shopList))
              end
            end
          end
        end
      end
    end
  else
    for k, v in pairs(DataModel.Now_ShopList.shopList) do
      local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
      local row = {}
      row.num = 0
      if recharge and recharge[tostring(v.id)] then
        local num = recharge[tostring(v.id)].num
        row.num = num
      end
      local isMax_index = 1
      local index = k
      local commoditData = DataModel:GetLocalValuableConfig(v.id)
      local maxNum = DataModel:GetPurchaseNum(commoditData)
      if commoditData.purchase == true and DataModel.PurchaseTypeList(commoditData.limitBuyType) ~= nil and maxNum <= row.num then
        isMax_index = 2
      end
      SetSkinHomeSkillInfo(row, commoditData)
      row.id = v.id
      row.index = index
      row.isMax_index = isMax_index
      row.isMax = isMax_index == 2
      row.isRedState = false
      row.commoditData = commoditData
      if commoditData.isRedPoint and PlayerData:GetPlayerPrefs("int", "StoreRed" .. v.id) == 0 then
        row.isRedState = true
      end
      row.endTime = 0
      if commoditData.isTriggerTime then
        local continueTime = commoditData.continueTime
        local endTime = DataModel.GetStoreFirstLoginTime() + continueTime * 3600 - TimeUtil:GetServerTimeStamp()
        row.endTime = endTime
        if 0 < endTime and DataModel.TriggerTimeList[row.id] == nil then
          DataModel.TriggerTimeList[row.id] = {time = endTime}
        end
      end
      if row.isMax or 0 > row.endTime then
        row.isRedState = false
        if PlayerData:GetPlayerPrefs("int", "StoreRed" .. v.id) == 0 then
          PlayerData:SetPlayerPrefs("int", "StoreRed" .. v.id, 1)
        end
      end
      if table.count(DataModel.SkinPreStoreLabel) == 0 then
        DataModel.SkinPreStoreLabel.shopList = {}
      end
      if commoditData.isTime == false or commoditData.isTime and TimeUtil:TimeIsActive(commoditData.startTime, commoditData.endTime) then
        table.insert(DataModel.SkinPreStoreLabel.shopList, row)
        if 0 > row.endTime then
          table.remove(DataModel.SkinPreStoreLabel.shopList, table.count(DataModel.GiftStoreListLabel.shopList))
        end
      end
    end
  end
  if DataModel.isTabSkinSequence then
    for k, v in pairs(DataModel.SkinPreStoreLabel) do
      if table.count(v.shopList) == 0 then
        table.remove(DataModel.SkinPreStoreLabel, k)
      end
    end
  end
end

function DataModel:GetSkinPreLabelList(index)
  local row = DataModel.SkinPreStoreLabel[index]
  DataModel.SkinPreStore = {}
  for k, v in pairs(row.shopList) do
    table.insert(DataModel.SkinPreStore, v)
  end
  table.sort(DataModel.SkinPreStore, function(a, b)
    if a.isMax_index == b.isMax_index then
      return a.index < b.index
    end
    return a.isMax_index < b.isMax_index
  end)
end

function DataModel:GetSkinPreList()
  local row = DataModel.SkinPreStoreLabel.shopList
  DataModel.SkinPreStore = row
  table.sort(DataModel.SkinPreStore, function(a, b)
    if a.isMax_index == b.isMax_index then
      return a.index < b.index
    end
    return a.isMax_index < b.isMax_index
  end)
end

function DataModel.GetInitStoreConfig()
  local diamondStoreList = DataModel.DefaultConfig.diamondStoreList
  local moonStoreList = DataModel.DefaultConfig.moonStoreList
  DataModel.List = {}
  local row = {}
  table.insert(DataModel.List, row)
  local count = table.count(DataModel.List) or 0
  local row = {}
  row.shopFactory = PlayerData:GetFactoryData(diamondStoreList[1].id)
  row.severStroeValue = PlayerData.ServerData.shops[tostring(diamondStoreList[1].id)] or {}
  if row.shopFactory.storeType == "Regular" and diamondStoreList[1].id == 40300003 then
    for k, v in pairs(row.shopFactory.shopList) do
      local recharge = PlayerData.RechargeGoods[tostring(40300003)]
      v.num = 0
      if recharge and recharge[tostring(v.id)] then
        local num = recharge[tostring(v.id)].num
        v.num = num
      end
    end
  end
  row.cor_time = row.cor_time or 0
  row.commoditData = ""
  row.moneyList = {}
  row.shopid = diamondStoreList[1].id
  DataModel.List[2] = row
  local list = {}
  for i = 1, 4 do
    local row = {}
    list[i] = {}
    if i == 3 then
      local shopFactory = PlayerData:GetFactoryData(moonStoreList[1].id)
      local severStroeValue = PlayerData.ServerData.shops[tostring(moonStoreList[1].id)] or {}
      if shopFactory.storeType == "Random" then
        DataModel.List[count] = severStroeValue
        if severStroeValue.last_auto_refresh then
          DataModel.List[count].cor_time = severStroeValue.last_auto_refresh + 86400 - PlayerData.ServerData.server_now
          DataModel.auto_refresh_index = 3
        end
      end
      row.cor_time = row.cor_time or 0
      row.commoditData = ""
      row.moneyList = {}
      row.shopFactory = shopFactory
      row.severStroeValue = severStroeValue
      row.shopid = moonStoreList[1].id
      list[i] = row
    end
  end
  DataModel.List[3] = list
end

function DataModel.GetStoreConfig(id)
  return PlayerData:GetFactoryData(id, "StoreFactory")
end

function DataModel.GetStoreConditionFactory(id)
  return PlayerData:GetFactoryData(id, "StoreConditionFactory")
end

local RightTag = {
  "Btn_Equip",
  "Btn_Furniture",
  "Btn_Role",
  "Btn_Skin"
}

function DataModel.ChooseRecommedStore(index)
  if index and DataModel.RecommedIndex == index then
    return
  end
  if DataModel.RecommedIndex then
    local old_element = View.Group_RecommendStore.ScrollGrid_List.grid.self:GetElementByIndex(DataModel.RecommedIndex - 1)
    old_element.Group_Off.self:SetActive(true)
    old_element.Group_On.self:SetActive(false)
  end
  local now_element = View.Group_RecommendStore.ScrollGrid_List.grid.self:GetElementByIndex(index - 1)
  now_element.Group_Off.self:SetActive(false)
  now_element.Group_On.self:SetActive(true)
  View.Group_RecommendStore.Btn_Recommend:SetSprite(DataModel.RecommendList[index].png)
  DataModel.RecommedIndex = index
end

function DataModel.ChooseRightList(index)
  if index == nil then
    return
  end
  if index == DataModel.RightIndex then
    return
  end
  local row = DataModel.mainStoreList[tonumber(index)]
  if DataModel.RightIndex ~= nil then
    DataModel.mainStoreList[DataModel.RightIndex].element.Btn_Top.Img_pitchon:SetActive(false)
  end
  DataModel.RightIndex = tonumber(index)
  row.element.Btn_Top.Img_pitchon:SetActive(true)
end

function DataModel:SearchAloneRedData(ca, typeList)
  local shopList = ca.shopList
  local count = 0
  for k, v in pairs(shopList) do
    if PlayerData:GetFactoryData(v.id) then
      if PlayerData:GetFactoryData(v.id).isRedPoint then
        local commoditData = DataModel:GetLocalValuableConfig(v.id)
        if commoditData then
          local isMax = false
          local recharge
          if commoditData.purchase == true then
            local typeTxtId = DataModel.PurchaseTypeList(commoditData.limitBuyType)
            local maxNum = DataModel:GetPurchaseNum(commoditData)
            if typeTxtId ~= nil and PlayerData.RechargeGoods then
              recharge = PlayerData.RechargeGoods[tostring(ca.id)]
              local row = {}
              row.num = 0
              if recharge and recharge[tostring(v.id)] then
                local num = recharge[tostring(v.id)].num
                row.num = num
              end
              if maxNum <= row.num then
                isMax = true
              end
            end
          end
          local isTimeOut = false
          local isNoStart = false
          if commoditData.isTriggerTime then
            local continueTime = commoditData.continueTime
            local endTime = DataModel.GetStoreFirstLoginTime() + continueTime * 3600 - TimeUtil:GetServerTimeStamp()
            isTimeOut = endTime < 0
          else
            local startTime = ""
            local lastTime = ""
            if commoditData.isActGift and PlayerData.RechargeGoods then
              recharge = PlayerData.RechargeGoods[tostring(ca.id)]
              if recharge and recharge[tostring(v.id)] then
                local server = recharge[tostring(v.id)]
                if server then
                  local last_auto_refresh = server.last_auto_refresh
                  local continueTime = commoditData.continueTime
                  if last_auto_refresh ~= -1 then
                    startTime = last_auto_refresh
                    lastTime = last_auto_refresh + continueTime * 3600
                  end
                end
              else
                isNoStart = true
              end
            end
            if commoditData.isTime == true then
              if lastTime ~= "" then
                lastTime = math.max(lastTime, TimeUtil:TimeStamp(commoditData.endTime))
              else
                lastTime = TimeUtil:TimeStamp(commoditData.endTime)
              end
              if startTime ~= "" then
                startTime = math.min(startTime, TimeUtil:TimeStamp(commoditData.startTime))
              else
                startTime = TimeUtil:TimeStamp(commoditData.startTime)
              end
            end
            lastTime = lastTime == "" and 0 or lastTime
            startTime = startTime == "" and 0 or lastTime
            lastTime = lastTime - TimeUtil:GetServerTimeStamp()
            startTime = startTime - TimeUtil:GetServerTimeStamp()
            isTimeOut = lastTime < 0
            if isNoStart == false then
              isNoStart = 0 < startTime
            end
          end
          if ca.id == DataModel.SignGiftShopId then
            local putState = PlayerData:GetPlayerPrefs("int", "StoreRed" .. v.id)
            local signState = DataModel.GetSignGiftRedDotState()
            if putState == 0 or signState then
              typeList.count = typeList.count + 1
              PlayerData:SetPlayerPrefs("int", "StoreRed" .. v.id, 0)
              table.insert(typeList.list, v.id)
              count = count + 1
            end
          elseif isMax or isTimeOut then
            PlayerData:SetPlayerPrefs("int", "StoreRed" .. v.id, 1)
          elseif isNoStart then
            PlayerData:SetPlayerPrefs("int", "StoreRed" .. v.id, 5)
          else
            local state = PlayerData:GetPlayerPrefs("int", "StoreRed" .. v.id)
            if state == 0 or state == 5 then
              typeList.count = typeList.count + 1
              PlayerData:SetPlayerPrefs("int", "StoreRed" .. v.id, 0)
              table.insert(typeList.list, v.id)
              count = count + 1
            end
          end
        end
      elseif ca.id == 40300012 and 0 < RedpointTree:GetRedpointCnt(RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. ca.id .. "|" .. v.id) then
        typeList.count = typeList.count + 1
        table.insert(typeList.list, v.id)
        count = count + 1
      end
    end
  end
  return count
end

function DataModel:SearchTwoAloneRedData(ca, typeList)
  local shopList = ca.shopList
  local count = 0
  for k, v in pairs(shopList) do
    local ca_1 = PlayerData:GetFactoryData(v.id)
    if ca_1 then
      for c, d in pairs(ca_1.commodityList) do
        if d.id > -1 and PlayerData:GetFactoryData(d.id) and PlayerData:GetFactoryData(d.id).isRedPoint then
          local commoditData = DataModel:GetLocalValuableConfig(d.id)
          local isMax = false
          local recharge
          if commoditData.purchase == true then
            local typeTxtId = DataModel.PurchaseTypeList(commoditData.limitBuyType)
            local maxNum = DataModel:GetPurchaseNum(commoditData)
            if typeTxtId ~= nil and PlayerData.RechargeGoods then
              recharge = PlayerData.RechargeGoods[tostring(ca.id)]
              local row = {}
              row.num = 0
              if recharge and recharge[tostring(d.id)] then
                local num = recharge[tostring(d.id)].num
                row.num = num
              end
              if maxNum <= row.num then
                isMax = true
              end
            end
          end
          local isTimeOut = false
          local isNoStart = false
          if commoditData.isTriggerTime then
            local continueTime = commoditData.continueTime
            local endTime = DataModel.GetStoreFirstLoginTime() + continueTime * 3600 - TimeUtil:GetServerTimeStamp()
            isTimeOut = endTime < 0
          else
            local startTime = ""
            local lastTime = ""
            if commoditData.isActGift and PlayerData.RechargeGoods then
              recharge = PlayerData.RechargeGoods[tostring(ca.id)]
              if recharge and recharge[tostring(d.id)] then
                local server = recharge[tostring(d.id)]
                if server then
                  local last_auto_refresh = server.last_auto_refresh
                  local continueTime = commoditData.continueTime
                  if last_auto_refresh ~= -1 then
                    startTime = last_auto_refresh
                    lastTime = last_auto_refresh + continueTime * 3600
                  end
                end
              else
                isNoStart = true
              end
            end
            if commoditData.isTime == true then
              if lastTime ~= "" then
                lastTime = math.max(lastTime, TimeUtil:TimeStamp(commoditData.endTime))
              else
                lastTime = TimeUtil:TimeStamp(commoditData.endTime)
              end
              if startTime ~= "" then
                startTime = math.max(startTime, TimeUtil:TimeStamp(commoditData.startTime))
              else
                startTime = TimeUtil:TimeStamp(commoditData.startTime)
              end
            end
            lastTime = lastTime == "" and 0 or lastTime
            startTime = startTime == "" and 0 or startTime
            lastTime = lastTime - TimeUtil:GetServerTimeStamp()
            startTime = startTime - TimeUtil:GetServerTimeStamp()
            isTimeOut = lastTime < 0
            if isNoStart == false then
              isNoStart = 0 < startTime
            end
          end
          if isMax or isTimeOut then
            PlayerData:SetPlayerPrefs("int", "StoreRed" .. d.id, 1)
          elseif isNoStart then
            PlayerData:SetPlayerPrefs("int", "StoreRed" .. d.id, 5)
          else
            local state = PlayerData:GetPlayerPrefs("int", "StoreRed" .. d.id)
            if state == 0 or state == 5 then
              typeList.count = typeList.count + 1
              PlayerData:SetPlayerPrefs("int", "StoreRed" .. d.id, 0)
              table.insert(typeList.list, d.id)
              count = count + 1
            end
          end
        end
      end
    end
  end
  return count
end

function DataModel:SetQuestStoreGacha(questId, type)
  local questCA
  questCA = PlayerData:GetFactoryData(questId, "QuestFactory")
  if questCA == nil then
    error("\228\187\187\229\138\161id:" .. questId .. "\228\184\141\229\173\152\229\156\168\230\156\172\229\156\176\233\133\141\231\189\174\232\161\168,\232\175\183\230\163\128\230\159\165\233\133\141\231\189\174")
  end
  local serverKey = type or ""
  if type == nil then
    if questCA.questType == "Main" then
      serverKey = "mq_quests"
    elseif questCA.questType == "Side" then
      serverKey = "branch_quests"
    end
  end
  if serverKey ~= "" and questCA.giftList and table.count(questCA.giftList) > 0 then
    for m, n in pairs(questCA.giftList) do
      local state = PlayerData:GetPlayerPrefs("int", "StoreRed" .. n.id)
      if state ~= 1 then
        PlayerData:SetPlayerPrefs("int", "StoreRed" .. n.id, 0)
        local storeId = PlayerData:GetFactoryData(n.id).correspondStore
        DataModel:AddStoreRedState(storeId, n.id)
      end
    end
  end
end

function DataModel:SetQuestStoreRedState(quest)
  for k, v in pairs(quest) do
    if k == "mq_quests" or k == "branch_quests" then
      for c, d in pairs(v) do
        DataModel:SetQuestStoreGacha(c, k)
      end
    end
  end
end

function DataModel:SetActivityStoreRedState(activityId)
  if activityId == nil or PlayerData:GetFactoryData(activityId) == nil then
    return
  end
  local giftList = PlayerData:GetFactoryData(activityId).giftList
  if giftList == nil or table.count(giftList) == 0 then
    return
  end
  for m, n in pairs(giftList) do
    local state = PlayerData:GetPlayerPrefs("int", "StoreRed" .. n.id)
    if state ~= 1 then
      PlayerData:SetPlayerPrefs("int", "StoreRed" .. n.id, 0)
      local storeId = PlayerData:GetFactoryData(n.id).correspondStore
      DataModel:AddStoreRedState(storeId, n.id)
    end
  end
end

function DataModel:UpdateStoreRedState(id, storeId)
  if DataModel.TypeList[id] then
    DataModel.TypeList[id].count = DataModel.TypeList[id].count - 1
    DataModel.TypeList[id].count = DataModel.TypeList[id].count < 0 and 0 or DataModel.TypeList[id].count
    if storeId then
      for k, v in pairs(DataModel.TypeList[id].list) do
        if v == storeId then
          table.remove(DataModel.TypeList[id].list, k)
        end
      end
    end
  end
end

function DataModel:AddStoreRedState(storeId, id)
  local isNowAdd = false
  if DataModel.TypeList[storeId] == nil then
    DataModel.TypeList[storeId] = {}
    DataModel.TypeList[storeId].count = 0
    DataModel.TypeList[storeId].list = {}
    isNowAdd = true
  end
  DataModel.TypeList[storeId].count = DataModel.TypeList[storeId].count + 1
  if id then
    if isNowAdd then
      table.insert(DataModel.TypeList[storeId].list, id)
      return
    end
    local isSame = false
    for k, v in pairs(DataModel.TypeList[storeId].list) do
      if v == id then
        isSame = true
      end
    end
    if not isSame then
      table.insert(DataModel.TypeList[storeId].list, id)
    end
  end
end

function DataModel.GetStoreRedState(id)
  local count = 0
  if DataModel.TypeList == nil or table.count(DataModel.TypeList) == 0 then
    return false
  end
  if id and DataModel.TypeList[id] == nil then
    return false
  end
  for k, v in pairs(DataModel.TypeList) do
    count = count + v.count
  end
  if id then
    return DataModel.TypeList[id].count ~= 0
  end
  return count ~= 0
end

function DataModel.GetStoreFirstLoginTime()
  return PlayerData:GetUserInfo().add_time
end

function DataModel.SetStoreRedState()
  DataModel.TypeList = {}
  local mainStoreList = DataModel.InitAllMainStoreList()
  for k, v in pairs(mainStoreList) do
    if v.isRedPoint then
      local ca = PlayerData:GetFactoryData(v.id)
      local id = ca.mainStoreList[1].id
      if DataModel.TypeList[id] == nil then
        DataModel.TypeList[id] = {}
        DataModel.TypeList[id].count = 0
        DataModel.TypeList[id].list = {}
      end
    end
  end
  for k, v in pairs(DataModel.TypeList) do
    local ca = PlayerData:GetFactoryData(k)
    if ca.isTab then
      DataModel:SearchTwoAloneRedData(ca, v)
    else
      DataModel:SearchAloneRedData(ca, v)
    end
  end
end

function DataModel:GetRestStore()
  DataModel.ResetStroeList = {}
  local removeIdx = {}
  local batchCount = 0
  for k, v in pairs(DataModel.Now_ShopList.shopList) do
    local isAdd = false
    local row_c = {}
    local recharge = PlayerData.ServerData.shops[tostring(DataModel.Shop_Id)]
    row_c.num = 0
    row_c.id = v.id
    local commoditData = PlayerData:GetFactoryData(v.id)
    row_c.endTime = commoditData.endTime
    local isMax_index = 1
    local index = k
    row_c.index = index
    row_c.isMax_index = isMax_index
    row_c.isMax = isMax_index == 2
    row_c.isRedState = 0 < RedpointTree:GetRedpointCnt(RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. DataModel.Shop_Id .. "|" .. row_c.id)
    row_c.itemId = commoditData.commodityItemList[1].id
    row_c.itemNum = commoditData.commodityNum
    row_c.storeType = commoditData.storeType
    row_c.shopId = DataModel.Shop_Id
    row_c.name = commoditData.name
    row_c.currencyShow = Clone(commoditData.currencyShow)
    if recharge then
      row_c.server = recharge
      if DataModel.Now_ShopList.storeType == "Random" then
        for k, v in pairs(recharge.items) do
          if k == row_c.idx and tonumber(v.id) == tonumber(row_c.id) then
            row_c.py_cnt = v.py_cnt
          end
        end
      else
        for k, v in pairs(recharge.items) do
          if tonumber(v.id) == tonumber(row_c.id) then
            row_c.py_cnt = v.py_cnt
            if v.last_auto_refresh and commoditData.isTriggerTime then
              row_c.endTime = v.last_auto_refresh + (commoditData.continueTime or 0)
              if TimeUtil:GetServerTimeStamp() >= row_c.endTime then
                table.insert(removeIdx, k)
              end
            end
          end
        end
      end
    end
    row_c.residue = 100
    if commoditData.purchase and DataModel.PurchaseTypeList(commoditData.limitBuyType) ~= nil then
      local maxNum = DataModel:GetPurchaseNum(commoditData)
      row_c.residue = maxNum - (row_c.py_cnt or 0)
      if 0 > row_c.residue then
        row_c.residue = 0
      end
    end
    row_c.buyLimit = false
    row_c.limitRep = 0
    row_c.limitGrade = 0
    if commoditData.isBuyCondition then
      if 0 < commoditData.repGradeCondition then
        local stationId = DataModel.StationId
        if 0 < commoditData.stationCondition then
          stationId = commoditData.stationCondition
          local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
          if 0 < stationCA.attachedToCity then
            stationId = stationCA.attachedToCity
          end
        end
        local curRep = PlayerData:GetHomeInfo().stations[tostring(stationId)].rep_lv
        if curRep < commoditData.repGradeCondition then
          row_c.buyLimit = true
          row_c.limitRep = commoditData.repGradeCondition
        end
      end
      if 0 < commoditData.gradeCondition then
        local curLv = PlayerData:GetPlayerLevel()
        if curLv < commoditData.gradeCondition then
          row_c.buyLimit = true
          row_c.limitGrade = commoditData.gradeCondition
        end
      end
    end
    if commoditData.isTime == false or commoditData.isTime and TimeUtil:TimeIsActive(commoditData.startTime, commoditData.endTime) then
      table.insert(DataModel.ResetStroeList, row_c)
      if 0 < row_c.residue and not row_c.buyLimit and commoditData.moneyList[1] and commoditData.moneyList[1].moneyID == 11400001 then
        batchCount = batchCount + 1
      end
    end
  end
  DataModel.ResetBatchCount = batchCount
  local count = 0
  for k, v in pairs(removeIdx) do
    table.remove(DataModel.ResetStroeList, v - count)
    count = count + 1
  end
  table.sort(DataModel.ResetStroeList, function(a, b)
    if a.residue == 0 and b.residue > 0 then
      return false
    end
    if a.residue > 0 and b.residue == 0 then
      return true
    end
    if a.buyLimit and not b.buyLimit then
      return false
    end
    if not a.buyLimit and b.buyLimit then
      return true
    end
    return a.index < b.index
  end)
end

function DataModel:GetItemWeight(itemId)
  local ca = PlayerData:GetFactoryData(itemId)
  if ca.isBuyCondition then
    local gradeCondition = ca.gradeCondition
    if gradeCondition > PlayerData:GetUserInfo().lv then
      return 1
    end
  end
  if ca.purchase then
    local maxNum = DataModel:GetPurchaseNum(ca)
    if maxNum - (self.itemBuyCount[tonumber(itemId)] or 0) <= 0 then
      return 0
    end
  end
  return 2
end

function DataModel:GetExchangeData()
  DataModel.ExchangeStoreList = {}
  local serverItems = {}
  if PlayerData.ServerData.shops[tostring(DataModel.Shop_Id)] ~= nil then
    serverItems = PlayerData.ServerData.shops[tostring(DataModel.Shop_Id)].items or {}
  end
  local itemBuyCount = {}
  for k, v in pairs(serverItems) do
    itemBuyCount[tonumber(v.id)] = v.py_cnt
  end
  DataModel.itemBuyCount = itemBuyCount
  local shopList = DataModel.Now_ShopList.shopList
  local itemList = {}
  for i = 1, #shopList do
    local itemCA = PlayerData:GetFactoryData(shopList[i].id, "CommondityFactory")
    if itemCA.isTime then
      if TimeUtil:IsActive(itemCA.startTime, itemCA.endTime) then
        itemList[#itemList + 1] = shopList[i]
      end
    else
      itemList[#itemList + 1] = shopList[i]
    end
    itemList[#itemList].idx = #itemList
    itemList[#itemList].commodityIndex = i
  end
  table.sort(itemList, function(e1, e2)
    local w1 = DataModel:GetItemWeight(e1.id)
    local w2 = DataModel:GetItemWeight(e2.id)
    if w1 ~= w2 then
      return w1 > w2
    else
      return e1.idx < e2.idx
    end
  end)
  DataModel.ExchangeStoreList = itemList
  DataModel.notEnoughMap = {}
end

function DataModel:JunmpStorePageData(shopId, id, isClick)
  local data = {}
  local labelIndex, index
  if (shopId == 80300323 or shopId == 80302554) and table.count(DataModel.GiftStoreListLabel) > 0 then
    for k, v in pairs(DataModel.GiftStoreListLabel) do
      if v.shopList and 0 < table.count(v.shopList) then
        for c, d in pairs(v.shopList) do
          if d.id == id then
            labelIndex = k
            index = c
            break
          end
        end
      end
    end
    if labelIndex then
      DataModel:GetGiftLabelList(labelIndex)
    end
    data = DataModel.GiftStoreList
  end
  if shopId == 80301713 and 0 < table.count(DataModel.SkinPreStoreLabel) then
    for k, v in pairs(DataModel.SkinPreStoreLabel) do
      if v.shopList and 0 < table.count(v.shopList) then
        for c, d in pairs(v.shopList) do
          if d.id == id then
            labelIndex = k
            index = c
            break
          end
        end
      end
    end
    if labelIndex then
      DataModel:GetSkinPreLabelList(labelIndex)
    end
    data = DataModel.SkinPreStore
  end
  if shopId == 80305469 then
    local listCA = PlayerData:GetFactoryData(shopId, "ListFactory")
    local storeInfo = listCA.mainStoreList and listCA.mainStoreList[1]
    if storeInfo then
      local storeCA = PlayerData:GetFactoryData(storeInfo.id, "StoreFactory")
      if storeCA.shopList then
        for k, v in pairs(storeCA.shopList) do
          if v.id == id then
            index = k
            break
          end
        end
        data = storeCA.shopList
      end
    end
  end
  return data, labelIndex
end

function DataModel.PurchaseTypeList(type)
  local id
  if type == "Forever" then
    id = 80602487
  elseif type == "Daily" then
    id = 80602484
  elseif type == "Weekly" then
    id = 80602483
  elseif type == "Monthly" then
    id = 80602485
  end
  return id
end

function DataModel.SetRefreshTime()
  local defaultConfig = DataModel.DefaultConfig
  local valuableRefreshTime = defaultConfig.valuableRefreshTime
  local h = tonumber(string.sub(valuableRefreshTime, 1, 2))
  local m = tonumber(string.sub(valuableRefreshTime, 4, 5))
  local s = tonumber(string.sub(valuableRefreshTime, 7, 8))
  local nextRefreshTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
  DataModel.NextRefreshTime = nextRefreshTime - TimeUtil:GetServerTimeStamp()
  DataModel.IsNextRefresh = true
end

function DataModel.GetStoreIndex(switchParameter)
  if switchParameter == nil then
    return
  end
  for k, v in pairs(DataModel.mainStoreList) do
    if v.id == tonumber(switchParameter) then
      DataModel.TopIndex = k
      break
    end
  end
end

function DataModel:GetLocalValuableConfig(id)
  if id == nil then
    return false
  end
  local ExtractFactoryData = CacheAndGetFactory("ValuableFactory")
  return ExtractFactoryData[tonumber(id)]
end

function DataModel:ShopIsActive(id, shopId, isMainAd)
  shopId = shopId or DataModel.Shop_Id
  local commoditData = PlayerData:GetFactoryData(id)
  local recharge = PlayerData.RechargeGoods[tostring(shopId)]
  local last_auto_refresh = -1
  local continueTime = commoditData.continueTime or 0
  local endTimeStore = ""
  local startTimeStore = ""
  local isActive = false
  if recharge and recharge[tostring(id)] then
    local server = recharge[tostring(id)]
    last_auto_refresh = server.last_auto_refresh
  end
  if commoditData.isActGift and last_auto_refresh ~= -1 and last_auto_refresh < TimeUtil:GetServerTimeStamp() and last_auto_refresh + continueTime * 3600 > TimeUtil:GetServerTimeStamp() then
    endTimeStore = last_auto_refresh + continueTime * 3600
    startTimeStore = last_auto_refresh
  end
  if commoditData.isTime == false then
    if commoditData.isTriggerTime then
      endTimeStore = DataModel.GetStoreFirstLoginTime() + continueTime * 3600
      startTimeStore = DataModel.GetStoreFirstLoginTime()
    end
    isActive = true
    startTimeStore = PlayerData:GetUserInfo().add_time
  else
    if endTimeStore ~= "" then
      endTimeStore = math.max(endTimeStore, TimeUtil:TimeStamp(commoditData.endTime))
    else
      endTimeStore = TimeUtil:TimeStamp(commoditData.endTime)
    end
    if startTimeStore ~= "" then
      startTimeStore = math.max(startTimeStore, TimeUtil:TimeStamp(commoditData.startTime))
    else
      startTimeStore = TimeUtil:TimeStamp(commoditData.startTime)
    end
  end
  if isMainAd and 0 < commoditData.showMainTime and startTimeStore ~= "" then
    endTimeStore = startTimeStore + commoditData.showMainTime * 86400
  end
  if endTimeStore ~= "" and startTimeStore ~= "" and startTimeStore < TimeUtil:GetServerTimeStamp() and endTimeStore > TimeUtil:GetServerTimeStamp() then
    isActive = true
  end
  return isActive
end

DataModel.ConditionList = {}
DataModel.InitSelectIndex = 1
DataModel.ConditionTrueNum = 0

function DataModel:Clear()
  DataModel.tagindex = nil
  DataModel.rightindex = nil
  DataModel.TopIndex = nil
  DataModel.Now_ShopList = nil
  DataModel.ActivityRechargeList = {}
end

DataModel.SignGiftProto = nil
DataModel.SignRewardGetState = {
  hasGet = 1,
  canGet = 2,
  canNotGet = 3
}
DataModel.SignGiftShopId = 40300086

function DataModel.GetStoreIsOpened(storeId, isMainAd)
  if storeId == 80307398 then
    local ca = PlayerData:GetFactoryData(storeId, "ListFactory")
    if not ca or not ca.mainStoreList then
      return false
    end
    for i = 1, #ca.mainStoreList do
      local storeCA = PlayerData:GetFactoryData(ca.mainStoreList[i].id, "StoreFactory")
      local buyTime = DataModel.GetGoodBuyTime()
      if storeCA and storeCA.shopList then
        for j = 1, #storeCA.shopList do
          local valueCa = PlayerData:GetFactoryData(storeCA.shopList[j].id, "ValuableFactory")
          if valueCa then
            local nowTime = TimeUtil:GetServerTimeStamp() or 0
            local isBuy = DataModel.GetGoodIsBuy()
            local endTime = TimeUtil:TimeStamp(valueCa.endTime) or 0
            if isMainAd and 0 < valueCa.showMainTime then
              endTime = PlayerData:GetUserInfo().add_time + valueCa.showMainTime * 86400
              return nowTime < endTime
            end
            if valueCa.isTime then
              if isBuy then
                if nowTime < buyTime + valueCa.getContinueTime * 86400 then
                  return true
                end
              elseif nowTime < endTime then
                return true
              end
            elseif isBuy then
              if nowTime < buyTime + valueCa.getContinueTime * 86400 then
                return true
              end
            else
              return true
            end
          end
        end
      end
    end
    return false
  end
  return true
end

function DataModel.IsGoodsOpened(shopId, goodsId, isMainAd)
  if DataModel.GetStoreIsOpened(shopId, isMainAd) then
    if not goodsId then
      return true
    end
    local cfg = PlayerData:GetFactoryData(shopId, "ListFactory")
    return DataModel:ShopIsActive(goodsId, cfg.mainStoreList[1].id, isMainAd)
  end
  return false
end

function DataModel.GetGoodIsBuy()
  if not PlayerData.RechargeGoods then
    return false
  end
  if not PlayerData.RechargeGoods[tostring(DataModel.SignGiftShopId)] then
    return false
  end
  local storeCA = PlayerData:GetFactoryData(DataModel.SignGiftShopId, "StoreFactory")
  if not storeCA then
    return false
  end
  local shopList = storeCA.shopList or {}
  if #shopList == 0 then
    return false
  end
  if PlayerData.RechargeGoods[tostring(DataModel.SignGiftShopId)][tostring(shopList[1].id)] then
    local num = PlayerData.RechargeGoods[tostring(DataModel.SignGiftShopId)][tostring(shopList[1].id)].num or 0
    if 0 < num then
      return true
    end
  end
  return false
end

function DataModel.GetGoodBuyTime()
  if not DataModel.SignGiftProto then
    return 0
  end
  return DataModel.SignGiftProto.buy_ts
end

function DataModel.GetGoodItemGetState(index)
  if not DataModel.SignGiftProto then
    return DataModel.SignRewardGetState.canNotGet
  end
  local isBuy = DataModel.GetGoodIsBuy()
  if not isBuy then
    return DataModel.SignRewardGetState.canNotGet
  end
  local hasRecList = DataModel.SignGiftProto.rec_l or {}
  if hasRecList then
    for i = 1, #hasRecList do
      if tostring(hasRecList[i]) == tostring(index - 1) then
        return DataModel.SignRewardGetState.hasGet
      end
    end
  end
  local canGetCount = DataModel.SignGiftProto.need or 0
  if 0 < canGetCount and index <= #hasRecList + canGetCount then
    return DataModel.SignRewardGetState.canGet
  end
  return DataModel.SignRewardGetState.canNotGet
end

function DataModel.GetCanGetMaxIndex()
  DataModel.SignGiftProto = DataModel.SignGiftProto or {}
  local hasRecList = DataModel.SignGiftProto.rec_l or {}
  local needCount = DataModel.SignGiftProto.need or 0
  local canGetMaxIndex = #hasRecList + needCount
  return canGetMaxIndex
end

function DataModel.GetStoreIndexByShopId(shopId)
  if shopId == nil then
    return 1
  end
  for i = 1, #DataModel.mainStoreList do
    if DataModel.mainStoreList[i].id == tonumber(shopId) then
      return i
    end
  end
  return 1
end

function DataModel.GetStoreIdByIndex(index)
  if not DataModel.mainStoreList or #DataModel.mainStoreList == 0 then
    return nil
  end
  index = index or 1
  if 0 < index and index <= #DataModel.mainStoreList then
    return DataModel.mainStoreList[index].id
  end
  return DataModel.mainStoreList[1].id
end

function DataModel.GetSignGiftToUpdateProto(index)
  if index <= 0 then
    return
  end
  DataModel.SignGiftProto = DataModel.SignGiftProto or {}
  DataModel.SignGiftProto.rec_l = {}
  for i = 0, index - 1 do
    table.insert(DataModel.SignGiftProto.rec_l, i)
  end
  DataModel.SignGiftProto.need = 0
  PlayerData.ServerData = PlayerData.ServerData or {}
  local signGiftValId = DataModel.GetSignGiftValuableId()
  if signGiftValId then
    for id, signValue in pairs(PlayerData.ServerData.sign_award) do
      if id == tostring(signGiftValId) then
        signValue = DataModel.SignGiftProto
      end
    end
  end
end

function DataModel.GetSignGiftRedDotState()
  local storeCA = PlayerData:GetFactoryData(DataModel.SignGiftShopId, "StoreFactory")
  if not storeCA then
    return false
  end
  local shopList = storeCA.shopList or {}
  if #shopList == 0 then
    return false
  end
  local valueCa = PlayerData:GetFactoryData(shopList[1].id, "ValuableFactory")
  if not valueCa then
    return false
  end
  local dayRewardList = valueCa.dayRewardList or {}
  for i = 1, #dayRewardList do
    local signState = DataModel.GetGoodItemGetState(i)
    if signState == DataModel.SignRewardGetState.canGet then
      return true
    end
  end
  return false
end

function DataModel.GetSignGiftValuableId()
  local storeCA = PlayerData:GetFactoryData(DataModel.SignGiftShopId, "StoreFactory")
  if not storeCA then
    return nil
  end
  local shopList = storeCA.shopList or {}
  if #shopList == 0 then
    return nil
  end
  return shopList[1].id
end

function DataModel:GetPurchaseNum(Config)
  local maxNum = Config.purchaseNum
  if Config.isPurchaseLv and PlayerData:GetPlayerLevel() > Config.purchaseLvInit then
    local lvNum = math.min(math.floor((PlayerData:GetPlayerLevel() - Config.purchaseLvInit) / Config.purchaseLvSpace) * Config.purchaseLvNum, Config.purchaseLvMax)
    maxNum = maxNum + lvNum
  end
  return maxNum
end

return DataModel
