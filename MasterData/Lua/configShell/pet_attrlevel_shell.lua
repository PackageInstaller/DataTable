local this = class("pet_attrlevel_shell", G_BaseConfig)
local core = G_Tables.TDPetAttrlevelTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {lv = 0, exp = 1}

function this:_getLv(offset)
  return core:GetInt(offset, this.indexMap.lv)
end

function this:_getExp(offset)
  return core:GetInt(offset, this.indexMap.exp)
end

this.keyToMethodsMap = {
  lv = this._getLv,
  exp = this._getExp
}
return this
