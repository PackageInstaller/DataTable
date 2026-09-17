local this = class("gacha_game_shell", G_BaseConfig)
local core = G_Tables.TDGachaGameTable.GetInstance()

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
  title = 1,
  type = 2,
  value = 3,
  _miscellaneous = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTitle(offset)
  return core:GetVString(offset, this.indexMap.title).value
end

function this:_getType(offset)
  return core:GetVString(offset, this.indexMap.type).value
end

function this:_getValue(offset)
  return core:GetVString(offset, this.indexMap.value).value
end

function this:_get_miscellaneous(offset)
  return core:GetVString(offset, this.indexMap._miscellaneous).value
end

this.keyToMethodsMap = {
  id = this._getId,
  title = this._getTitle,
  type = this._getType,
  value = this._getValue,
  _miscellaneous = this._get_miscellaneous
}
return this
