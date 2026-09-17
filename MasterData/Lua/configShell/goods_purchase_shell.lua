local this = class("goods_purchase_shell", G_BaseConfig)
local core = G_Tables.TDGoodsPurchaseTable.GetInstance()

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
  costId = 4,
  costNum = 5,
  commonCondition = 6,
  unlockParam = 7,
  unlockDesc = 8,
  recommend = 9,
  specialPrice = 10,
  specialTips = 11,
  order = 12,
  refreshType = 13,
  refreshTypeParam = 14,
  startTime = 15,
  endTime = 16,
  duration = 17,
  icon = 18,
  rarity = 19,
  goodsNum = 20,
  limitTxt = 21,
  disappearType = 22,
  showCondition = 23,
  redDots = 24,
  isDelete = 25,
  _note = 26
}

function this:_getGoodsid(offset)
  return core:GetInt(offset, this.indexMap.goodsId)
end

function this:_getItem(offset)
  local str = core:GetVString(offset, this.indexMap.item).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getGoodsname(offset)
  local langStr = G_TableMgrIns:GetLangStr("goods_purchase", core:GetVString(offset, this.indexMap.goodsName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "goodsName")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("goods_purchase", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getCostid(offset)
  return core:GetInt(offset, this.indexMap.costId)
end

function this:_getCostnum(offset)
  return core:GetInt(offset, this.indexMap.costNum)
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
  local langStrList = G_TableMgrIns:GetListLangStr("goods_purchase", core:GetVString(offset, this.indexMap.unlockDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "goods_purchase")
end

function this:_getRecommend(offset)
  return core:GetVString(offset, this.indexMap.recommend).value
end

function this:_getSpecialprice(offset)
  return core:GetInt(offset, this.indexMap.specialPrice)
end

function this:_getSpecialtips(offset)
  local str = core:GetVString(offset, this.indexMap.specialTips).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
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

function this:_getStarttime(offset)
  return core:GetVString(offset, this.indexMap.startTime).value
end

function this:_getEndtime(offset)
  return core:GetVString(offset, this.indexMap.endTime).value
end

function this:_getDuration(offset)
  return core:GetInt(offset, this.indexMap.duration)
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
  local langStr = G_TableMgrIns:GetLangStr("goods_purchase", core:GetVString(offset, this.indexMap.limitTxt))
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

function this:_getIsdelete(offset)
  return core:GetBool(offset, this.indexMap.isDelete)
end

function this:_get_note(offset)
  return core:GetVString(offset, this.indexMap._note).value
end

this.keyToMethodsMap = {
  goodsId = this._getGoodsid,
  item = this._getItem,
  goodsName = this._getGoodsname,
  desc = this._getDesc,
  costId = this._getCostid,
  costNum = this._getCostnum,
  commonCondition = this._getCommoncondition,
  unlockParam = this._getUnlockparam,
  unlockDesc = this._getUnlockdesc,
  recommend = this._getRecommend,
  specialPrice = this._getSpecialprice,
  specialTips = this._getSpecialtips,
  order = this._getOrder,
  refreshType = this._getRefreshtype,
  refreshTypeParam = this._getRefreshtypeparam,
  startTime = this._getStarttime,
  endTime = this._getEndtime,
  duration = this._getDuration,
  icon = this._getIcon,
  rarity = this._getRarity,
  goodsNum = this._getGoodsnum,
  limitTxt = this._getLimittxt,
  disappearType = this._getDisappeartype,
  showCondition = this._getShowcondition,
  redDots = this._getReddots,
  isDelete = this._getIsdelete,
  _note = this._get_note
}
return this
