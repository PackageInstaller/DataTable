local this = class("serverlist_shell", G_BaseConfig)
local core = G_Tables.TDServerlistTable.GetInstance()

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
  IP = 1,
  Port = 2,
  Desc = 3
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getIp(offset)
  return core:GetVString(offset, this.indexMap.IP).value
end

function this:_getPort(offset)
  return core:GetInt(offset, this.indexMap.Port)
end

function this:_getDesc(offset)
  return core:GetVString(offset, this.indexMap.Desc).value
end

this.keyToMethodsMap = {
  id = this._getId,
  IP = this._getIp,
  Port = this._getPort,
  Desc = this._getDesc
}
return this
