local this = class("egg_pooltype_shell", G_BaseConfig)
local core = G_Tables.TDEggPooltypeTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, poolTypeProb = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPooltypeprob(offset)
  local str = core:GetVString(offset, this.indexMap.poolTypeProb).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  poolTypeProb = this._getPooltypeprob
}
return this
