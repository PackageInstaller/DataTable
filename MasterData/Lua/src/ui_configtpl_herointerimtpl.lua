local this = class("heroInterimTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getRank(tpl)
  if tpl == nil then
    return 1
  end
  if tpl.rank == nil then
    return 1
  end
  return tpl.rank
end

function this:getId(tpl)
  return tpl.id
end

function this:getSkilllevel(tpl)
  if tpl == nil then
    return 1
  end
  if tpl.skilllevel == nil then
    return 1
  end
  return tpl.skilllevel
end

function this:getLevel(tpl)
  if tpl == nil then
    return 1
  end
  if tpl.level == nil or tpl.level <= 0 then
    return 1
  end
  return tpl.level
end

function this:getSoulEssence(tpl)
  return tpl.soulessence
end

function this:getAccessorySet(tpl)
  return tpl.accessorySet
end

function this:getHeroId(tpl)
  return tpl.heroId
end

return this
