local this = class("food_cook_shell", G_BaseConfig)
local core = G_Tables.TDFoodCookTable.GetInstance()

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
  rarity = 1,
  material = 2,
  timesLimit = 3,
  gameContent = 4,
  proficiency = 5,
  unlock = 6,
  commonBase = 7,
  perferBase = 8,
  coefficient = 9,
  timeline = 10,
  specialShow = 11,
  normal = 12,
  perfect = 13,
  fail = 14,
  desc = 15,
  tagDesc = 16,
  valueIndex = 17
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getMaterial(offset)
  local str = core:GetVString(offset, this.indexMap.material).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTimeslimit(offset)
  local str = core:GetVString(offset, this.indexMap.timesLimit).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getGamecontent(offset)
  local str = core:GetVString(offset, this.indexMap.gameContent).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getProficiency(offset)
  return core:GetInt(offset, this.indexMap.proficiency)
end

function this:_getUnlock(offset)
  return core:GetInt(offset, this.indexMap.unlock)
end

function this:_getCommonbase(offset)
  return core:GetInt(offset, this.indexMap.commonBase)
end

function this:_getPerferbase(offset)
  return core:GetInt(offset, this.indexMap.perferBase)
end

function this:_getCoefficient(offset)
  return core:GetInt(offset, this.indexMap.coefficient)
end

function this:_getTimeline(offset)
  local str = core:GetVString(offset, this.indexMap.timeline).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSpecialshow(offset)
  local str = core:GetVString(offset, this.indexMap.specialShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNormal(offset)
  local str = core:GetVString(offset, this.indexMap.normal).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPerfect(offset)
  local str = core:GetVString(offset, this.indexMap.perfect).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getFail(offset)
  local str = core:GetVString(offset, this.indexMap.fail).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("food_cook", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getTagdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("food_cook", core:GetVString(offset, this.indexMap.tagDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "tagDesc")
end

function this:_getValueindex(offset)
  local str = core:GetVString(offset, this.indexMap.valueIndex).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  rarity = this._getRarity,
  material = this._getMaterial,
  timesLimit = this._getTimeslimit,
  gameContent = this._getGamecontent,
  proficiency = this._getProficiency,
  unlock = this._getUnlock,
  commonBase = this._getCommonbase,
  perferBase = this._getPerferbase,
  coefficient = this._getCoefficient,
  timeline = this._getTimeline,
  specialShow = this._getSpecialshow,
  normal = this._getNormal,
  perfect = this._getPerfect,
  fail = this._getFail,
  desc = this._getDesc,
  tagDesc = this._getTagdesc,
  valueIndex = this._getValueindex
}
return this
