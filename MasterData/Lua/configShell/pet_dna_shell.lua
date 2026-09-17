local this = class("pet_dna_shell", G_BaseConfig)
local core = G_Tables.TDPetDnaTable.GetInstance()

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
  isRarity = 3,
  gradeScore = 4,
  iconCondition = 5,
  iconEffect = 6,
  evoDnaId = 7,
  type = 8,
  talentDnaType = 9,
  nestCoopTag = 10,
  dnaElement = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet_dna", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getIsrarity(offset)
  return core:GetBool(offset, this.indexMap.isRarity)
end

function this:_getGradescore(offset)
  return core:GetInt(offset, this.indexMap.gradeScore)
end

function this:_getIconcondition(offset)
  local str = core:GetVString(offset, this.indexMap.iconCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIconeffect(offset)
  local str = core:GetVString(offset, this.indexMap.iconEffect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getEvodnaid(offset)
  return core:GetInt(offset, this.indexMap.evoDnaId)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getTalentdnatype(offset)
  return core:GetInt(offset, this.indexMap.talentDnaType)
end

function this:_getNestcooptag(offset)
  return core:GetInt(offset, this.indexMap.nestCoopTag)
end

function this:_getDnaelement(offset)
  return core:GetInt(offset, this.indexMap.dnaElement)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  rarity = this._getRarity,
  isRarity = this._getIsrarity,
  gradeScore = this._getGradescore,
  iconCondition = this._getIconcondition,
  iconEffect = this._getIconeffect,
  evoDnaId = this._getEvodnaid,
  type = this._getType,
  talentDnaType = this._getTalentdnatype,
  nestCoopTag = this._getNestcooptag,
  dnaElement = this._getDnaelement
}
return this
