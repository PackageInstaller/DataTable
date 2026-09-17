local this = class("talentRuneTpl")

function this:init(config)
  self.data = config
  self.itemMap = {}
  for _, v in pairs(config) do
    self.itemMap[v.runeItem] = v
  end
end

function this:getTplByItemId(itemId)
  return self.itemMap[itemId]
end

function this:getTplById(id)
  return self.data[id]
end

function this:getEquipRuneThroughCoin(tpl)
  return tpl.equipRuneThroughCoin
end

function this:getEquipRuneCoin(tpl)
  return tpl.equipRuneCoin
end

function this:getRuneSkill(tpl)
  return tpl.runeSkill
end

function this:getId(tpl)
  return tpl.id
end

function this:getRuneItem(tpl)
  return tpl.runeItem
end

function this:getRuneAttribute(tpl)
  return tpl.runeAttribute
end

function this:getRuneTypeName(tpl)
  return L_Config:provider(tpl.runeTypeName)
end

function this:getRuneTypeEngName(tpl)
  return tpl.runeTypeEngName
end

function this:getIsDrop(tpl)
  return tpl.isDrop
end

function this:getExtraCost(tpl)
  return tpl.equipRuneCost
end

return this
