local View = require("UIFriendList/UIFriendListView")
local DataModel = require("UIFriendList/UIFriendListDataModel")
local ViewFunction = {
  FriendList_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
  end,
  FriendList_Btn_List_Click = function(btn, str)
    View.self:CloseUI()
  end,
  FriendList_Group_FriendList_Img_Tab_Btn_Level_Click = function(btn, str)
    DataModel.SortFriendClick(DataModel.EnumSort.Level)
  end,
  FriendList_Group_FriendList_Img_Tab_Btn_Clean_Click = function(btn, str)
    DataModel.SortFriendClick(DataModel.EnumSort.Clean)
  end,
  FriendList_Group_FriendList_Img_Tab_Btn_Fight_Click = function(btn, str)
    DataModel.SortFriendClick(DataModel.EnumSort.Safe)
  end,
  FriendList_Group_FriendList_Btn_History_Click = function(btn, str)
    Net:SendProto("playground.fg_friend_me_record", function(json)
      local HistoryListDataModel = require("UIHistoryList/UIHistoryListDataModel")
      local t = {}
      t.todayRecord = json.record_today or {}
      t.totalRecord = json.record_history or {}
      t.recordType = HistoryListDataModel.ERecordType.Total
      UIManager:Open("UI/Playground/FriendIslandUpdate/FriendList/HistoryList", Json.encode(t))
    end, DataModel.playgroundId)
  end,
  FriendList_Group_FriendList_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local data = DataModel.friends[elementIndex]
    local playgroundData = data.playground[tostring(DataModel.playgroundId)]
    local avatar = data.avatar
    if avatar and avatar ~= "" then
      local profilePhotoCA = PlayerData:GetFactoryData(avatar, "ProfilePhotoFactory")
      element.Img_Head.Img_Mask.Img_Character:SetSprite(profilePhotoCA.imagePath)
      CommonTips:SetPlayerHeadShader(element.Img_Head.Img_Mask.Img_spAdd, profilePhotoCA)
    else
      local gender = data.gender
      local head = PlayerData:GetFactoryData(99900001, "ConfigFactory")
      if head and head.playerHeadList then
        element.Img_Head.Img_Mask.Img_Character:SetSprite(head.playerHeadList[gender + 1].playerHeadPath)
      end
    end
    element.Txt_Name:SetText(data.role_name)
    element.Txt_Lv:SetText(playgroundData.lv)
    element.Btn_Go:SetClickParam(elementIndex)
    element.Img_Select:SetActive(data.uid == DataModel.curVisitFriendUid)
    element.Img_CanSteal:SetActive(data.canClean)
    element.Img_CanHelp:SetActive(data.canHelp)
  end,
  FriendList_Group_FriendList_ScrollGrid_List_Group_Item_Btn_Go_Click = function(btn, str)
    local index = tonumber(str)
    DataModel.VisitFriendClick(index)
  end
}
return ViewFunction
