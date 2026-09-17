local this = class("trailhero_shell", G_BaseConfig)
local core = G_Tables.TDTrailheroTable.GetInstance()

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
  trailHero = 1,
  trailHeroLevel = 2,
  trailHeroSkillLevel = 3,
  trailHeroBreak = 4,
  trailSoulEssence = 5,
  trailSoulEssenceLevel = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTrailhero(offset)
  return core:GetInt(offset, this.indexMap.trailHero)
end

function this:_getTrailherolevel(offset)
  return core:GetInt(offset, this.indexMap.trailHeroLevel)
end

function this:_getTrailheroskilllevel(offset)
  return core:GetInt(offset, this.indexMap.trailHeroSkillLevel)
end

function this:_getTrailherobreak(offset)
  return core:GetInt(offset, this.indexMap.trailHeroBreak)
end

function this:_getTrailsoulessence(offset)
  return core:GetInt(offset, this.indexMap.trailSoulEssence)
end

function this:_getTrailsoulessencelevel(offset)
  return core:GetInt(offset, this.indexMap.trailSoulEssenceLevel)
end

this.keyToMethodsMap = {
  id = this._getId,
  trailHero = this._getTrailhero,
  trailHeroLevel = this._getTrailherolevel,
  trailHeroSkillLevel = this._getTrailheroskilllevel,
  trailHeroBreak = this._getTrailherobreak,
  trailSoulEssence = this._getTrailsoulessence,
  trailSoulEssenceLevel = this._getTrailsoulessencelevel
}
return this
