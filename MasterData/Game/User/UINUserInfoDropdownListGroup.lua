local UINUserInfoDropdownListGroup = class("UINUserInfoDropdownListGroup", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local UINUserInfoDropDownListItem = require("Game.User.UINUserInfoDropdownListItem")

function UINUserInfoDropdownListGroup:OnInit()
  self.itemDic = {}
  self.__isExpand = false
  self.OnClickSetAlias = BindCallback(self, self.__OnClickSetAlias)
  self.OnClickDelete = BindCallback(self, self.__OnClickDelete)
  self.OnClickBlock = BindCallback(self, self.__OnClickBlock)
  self.OnClickReport = BindCallback(self, self.__OnClickReport)
  self.clickFuncArray = {
    [1] = self.OnClickSetAlias,
    [2] = self.OnClickDelete,
    [3] = self.OnClickBlock,
    [4] = self.OnClickReport
  }
  self.friendNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Friend)
  self.friendDataCenter = PlayerDataCenter.friendDataCenter
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_list, self, self.OnClickBtnDropDownList)
end

function UINUserInfoDropdownListGroup:InitDropDownList(userData)
  self.userInfoData = userData
  self.ui.obj_item:SetActive(false)
  for index, func in ipairs(self.clickFuncArray) do
    local go = self.ui.obj_item:Instantiate(self.ui.obj_itemList)
    go:SetActive(true)
    local item = UINUserInfoDropDownListItem.New()
    item:Init(go)
    item:InitItem(index - 1, func)
    self.itemDic[go] = item
  end
end

function UINUserInfoDropdownListGroup:RefreshDropDownList(userData)
  self.userInfoData = userData
  self.ui.imgItem_list:SetIndex(0)
  self.ui.obj_itemList:SetActive(false)
  self.__isExpand = false
end

function UINUserInfoDropdownListGroup:OnClickBtnDropDownList()
  self.__isExpand = not self.__isExpand
  if self.__isExpand then
    self.ui.imgItem_list:SetIndex(1)
    self.ui.obj_itemList:SetActive(true)
  else
    self.ui.imgItem_list:SetIndex(0)
    self.ui.obj_itemList:SetActive(false)
  end
end

function UINUserInfoDropdownListGroup:__OnClickSetAlias()
  if CloseCustomBename then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(393))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UserFreinedSetAlias, function(win)
    if win == nil then
      return
    end
    win:InitSetFriendAlias(self.userInfoData)
  end)
end

function UINUserInfoDropdownListGroup:__OnClickDelete()
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(TipContent.Friend_DeleteAlert), function()
    if self.friendDataCenter:TryGetFriendData(self.userInfoData:GetUserUID()) ~= nil then
      self.friendNetworkCtrl:CS_FRIEND_DissolveFriend(self.userInfoData:GetUserUID())
    end
  end, nil)
end

function UINUserInfoDropdownListGroup:__OnClickBlock()
  local userName = self.userInfoData:GetAlias()
  local messageStr = string.format(ConfigData:GetTipContent(TipContent.Frined_AddToBlacklist), userName)
  cs_MessageCommon.ShowMessageBox(messageStr, function()
    if self.friendDataCenter:TryGetFriendData(self.userInfoData:GetUserUID()) ~= nil then
      self.friendNetworkCtrl:CS_Black_Add(self.userInfoData:GetUserUID())
    end
  end, nil)
end

function UINUserInfoDropdownListGroup:__OnClickReport()
  UIManager:ShowWindowAsync(UIWindowTypeID.Report, function(window)
    window:InitReport(self.userInfoData)
  end)
end

function UINUserInfoDropdownListGroup:OnDelete()
  for k, v in pairs(self.itemDic) do
    v:Delete()
  end
  self.itemDic = nil
  base.OnDelete(self)
end

return UINUserInfoDropdownListGroup
