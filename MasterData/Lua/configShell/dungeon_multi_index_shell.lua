local this = class("dungeon_multi_index_shell", G_BaseConfig)
local core = G_Tables.TDDungeonMultiIndexTable.GetInstance()

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
  simpleNum = 1,
  doubleNum = 2,
  tripleNum = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getSimplenum(offset)
  local str = core:GetVString(offset, this.indexMap.simpleNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getDoublenum(offset)
  local str = core:GetVString(offset, this.indexMap.doubleNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getTriplenum(offset)
  local str = core:GetVString(offset, this.indexMap.tripleNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  simpleNum = this._getSimplenum,
  doubleNum = this._getDoublenum,
  tripleNum = this._getTriplenum
}
return this
