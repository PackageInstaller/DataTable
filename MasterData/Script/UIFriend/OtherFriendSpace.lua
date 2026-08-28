local View = require("UIFriend/UIFriendView")
local DataModel = require("UIFriend/UIFriendDataModel")
local ViewSpace
local module = {
  Load = function(self)
    Net:SendProto("zone.get_msg", function(json)
      print_r(json)
      DataModel.FriendMessage = json.messages
      DataModel.MsgPermission = json.msg_permission
      self:RefreshMessageList()
    end, DataModel.NowChooseInfo.id)
    ViewSpace = View.Group_FriendSpace
    ViewSpace.self:SetActive(true)
    local Group_Left = ViewSpace.Group_Left
    local user_info = PlayerData:GetUserInfo()
    local viewId = _data.UnitFactory[tonumber(user_info.receptionist_id[1])].viewId
    local viewData = _data.UnitViewFactory[tonumber(viewId)]
    Group_Left.Img_Character:SetSprite(viewData.resUrl)
    Group_Left.Img_Mask.Img_Character:SetSprite(viewData.resUrl)
    local posX = viewData.squadsX or 0
    local posY = viewData.squadsY or 0
    Group_Left.Img_Character:SetLocalPosition(Vector3(posX - 200, posY, 0))
    Group_Left.Img_Mask.Img_Character:SetLocalPosition(Vector3(posX, posY, 0))
    Group_Left.Txt_Lv:SetText(DataModel.NowChooseInfo.lv)
    Group_Left.Txt_InfoName:SetText(DataModel.NowChooseInfo.role_name)
    Group_Left.Group_Signature.Txt_Signature:SetText(DataModel.NowChooseInfo.sign or "")
    View.Group_FriendSpace.Group_Right.Group_Bottom.InputField_Board.self:SetText("")
  end,
  RefreshMessageList = function(self)
    local Group_Middle = ViewSpace.Group_Right.Group_Middle
    table.sort(DataModel.FriendMessage, function(a, b)
      return a.time > b.time
    end)
    if table.count(DataModel.FriendMessage) == 0 then
      Group_Middle.Group_Content.Txt_Null:SetActive(true)
      Group_Middle.Group_Content.ScrollGrid_Board.self:SetActive(false)
    else
      Group_Middle.Group_Content.Txt_Null:SetActive(false)
      Group_Middle.Group_Content.ScrollGrid_Board.self:SetActive(true)
      Group_Middle.Group_Content.ScrollGrid_Board.grid.self:SetDataCount(table.count(DataModel.FriendMessage))
      Group_Middle.Group_Content.ScrollGrid_Board.grid.self:RefreshAllElement()
    end
  end,
  SendPermission = function(self, type)
    if type == DataModel.MsgPermission then
      self:RefreshPushShow()
      return
    end
    Net:SendProto("zone.set_permission", function(json)
      print_r(json)
      DataModel.MsgPermission = json.new_permission
      self:RefreshMessagePermission()
      self:RefreshPushShow()
    end, type)
  end,
  LeaveMessage = function(self, content)
    Net:SendProto("zone.leave_msg", function(json)
      table.insert(DataModel.FriendMessage, json.new_msg)
      self:RefreshMessageList()
      CommonTips.OpenTips(80600120)
      View.Group_FriendSpace.Group_Right.Group_Bottom.InputField_Board.self:SetText("")
    end, DataModel.NowChooseInfo.id, content)
  end,
  DeleteMessage = function(self, index)
    Net:SendProto("zone.del_msg", function(json)
      table.remove(DataModel.FriendMessage, index)
      self:RefreshMessageList()
    end, index)
  end,
  JoinBlack = function(self, uid, index)
    if DataModel.IsBlackMax(uid) then
      return CommonTips.OpenTips(80600097)
    end
    
    local function callback()
      Net:SendProto("friend.add_blacklist", function(json)
        print_r(json)
        DataModel.JoinBlackList(json.new_black, uid)
        DataModel.TabNumRefresh()
        CommonTips.OpenTips(80600098)
      end, uid)
    end
    
    CommonTips.OnPrompt("80600114", nil, nil, callback)
  end,
  RemoveBlack = function(self, uid, index)
    local function callback()
      Net:SendProto("friend.remove_blacklist", function(json)
        print_r(json)
        
        table.remove(DataModel.SeverListData.blacklist, index)
        DataModel.TabNumRefresh()
        CommonTips.OpenTips(80600099)
      end, uid)
    end
    
    CommonTips.OnPrompt("80600115", nil, nil, callback)
  end
}
return module
