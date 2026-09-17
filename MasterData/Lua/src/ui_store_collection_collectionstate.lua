local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    collectionMap = {}
  }
end

function this:getAllCollection()
  return self.data.collectionMap
end

function this:getCollection(collectionId)
  return self.data.collectionMap[collectionId] or {}
end

function this:getCollectionNoFixed(collectionId)
  return math.isEmpty(self:getCollection(collectionId).build_id)
end

function this:getCollectionProductReward(collectionId, productId)
  local collection = self:getCollection(collectionId)
  local products = collection.product_infos or {}
  for i, v in pairs(products) do
    if v.product_id == productId then
      return v
    end
  end
  return {
    product_id = collectionId,
    collect_num = 0,
    receive_num = 0
  }
end

function this:getCollectionCommonItemsReward(collectionId)
  local collection = self:getCollection(collectionId)
  local rewards = collection.items or {}
  local itemRewards = {}
  for i, v in pairs(rewards) do
    table.insert(itemRewards, {
      itemId = v.item_id,
      itemNum = v.item_num,
      itemType = v.item_type,
      product_id = v.source_product_id,
      sort_arg1 = v.sort_arg1,
      sort_arg2 = v.sort_arg2
    })
  end
  return itemRewards
end

return this
