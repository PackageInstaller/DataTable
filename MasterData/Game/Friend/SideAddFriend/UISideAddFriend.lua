local UISideAddFriend = class("UISideAddFriend", UIBaseWindow)
local base = UIBaseWindow
local cs_MessageCommon = CS.MessageCommon
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local eFriendEnum = require("Game.Friend.eFriendEnum")

function UISideAddFriend:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.OnCLickCancle)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickAddFriend)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.obj_UINUserHead)
end

function UISideAddFriend:InitAddHeroSide(userUID, resLoader)
  self.resLoader = resLoader
  self.ui.btn_Cancel.gameObject:SetActive(false)
  self.ui.btn_Confirm.gameObject:SetActive(false)
  PlayerDataCenter:GetUserInfoByUID(userUID, function(userData)
    if userData == nil then
      return
    end
    if userData:GetIsFriend() then
      return
    end
    self.ui.inTween:DOPlay()
    self.ui.tex_Name.text = userData:GetUserName()
    self.userHeadNode:InitUserHeadUI(userData:GetAvatarId(), userData:GetAvatarFrameId(), self.resLoader)
    self.userData = userData
    self.ui.btn_Cancel.gameObject:SetActive(true)
    self.ui.btn_Confirm.gameObject:SetActive(true)
  end)
end

function UISideAddFriend:OnCLickCancle()
  self:Delete()
end

function UISideAddFriend:OnClickAddFriend()
  if PlayerDataCenter.friendDataCenter:GetIsFriendFull() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Friend_AddFailure))
    self:Delete()
    return
  end
  NetworkManager:GetNetwork(NetworkTypeID.Friend):CS_FRIEND_ApplyFriend(self.userData:GetUserUID(), eFriendEnum.eFriendApplyWay.Assist, function()
    self:Delete()
  end)
end

function UISideAddFriend:OnDelete()
  base.OnDelete(self)
end

return UISideAddFriend
