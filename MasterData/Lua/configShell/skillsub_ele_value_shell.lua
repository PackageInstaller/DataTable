local this = class("skillsub_ele_value_shell", G_BaseConfig)
local core = G_Tables.TDSkillsubEleValueTable.GetInstance()

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
  elementId = 1,
  skillId = 2,
  level = 3,
  valueParam = 4,
  overrideDuration = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getElementid(offset)
  return core:GetInt(offset, this.indexMap.elementId)
end

function this:_getSkillid(offset)
  return core:GetInt(offset, this.indexMap.skillId)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getValueparam(offset)
  local str = core:GetVString(offset, this.indexMap.valueParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getOverrideduration(offset)
  return core:GetInt(offset, this.indexMap.overrideDuration)
end

this.keyToMethodsMap = {
  id = this._getId,
  elementId = this._getElementid,
  skillId = this._getSkillid,
  level = this._getLevel,
  valueParam = this._getValueparam,
  overrideDuration = this._getOverrideduration
}
return this
