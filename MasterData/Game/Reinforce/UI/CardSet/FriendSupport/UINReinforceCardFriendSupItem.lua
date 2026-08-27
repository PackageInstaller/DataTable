local base = UIBaseNode
local UINReinforceCardFriendSupItem = class("UINReinforceCardFriendSupItem", base)
local UINRfCardFacSmall = require("Game.Reinforce.UI.FactorCard.UINRfCardFacSmall")
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local eFriendEnum = require("Game.Friend.eFriendEnum")

function UINReinforceCardFriendSupItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_SelDetail, self, self.OnClickSelDetail)
  UIUtil.AddButtonListener(self.ui.Btn_Use, self, self.OnClickUse)
  UIUtil.AddButtonListener(self.ui.Btn_FriendInfo, self, self.OnClickFriendInfo)
  self.cardNode = UINRfCardFacSmall.New()
  self.cardNode:Init(self.ui.UINRfCardFacSmall)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.UINUserHead)
end

function UINReinforceCardFriendSupItem:InitSupportFacCard(resloader, onSelectCallback)
  self.resloader = resloader
  self.onSelectCallback = onSelectCallback
end

function UINReinforceCardFriendSupItem:RefreshSupportFacCard(facCardData)
  self.facCardData = facCardData
  local userInfoData = self.facCardData:GetSupportCardUserInfoData()
  self.cardNode:InitRfCardFacSmall(self.facCardData, self.resloader, false)
  self.userHeadNode:InitUserHeadUI(userInfoData:GetAvatarId(), userInfoData:GetAvatarFrameId(), self.resloader)
  self.ui.Tex_UserName.text = userInfoData:GetAlias()
  self.ui.Tex_UserLv:SetIndex(0, tostring(userInfoData:GetUserLevel()))
  self.ui.Img_Recommend:SetActive(not userInfoData:GetIsFriend())
end

function UINReinforceCardFriendSupItem:OnClickSelDetail()
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardDetailFac, function(win)
    if win == nil then
      return
    end
    win:InitRfCardDetailFac(self.facCardData, false, true)
  end)
end

function UINReinforceCardFriendSupItem:OnClickUse()
  if self.onSelectCallback ~= nil then
    self.onSelectCallback(self.facCardData, true)
  end
end

function UINReinforceCardFriendSupItem:OnClickFriendInfo()
  local userInfoData = self.facCardData:GetSupportCardUserInfoData()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonUserInfo, function(win)
    if win == nil then
      return
    end
    win:InitUserInfoView(userInfoData, eFriendEnum.eFriendApplyWay.Assist)
  end)
end

function UINReinforceCardFriendSupItem:OnDelete()
end

return UINReinforceCardFriendSupItem
