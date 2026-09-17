local this = class("pet_customized_shell", G_BaseConfig)
local core = G_Tables.TDPetCustomizedTable.GetInstance()

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
  level = 1,
  petId = 2,
  builderRule = 3,
  petAttr = 4,
  isRelease = 5,
  starColorParam = 6,
  colorParam = 7,
  lightParam = 8,
  skillCountType = 9,
  skillCount = 10,
  talentDnaType = 11,
  talentDna = 12,
  dnaType = 13,
  dna = 14,
  skillType = 15,
  breakSkillList = 16,
  signatureSkillList = 17,
  skillList = 18,
  laborScoreType = 19,
  laborScore = 20,
  mountType = 21,
  mountSpeed = 22
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getPetid(offset)
  return core:GetInt(offset, this.indexMap.petId)
end

function this:_getBuilderrule(offset)
  return core:GetInt(offset, this.indexMap.builderRule)
end

function this:_getPetattr(offset)
  local str = core:GetVString(offset, this.indexMap.petAttr).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getIsrelease(offset)
  return core:GetBool(offset, this.indexMap.isRelease)
end

function this:_getStarcolorparam(offset)
  local str = core:GetVString(offset, this.indexMap.starColorParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getColorparam(offset)
  local str = core:GetVString(offset, this.indexMap.colorParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getLightparam(offset)
  return core:GetInt(offset, this.indexMap.lightParam)
end

function this:_getSkillcounttype(offset)
  return core:GetInt(offset, this.indexMap.skillCountType)
end

function this:_getSkillcount(offset)
  local str = core:GetVString(offset, this.indexMap.skillCount).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getTalentdnatype(offset)
  return core:GetInt(offset, this.indexMap.talentDnaType)
end

function this:_getTalentdna(offset)
  return core:GetInt(offset, this.indexMap.talentDna)
end

function this:_getDnatype(offset)
  return core:GetInt(offset, this.indexMap.dnaType)
end

function this:_getDna(offset)
  local str = core:GetVString(offset, this.indexMap.dna).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSkilltype(offset)
  return core:GetInt(offset, this.indexMap.skillType)
end

function this:_getBreakskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.breakSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getSignatureskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.signatureSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSkilllist(offset)
  local str = core:GetVString(offset, this.indexMap.skillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getLaborscoretype(offset)
  return core:GetInt(offset, this.indexMap.laborScoreType)
end

function this:_getLaborscore(offset)
  local str = core:GetVString(offset, this.indexMap.laborScore).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMounttype(offset)
  return core:GetInt(offset, this.indexMap.mountType)
end

function this:_getMountspeed(offset)
  return core:GetInt(offset, this.indexMap.mountSpeed)
end

this.keyToMethodsMap = {
  id = this._getId,
  level = this._getLevel,
  petId = this._getPetid,
  builderRule = this._getBuilderrule,
  petAttr = this._getPetattr,
  isRelease = this._getIsrelease,
  starColorParam = this._getStarcolorparam,
  colorParam = this._getColorparam,
  lightParam = this._getLightparam,
  skillCountType = this._getSkillcounttype,
  skillCount = this._getSkillcount,
  talentDnaType = this._getTalentdnatype,
  talentDna = this._getTalentdna,
  dnaType = this._getDnatype,
  dna = this._getDna,
  skillType = this._getSkilltype,
  breakSkillList = this._getBreakskilllist,
  signatureSkillList = this._getSignatureskilllist,
  skillList = this._getSkilllist,
  laborScoreType = this._getLaborscoretype,
  laborScore = this._getLaborscore,
  mountType = this._getMounttype,
  mountSpeed = this._getMountspeed
}
return this
