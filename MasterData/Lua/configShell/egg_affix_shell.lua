local this = class("egg_affix_shell", G_BaseConfig)
local core = G_Tables.TDEggAffixTable.GetInstance()

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
  affixtype = 2,
  affixname = 3,
  affixtxt = 4,
  type = 5,
  effectvalue1 = 6,
  effectvalue2 = 7,
  mutexgroup = 8,
  affixicon = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("egg_affix", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getAffixtype(offset)
  return core:GetInt(offset, this.indexMap.affixtype)
end

function this:_getAffixname(offset)
  local langStr = G_TableMgrIns:GetLangStr("egg_affix", core:GetVString(offset, this.indexMap.affixname))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "affixname")
end

function this:_getAffixtxt(offset)
  local langStr = G_TableMgrIns:GetLangStr("egg_affix", core:GetVString(offset, this.indexMap.affixtxt))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "affixtxt")
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getEffectvalue1(offset)
  return core:GetInt(offset, this.indexMap.effectvalue1)
end

function this:_getEffectvalue2(offset)
  local str = core:GetVString(offset, this.indexMap.effectvalue2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getMutexgroup(offset)
  return core:GetInt(offset, this.indexMap.mutexgroup)
end

function this:_getAffixicon(offset)
  local str = core:GetVString(offset, this.indexMap.affixicon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  affixtype = this._getAffixtype,
  affixname = this._getAffixname,
  affixtxt = this._getAffixtxt,
  type = this._getType,
  effectvalue1 = this._getEffectvalue1,
  effectvalue2 = this._getEffectvalue2,
  mutexgroup = this._getMutexgroup,
  affixicon = this._getAffixicon
}
return this
