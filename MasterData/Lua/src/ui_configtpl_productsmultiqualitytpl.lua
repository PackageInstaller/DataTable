local this = class("productsMultiQualityTpl")
local _foodMaterialTpl = L_GameTpl:getFoodMaterialGroupTpl()

function this:init(config)
  self.data = config
  self.foodGroupId2productIdListDic = {}
  self.foodGroupId2ItemIdList = {}
  for _, rowData in pairs(config) do
    local productId = rowData.productId
    local productGroupId = rowData.productGroup
    local itemId = rowData.id
    self.foodGroupId2productIdListDic[productGroupId] = self.foodGroupId2productIdListDic[productGroupId] or {}
    self.foodGroupId2ItemIdList[productGroupId] = self.foodGroupId2ItemIdList[productGroupId] or {}
    table.insert(self.foodGroupId2productIdListDic[productGroupId], productId)
    table.insert(self.foodGroupId2ItemIdList[productGroupId], itemId)
  end
  for _, itemIdList in pairs(self.foodGroupId2ItemIdList) do
    table.sort(itemIdList, function(a, b)
      return a < b
    end)
  end
end

function this:tryGetRowDataByConfigId(configId)
  if self.data[configId] then
    return self.data[configId]
  else
    errorf(string.format("productsMultiQualityTpl 没有该配置id:%d", configId))
    return {}
  end
end

function this:containsConfigId(configId)
  if self.data[configId] then
    return true
  else
    return false
  end
end

function this:getProductGroupByConfigId(configId)
  local rowData = self:tryGetRowDataByConfigId(configId)
  return rowData.productGroup
end

function this:getProductIdByConfigId(configId)
  local rowData = self:tryGetRowDataByConfigId(configId)
  return rowData.productId
end

function this:getProductRarityByConfigId(configId)
  local rowData = self:tryGetRowDataByConfigId(configId)
  return rowData.productRarity
end

function this:getNeedMaterialByConfigId(configId)
  local rowData = self:tryGetRowDataByConfigId(configId)
  return rowData.needMaterial
end

function this:getProductIdListByFoodGroupId(foodGroupId)
  if self.foodGroupId2productIdListDic[foodGroupId] then
    return self.foodGroupId2productIdListDic[foodGroupId]
  else
    errorf(string.format("productsMultiQualityTpl 无foodGroupId:%d", foodGroupId))
  end
  return nil
end

function this:getItemIdListByFoodGroupId(foodGroupId)
  if self.foodGroupId2ItemIdList[foodGroupId] then
    return self.foodGroupId2ItemIdList[foodGroupId]
  else
    errorf(string.format("无productsMultiQualityTpl 无foodGroupId:%d", foodGroupId))
  end
end

function this:getCanDoTpl(groupId, rarityList)
  local itemIdList = self:getItemIdListByFoodGroupId(groupId)
  for i = #itemIdList, 1, -1 do
    local configId = itemIdList[i]
    local materials = self:getNeedMaterialByConfigId(configId)
    local res = true
    for i = 1, #materials do
      res = res and rarityList[i] >= materials[i][3]
    end
    if res then
      return self.data[configId]
    end
  end
  errorf("有问题，做不出饭 " .. groupId .. "  " .. rarityList[1] .. " " .. rarityList[2] .. " " .. rarityList[3] .. " " .. rarityList[4])
end

function this:getCanDoMaxNum(itemId, rarityList)
  local targetFoodId = itemId
  local materials = self:getNeedMaterialByConfigId(targetFoodId)
  local _foodMaterialGroupTpl = L_GameTpl:getFoodMaterialGroupTpl()
  local canNum = L_Const.maxInt
  for i = 1, 4 do
    local material = materials[i]
    if material then
      local itemId = _foodMaterialGroupTpl:getItemId(material[1], rarityList[i])
      local oneNum = material[2]
      local haveNum = C_BagMgr:getItemNumByItemId(itemId)
      canNum = math.min(canNum, math.floor(haveNum / oneNum))
    end
  end
  return canNum
end

function this:getNeedMaterialByProductId(productId, selectIndexs)
  local needMaterials
  for _, rowData in pairs(self.data) do
    if rowData.productId == productId then
      needMaterials = rowData.needMaterial
      break
    end
  end
  if not needMaterials then
    return
  end
  selectIndexs = selectIndexs or {}
  local materials = {}
  for i, material in ipairs(needMaterials) do
    if material then
      local itemId = _foodMaterialTpl:getItemId(material[1], selectIndexs[i] or 1)
      if itemId then
        table.insert(materials, {
          item_id = itemId,
          item_num = material[2] or 1,
          item_type = L_Const.resType.commonItem
        })
      end
    end
  end
  return materials
end

return this
