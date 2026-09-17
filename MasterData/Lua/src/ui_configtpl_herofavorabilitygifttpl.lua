local this = class("heroFavorabilityGiftTpl")

function this:init(config)
  self.data = config
  local heroIDs = {}
  local HeroData = L_GameTpl:getHeroTpl().data
  for key, value in pairs(HeroData) do
    table.insert(heroIDs, key)
  end
  self.heroPresentMap = {}
  for itemId, value in pairs(self.data) do
    if #value.favourHero > 0 then
      for kk, heroId in ipairs(value.favourHero) do
        if self.heroPresentMap[heroId] == nil then
          self.heroPresentMap[heroId] = {}
        end
        if table.containsValue(self.heroPresentMap[heroId], itemId) == false then
          table.insert(self.heroPresentMap[heroId], {
            id = itemId,
            name = L_Config:provider(value.name),
            normalValue = value.normalValue,
            favourValue = value.favourValue
          })
        end
      end
    else
      for kk, heroId in ipairs(heroIDs) do
        if table.containsValue(self.heroPresentMap[heroId], itemId) == false then
          table.insert(self.heroPresentMap[heroId], {
            id = itemId,
            name = L_Config:provider(value.name),
            normalValue = value.normalValue,
            favorValue = value.favourValue
          })
        end
      end
    end
  end
end

function this:getAllData()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getFavorById(id)
  return self.data[id].favourValue
end

function this:getTplByHeroID(id)
  print("==========================id")
  return self.heroPresentMap[id]
end

function this:getStringNameByHeroID(id)
  return L_Config:provider(self.data[id].name)
end

function this:isFavor(itemid, heroid)
  if self.data[itemid] then
    if #self.data[itemid].favourHero == 0 then
      return true
    end
    for itemId, value in ipairs(self.data[itemid].favourHero) do
      if value == heroid then
        return true
      end
    end
  end
  return false
end

return this
