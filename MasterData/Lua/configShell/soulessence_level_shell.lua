local this = class("soulessence_level_shell", G_BaseConfig)
local core = G_Tables.TDSoulessenceLevelTable.GetInstance()

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
  lv = 1,
  rarity = 2,
  exp = 3,
  exp_all = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.Id)
end

function this:_getLv(offset)
  return core:GetInt(offset, this.indexMap.lv)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getExp(offset)
  return core:GetInt(offset, this.indexMap.exp)
end

function this:_getExp_all(offset)
  return core:GetInt(offset, this.indexMap.exp_all)
end

this.keyToMethodsMap = {
  Id = this._getId,
  lv = this._getLv,
  rarity = this._getRarity,
  exp = this._getExp,
  exp_all = this._getExp_all
}
return this
