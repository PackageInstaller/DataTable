local this = class("homeBuildingProductionTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getProducts(tpl)
  return tpl.products
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getPetSize(tpl)
  return tpl.petSize
end

function this:getProductionQueueNum(tpl)
  return tpl.productionQueueNum
end

function this:getPetHomeAttribute(tpl)
  return tpl.petHomeAttribute
end

function this:getType(tpl)
  return tpl.type
end

function this:getTab(tpl)
  return tpl.tab
end

function this:getLaborType(tpl)
  return tpl.laborType
end

function this:getLaborTypeByCapacity(capacity)
  for _, tpl in pairs(self.data) do
    if tpl.petHomeAttribute == capacity then
      return tpl.laborType
    end
  end
end

function this:getObjId(tpl)
  return tpl.objId
end

function this:getProductListType(tpl)
  return tpl.productListype
end

function this:getReduceSatietyScoreBefore(tpl)
  return tpl.reduceSatietyScoreBefore
end

function this:getOneBuildingIdByGroupId(groupId)
  for _, v in pairs(self.data) do
    if v.groupId == groupId then
      return v.id
    end
  end
end

return this
