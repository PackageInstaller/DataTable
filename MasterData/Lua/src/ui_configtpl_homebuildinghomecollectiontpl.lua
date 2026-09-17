local this = class("homeBuildingHomecollectionTpl")

function this:init(config)
  self.data = config
  self.groupData = {}
  for i, v in pairs(config) do
    if not self.groupData[v.groupId] then
      self.groupData[v.groupId] = {}
    end
    self.groupData[v.groupId][v.level] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getType(tpl)
  return tpl.type
end

function this:getId(tpl)
  return tpl.id
end

function this:getStorageMax(tpl)
  return tpl.storageMax
end

function this:getProducts(tpl)
  return tpl.products
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getLevel(tpl)
  return tpl.level
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getTplByGroupIdAndLevel(groupId, level)
  if self.groupData[groupId] then
    return self.groupData[groupId][level]
  end
  return nil
end

function this:getRevenuetime(tpl)
  return tpl.revenuetime
end

function this:getMiniIcon(tpl)
  return tpl.miniIcon or "Altas/HomeButton/tex_home_entrance_icon_suishichang.png"
end

function this:getFrameTexture(tpl)
  return tpl.frameTexture
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getUpgradeDesc(tpl)
  local res = {}
  for _, key in ipairs(tpl.upgradeDesc) do
    table.insert(res, L_Config:provider(key))
  end
  return res
end

function this:getUpgradeCondition(tpl)
  return tpl.upgradeCondition
end

function this:getMaterial(tpl)
  return tpl.material
end

function this:getPetCapacity(tpl)
  return tpl.petCapacity
end

function this:getPetSize(tpl)
  return tpl.petSize
end

function this:getMaxLevelProducts(collectionId)
  local buildings = self:getTplByCollectionId(collectionId)
  local tpl_maxLevel = buildings[table.count(buildings)]
  return tpl_maxLevel.products, tpl_maxLevel.extraProducts
end

function this:getShowAllProducts(collectionId, level)
  local buildings = self:getTplByCollectionId(collectionId)
  local _productsTpl = L_GameTpl:getProductsCollectionTpl()
  level = level or 1
  local productIds = {}
  local productDict = {}
  for i = level, #buildings do
    local tpl = buildings[i]
    for i, productId in ipairs(tpl.products) do
      local tpl_pro = _productsTpl:getTplById(productId)
      local dropShow = _productsTpl:getDropShow(tpl_pro)[1][2]
      if not productDict[dropShow] then
        table.insert(productIds, productId)
        productDict[dropShow] = 1
      end
    end
    for i, productId in ipairs(tpl.extraProducts) do
      local tpl_pro = _productsTpl:getTplById(productId)
      local dropShow = _productsTpl:getDropShow(tpl_pro)[1][2]
      if not productDict[dropShow] then
        table.insert(productIds, productId)
        productDict[dropShow] = 1
      end
    end
  end
  return productIds
end

function this:getShowProducts(collectionId, level)
  local buildings = self:getTplByCollectionId(collectionId)
  local _productsTpl = L_GameTpl:getProductsCollectionTpl()
  level = level or 1
  local productIds = {}
  local productDict = {}
  for i = level, #buildings do
    local tpl = buildings[i]
    for i, productId in ipairs(tpl.products) do
      local tpl_pro = _productsTpl:getTplById(productId)
      local dropShow = _productsTpl:getDropShow(tpl_pro)[1][2]
      if not productDict[dropShow] then
        table.insert(productIds, productId)
        productDict[dropShow] = 1
      end
    end
  end
  return productIds
end

function this:getTplByCollectionId(collectionId)
  local homeCollectionWorldTpl = L_GameTpl:getHomeCollectionWorldTpl()
  local tpl_collection = homeCollectionWorldTpl:getTplById(collectionId)
  local groupId = homeCollectionWorldTpl:getGroupId(tpl_collection)
  return self.groupData[groupId]
end

function this:getBaseBuildingId(collectionId)
  local buildings = self:getTplByCollectionId(collectionId)
  return buildings[1].id
end

function this:getIsNeedPet(tpl)
  return tpl.isNeedPet
end

function this:getPetPosition(tpl)
  local pos = tpl.petPosition
  return L_Vector3.new(pos[1], pos[2], pos[3])
end

function this:getPetRotation(tpl)
  local pos = tpl.petRotation
  return L_Vector3.new(pos[1], pos[2], pos[3])
end

function this:getCameraVerticalAngle(tpl)
  return tpl.cameraVerticalAngle
end

function this:getCameraHorizontalAngle(tpl)
  return tpl.cameraHorizontalAngle
end

function this:getCameraDistance(tpl)
  return tpl.cameraDistance
end

function this:getLaborType(tpl)
  return tpl.laborType
end

return this
