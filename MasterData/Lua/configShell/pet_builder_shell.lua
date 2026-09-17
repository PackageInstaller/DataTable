local this = class("pet_builder_shell", G_BaseConfig)
local core = G_Tables.TDPetBuilderTable.GetInstance()

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
  ID = 0,
  talentdnaQuality = 1,
  geneNum = 2,
  geneQuality = 3,
  geneRare = 4,
  talent = 5,
  statusProb = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.ID)
end

function this:_getTalentdnaquality(offset)
  local str = core:GetVString(offset, this.indexMap.talentdnaQuality).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getGenenum(offset)
  local str = core:GetVString(offset, this.indexMap.geneNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getGenequality(offset)
  local str = core:GetVString(offset, this.indexMap.geneQuality).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getGenerare(offset)
  local str = core:GetVString(offset, this.indexMap.geneRare).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getTalent(offset)
  local str = core:GetVString(offset, this.indexMap.talent).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getStatusprob(offset)
  local str = core:GetVString(offset, this.indexMap.statusProb).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  ID = this._getId,
  talentdnaQuality = this._getTalentdnaquality,
  geneNum = this._getGenenum,
  geneQuality = this._getGenequality,
  geneRare = this._getGenerare,
  talent = this._getTalent,
  statusProb = this._getStatusprob
}
return this
