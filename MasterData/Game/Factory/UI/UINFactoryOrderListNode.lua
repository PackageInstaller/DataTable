local UINFactoryOrderListNode = class("UINFactoryOrderListNode", UIBaseNode)
local base = UIBaseNode
local UINFactoryOrderListItem = require("Game.Factory.UI.UINFactoryOrderListItem")
local FactoryEnum = require("Game.Factory.FactoryEnum")

function UINFactoryOrderListNode:OnInit()
  self.factoryController = ControllerManager:GetController(ControllerTypeId.Factory, false)
  self.togSelectType = FactoryEnum.eOrderType.dig
  self.orderItemDic = {}
  self.orderDataList = {}
  self.selectedData = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.loop_factoryItemList.onInstantiateItem = BindCallback(self, self.m_OnNewItem)
  self.ui.loop_factoryItemList.onChangeItem = BindCallback(self, self.m_OnChangeItem)
  self.ui.loop_factoryItemList.onReturnItem = BindCallback(self, self.m_OnReturnItem)
  self.__OnSelectItem = BindCallback(self, self.OnSelectOrderItem)
  self.__OnItemUpdate = BindCallback(self, self.OnItemUpdate)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
end

function UINFactoryOrderListNode:InitList(roomIndex, callback)
  self.roomIndex = roomIndex
  self.onSelectOrderCallback = callback
  self.ui.text_RoomName.text = LanguageUtil.GetLocaleText(ConfigData.factory[roomIndex].name)
  self.ui.tog_Dig.isOn = false
  self.ui.tog_Production.isOn = true
  self.ui.obj_Select:SetActive(false)
  self:RefreshOrderList()
end

function UINFactoryOrderListNode:RefreshOrderList()
  self.orderDataList = self.factoryController:GetOrders(self.roomIndex)
  self.selectedData = nil
  self.ui.loop_factoryItemList.totalCount = #self.orderDataList
  self.ui.loop_factoryItemList:RefillCells()
  local firstOederData = self.orderDataList[1]
  self.ui.img_Icon:SetIndex(firstOederData:GetOrderType() - 1)
end

function UINFactoryOrderListNode:m_OnNewItem(go)
  local orderItem = UINFactoryOrderListItem.New()
  orderItem:Init(go)
  orderItem:SetValueChangeCallback(self.__OnSelectItem)
  self.orderItemDic[go] = orderItem
end

function UINFactoryOrderListNode:m_OnChangeItem(go, index)
  local orderItem = self.orderItemDic[go]
  if orderItem == nil then
    error("Can't find orderItem by gameObject")
    return
  end
  local orderData = self.orderDataList[index + 1]
  if orderData == nil then
    error("Can't find orderData by index, index = " .. tonumber(index))
  end
  local couldProdunc = orderData:GetCouldProdunc(self.factoryController)
  orderItem:InitOrderListItem(orderData, couldProdunc)
  if self.selectedData == orderData then
    self:moveSelect2Item(orderItem)
  end
end

function UINFactoryOrderListNode:m_OnReturnItem(go)
  local levelItem = self.orderItemDic[go]
  if levelItem == nil then
    error("Can't find levelItem by gameObject")
    return
  end
  local orderData = levelItem.orderData
  if self.selectedData == orderData then
    self.ui.obj_Select:SetActive(false)
  end
end

function UINFactoryOrderListNode:m_GetOrderItemByData(orderData)
  for k, v in ipairs(self.treeDataList) do
    if v == orderData then
      local index = k - 1
      return self:m_GetOrderItemGoByIndex(index), index
    end
  end
end

function UINFactoryOrderListNode:m_GetOrderItemGoByIndex(index)
  if index > self.ui.loop_factoryItemList.totalCount then
    return nil
  end
  local go = self.ui.loop_factoryItemList:GetCellByIndex(index)
  if go ~= nil then
    local orderItem = self.orderItemDic[go]
    return orderItem
  end
  return nil
end

function UINFactoryOrderListNode:moveSelect2Item(orderItem)
  self.ui.obj_Select:SetActive(true)
  self.ui.obj_Select.transform:SetParent(orderItem.transform)
  self.ui.obj_Select.transform.position = orderItem.transform.position
end

function UINFactoryOrderListNode:OnSelectOrderItem(orderItem)
  self.selectedData = orderItem.orderData
  self:moveSelect2Item(orderItem)
  if self.onSelectOrderCallback ~= nil then
    self.onSelectOrderCallback(orderItem.orderData)
  end
end

function UINFactoryOrderListNode:DeSelect()
  self.selectedData = nil
  self.ui.obj_Select:SetActive(false)
end

function UINFactoryOrderListNode:UpdateEnergy()
  local goArry = self.ui.loop_factoryItemList:GetAllCellObj()
  for i = 0, goArry.Length - 1 do
    local go = goArry[i]
    local item = self.orderItemDic[go]
    if item ~= nil then
      local couldProdunc = item.orderData:GetCouldProdunc(self.factoryController)
      item:RefreshCouldProdunc(couldProdunc)
    end
  end
end

function UINFactoryOrderListNode:OnItemUpdate(itemUpdate)
  for index, orderData in ipairs(self.orderDataList) do
    if itemUpdate[orderData:GetOrderCfg().outPutItemId] ~= nil then
      local item = self:m_GetOrderItemGoByIndex(index - 1)
      if item ~= nil then
        item:RefreshWarehousNum()
      end
    end
  end
  self:UpdateEnergy()
end

function UINFactoryOrderListNode:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__OnItemUpdate)
  base.OnDelete(self)
end

return UINFactoryOrderListNode
