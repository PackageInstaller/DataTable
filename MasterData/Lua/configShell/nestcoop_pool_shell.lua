local this = class("nestcoop_pool_shell", G_BaseConfig)
local core = G_Tables.TDNestcoopPoolTable.GetInstance()

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
  poolID = 1,
  enemyID = 2,
  starTier = 3,
  inPool = 4,
  weight = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getPoolid(offset)
  return core:GetInt(offset, this.indexMap.poolID)
end

function this:_getEnemyid(offset)
  return core:GetInt(offset, this.indexMap.enemyID)
end

function this:_getStartier(offset)
  return core:GetInt(offset, this.indexMap.starTier)
end

function this:_getInpool(offset)
  return core:GetInt(offset, this.indexMap.inPool)
end

function this:_getWeight(offset)
  return core:GetInt(offset, this.indexMap.weight)
end

this.keyToMethodsMap = {
  id = this._getId,
  poolID = this._getPoolid,
  enemyID = this._getEnemyid,
  starTier = this._getStartier,
  inPool = this._getInpool,
  weight = this._getWeight
}
return this
