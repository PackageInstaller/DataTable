local this = class("home_technology_level_shell", G_BaseConfig)
local core = G_Tables.TDHomeTechnologyLevelTable.GetInstance()

function this:getLineOffset(key)
  return core:GetRowOffset(key)
end

function this:getLen()
  return core.count or 0
end

function this:getKeys()
  return core:GetKeysEnumerator()
end

this.indexMap = {id = 0, technologyCount = 1}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTechnologycount(offset)
  return core:GetInt(offset, this.indexMap.technologyCount)
end

this.keyToMethodsMap = {
  id = this._getId,
  technologyCount = this._getTechnologycount
}
return this
