local UIDormVisitorItem = class("UIDormVisitorItem", UIBaseNode)
local base = UIBaseNode
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local eFriendEnum = require("Game.Friend.eFriendEnum")
local cs_MessageCommon = CS.MessageCommon

function UIDormVisitorItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Visit, self, self.OnClickVisit)
  UIUtil.AddButtonListener(self.ui.btn_AddFriend, self, self.OnClickAddFriend)
  self.__OnClickUserInfo = BindCallback(self, self.OnClickUserInfo)
  self.userHead = UINUserHead.New()
  self.userHead:Init(self.ui.uINUserHead)
end

function UIDormVisitorItem:InitUIDormVisitorItem(visitData, index, resloader)
  self.resloader = resloader
  self.gameObject:SetActive(true)
  self._uid = visitData.UID
  self.userName = visitData.name
  self.userInfoData = visitData
  self:UpdateFriendItem(visitData)
end

function UIDormVisitorItem:UpdateFriendItem(visitData)
  self.userHead:InitUserHeadUI(visitData.avatarId, visitData.avatarFrameId, self.resloader)
  self.userHead:BindUserHeadEvent(self.__OnClickUserInfo)
  self:UpdateLevel(visitData.level)
  self:UpdateUserName(visitData.name)
  self:UpdateFriendBtnState()
  self:RefreshFriendOnlineState(visitData)
end

function UIDormVisitorItem:UpdateLevel(level)
  self.ui.tex_Level.text = tostring(level)
end

function UIDormVisitorItem:UpdateUserName(name)
  self.ui.tex_Name.text = name
end

function UIDormVisitorItem:UpdateFriendBtnState()
  local isFriend = PlayerDataCenter.friendDataCenter:TryGetFriendData(self._uid) or PlayerDataCenter.friendDataCenter:TryGetFriendApplyData(self._uid)
  local hasAppliedUser = PlayerDataCenter.friendDataCenter:HasAppliedUser(self._uid)
  self.ui.btn_AddFriend.gameObject:SetActive(not isFriend and not hasAppliedUser)
  self.ui.btn_Wait.gameObject:SetActive(not isFriend and hasAppliedUser)
end

function UIDormVisitorItem:RefreshFriendOnlineState(visitData)
  local lastOfflineTs = visitData:GetOnlineState()
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

function UIDormVisitorItem:OnClickVisit()
  local dormCtrl = ControllerManager:GetController(ControllerTypeId.Dorm)
  if dormCtrl ~= nil then
    if dormCtrl:GetDormOwnerUserId() == self._uid then
      cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(9367))
      return
    end
    dormCtrl:EnterOtherDorm(self._uid, self.userName)
  end
end

function UIDormVisitorItem:OnClickAddFriend()
  if PlayerDataCenter.friendDataCenter:TryGetFriendData(self._uid) or PlayerDataCenter.friendDataCenter:TryGetFriendApplyData(self._uid) then
    return
  end
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7708))
  if PlayerDataCenter.friendDataCenter:HasAppliedUser(self._uid) then
    return
  end
  NetworkManager:GetNetwork(NetworkTypeID.Friend):CS_FRIEND_ApplyFriend(self._uid, eFriendEnum.eFriendApplyWay.DormVisit, function()
    self:UpdateFriendBtnState()
  end)
end

function UIDormVisitorItem:OnClickUserInfo()
  if self.userInfoData == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonUserInfo, function(win)
    if win == nil then
      return
    end
    win:InitUserInfoView(self.userInfoData)
  end)
end

function UIDormVisitorItem:OnDelete()
  self.userHead:Delete()
  self.userHead = nil
  base.OnDelete(self)
end

return UIDormVisitorItem
