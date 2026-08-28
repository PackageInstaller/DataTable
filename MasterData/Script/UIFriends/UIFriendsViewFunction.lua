local View = require("UIFriends/UIFriendsView")
local DataModel = require("UIFriends/UIFriendsDataModel")
local Controller = require("UIFriends/UIFriendsLuaController")
local ViewFunction = {
  Friends_Group_Top_Btn_Refresh_Click = function(btn, str)
    Controller.GetRecommendFriend()
  end,
  Friends_Group_Top_InputField_Search_Btn_Search_Click = function(btn, str)
    if DataModel.status == 2 then
      Controller.SearchFriend()
      return
    end
    Controller.MacthFriend()
  end,
  Friends_Group_CallingCard_Img_Info_StaticGrid_Text_SetGrid = function(element, elementIndex)
    element.Txt_Info:SetText(DataModel.PlayerInfoList[elementIndex])
  end,
  Friends_Group_CallingCard_Group_CardShow_Img_Show_StaticGrid_CollectCard_SetGrid = function(element, elementIndex)
    local data = DataModel.GetShowCardList()[elementIndex]
    element:SetActive(false)
    if data then
      element:SetActive(true)
      local cardId = data
      local cardCfg = PlayerData:GetFactoryData(cardId)
      element.Img_Card:SetSprite(cardCfg.iconPath)
    end
  end,
  Friends_Group_CallingCard_Group_CardShow_Img_Show_Btn_Change_Click = function(btn, str)
    if DataModel.status ~= 0 then
      return
    end
    View.Group_CardChoose:SetActive(true)
    DataModel.SetCardList()
    View.Group_CardChoose.CustomScrollGrid_List.self:UpdateGridWidthOrHeight(DataModel.height)
    View.myCustomSV:RefreshData(DataModel.cardDataList, View.Group_CardChoose.CustomScrollGrid_List.self.viewportCount)
    View.Group_CardChoose.CustomScrollGrid_List.self.scrollRect.verticalNormalizedPosition = 1
    View.myCustomSV:RefreshAllElement()
  end,
  Friends_Group_CallingCard_Group_Btn_Btn_Visit_Click = function(btn, str)
    Controller.CheckFriendTrain(DataModel.selectIdx)
  end,
  Friends_Group_CallingCard_Group_Btn_Btn_Add_Click = function(btn, str)
    local idx = 1
    Controller.AddFriend(idx)
  end,
  Friends_Group_CallingCard_Img_Imput_Btn_Input_Click = function(btn, str)
    if DataModel.status == 0 then
      View.Group_FriendsInput:SetActive(true)
      View.Group_FriendsInput.InputField_Penguin:SetActive(true)
      View.Group_FriendsInput.InputField_Remark:SetActive(false)
      View.Group_FriendsInput.InputField_Penguin:SetText("")
    end
  end,
  Friends_Group_RightList_Group_CallingCard_Btn_CallingCard_Click = function(btn, str)
    if DataModel.status ~= 0 then
      Controller.RefreshPanel(0)
    end
  end,
  Friends_Group_RightList_Group_List_Btn_List_Click = function(btn, str)
    if DataModel.status ~= 1 then
      Controller.RefreshPanel(1)
    end
  end,
  Friends_Group_RightList_Group_Add_Btn_Add_Click = function(btn, str)
    if DataModel.status ~= 2 then
      Controller.RefreshPanel(2)
    end
  end,
  Friends_Group_RightList_Group_Request_Btn_Request_Click = function(btn, str)
    if DataModel.status ~= 3 then
      Controller.RefreshPanel(3)
    end
  end,
  Friends_Group_RightList_Group_Invite_Btn_Request_Click = function(btn, str)
    if DataModel.status ~= 4 then
      Controller.RefreshPanel(4)
    end
  end,
  Friends_Group_CardChoose_Btn_Close_Click = function(btn, str)
    Controller.SetShowCard()
  end,
  Friends_Group_CardChoose_CustomScrollGrid_List_SetGrid = function(element, elementIndex)
    View.myCustomSV:SetItemShowAndHide(View.Group_CardChoose.CustomScrollGrid_List.self.currentPosXOrY)
  end,
  Friends_Group_CardChoose_CustomScrollGrid_List_Group_CardGroup_Img_GroupTitle_Btn_SelectAll_Click = function(btn, str)
    local suitIdx = tonumber(str)
    DataModel.UpdateShowCardList(nil, suitIdx)
    View.myCustomSV:ElementCallBack()
    View.Group_CallingCard.Group_CardShow.Img_Show.StaticGrid_CollectCard.grid.self:RefreshAllElement()
  end,
  Friends_Group_CardChoose_CustomScrollGrid_List_Group_CardGroup_StaticGrid_SelectCard_SetGrid = function(element, elementIndex)
    local cardList = DataModel.cardDataList[DataModel.nowIndx].list
    local cardId = cardList[elementIndex]
    if cardId == nil then
      element.Img_Card:SetActive(false)
      element.Btn_Select:SetActive(false)
      element.Img_Selected:SetActive(false)
      return
    end
    element.Img_Card:SetActive(true)
    element.Btn_Select:SetActive(true)
    element.Btn_Select:SetClickParam(cardId)
    local cardCfg = PlayerData:GetFactoryData(cardId)
    element.Img_Card:SetSprite(cardCfg.iconPath)
    element.Img_SelectBox:SetActive(DataModel.selectCardId == cardId)
    element.Img_Selected:SetActive(false)
    local isSelect, idx = DataModel.CardIsSelect(cardId)
    if isSelect then
      element.Img_Selected:SetActive(true)
      element.Img_Selected.Img_SelectIcon.Txt_Select:SetText(idx)
    end
  end,
  Friends_Group_CardChoose_CustomScrollGrid_List_Group_CardGroup_StaticGrid_SelectCard_Group_Card_Btn_Select_Click = function(btn, str)
    local nowSelectId = tonumber(str)
    DataModel.selectCardId = nowSelectId
    local lastCnt = DataModel.cardCnt
    DataModel.UpdateShowCardList(nowSelectId)
    if lastCnt ~= DataModel.cardCnt then
      View.myCustomSV:ElementCallBack()
      View.Group_CallingCard.Group_CardShow.Img_Show.StaticGrid_CollectCard.grid.self:RefreshAllElement()
    end
  end,
  Friends_Group_FriendsTip_Btn_BG_Click = function(btn, str)
    View.Group_FriendsTip:SetActive(false)
  end,
  Friends_Group_FriendsTip_Btn_Confirm_Click = function(btn, str)
    Controller.DelFriend()
  end,
  Friends_Group_FriendsTip_Btn_Cancel_Click = function(btn, str)
    View.Group_FriendsTip:SetActive(false)
  end,
  Friends_Group_FriendsInput_Btn_BG_Click = function(btn, str)
    View.Group_FriendsInput:SetActive(false)
  end,
  Friends_Group_FriendsInput_Btn_Cancel_Click = function(btn, str)
    View.Group_FriendsInput:SetActive(false)
  end,
  Friends_Group_FriendsInput_Btn_Confirm_Click = function(btn, str)
    if View.Group_FriendsInput.InputField_Penguin.IsActive then
      Controller.SetQQInfo()
      return
    end
    Controller.SetRemark()
  end,
  Friends_Group_CardChoose_Img_BG_Btn_Close_Click = function(btn, str)
    Controller.SetShowCard()
  end,
  Friends_Group_TopLeft_Btn_Return_Click = function(btn, str)
    if DataModel.status == 5 then
      UIManager:GoBack()
      return
    end
    if DataModel.status ~= 0 and View.Group_CallingCard.IsActive then
      Controller.RefreshPanel(DataModel.status)
      return
    end
    UIManager:GoBack()
  end,
  Friends_Group_TopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Friends_Group_TopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Friends_Group_TopLeft_Btn_Help_Click = function(btn, str)
  end,
  Friends_Group_ListMain_NewScrollGrid__SetGrid = function(element, elementIndex)
    local idx = elementIndex
    local data = DataModel.GetFriendData()[idx]
    if data then
      Controller.UpdateFriendInfo(idx)
      element.Group_Ani.StaticGrid_Info.grid.self:RefreshAllElement()
      local uid = DataModel.GetUID(data.uid)
      element.Group_Ani.Group_Info.Group_Account.Txt_UID:SetText(uid)
      local name = DataModel.GetPlayerName(data.role_name)
      element.Group_Ani.Group_Info.Group_Account.Group_AccountInfo.Txt_Name:SetText(name)
      local lv = DataModel.GetPlayerLV(data.lv)
      element.Group_Ani.Group_Info.Group_Account.Group_AccountInfo.Txt_Level:SetText("Lv " .. lv)
      local headPah, photoFactory = DataModel.GetHeadPath(data.avatar, data.gender)
      element.Group_Ani.Img_Head.Img_Mask.Img_Character:SetSprite(headPah)
      CommonTips:SetPlayerHeadShader(element.Group_Ani.Img_Head.Img_Mask.Img_spAdd, photoFactory)
      local totalRep = DataModel.GetTotalRep(data.all_rep)
      element.Group_Ani.Group_Info.Group_CityPrestige.Txt_CityPrestige:SetText(totalRep)
      element.Group_Ani.Group_List:SetActive(DataModel.status == 1)
      element.Group_Ani.Group_Info.Group_Account.Btn_Remark:SetActive(DataModel.status == 1)
      element.Group_Ani.Group_Add:SetActive(DataModel.status == 2)
      element.Group_Ani.Group_Request:SetActive(DataModel.status == 3)
      element.Group_Ani.Group_Info.Group_Account.Btn_Remark.Txt_Remark:SetText(data.remark)
      element.Group_Ani.Group_Info.Group_Account.Btn_Remark.Txt_Remark:SetActive(data.remark ~= "")
      element.Group_Ani.Group_Info.Group_Account.Btn_Remark.Img_Tips.Txt_Tips:SetActive(data.remark == "")
      element.Group_Ani.Group_List.Group_Goods.Img_Goods:SetActive(false)
      element.Group_Ani.Group_List.Group_Goods.Img_Goods.Txt_Price:SetActive(false)
      if next(data.top_value) then
        for k, v in pairs(data.top_value) do
          local cfg = PlayerData:GetFactoryData(k)
          if cfg == nil then
            break
          end
          element.Group_Ani.Group_List.Group_Goods.Img_Goods:SetActive(true)
          element.Group_Ani.Group_List.Group_Goods.Img_Goods.Txt_Price:SetActive(true)
          element.Group_Ani.Group_List.Group_Goods.Img_Goods.Txt_Price:SetText(math.floor(v * 100) .. "%")
          element.Group_Ani.Group_List.Group_Goods.Img_Goods.Img_Item:SetSprite(cfg.imagePath)
          element.Group_Ani.Group_List.Group_Goods.Img_Goods.Btn_Goods:SetClickParam(k)
        end
      end
      local path = DataModel.GetHeadTrainSkinPath(tonumber(data.head_skin))
      element.Group_Ani.Img_Train:SetSprite(path)
      local lastTs = data.login_time
      element.Group_Ani.Img_Info2.Group_LoginInfo.Txt_LoginInfo:SetText(DataModel.GetLoginTimeInfo(lastTs))
      local cityName = DataModel.GetCityName(data.position)
      element.Group_Ani.Img_Info2.Group_PositionInfo.Txt_PositionInfo:SetText(cityName)
      if data and type(data.receptionist_id) ~= "table" then
        data.receptionist_id = {
          [1] = data.receptionist_id
        }
      end
      local viewId = PlayerData:GetFactoryData(data.receptionist_id[1]).viewId
      local viewCA = PlayerData:GetFactoryData(viewId)
      element.Group_Ani.Group_Spine.SpineAnimation_Character:SetActive(false)
      local helpRoles = data.battle_help.heros
      DataModel.helpSpineRoles = {}
      if helpRoles then
        for k, v in pairs(helpRoles) do
          v.id = k
          DataModel.helpSpineRoles[#DataModel.helpSpineRoles + 1] = v
        end
      end
      element.Group_Ani.Group_Spine.StaticGrid_HelpRoleList.grid.self:SetDataCount(#DataModel.helpSpineRoles)
      element.Group_Ani.Group_Spine.StaticGrid_HelpRoleList.grid.self:RefreshAllElement()
      Controller.LoadPlayer(data.gender, element.Group_Ani.Group_Spine.SpineAnimation_Player, idx)
      element.Group_Ani.Group_List.Btn_CallingCard:SetClickParam(idx)
      element.Group_Ani.Group_List.Btn_Visit:SetClickParam(idx)
      element.Group_Ani.Group_List.Btn_Delet:SetClickParam(idx)
      element.Group_Ani.Group_Info.Group_Account.Btn_Remark:SetClickParam(idx)
      element.Group_Ani.Group_Add.Btn_CallingCard:SetClickParam(idx)
      element.Group_Ani.Group_Add.Btn_Add:SetClickParam(idx)
      element.Group_Ani.Group_Request.Btn_OK:SetClickParam(idx)
      element.Group_Ani.Group_Request.Btn_NO:SetClickParam(idx)
      element.Group_Ani.Group_Fashion.Txt_Num:SetText(data.fashion_num)
    end
  end,
  Friends_Group_ListMain_NewScrollGrid__Group_Card_Group_Ani_Group_Info_Group_Account_Btn_Remark_Click = function(btn, str)
    DataModel.selectIdx = tonumber(str)
    View.Group_FriendsInput:SetActive(true)
    View.Group_FriendsInput.InputField_Penguin:SetActive(false)
    View.Group_FriendsInput.InputField_Remark:SetActive(true)
    View.Group_FriendsInput.InputField_Remark:SetText("")
  end,
  Friends_Group_ListMain_NewScrollGrid__Group_Card_Group_Ani_StaticGrid_Info_SetGrid = function(element, elementIndex)
    element.Txt_Info:SetText(DataModel.PlayerInfoList[elementIndex])
  end,
  Friends_Group_ListMain_NewScrollGrid__Group_Card_Group_Ani_Group_List_Btn_CallingCard_Click = function(btn, str)
    Controller.CheckFriendCardInfo(tonumber(str))
  end,
  Friends_Group_ListMain_NewScrollGrid__Group_Card_Group_Ani_Group_List_Btn_Visit_Click = function(btn, str)
    Controller.CheckFriendTrain(tonumber(str))
  end,
  Friends_Group_ListMain_NewScrollGrid__Group_Card_Group_Ani_Group_List_Btn_Delet_Click = function(btn, str)
    local idx = tonumber(str)
    local data = DataModel.GetFriendData()[idx]
    if data == nil then
      return
    end
    DataModel.selectIdx = idx
    View.Group_FriendsTip:SetActive(true)
  end,
  Friends_Group_ListMain_NewScrollGrid__Group_Card_Group_Ani_Group_Add_Btn_CallingCard_Click = function(btn, str)
    Controller.CheckFriendCardInfo(tonumber(str))
  end,
  Friends_Group_ListMain_NewScrollGrid__Group_Card_Group_Ani_Group_Add_Btn_Add_Click = function(btn, str)
    Controller.AddFriend(tonumber(str))
  end,
  Friends_Group_ListMain_NewScrollGrid__Group_Card_Group_Ani_Group_Request_Btn_OK_Click = function(btn, str)
    Controller.AgreeFriendRequest(tonumber(str))
  end,
  Friends_Group_ListMain_NewScrollGrid__Group_Card_Group_Ani_Group_Request_Btn_NO_Click = function(btn, str)
    Controller.RefuseFriendRequest(tonumber(str))
  end,
  Friends_Group_ListMain_NewScrollGrid__Group_Card_Group_Ani_Group_List_Group_Goods_Img_Goods_Btn_Goods_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(str)
  end,
  Friends_Btn_Share_Click = function(btn, str)
    ComBtnShareComp.OnClickShareWithNoneArgs(View.Btn_Share)
  end,
  Friends_Group_Invite_Group_Invite_Img_Copy_Btn_Copy_Click = function(btn, str)
    CS.UnityEngine.GUIUtility.systemCopyBuffer = DataModel.inviteCode
    CommonTips.OpenTips(80602254)
  end,
  Friends_Group_Invite_Group_Invite_Group_Rewards_ScrollGrid_Rewards_SetGrid = function(element, elementIndex)
    Controller.RefreshRewardItem(element, elementIndex, false)
  end,
  Friends_Group_Invite_Group_Invite_Group_Rewards_ScrollGrid_Rewards_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(str)
  end,
  Friends_Group_Invite_Group_Inviter_InputField_InviteCode_Btn_Confirm_Click = function(btn, str)
    Controller.BindFriend()
  end,
  Friends_Group_Invite_Group_Inviter_Group_Rewards_ScrollGrid_Rewards_SetGrid = function(element, elementIndex)
    Controller.RefreshRewardItem(element, elementIndex, true)
  end,
  Friends_Group_Invite_Group_Inviter_Group_Rewards_ScrollGrid_Rewards_Group_Item_Btn_Item_Click = function(btn, str)
    CommonTips.OpenPreRewardDetailTips(str)
  end,
  Friends_Group_Invite_Group_Invitee_Group_Item_Img_BG_Btn_Get_Click = function(btn, str)
  end,
  Friends_Group_Invite_Group_Invitee_StaticGrid_Invitee_SetGrid = function(element, elementIndex)
    local data = DataModel.inviteList[elementIndex]
    element.Img_BG:SetActive(false)
    if data then
      element.Img_BG:SetActive(true)
      element.Img_BG.Txt_UID:SetText(DataModel.GetUID(data.uid))
      element.Img_BG.Txt_Name:SetText(DataModel.GetPlayerName(data.role_name))
      local headPah, photoFactory = DataModel.GetHeadPath(data.avatar, data.gender)
      element.Img_BG.Img_Head.Img_Mask.Img_Character:SetSprite(headPah)
      CommonTips:SetPlayerHeadShader(element.Img_BG.Img_Head.Img_Mask.Img_spAdd, photoFactory)
      element.Img_BG.Img_Get:SetActive(data.rcv == 1)
      element.Img_BG.Btn_Get:SetActive(data.rcv == 0)
      element.Img_BG.Img_Tips:SetActive(data.rcv == 0)
      element.Img_BG.Btn_Get:SetClickParam(elementIndex)
    end
  end,
  Friends_Group_Invite_Group_Invitee_StaticGrid_Invitee_Group_Item_Img_BG_Btn_Get_Click = function(btn, str)
    Controller.RecBindReward(tonumber(str))
  end,
  Friends_Group_CallingCard_Img_Name_Btn_Info_Click = function(btn, str)
    Controller:OnClickBtnInfoShow()
  end,
  Friends_Group_CallingCard_Group_HelpBattle_Group_Role_StaticGrid_BK_SetGrid = function(element, elementIndex)
  end,
  Friends_Group_CallingCard_Group_HelpBattle_Group_Role_Btn_select_Click = function(btn, str)
  end,
  Friends_Group_CallingCard_Group_HelpBattle_StaticGrid_RoleList_SetGrid = function(element, elementIndex)
    Controller:OnSetHelpRoleGrid(element, elementIndex)
  end,
  Friends_Group_CallingCard_Group_HelpBattle_StaticGrid_RoleList_Group_Role_StaticGrid_BK_SetGrid = function(element, elementIndex)
  end,
  Friends_Group_CallingCard_Group_HelpBattle_StaticGrid_RoleList_Group_Role_Btn_select_Click = function(btn, str)
    if DataModel.status == 0 then
      UIManager:Open("UI/Friends/HelpRoleSelect", Json.encode({
        curSelectedIndex = -1,
        curSelectedRoles = DataModel.helpRoles
      }))
    end
  end,
  Friends_Group_CallingCard_Group_HelpBattle_Group_Reward_Btn_Reward_Click = function(btn, str)
  end,
  Friends_Group_CallingCard_Group_HelpBattle_StaticGrid_RwardList_SetGrid = function(element, elementIndex)
    Controller:OnSetRewardGrid(element, elementIndex)
  end,
  Friends_Group_CallingCard_Group_HelpBattle_StaticGrid_RwardList_Group_Reward_Btn_Reward_Click = function(btn, str)
    Controller:GetHelpReward()
  end,
  Friends_Group_CallingCard_Img_Train_StaticGrid_HelpRoleList_SetGrid = function(element, elementIndex)
    Controller:OnSetHelpRoleSpineGrid(element, elementIndex)
  end,
  Friends_Group_ListMain_NewScrollGrid__Group_Card_Group_Ani_Group_Spine_StaticGrid_HelpRoleList_SetGrid = function(element, elementIndex)
    Controller:OnSetHelpRoleSpineGrid(element, elementIndex)
  end
}
return ViewFunction
