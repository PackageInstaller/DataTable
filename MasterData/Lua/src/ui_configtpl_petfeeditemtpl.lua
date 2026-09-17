local this = class("petFeedItemTpl")

function this:init(config)
  self.data = config
end

function this:getAllTpl()
  return self.data
end

function this:getTplById(commonItemId)
  return self.data[commonItemId]
end

function this:getEffectType(tpl)
  return tpl.type
end

function this:getIsReuse(tpl)
  return tpl.isReuse
end

function this:getDnaParam(tpl)
  return tpl.dnaParam
end

function this:getEffectParamList(tpl)
  return tpl.param
end

function this:getAttributeBg(tpl)
  return tpl.bg
end

function this:getTargetFruitItemAddComprehensionAttrEnumNumList(itemId)
  local targetFruitItemAddComprehensionAttrEnumNumList = {}
  local petFeedItemTpl = self:getTplById(itemId)
  if petFeedItemTpl then
    local effectParamList = self:getEffectParamList(petFeedItemTpl)
    for _, effectParam in pairs(effectParamList) do
      local attrEnumNum = effectParam[1]
      table.insert(targetFruitItemAddComprehensionAttrEnumNumList, attrEnumNum)
    end
  end
  return targetFruitItemAddComprehensionAttrEnumNumList
end

function this:getAttrIdListOfPetFeedItemByItemList(itemIdList)
  local attrIdDic = {}
  for _, itemId in pairs(itemIdList) do
    local subAttrIdList = self:getTargetFruitItemAddComprehensionAttrEnumNumList(itemId)
    for _, attrId in pairs(subAttrIdList) do
      attrIdDic[attrId] = true
    end
  end
  local attrIdList = {}
  for attrId, _ in pairs(attrIdDic) do
    table.insert(attrIdList, attrId)
  end
  return attrIdList
end

return this
