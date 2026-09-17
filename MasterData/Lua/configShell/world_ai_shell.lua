local this = class("world_ai_shell", G_BaseConfig)
local core = G_Tables.TDWorldAiTable.GetInstance()

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
  battleTreeId = 2,
  changeBattleTreeId = 3,
  subTrees = 4,
  paramFloat = 5,
  paramStr = 6,
  paramInt = 7,
  paramBool = 8,
  paramEnum = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPath(offset)
  local str = core:GetVString(offset, this.indexMap.path).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBattletreeid(offset)
  return core:GetInt(offset, this.indexMap.battleTreeId)
end

function this:_getChangebattletreeid(offset)
  return core:GetInt(offset, this.indexMap.changeBattleTreeId)
end

function this:_getSubtrees(offset)
  local str = core:GetVString(offset, this.indexMap.subTrees).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getParamfloat(offset)
  local str = core:GetVString(offset, this.indexMap.paramFloat).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

function this:_getParamstr(offset)
  local str = core:GetVString(offset, this.indexMap.paramStr).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "string")
end

function this:_getParamint(offset)
  local str = core:GetVString(offset, this.indexMap.paramInt).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

function this:_getParambool(offset)
  local str = core:GetVString(offset, this.indexMap.paramBool).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string")
end

function this:_getParamenum(offset)
  return core:GetVString(offset, this.indexMap.paramEnum).value
end

this.keyToMethodsMap = {
  id = this._getId,
  path = this._getPath,
  battleTreeId = this._getBattletreeid,
  changeBattleTreeId = this._getChangebattletreeid,
  subTrees = this._getSubtrees,
  paramFloat = this._getParamfloat,
  paramStr = this._getParamstr,
  paramInt = this._getParamint,
  paramBool = this._getParambool,
  paramEnum = this._getParamenum
}
return this
