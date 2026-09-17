local this = class("hero_battle_info_shell", G_BaseConfig)
local core = G_Tables.TDHeroBattleInfoTable.GetInstance()

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
  attackSkill = 1,
  skillList = 2,
  aerialSkillList = 3,
  _LimitEvade = 4,
  passiveSkillList = 5,
  homeSkillList = 6,
  backupSkillList = 7,
  skillBytesPath = 8,
  lifeskillDesc = 9,
  weaponType = 10,
  weaponDefault = 11,
  skillSystem = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAttackskill(offset)
  return core:GetInt(offset, this.indexMap.attackSkill)
end

function this:_getSkilllist(offset)
  local str = core:GetVString(offset, this.indexMap.skillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getAerialskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.aerialSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_get_limitevade(offset)
  return core:GetInt(offset, this.indexMap._LimitEvade)
end

function this:_getPassiveskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.passiveSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHomeskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.homeSkillList).value
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

function this:_getLifeskilldesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_battle_info", core:GetVString(offset, this.indexMap.lifeskillDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "lifeskillDesc")
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

this.keyToMethodsMap = {
  id = this._getId,
  attackSkill = this._getAttackskill,
  skillList = this._getSkilllist,
  aerialSkillList = this._getAerialskilllist,
  _LimitEvade = this._get_limitevade,
  passiveSkillList = this._getPassiveskilllist,
  homeSkillList = this._getHomeskilllist,
  backupSkillList = this._getBackupskilllist,
  skillBytesPath = this._getSkillbytespath,
  lifeskillDesc = this._getLifeskilldesc,
  weaponType = this._getWeapontype,
  weaponDefault = this._getWeapondefault,
  skillSystem = this._getSkillsystem
}
return this
