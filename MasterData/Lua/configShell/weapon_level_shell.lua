local this = class("weapon_level_shell", G_BaseConfig)
local core = G_Tables.TDWeaponLevelTable.GetInstance()

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
  exp_all = 2
}

function this:_getLv(offset)
  return core:GetInt(offset, this.indexMap.lv)
end

function this:_getExp(offset)
  return core:GetInt(offset, this.indexMap.exp)
end

function this:_getExp_all(offset)
  return core:GetInt(offset, this.indexMap.exp_all)
end

this.keyToMethodsMap = {
  lv = this._getLv,
  exp = this._getExp,
  exp_all = this._getExp_all
}
return this
