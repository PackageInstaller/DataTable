local this = class("products_collection_shell", G_BaseConfig)
local core = G_Tables.TDProductsCollectionTable.GetInstance()

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
  dropShow = 1,
  dropUnlockLevelShow = 2,
  homeDropId = 3,
  dropType = 4,
  rareDropTime = 5,
  satietyScore = 6,
  technologyExp = 7,
  name = 8,
  icon = 9,
  rewardId = 10,
  needLabor = 11,
  isNeedMaster = 12
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getDropshow(offset)
  local str = core:GetVString(offset, this.indexMap.dropShow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDropunlocklevelshow(offset)
  return core:GetInt(offset, this.indexMap.dropUnlockLevelShow)
end

function this:_getHomedropid(offset)
  return core:GetInt(offset, this.indexMap.homeDropId)
end

function this:_getDroptype(offset)
  return core:GetInt(offset, this.indexMap.dropType)
end

function this:_getRaredroptime(offset)
  return core:GetInt(offset, this.indexMap.rareDropTime)
end

function this:_getSatietyscore(offset)
  return core:GetInt(offset, this.indexMap.satietyScore)
end

function this:_getTechnologyexp(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("products_collection", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRewardid(offset)
  local str = core:GetVString(offset, this.indexMap.rewardId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getNeedlabor(offset)
  return core:GetInt(offset, this.indexMap.needLabor)
end

function this:_getIsneedmaster(offset)
  return core:GetBool(offset, this.indexMap.isNeedMaster)
end

this.keyToMethodsMap = {
  id = this._getId,
  dropShow = this._getDropshow,
  dropUnlockLevelShow = this._getDropunlocklevelshow,
  homeDropId = this._getHomedropid,
  dropType = this._getDroptype,
  rareDropTime = this._getRaredroptime,
  satietyScore = this._getSatietyscore,
  technologyExp = this._getTechnologyexp,
  name = this._getName,
  icon = this._getIcon,
  rewardId = this._getRewardid,
  needLabor = this._getNeedlabor,
  isNeedMaster = this._getIsneedmaster
}
return this
