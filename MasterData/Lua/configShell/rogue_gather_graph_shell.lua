local this = class("rogue_gather_graph_shell", G_BaseConfig)
local core = G_Tables.TDRogueGatherGraphTable.GetInstance()

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
  graphgather = 1,
  weight = 2,
  graphid = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGraphgather(offset)
  return core:GetInt(offset, this.indexMap.graphgather)
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

function this:_getGraphid(offset)
  return core:GetInt(offset, this.indexMap.graphid)
end

this.keyToMethodsMap = {
  id = this._getId,
  graphgather = this._getGraphgather,
  weight = this._getWeight,
  graphid = this._getGraphid
}
return this
