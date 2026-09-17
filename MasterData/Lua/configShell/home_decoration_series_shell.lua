local this = class("home_decoration_series_shell", G_BaseConfig)
local core = G_Tables.TDHomeDecorationSeriesTable.GetInstance()

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
  name = 1,
  unlockCondition = 2,
  bannerPC = 3,
  bannerPortable = 4
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_decoration_series", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getBannerpc(offset)
  local str = core:GetVString(offset, this.indexMap.bannerPC).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getBannerportable(offset)
  local str = core:GetVString(offset, this.indexMap.bannerPortable).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  unlockCondition = this._getUnlockcondition,
  bannerPC = this._getBannerpc,
  bannerPortable = this._getBannerportable
}
return this
