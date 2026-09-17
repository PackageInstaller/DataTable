local this = class("template_petlevel_shell", G_BaseConfig)
local core = G_Tables.TDTemplatePetlevelTable.GetInstance()

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
  SkillLevel = 1,
  baseAttribute = 2,
  extraAttribute = 3,
  baseElement = 4,
  basePetDNAList = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSkilllevel(offset)
  return core:GetInt(offset, this.indexMap.SkillLevel)
end

function this:_getBaseattribute(offset)
  local str = core:GetVString(offset, this.indexMap.baseAttribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getExtraattribute(offset)
  local str = core:GetVString(offset, this.indexMap.extraAttribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getBaseelement(offset)
  local str = core:GetVString(offset, this.indexMap.baseElement).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBasepetdnalist(offset)
  local str = core:GetVString(offset, this.indexMap.basePetDNAList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  SkillLevel = this._getSkilllevel,
  baseAttribute = this._getBaseattribute,
  extraAttribute = this._getExtraattribute,
  baseElement = this._getBaseelement,
  basePetDNAList = this._getBasepetdnalist
}
return this
