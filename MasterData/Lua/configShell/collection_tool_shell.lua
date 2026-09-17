local this = class("collection_tool_shell", G_BaseConfig)
local core = G_Tables.TDCollectionToolTable.GetInstance()

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
  weaponId = 3,
  rarity = 4,
  desc = 5,
  specialDesc = 6,
  icon = 7,
  damage = 8,
  dropRate = 9,
  endurance = 10,
  enduranceCost = 11,
  technologyExp = 12,
  tag = 13,
  way = 14,
  wayDesc = 15
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("collection_tool", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getWeaponid(offset)
  return core:GetInt(offset, this.indexMap.weaponId)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("collection_tool", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getSpecialdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("collection_tool", core:GetVString(offset, this.indexMap.specialDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "specialDesc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDamage(offset)
  return core:GetInt(offset, this.indexMap.damage)
end

function this:_getDroprate(offset)
  return core:GetInt(offset, this.indexMap.dropRate)
end

function this:_getEndurance(offset)
  return core:GetInt(offset, this.indexMap.endurance)
end

function this:_getEndurancecost(offset)
  return core:GetInt(offset, this.indexMap.enduranceCost)
end

function this:_getTechnologyexp(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getTag(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("collection_tool", core:GetVString(offset, this.indexMap.tag))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "collection_tool")
end

function this:_getWay(offset)
  local str = core:GetVString(offset, this.indexMap.way).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWaydesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("collection_tool", core:GetVString(offset, this.indexMap.wayDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "collection_tool")
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  name = this._getName,
  weaponId = this._getWeaponid,
  rarity = this._getRarity,
  desc = this._getDesc,
  specialDesc = this._getSpecialdesc,
  icon = this._getIcon,
  damage = this._getDamage,
  dropRate = this._getDroprate,
  endurance = this._getEndurance,
  enduranceCost = this._getEndurancecost,
  technologyExp = this._getTechnologyexp,
  tag = this._getTag,
  way = this._getWay,
  wayDesc = this._getWaydesc
}
return this
