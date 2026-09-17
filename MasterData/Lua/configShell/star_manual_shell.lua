local this = class("star_manual_shell", G_BaseConfig)
local core = G_Tables.TDStarManualTable.GetInstance()

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
  show = 2,
  unlock = 3,
  shopId = 4,
  limitParam = 5,
  desc = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

function this:_getUnlock(offset)
  return core:GetInt(offset, this.indexMap.unlock)
end

function this:_getShopid(offset)
  return core:GetInt(offset, this.indexMap.shopId)
end

function this:_getLimitparam(offset)
  return core:GetInt(offset, this.indexMap.limitParam)
end

function this:_getDesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("star_manual", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "star_manual")
end

this.keyToMethodsMap = {
  id = this._getId,
  order = this._getOrder,
  show = this._getShow,
  unlock = this._getUnlock,
  shopId = this._getShopid,
  limitParam = this._getLimitparam,
  desc = this._getDesc
}
return this
