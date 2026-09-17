local this = class("world_cicd_whitelist_shell", G_BaseConfig)
local core = G_Tables.TDWorldCICDWhitelistTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, desc = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDesc(offset)
  return core:GetVString(offset, this.indexMap.desc).value
end

this.keyToMethodsMap = {
  id = this._getId,
  desc = this._getDesc
}
return this
