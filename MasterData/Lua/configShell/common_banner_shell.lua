local this = class("common_banner_shell", G_BaseConfig)
local core = G_Tables.TDCommonBannerTable.GetInstance()

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
  order = 2,
  pic = 3,
  show = 4,
  type = 5,
  param = 6,
  startTime = 7,
  endTime = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("common_banner", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getParam(offset)
  return core:GetVString(offset, this.indexMap.param).value
end

function this:_getStarttime(offset)
  return core:GetVString(offset, this.indexMap.startTime).value
end

function this:_getEndtime(offset)
  return core:GetVString(offset, this.indexMap.endTime).value
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  order = this._getOrder,
  pic = this._getPic,
  show = this._getShow,
  type = this._getType,
  param = this._getParam,
  startTime = this._getStarttime,
  endTime = this._getEndtime
}
return this
