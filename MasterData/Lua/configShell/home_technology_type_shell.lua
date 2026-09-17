local this = class("home_technology_type_shell", G_BaseConfig)
local core = G_Tables.TDHomeTechnologyTypeTable.GetInstance()

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
  categroy = 0,
  technologyName = 1,
  english = 2,
  expUpperLimit = 3,
  expEfficiency = 4,
  technologyCurrencyId = 5,
  technologyCurrencyPageIcon = 6,
  technologyIcon = 7,
  typeBg = 8,
  nameBgColor = 9,
  lvBgColor = 10,
  iconBg = 11,
  lineColor = 12,
  tabBgColor = 13,
  studySuccessBg = 14,
  technologyExpBarIcon = 15
}

function this:_getCategroy(offset)
  return core:GetInt(offset, this.indexMap.categroy)
end

function this:_getTechnologyname(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_technology_type", core:GetVString(offset, this.indexMap.technologyName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "technologyName")
end

function this:_getEnglish(offset)
  return core:GetVString(offset, this.indexMap.english).value
end

function this:_getExpupperlimit(offset)
  return core:GetInt(offset, this.indexMap.expUpperLimit)
end

function this:_getExpefficiency(offset)
  local str = core:GetVString(offset, this.indexMap.expEfficiency).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTechnologycurrencyid(offset)
  return core:GetInt(offset, this.indexMap.technologyCurrencyId)
end

function this:_getTechnologycurrencypageicon(offset)
  local str = core:GetVString(offset, this.indexMap.technologyCurrencyPageIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTechnologyicon(offset)
  return core:GetInt(offset, this.indexMap.technologyIcon)
end

function this:_getTypebg(offset)
  local str = core:GetVString(offset, this.indexMap.typeBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getNamebgcolor(offset)
  return core:GetVString(offset, this.indexMap.nameBgColor).value
end

function this:_getLvbgcolor(offset)
  return core:GetVString(offset, this.indexMap.lvBgColor).value
end

function this:_getIconbg(offset)
  local str = core:GetVString(offset, this.indexMap.iconBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getLinecolor(offset)
  return core:GetVString(offset, this.indexMap.lineColor).value
end

function this:_getTabbgcolor(offset)
  return core:GetVString(offset, this.indexMap.tabBgColor).value
end

function this:_getStudysuccessbg(offset)
  local str = core:GetVString(offset, this.indexMap.studySuccessBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getTechnologyexpbaricon(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExpBarIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

this.keyToMethodsMap = {
  categroy = this._getCategroy,
  technologyName = this._getTechnologyname,
  english = this._getEnglish,
  expUpperLimit = this._getExpupperlimit,
  expEfficiency = this._getExpefficiency,
  technologyCurrencyId = this._getTechnologycurrencyid,
  technologyCurrencyPageIcon = this._getTechnologycurrencypageicon,
  technologyIcon = this._getTechnologyicon,
  typeBg = this._getTypebg,
  nameBgColor = this._getNamebgcolor,
  lvBgColor = this._getLvbgcolor,
  iconBg = this._getIconbg,
  lineColor = this._getLinecolor,
  tabBgColor = this._getTabbgcolor,
  studySuccessBg = this._getStudysuccessbg,
  technologyExpBarIcon = this._getTechnologyexpbaricon
}
return this
