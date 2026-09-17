local this = class("hero_test_shell", G_BaseConfig)
local core = G_Tables.TDHeroTestTable.GetInstance()

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
  rarity = 2,
  groups = 3,
  cost = 4,
  position = 5,
  unitId = 6,
  attackSkill = 7,
  levelUpType = 8,
  skillList = 9,
  passiveSkillList = 10,
  backupSkillList = 11,
  skillBytesPath = 12,
  weaponType = 13,
  weaponDefault = 14,
  skillSystem = 15,
  dec = 16,
  propertyId = 17
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_test", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getGroups(offset)
  return core:GetInt(offset, this.indexMap.groups)
end

function this:_getCost(offset)
  return core:GetInt(offset, this.indexMap.cost)
end

function this:_getPosition(offset)
  return core:GetInt(offset, this.indexMap.position)
end

function this:_getUnitid(offset)
  return core:GetInt(offset, this.indexMap.unitId)
end

function this:_getAttackskill(offset)
  return core:GetInt(offset, this.indexMap.attackSkill)
end

function this:_getLeveluptype(offset)
  return core:GetInt(offset, this.indexMap.levelUpType)
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
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getWeapontype(offset)
  return core:GetInt(offset, this.indexMap.weaponType)
end

function this:_getWeapondefault(offset)
  return core:GetInt(offset, this.indexMap.weaponDefault)
end

function this:_getSkillsystem(offset)
  local str = core:GetVString(offset, this.indexMap.skillSystem).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDec(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_test", core:GetVString(offset, this.indexMap.dec))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "dec")
end

function this:_getPropertyid(offset)
  return core:GetInt(offset, this.indexMap.propertyId)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  rarity = this._getRarity,
  groups = this._getGroups,
  cost = this._getCost,
  position = this._getPosition,
  unitId = this._getUnitid,
  attackSkill = this._getAttackskill,
  levelUpType = this._getLeveluptype,
  skillList = this._getSkilllist,
  passiveSkillList = this._getPassiveskilllist,
  backupSkillList = this._getBackupskilllist,
  skillBytesPath = this._getSkillbytespath,
  weaponType = this._getWeapontype,
  weaponDefault = this._getWeapondefault,
  skillSystem = this._getSkillsystem,
  dec = this._getDec,
  propertyId = this._getPropertyid
}
return this
