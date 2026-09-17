local this = class("buff_displaycontent_shell", G_BaseConfig)
local core = G_Tables.TDBuffDisplaycontentTable.GetInstance()

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
  buffName = 1,
  buffResourse = 2,
  buffDesc = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getBuffname(offset)
  return core:GetVString(offset, this.indexMap.buffName).value
end

function this:_getBuffresourse(offset)
  return core:GetVString(offset, this.indexMap.buffResourse).value
end

function this:_getBuffdesc(offset)
  return core:GetVString(offset, this.indexMap.buffDesc).value
end

this.keyToMethodsMap = {
  id = this._getId,
  buffName = this._getBuffname,
  buffResourse = this._getBuffresourse,
  buffDesc = this._getBuffdesc
}
return this
