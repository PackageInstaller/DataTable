local this = class("common_item_bag_type_shell", G_BaseConfig)
local core = G_Tables.TDCommonItemBagTypeTable.GetInstance()

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
  name = 2,
  show = 3,
  commonTabId = 4,
  unlockCondition = 5,
  subType = 6,
  sortFilter = 7,
  nameEn = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("common_item_bag_type", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getShow(offset)
  return core:GetInt(offset, this.indexMap.show)
end

function this:_getCommontabid(offset)
  return core:GetInt(offset, this.indexMap.commonTabId)
end

function this:_getUnlockcondition(offset)
  local str = core:GetVString(offset, this.indexMap.unlockCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSubtype(offset)
  local str = core:GetVString(offset, this.indexMap.subType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSortfilter(offset)
  return core:GetInt(offset, this.indexMap.sortFilter)
end

function this:_getNameen(offset)
  return core:GetVString(offset, this.indexMap.nameEn).value
end

this.keyToMethodsMap = {
  id = this._getId,
  order = this._getOrder,
  name = this._getName,
  show = this._getShow,
  commonTabId = this._getCommontabid,
  unlockCondition = this._getUnlockcondition,
  subType = this._getSubtype,
  sortFilter = this._getSortfilter,
  nameEn = this._getNameen
}
return this
