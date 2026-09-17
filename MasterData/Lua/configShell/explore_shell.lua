local this = class("explore_shell", G_BaseConfig)
local core = G_Tables.TDExploreTable.GetInstance()

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
  regionid = 1,
  areaid = 2,
  exploreType = 3,
  kibo = 4,
  category = 5,
  filler = 6,
  fillerspawner = 7,
  fillercount = 8,
  ExploreIcon = 9,
  ExploreTexture = 10,
  exploreName = 11,
  introducetext = 12,
  unlocktext = 13,
  condition = 14,
  exploreexp = 15
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getRegionid(offset)
  return core:GetInt(offset, this.indexMap.regionid)
end

function this:_getAreaid(offset)
  return core:GetInt(offset, this.indexMap.areaid)
end

function this:_getExploretype(offset)
  return core:GetInt(offset, this.indexMap.exploreType)
end

function this:_getKibo(offset)
  local str = core:GetVString(offset, this.indexMap.kibo).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCategory(offset)
  return core:GetInt(offset, this.indexMap.category)
end

function this:_getFiller(offset)
  return core:GetInt(offset, this.indexMap.filler)
end

function this:_getFillerspawner(offset)
  local str = core:GetVString(offset, this.indexMap.fillerspawner).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getFillercount(offset)
  return core:GetInt(offset, this.indexMap.fillercount)
end

function this:_getExploreicon(offset)
  local str = core:GetVString(offset, this.indexMap.ExploreIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getExploretexture(offset)
  local str = core:GetVString(offset, this.indexMap.ExploreTexture).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getExplorename(offset)
  local langStr = G_TableMgrIns:GetLangStr("explore", core:GetVString(offset, this.indexMap.exploreName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "exploreName")
end

function this:_getIntroducetext(offset)
  local langStr = G_TableMgrIns:GetLangStr("explore", core:GetVString(offset, this.indexMap.introducetext))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "introducetext")
end

function this:_getUnlocktext(offset)
  local langStr = G_TableMgrIns:GetLangStr("explore", core:GetVString(offset, this.indexMap.unlocktext))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlocktext")
end

function this:_getCondition(offset)
  local str = core:GetVString(offset, this.indexMap.condition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getExploreexp(offset)
  return core:GetInt(offset, this.indexMap.exploreexp)
end

this.keyToMethodsMap = {
  id = this._getId,
  regionid = this._getRegionid,
  areaid = this._getAreaid,
  exploreType = this._getExploretype,
  kibo = this._getKibo,
  category = this._getCategory,
  filler = this._getFiller,
  fillerspawner = this._getFillerspawner,
  fillercount = this._getFillercount,
  ExploreIcon = this._getExploreicon,
  ExploreTexture = this._getExploretexture,
  exploreName = this._getExplorename,
  introducetext = this._getIntroducetext,
  unlocktext = this._getUnlocktext,
  condition = this._getCondition,
  exploreexp = this._getExploreexp
}
return this
