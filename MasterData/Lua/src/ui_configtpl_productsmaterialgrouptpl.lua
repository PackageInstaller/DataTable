local this = class("productsMaterialGroupTpl")

function this:init(config)
  self.data = config
  self.materialGroupId2GroupData = {}
  self:initMaterialGroupId2GroupData()
end

function this:initMaterialGroupId2GroupData()
  for tableId, tpl in pairs(self.data) do
    local materialGroupId = self:getMaterialGroupId(tpl)
    local itemInfo = self:getItemInfo(tpl)
    self.materialGroupId2GroupData[materialGroupId] = self.materialGroupId2GroupData[materialGroupId] or {}
    local groupData = self.materialGroupId2GroupData[materialGroupId]
    local itemData = {}
    itemData.tableId = tableId
    itemData.materialGroupId = materialGroupId
    itemData.itemType = itemInfo[1][1]
    itemData.itemId = itemInfo[1][2]
    itemData.itemNum = itemInfo[1][3]
    table.insert(groupData, itemData)
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getMaterialGroupId(tpl)
  return tpl.materialGroupId
end

function this:getItemInfo(tpl)
  return tpl.material
end

function this:getGroupDataByMaterialGroupId(materialGroupId)
  return self.materialGroupId2GroupData[materialGroupId]
end

return this
