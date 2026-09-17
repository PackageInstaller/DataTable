local this = class("game_events_cul_effect_shell", G_BaseConfig)
local core = G_Tables.TDGameEventsCulEffectTable.GetInstance()

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
  Id = 0,
  type = 1,
  param = 2
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  Id = this._getId,
  type = this._getType,
  param = this._getParam
}
return this
