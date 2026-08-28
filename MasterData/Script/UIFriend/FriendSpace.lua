local View = require("UIFriend/UIFriendView")
local DataModel = require("UIFriend/UIFriendDataModel")
local ViewSpace
local module = {
  Load = function(self)
    Net:SendProto("zone.get_msg", function(json)
      print_r(json)
      DataModel.Messages = json.messages
      DataModel.MsgPermission = json.msg_permission
      self:RefreshMessageList()
      self:RefreshMessagePermission()
    end, PlayerData:GetUserInfo().uid)
    ViewSpace = View.Group_Space
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
    Group_Left.Txt_Lv:SetText(user_info.lv)
    Group_Left.Txt_InfoName:SetText(user_info.role_name)
    Group_Left.Group_Signature.Txt_Signature:SetText(user_info.sign or "")
    ViewSpace.Group_Right.Group_Middle.Group_Push.Group_Show.self:SetActive(false)
    View.Group_Space.Group_Right.Group_Bottom.InputField_Board.self:SetText("")
  end,
  RefreshMessagePermission = function(self)
    local Txt_Type = ViewSpace.Group_Right.Group_Middle.Group_Push.Group_Init.Txt_Type
    if DataModel.MsgPermission == 1 then
      Txt_Type:SetText("\228\187\133\229\165\189\229\143\139\229\143\175\231\149\153\232\168\128")
    elseif DataModel.MsgPermission == 0 then
      Txt_Type:SetText("\230\137\128\230\156\137\228\186\186\229\143\175\231\149\153\232\168\128")
    end
  end,
  RefreshMessageList = function(self)
    local Group_Middle = ViewSpace.Group_Right.Group_Middle
    table.sort(DataModel.Messages, function(a, b)
      return a.time > b.time
    end)
    if table.count(DataModel.Messages) == 0 then
      Group_Middle.Group_Content.Txt_Null:SetActive(true)
      Group_Middle.Group_Content.ScrollGrid_Board.self:SetActive(false)
    else
      Group_Middle.Group_Content.Txt_Null:SetActive(false)
      Group_Middle.Group_Content.ScrollGrid_Board.self:SetActive(true)
      Group_Middle.Group_Content.ScrollGrid_Board.grid.self:SetDataCount(table.count(DataModel.Messages))
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
  RefreshPushShow = function()
    if ViewSpace.Group_Right.Group_Middle.Group_Push.Group_Show.IsActive then
      ViewSpace.Group_Right.Group_Middle.Group_Push.Group_Show.self:SetActive(false)
    else
      ViewSpace.Group_Right.Group_Middle.Group_Push.Group_Show.self:SetActive(true)
    end
  end,
  LeaveMessage = function(self, content)
    Net:SendProto("zone.leave_msg", function(json)
      table.insert(DataModel.Messages, json.new_msg)
      self:RefreshMessageList()
      CommonTips.OpenTips(80600120)
      View.Group_Space.Group_Right.Group_Bottom.InputField_Board.self:SetText("")
    end, PlayerData:GetUserInfo().uid, content)
  end,
  DeleteMessage = function(self, index)
    Net:SendProto("zone.del_msg", function(json)
      table.remove(DataModel.Messages, index)
      self:RefreshMessageList()
    end, index)
  end,
  OpenReplyMessagePage = function(self, row)
    View.Group_Reply.self:SetActive(true)
    local content = "\229\155\158\229\164\141" .. row.role_name .. ":"
    View.Group_Reply.InputField_Board.self:SetPlaceHolder(content)
    View.Group_Reply.InputField_Board.self:SetText("")
    View.Group_Reply.InputField_Board.self:SetCharacterLimit(DataModel.ConfigFactory.messageWordMax)
  end,
  ReplyMessage = function(self)
    local content = View.Group_Reply.InputField_Board.self:GetText()
    if content == "" then
      return CommonTips.OpenTips(80600101)
    end
    Net:SendProto("zone.reply_msg", function(json)
      print_r(json)
      table.insert(DataModel.Messages, json.new_msg)
      CommonTips.OpenTips(80600132)
      View.Group_Reply.self:SetActive(false)
      self:RefreshMessageList()
    end, content, DataModel.FriendMessageIndex)
  end,
  JoinBlack = function(self, uid)
    if DataModel.IsBlackMax(uid) == true then
      return
    end
    print_r(uid .. "------------------------------")
    
    local function callback()
      Net:SendProto("friend.add_blacklist", function(json)
        DataModel.JoinBlackList(json.new_black, uid)
        CommonTips.OpenTips(80600098)
        DataModel.TabNumRefresh()
      end, uid)
    end
    
    CommonTips.OnPrompt("80600114", nil, nil, callback)
  end,
  RemoveBlack = function(self, uid, index)
    local function callback()
      Net:SendProto("friend.remove_blacklist", function(json)
        print_r(json)
        
        table.remove(DataModel.SeverListData.blacklist, index)
        CommonTips.OpenTips(80600099)
        DataModel.TabNumRefresh()
      end, uid)
    end
    
    CommonTips.OnPrompt("80600115", nil, nil, callback)
  end
}
return module
