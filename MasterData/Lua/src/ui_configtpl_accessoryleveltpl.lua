local this = class("accessoryLevelTpl")

function this:init(config)
  self.data = {}
  self.subAttLevelDic = {}
  for _, v in ipairs(config) do
    if not self.data[v.accessoryId] then
      self.data[v.accessoryId] = {}
    end
    table.insert(self.data[v.accessoryId], v)
    if not self.subAttLevelDic[v.rarity] then
      self.subAttLevelDic[v.rarity] = {}
    end
    if v.unlock_entry > 0 then
      if not self.subAttLevelDic[v.rarity][v.unlock_entry] then
        self.subAttLevelDic[v.rarity][v.unlock_entry] = v.level
      else
        self.subAttLevelDic[v.rarity][v.unlock_entry] = math.min(self.subAttLevelDic[v.rarity][v.unlock_entry], v.level)
      end
    end
  end
  for accessoryId, v in pairs(self.data) do
    table.sort(v, function(a, b)
      return a.level < b.level
    end)
  end
end

function this:getTplByAccessoryIdAndLevel(accessoryId, level)
  for i, v in ipairs(self.data[accessoryId] or {}) do
    if v.level == level then
      return v
    end
  end
  return nil
end

function this:getMaxLevelByAccessoryId(accessoryId)
  local levels = self.data[accessoryId]
  return levels[#levels].level
end

function this:getUnlockEntry(tpl)
  return tpl and tpl.unlock_entry or 0
end

function this:getLevelBySubAttIndex(rarity, index)
  return self.subAttLevelDic[rarity][index]
end

function this:getUpgradeCostByAccessoryIdAndLevel(accessoryId, level)
  local tpl = self:getTplByAccessoryIdAndLevel(accessoryId, level)
  return self:getUpgradeCost(tpl)
end

function this:getUpgradeCost(tpl)
  return tpl.item
end

function this:getAccessoryReturnReward(accessoryId, level)
  local tpl = self:getTplByAccessoryIdAndLevel(accessoryId, level)
  return self:getReturnReward(tpl)
end

function this:getReturnReward(tpl)
  return tpl.return_item
end

return this
