local this = class("dungeon_input_limit_set_shell", G_BaseConfig)
local core = G_Tables.TDDungeonInputLimitSetTable.GetInstance()

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
  group = 1,
  inputActions = 2,
  noticeWord = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getInputactions(offset)
  return core:GetVString(offset, this.indexMap.inputActions).value
end

function this:_getNoticeword(offset)
  return core:GetVString(offset, this.indexMap.noticeWord).value
end

this.keyToMethodsMap = {
  id = this._getId,
  group = this._getGroup,
  inputActions = this._getInputactions,
  noticeWord = this._getNoticeword
}
return this
