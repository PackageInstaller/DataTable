local this = class("game_activity_currency_shell", G_BaseConfig)
local core = G_Tables.TDGameActivityCurrencyTable.GetInstance()

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
  _note = 2,
  desc = 3,
  specialDesc = 4,
  icon = 5,
  iconSmall = 6,
  quality = 7,
  way1 = 8,
  way1desc = 9,
  way2 = 10,
  way2desc = 11,
  way3 = 12,
  way3desc = 13,
  maxNum = 14,
  isclear = 15
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_activity_currency", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_get_note(offset)
  return core:GetVString(offset, this.indexMap._note).value
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_activity_currency", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getSpecialdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_activity_currency", core:GetVString(offset, this.indexMap.specialDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "specialDesc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIconsmall(offset)
  local str = core:GetVString(offset, this.indexMap.iconSmall).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getQuality(offset)
  return core:GetInt(offset, this.indexMap.quality)
end

function this:_getWay1(offset)
  return core:GetInt(offset, this.indexMap.way1)
end

function this:_getWay1desc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_activity_currency", core:GetVString(offset, this.indexMap.way1desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "way1desc")
end

function this:_getWay2(offset)
  return core:GetInt(offset, this.indexMap.way2)
end

function this:_getWay2desc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_activity_currency", core:GetVString(offset, this.indexMap.way2desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "way2desc")
end

function this:_getWay3(offset)
  return core:GetInt(offset, this.indexMap.way3)
end

function this:_getWay3desc(offset)
  local langStr = G_TableMgrIns:GetLangStr("game_activity_currency", core:GetVString(offset, this.indexMap.way3desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "way3desc")
end

function this:_getMaxnum(offset)
  return core:GetInt(offset, this.indexMap.maxNum)
end

function this:_getIsclear(offset)
  return core:GetInt(offset, this.indexMap.isclear)
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  _note = this._get_note,
  desc = this._getDesc,
  specialDesc = this._getSpecialdesc,
  icon = this._getIcon,
  iconSmall = this._getIconsmall,
  quality = this._getQuality,
  way1 = this._getWay1,
  way1desc = this._getWay1desc,
  way2 = this._getWay2,
  way2desc = this._getWay2desc,
  way3 = this._getWay3,
  way3desc = this._getWay3desc,
  maxNum = this._getMaxnum,
  isclear = this._getIsclear
}
return this
