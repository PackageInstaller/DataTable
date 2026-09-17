local this = class("template_hero_shell", G_BaseConfig)
local core = G_Tables.TDTemplateHeroTable.GetInstance()

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
  level = 2,
  baseAttribute = 3,
  ascension = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getBaseattribute(offset)
  return core:GetInt(offset, this.indexMap.baseAttribute)
end

function this:_getAscension(offset)
  return core:GetInt(offset, this.indexMap.ascension)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  level = this._getLevel,
  baseAttribute = this._getBaseattribute,
  ascension = this._getAscension
}
return this
