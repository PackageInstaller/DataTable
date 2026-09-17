local this = class("repeat_event_chapter_shell", G_BaseConfig)
local core = G_Tables.TDRepeatEventChapterTable.GetInstance()

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
  group = 1,
  sort = 2,
  name = 3,
  levelGroup = 4,
  preLevel = 5,
  preLevelDiff = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getSort(offset)
  return core:GetInt(offset, this.indexMap.sort)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("repeat_event_chapter", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getLevelgroup(offset)
  return core:GetInt(offset, this.indexMap.levelGroup)
end

function this:_getPrelevel(offset)
  return core:GetInt(offset, this.indexMap.preLevel)
end

function this:_getPreleveldiff(offset)
  return core:GetInt(offset, this.indexMap.preLevelDiff)
end

this.keyToMethodsMap = {
  id = this._getId,
  group = this._getGroup,
  sort = this._getSort,
  name = this._getName,
  levelGroup = this._getLevelgroup,
  preLevel = this._getPrelevel,
  preLevelDiff = this._getPreleveldiff
}
return this
