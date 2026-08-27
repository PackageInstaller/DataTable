local UINWarehouseItem = class("UINWarehouseItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINWarehouseItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.item = UINBaseItemWithCount.New()
  self.item:Init(self.ui.uINBaseItemWithCount)
end

function UINWarehouseItem:InitWarehouseItem(itemCfg, count, clickEvent, wareHouseNum)
  self.itemCfg = itemCfg
  self.outTime = nil
  self.item:InitItemWithCount(itemCfg, count, clickEvent, wareHouseNum, BindCallback(self, self.OnClickExtra))
  self:RefreshRedDotState()
end

function UINWarehouseItem:InitWarehouseDynLimitTimeItem(itemCfg, stackInfo, clickEvent, wareHouseNum)
  self.itemCfg = itemCfg
  self.outTime = stackInfo.time
  self.item:InitItemWithCount(itemCfg, stackInfo.num, clickEvent, wareHouseNum, BindCallback(self, self.OnClickExtra))
  self.item:BindClickCustomArg(stackInfo)
  self:RefreshRedDotState()
  self:UpdateLimitTimeDetail()
end

function UINWarehouseItem:InitWarehouseLimitTimeItem(itemCfg, count, outTime, clickEvent, wareHouseNum)
  self.itemCfg = itemCfg
  self.outTime = outTime
  self.item:InitItemWithCount(itemCfg, count, clickEvent, wareHouseNum, BindCallback(self, self.OnClickExtra))
  self:RefreshRedDotState()
  self:UpdateLimitTimeDetail()
end

function UINWarehouseItem:UpdateLimitTimeDetail()
  if self.outTime ~= nil then
    self.item:ShowLimtTimeDetail(self.outTime)
  end
end

function UINWarehouseItem:RefreshRedDotState()
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Warehouse, self.itemCfg.warehouse_page, self.itemCfg.id)
  if ok then
    self.ui.blueDot:SetActive(node:GetRedDotCount() > 0)
  else
    self.ui.blueDot:SetActive(false)
  end
end

function UINWarehouseItem:OnClickExtra()
  local ok, node = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Warehouse, self.itemCfg.warehouse_page, self.itemCfg.id)
  if ok and node:GetRedDotCount() > 0 then
    node:SetRedDotCount(0)
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetNewGiftItemReddot(self.itemCfg.id, nil)
  end
end

function UINWarehouseItem:SetNum(num)
  self.item:SetNum(num)
end

return UINWarehouseItem
