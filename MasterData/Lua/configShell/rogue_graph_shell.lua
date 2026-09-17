local this = class("rogue_graph_shell", G_BaseConfig)
local core = G_Tables.TDRogueGraphTable.GetInstance()

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
  graphId = 1,
  nodeIndex = 2,
  nodeId = 3,
  preNodeList = 4,
  nextNodeList = 5,
  nodeSort = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGraphid(offset)
  return core:GetInt(offset, this.indexMap.graphId)
end

function this:_getNodeindex(offset)
  return core:GetInt(offset, this.indexMap.nodeIndex)
end

function this:_getNodeid(offset)
  return core:GetInt(offset, this.indexMap.nodeId)
end

function this:_getPrenodelist(offset)
  local str = core:GetVString(offset, this.indexMap.preNodeList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNextnodelist(offset)
  local str = core:GetVString(offset, this.indexMap.nextNodeList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNodesort(offset)
  return core:GetInt(offset, this.indexMap.nodeSort)
end

this.keyToMethodsMap = {
  id = this._getId,
  graphId = this._getGraphid,
  nodeIndex = this._getNodeindex,
  nodeId = this._getNodeid,
  preNodeList = this._getPrenodelist,
  nextNodeList = this._getNextnodelist,
  nodeSort = this._getNodesort
}
return this
