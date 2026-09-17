local this = class("rogue_activity_carplevelweight_shell", G_BaseConfig)
local core = G_Tables.TDRogueActivityCarplevelweightTable.GetInstance()

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
  carplevelgather = 1,
  levelnum = 2,
  commoncarpweight = 3,
  rarecarpweight = 4,
  epiccarpweight = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getCarplevelgather(offset)
  return core:GetInt(offset, this.indexMap.carplevelgather)
end

function this:_getLevelnum(offset)
  return core:GetInt(offset, this.indexMap.levelnum)
end

function this:_getCommoncarpweight(offset)
  return core:GetInt(offset, this.indexMap.commoncarpweight)
end

function this:_getRarecarpweight(offset)
  return core:GetInt(offset, this.indexMap.rarecarpweight)
end

function this:_getEpiccarpweight(offset)
  return core:GetInt(offset, this.indexMap.epiccarpweight)
end

this.keyToMethodsMap = {
  id = this._getId,
  carplevelgather = this._getCarplevelgather,
  levelnum = this._getLevelnum,
  commoncarpweight = this._getCommoncarpweight,
  rarecarpweight = this._getRarecarpweight,
  epiccarpweight = this._getEpiccarpweight
}
return this
