local this = class("home_labor_train_shell", G_BaseConfig)
local core = G_Tables.TDHomeLaborTrainTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, exp = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getExp(offset)
  return core:GetInt(offset, this.indexMap.exp)
end

this.keyToMethodsMap = {
  id = this._getId,
  exp = this._getExp
}
return this
