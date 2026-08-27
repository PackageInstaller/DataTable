local UIUserFriendBlackListItem = class("UIUserFriendBlackListItem", UIBaseNode)
local base = UIBaseNode
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local cs_MessageCommon = CS.MessageCommon

function UIUserFriendBlackListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_cancel, self, self.OnClickBtnCancel)
  self.friendDataCenter = PlayerDataCenter.friendDataCenter
  self.friendNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.obj_UINUserHead)
end

function UIUserFriendBlackListItem:InitItem(index, userdata, removeFunc, resLoader)
  self.__index = index
  self.userInfoData = userdata
  self.removeFunc = removeFunc
  self.resLoader = resLoader
  self:RefreshItem()
end

function UIUserFriendBlackListItem:RefreshItemData(userdata)
  self.userInfoData = userdata
  self:RefreshItem()
end

function UIUserFriendBlackListItem:RefreshItem()
  self.ui.tex_name.text = self.userInfoData:GetAlias()
  self.ui.tex_level.text = self.userInfoData:GetUserLevel()
  self.userHeadNode:InitUserHeadUI(self.userInfoData:GetAvatarId(), self.userInfoData:GetAvatarFrameId(), self.resLoader)
  self:RefreshOnlineState()
end

function UIUserFriendBlackListItem:RefreshOnlineState()
  local lastOfflineTs = self.userInfoData:GetOnlineState()
  if lastOfflineTs == nil then
    self.ui.obj_online:SetActive(false)
    self.ui.obj_offline:SetActive(false)
    return
  elseif lastOfflineTs == 0 then
    self.ui.obj_online:SetActive(true)
    self.ui.obj_offline:SetActive(false)
    return
  end
  local timepassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, false)
  local isToday, dayPassTimeStamp = timepassCtrl:GetIsLogicToday(lastOfflineTs)
  self.ui.obj_online:SetActive(isToday)
  self.ui.obj_offline:SetActive(not isToday)
  if not isToday then
    local timeSpan = dayPassTimeStamp - lastOfflineTs
    local day = math.floor(timeSpan / 86400)
    self.ui.tex_offlineTime:SetIndex(0, tostring(day))
  end
end

function UIUserFriendBlackListItem:OnClickBtnCancel()
  local name = self.userInfoData:GetAlias()
  local str = string.format(ConfigData:GetTipContent(TipContent.Friend_RemoveFromBlacklist), name)
  cs_MessageCommon.ShowMessageBox(str, function()
    if self.friendDataCenter:TryGetBlackListData(self.userInfoData:GetUserUID()) ~= nil then
      self.friendNetworkCtrl:CS_Black_Delete(self.userInfoData:GetUserUID(), function()
        if self.removeFunc and self.resLoader then
          self.removeFunc(self.resLoader)
        end
      end)
    end
  end, nil)
end

function UIUserFriendBlackListItem:OnDelete()
  if self.resLoader ~= nil then
    self.resLoader:Put2Pool()
    self.resLoader = nil
  end
  self.userHeadNode:Delete()
  base.OnDelete(self)
end

return UIUserFriendBlackListItem
