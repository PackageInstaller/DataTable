local this = class("world_collecting_shell", G_BaseConfig)
local core = G_Tables.TDWorldCollectingTable.GetInstance()

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
  itemType = 2,
  itemId = 3,
  name = 4,
  spawnerId = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getItemtype(offset)
  return core:GetInt(offset, this.indexMap.itemType)
end

function this:_getItemid(offset)
  return core:GetInt(offset, this.indexMap.itemId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("world_collecting", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getSpawnerid(offset)
  local str = core:GetVString(offset, this.indexMap.spawnerId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  itemType = this._getItemtype,
  itemId = this._getItemid,
  name = this._getName,
  spawnerId = this._getSpawnerid
}
return this
