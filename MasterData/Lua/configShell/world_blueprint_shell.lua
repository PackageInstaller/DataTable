local this = class("world_blueprint_shell", G_BaseConfig)
local core = G_Tables.TDWorldBlueprintTable.GetInstance()

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
  path = 1,
  param = 2,
  stringParam = 3,
  intParam = 4,
  boolParam = 5,
  collisionType = 6,
  paramTemplate = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPath(offset)
  local str = core:GetVString(offset, this.indexMap.path).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

function this:_getStringparam(offset)
  local str = core:GetVString(offset, this.indexMap.stringParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "string")
end

function this:_getIntparam(offset)
  local str = core:GetVString(offset, this.indexMap.intParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

function this:_getBoolparam(offset)
  local str = core:GetVString(offset, this.indexMap.boolParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "bool")
end

function this:_getCollisiontype(offset)
  return core:GetInt(offset, this.indexMap.collisionType)
end

function this:_getParamtemplate(offset)
  return core:GetInt(offset, this.indexMap.paramTemplate)
end

this.keyToMethodsMap = {
  id = this._getId,
  path = this._getPath,
  param = this._getParam,
  stringParam = this._getStringparam,
  intParam = this._getIntparam,
  boolParam = this._getBoolparam,
  collisionType = this._getCollisiontype,
  paramTemplate = this._getParamtemplate
}
return this
