local this = class("smelt_return_shell", G_BaseConfig)
local core = G_Tables.TDSmeltReturnTable.GetInstance()

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
  itemId = 2,
  homeCoinNumber = 3,
  homeCoindumpNumber = 4,
  smeltCoinNumber = 5,
  dustNumber = 6
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getItemid(offset)
  return core:GetInt(offset, this.indexMap.itemId)
end

function this:_getHomecoinnumber(offset)
  local str = core:GetVString(offset, this.indexMap.homeCoinNumber).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getHomecoindumpnumber(offset)
  local str = core:GetVString(offset, this.indexMap.homeCoindumpNumber).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSmeltcoinnumber(offset)
  local str = core:GetVString(offset, this.indexMap.smeltCoinNumber).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDustnumber(offset)
  local str = core:GetVString(offset, this.indexMap.dustNumber).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  itemId = this._getItemid,
  homeCoinNumber = this._getHomecoinnumber,
  homeCoindumpNumber = this._getHomecoindumpnumber,
  smeltCoinNumber = this._getSmeltcoinnumber,
  dustNumber = this._getDustnumber
}
return this
