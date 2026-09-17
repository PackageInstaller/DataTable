local this = class("home_exchange_tag_shell", G_BaseConfig)
local core = G_Tables.TDHomeExchangeTagTable.GetInstance()

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
  TagID = 0,
  TagName = 1,
  TagDesc = 2,
  TagIcon = 3
}

function this:_getTagid(offset)
  return core:GetInt(offset, this.indexMap.TagID)
end

function this:_getTagname(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_exchange_tag", core:GetVString(offset, this.indexMap.TagName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "TagName")
end

function this:_getTagdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_exchange_tag", core:GetVString(offset, this.indexMap.TagDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "TagDesc")
end

function this:_getTagicon(offset)
  local str = core:GetVString(offset, this.indexMap.TagIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  TagID = this._getTagid,
  TagName = this._getTagname,
  TagDesc = this._getTagdesc,
  TagIcon = this._getTagicon
}
return this
