local this = class("enemyTpl")

function this:init(config)
  self.data = config
end

function this:getAllTpl()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getUnitId(tpl)
  return tpl.unitId
end

function this:getBackupSkillList(tpl)
  return tpl.backupSkillList
end

function this:getEnemyType(tpl)
  return tpl.enemyType
end

function this:getAttackSkill(tpl)
  return tpl.attackSkill
end

function this:getId(tpl)
  return tpl.id
end

function this:getBossItemNum(tpl)
  return tpl.bossItemNum
end

function this:getPassiveSkillList(tpl)
  return tpl.passiveSkillList
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getSkillBytesPath(tpl)
  return tpl.skillBytesPath
end

function this:getPetId(tpl)
  return tpl.petId
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getIsBossHpBar(tpl)
  return tpl.isBossHpBar
end

function this:getPropertyId(tpl)
  return tpl.propertyId
end

function this:getSkillList(tpl)
  return tpl.skillList
end

function this:getHpBarWeakness(tpl)
  return tpl.hpBarWeakness == 1
end

function this:getAvatarTexture(tpl)
  return tpl.avatarTexture
end

function this:getElement(tpl)
  return tpl.element
end

function this:getFirstElement(tpl)
  return tpl.element[1]
end

return this
