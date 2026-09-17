local this = class("world_reborn_pos_shell", G_BaseConfig)
local core = G_Tables.TDWorldRebornPosTable.GetInstance()

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
  groupId = 1,
  sceneId = 2,
  position = 3,
  rotation = 4,
  actionList = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getSceneid(offset)
  return core:GetInt(offset, this.indexMap.sceneId)
end

function this:_getPosition(offset)
  local str = core:GetVString(offset, this.indexMap.position).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRotation(offset)
  local str = core:GetVString(offset, this.indexMap.rotation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getActionlist(offset)
  local str = core:GetVString(offset, this.indexMap.actionList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  sceneId = this._getSceneid,
  position = this._getPosition,
  rotation = this._getRotation,
  actionList = this._getActionlist
}
return this
