local this = class("mall_shop_shell", G_BaseConfig)
local core = G_Tables.TDMallShopTable.GetInstance()

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
  systemUnLockId = 3,
  gmBlockType = 4,
  groupId = 5,
  order = 6,
  unlockCondition = 7,
  refreshType = 8,
  refreshTypeParam = 9,
  timelimit = 10,
  goodsList = 11,
  goodsListPurchase = 12,
  param = 13,
  icon = 14,
  resourceBar = 15,
  ModulePath = 16,
  tabShowCtrl = 17,
  _note = 18
}

function this:_getShopid(offset)
  return core:GetInt(offset, this.indexMap.shopId)
end

function this:_getShopname(offset)
  local langStr = G_TableMgrIns:GetLangStr("mall_shop", core:GetVString(offset, this.indexMap.shopName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "shopName")
end

function this:_getServermalltype(offset)
  return core:GetInt(offset, this.indexMap.serverMallType)
end

function this:_getSystemunlockid(offset)
  return core:GetInt(offset, this.indexMap.systemUnLockId)
end

function this:_getGmblocktype(offset)
  return core:GetInt(offset, this.indexMap.gmBlockType)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
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

function this:_getGoodslist(offset)
  local str = core:GetVString(offset, this.indexMap.goodsList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
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

function this:_getResourcebar(offset)
  local str = core:GetVString(offset, this.indexMap.resourceBar).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getModulepath(offset)
  local str = core:GetVString(offset, this.indexMap.ModulePath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTabshowctrl(offset)
  return core:GetInt(offset, this.indexMap.tabShowCtrl)
end

function this:_get_note(offset)
  return core:GetVString(offset, this.indexMap._note).value
end

this.keyToMethodsMap = {
  shopId = this._getShopid,
  shopName = this._getShopname,
  serverMallType = this._getServermalltype,
  systemUnLockId = this._getSystemunlockid,
  gmBlockType = this._getGmblocktype,
  groupId = this._getGroupid,
  order = this._getOrder,
  unlockCondition = this._getUnlockcondition,
  refreshType = this._getRefreshtype,
  refreshTypeParam = this._getRefreshtypeparam,
  timelimit = this._getTimelimit,
  goodsList = this._getGoodslist,
  goodsListPurchase = this._getGoodslistpurchase,
  param = this._getParam,
  icon = this._getIcon,
  resourceBar = this._getResourcebar,
  ModulePath = this._getModulepath,
  tabShowCtrl = this._getTabshowctrl,
  _note = this._get_note
}
return this
