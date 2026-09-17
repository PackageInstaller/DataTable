local this = class("dungeon_entrust_tag_shell", G_BaseConfig)
local core = G_Tables.TDDungeonEntrustTagTable.GetInstance()

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
  color = 2,
  textColor = 3,
  icon = 4,
  ifFilter = 5,
  sort = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_entrust_tag", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getColor(offset)
  return core:GetVString(offset, this.indexMap.color).value
end

function this:_getTextcolor(offset)
  return core:GetVString(offset, this.indexMap.textColor).value
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIffilter(offset)
  return core:GetInt(offset, this.indexMap.ifFilter)
end

function this:_getSort(offset)
  return core:GetInt(offset, this.indexMap.sort)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  color = this._getColor,
  textColor = this._getTextcolor,
  icon = this._getIcon,
  ifFilter = this._getIffilter,
  sort = this._getSort
}
return this
