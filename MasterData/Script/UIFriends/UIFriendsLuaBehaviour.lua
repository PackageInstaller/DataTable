local View = require("UIFriends/UIFriendsView")
local DataModel = require("UIFriends/UIFriendsDataModel")
local ViewFunction = require("UIFriends/UIFriendsViewFunction")
local Controller = require("UIFriends/UIFriendsLuaController")
local customSV = require("Common/CustomSV")
local Luabehaviour = {
  serialize = function()
  end,
  deserialize = function(initParams)
    Controller:InitView(initParams)
    View.Group_CallingCard:SetActive(false)
    View.Group_ListMain:SetActive(false)
    View.Group_Invite:SetActive(false)
    View.Group_RightList:SetActive(false)
    View.Group_RightList.Group_Invite:SetActive(GameSetting.fromRes ~= "KR")
    View.Group_RightList.Group_Request.Img_Tips:SetActive(false)
    if initParams then
      local data = Json.decode(initParams)
      if data.uid then
        DataModel.selectIdx = 1
        DataModel.status = 5
        DataModel.PlayerInfoList = {}
        Net:SendProto("friend.detail", function(json)
          DataModel.playerData = {}
          for k, v in pairs(json.friend) do
            v.uid = k
            table.insert(DataModel.playerData, v)
          end
          Controller.CheckFriendCardInfo(1)
          View.Group_CallingCard.Group_Btn.Btn_Add:SetActive(data.uid ~= PlayerData:GetUserInfo().uid and json.is_friend == 0)
          View.Group_Top:SetActive(true)
          View.Group_Top.Img_Top:SetActive(false)
          View.Group_Top.Btn_Refresh:SetActive(false)
          View.Group_Top.InputField_Search:SetActive(false)
          View.Group_CallingCard.Group_Btn.Btn_Visit:SetActive(false)
          View.Group_CallingCard.Group_CardShow.Img_Show.Btn_Change:SetActive(false)
        end, data.uid)
        return
      end
    end
    View.Group_Top.Img_Top:SetActive(true)
    Net:SendProto("friend.get_lists", function(json)
      DataModel.tower_points = json.tower_points
      DataModel.today_profit = json.today_profit or 0
      DataModel.today_distance = json.today_distance or 0
      DataModel.serverInviteData = json.invitation_list or {}
      DataModel.inviteCode = json.invitation_str
      DataModel.bindInviteCode = json.bond_invitation_str
      DataModel.profit_daily = json.profit_daily or 0
      View.Group_RightList:SetActive(true)
      DataModel.init(json.friends, json.requested)
      Controller.RefreshPanel(0)
      View.Group_RightList.Group_List.Btn_List.Img_UnSelected.Txt_Num:SetText(#DataModel.FriendList .. "/" .. DataModel.friendMaxNum)
    end)
  end,
  awake = function()
    View.myCustomSV = customSV.New(View.Group_CardChoose.CustomScrollGrid_List.grid, true, function(element, index)
      local data = DataModel.cardDataList[index]
      element.Img_GroupTitle:SetActive(data.ShowTitle)
      DataModel.nowIndx = index
      element.StaticGrid_SelectCard.grid.self:RefreshAllElement(#data.list)
      local cardPackId = data.cardPackId
      local cfg = PlayerData:GetFactoryData(cardPackId)
      element.Img_GroupTitle:SetSprite(cfg.titleLine)
      element.Img_GroupTitle.Txt_Title:SetText(cfg.seriesName)
      element.Img_GroupTitle.Btn_SelectAll:SetClickParam(index)
    end)
    DataModel.bgSpineX = View.Group_CallingCard.Group_Assistant.Img_SpineBG.transform.localPosition.x
  end,
  start = function()
  end,
  update = function()
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
    View.Group_CardChoose:SetActive(false)
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
