local this = class("preload_state_custom_shell", G_BaseConfig)
local core = G_Tables.TDPreloadStateCustomTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, animStates = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getAnimstates(offset)
  local str = core:GetVString(offset, this.indexMap.animStates).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

this.keyToMethodsMap = {
  id = this._getId,
  animStates = this._getAnimstates
}
return this
