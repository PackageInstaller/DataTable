local UINEventInvitationPlayerItem = class("UINEventInvitationPlayerItem", UIBaseNode)
local base = UIBaseNode
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local eFriendEnum = require("Game.Friend.eFriendEnum")
local cs_MessageCommon = CS.MessageCommon

function UINEventInvitationPlayerItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_States, self, self.OnClickAddFriend)
  self._headNode = UINUserHead.New()
  self._headNode:Init(self.ui.uINUserHead)
  self._defaultColor = self.ui.img_States.color
end

function UINEventInvitationPlayerItem:SetInvitationPlayerItem(uid, resloader, callback)
  self._resloader = resloader
  self._uid = uid
  self._avatar = nil
  self._callback = callback
  PlayerDataCenter:GetUserInfoByUID(uid, function(avatar)
    if IsNull(self.transform) then
      return
    end
    if uid ~= self._uid then
      return
    end
    self._avatar = avatar
    self:RefreshInvitationPlayerItem()
  end)
end

function UINEventInvitationPlayerItem:RefreshInvitationPlayerItem()
  if self._avatar == nil then
    return
  end
  self._headNode:InitUserHeadUI(self._avatar:GetAvatarId(), self._avatar:GetAvatarFrameId(), self._resloader)
  self._headNode:BindUserHeadEvent(function()
    self._callback(self._uid)
  end)
  self.ui.tex_PlayerName.text = self._avatar:GetUserName()
  if PlayerDataCenter.friendDataCenter:TryGetFriendData(self._uid) then
    self.ui.img_state:SetIndex(2)
    self.ui.tex_state:SetIndex(2)
    self.ui.img_States.color = self._defaultColor
  elseif PlayerDataCenter.friendDataCenter:TryGetFriendApplyData(self._uid) then
    self.ui.img_state:SetIndex(1)
    self.ui.tex_state:SetIndex(1)
    self.ui.img_States.color = self._defaultColor
  else
    self.ui.img_state:SetIndex(0)
    self.ui.tex_state:SetIndex(0)
    self.ui.img_States.color = self.ui.color_black
  end
end

function UINEventInvitationPlayerItem:OnClickAddFriend()
  if PlayerDataCenter.friendDataCenter:TryGetFriendData(self._uid) or PlayerDataCenter.friendDataCenter:TryGetFriendApplyData(self._uid) then
    return
  end
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7708))
  if PlayerDataCenter.friendDataCenter:HasAppliedUser(self._uid) then
    return
  end
  NetworkManager:GetNetwork(NetworkTypeID.Friend):CS_FRIEND_ApplyFriend(self._uid, eFriendEnum.eFriendApplyWay.Search, function()
    if not IsNull(self.transform) then
      self:RefreshInvitationPlayerItem()
    end
  end)
end

return UINEventInvitationPlayerItem
