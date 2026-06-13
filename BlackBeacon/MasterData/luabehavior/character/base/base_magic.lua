local commonMagicBase = {}
local roleMagicBase = {}
local monsterMagicBase = {}
commonMagicBase.__index = commonMagicBase

function commonMagicBase.new(magicBase, unit, id, name)
  local result = setmetatable({}, magicBase)
  result.base = magicBase
  result:_init(unit, id, name)
  return result
end

function commonMagicBase._init(magic, unit, id, name)
  local magic = magic
  magic.id = id
  magic.name = name
  magic.unit = unit
  magic.tool = unit.tool
end

function commonMagicBase.insertFun(magic, funName, newFun)
  magic.tool.insert(magic, funName, newFun)
end

function commonMagicBase.removeFun(magic, funName, newFun)
  magic.tool.remove(magic, funName, newFun)
end

function commonMagicBase.onBegin(magic, caster, target)
end

function commonMagicBase.onEnd(magic, casterNpc, target)
end

function commonMagicBase.befDamage(magic, caster, target, damageSign, damageType, targetCamp, changeToungh, magicLv, skillId, missile)
end

function commonMagicBase.afterDamage(magic, caster, target, damageSign, damageType, isCrit, damageVal, baseDamage, elementDamage, skillId, missile)
end

function commonMagicBase.onKill(magic, caster, target)
end

roleMagicBase.__index = roleMagicBase
setmetatable(roleMagicBase, commonMagicBase)

function roleMagicBase.new(roleMagicBase, role, id, name)
  local roleMagic = setmetatable({}, roleMagicBase)
  roleMagic.base = roleMagicBase
  roleMagic.role = role
  roleMagic:_init(role, id, name)
  return roleMagic
end

function roleMagicBase.onBegin(magic, caster, target)
end

function roleMagicBase.onEnd(magic, casterNpc, target)
end

monsterMagicBase.__index = monsterMagicBase
setmetatable(monsterMagicBase, commonMagicBase)

function monsterMagicBase.new(monsterMagicBase, monster, id, name)
  local roleMagic = setmetatable({}, monsterMagicBase)
  roleMagic.base = monsterMagicBase
  roleMagic.monster = monster
  roleMagic:_init(monster, id, name)
  return roleMagic
end

function monsterMagicBase.onBegin(magic, caster, target)
end

function monsterMagicBase.onBreak(magic, casterNpc, target)
end

function monsterMagicBase.onEnd(magic, casterNpc, target)
end

function monsterMagicBase.onQuit(magic, casterNpc, target)
end

local magicBases = {
  common = commonMagicBase,
  role = roleMagicBase,
  monster = monsterMagicBase
}
return magicBases
