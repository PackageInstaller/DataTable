local this = class("details_shell", G_BaseConfig)
local core = G_Tables.TDDetailsTable.GetInstance()

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
  page = 1,
  tab = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPage(offset)
  return core:GetInt(offset, this.indexMap.page)
end

function this:_getTab(offset)
  local str = core:GetVString(offset, this.indexMap.tab).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  page = this._getPage,
  tab = this._getTab
}
return this
