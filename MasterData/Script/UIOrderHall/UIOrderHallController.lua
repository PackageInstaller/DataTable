local DataModel = require("UIOrderHall/UIOrderHallDataModel")
local View = require("UIOrderHall/UIOrderHallView")
local CommonItem = require("Common/BtnItem")
local NPCDialog = require("Common/NPCDialog")
local Controller = {}

function Controller:Init()
  DataModel.Init()
  DataModel.sortType = nil
  DataModel.CurrentTab = 1
  Controller.SelectSortType(DataModel.Enum_SortType.all)
  View.Group_Hall.Group_Filter.StaticGrid_.grid.self:SetDataCount(#DataModel.SortTypeData)
  View.Group_Hall.Group_Filter.StaticGrid_.grid.self:RefreshAllElement()
  Controller:SwitchTab(DataModel.CurrentTab, true)
  View.Group_Hall.Img_NPC:SetActive(false)
  View.Group_Invite.Img_NPC:SetActive(false)
  View.Group_Hall.Group_NPC:SetActive(true)
  View.Group_Invite.Group_NPC:SetActive(true)
  NPCDialog.SetNPC(View.Group_Hall.Group_NPC, 83700159)
  NPCDialog.SetNPC(View.Group_Invite.Group_NPC, 83700158)
  Controller:SetNPCDialog(DataModel.NPCDialogEnum.enterText)
end

function Controller.ShowSort(active)
  if not active then
    View.Group_Hall.Group_FilterTitle.Img_Down:SetActive(false)
    View.Group_Hall.Group_Filter:SetActive(false)
    View.Group_Hall.Group_NPC.Img_Dialog:SetActive(true)
    View.Group_Hall.Group_NPC.Img_Name:SetActive(true)
    return
  end
  View.Group_Hall.Group_NPC.Img_Dialog:SetActive(false)
  View.Group_Hall.Group_NPC.Img_Name:SetActive(false)
  View.Group_Hall.Group_FilterTitle.Img_Down:SetActive(true)
  View.Group_Hall.Group_Filter:SetActive(true)
  View.Group_Hall.Group_Filter.StaticGrid_.grid.self:RefreshAllElement()
end

function Controller.SelectSortType(sortType)
  if DataModel.sortType == sortType then
    return false
  end
  DataModel.sortType = sortType
  View.Group_Hall.Group_FilterTitle.Img_Down:SetActive(false)
  View.Group_Hall.Group_Filter:SetActive(false)
  View.Group_Hall.Group_FilterTitle.Txt_:SetText(GetText(DataModel.SortTypeData[sortType].txtId))
  return true
end

function Controller:SetNPCDialog(dialogEnum)
  local element = DataModel.CurrentTab == 1 and View.Group_Hall.Group_NPC or View.Group_Invite.Group_NPC
  local npcId = DataModel.CurrentTab == 1 and DataModel.NPCHallId or DataModel.NPCInviteId
  local npcConfig = PlayerData:GetFactoryData(npcId, "NPCFactory")
  local textTable = npcConfig[dialogEnum]
  if textTable == nil then
    return
  end
  Controller.ShowSort(false)
  NPCDialog.SetNPCText(element, textTable, dialogEnum)
end

function Controller:SwitchTab(tab, isEnter)
  DataModel.CurrentTab = tab
  View.Group_Invite:SetActive(tab == 2)
  View.Group_Hall:SetActive(tab == 1)
  if tab == 1 then
    Controller:OpenHallPanel(true)
  else
    Controller:OpenInvitePanel(true)
  end
  local inviteList = PlayerData.ServerData.user_info.being_invite_data
  View.Group_Hall.Img_RedPoint:SetActive(inviteList and table.count(inviteList) > 0)
end

function Controller:OpenHallPanel(isEnter)
  Net:SendProto("future.hall", function(json)
    if json.hall_order then
      PlayerData.ServerData.user_info.hall_order = json.hall_order
    end
    DataModel.RefreshHallOrderData()
    Controller:SelectOrder(1, isEnter)
    local curJoinCount = PlayerData.ServerData.user_info.future_base_info.daily_add_other_count
    local totalJoinCount = PlayerData:GetFactoryData(99900134).teamOrderNum
    local remainCount = totalJoinCount - curJoinCount
    View.Group_JoinTeamNum.Txt_Num:SetText(remainCount .. "/" .. totalJoinCount)
  end, DataModel.SortTypeData[DataModel.sortType].str)
end

function Controller:OpenInvitePanel(isEnter)
  Net:SendProto("future.being_invite_list", function(json)
    if json.being_invite_data then
      PlayerData.ServerData.user_info.being_invite_data = json.being_invite_data
      DataModel.RefreshBeingInviteData()
      Controller:SelectOrder(1, isEnter)
      local curJoinCount = PlayerData.ServerData.user_info.future_base_info.daily_add_other_count
      local totalJoinCount = PlayerData:GetFactoryData(99900134).teamOrderNum
      local remainCount = totalJoinCount - curJoinCount
      View.Group_JoinTeamNum.Txt_Num:SetText(remainCount .. "/" .. totalJoinCount)
    end
  end)
end

function Controller:SetRewardElement(element, elementIndex)
  local reward = DataModel.CurrentOrderRewardList[elementIndex]
  CommonItem:SetItem(element, reward)
  element.Img_Num.Txt_:SetText(reward.num)
  element.Btn_:SetClickParam(reward.id)
end

function Controller:RefreshReward()
  local data = DataModel.CurrentTab == 1 and DataModel.HallOrderList[DataModel.CurSelectOrderIndex] or DataModel.BeingInviteList[DataModel.CurSelectOrderIndex]
  local rewardList = DataModel.GetOrderReward(data.uid, data.id)
  DataModel.CurrentOrderRewardList = rewardList
  View.Group_OrderInfo.Group_Reward.ScrollGrid_Reward.grid.self:SetDataCount(#rewardList)
  View.Group_OrderInfo.Group_Reward.ScrollGrid_Reward.grid.self:RefreshAllElement()
end

function Controller:SetTeamMemberElement(element, elementIndex)
  local order = DataModel.CurrentTab == 1 and DataModel.HallOrderList[DataModel.CurSelectOrderIndex] or DataModel.BeingInviteList[DataModel.CurSelectOrderIndex]
  local team = order.team or {}
  local member = team[elementIndex]
  if member then
    element.Img_Member:SetActive(true)
    element.Img_Member:SetSprite(PlayerData:GetFactoryData(member.avatar).imagePath)
    CommonTips:SetPlayerHeadShader(element.Img_spAdd, PlayerData:GetFactoryData(member.avatar))
  else
    element.Img_Member:SetActive(false)
  end
end

function Controller:RefreshTeamMember()
  View.Group_OrderInfo.Group_Team.StaticGrid_Member.grid.self:SetDataCount(5)
  View.Group_OrderInfo.Group_Team.StaticGrid_Member.grid.self:RefreshAllElement()
end

function Controller:SetOrderElement(element, elementIndex)
  local data = DataModel.CurrentTab == 1 and DataModel.HallOrderList[elementIndex] or DataModel.BeingInviteList[elementIndex]
  local hasOrder = data and next(data) ~= nil
  element.Group_Team:SetActive(hasOrder)
  element.Group_Empty:SetActive(not hasOrder)
  element.Img_Pick:SetActive(elementIndex == DataModel.CurSelectOrderIndex)
  element.Btn_:SetClickParam(elementIndex)
  if hasOrder then
    local orderCfg = PlayerData:GetFactoryData(data.id)
    local requireItem = orderCfg.requireItemList[1]
    local requireItemCfg = PlayerData:GetFactoryData(requireItem.id)
    local requireCount = DataModel.GetOrderRequireCount(data.uid, data.id)
    element.Group_Team.Img_bg.Img_Item:SetSprite(requireItemCfg.iconPath or requireItemCfg.imagePath)
    element.Group_Team.Img_bg.Txt_Num:SetText(requireCount)
    element.Group_Team.Img_bg.Txt_Item:SetText(orderCfg.name)
    element.Group_Team.Img_.Txt_Num:SetText(table.count(data.team) .. "/" .. 5)
  end
end

function Controller:RefreshOrderList()
  View.Group_Order.StaticGrid_Order.grid.self:SetDataCount(6)
  View.Group_Order.StaticGrid_Order.grid.self:RefreshAllElement()
end

function Controller:SelectOrder(idx, isEnter)
  DataModel.CurSelectOrderIndex = idx
  Controller:RefreshOrderList()
  Controller:RefreshOrderInfoPanel()
  if isEnter then
    Controller:SetNPCDialog(DataModel.NPCDialogEnum.enterText)
  else
    Controller:SetNPCDialog(DataModel.NPCDialogEnum.chooseOrderText)
  end
end

function Controller:RefreshOrderInfoPanel()
  local data = DataModel.CurrentTab == 1 and DataModel.HallOrderList[DataModel.CurSelectOrderIndex] or DataModel.BeingInviteList[DataModel.CurSelectOrderIndex]
  local hasOrder = data and next(data) ~= nil
  View.Group_OrderInfo:SetActive(hasOrder)
  DataModel.CurOrderEndTime = -1
  View.Group_OrderInfo.Group_Title.Txt_Title:SetText("")
  View.Group_OrderInfo.Group_Title.Txt_Des:SetText("")
  View.Group_NoOrder:SetActive(not hasOrder)
  View.Group_OrderInfo:SetActive(hasOrder)
  if hasOrder then
    View.Group_OrderInfo.Group_Team.Group_TeamNum.Txt_Num:SetText(table.count(data.team) .. "/" .. 5)
    local remainTime = data.endTime - TimeUtil:GetServerTimeStamp()
    DataModel.CurOrderEndTime = data.endTime
    local timeTable = TimeUtil:SecondToTableHMS(remainTime)
    View.Group_OrderInfo.Group_Team.Group_Time.Txt_Time:SetText(string.format("%02d:%02d:%02d", timeTable.hour, timeTable.minute, timeTable.second))
    Controller:RefreshTeamMember()
    Controller:RefreshReward()
    local orderCfg = PlayerData:GetFactoryData(data.id)
    local requireCount = DataModel.GetOrderRequireCount(data.uid, data.id)
    local curDeliver = DataModel.GetOrderDeliverCount(data.uid)
    View.Group_OrderInfo.Group_Reward.Txt_1:SetText(math.floor(curDeliver / requireCount * 100 + 0.5) .. "%")
    View.Group_OrderInfo.Group_Reward.Img_Circle:SetFilledImgAmount(curDeliver / requireCount)
    View.Group_OrderInfo.Group_Team.Btn_Join:SetActive(not DataModel.IsInTeam(data.uid))
    View.Group_OrderInfo.Group_Title.Txt_Title:SetText(string.format(GetText(80607880), orderCfg.name))
    View.Group_OrderInfo.Group_Title.Txt_Des:SetText(string.format(orderCfg.des, requireCount))
  end
end

function Controller:TryJoinOrder()
  local cfg = PlayerData:GetFactoryData("99900134")
  local level = PlayerData:GetHomeInfo().compound_lv or 0
  if level < cfg.teamRepLimit then
    CommonTips.OpenTips("80610783")
    return
  end
  local coinCount = PlayerData:GetGoodsById(11400001).num
  local data = DataModel.CurrentTab == 1 and DataModel.HallOrderList[DataModel.CurSelectOrderIndex] or DataModel.BeingInviteList[DataModel.CurSelectOrderIndex]
  local orderCfg = PlayerData:GetFactoryData(data.id)
  local factory = DataModel.GetOrderFactorValue(data.uid)
  local requireCount = orderCfg.moneyList[1].num * factory / 5
  if coinCount < requireCount then
    CommonTips.OpenTips(80600260)
    return
  end
  Net:SendProto("future.join_other_order", function(json)
    if json.join_my_orders then
      PlayerData.ServerData.user_info.join_my_orders = json.join_my_orders
    end
    if json.join_other_orders then
      PlayerData.ServerData.user_info.join_other_orders = json.join_other_orders
    end
    if json.future_base_info then
      PlayerData.ServerData.user_info.future_base_info = json.future_base_info
    end
    if DataModel.CurrentTab == 1 then
      Controller:OpenHallPanel()
    else
      Controller:OpenInvitePanel()
    end
    if json.fail then
      if tonumber(json.fail) == 1 then
        CommonTips.OpenTips(80610824)
      elseif tonumber(json.fail) == 2 then
        CommonTips.OpenTips(80610782)
      end
      return
    else
      CommonTips.OpenTips(80611040)
    end
    Controller:SetNPCDialog(DataModel.NPCDialogEnum.joinOrderText)
  end, data.uid, DataModel.CurrentTab == 1 and "hall" or "invite")
end

function Controller:UpdateOrderRemainTime()
  if DataModel.CurOrderEndTime > 0 then
    local remainTime = DataModel.CurOrderEndTime - TimeUtil:GetServerTimeStamp()
    local timeTable = TimeUtil:SecondToTableHMS(remainTime)
    View.Group_OrderInfo.Group_Team.Group_Time.Txt_Time:SetText(string.format("%02d:%02d:%02d", timeTable.hour, timeTable.minute, timeTable.second))
  end
end

function Controller:TryRefreshHallOrder()
  Net:SendProto("future.hall", function(json)
    if json.hall_order then
      PlayerData.ServerData.user_info.hall_order = json.hall_order
    end
    DataModel.RefreshHallOrderData()
    Controller:SelectOrder(1)
    Controller:SetNPCDialog(DataModel.NPCDialogEnum.refreshOrderText)
  end, DataModel.SortTypeData[DataModel.sortType].str)
end

return Controller
