local this = class("pet_catch_factor_shell", G_BaseConfig)
local core = G_Tables.TDPetCatchFactorTable.GetInstance()

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
  level = 1,
  enemyHpA = 2,
  enemyHpB = 3,
  enemyHpC = 4,
  enemyHpD = 5,
  enemyHpE = 6,
  enemyHpF = 7,
  enemyHpG = 8,
  enemyHpH = 9,
  enemyHpI = 10,
  enemyHpJ = 11,
  foodParam = 12,
  CardA = 13,
  CardB = 14,
  CardC = 15,
  CardD = 16,
  CardE = 17
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getEnemyhpa(offset)
  return core:GetInt(offset, this.indexMap.enemyHpA)
end

function this:_getEnemyhpb(offset)
  return core:GetInt(offset, this.indexMap.enemyHpB)
end

function this:_getEnemyhpc(offset)
  return core:GetInt(offset, this.indexMap.enemyHpC)
end

function this:_getEnemyhpd(offset)
  return core:GetInt(offset, this.indexMap.enemyHpD)
end

function this:_getEnemyhpe(offset)
  return core:GetInt(offset, this.indexMap.enemyHpE)
end

function this:_getEnemyhpf(offset)
  return core:GetInt(offset, this.indexMap.enemyHpF)
end

function this:_getEnemyhpg(offset)
  return core:GetInt(offset, this.indexMap.enemyHpG)
end

function this:_getEnemyhph(offset)
  return core:GetInt(offset, this.indexMap.enemyHpH)
end

function this:_getEnemyhpi(offset)
  return core:GetInt(offset, this.indexMap.enemyHpI)
end

function this:_getEnemyhpj(offset)
  return core:GetInt(offset, this.indexMap.enemyHpJ)
end

function this:_getFoodparam(offset)
  return core:GetInt(offset, this.indexMap.foodParam)
end

function this:_getCarda(offset)
  return core:GetInt(offset, this.indexMap.CardA)
end

function this:_getCardb(offset)
  return core:GetInt(offset, this.indexMap.CardB)
end

function this:_getCardc(offset)
  return core:GetInt(offset, this.indexMap.CardC)
end

function this:_getCardd(offset)
  return core:GetInt(offset, this.indexMap.CardD)
end

function this:_getCarde(offset)
  return core:GetInt(offset, this.indexMap.CardE)
end

this.keyToMethodsMap = {
  id = this._getId,
  level = this._getLevel,
  enemyHpA = this._getEnemyhpa,
  enemyHpB = this._getEnemyhpb,
  enemyHpC = this._getEnemyhpc,
  enemyHpD = this._getEnemyhpd,
  enemyHpE = this._getEnemyhpe,
  enemyHpF = this._getEnemyhpf,
  enemyHpG = this._getEnemyhpg,
  enemyHpH = this._getEnemyhph,
  enemyHpI = this._getEnemyhpi,
  enemyHpJ = this._getEnemyhpj,
  foodParam = this._getFoodparam,
  CardA = this._getCarda,
  CardB = this._getCardb,
  CardC = this._getCardc,
  CardD = this._getCardd,
  CardE = this._getCarde
}
return this
