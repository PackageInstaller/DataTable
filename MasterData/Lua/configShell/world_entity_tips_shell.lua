local this = class("world_entity_tips_shell", G_BaseConfig)
local core = G_Tables.TDWorldEntityTipsTable.GetInstance()

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
  resourcePath = 1,
  scanDuration = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getResourcepath(offset)
  local str = core:GetVString(offset, this.indexMap.resourcePath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getScanduration(offset)
  return core:GetFloat(offset, this.indexMap.scanDuration)
end

this.keyToMethodsMap = {
  id = this._getId,
  resourcePath = this._getResourcepath,
  scanDuration = this._getScanduration
}
return this
