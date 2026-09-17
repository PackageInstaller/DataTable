local this = class("home_labor_type_shell", G_BaseConfig)
local core = G_Tables.TDHomeLaborTypeTable.GetInstance()

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
  icon = 2,
  desc = 3,
  descDetail = 4,
  laborParameter = 5,
  homeBuffId = 6,
  parameter = 7,
  buff_parameter = 8,
  buildingIconPetSize4 = 9,
  buildingNamePetSize4 = 10,
  buildingIconPetSize3 = 11,
  buildingNamePetSize3 = 12,
  buildingIconPetSize2 = 13,
  buildingNamePetSize2 = 14,
  buildingIconPetSize1 = 15,
  buildingNamePetSize1 = 16,
  homeBuffTitle = 17,
  homeBuffIcon = 18,
  homeBuffSimpleText = 19,
  homeBuffSimpleIcon = 20
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_labor_type", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_labor_type", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_labor_type")
end

function this:_getDescdetail(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_labor_type", core:GetVString(offset, this.indexMap.descDetail))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_labor_type")
end

function this:_getLaborparameter(offset)
  local str = core:GetVString(offset, this.indexMap.laborParameter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getHomebuffid(offset)
  local str = core:GetVString(offset, this.indexMap.homeBuffId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getParameter(offset)
  return core:GetInt(offset, this.indexMap.parameter)
end

function this:_getBuff_parameter(offset)
  local str = core:GetVString(offset, this.indexMap.buff_parameter).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBuildingiconpetsize4(offset)
  local str = core:GetVString(offset, this.indexMap.buildingIconPetSize4).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getBuildingnamepetsize4(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_labor_type", core:GetVString(offset, this.indexMap.buildingNamePetSize4))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_labor_type")
end

function this:_getBuildingiconpetsize3(offset)
  local str = core:GetVString(offset, this.indexMap.buildingIconPetSize3).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getBuildingnamepetsize3(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_labor_type", core:GetVString(offset, this.indexMap.buildingNamePetSize3))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_labor_type")
end

function this:_getBuildingiconpetsize2(offset)
  local str = core:GetVString(offset, this.indexMap.buildingIconPetSize2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getBuildingnamepetsize2(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_labor_type", core:GetVString(offset, this.indexMap.buildingNamePetSize2))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_labor_type")
end

function this:_getBuildingiconpetsize1(offset)
  local str = core:GetVString(offset, this.indexMap.buildingIconPetSize1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getBuildingnamepetsize1(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_labor_type", core:GetVString(offset, this.indexMap.buildingNamePetSize1))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_labor_type")
end

function this:_getHomebufftitle(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_labor_type", core:GetVString(offset, this.indexMap.homeBuffTitle))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_labor_type")
end

function this:_getHomebufficon(offset)
  local str = core:GetVString(offset, this.indexMap.homeBuffIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getHomebuffsimpletext(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_labor_type", core:GetVString(offset, this.indexMap.homeBuffSimpleText))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_labor_type")
end

function this:_getHomebuffsimpleicon(offset)
  local str = core:GetVString(offset, this.indexMap.homeBuffSimpleIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "string")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  icon = this._getIcon,
  desc = this._getDesc,
  descDetail = this._getDescdetail,
  laborParameter = this._getLaborparameter,
  homeBuffId = this._getHomebuffid,
  parameter = this._getParameter,
  buff_parameter = this._getBuff_parameter,
  buildingIconPetSize4 = this._getBuildingiconpetsize4,
  buildingNamePetSize4 = this._getBuildingnamepetsize4,
  buildingIconPetSize3 = this._getBuildingiconpetsize3,
  buildingNamePetSize3 = this._getBuildingnamepetsize3,
  buildingIconPetSize2 = this._getBuildingiconpetsize2,
  buildingNamePetSize2 = this._getBuildingnamepetsize2,
  buildingIconPetSize1 = this._getBuildingiconpetsize1,
  buildingNamePetSize1 = this._getBuildingnamepetsize1,
  homeBuffTitle = this._getHomebufftitle,
  homeBuffIcon = this._getHomebufficon,
  homeBuffSimpleText = this._getHomebuffsimpletext,
  homeBuffSimpleIcon = this._getHomebuffsimpleicon
}
return this
