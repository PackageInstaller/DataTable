local this = class("enemy_shell", G_BaseConfig)
local core = G_Tables.TDEnemyTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {
  id = 0,
  name = 1,
  desc = 2,
  unitId = 3,
  attackSkill = 4,
  skillList = 5,
  passiveSkillList = 6,
  backupSkillList = 7,
  skillBytesPath = 8,
  changeSkillList = 9,
  enemyType = 10,
  element = 11,
  hpBarType = 12,
  hpIndex = 13,
  hpBarWeakness = 14,
  breakPoint = 15,
  kinsAtkPoint = 16,
  kinsHitTime = 17,
  diminishingReturns = 18,
  knisAttackDistance = 19,
  hpBarName = 20,
  bossItemNum = 21,
  propertyId = 22,
  isUsable = 23,
  avatarTexture = 24,
  collisionType = 25,
  worldCollisionType = 26,
  petId = 27,
  catchCameraParam = 28,
  worldPropertyId = 29,
  moveType = 30,
  defaultMoveType = 31,
  gameplayTag = 32,
  weaponOverride = 33,
  weaponDefault = 34,
  AlertExpression = 35,
  catchHp = 36,
  switchControlRemoveElements = 37
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("enemy", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("enemy", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getUnitid(offset)
  return core:GetInt(offset, this.indexMap.unitId)
end

function this:_getAttackskill(offset)
  return core:GetInt(offset, this.indexMap.attackSkill)
end

function this:_getSkilllist(offset)
  local str = core:GetVString(offset, this.indexMap.skillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getPassiveskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.passiveSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBackupskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.backupSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSkillbytespath(offset)
  local str = core:GetVString(offset, this.indexMap.skillBytesPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getChangeskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.changeSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getEnemytype(offset)
  return core:GetInt(offset, this.indexMap.enemyType)
end

function this:_getElement(offset)
  local str = core:GetVString(offset, this.indexMap.element).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHpbartype(offset)
  return core:GetInt(offset, this.indexMap.hpBarType)
end

function this:_getHpindex(offset)
  local str = core:GetVString(offset, this.indexMap.hpIndex).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHpbarweakness(offset)
  return core:GetInt(offset, this.indexMap.hpBarWeakness)
end

function this:_getBreakpoint(offset)
  return core:GetInt(offset, this.indexMap.breakPoint)
end

function this:_getKinsatkpoint(offset)
  local str = core:GetVString(offset, this.indexMap.kinsAtkPoint).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getKinshittime(offset)
  return core:GetFloat(offset, this.indexMap.kinsHitTime)
end

function this:_getDiminishingreturns(offset)
  return core:GetInt(offset, this.indexMap.diminishingReturns)
end

function this:_getKnisattackdistance(offset)
  local str = core:GetVString(offset, this.indexMap.knisAttackDistance).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHpbarname(offset)
  return core:GetInt(offset, this.indexMap.hpBarName)
end

function this:_getBossitemnum(offset)
  return core:GetInt(offset, this.indexMap.bossItemNum)
end

function this:_getPropertyid(offset)
  return core:GetInt(offset, this.indexMap.propertyId)
end

function this:_getIsusable(offset)
  return core:GetInt(offset, this.indexMap.isUsable)
end

function this:_getAvatartexture(offset)
  local str = core:GetVString(offset, this.indexMap.avatarTexture).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getCollisiontype(offset)
  return core:GetInt(offset, this.indexMap.collisionType)
end

function this:_getWorldcollisiontype(offset)
  return core:GetInt(offset, this.indexMap.worldCollisionType)
end

function this:_getPetid(offset)
  return core:GetInt(offset, this.indexMap.petId)
end

function this:_getCatchcameraparam(offset)
  return core:GetInt(offset, this.indexMap.catchCameraParam)
end

function this:_getWorldpropertyid(offset)
  return core:GetInt(offset, this.indexMap.worldPropertyId)
end

function this:_getMovetype(offset)
  local str = core:GetVString(offset, this.indexMap.moveType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDefaultmovetype(offset)
  return core:GetInt(offset, this.indexMap.defaultMoveType)
end

function this:_getGameplaytag(offset)
  return core:GetVString(offset, this.indexMap.gameplayTag).value
end

function this:_getWeaponoverride(offset)
  return core:GetInt(offset, this.indexMap.weaponOverride)
end

function this:_getWeapondefault(offset)
  return core:GetInt(offset, this.indexMap.weaponDefault)
end

function this:_getAlertexpression(offset)
  local str = core:GetVString(offset, this.indexMap.AlertExpression).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCatchhp(offset)
  return core:GetInt(offset, this.indexMap.catchHp)
end

function this:_getSwitchcontrolremoveelements(offset)
  local str = core:GetVString(offset, this.indexMap.switchControlRemoveElements).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  desc = this._getDesc,
  unitId = this._getUnitid,
  attackSkill = this._getAttackskill,
  skillList = this._getSkilllist,
  passiveSkillList = this._getPassiveskilllist,
  backupSkillList = this._getBackupskilllist,
  skillBytesPath = this._getSkillbytespath,
  changeSkillList = this._getChangeskilllist,
  enemyType = this._getEnemytype,
  element = this._getElement,
  hpBarType = this._getHpbartype,
  hpIndex = this._getHpindex,
  hpBarWeakness = this._getHpbarweakness,
  breakPoint = this._getBreakpoint,
  kinsAtkPoint = this._getKinsatkpoint,
  kinsHitTime = this._getKinshittime,
  diminishingReturns = this._getDiminishingreturns,
  knisAttackDistance = this._getKnisattackdistance,
  hpBarName = this._getHpbarname,
  bossItemNum = this._getBossitemnum,
  propertyId = this._getPropertyid,
  isUsable = this._getIsusable,
  avatarTexture = this._getAvatartexture,
  collisionType = this._getCollisiontype,
  worldCollisionType = this._getWorldcollisiontype,
  petId = this._getPetid,
  catchCameraParam = this._getCatchcameraparam,
  worldPropertyId = this._getWorldpropertyid,
  moveType = this._getMovetype,
  defaultMoveType = this._getDefaultmovetype,
  gameplayTag = this._getGameplaytag,
  weaponOverride = this._getWeaponoverride,
  weaponDefault = this._getWeapondefault,
  AlertExpression = this._getAlertexpression,
  catchHp = this._getCatchhp,
  switchControlRemoveElements = this._getSwitchcontrolremoveelements
}
return this
