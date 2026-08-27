local UINResourceGroup = class("UINResourceGroup", UIBaseNode)
local base = UIBaseNode
local UINResourceItem = require("Game.CommonUI.ResourceGroup.UINResourceItem")
local DefaultResourceIds = {
  1001,
  1002,
  1003
}

function UINResourceGroup:OnInit()
  self.resourceIds = DefaultResourceIds
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.materialItemPool = UIItemPool.New(UINResourceItem, self.ui.obj_resourceItem)
  self.ui.obj_resourceItem:SetActive(false)
  self.__updateTopCurrencys = BindCallback(self, self.__UpdateTopCurrencys)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__updateTopCurrencys)
  self.__updateCurrencys4ARG = BindCallback(self, self.__UpdateCurrencys4ARG)
  MsgCenter:AddListener(eMsgEventId.UpdateARGItem, self.__updateCurrencys4ARG)
  self:__InitTopCurrencys()
end

function UINResourceGroup:ChangeResourceItemClass(newClass)
  self.materialItemPool:DeleteAll()
  self.materialItemPool = UIItemPool.New(newClass, self.ui.obj_resourceItem)
  self:__InitTopCurrencys()
end

function UINResourceGroup:__InitTopCurrencys()
  local matItemDataList = {}
  local smallMatItemDataList = {}
  for _, id in pairs(self.resourceIds) do
    local itemCfg = ConfigData.item[id]
    if itemCfg == nil then
      error("item Cfg is null :" .. tostring(id))
      return
    end
    if itemCfg.small_icon_type then
      table.insert(smallMatItemDataList, itemCfg)
    else
      table.insert(matItemDataList, itemCfg)
    end
  end
  self.materialItemPool:HideAll()
  for _, itemCfg in pairs(smallMatItemDataList) do
    local item = self.materialItemPool:GetOne()
    item:InitCurrencyItem(itemCfg)
  end
  for _, itemCfg in pairs(matItemDataList) do
    local item = self.materialItemPool:GetOne()
    item:InitCurrencyItem(itemCfg)
  end
end

function UINResourceGroup:UpdateResourceGroupTopCurrencys()
  self:__UpdateTopCurrencys()
end

function UINResourceGroup:__UpdateTopCurrencys()
  for _, item in ipairs(self.materialItemPool.listItem) do
    item:UpdateCount()
  end
end

function UINResourceGroup:__UpdateCurrencys4ARG(changedItemNumDic)
  for _, item in ipairs(self.materialItemPool.listItem) do
    if changedItemNumDic[item.itemCfg.id] ~= nil then
      item:UpdateCount()
    end
  end
end

function UINResourceGroup:SetResourceIds(ids, setCommonAddBtn)
  self.resourceIds = {}
  if table.count(ids) <= 0 then
    self.resourceIds = DefaultResourceIds
  else
    for index, id in ipairs(ids) do
      if 7 < index then
        break
      end
      table.insert(self.resourceIds, id)
    end
  end
  self:__InitTopCurrencys()
  if setCommonAddBtn then
    self:SetCommonResourceAddBtn()
  end
end

function UINResourceGroup:SetCommonResourceAddBtn()
  for _, item in ipairs(self.materialItemPool.listItem) do
    local itemId = item.itemCfg.id
    local addCallback = UIUtil.GetItemResAddFunc(itemId)
    if addCallback ~= nil then
      item:SetAddBtn(true, addCallback)
    end
  end
end

function UINResourceGroup:SetResourceAddBtnFunc(itemId, bool, addBtnCallback)
  for _, item in ipairs(self.materialItemPool.listItem) do
    if item.itemCfg.id == itemId then
      item:SetAddBtn(bool, addBtnCallback)
    end
  end
end

function UINResourceGroup:GetResourceItem(id)
  local resItem
  for _, item in ipairs(self.materialItemPool.listItem) do
    if item.itemCfg.id == id then
      resItem = item
    end
  end
  return resItem
end

function UINResourceGroup:GetResItemPos(id)
  local pos
  local item = self:GetResourceItem(id)
  if item ~= nil then
    pos = item.transform.position
  end
  return pos
end

function UINResourceGroup:SetResItemNum(itemId, num)
  local resItem = self:GetResourceItem(itemId)
  if resItem ~= nil then
    resItem:UpdateCount(num)
  end
end

function UINResourceGroup:OnDelete()
  self.materialItemPool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__updateTopCurrencys)
  MsgCenter:RemoveListener(eMsgEventId.UpdateARGItem, self.__updateCurrencys4ARG)
  base.OnDelete(self)
end

return UINResourceGroup
