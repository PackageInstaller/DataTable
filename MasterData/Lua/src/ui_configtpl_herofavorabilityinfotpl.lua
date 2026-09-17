local this = class("heroFavorabilityInfoTpl")

function this:init(config)
  self.data = {}
  for i, v in pairs(config) do
    if self.data[v.heroId] == nil then
      self.data[v.heroId] = {}
    end
    self.data[v.heroId][v.favorabilityLevel] = v
  end
end

function this:getChildren(heroId)
  return self.data[heroId]
end

function this:getTplById(heroId, level)
  if self.data[heroId] then
    return self.data[heroId][level]
  end
  return nil
end

function this:getInfo(tpl)
  return tpl.info
end

function this:getFavorabilityLevel(tpl)
  return tpl.favorabilityLevel
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getLevelUpAttribute(tpl)
  return tpl.levelUpAttribute
end

return this
