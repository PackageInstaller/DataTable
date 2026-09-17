local this = class("playercard_dress_list_shell", G_BaseConfig)
local core = G_Tables.TDPlayercardDressListTable.GetInstance()

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
  team = 1,
  name = 2,
  show = 3,
  order = 4,
  condition = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTeam(offset)
  return core:GetInt(offset, this.indexMap.team)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("playercard_dress_list", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

this.keyToMethodsMap = {
  id = this._getId,
  team = this._getTeam,
  name = this._getName,
  show = this._getShow,
  order = this._getOrder,
  condition = this._getCondition
}
return this
