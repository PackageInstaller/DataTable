local this = class("home_buff_shell", G_BaseConfig)
local core = G_Tables.TDHomeBuffTable.GetInstance()

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
  type = 1,
  algorithmType = 2,
  isTechnologyBuff = 3,
  isPetBuff = 4,
  isWorldBuff = 5,
  isIconographyBuff = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getAlgorithmtype(offset)
  return core:GetInt(offset, this.indexMap.algorithmType)
end

function this:_getIstechnologybuff(offset)
  return core:GetInt(offset, this.indexMap.isTechnologyBuff)
end

function this:_getIspetbuff(offset)
  return core:GetInt(offset, this.indexMap.isPetBuff)
end

function this:_getIsworldbuff(offset)
  return core:GetInt(offset, this.indexMap.isWorldBuff)
end

function this:_getIsiconographybuff(offset)
  return core:GetInt(offset, this.indexMap.isIconographyBuff)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  algorithmType = this._getAlgorithmtype,
  isTechnologyBuff = this._getIstechnologybuff,
  isPetBuff = this._getIspetbuff,
  isWorldBuff = this._getIsworldbuff,
  isIconographyBuff = this._getIsiconographybuff
}
return this
