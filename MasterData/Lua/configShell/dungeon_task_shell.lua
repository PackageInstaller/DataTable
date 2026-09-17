local this = class("dungeon_task_shell", G_BaseConfig)
local core = G_Tables.TDDungeonTaskTable.GetInstance()

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
  dungeonId = 0,
  taskIds = 1,
  taskTeleportIds = 2,
  autoExit = 3
}

function this:_getDungeonid(offset)
  return core:GetInt(offset, this.indexMap.dungeonId)
end

function this:_getTaskids(offset)
  local str = core:GetVString(offset, this.indexMap.taskIds).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTaskteleportids(offset)
  local str = core:GetVString(offset, this.indexMap.taskTeleportIds).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getAutoexit(offset)
  return core:GetInt(offset, this.indexMap.autoExit)
end

this.keyToMethodsMap = {
  dungeonId = this._getDungeonid,
  taskIds = this._getTaskids,
  taskTeleportIds = this._getTaskteleportids,
  autoExit = this._getAutoexit
}
return this
