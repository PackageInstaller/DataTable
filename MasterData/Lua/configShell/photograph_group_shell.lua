local this = class("photograph_group_shell", G_BaseConfig)
local core = G_Tables.TDPhotographGroupTable.GetInstance()

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
  show = 2,
  type = 3,
  tabIcon = 4,
  order = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("photograph_group", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getTabicon(offset)
  local str = core:GetVString(offset, this.indexMap.tabIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  show = this._getShow,
  type = this._getType,
  tabIcon = this._getTabicon,
  order = this._getOrder
}
return this
