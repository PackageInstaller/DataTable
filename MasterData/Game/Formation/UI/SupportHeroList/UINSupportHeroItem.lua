local UINSupportHeroItem = class("UINSupportHeroItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local UINHeroCardItem = require("Game.Hero.NewUI.UINHeroCardItem")
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local eFriendEnum = require("Game.Friend.eFriendEnum")

function UINSupportHeroItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_SelDetail, self, self.OnClickSupportorInfo)
  UIUtil.AddButtonListener(self.ui.btn_Use, self, self.OnClickUse)
  UIUtil.AddButtonListener(self.ui.btn_FriendInfo, self, self.OnClickFriendInfo)
  self.heroCard = UINHeroCardItem.New()
  self.heroCard:Init(self.ui.uINHeroItem)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.obj_UINUserHead)
  self.expiredData = nil
end

function UINSupportHeroItem:InitSupportHeroCard(friednSupportHeroData, useCardCallback, resloader, normalHeroDic)
  self.friednSupportHeroData = friednSupportHeroData
  self.useCardCallback = useCardCallback
  self.expiredData = friednSupportHeroData.expiredSupport
  self.heroCard:InitHeroCardItem(friednSupportHeroData, resloader, nil, nil)
  self.heroCard:SetEfficiencyActive(true)
  self:RefreshUserInfo(resloader)
  if self.expiredData ~= nil then
    self.ui.obj_img_SameHero:SetActive(true)
    self.ui.tex_Tip:SetIndex(1, tostring(self.expiredData.nextUseTurn))
  else
    self.ui.obj_img_SameHero:SetActive(false)
  end
  local talentLevel = self.friednSupportHeroData:GetSupportHerotalentLevel()
  self.heroCard:ShowTalentStage(talentLevel)
end

function UINSupportHeroItem:RefreshUserInfo(resloader)
  local userInfoData = self.friednSupportHeroData:GetUserInfo()
  self.ui.tex_UserName.text = userInfoData:GetAlias()
  self.ui.tex_UserLv:SetIndex(0, tostring(userInfoData:GetUserLevel()))
  self.ui.img_Recommend:SetActive(not userInfoData:GetIsFriend())
  self.userHeadNode:InitUserHeadUI(userInfoData:GetAvatarId(), userInfoData:GetAvatarFrameId(), resloader)
end

function UINSupportHeroItem:OnClickSupportorInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.SupportHeroState, function(win)
    if win == nil then
      return
    end
    win:InitSupportHeroState(self.friednSupportHeroData)
  end)
end

function UINSupportHeroItem:OnClickUse()
  if self.expiredData ~= nil then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Support_CanNotUseSameSupport))
    return
  end
  if self.useCardCallback ~= nil then
    self.useCardCallback(self)
  end
end

function UINSupportHeroItem:OnClickFriendInfo()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonUserInfo, function(win)
    if win == nil then
      return
    end
    win:InitUserInfoView(self.friednSupportHeroData:GetUserInfo(), eFriendEnum.eFriendApplyWay.Assist)
  end)
end

function UINSupportHeroItem:OnDelete()
  base.OnDelete(self)
end

return UINSupportHeroItem
