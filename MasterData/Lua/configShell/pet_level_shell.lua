local this = class("pet_level_shell", G_BaseConfig)
local core = G_Tables.TDPetLevelTable.GetInstance()

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
  lv = 0,
  exp = 1,
  condition = 2
}

function this:_getLv(offset)
  return core:GetInt(offset, this.indexMap.lv)
end

function this:_getExp(offset)
  return core:GetInt(offset, this.indexMap.exp)
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  lv = this._getLv,
  exp = this._getExp,
  condition = this._getCondition
}
return this
