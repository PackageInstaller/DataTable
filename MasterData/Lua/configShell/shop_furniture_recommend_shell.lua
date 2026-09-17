local this = class("shop_furniture_recommend_shell", G_BaseConfig)
local core = G_Tables.TDShopFurnitureRecommendTable.GetInstance()

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
  startTime = 2,
  endTime = 3,
  showId = 4,
  jumpType = 5,
  param = 6,
  pic = 7
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("shop_furniture_recommend", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getStarttime(offset)
  return core:GetVString(offset, this.indexMap.startTime).value
end

function this:_getEndtime(offset)
  return core:GetVString(offset, this.indexMap.endTime).value
end

function this:_getShowid(offset)
  return core:GetInt(offset, this.indexMap.showId)
end

function this:_getJumptype(offset)
  return core:GetInt(offset, this.indexMap.jumpType)
end

function this:_getParam(offset)
  return core:GetInt(offset, this.indexMap.param)
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  startTime = this._getStarttime,
  endTime = this._getEndtime,
  showId = this._getShowid,
  jumpType = this._getJumptype,
  param = this._getParam,
  pic = this._getPic
}
return this
