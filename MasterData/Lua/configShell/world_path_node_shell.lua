local this = class("world_path_node_shell", G_BaseConfig)
local core = G_Tables.TDWorldPathNodeTable.GetInstance()

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
  sceneId = 1,
  pathNode = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSceneid(offset)
  return core:GetInt(offset, this.indexMap.sceneId)
end

function this:_getPathnode(offset)
  local str = core:GetVString(offset, this.indexMap.pathNode).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  sceneId = this._getSceneid,
  pathNode = this._getPathnode
}
return this
