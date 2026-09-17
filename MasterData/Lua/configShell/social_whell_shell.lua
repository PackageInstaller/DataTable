local this = class("social_whell_shell", G_BaseConfig)
local core = G_Tables.TDSocialWhellTable.GetInstance()

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
  type = 1,
  name = 2,
  resource = 3,
  lock_type = 4,
  Icon = 5,
  unlock = 6,
  state = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("social_whell", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getResource(offset)
  return core:GetVString(offset, this.indexMap.resource).value
end

function this:_getLock_type(offset)
  return core:GetInt(offset, this.indexMap.lock_type)
end

function this:_getIcon(offset)
  return core:GetVString(offset, this.indexMap.Icon).value
end

function this:_getUnlock(offset)
  local str = core:GetVString(offset, this.indexMap.unlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getState(offset)
  return core:GetInt(offset, this.indexMap.state)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  name = this._getName,
  resource = this._getResource,
  lock_type = this._getLock_type,
  Icon = this._getIcon,
  unlock = this._getUnlock,
  state = this._getState
}
return this
