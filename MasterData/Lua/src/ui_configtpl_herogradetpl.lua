local this = class("heroGradeTpl")

function this:init(config)
  self.data = config
  self.hero_data = {}
  for k, v in pairs(self.data) do
    if not self.hero_data[v.heroId] then
      self.hero_data[v.heroId] = {}
    end
    self.hero_data[v.heroId][v.grade] = v
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getTplByHeroIdAndGrade(heroId, grade)
  if self.hero_data and self.hero_data[heroId] then
    if grade then
      return self.hero_data[heroId][grade]
    else
      return self.hero_data[heroId]
    end
  else
    return nil
  end
end

function this:getTitle(tpl)
  return L_Config:provider(tpl.title)
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.text)
end

function this:getRwd(tpl)
  return tpl.reward
end

return this
