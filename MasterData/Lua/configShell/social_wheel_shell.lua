local this = class("social_wheel_shell", G_BaseConfig)
local core = G_Tables.TDSocialWheelTable.GetInstance()

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
  action = 3,
  social_emotion = 4,
  lock_type = 5,
  icon = 6,
  unlock = 7,
  state = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("social_wheel", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getAction(offset)
  return core:GetVString(offset, this.indexMap.action).value
end

function this:_getSocial_emotion(offset)
  local str = core:GetVString(offset, this.indexMap.social_emotion).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getLock_type(offset)
  return core:GetInt(offset, this.indexMap.lock_type)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
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
  action = this._getAction,
  social_emotion = this._getSocial_emotion,
  lock_type = this._getLock_type,
  icon = this._getIcon,
  unlock = this._getUnlock,
  state = this._getState
}
return this
