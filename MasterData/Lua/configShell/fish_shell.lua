local this = class("fish_shell", G_BaseConfig)
local core = G_Tables.TDFishTable.GetInstance()

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
  fishName = 1,
  rarity = 2,
  description = 3,
  strength = 4,
  errors = 5,
  shape = 6,
  baitTime = 7,
  bait = 8,
  musicScore = 9,
  fishIllustrationResource = 10,
  lockDescription = 11,
  technologyExp = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFishname(offset)
  local langStr = G_TableMgrIns:GetLangStr("fish", core:GetVString(offset, this.indexMap.fishName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "fishName")
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getDescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("fish", core:GetVString(offset, this.indexMap.description))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "description")
end

function this:_getStrength(offset)
  return core:GetInt(offset, this.indexMap.strength)
end

function this:_getErrors(offset)
  return core:GetInt(offset, this.indexMap.errors)
end

function this:_getShape(offset)
  local str = core:GetVString(offset, this.indexMap.shape).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBaittime(offset)
  local str = core:GetVString(offset, this.indexMap.baitTime).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBait(offset)
  local str = core:GetVString(offset, this.indexMap.bait).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMusicscore(offset)
  local str = core:GetVString(offset, this.indexMap.musicScore).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getFishillustrationresource(offset)
  return core:GetVString(offset, this.indexMap.fishIllustrationResource).value
end

function this:_getLockdescription(offset)
  local langStr = G_TableMgrIns:GetLangStr("fish", core:GetVString(offset, this.indexMap.lockDescription))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "lockDescription")
end

function this:_getTechnologyexp(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  fishName = this._getFishname,
  rarity = this._getRarity,
  description = this._getDescription,
  strength = this._getStrength,
  errors = this._getErrors,
  shape = this._getShape,
  baitTime = this._getBaittime,
  bait = this._getBait,
  musicScore = this._getMusicscore,
  fishIllustrationResource = this._getFishillustrationresource,
  lockDescription = this._getLockdescription,
  technologyExp = this._getTechnologyexp
}
return this
