local this = class("optiondata_total_shell", G_BaseConfig)
local core = G_Tables.TDOptionDataTotalTable.GetInstance()

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
  level2 = 1,
  level3 = 2,
  level4 = 3,
  level5 = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLevel2(offset)
  return core:GetInt(offset, this.indexMap.level2)
end

function this:_getLevel3(offset)
  return core:GetInt(offset, this.indexMap.level3)
end

function this:_getLevel4(offset)
  return core:GetInt(offset, this.indexMap.level4)
end

function this:_getLevel5(offset)
  return core:GetInt(offset, this.indexMap.level5)
end

this.keyToMethodsMap = {
  id = this._getId,
  level2 = this._getLevel2,
  level3 = this._getLevel3,
  level4 = this._getLevel4,
  level5 = this._getLevel5
}
return this
