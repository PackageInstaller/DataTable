local this = class("event_staminachestup_shell", G_BaseConfig)
local core = G_Tables.TDEventStaminachestupTable.GetInstance()

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
  dungeonID = 2,
  dropUp = 3,
  rewardDisplayUp = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getDungeonid(offset)
  return core:GetInt(offset, this.indexMap.dungeonID)
end

function this:_getDropup(offset)
  return core:GetInt(offset, this.indexMap.dropUp)
end

function this:_getRewarddisplayup(offset)
  local str = core:GetVString(offset, this.indexMap.rewardDisplayUp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  dungeonID = this._getDungeonid,
  dropUp = this._getDropup,
  rewardDisplayUp = this._getRewarddisplayup
}
return this
