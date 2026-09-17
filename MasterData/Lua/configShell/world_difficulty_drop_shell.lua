local this = class("world_difficulty_drop_shell", G_BaseConfig)
local core = G_Tables.TDWorldDifficultyDropTable.GetInstance()

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
  monsterType = 1,
  lowLevel = 2,
  topLevel = 3,
  drop = 4,
  worldStarlinkDna = 5,
  holeStarlinkDna = 6,
  technologyExp = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getMonstertype(offset)
  return core:GetInt(offset, this.indexMap.monsterType)
end

function this:_getLowlevel(offset)
  return core:GetInt(offset, this.indexMap.lowLevel)
end

function this:_getToplevel(offset)
  return core:GetInt(offset, this.indexMap.topLevel)
end

function this:_getDrop(offset)
  return core:GetInt(offset, this.indexMap.drop)
end

function this:_getWorldstarlinkdna(offset)
  return core:GetInt(offset, this.indexMap.worldStarlinkDna)
end

function this:_getHolestarlinkdna(offset)
  return core:GetInt(offset, this.indexMap.holeStarlinkDna)
end

function this:_getTechnologyexp(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  monsterType = this._getMonstertype,
  lowLevel = this._getLowlevel,
  topLevel = this._getToplevel,
  drop = this._getDrop,
  worldStarlinkDna = this._getWorldstarlinkdna,
  holeStarlinkDna = this._getHolestarlinkdna,
  technologyExp = this._getTechnologyexp
}
return this
