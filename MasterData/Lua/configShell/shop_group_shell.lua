local this = class("shop_group_shell", G_BaseConfig)
local core = G_Tables.TDShopGroupTable.GetInstance()

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
  shopGroupId = 0,
  shopGroupName = 1,
  point = 2,
  order = 3,
  shopList = 4,
  unlockCondition = 5,
  isMall = 6,
  shopType = 7,
  icon = 8,
  npcShopIcon = 9,
  npcParam = 10,
  _note = 11
}

function this:_getShopgroupid(offset)
  return core:GetInt(offset, this.indexMap.shopGroupId)
end

function this:_getShopgroupname(offset)
  local langStr = G_TableMgrIns:GetLangStr("shop_group", core:GetVString(offset, this.indexMap.shopGroupName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "shopGroupName")
end

function this:_getPoint(offset)
  return core:GetInt(offset, this.indexMap.point)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getShoplist(offset)
  local str = core:GetVString(offset, this.indexMap.shopList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getIsmall(offset)
  return core:GetBool(offset, this.indexMap.isMall)
end

function this:_getShoptype(offset)
  return core:GetInt(offset, this.indexMap.shopType)
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getNpcshopicon(offset)
  local str = core:GetVString(offset, this.indexMap.npcShopIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getNpcparam(offset)
  local str = core:GetVString(offset, this.indexMap.npcParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_get_note(offset)
  return core:GetVString(offset, this.indexMap._note).value
end

this.keyToMethodsMap = {
  shopGroupId = this._getShopgroupid,
  shopGroupName = this._getShopgroupname,
  point = this._getPoint,
  order = this._getOrder,
  shopList = this._getShoplist,
  unlockCondition = this._getUnlockcondition,
  isMall = this._getIsmall,
  shopType = this._getShoptype,
  icon = this._getIcon,
  npcShopIcon = this._getNpcshopicon,
  npcParam = this._getNpcparam,
  _note = this._get_note
}
return this
