local UINAddFriendListItem = class("UINAddFriendListItem", UIBaseNode)
local base = UIBaseNode
local eFriendEnum = require("Game.Friend.eFriendEnum")
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local cs_MessageCommon = CS.MessageCommon

function UINAddFriendListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_add, self, self.OnClickBtnAddFriend)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.obj_UINUserHead)
  self.__OnClickItem = BindCallback(self, self.OnClickItem)
end

function UINAddFriendListItem:InitWithFriendData(friendData, clickCallback, resLoader, isSearch)
  self.friendData = friendData
  self.clickCallback = clickCallback
  self.resLoader = resLoader
  self.isSearch = isSearch
  self:RefreshFriendItem()
end

function UINAddFriendListItem:RefreshFriendItem()
  self.ui.tex_name.text = self.friendData:GetAlias()
  self.ui.tex_level.text = self.friendData:GetUserLevel()
  self.userHeadNode:InitUserHeadUI(self.friendData:GetAvatarId(), self.friendData:GetAvatarFrameId(), self.resLoader)
  self.userHeadNode:BindUserHeadEvent(self.__OnClickItem)
  self:RefreshFriendOnlineState()
  self:RefreshFriendRelationState()
end

function UINAddFriendListItem:RefreshUserHead(avatarId)
  if avatarId == nil or avatarId == 0 then
    return
  end
  local cfg = ConfigData.portrait[avatarId]
  if cfg == nil or cfg.icon == nil then
    error("can't read portraitCfg with id:" .. tostring(avatarId))
    return
  end
  local icon = cfg.icon
  if string.IsNullOrEmpty(icon) ~= nil then
    self.ui.img_UserHead.sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
end

function UINAddFriendListItem:RefreshUserHeadFrame(avatarFrameId)
  if avatarFrameId == nil or avatarFrameId == 0 then
    return
  end
  local cfg = ConfigData.portrait_frame[avatarFrameId]
  if cfg == nil or cfg.icon == nil then
    error("can't read portrait_frameCfg with id:" .. tostring(avatarFrameId))
    return
  end
  local icon = cfg.icon
  if string.IsNullOrEmpty(icon) ~= nil then
    self.ui.img_Frame.sprite = CRH:GetSprite(icon, CommonAtlasType.HeroHeadIcon)
  end
end

function UINAddFriendListItem:RefreshFriendOnlineState()
  local lastOfflineTs = self.friendData:GetOnlineState()
  if lastOfflineTs == nil then
    self.ui.obj_online:SetActive(false)
    self.ui.obj_offline:SetActive(false)
    return
  elseif lastOfflineTs == 0 then
    self.ui.obj_online:SetActive(true)
    self.ui.obj_offline:SetActive(false)
    return
  end
  self.ui.obj_online:SetActive(false)
  self.ui.obj_offline:SetActive(true)
  local timepassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, false)
  local isToday, dayPassTimeStamp = timepassCtrl:GetIsLogicToday(lastOfflineTs)
  if not isToday then
    local timeSpan = dayPassTimeStamp - lastOfflineTs
    local day = math.floor(timeSpan / 86400)
    self.ui.tex_offlineTime:SetIndex(1, tostring(day))
  else
    local timeSpan = PlayerDataCenter.timestamp - lastOfflineTs
    local hour = math.floor(timeSpan / 3600)
    self.ui.tex_offlineTime:SetIndex(0, tostring(hour))
  end
end

function UINAddFriendListItem:RefreshFriendRelationState()
  local friendData = PlayerDataCenter.friendDataCenter:TryGetFriendData(self.friendData:GetUserUID())
  local isFriend = friendData ~= nil
  local hasApplied = PlayerDataCenter.friendDataCenter:HasAppliedUser(self.friendData:GetUserUID())
  self.ui.obj_added:SetActive(isFriend)
  self.ui.btn_add.gameObject:SetActive(not hasApplied and not isFriend)
  self.ui.obj_wait:SetActive(hasApplied and not isFriend)
end

function UINAddFriendListItem:OnClickBtnAddFriend()
  if PlayerDataCenter.friendDataCenter:GetIsFriendFull() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Friend_FriendListIsFull))
    return
  end
  local friendNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
  local applyWay = self.isSearch and eFriendEnum.eFriendApplyWay.Search or eFriendEnum.eFriendApplyWay.Recommend
  friendNetworkCtrl:CS_FRIEND_ApplyFriend(self.friendData:GetUserUID(), applyWay, function()
    self:RefreshFriendRelationState()
  end)
end

function UINAddFriendListItem:OnClickItem()
  if self.clickCallback ~= nil then
    self.clickCallback(self.friendData)
  end
end

function UINAddFriendListItem:OnDelete()
  base.OnDelete(self)
end

return UINAddFriendListItem
