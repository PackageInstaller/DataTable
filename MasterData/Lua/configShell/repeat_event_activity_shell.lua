local this = class("repeat_event_activity_shell", G_BaseConfig)
local core = G_Tables.TDRepeatEventActivityTable.GetInstance()

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
  gameEventsId = 0,
  chapterGroup = 1,
  taskGroup = 2
}

function this:_getGameeventsid(offset)
  return core:GetInt(offset, this.indexMap.gameEventsId)
end

function this:_getChaptergroup(offset)
  return core:GetInt(offset, this.indexMap.chapterGroup)
end

function this:_getTaskgroup(offset)
  return core:GetInt(offset, this.indexMap.taskGroup)
end

this.keyToMethodsMap = {
  gameEventsId = this._getGameeventsid,
  chapterGroup = this._getChaptergroup,
  taskGroup = this._getTaskgroup
}
return this
