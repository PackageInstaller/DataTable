local this = class("currency_bar_shell", G_BaseConfig)
local core = G_Tables.TDCurrencyBarTable.GetInstance()

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
  classify = 1,
  viewType = 2,
  currencyList = 3,
  showJump = 4,
  _desc = 5
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getClassify(offset)
  return core:GetInt(offset, this.indexMap.classify)
end

function this:_getViewtype(offset)
  return core:GetInt(offset, this.indexMap.viewType)
end

function this:_getCurrencylist(offset)
  local str = core:GetVString(offset, this.indexMap.currencyList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getShowjump(offset)
  local str = core:GetVString(offset, this.indexMap.showJump).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_get_desc(offset)
  return core:GetVString(offset, this.indexMap._desc).value
end

this.keyToMethodsMap = {
  id = this._getId,
  classify = this._getClassify,
  viewType = this._getViewtype,
  currencyList = this._getCurrencylist,
  showJump = this._getShowjump,
  _desc = this._get_desc
}
return this
