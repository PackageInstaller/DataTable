local this = class("pet_interim_shell", G_BaseConfig)
local core = G_Tables.TDPetInterimTable.GetInstance()

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
  petId = 1,
  name = 2,
  petLevel = 3,
  signatureSkillList = 4,
  skillList = 5,
  fPropertyskillList = 6,
  breakskillList = 7,
  fixedSkillList = 8,
  dnaList = 9,
  petGrade = 10,
  param = 11,
  homeTalent = 12,
  feature = 13,
  speed = 14
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPetid(offset)
  return core:GetInt(offset, this.indexMap.petId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_interim", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getPetlevel(offset)
  return core:GetInt(offset, this.indexMap.petLevel)
end

function this:_getSignatureskilllist(offset)
  return core:GetInt(offset, this.indexMap.signatureSkillList)
end

function this:_getSkilllist(offset)
  local str = core:GetVString(offset, this.indexMap.skillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getFpropertyskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.fPropertyskillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getBreakskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.breakskillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getFixedskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.fixedSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDnalist(offset)
  local str = core:GetVString(offset, this.indexMap.dnaList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetgrade(offset)
  return core:GetInt(offset, this.indexMap.petGrade)
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getHometalent(offset)
  local str = core:GetVString(offset, this.indexMap.homeTalent).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getFeature(offset)
  return core:GetInt(offset, this.indexMap.feature)
end

function this:_getSpeed(offset)
  return core:GetInt(offset, this.indexMap.speed)
end

this.keyToMethodsMap = {
  id = this._getId,
  petId = this._getPetid,
  name = this._getName,
  petLevel = this._getPetlevel,
  signatureSkillList = this._getSignatureskilllist,
  skillList = this._getSkilllist,
  fPropertyskillList = this._getFpropertyskilllist,
  breakskillList = this._getBreakskilllist,
  fixedSkillList = this._getFixedskilllist,
  dnaList = this._getDnalist,
  petGrade = this._getPetgrade,
  param = this._getParam,
  homeTalent = this._getHometalent,
  feature = this._getFeature,
  speed = this._getSpeed
}
return this
