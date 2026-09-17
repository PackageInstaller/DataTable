local this = class("player_title_shell", G_BaseConfig)
local core = G_Tables.TDPlayerTitleTable.GetInstance()

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
  special = 2,
  name = 3,
  desc = 4,
  icon = 5,
  rarity = 6,
  itemName = 7,
  itemDesc = 8,
  specialDesc = 9,
  itemIcon = 10,
  itemRarity = 11,
  way = 12,
  wayDesc = 13
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getType(offset)
  return core:GetInt(offset, this.indexMap.type)
end

function this:_getSpecial(offset)
  return core:GetInt(offset, this.indexMap.special)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("player_title", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("player_title", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getItemname(offset)
  local langStr = G_TableMgrIns:GetLangStr("player_title", core:GetVString(offset, this.indexMap.itemName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "itemName")
end

function this:_getItemdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("player_title", core:GetVString(offset, this.indexMap.itemDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "itemDesc")
end

function this:_getSpecialdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("player_title", core:GetVString(offset, this.indexMap.specialDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "specialDesc")
end

function this:_getItemicon(offset)
  local str = core:GetVString(offset, this.indexMap.itemIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getItemrarity(offset)
  return core:GetInt(offset, this.indexMap.itemRarity)
end

function this:_getWay(offset)
  local str = core:GetVString(offset, this.indexMap.way).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWaydesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("player_title", core:GetVString(offset, this.indexMap.wayDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "player_title")
end

this.keyToMethodsMap = {
  id = this._getId,
  type = this._getType,
  special = this._getSpecial,
  name = this._getName,
  desc = this._getDesc,
  icon = this._getIcon,
  rarity = this._getRarity,
  itemName = this._getItemname,
  itemDesc = this._getItemdesc,
  specialDesc = this._getSpecialdesc,
  itemIcon = this._getItemicon,
  itemRarity = this._getItemrarity,
  way = this._getWay,
  wayDesc = this._getWaydesc
}
return this
