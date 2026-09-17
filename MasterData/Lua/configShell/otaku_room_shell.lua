local this = class("otaku_room_shell", G_BaseConfig)
local core = G_Tables.TDOtakuRoomTable.GetInstance()

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
  roomId = 0,
  name = 1,
  isDefaultUnlock = 2,
  unlockCondition = 3,
  cost = 4
}

function this:_getRoomid(offset)
  return core:GetInt(offset, this.indexMap.roomId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("otaku_room", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIsdefaultunlock(offset)
  return core:GetBool(offset, this.indexMap.isDefaultUnlock)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getCost(offset)
  local str = core:GetVString(offset, this.indexMap.cost).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  roomId = this._getRoomid,
  name = this._getName,
  isDefaultUnlock = this._getIsdefaultunlock,
  unlockCondition = this._getUnlockcondition,
  cost = this._getCost
}
return this
