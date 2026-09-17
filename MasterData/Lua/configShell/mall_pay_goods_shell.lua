local this = class("mall_pay_goods_shell", G_BaseConfig)
local core = G_Tables.TDMallPayGoodsTable.GetInstance()

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
  purchaseSdkID = 5,
  costPurchaseDiamondNum = 6,
  costDiamondOriginal = 7,
  commonCondition = 8,
  unlockParam = 9,
  unlockDesc = 10,
  specialPrice = 11,
  specialTips = 12,
  order = 13,
  refreshType = 14,
  refreshTypeParam = 15,
  timelimit = 16,
  icon = 17,
  illustrationPic = 18,
  BuyTipLPic = 19,
  rarity = 20,
  goodsNum = 21,
  limitTxt = 22,
  disappearType = 23,
  showCondition = 24,
  redDots = 25,
  clothingSceneId = 26,
  giftTagIndex = 27,
  mailId = 28,
  _note = 29
}

function this:_getGoodsid(offset)
  return core:GetInt(offset, this.indexMap.goodsId)
end

function this:_getItem(offset)
  local str = core:GetVString(offset, this.indexMap.item).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getGoodsname(offset)
  local langStr = G_TableMgrIns:GetLangStr("mall_pay_goods", core:GetVString(offset, this.indexMap.goodsName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "goodsName")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("mall_pay_goods", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getAutoopen(offset)
  return core:GetInt(offset, this.indexMap.autoOpen)
end

function this:_getPurchasesdkid(offset)
  return core:GetInt(offset, this.indexMap.purchaseSdkID)
end

function this:_getCostpurchasediamondnum(offset)
  return core:GetInt(offset, this.indexMap.costPurchaseDiamondNum)
end

function this:_getCostdiamondoriginal(offset)
  return core:GetInt(offset, this.indexMap.costDiamondOriginal)
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
  local langStrList = G_TableMgrIns:GetListLangStr("mall_pay_goods", core:GetVString(offset, this.indexMap.unlockDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "mall_pay_goods")
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

function this:_getIllustrationpic(offset)
  local str = core:GetVString(offset, this.indexMap.illustrationPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getBuytiplpic(offset)
  local str = core:GetVString(offset, this.indexMap.BuyTipLPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getGoodsnum(offset)
  return core:GetInt(offset, this.indexMap.goodsNum)
end

function this:_getLimittxt(offset)
  local langStr = G_TableMgrIns:GetLangStr("mall_pay_goods", core:GetVString(offset, this.indexMap.limitTxt))
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

function this:_getClothingsceneid(offset)
  return core:GetInt(offset, this.indexMap.clothingSceneId)
end

function this:_getGifttagindex(offset)
  local str = core:GetVString(offset, this.indexMap.giftTagIndex).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getMailid(offset)
  return core:GetInt(offset, this.indexMap.mailId)
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
  purchaseSdkID = this._getPurchasesdkid,
  costPurchaseDiamondNum = this._getCostpurchasediamondnum,
  costDiamondOriginal = this._getCostdiamondoriginal,
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
  illustrationPic = this._getIllustrationpic,
  BuyTipLPic = this._getBuytiplpic,
  rarity = this._getRarity,
  goodsNum = this._getGoodsnum,
  limitTxt = this._getLimittxt,
  disappearType = this._getDisappeartype,
  showCondition = this._getShowcondition,
  redDots = this._getReddots,
  clothingSceneId = this._getClothingsceneid,
  giftTagIndex = this._getGifttagindex,
  mailId = this._getMailid,
  _note = this._get_note
}
return this
