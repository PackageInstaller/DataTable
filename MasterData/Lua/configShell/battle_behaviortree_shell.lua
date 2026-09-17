local this = class("battle_behaviortree_shell", G_BaseConfig)
local core = G_Tables.TDBattleBehaviortreeTable.GetInstance()

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
  kiboBehaviorTree = 1,
  behaviorTree = 2,
  kiboArenaBehaviorTree = 3,
  subTrees = 4,
  paramFloat = 5,
  paramStr = 6,
  paramInt = 7,
  paramBool = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getKibobehaviortree(offset)
  local str = core:GetVString(offset, this.indexMap.kiboBehaviorTree).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBehaviortree(offset)
  local str = core:GetVString(offset, this.indexMap.behaviorTree).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getKiboarenabehaviortree(offset)
  local str = core:GetVString(offset, this.indexMap.kiboArenaBehaviorTree).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
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
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "bool")
end

this.keyToMethodsMap = {
  id = this._getId,
  kiboBehaviorTree = this._getKibobehaviortree,
  behaviorTree = this._getBehaviortree,
  kiboArenaBehaviorTree = this._getKiboarenabehaviortree,
  subTrees = this._getSubtrees,
  paramFloat = this._getParamfloat,
  paramStr = this._getParamstr,
  paramInt = this._getParamint,
  paramBool = this._getParambool
}
return this
