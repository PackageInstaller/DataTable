local this = class("shop_shell", G_BaseConfig)
local core = G_Tables.TDShopTable.GetInstance()

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
  shopId = 0,
  shopName = 1,
  serverMallType = 2,
  groupId = 3,
  order = 4,
  systemUnLockId = 5,
  unlockCondition = 6,
  unlockConditionDesc = 7,
  refreshType = 8,
  refreshTypeParam = 9,
  startTime = 10,
  endTime = 11,
  duration = 12,
  timelimit = 13,
  launchType = 14,
  goodsList = 15,
  randomGoodsList = 16,
  goodsListPurchase = 17,
  param = 18,
  icon = 19,
  commonTabId = 20,
  resourceBar = 21,
  ModulePath = 22,
  _note = 23
}

function this:_getShopid(offset)
  return core:GetInt(offset, this.indexMap.shopId)
end

function this:_getShopname(offset)
  local langStr = G_TableMgrIns:GetLangStr("shop", core:GetVString(offset, this.indexMap.shopName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "shopName")
end

function this:_getServermalltype(offset)
  return core:GetInt(offset, this.indexMap.serverMallType)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getSystemunlockid(offset)
  return core:GetInt(offset, this.indexMap.systemUnLockId)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getUnlockconditiondesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("shop", core:GetVString(offset, this.indexMap.unlockConditionDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "unlockConditionDesc")
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

function this:_getTimelimit(offset)
  return core:GetInt(offset, this.indexMap.timelimit)
end

function this:_getLaunchtype(offset)
  return core:GetInt(offset, this.indexMap.launchType)
end

function this:_getGoodslist(offset)
  local str = core:GetVString(offset, this.indexMap.goodsList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRandomgoodslist(offset)
  return core:GetInt(offset, this.indexMap.randomGoodsList)
end

function this:_getGoodslistpurchase(offset)
  local str = core:GetVString(offset, this.indexMap.goodsListPurchase).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getParam(offset)
  return core:GetVString(offset, this.indexMap.param).value
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getCommontabid(offset)
  return core:GetInt(offset, this.indexMap.commonTabId)
end

function this:_getResourcebar(offset)
  local str = core:GetVString(offset, this.indexMap.resourceBar).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getModulepath(offset)
  local str = core:GetVString(offset, this.indexMap.ModulePath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_get_note(offset)
  return core:GetVString(offset, this.indexMap._note).value
end

this.keyToMethodsMap = {
  shopId = this._getShopid,
  shopName = this._getShopname,
  serverMallType = this._getServermalltype,
  groupId = this._getGroupid,
  order = this._getOrder,
  systemUnLockId = this._getSystemunlockid,
  unlockCondition = this._getUnlockcondition,
  unlockConditionDesc = this._getUnlockconditiondesc,
  refreshType = this._getRefreshtype,
  refreshTypeParam = this._getRefreshtypeparam,
  startTime = this._getStarttime,
  endTime = this._getEndtime,
  duration = this._getDuration,
  timelimit = this._getTimelimit,
  launchType = this._getLaunchtype,
  goodsList = this._getGoodslist,
  randomGoodsList = this._getRandomgoodslist,
  goodsListPurchase = this._getGoodslistpurchase,
  param = this._getParam,
  icon = this._getIcon,
  commonTabId = this._getCommontabid,
  resourceBar = this._getResourcebar,
  ModulePath = this._getModulepath,
  _note = this._get_note
}
return this
