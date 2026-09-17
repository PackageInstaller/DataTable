local this = class("guide_shell", G_BaseConfig)
local core = G_Tables.TDGuideTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, groupId = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid
}
return this
