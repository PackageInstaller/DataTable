local this = class("home_seeds_shell", G_BaseConfig)
local core = G_Tables.TDHomeSeedsTable.GetInstance()

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
  fieldType = 1,
  cropType = 2,
  cropName = 3,
  cropStar = 4,
  nextLevelSeedId = 5,
  cropID = 6,
  cropUnlockCondition = 7,
  upgradeCondition = 8,
  harvestType = 9,
  numShow = 10,
  dropType = 11,
  corpUpgrade = 12,
  homeDropId = 13,
  homeDropId_exp = 14,
  upgrade = 15,
  harvestUpgrade = 16,
  harvestSurprise = 17,
  harvestSurprise_exp = 18,
  cancelWithdraw = 19,
  homeDropSeedId = 20,
  homeDropNextSeedId = 21,
  needWater = 22,
  needWaterCycle = 23,
  technologyExpSow = 24,
  technologyExp = 25,
  dropPath = 26,
  dropOffset = 27,
  homeItemSize = 28,
  seedParam = 29,
  growParam = 30,
  preHarvestParam = 31,
  harvestParam = 32,
  goldHarvestParam = 33
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getFieldtype(offset)
  local str = core:GetVString(offset, this.indexMap.fieldType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCroptype(offset)
  return core:GetInt(offset, this.indexMap.cropType)
end

function this:_getCropname(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_seeds", core:GetVString(offset, this.indexMap.cropName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "cropName")
end

function this:_getCropstar(offset)
  return core:GetInt(offset, this.indexMap.cropStar)
end

function this:_getNextlevelseedid(offset)
  return core:GetInt(offset, this.indexMap.nextLevelSeedId)
end

function this:_getCropid(offset)
  return core:GetInt(offset, this.indexMap.cropID)
end

function this:_getCropunlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.cropUnlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getUpgradecondition(offset)
  local str = core:GetVString(offset, this.indexMap.upgradeCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getHarvesttype(offset)
  return core:GetInt(offset, this.indexMap.harvestType)
end

function this:_getNumshow(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_seeds", core:GetVString(offset, this.indexMap.numShow))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "numShow")
end

function this:_getDroptype(offset)
  return core:GetInt(offset, this.indexMap.dropType)
end

function this:_getCorpupgrade(offset)
  local str = core:GetVString(offset, this.indexMap.corpUpgrade).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHomedropid(offset)
  local str = core:GetVString(offset, this.indexMap.homeDropId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHomedropid_exp(offset)
  return core:GetInt(offset, this.indexMap.homeDropId_exp)
end

function this:_getUpgrade(offset)
  local str = core:GetVString(offset, this.indexMap.upgrade).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHarvestupgrade(offset)
  local str = core:GetVString(offset, this.indexMap.harvestUpgrade).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHarvestsurprise(offset)
  local str = core:GetVString(offset, this.indexMap.harvestSurprise).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHarvestsurprise_exp(offset)
  return core:GetInt(offset, this.indexMap.harvestSurprise_exp)
end

function this:_getCancelwithdraw(offset)
  local str = core:GetVString(offset, this.indexMap.cancelWithdraw).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getHomedropseedid(offset)
  local str = core:GetVString(offset, this.indexMap.homeDropSeedId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHomedropnextseedid(offset)
  local str = core:GetVString(offset, this.indexMap.homeDropNextSeedId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNeedwater(offset)
  return core:GetInt(offset, this.indexMap.needWater)
end

function this:_getNeedwatercycle(offset)
  local str = core:GetVString(offset, this.indexMap.needWaterCycle).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getTechnologyexpsow(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExpSow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getTechnologyexp(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getDroppath(offset)
  local str = core:GetVString(offset, this.indexMap.dropPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDropoffset(offset)
  local str = core:GetVString(offset, this.indexMap.dropOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getHomeitemsize(offset)
  local str = core:GetVString(offset, this.indexMap.homeItemSize).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSeedparam(offset)
  return core:GetInt(offset, this.indexMap.seedParam)
end

function this:_getGrowparam(offset)
  local str = core:GetVString(offset, this.indexMap.growParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPreharvestparam(offset)
  local str = core:GetVString(offset, this.indexMap.preHarvestParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHarvestparam(offset)
  return core:GetInt(offset, this.indexMap.harvestParam)
end

function this:_getGoldharvestparam(offset)
  return core:GetInt(offset, this.indexMap.goldHarvestParam)
end

this.keyToMethodsMap = {
  id = this._getId,
  fieldType = this._getFieldtype,
  cropType = this._getCroptype,
  cropName = this._getCropname,
  cropStar = this._getCropstar,
  nextLevelSeedId = this._getNextlevelseedid,
  cropID = this._getCropid,
  cropUnlockCondition = this._getCropunlockcondition,
  upgradeCondition = this._getUpgradecondition,
  harvestType = this._getHarvesttype,
  numShow = this._getNumshow,
  dropType = this._getDroptype,
  corpUpgrade = this._getCorpupgrade,
  homeDropId = this._getHomedropid,
  homeDropId_exp = this._getHomedropid_exp,
  upgrade = this._getUpgrade,
  harvestUpgrade = this._getHarvestupgrade,
  harvestSurprise = this._getHarvestsurprise,
  harvestSurprise_exp = this._getHarvestsurprise_exp,
  cancelWithdraw = this._getCancelwithdraw,
  homeDropSeedId = this._getHomedropseedid,
  homeDropNextSeedId = this._getHomedropnextseedid,
  needWater = this._getNeedwater,
  needWaterCycle = this._getNeedwatercycle,
  technologyExpSow = this._getTechnologyexpsow,
  technologyExp = this._getTechnologyexp,
  dropPath = this._getDroppath,
  dropOffset = this._getDropoffset,
  homeItemSize = this._getHomeitemsize,
  seedParam = this._getSeedparam,
  growParam = this._getGrowparam,
  preHarvestParam = this._getPreharvestparam,
  harvestParam = this._getHarvestparam,
  goldHarvestParam = this._getGoldharvestparam
}
return this
