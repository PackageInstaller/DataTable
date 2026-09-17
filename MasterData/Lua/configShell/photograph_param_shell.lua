local this = class("photograph_param_shell", G_BaseConfig)
local core = G_Tables.TDPhotographParamTable.GetInstance()

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
  groupId = 1,
  sequence = 2,
  name = 3,
  systemUnlock = 4,
  paramType = 5,
  show = 6,
  param = 7,
  paramMin = 8,
  paramMax = 9,
  icon = 10,
  type = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getSequence(offset)
  return core:GetInt(offset, this.indexMap.sequence)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("photograph_param", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getSystemunlock(offset)
  local str = core:GetVString(offset, this.indexMap.systemUnlock).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getParamtype(offset)
  return core:GetInt(offset, this.indexMap.paramType)
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

function this:_getParam(offset)
  return core:GetVString(offset, this.indexMap.param).value
end

function this:_getParammin(offset)
  return core:GetInt(offset, this.indexMap.paramMin)
end

function this:_getParammax(offset)
  return core:GetInt(offset, this.indexMap.paramMax)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  sequence = this._getSequence,
  name = this._getName,
  systemUnlock = this._getSystemunlock,
  paramType = this._getParamtype,
  show = this._getShow,
  param = this._getParam,
  paramMin = this._getParammin,
  paramMax = this._getParammax,
  icon = this._getIcon,
  type = this._getType
}
return this
