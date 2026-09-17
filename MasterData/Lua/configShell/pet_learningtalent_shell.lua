local this = class("pet_learningtalent_shell", G_BaseConfig)
local core = G_Tables.TDPetLearningtalentTable.GetInstance()

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
  icon = 2,
  type = 3,
  enumId = 4,
  range = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLevel(offset)
  return core:GetVString(offset, this.indexMap.level).value
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getEnumid(offset)
  return core:GetInt(offset, this.indexMap.enumId)
end

function this:_getRange(offset)
  local str = core:GetVString(offset, this.indexMap.range).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  level = this._getLevel,
  icon = this._getIcon,
  type = this._getType,
  enumId = this._getEnumid,
  range = this._getRange
}
return this
