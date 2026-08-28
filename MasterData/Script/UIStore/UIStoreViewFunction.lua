local View = require("UIStore/UIStoreView")
local DataModel = require("UIStore/UIStoreDataModel")
local Controller = require("UIStore/UIStoreDataController")
local CommonItem = require("Common/BtnItem")
local SignGiftController = require("UIStore/UIStoreController_SignGift")
local buy_num = 1
local buy_price, all_num, gird_daily, gird_dimond, grid_daily_reward, grid_gold_reward, grid_gold, grid_gift, grid_role
local last_auto_refresh = 0
local refresh_state = false
local freeCount
local now_item_info = {}

local function OpenActivityRecharge(str)
  local row = DataModel.ActivityRechargeList[tonumber(str)]
  if row == nil then
    return
  end
  UIManager:Open("UI/Activity/ActivityMain", Json.encode({
    index = row.index,
    id = row.id
  }))
end

local function GetCurrency(id)
  if id == 11400001 then
    return PlayerData:GetUserInfo().gold
  end
  if id == 11400005 then
    return PlayerData:GetUserInfo().bm_rock
  end
  return 0
end

local function Refresh_Month_Day()
  if PlayerData.ServerData.monthly_card["11400018"] then
    View.Group_Month.Group_Time.Txt_Time:SetText(PlayerData.ServerData.monthly_card["11400018"].month_time)
  else
    View.Group_Month.Group_Time.Txt_Time:SetText(0)
  end
end

local function ShowPurchaseRole(data, index)
  local shopCA = PlayerData:GetFactoryData(data.id)
  local itemCA = PlayerData:GetFactoryData(shopCA.commodityItemList[1].id)
  local viewCA = PlayerData:GetFactoryData(itemCA.viewId)
  View.Group_RoleStore.Group_TimeCommodity.Group_Role.SpineAnimation_Character:SetData(viewCA.spineUrl)
  View.Group_RoleStore.Group_TimeCommodity.Group_Role.SpineAnimation_Character.transform.localPosition = Vector3(-80, -900, 0)
  View.Group_RoleStore.Group_TimeCommodity.Group_Role.Group_Character.Sprite_Character:SetActive(false)
  local lastTime = TimeUtil:LastTime(shopCA.endTime)
  local time = TimeUtil:SecondToTable(lastTime)
  DataModel.List[6].cor_time = lastTime
  DataModel.Choose_Purchase_Role = {}
  DataModel.Choose_Purchase_Role.index = index
  DataModel.Choose_Purchase_Role.id = data.id
  DataModel.Choose_Purchase_Role.shopCA = shopCA
  View.Group_RoleStore.Group_TimeCommodity.Group_Time.Txt_Time:SetText(TimeUtil:GetGachaDesc(time))
  View.Group_RoleStore.Group_TimeCommodity.Btn_Buy.Txt_Num:SetText(shopCA.moneyList[1].moneyNum)
  local left_money = PlayerData:GetFactoryData(tonumber(shopCA.moneyList[1].moneyID))
  View.Group_RoleStore.Group_TimeCommodity.Btn_Buy.Img_Money:SetSprite(left_money.iconPath)
end

local function ShowMedal()
  View.Group_RoleStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetUserInfo().medal)
end

local function refresh_buy_num()
  local ui_right = View.Group_PropBuy.Group_Right
  local group_middle = ui_right.Group_Middle
  local group_bottom = ui_right.Group_Bottom
  group_middle.Img_Num.Txt_Num:SetText(buy_num)
  group_bottom.Txt_Num:SetText(buy_num * buy_price)
end

local function get_free_refresh_num(already, freeCount)
  local number = 0
  if freeCount <= already then
    number = 0
  else
    number = freeCount - already
  end
  return number
end

local function init_item_detail(list, index)
  now_item_info = {}
  local row = list
  local commoditData = row.commoditData
  buy_num = 1
  local ui_list = View.Group_PropBuy
  local ui_left = ui_list.Group_Left
  ui_left.Txt_Title:SetText(commoditData.commodityName)
  ui_left.Img_Item:SetSprite(commoditData.commodityView)
  ui_left.Txt_Describe:SetText(commoditData.commodityFunction)
  local ui_right = ui_list.Group_Right
  local group_top = ui_right.Group_Top
  buy_price = commoditData.moneyList[1] == nil and 0 or commoditData.moneyList[1].moneyNum
  group_top.Txt_Price:SetText(buy_price)
  local money_info = commoditData.moneyList[1] and PlayerData:GetFactoryData(tonumber(commoditData.moneyList[1].moneyID)) or {iconPath = ""}
  local group_middle = ui_right.Group_Middle
  group_middle.Img_Num.Txt_Num:SetText(buy_num)
  all_num = row.residue
  group_middle.Txt_QuantityNum:SetText(all_num)
  local group_bottom = ui_right.Group_Bottom
  group_bottom.Txt_Num:SetText(buy_num * buy_price)
  if money_info.iconPath == "" then
    group_top:SetActive(false)
    group_bottom:SetActive(false)
  else
    group_top:SetActive(true)
    group_bottom:SetActive(true)
    group_top.Img_Icon:SetSprite(money_info.iconPath)
    group_bottom.Img_Icon:SetSprite(money_info.iconPath)
  end
  now_item_info.image = commoditData.commodityView
  now_item_info.name = row.name
  now_item_info.index = index
  now_item_info.shopid = DataModel.shop_id
  local maxNum = DataModel:GetPurchaseNum(commoditData)
  now_item_info.purchaseNum = maxNum
  now_item_info.purchase = commoditData.purchase
  now_item_info.commoditData = commoditData
  now_item_info.residue = row.residue
end

local function InitLackMoneyPage()
  View.Group_LackMoney.self:SetActive(true)
end

local function CloseLackMoneyPage()
  View.Group_LackMoney.self:SetActive(false)
end

local function CloseRefreshWindowPage()
  View.Group_RefreshWindow.self:SetActive(false)
end

local function OpenStockPage()
  View.Group_RefreshWindow.self:SetActive(true)
  View.Group_RefreshWindow.Txt_NoReminded.Btn_Check.Txt_Check:SetActive(refresh_state)
end

local function OpenDetail(row, index)
  View.Group_PropBuy.self:SetActive(true)
  init_item_detail(row, index)
end

local function ClosePropBuy()
  View.Group_PropBuy.self:SetActive(false)
end

local bottom_button_config = {}

local function UpdateBottomButtonState(index)
  DataModel.shop_id = DataModel.List[index].shopid
  if index == DataModel.Now_Tab_Index and DataModel.RefreshState == 0 then
    return
  end
  DataModel.RefreshState = 0
  DataModel.Now_Tab_Index = index
  for k, v in pairs(bottom_button_config) do
    v.button.Img_pitchon:SetActive(false)
    if v.show then
      v.show.self:SetActive(false)
    end
  end
  bottom_button_config[index].button.Img_pitchon:SetActive(true)
  if index == 7 then
    View.Group_Month.self:SetActive(true)
    Refresh_Month_Day()
    return
  end
  if index == 1 then
    CommonTips.OpenTips("\230\142\168 \230\142\168\232\141\144\228\184\141\228\186\134")
    return
  end
  DataModel.Choose_List = DataModel.List[index]
  freeCount = DataModel.List[index].shopFactory.freeRefreshNum
  local refresh_num = DataModel.Choose_List.refresh_num
  local showUI = bottom_button_config[index].show
  local reward_grid = bottom_button_config[index].reward
  if showUI.self == nil then
    return
  end
  showUI.self:SetActive(true)
  if index == 6 then
    ShowMedal()
    DataModel.RoleStoreList = {}
    local count = 1
    for k, v in pairs(DataModel.Choose_List.shopFactory.shopList) do
      local ca = PlayerData:GetFactoryData(v.id)
      if ca.isTime and ca.isTime == true then
        if ca.startTime ~= "" and TimeUtil:IsActive(ca.startTime, ca.endTime) then
          ShowPurchaseRole(v, k)
        end
      else
        DataModel.RoleStoreList[count] = v
        DataModel.RoleStoreList[count].index = k
        DataModel.RoleStoreList[count].server = {}
        if PlayerData.ServerData.shops[tostring(DataModel.shop_id)] then
          for c, d in pairs(PlayerData.ServerData.shops[tostring(DataModel.shop_id)].items) do
            if tonumber(d.id) == tonumber(v.id) then
              DataModel.RoleStoreList[count].server = d
            end
          end
        end
        count = count + 1
      end
    end
    if 0 < table.count(DataModel.RoleStoreList) then
      View.Group_RoleStore.StaticGrid_List.grid.self:SetActive(true)
      View.Group_RoleStore.StaticGrid_List.grid.self:SetDataCount(table.count(DataModel.RoleStoreList))
      View.Group_RoleStore.StaticGrid_List.grid.self:RefreshAllElement()
    else
      View.Group_RoleStore.StaticGrid_List.grid.self:SetActive(false)
    end
  end
  if index == 5 then
    View.Group_GiftStore.NewScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.Choose_List.shopFactory.shopList))
    View.Group_GiftStore.NewScrollGrid_List.grid.self:RefreshAllElement()
  end
  if index == 4 then
    DataModel:get_gold_grid():RefreshAllElement()
    View.Group_GoldStore.Group_Bottom.Img_Backgroud.Txt_RefreshTime:SetText("")
    View.Group_GoldStore.Group_Bottom.Img_Backgroud.Img_refresh.Txt_Stock:SetText("\229\133\141\232\180\185\229\136\183\230\150\176 " .. get_free_refresh_num(refresh_num, freeCount) .. "/" .. freeCount)
  end
  if index == 3 then
    DataModel:get_day_grid():RefreshAllElement()
    View.Group_DailyStore.Group_Bottom.Img_Backgroud.Txt_RefreshTime:SetText("")
    View.Group_DailyStore.Group_Bottom.Img_Backgroud.Img_refresh.Txt_Stock:SetText("\229\133\141\232\180\185\229\136\183\230\150\176 " .. get_free_refresh_num(refresh_num, freeCount) .. "/" .. freeCount)
  end
  if index == 2 then
    View.Group_DiamondStore.ScrollGrid_List.grid.self:SetDataCount(table.count(DataModel.Choose_List.shopFactory.shopList))
    View.Group_DiamondStore.ScrollGrid_List.grid.self:RefreshAllElement()
  end
  if showUI.Group_Reward then
    showUI.Group_Reward:SetActive(false)
    local Group_Reward = showUI.Group_Reward
    if DataModel.Choose_List.rewards ~= nil and 0 < table.count(DataModel.Choose_List.rewards) then
      DataModel.Group_Reward = {}
      showUI.Group_Reward:SetActive(true)
      reward_grid():RefreshAllElement()
      local max_progress = DataModel.Choose_List.rewards[table.count(DataModel.Choose_List.rewards)].buy_times
      local progress = 1 < DataModel.Choose_List.shop_times / max_progress and 1 or DataModel.Choose_List.shop_times / max_progress
      Group_Reward.Group_Progress.Img_Bar:SetFilledImgAmount(progress)
      Group_Reward.Group_Progress.Txt_Progress:SetText(DataModel.Choose_List.shop_times)
    end
    Group_Reward.Btn_Back:SetActive(false)
  end
end

local function Refresh_Right_Top_Num()
  View.Group_TopRight.Btn_Diamond.Txt_diamondnum:SetText(PlayerData.ServerData.user_info.bm_rock)
  View.Group_TopRight.Btn_Gold.Txt_Gold:SetText(PlayerData.ServerData.user_info.gold)
end

local function RefreshShopList(res)
  for k, v in pairs(PlayerData.ServerData.shops) do
    if tonumber(k) == tonumber(DataModel.List[3].shopid) then
      DataModel.List[3] = {}
      DataModel.List[3] = v
      DataModel.List[3].commoditData = ""
      DataModel.List[3].moneyList = {}
      DataModel.List[3].shopid = k
      DataModel.List[3].shopFactory = DataModel.GetStoreConfig(tonumber(k))
      DataModel.List[3].cor_time = 0
      if v.last_auto_refresh then
        DataModel.List[3].cor_time = v.last_auto_refresh + 86400 - PlayerData.ServerData.server_now
        DataModel.auto_refresh_index = DataModel.Now_Tab_Index
      end
    end
  end
  DataModel:ChooseRightTab(DataModel.rightindex, true)
end

local function SendRefreshShop()
  Net:SendProto("shop.refresh", function(json)
    DataModel.RefreshState = 1
    Refresh_Right_Top_Num()
    RefreshShopList(json)
    local num = json.shops[tostring(DataModel.shop_id)].refresh_num
    if DataModel.Now_Tab_Index == 3 then
      View.Group_DailyStore.Group_Bottom.Img_Backgroud.Img_refresh.Txt_Stock:SetText("\229\133\141\232\180\185\229\136\183\230\150\176 " .. get_free_refresh_num(num, freeCount) .. "/" .. freeCount)
    end
    if DataModel.Now_Tab_Index == 4 then
      View.Group_GoldStore.Group_Bottom.Img_Backgroud.Img_refresh.Txt_Stock:SetText("\229\133\141\232\180\185\229\136\183\230\150\176 " .. get_free_refresh_num(num, freeCount) .. "/" .. freeCount)
    end
    CommonTips.OpenTips(80600076)
  end, DataModel.shop_id)
end

local function ConsRockRefresh()
  local moneyList = DataModel.Choose_List.shopFactory.moneyList[1]
  local moneyNum = moneyList.moneyNum
  local moneyID = moneyList.moneyID
  if moneyNum > GetCurrency(moneyID) then
    if moneyID == 11400001 then
      CommonTips.OpenTips(80600129)
    end
    if moneyID == 11400005 then
      CommonTips.OnPrompt(80600147, nil, nil, callback)
    end
  else
    SendRefreshShop()
  end
end

local function ClickBottomReward(str)
  local row = DataModel.Choose_List.rewards[str]
  if row.status_rec == 2 then
    Net:SendProto("shop.receive_awards", function(json)
      DataModel.RefreshState = 1
      CommonTips.OpenShowItem(json.reward)
      row.received_status = 1
      RefreshShopList(json)
      Refresh_Right_Top_Num()
    end, DataModel.shop_id, str - 1)
    return
  end
  if str ~= DataModel.Now_Group_Index then
    for k, v in pairs(DataModel.Choose_List.rewards) do
      local element_every = View.Group_DailyStore.Group_Reward.StaticGrid_Box.grid[k]
      element_every.Group_Preview:SetActive(false)
    end
  end
  local element = View.Group_DailyStore.Group_Reward.StaticGrid_Box.grid[str]
  if element.Group_Preview.IsActive == true then
    element.Group_Preview:SetActive(false)
    View.Group_DailyStore.Group_Reward.Btn_Back:SetActive(false)
  else
    element.Group_Preview:SetActive(true)
    View.Group_DailyStore.Group_Reward.Btn_Back:SetActive(true)
    DataModel.Now_Group_Index = str
  end
end

local ViewFunction = {
  Store_Group_CommonTopLeft_Btn_Return_Click = function(str)
    DataModel.Now_Tab_Index = nil
    UIManager:GoBack()
  end,
  Store_Group_CommonTopLeft_Btn_Home_Click = function(str)
    MapNeedleData.GoHome()
  end,
  Store_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Store_Group_Top_Button_Btn_recommend_Click = function(btn, str)
    DataModel:ChooseTag(1)
  end,
  Store_Group_Top_Button_Btn_diamondstore_Click = function(btn, str)
    DataModel:ChooseTag(2)
  end,
  Store_Group_Top_Button_Btn_dailystore_Click = function(btn, str)
    local condition = DataModel.ConditionList[2]
    if condition.state == false then
      CommonTips.OpenTips(condition.txt)
      return
    end
    UpdateBottomButtonState(3)
  end,
  Store_Group_Top_Button_Btn_month_Click = function(btn, str)
    UpdateBottomButtonState(7)
  end,
  Store_Group_Top_Button_Btn_glodStore_Click = function(btn, str)
    UpdateBottomButtonState(4)
  end,
  Store_Group_Top_Button_Btn_giftStore_Click = function(btn, str)
    UpdateBottomButtonState(5)
  end,
  Store_Group_Top_Button_Btn_roleStore_Click = function(btn, str)
    UpdateBottomButtonState(6)
  end,
  Store_Group_Top_Button_Btn_MoonStore_Click = function(btn, str)
    DataModel:ChooseTag(3)
  end,
  Store_StaticGrid_RightButton_SetGrid = function(element, elementIndex)
    local row = DataModel.RightMainStoreList[tonumber(elementIndex)]
    element:SetActive(false)
    if row then
      element:SetActive(true)
      local Group_On = element.Group_On
      local Group_Off = element.Group_Off
      Group_On:SetActive(false)
      Group_Off:SetActive(false)
      local ca = PlayerData:GetFactoryData(row.id)
      row.ca = ca
      element:SetClickParam(elementIndex)
    end
  end,
  Store_StaticGrid_RightButton_Btn_RightButtom_000_Click = function(btn, str)
  end,
  Store_StaticGrid_RightButton_Btn_RightButtom_001_Click = function(btn, str)
  end,
  Store_StaticGrid_RightButton_Btn_RightButtom_002_Click = function(btn, str)
  end,
  Store_StaticGrid_RightButton_Btn_RightButtom_003_Click = function(btn, str)
  end,
  Store_Group_Top_Button_Btn_giftstore_Click = function(btn, str)
  end,
  Store_Group_Top_Button_Btn_Top_Click = function(btn, str)
  end,
  Store_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Store_Btn_Medal_Click = function(btn, str)
  end,
  Store_Btn_Medal_Btn_Add_Click = function(btn, str)
  end,
  Store_Group_MoonTips_Btn_Close_Click = function(btn, str)
    View.Group_MoonTips.self:SetActive(false)
  end,
  Store_ScrollGrid_TopButton_SetGrid = function(element, elementIndex)
    local row = DataModel.mainStoreList[tonumber(elementIndex)]
    element.Btn_Top.Img_pitchon:SetActive(tonumber(elementIndex) == DataModel.TopIndex)
    if row then
      local ca = PlayerData:GetFactoryData(row.id)
      row.ca = ca
      element.Btn_Top.Txt_TopName:SetText(row.name)
      element.Btn_Top.Img_1:SetSprite(row.pngNotSelect)
      element.Btn_Top.Img_pitchon.Txt_TopName:SetText(row.name)
      element.Btn_Top.Img_pitchon.Img_2:SetSprite(row.pngSelect)
      element.Btn_Top:SetClickParam(elementIndex)
      if row.showUI == nil then
        local showUI = PlayerData:GetFactoryData(ca.mainStoreList[1].id).showUI
        row.showUI = showUI
      end
      element.Btn_Top.Img_RedPoint:SetActive(DataModel.GetStoreRedState(ca.mainStoreList[1].id))
    end
  end,
  Store_ScrollGrid_TopButton_Group_Top_Btn_Top_Click = function(btn, str)
    Controller.ChooseTopList(str)
  end,
  Store_Group_DiamondStore_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.Now_ShopList.shopList[tonumber(elementIndex)]
    local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
    row.commoditData = commoditData
    row.name = commoditData.commodityName
    row.image = commoditData.commodityView
    local Btn_Item = element.Btn_Item
    Btn_Item.self:SetClickParam(elementIndex)
    local Group_Bottom = Btn_Item.Group_Bottom
    local Img_discountBG = Btn_Item.Img_discountBG
    local count = 0
    if commoditData.rewardFirstList and 0 < table.count(commoditData.rewardFirstList) then
      count = table.count(commoditData.rewardFirstList)
    end
    Group_Bottom.Txt_FollowCharge:SetActive(false)
    if commoditData.isFirst == true and 0 < count and row.num == 0 then
      local rewardFirst = PlayerData:GetFactoryData(commoditData.rewardFirstList[1].id)
      Img_discountBG.Txt_FirstCharge:SetText(string.format(GetText(80600198), commoditData.rewardFirstList[1].num))
      local reward = PlayerData:GetFactoryData(commoditData.rewardList[1].id)
      Group_Bottom.Txt_discount:SetText(commoditData.rewardList[1].num .. " " .. reward.name .. "+" .. commoditData.rewardFirstList[1].num .. " " .. rewardFirst.name)
      Group_Bottom.Txt_discountNum:SetActive(true)
      Img_discountBG:SetActive(true)
    else
      Group_Bottom.Txt_discountNum:SetActive(false)
      Img_discountBG:SetActive(false)
      local reward = PlayerData:GetFactoryData(commoditData.rewardList[1].id)
      Group_Bottom.Txt_discount:SetText(commoditData.rewardList[1].num .. " " .. reward.name)
      if commoditData.rewardFollowList and table.count(commoditData.rewardFollowList) ~= 0 then
        Group_Bottom.Txt_FollowCharge:SetActive(true)
        Group_Bottom.Txt_FollowCharge:SetText(string.format(GetText(80601197), commoditData.rewardFollowList[1].num))
        local ca = PlayerData:GetFactoryData(commoditData.rewardFollowList[1].id)
        Group_Bottom.Txt_discount:SetText(commoditData.rewardList[1].num .. " " .. reward.name .. "+" .. commoditData.rewardFollowList[1].num .. " " .. ca.name)
      end
    end
    Btn_Item.Img_diamond:SetSprite(commoditData.iconPath)
    local displayPrice = PayProductHelper.GetProductDisplayPrice(commoditData.id, true)
    Group_Bottom.Txt_price:SetText(displayPrice)
    Btn_Item.Txt_Name:SetText(commoditData.name)
  end,
  Store_Group_DiamondStore_ScrollGrid_List_Group_diamondItem_Btn_Item_Click = function(btn, str)
    local row = DataModel.Now_ShopList.shopList[tonumber(str)]
    local metaId = tostring(row.id)
    local shopId = DataModel.Shop_Id
    local payAmount = row.commoditData.value
    local name = row.commoditData.name
    local priceStr = PayProductHelper.GetProductDisplayPrice(metaId, true)
    local uiParams = Json.encode({
      name = name,
      price = priceStr,
      itemId = metaId,
      shopId = shopId,
      payAmount = payAmount
    })
    
    local function callback(json)
      row.num = row.num and row.num + 1 or 1
      local recharge = PlayerData.RechargeGoods[tostring(DataModel.Shop_Id)]
      if recharge then
        if recharge[tostring(row.id)] then
          recharge[tostring(row.id)].num = row.num
        else
          recharge[tostring(row.id)] = {}
          recharge[tostring(row.id)].num = row.num
        end
      else
        recharge = {}
        recharge[tostring(row.id)] = {}
        recharge[tostring(row.id)].num = row.num
      end
      if row.num == 1 then
        local commoditData = row.commoditData
        local element = View.Group_DiamondStore.ScrollGrid_List.grid[tonumber(str)]
        local Btn_Item = element.Btn_Item
        local Group_Bottom = Btn_Item.Group_Bottom
        local Img_discountBG = Btn_Item.Img_discountBG
        local count = 0
        if commoditData.rewardFirstList and 0 < table.count(commoditData.rewardFirstList) then
          count = table.count(commoditData.rewardFirstList)
        end
        if commoditData.isFirst == true and 0 < count and row.num == 0 then
          local rewardFirst = PlayerData:GetFactoryData(commoditData.rewardFirstList[1].id)
          Img_discountBG.Txt_FirstCharge:SetText(string.format(GetText(80600198), commoditData.rewardFirstList[1].num))
          local reward = PlayerData:GetFactoryData(commoditData.rewardList[1].id)
          Group_Bottom.Txt_discount:SetText(commoditData.rewardList[1].num .. " " .. reward.name .. "+" .. commoditData.rewardFirstList[1].num .. " " .. rewardFirst.name)
          Group_Bottom.Txt_discountNum:SetActive(true)
          Img_discountBG:SetActive(true)
        else
          Group_Bottom.Txt_discountNum:SetActive(false)
          Img_discountBG:SetActive(false)
          local reward = PlayerData:GetFactoryData(commoditData.rewardList[1].id)
          Group_Bottom.Txt_discount:SetText(commoditData.rewardList[1].num .. reward.name)
          if commoditData.rewardFollowList and table.count(commoditData.rewardFollowList) ~= 0 then
            Group_Bottom.Txt_FollowCharge:SetActive(true)
            Group_Bottom.Txt_FollowCharge:SetText(string.format(GetText(80601197), commoditData.rewardFollowList[1].num))
            local ca = PlayerData:GetFactoryData(commoditData.rewardFollowList[1].id)
            Group_Bottom.Txt_discount:SetText(commoditData.rewardList[1].num .. reward.name .. "+" .. commoditData.rewardFollowList[1].num .. ca.name)
          end
        end
      end
      View.Group_DiamondStore.Btn_Medal.Txt_Num:SetText(PlayerData:GetGoodsById(11400005).num)
      CommonTips.OpenShowItem(json.reward)
      Controller:Recharge()
    end
    
    PayHelper.Buy(metaId, callback, uiParams)
  end,
  Store_Group_GoldStore_StaticGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.Choose_List.items[tonumber(elementIndex)]
    local commoditData = PlayerData:GetFactoryData(tonumber(row.id))
    row.commoditData = commoditData
    row.name = commoditData.commodityName
    row.image = commoditData.commodityView
    row.residue = 0
    local Btn_Item = element.Btn_Item
    Btn_Item.self:SetClickParam(elementIndex)
    Btn_Item.Txt_ItemName:SetText(row.name)
    local Item = PlayerData:GetFactoryData(commoditData.commodityItemList[1].id)
    Btn_Item.Img_ItemBG.Img_Item:SetSprite(row.image)
    local quantity = Item.qualityInt
    Btn_Item.Img_ItemBG:SetSprite(UIConfig.BottomConfig[quantity + 1])
    row.qualityInt = quantity
    local purchase = commoditData.purchase
    if purchase == true then
      local maxNum = DataModel:GetPurchaseNum(commoditData)
      row.residue = maxNum - row.py_cnt
      if row.residue < 0 then
        row.residue = 0
      end
      Btn_Item.Img_ItemBG.Txt_ResidueNum:SetText(string.format(GetText(80600430), row.residue))
      if row.residue == 0 then
        Btn_Item.Img_Sold.self:SetActive(true)
      else
        Btn_Item.Img_Sold.self:SetActive(false)
      end
    else
      Btn_Item.Img_ItemBG.Txt_ResidueNum:SetText("")
    end
    Btn_Item.Img_ItemBG.Txt_Num:SetText(commoditData.commodityNum or 1)
    local money = commoditData.moneyList[1]
    if money then
      Btn_Item.Img_Money:SetActive(true)
      local left_money = PlayerData:GetFactoryData(tonumber(commoditData.moneyList[1].moneyID))
      Btn_Item.Img_Money.self:SetSprite(left_money.iconPath)
      Btn_Item.Img_Money.Txt_MoneyNum:SetText(commoditData.moneyList[1].moneyNum)
      return
    end
    Btn_Item.Img_Money:SetActive(false)
  end,
  Store_Group_GoldStore_StaticGrid_List_Group_Item_Btn_Item_Click = function(btn, str)
    local row = DataModel.Choose_List.items[tonumber(str)]
    if row.residue == 0 then
      CommonTips.OpenTips(80600077)
      return
    end
    row.index = tonumber(str) - 1
    row.shopid = DataModel.shop_id
    CommonTips.OpenBuyTips(row)
  end,
  Store_Group_GoldStore_Group_Bottom_Img_Backgroud_Img_refresh_Btn_Mask_Click = function(btn, str)
    local sever_now = PlayerData.ServerData.server_now
    if freeCount - DataModel.Choose_List.refresh_num > 0 then
      SendRefreshShop()
      return
    elseif PlayerData:GetPlayerPrefs("int", "refreshState" .. DataModel.shop_id) == 0 and sever_now ~= PlayerData:GetPlayerPrefs("int", "lastautorefresh" .. DataModel.shop_id) then
      OpenStockPage()
    else
      ConsRockRefresh()
    end
  end,
  Store_Group_GoldStore_Group_Bottom_Img_Backgroud_Btn_Refresh_Click = function(btn, str)
  end,
  Store_Group_GoldStore_Group_Reward_Btn_Back_Click = function(btn, str)
  end,
  Store_Group_GoldStore_Group_Reward_StaticGrid_Box_SetGrid = function(element, elementIndex)
  end,
  Store_Group_GoldStore_Group_Reward_StaticGrid_Box_Group_Box_Btn_Box_Click = function(btn, str)
  end,
  Store_Group_GoldStore_Group_Reward_StaticGrid_Box_Group_Box_Btn_Box_Group_NoGet_Btn_Preview_Click = function(btn, str)
  end,
  Store_Group_GoldStore_Group_Reward_StaticGrid_Box_Group_Box_Btn_Box_Group_Got_Btn_Preview_Click = function(btn, str)
  end,
  Store_Group_GoldStore_Group_Reward_StaticGrid_Box_Group_Box_Btn_Box_Group_CanGet_Btn_Get_Click = function(btn, str)
  end,
  Store_Group_GoldStore_Group_Reward_StaticGrid_Box_Group_Box_Group_Preview_StaticGrid_Item_SetGrid = function(element, elementIndex)
  end,
  Store_Group_GoldStore_Group_Reward_StaticGrid_Box_Group_Box_Group_Preview_StaticGrid_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Store_Group_DiamondStore_Btn_Medal_Click = function(btn, str)
    Controller.ChooseTopList(DataModel.GetStoreIndexByShopId(80300003))
  end,
  Store_Group_GiftStore_Btn_Medal_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  Store_Group_DiamondStore_Btn_Medal_Btn_Add_Click = function(btn, str)
  end,
  Store_Group_GiftStore_Btn_Medal_Btn_Add_Click = function(btn, str)
  end,
  Store_Group_RecommendStore_Btn_Medal_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  Store_Group_RecommendStore_Btn_Medal_Btn_Add_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  Store_Group_RecommendStore_Btn_Recommend_Click = function(btn, str)
    local row = DataModel.RecommendList[DataModel.RecommedIndex]
    local urlPath
    if GameSetting.platform == "Android" then
      urlPath = row.andPath
    elseif GameSetting.platform == "Harmony" then
      urlPath = row.andPath
    elseif GameSetting.platform == "StandaloneWindows64" then
      urlPath = row.andPath
    elseif GameSetting.platform == "IOS" then
      urlPath = row.iosPath
    end
    if not string.nilorempty(urlPath) then
      ApplicationHelper.OpenUrl(urlPath)
      return
    end
    if row.type == "SkipStore" then
      Controller.ChooseTopList(DataModel.GetStoreIndexByShopId(row.storeId))
      return
    end
    if row.type == "SkipPage" then
      if row.otherUI ~= "" then
        if PlayerData:GetNowPassData() == false then
          CommonTips.OpenTips(80602313)
          return
        end
        UIManager:Open(row.otherUI)
      end
      return
    end
    if row.type == "Buy" then
      DataModel.RefreshState = 1
      if row.isLock then
        CommonTips.OpenTips(80601023)
        return
      end
      if row.isMax then
        Controller.ChooseTopList(DataModel.GetStoreIndexByShopId(row.storeId))
        return
      end
      if row.id == -1 then
        return
      end
      Controller.ChooseTopList(DataModel.GetStoreIndexByShopId(row.storeId))
      local data, labelIndex = DataModel:JunmpStorePageData(row.storeId, row.id)
      if (row.storeId == 80300323 or row.storeId == 80302554) and labelIndex then
        Controller:ClickGroupGiftGroupLabelElement(labelIndex)
      end
      if row.storeId == 80301713 and labelIndex then
        Controller:ClickGroupSkinLabelElement(labelIndex)
      end
      local params = {}
      params.id = row.id
      params.name = row.name
      params.commoditData = row.commoditData
      params.num = row.num
      
      local function callback()
        local metaId = tostring(row.id)
        local shopId = DataModel.Shop_Id
        local name = params.commoditData.name
        local payAmount = row.commoditData.value
        local priceStr = PayProductHelper.GetProductDisplayPrice(metaId)
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
        end, uiParams)
      end
      
      CommonTips.OnBuyGiftTips(params, callback)
      PlayerData:SetPlayerPrefs("int", "StoreRed" .. row.id, 1)
      return
    end
  end,
  Store_Group_RecommendStore_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.RecommendList[tonumber(elementIndex)]
    element.Btn_:SetClickParam(tonumber(elementIndex))
    element.Group_Off.self:SetActive(true)
    element.Group_On.self:SetActive(false)
    element.Group_Off.Img_Tab:SetSprite(row.tabPng)
    element.Group_On.Img_Tab:SetSprite(row.tabPng)
    element.Group_Off.Txt_Name:SetText(row.name)
    element.Group_On.Txt_Name:SetText(row.name)
  end,
  Store_Group_RecommendStore_ScrollGrid_List_Group_Item_Btn__Click = function(btn, str)
    DataModel.ChooseRecommedStore(tonumber(str))
  end,
  Store_Group_GiftStore_NewScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetGiftStoreGroupGiftElement(element, elementIndex)
  end,
  Store_Group_GiftStore_NewScrollGrid_List_Group_gift_Btn_Item_Click = function(btn, str)
    Controller:ClickGiftStoreGroupGiftElement(btn, str)
  end,
  Store_Group_GiftStore_NewScrollGrid_List_Group_gift_Btn_Item_Group_Bottom_Btn_Help_Click = function(btn, str)
    View.Group_MoonTips.self:SetActive(true)
  end,
  Store_Group_SkinPreStore_Btn_Medal_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  Store_Group_SkinPreStore_Btn_Medal_Btn_Add_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  Store_Group_SkinPreStore_NewScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetSkinPreStoreGroupNewGiftElement(element, elementIndex)
  end,
  Store_Group_SkinPreStore_NewScrollGrid_List_Group_gift_Btn_Item_Click = function(btn, str)
    Controller:ClickSkinPreStoreGroupNewGiftElement(btn, str)
  end,
  Store_Group_SkinPreStore_NewScrollGrid_List_Group_gift_Btn_Item_Group_Bottom_Btn_Help_Click = function(btn, str)
  end,
  Store_Group_GiftStore_Group_Label_NewScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetGroupGiftGroupLabelElement(element, elementIndex)
  end,
  Store_Group_GiftStore_Group_Label_NewScrollGrid_List_Group_Item_Btn__Click = function(btn, str)
    Controller:ClickGroupGiftGroupLabelElement(str)
  end,
  Store_Group_SkinPreStore_Group_Label_NewScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetGroupSkinLabelElement(element, elementIndex)
  end,
  Store_Group_SkinPreStore_Group_Label_NewScrollGrid_List_Group_Item_Btn__Click = function(btn, str)
    Controller:ClickGroupSkinLabelElement(str)
  end,
  Store_Group_RestStore_Btn_Medal_Btn_Add_Click = function(btn, str)
  end,
  Store_Group_RestStore_ScrollGrid_List_SetGrid = function(element, elementIndex)
    Controller:SetResetGroupElement(element, elementIndex)
  end,
  Store_Group_RestStore_ScrollGrid_List_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    Controller:ClickResetGroupElemet(btn, str)
  end,
  Store_Group_RestStore_ScrollGrid_List_Group_Item_Group_Item_Btn_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Store_Group_RestStore_Btn_Record_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(11400017)
  end,
  Store_Group_RestStore_Btn_Coin_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(11400001)
  end,
  Store_Group_RestStore_Btn_Medal_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  Store_Group_Exchange_Group_Middle_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local itemId = DataModel.ExchangeStoreList[elementIndex].id
    local ca = PlayerData:GetFactoryData(itemId, "CommondityFactory")
    element.Img_Icon.self:SetSprite(ca.commodityView)
    local itemParam = ca.commodityItemList[1].id
    element.Img_Icon.Btn_:SetClickParam(itemParam)
    local isShowQuality = false
    if DataManager:GetFactoryNameById(itemParam) == "EquipmentFactory" then
      isShowQuality = true
    end
    element.Group_Quality.self:SetActive(isShowQuality)
    if isShowQuality then
      local equipCA = PlayerData:GetFactoryData(itemParam)
      local qualityNum = equipCA.qualityInt + 1
      element.Group_Quality.Img_Quality:SetSprite(UIConfig.ItemTipQuality[qualityNum])
    end
    element.Group_Name.Txt_Name:SetActive(false)
    element.Group_Name.Txt_NameL:SetActive(true)
    element.Group_Name.Txt_NameL:SetText(string.format(GetText(80601981), ca.commodityName, ca.commodityNum))
    local moneyList = ca.moneyList
    local groupItem = element.Group_Item
    local consumeGrid = element.ScrollGrid_List
    consumeGrid.self:SetActive(3 < #moneyList)
    groupItem.self:SetActive(#moneyList <= 3)
    if #moneyList <= 3 then
      for i = 1, 3 do
        local isShow = i <= #moneyList
        local groupConsume = groupItem["Group_Consume" .. i]
        groupConsume.self:SetActive(isShow)
        if isShow then
          local moneyData = moneyList[i]
          Controller:SetGroupConsume(groupConsume, moneyData, elementIndex)
        end
      end
    else
      consumeGrid.grid.self:SetParentParam(elementIndex)
      consumeGrid.grid.self:SetDataCount(#moneyList)
      consumeGrid.grid.self:RefreshAllElement()
      consumeGrid.grid.self:MoveToTop()
    end
    local isPurchase = ca.purchase
    element.Group_Num.self:SetActive(isPurchase)
    local groupBtn = element.Group_Btn
    groupBtn.Group_Can.Btn_:SetClickParam(elementIndex)
    if isPurchase then
      local itemBuyCount = DataModel.itemBuyCount[tonumber(itemId)] or 0
      local maxNum = DataModel:GetPurchaseNum(ca)
      local remainCount = math.max(0, maxNum - itemBuyCount)
      local textIdEnuogh = 80601872
      local textIdUnEnuogh = 80601873
      if ca.limitBuyType == "Forever" then
        textIdEnuogh = 80601872
        textIdUnEnuogh = 80601873
      elseif ca.limitBuyType == "Daily" then
        textIdEnuogh = 80602203
        textIdUnEnuogh = 80602202
      elseif ca.limitBuyType == "Weekly" then
        textIdEnuogh = 80602204
        textIdUnEnuogh = 80602205
      elseif ca.limitBuyType == "Monthly" then
        textIdEnuogh = 80602206
        textIdUnEnuogh = 80602207
      end
      if 0 < remainCount then
        element.Group_Num.Txt_Num:SetText(string.format(GetText(textIdEnuogh), remainCount))
      else
        element.Group_Num.Txt_Num:SetText(GetText(textIdUnEnuogh))
      end
      groupBtn.Group_Can.self:SetActive(0 < remainCount)
      groupBtn.Group_Not.self:SetActive(remainCount <= 0)
      element.Group_Allready.self:SetActive(remainCount <= 0)
    else
      element.Group_Allready.self:SetActive(false)
      groupBtn.Group_Can.self:SetActive(true)
      groupBtn.Group_Not.self:SetActive(false)
    end
    local extraGiveList = ca.extraGiveList
    local groupExtra = element.Group_Extra
    groupExtra.self:SetActive(0 < #extraGiveList)
    if 0 < #extraGiveList then
      groupExtra.Txt_Num:SetText(string.format(GetText(80601880), extraGiveList[1].num))
      groupExtra.Img_Icon:SetSprite(PlayerData:GetFactoryData(extraGiveList[1].id).iconPath)
      groupExtra.Img_Icon.Btn_:SetClickParam(extraGiveList[1].id)
    end
    local isTime = ca.isTime
    local groupTime = element.Group_Time
    groupTime.self:SetActive(isTime)
    if isTime then
      local remainTime = TimeUtil:SecondToTable(TimeUtil:LastTime(ca.endTime))
      groupTime.Txt_Time:SetText(string.format(GetText(80601059), remainTime.day, remainTime.hour))
    end
    local isGradeLimit = false
    if ca.isBuyCondition then
      local gradeCondition = ca.gradeCondition
      if gradeCondition > PlayerData:GetUserInfo().lv then
        isGradeLimit = true
        element.Group_Grade.Txt_Grade:SetText(string.format(GetText(80607663), gradeCondition))
      end
    end
    element.Group_Grade:SetActive(isGradeLimit)
  end,
  Store_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Img_Icon_Btn__Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  Store_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Item_Group_Consume1_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  Store_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Item_Group_Consume2_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  Store_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Item_Group_Consume3_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(str, nil, true)
  end,
  Store_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_ScrollGrid_List_SetGrid = function(element, elementIndex)
  end,
  Store_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_ScrollGrid_List_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Store_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Btn_Group_Can_Btn__Click = function(btn, str)
    local itemId = DataModel.ExchangeStoreList[tonumber(str)].id
    local ca = PlayerData:GetFactoryData(itemId, "CommondityFactory")
    if ca.isBuyCondition then
      local gradeCondition = ca.gradeCondition
      if gradeCondition > PlayerData:GetUserInfo().lv then
        return
      end
    end
    if DataModel.notEnoughMap[tonumber(str)] then
      CommonTips.OpenTips(80601871)
      return
    end
    local maxNum = DataModel:GetPurchaseNum(ca)
    local remainBuyNum = ca.purchase ~= true and -1 or math.max(0, maxNum - (DataModel.itemBuyCount[tonumber(itemId)] or 0))
    UIManager:Open("UI/Common/ExchangeTips", Json.encode({
      commodityId = itemId,
      remainNum = remainBuyNum,
      shopId = DataModel.Shop_Id,
      index = DataModel.ExchangeStoreList[tonumber(str)].commodityIndex
    }), function()
      Controller.OpenStorePage()
    end)
  end,
  Store_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Btn_Group_Not_Btn__Click = function(btn, str)
  end,
  Store_Group_Exchange_Group_Middle_ScrollGrid_List_Group_Item_Group_Extra_Img_Icon_Btn__Click = function(btn, str)
  end,
  Store_Group_RestStore_Btn_PL_Click = function(btn, str)
    Controller:ClickBatchBtn()
  end,
  Store_Group_RestStore_Group_PL_Group_SelectAll_Btn__Click = function(btn, str)
    Controller:ClickBatchAll()
  end,
  Store_Group_RestStore_Group_PL_Btn_Buy_Click = function(btn, str)
    Controller:ConfirmBatchBuy()
  end,
  Store_Group_SignGift_Btn_Medal_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  Store_Group_SignGift_Btn_Medal_Btn_Add_Click = function(btn, str)
    CommonTips.OpenStoreBuy()
  end,
  Store_Group_SignGift_Group_Middle_Group_7_StaticGrid_List_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshRewardElementItemShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_7_StaticGrid_List_Group_Reward_StaticGrid_Reward_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshItemElementShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_7_StaticGrid_List_Group_Reward_StaticGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_7_StaticGrid_List_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshItemElementShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_7_StaticGrid_List_Group_Reward_ScrollGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_7_StaticGrid_List_Group_Reward_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_6_StaticGrid_List_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshRewardElementItemShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_6_StaticGrid_List_Group_Reward_StaticGrid_Reward_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshItemElementShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_6_StaticGrid_List_Group_Reward_StaticGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_6_StaticGrid_List_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshItemElementShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_6_StaticGrid_List_Group_Reward_ScrollGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_6_StaticGrid_List_Group_Reward_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_5_StaticGrid_List_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshRewardElementItemShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_5_StaticGrid_List_Group_Reward_StaticGrid_Reward_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshItemElementShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_5_StaticGrid_List_Group_Reward_StaticGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_5_StaticGrid_List_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshItemElementShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_5_StaticGrid_List_Group_Reward_ScrollGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_5_StaticGrid_List_Group_Reward_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_4_StaticGrid_List_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshRewardElementItemShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_4_StaticGrid_List_Group_Reward_StaticGrid_Reward_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshItemElementShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_4_StaticGrid_List_Group_Reward_StaticGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_4_StaticGrid_List_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshItemElementShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_4_StaticGrid_List_Group_Reward_ScrollGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_4_StaticGrid_List_Group_Reward_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_3_StaticGrid_List_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshRewardElementItemShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_3_StaticGrid_List_Group_Reward_StaticGrid_Reward_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshItemElementShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_3_StaticGrid_List_Group_Reward_StaticGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_3_StaticGrid_List_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
    SignGiftController.RefreshItemElementShow(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_3_StaticGrid_List_Group_Reward_ScrollGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_3_StaticGrid_List_Group_Reward_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_Short_StaticGrid_Reward_SetGrid = function(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_Short_StaticGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_Short_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_Short_ScrollGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_Short_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_Long_StaticGrid_Reward_SetGrid = function(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_Long_StaticGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_Long_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_Long_ScrollGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_Long_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_Reward_StaticGrid_Reward_SetGrid = function(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_Reward_StaticGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_Reward_ScrollGrid_Reward_SetGrid = function(element, elementIndex)
  end,
  Store_Group_SignGift_Group_Middle_Group_Reward_ScrollGrid_Reward_Group_Item_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_Reward_Btn__Click = function(btn, str)
  end,
  Store_Group_SignGift_Group_Middle_Group_Btn_Btn__Click = function(btn, str)
    SignGiftController.OnBuyGiftBtnClick()
  end,
  Store_Btn_BlackMoon_Click = function(btn, str)
    local index = DataModel.GetStoreIndexByShopId(80300004)
    Controller.ChooseTopList(index)
    View.ScrollGrid_TopButton.grid.self:MoveToPos(index)
  end,
  Store_Group_Recharge_StaticGrid_Btn_SetGrid = function(element, elementIndex)
    Controller:SetActivityRechargeElement(element, elementIndex)
  end,
  Store_Group_Recharge_StaticGrid_Btn_Group_ActivityRecharge_Btn_Item_Click = function(btn, str)
    OpenActivityRecharge(str)
  end
}
return ViewFunction
