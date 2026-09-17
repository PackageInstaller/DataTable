local this = class("mall_goods_shell", G_BaseConfig)
local core = G_Tables.TDMallGoodsTable.GetInstance()

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
  goodsId = 0,
  item = 1,
  goodsName = 2,
  desc = 3,
  autoOpen = 4,
  costId = 5,
  commonCondition = 6,
  unlockParam = 7,
  unlockDesc = 8,
  specialPrice = 9,
  specialTips = 10,
  order = 11,
  refreshType = 12,
  refreshTypeParam = 13,
  timelimit = 14,
  icon = 15,
  rarity = 16,
  goodsNum = 17,
  limitTxt = 18,
  disappearType = 19,
  showCondition = 20,
  redDots = 21,
  _note = 22
}

function this:_getGoodsid(offset)
  return core:GetInt(offset, this.indexMap.goodsId)
end

function this:_getItem(offset)
  local str = core:GetVString(offset, this.indexMap.item).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getGoodsname(offset)
  local langStr = G_TableMgrIns:GetLangStr("mall_goods", core:GetVString(offset, this.indexMap.goodsName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "goodsName")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("mall_goods", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getAutoopen(offset)
  return core:GetInt(offset, this.indexMap.autoOpen)
end

function this:_getCostid(offset)
  local str = core:GetVString(offset, this.indexMap.costId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getCommoncondition(offset)
  local str = core:GetVString(offset, this.indexMap.commonCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getUnlockparam(offset)
  local str = core:GetVString(offset, this.indexMap.unlockParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUnlockdesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("mall_goods", core:GetVString(offset, this.indexMap.unlockDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "mall_goods")
end

function this:_getSpecialprice(offset)
  return core:GetInt(offset, this.indexMap.specialPrice)
end

function this:_getSpecialtips(offset)
  local str = core:GetVString(offset, this.indexMap.specialTips).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getRefreshtype(offset)
  return core:GetInt(offset, this.indexMap.refreshType)
end

function this:_getRefreshtypeparam(offset)
  local str = core:GetVString(offset, this.indexMap.refreshTypeParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTimelimit(offset)
  return core:GetInt(offset, this.indexMap.timelimit)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getGoodsnum(offset)
  return core:GetInt(offset, this.indexMap.goodsNum)
end

function this:_getLimittxt(offset)
  local langStr = G_TableMgrIns:GetLangStr("mall_goods", core:GetVString(offset, this.indexMap.limitTxt))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "limitTxt")
end

function this:_getDisappeartype(offset)
  return core:GetInt(offset, this.indexMap.disappearType)
end

function this:_getShowcondition(offset)
  local str = core:GetVString(offset, this.indexMap.showCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getReddots(offset)
  return core:GetInt(offset, this.indexMap.redDots)
end

function this:_get_note(offset)
  return core:GetVString(offset, this.indexMap._note).value
end

this.keyToMethodsMap = {
  goodsId = this._getGoodsid,
  item = this._getItem,
  goodsName = this._getGoodsname,
  desc = this._getDesc,
  autoOpen = this._getAutoopen,
  costId = this._getCostid,
  commonCondition = this._getCommoncondition,
  unlockParam = this._getUnlockparam,
  unlockDesc = this._getUnlockdesc,
  specialPrice = this._getSpecialprice,
  specialTips = this._getSpecialtips,
  order = this._getOrder,
  refreshType = this._getRefreshtype,
  refreshTypeParam = this._getRefreshtypeparam,
  timelimit = this._getTimelimit,
  icon = this._getIcon,
  rarity = this._getRarity,
  goodsNum = this._getGoodsnum,
  limitTxt = this._getLimittxt,
  disappearType = this._getDisappeartype,
  showCondition = this._getShowcondition,
  redDots = this._getReddots,
  _note = this._get_note
}
return this
