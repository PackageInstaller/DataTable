local this = class("home_ranch_shell", G_BaseConfig)
local core = G_Tables.TDHomeRanchTable.GetInstance()

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
  level = 0,
  upgradeCondition = 1,
  cost = 2,
  petLimit = 3,
  petProductLimit = 4,
  storageLimit = 5,
  upgradeDesc = 6
}

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getUpgradecondition(offset)
  local str = core:GetVString(offset, this.indexMap.upgradeCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getCost(offset)
  local str = core:GetVString(offset, this.indexMap.cost).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPetlimit(offset)
  return core:GetInt(offset, this.indexMap.petLimit)
end

function this:_getPetproductlimit(offset)
  return core:GetInt(offset, this.indexMap.petProductLimit)
end

function this:_getStoragelimit(offset)
  return core:GetInt(offset, this.indexMap.storageLimit)
end

function this:_getUpgradedesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_ranch", core:GetVString(offset, this.indexMap.upgradeDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_ranch")
end

this.keyToMethodsMap = {
  level = this._getLevel,
  upgradeCondition = this._getUpgradecondition,
  cost = this._getCost,
  petLimit = this._getPetlimit,
  petProductLimit = this._getPetproductlimit,
  storageLimit = this._getStoragelimit,
  upgradeDesc = this._getUpgradedesc
}
return this
