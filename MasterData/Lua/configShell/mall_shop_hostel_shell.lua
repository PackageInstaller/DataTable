local this = class("mall_shop_hostel_shell", G_BaseConfig)
local core = G_Tables.TDMallShopHostelTable.GetInstance()

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
  type = 1,
  name = 2,
  tag = 3,
  desc = 4,
  bgpic = 5,
  enterbgpic = 6,
  goodsId = 7,
  order = 8,
  heroId = 9
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("mall_shop_hostel", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getTag(offset)
  local langStr = G_TableMgrIns:GetLangStr("mall_shop_hostel", core:GetVString(offset, this.indexMap.tag))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "tag")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("mall_shop_hostel", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getBgpic(offset)
  local str = core:GetVString(offset, this.indexMap.bgpic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getEnterbgpic(offset)
  local str = core:GetVString(offset, this.indexMap.enterbgpic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getGoodsid(offset)
  return core:GetInt(offset, this.indexMap.goodsId)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  name = this._getName,
  tag = this._getTag,
  desc = this._getDesc,
  bgpic = this._getBgpic,
  enterbgpic = this._getEnterbgpic,
  goodsId = this._getGoodsid,
  order = this._getOrder,
  heroId = this._getHeroid
}
return this
