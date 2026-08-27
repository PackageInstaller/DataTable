local base = UIBaseNode
local UINRfCardSetSelectSetNodeSysNode = class("UINRfCardSetSelectSetNodeSysNode", base)
local UINRfCardSetSelectSetNodeList2Item = require("Game.Reinforce.UI.CardSet.Select.SetNode.FacNode.UINRfCardSetSelectSetNodeList2Item")

function UINRfCardSetSelectSetNodeSysNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.list2SelfItem = UINRfCardSetSelectSetNodeList2Item.New()
  self.list2SelfItem:Init(self.ui.Item)
  self.list2FriendItem = UINRfCardSetSelectSetNodeList2Item.New()
  local list2FriendItemGo = self.ui.Item:Instantiate()
  self.list2FriendItem:Init(list2FriendItemGo)
  self._OnFactorCardSetFacCardChange = BindCallback(self, self.OnFactorCardSetFacCardChange)
  MsgCenter:AddListener(eMsgEventId.ReinforceFactorCardSetCardChange, self._OnFactorCardSetFacCardChange)
end

function UINRfCardSetSelectSetNodeSysNode:InitSetNodeFacPanel(setNode, dataAll, actLongId, resLoader)
  self.setNode = setNode
  self.dataAll = dataAll
  self.actLongId = actLongId
  self.resLoader = resLoader
  self.list2SelfItem:InitList2Item(self.setNode, self.dataAll, actLongId, resLoader)
  self.list2FriendItem:InitList2Item(self.setNode, self.dataAll, actLongId, resLoader)
  self:OnFactorCardSetFacCardChange()
  self.setNode:RefreshEquipNum()
end

function UINRfCardSetSelectSetNodeSysNode:OnFactorCardSetFacCardChange()
  if self.setNode == nil then
    return
  end
  local selfCardIndex = self.setNode.facIndex
  local selfCardData = self.setNode.alSelectList[selfCardIndex]
  local selfIsEquip = selfCardData ~= nil
  self.list2SelfItem:RefreshList2Item(true, selfCardData, selfCardIndex, selfIsEquip)
  local supportCardIndex = self.setNode.supportFacIndex
  local supportCardData = self.setNode.alSelectList[supportCardIndex]
  local supportIsEquip = supportCardData ~= nil
  self.list2FriendItem:RefreshList2Item(false, supportCardData, supportCardIndex, supportIsEquip)
end

function UINRfCardSetSelectSetNodeSysNode:OnDelete()
  self.list2SelfItem:Delete()
  self.list2FriendItem:Delete()
  MsgCenter:RemoveListener(eMsgEventId.ReinforceFactorCardSetCardChange, self._OnFactorCardSetFacCardChange)
end

return UINRfCardSetSelectSetNodeSysNode
