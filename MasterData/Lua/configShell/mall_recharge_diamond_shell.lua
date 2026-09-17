local this = class("mall_recharge_diamond_shell", G_BaseConfig)
local core = G_Tables.TDMallRechargeDiamondTable.GetInstance()

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
  purchaseSdkID = 0,
  goodsName = 1,
  rechargeDiamondNum = 2,
  firstRechargeBonus = 3,
  rechargeBonus = 4,
  order = 5,
  firstspecialTips = 6,
  specialTips = 7,
  icon = 8,
  iconSpine = 9,
  hoverAudio = 10,
  rarity = 11,
  resetTimeStamp = 12,
  _note = 13
}

function this:_getPurchasesdkid(offset)
  return core:GetInt(offset, this.indexMap.purchaseSdkID)
end

function this:_getGoodsname(offset)
  local langStr = G_TableMgrIns:GetLangStr("mall_recharge_diamond", core:GetVString(offset, this.indexMap.goodsName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "goodsName")
end

function this:_getRechargediamondnum(offset)
  return core:GetInt(offset, this.indexMap.rechargeDiamondNum)
end

function this:_getFirstrechargebonus(offset)
  return core:GetInt(offset, this.indexMap.firstRechargeBonus)
end

function this:_getRechargebonus(offset)
  return core:GetInt(offset, this.indexMap.rechargeBonus)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getFirstspecialtips(offset)
  local str = core:GetVString(offset, this.indexMap.firstspecialTips).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getSpecialtips(offset)
  local str = core:GetVString(offset, this.indexMap.specialTips).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIconspine(offset)
  local str = core:GetVString(offset, this.indexMap.iconSpine).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getHoveraudio(offset)
  return core:GetVString(offset, this.indexMap.hoverAudio).value
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getResettimestamp(offset)
  local str = core:GetVString(offset, this.indexMap.resetTimeStamp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_get_note(offset)
  return core:GetVString(offset, this.indexMap._note).value
end

this.keyToMethodsMap = {
  purchaseSdkID = this._getPurchasesdkid,
  goodsName = this._getGoodsname,
  rechargeDiamondNum = this._getRechargediamondnum,
  firstRechargeBonus = this._getFirstrechargebonus,
  rechargeBonus = this._getRechargebonus,
  order = this._getOrder,
  firstspecialTips = this._getFirstspecialtips,
  specialTips = this._getSpecialtips,
  icon = this._getIcon,
  iconSpine = this._getIconspine,
  hoverAudio = this._getHoveraudio,
  rarity = this._getRarity,
  resetTimeStamp = this._getResettimestamp,
  _note = this._get_note
}
return this
