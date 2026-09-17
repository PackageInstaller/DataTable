local this = class("hero_interim_shell", G_BaseConfig)
local core = G_Tables.TDHeroInterimTable.GetInstance()

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
  rank = 2,
  talentrune = 3,
  skilllevel = 4,
  heroType = 5,
  heroId = 6,
  name = 7,
  starLevel = 8,
  gradeLevel = 9,
  soulessence = 10,
  accessorySet = 11
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getRank(offset)
  return core:GetInt(offset, this.indexMap.rank)
end

function this:_getTalentrune(offset)
  return core:GetInt(offset, this.indexMap.talentrune)
end

function this:_getSkilllevel(offset)
  local str = core:GetVString(offset, this.indexMap.skilllevel).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHerotype(offset)
  return core:GetInt(offset, this.indexMap.heroType)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_interim", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getStarlevel(offset)
  return core:GetInt(offset, this.indexMap.starLevel)
end

function this:_getGradelevel(offset)
  return core:GetInt(offset, this.indexMap.gradeLevel)
end

function this:_getSoulessence(offset)
  local str = core:GetVString(offset, this.indexMap.soulessence).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getAccessoryset(offset)
  local str = core:GetVString(offset, this.indexMap.accessorySet).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  level = this._getLevel,
  rank = this._getRank,
  talentrune = this._getTalentrune,
  skilllevel = this._getSkilllevel,
  heroType = this._getHerotype,
  heroId = this._getHeroid,
  name = this._getName,
  starLevel = this._getStarlevel,
  gradeLevel = this._getGradelevel,
  soulessence = this._getSoulessence,
  accessorySet = this._getAccessoryset
}
return this
