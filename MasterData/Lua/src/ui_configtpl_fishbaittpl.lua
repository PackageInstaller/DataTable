local this = class("fishBaitTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getFishRodName(tpl)
  return tpl.fishRodName
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getIconMain(tpl)
  return tpl.iconMain
end

function this:getId(tpl)
  return tpl.id
end

return this
