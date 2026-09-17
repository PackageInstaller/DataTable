local this = class("template_difficulty_shell", G_BaseConfig)
local core = G_Tables.TDTemplateDifficultyTable.GetInstance()

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
  difficulty = 1,
  type = 2,
  level = 3,
  baseAttribute = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDifficulty(offset)
  return core:GetInt(offset, this.indexMap.difficulty)
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

this.keyToMethodsMap = {
  id = this._getId,
  difficulty = this._getDifficulty,
  type = this._getType,
  level = this._getLevel,
  baseAttribute = this._getBaseattribute
}
return this
