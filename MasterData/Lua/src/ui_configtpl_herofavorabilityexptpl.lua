local this = class("heroFavorabilityExpTpl")

function this:init(config)
  self.data = config
  self.maxFavorabilityLevel = 0
  self.levelUpTotalExp = {}
  self.levelUpTotalExp[0] = 0
  local tmp = {}
  for _, v in pairs(self.data) do
    if v.favorabilityLevel > self.maxFavorabilityLevel then
      self.maxFavorabilityLevel = v.favorabilityLevel
    end
    table.insert(tmp, v)
  end
  table.sort(tmp, function(a, b)
    return a.favorabilityLevel < b.favorabilityLevel
  end)
  for _, v in ipairs(tmp) do
    if v.favorabilityLevel == 0 then
      self.levelUpTotalExp[v.favorabilityLevel] = v.favorabilityExp
    else
      self.levelUpTotalExp[v.favorabilityLevel] = self.levelUpTotalExp[v.favorabilityLevel - 1] + v.favorabilityExp
    end
  end
end

function this:getTplById(id)
  return self.data[id]
end

function this:getMaxFavorabilityLevel()
  return self.maxFavorabilityLevel
end

function this:getFavorabilityExp(tpl)
  return tpl.favorabilityExp
end

function this:getFavorabilityTotalExp(level)
  if level > self.maxFavorabilityLevel then
    level = self.maxFavorabilityLevel
  end
  return self.levelUpTotalExp[level] or 0
end

function this:getFavorabilityLevel(tpl)
  return tpl.favorabilityLevel
end

return this
