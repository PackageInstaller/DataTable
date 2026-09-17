local this = class("dungeon_entrust_type_shell", G_BaseConfig)
local core = G_Tables.TDDungeonEntrustTypeTable.GetInstance()

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
  name = 1,
  taskId = 2,
  ifShow = 3,
  ifShowStarReward = 4,
  iftimelimit = 5,
  systemUnLockId = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("dungeon_entrust_type", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getTaskid(offset)
  return core:GetInt(offset, this.indexMap.taskId)
end

function this:_getIfshow(offset)
  return core:GetInt(offset, this.indexMap.ifShow)
end

function this:_getIfshowstarreward(offset)
  return core:GetInt(offset, this.indexMap.ifShowStarReward)
end

function this:_getIftimelimit(offset)
  return core:GetInt(offset, this.indexMap.iftimelimit)
end

function this:_getSystemunlockid(offset)
  return core:GetInt(offset, this.indexMap.systemUnLockId)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  taskId = this._getTaskid,
  ifShow = this._getIfshow,
  ifShowStarReward = this._getIfshowstarreward,
  iftimelimit = this._getIftimelimit,
  systemUnLockId = this._getSystemunlockid
}
return this
