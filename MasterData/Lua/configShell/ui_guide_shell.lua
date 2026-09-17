local this = class("ui_guide_shell", G_BaseConfig)
local core = G_Tables.TDUiGuideTable.GetInstance()

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
  ui = 2,
  item = 3,
  position = 4,
  sequence = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getUi(offset)
  return core:GetVString(offset, this.indexMap.ui).value
end

function this:_getItem(offset)
  return core:GetVString(offset, this.indexMap.item).value
end

function this:_getPosition(offset)
  return core:GetVString(offset, this.indexMap.position).value
end

function this:_getSequence(offset)
  return core:GetInt(offset, this.indexMap.sequence)
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  ui = this._getUi,
  item = this._getItem,
  position = this._getPosition,
  sequence = this._getSequence
}
return this
