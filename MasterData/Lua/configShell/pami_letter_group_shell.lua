local this = class("pami_letter_group_shell", G_BaseConfig)
local core = G_Tables.TDPamiLetterGroupTable.GetInstance()

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
  categoryId = 1,
  heroId = 2,
  name = 3,
  icon = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCategoryid(offset)
  return core:GetInt(offset, this.indexMap.categoryId)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("pami_letter_group", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  categoryId = this._getCategoryid,
  heroId = this._getHeroid,
  name = this._getName,
  icon = this._getIcon
}
return this
