local UIUserFriendBlackListNode = class("UIUserFriendBlackListNode", UIBaseNode)
local base = UIBaseNode
local UIUserFriendBlackListItem = require("Game.Friend.UI.UIUserFriendBlackListItem")

function UIUserFriendBlackListNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemList = {}
  self.friendDataCenter = PlayerDataCenter.friendDataCenter
  self.RemoveBlackListFunc = BindCallback(self, self.__RemoveBlackListFunc)
  local userChatCtrl = ControllerManager:GetController(ControllerTypeId.ChatSystem, true)
  self.blacklistMax = userChatCtrl:GetChatSystemMainCfg().blacklist_max
end

function UIUserFriendBlackListNode:RefreshBlackListNode(resLoader)
  self.ui.tex_limit:SetIndex(0, tostring(self.friendDataCenter:GetBlackListNum()), tostring(self.blacklistMax))
  local list = self.friendDataCenter:GetBlackList()
  self.ui.obj_item:SetActive(false)
  for k, v in ipairs(self.itemList) do
    v.go:SetActive(false)
  end
  for k, v in ipairs(list) do
    self:RefreshBlackListItem(k, v, self.RemoveBlackListFunc, resLoader)
  end
end

function UIUserFriendBlackListNode:RefreshBlackListItem(index, userdata, removeFunc, resLoader)
  local itemTable = self.itemList[index]
  if itemTable and itemTable.item then
    local item = itemTable.item
    item:RefreshItemData(userdata)
    self.itemList[index].item = item
    self.itemList[index].go:SetActive(true)
  else
    local go = self.ui.obj_item:Instantiate(self.ui.obj_holder)
    go:SetActive(true)
    local item = UIUserFriendBlackListItem.New()
    item:Init(go)
    item:InitItem(index, userdata, removeFunc, resLoader)
    self.itemList[index] = {}
    self.itemList[index].item = item
    self.itemList[index].go = go
  end
end

function UIUserFriendBlackListNode:__RemoveBlackListFunc(resLoader)
  self:RefreshBlackListNode(resLoader)
end

function UIUserFriendBlackListNode:OnDelete()
  for _, v in ipairs(self.itemList) do
    v.item:Delete()
  end
  self.itemList = nil
  base.OnDelete(self)
end

return UIUserFriendBlackListNode
