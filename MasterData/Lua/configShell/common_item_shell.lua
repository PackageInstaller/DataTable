local this = class("common_item_shell", G_BaseConfig)
local core = G_Tables.TDCommonItemTable.GetInstance()

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
  name = 1,
  desc = 2,
  specialDesc = 3,
  icon = 4,
  filterIcon = 5,
  rarity = 6,
  itemGrade = 7,
  type = 8,
  showNum = 9,
  tag = 10,
  maxNum = 11,
  stackNum = 12,
  useType = 13,
  bagType = 14,
  subType = 15,
  giftBagReward = 16,
  useFunction = 17,
  subId = 18,
  rouletteType = 19,
  rouletteTab = 20,
  way = 21,
  wayDesc = 22,
  wayMaterialFill = 23,
  isQuickBar = 24
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("common_item", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("common_item", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getSpecialdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("common_item", core:GetVString(offset, this.indexMap.specialDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "specialDesc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getFiltericon(offset)
  local str = core:GetVString(offset, this.indexMap.filterIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getItemgrade(offset)
  return core:GetInt(offset, this.indexMap.itemGrade)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getShownum(offset)
  return core:GetInt(offset, this.indexMap.showNum)
end

function this:_getTag(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("common_item", core:GetVString(offset, this.indexMap.tag))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "common_item")
end

function this:_getMaxnum(offset)
  return core:GetInt(offset, this.indexMap.maxNum)
end

function this:_getStacknum(offset)
  return core:GetInt(offset, this.indexMap.stackNum)
end

function this:_getUsetype(offset)
  return core:GetInt(offset, this.indexMap.useType)
end

function this:_getBagtype(offset)
  return core:GetInt(offset, this.indexMap.bagType)
end

function this:_getSubtype(offset)
  return core:GetInt(offset, this.indexMap.subType)
end

function this:_getGiftbagreward(offset)
  local str = core:GetVString(offset, this.indexMap.giftBagReward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getUsefunction(offset)
  local str = core:GetVString(offset, this.indexMap.useFunction).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSubid(offset)
  return core:GetInt(offset, this.indexMap.subId)
end

function this:_getRoulettetype(offset)
  return core:GetInt(offset, this.indexMap.rouletteType)
end

function this:_getRoulettetab(offset)
  return core:GetInt(offset, this.indexMap.rouletteTab)
end

function this:_getWay(offset)
  local str = core:GetVString(offset, this.indexMap.way).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWaydesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("common_item", core:GetVString(offset, this.indexMap.wayDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "common_item")
end

function this:_getWaymaterialfill(offset)
  return core:GetInt(offset, this.indexMap.wayMaterialFill)
end

function this:_getIsquickbar(offset)
  return core:GetInt(offset, this.indexMap.isQuickBar)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  desc = this._getDesc,
  specialDesc = this._getSpecialdesc,
  icon = this._getIcon,
  filterIcon = this._getFiltericon,
  rarity = this._getRarity,
  itemGrade = this._getItemgrade,
  type = this._getType,
  showNum = this._getShownum,
  tag = this._getTag,
  maxNum = this._getMaxnum,
  stackNum = this._getStacknum,
  useType = this._getUsetype,
  bagType = this._getBagtype,
  subType = this._getSubtype,
  giftBagReward = this._getGiftbagreward,
  useFunction = this._getUsefunction,
  subId = this._getSubid,
  rouletteType = this._getRoulettetype,
  rouletteTab = this._getRoulettetab,
  way = this._getWay,
  wayDesc = this._getWaydesc,
  wayMaterialFill = this._getWaymaterialfill,
  isQuickBar = this._getIsquickbar
}
return this
