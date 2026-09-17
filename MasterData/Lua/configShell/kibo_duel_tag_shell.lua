local this = class("kibo_duel_tag_shell", G_BaseConfig)
local core = G_Tables.TDKiboDuelTagTable.GetInstance()

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
  attrID = 1,
  tagName = 2,
  tagDesc = 3,
  tagIcon = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAttrid(offset)
  return core:GetVString(offset, this.indexMap.attrID).value
end

function this:_getTagname(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_tag", core:GetVString(offset, this.indexMap.tagName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "tagName")
end

function this:_getTagdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("kibo_duel_tag", core:GetVString(offset, this.indexMap.tagDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "tagDesc")
end

function this:_getTagicon(offset)
  local str = core:GetVString(offset, this.indexMap.tagIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  attrID = this._getAttrid,
  tagName = this._getTagname,
  tagDesc = this._getTagdesc,
  tagIcon = this._getTagicon
}
return this
