local this = class("homeDropTpl")

function this:init(config)
  self.data = config
  self.maxExpList = {}
  self.itemId2IsSurpriseDic = {}
  for _, v in pairs(config) do
    local itemIdList = v.itemId
    local itemType = v.itemType
    local exp = v.home_exp
    local isSurprise = v.isSurprise == 1
    if self.maxExpList[itemType] == nil then
      self.maxExpList[itemType] = {}
    end
    for _, itemId in ipairs(itemIdList) do
      local curMaxExp = self.maxExpList[itemType][itemId]
      if curMaxExp == nil or exp > curMaxExp then
        self.maxExpList[itemType][itemId] = curMaxExp
      end
      self.itemId2IsSurpriseDic[itemId] = isSurprise
    end
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getMaxValue(tpl)
  return tpl.maxValue
end

function this:getRate(tpl)
  return tpl.rate
end

function this:getMinValue(tpl)
  return tpl.minValue
end

function this:getDropTime(tpl)
  return tpl.dropTime
end

function this:getItemType(tpl)
  return tpl.itemType
end

function this:getItemId(tpl)
  return tpl.itemId
end

function this:getExp(tpl)
  return tpl.home_exp
end

function this:getIsSurprise(tpl)
  return tpl.isSurprise
end

function this:findHomeExpByCommonItemTpl(itemTpl)
  local tpl = L_GameTpl:getCommonItemTpl()
  local id = tpl:getId(itemTpl)
  local type = tpl:getType(itemTpl)
  for k, v in pairs(self.data) do
    if self:getItemId(v) == id and self:getItemType(v) == type then
      return self:getExp(v)
    end
  end
  return 0
end

function this:findHomeExpByItemIdAndItemType(itemId, itemType)
  if self.maxExpList[itemId] == nil or self.maxExpList[itemId][itemType] == nil then
    errorf(string.format("未找到HomeDrop配置的最大经验值，ItemId = %s, ItemType = %s", itemId, itemType))
    return 0
  end
  local maxExp = self.maxExpList[itemId][itemType]
  return maxExp
end

function this:getIsSurpriseHarvest(itemId)
  if self.itemId2IsSurpriseDic[itemId] == nil then
    return false
  end
  return self.itemId2IsSurpriseDic[itemId]
end

return this
