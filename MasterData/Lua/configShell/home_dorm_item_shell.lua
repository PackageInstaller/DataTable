local this = class("home_dorm_item_shell", G_BaseConfig)
local core = G_Tables.TDHomeDormItemTable.GetInstance()

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
  heroId = 1,
  name = 2,
  icon = 3,
  itemDesc = 4,
  rarity = 5,
  tag = 6,
  skinBuyWay = 7,
  dormItemGetBg = 8
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_dorm_item", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getItemdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_dorm_item", core:GetVString(offset, this.indexMap.itemDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "itemDesc")
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getTag(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_dorm_item", core:GetVString(offset, this.indexMap.tag))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_dorm_item")
end

function this:_getSkinbuyway(offset)
  return core:GetInt(offset, this.indexMap.skinBuyWay)
end

function this:_getDormitemgetbg(offset)
  local str = core:GetVString(offset, this.indexMap.dormItemGetBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  id = this._getId,
  heroId = this._getHeroid,
  name = this._getName,
  icon = this._getIcon,
  itemDesc = this._getItemdesc,
  rarity = this._getRarity,
  tag = this._getTag,
  skinBuyWay = this._getSkinbuyway,
  dormItemGetBg = this._getDormitemgetbg
}
return this
