local this = class("repeat_event_level_shell", G_BaseConfig)
local core = G_Tables.TDRepeatEventLevelTable.GetInstance()

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
  preLevel = 2,
  preLevelDiff = 3,
  type = 4,
  iconNum = 5,
  firstDrop = 6,
  firstDropShow = 7,
  fightLimitNum = 8,
  isRankOpen = 9,
  normalDungeonId = 10,
  normalName = 11,
  normalDesc = 12,
  normalExtraDropNum = 13,
  normalExtraDrop = 14,
  normalExtraDropShow = 15,
  isFreeChestNormal = 16,
  isHardOpen = 17,
  hardDungeonId = 18,
  hardName = 19,
  hardDesc = 20,
  hardExtraDropNum = 21,
  hardExtraDrop = 22,
  hardExtraDropShow = 23,
  isFreeChestHard = 24
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroup(offset)
  return core:GetInt(offset, this.indexMap.group)
end

function this:_getPrelevel(offset)
  return core:GetInt(offset, this.indexMap.preLevel)
end

function this:_getPreleveldiff(offset)
  return core:GetInt(offset, this.indexMap.preLevelDiff)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getIconnum(offset)
  local str = core:GetVString(offset, this.indexMap.iconNum).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getFirstdrop(offset)
  return core:GetInt(offset, this.indexMap.firstDrop)
end

function this:_getFirstdropshow(offset)
  local str = core:GetVString(offset, this.indexMap.firstDropShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getFightlimitnum(offset)
  return core:GetInt(offset, this.indexMap.fightLimitNum)
end

function this:_getIsrankopen(offset)
  return core:GetInt(offset, this.indexMap.isRankOpen)
end

function this:_getNormaldungeonid(offset)
  return core:GetInt(offset, this.indexMap.normalDungeonId)
end

function this:_getNormalname(offset)
  local langStr = G_TableMgrIns:GetLangStr("repeat_event_level", core:GetVString(offset, this.indexMap.normalName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "normalName")
end

function this:_getNormaldesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("repeat_event_level", core:GetVString(offset, this.indexMap.normalDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "normalDesc")
end

function this:_getNormalextradropnum(offset)
  return core:GetInt(offset, this.indexMap.normalExtraDropNum)
end

function this:_getNormalextradrop(offset)
  return core:GetInt(offset, this.indexMap.normalExtraDrop)
end

function this:_getNormalextradropshow(offset)
  local str = core:GetVString(offset, this.indexMap.normalExtraDropShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getIsfreechestnormal(offset)
  return core:GetInt(offset, this.indexMap.isFreeChestNormal)
end

function this:_getIshardopen(offset)
  return core:GetInt(offset, this.indexMap.isHardOpen)
end

function this:_getHarddungeonid(offset)
  return core:GetInt(offset, this.indexMap.hardDungeonId)
end

function this:_getHardname(offset)
  local langStr = G_TableMgrIns:GetLangStr("repeat_event_level", core:GetVString(offset, this.indexMap.hardName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "hardName")
end

function this:_getHarddesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("repeat_event_level", core:GetVString(offset, this.indexMap.hardDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "hardDesc")
end

function this:_getHardextradropnum(offset)
  return core:GetInt(offset, this.indexMap.hardExtraDropNum)
end

function this:_getHardextradrop(offset)
  return core:GetInt(offset, this.indexMap.hardExtraDrop)
end

function this:_getHardextradropshow(offset)
  local str = core:GetVString(offset, this.indexMap.hardExtraDropShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getIsfreechesthard(offset)
  return core:GetInt(offset, this.indexMap.isFreeChestHard)
end

this.keyToMethodsMap = {
  id = this._getId,
  group = this._getGroup,
  preLevel = this._getPrelevel,
  preLevelDiff = this._getPreleveldiff,
  type = this._getType,
  iconNum = this._getIconnum,
  firstDrop = this._getFirstdrop,
  firstDropShow = this._getFirstdropshow,
  fightLimitNum = this._getFightlimitnum,
  isRankOpen = this._getIsrankopen,
  normalDungeonId = this._getNormaldungeonid,
  normalName = this._getNormalname,
  normalDesc = this._getNormaldesc,
  normalExtraDropNum = this._getNormalextradropnum,
  normalExtraDrop = this._getNormalextradrop,
  normalExtraDropShow = this._getNormalextradropshow,
  isFreeChestNormal = this._getIsfreechestnormal,
  isHardOpen = this._getIshardopen,
  hardDungeonId = this._getHarddungeonid,
  hardName = this._getHardname,
  hardDesc = this._getHarddesc,
  hardExtraDropNum = this._getHardextradropnum,
  hardExtraDrop = this._getHardextradrop,
  hardExtraDropShow = this._getHardextradropshow,
  isFreeChestHard = this._getIsfreechesthard
}
return this
