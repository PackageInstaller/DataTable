local this = class("mall_shop_recommend_shell", G_BaseConfig)
local core = G_Tables.TDMallShopRecommendTable.GetInstance()

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
  order = 1,
  name = 2,
  startTime = 3,
  endTime = 4,
  timelimit = 5,
  redDots = 6,
  type = 7,
  disappearType = 8,
  goodsParam = 9,
  param = 10,
  jumpParam = 11,
  timeShow = 12,
  modulePath = 13,
  pic = 14,
  specialTips = 15,
  icon = 16,
  introductionId = 17
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("mall_shop_recommend", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getStarttime(offset)
  return core:GetVString(offset, this.indexMap.startTime).value
end

function this:_getEndtime(offset)
  return core:GetVString(offset, this.indexMap.endTime).value
end

function this:_getTimelimit(offset)
  return core:GetInt(offset, this.indexMap.timelimit)
end

function this:_getReddots(offset)
  return core:GetInt(offset, this.indexMap.redDots)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getDisappeartype(offset)
  return core:GetInt(offset, this.indexMap.disappearType)
end

function this:_getGoodsparam(offset)
  local str = core:GetVString(offset, this.indexMap.goodsParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getJumpparam(offset)
  local str = core:GetVString(offset, this.indexMap.jumpParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTimeshow(offset)
  return core:GetInt(offset, this.indexMap.timeShow)
end

function this:_getModulepath(offset)
  local str = core:GetVString(offset, this.indexMap.modulePath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPic(offset)
  local str = core:GetVString(offset, this.indexMap.pic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSpecialtips(offset)
  local str = core:GetVString(offset, this.indexMap.specialTips).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIntroductionid(offset)
  return core:GetInt(offset, this.indexMap.introductionId)
end

this.keyToMethodsMap = {
  id = this._getId,
  order = this._getOrder,
  name = this._getName,
  startTime = this._getStarttime,
  endTime = this._getEndtime,
  timelimit = this._getTimelimit,
  redDots = this._getReddots,
  type = this._getType,
  disappearType = this._getDisappeartype,
  goodsParam = this._getGoodsparam,
  param = this._getParam,
  jumpParam = this._getJumpparam,
  timeShow = this._getTimeshow,
  modulePath = this._getModulepath,
  pic = this._getPic,
  specialTips = this._getSpecialtips,
  icon = this._getIcon,
  introductionId = this._getIntroductionid
}
return this
