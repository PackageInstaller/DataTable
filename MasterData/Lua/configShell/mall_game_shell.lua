local this = class("mall_game_shell", G_BaseConfig)
local core = G_Tables.TDMallGameTable.GetInstance()

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
  title = 0,
  type = 1,
  value = 2
}

function this:_getTitle(offset)
  return core:GetVString(offset, this.indexMap.title).value
end

function this:_getType(offset)
  return core:GetVString(offset, this.indexMap.type).value
end

function this:_getValue(offset)
  return core:GetVString(offset, this.indexMap.value).value
end

this.keyToMethodsMap = {
  title = this._getTitle,
  type = this._getType,
  value = this._getValue
}
return this
