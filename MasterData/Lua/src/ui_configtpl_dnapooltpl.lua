local this = class("dnaPoolTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getMod(tpl)
  return tpl.mod
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getDna(tpl)
  return tpl.dna
end

function this:getDnaType(tpl)
  return tpl.dnatype
end

return this
