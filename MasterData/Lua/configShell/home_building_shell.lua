local this = class("home_building_shell", G_BaseConfig)
local core = G_Tables.TDHomeBuildingTable.GetInstance()

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
  groupId = 1,
  objId = 2,
  upgradeObjId = 3,
  level = 4,
  name = 5,
  frameTexture = 6,
  buildingPixelIcon = 7,
  desc = 8,
  desc_2 = 9,
  upgradeDesc = 10,
  upgradeCondition = 11,
  material = 12,
  time = 13,
  technologyExp = 14,
  nextLevel = 15,
  stackNum = 16,
  slotNumber = 17,
  trough = 18,
  isShowName = 19,
  dormCharacterNum = 20,
  dormPixelIconSmall = 21,
  dormPixelIconBig = 22,
  exp = 23,
  prosperity = 24,
  path = 25,
  param = 26,
  ouput = 27,
  elementalCurrencyLimitIncrease = 28,
  isPopout = 29,
  popoutSize = 30,
  dormAvatarPos = 31
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getGroupid(offset)
  return core:GetInt(offset, this.indexMap.groupId)
end

function this:_getObjid(offset)
  return core:GetInt(offset, this.indexMap.objId)
end

function this:_getUpgradeobjid(offset)
  return core:GetInt(offset, this.indexMap.upgradeObjId)
end

function this:_getLevel(offset)
  return core:GetInt(offset, this.indexMap.level)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_building", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getFrametexture(offset)
  return core:GetInt(offset, this.indexMap.frameTexture)
end

function this:_getBuildingpixelicon(offset)
  local str = core:GetVString(offset, this.indexMap.buildingPixelIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_building", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getDesc_2(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_building", core:GetVString(offset, this.indexMap.desc_2))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc_2")
end

function this:_getUpgradedesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_building", core:GetVString(offset, this.indexMap.upgradeDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_building")
end

function this:_getUpgradecondition(offset)
  local str = core:GetVString(offset, this.indexMap.upgradeCondition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.listCondition)
end

function this:_getMaterial(offset)
  local str = core:GetVString(offset, this.indexMap.material).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getTime(offset)
  return core:GetInt(offset, this.indexMap.time)
end

function this:_getTechnologyexp(offset)
  local str = core:GetVString(offset, this.indexMap.technologyExp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getNextlevel(offset)
  return core:GetInt(offset, this.indexMap.nextLevel)
end

function this:_getStacknum(offset)
  return core:GetInt(offset, this.indexMap.stackNum)
end

function this:_getSlotnumber(offset)
  return core:GetInt(offset, this.indexMap.slotNumber)
end

function this:_getTrough(offset)
  return core:GetInt(offset, this.indexMap.trough)
end

function this:_getIsshowname(offset)
  return core:GetBool(offset, this.indexMap.isShowName)
end

function this:_getDormcharacternum(offset)
  return core:GetInt(offset, this.indexMap.dormCharacterNum)
end

function this:_getDormpixeliconsmall(offset)
  local str = core:GetVString(offset, this.indexMap.dormPixelIconSmall).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getDormpixeliconbig(offset)
  local str = core:GetVString(offset, this.indexMap.dormPixelIconBig).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getExp(offset)
  return core:GetInt(offset, this.indexMap.exp)
end

function this:_getProsperity(offset)
  return core:GetInt(offset, this.indexMap.prosperity)
end

function this:_getPath(offset)
  return core:GetVString(offset, this.indexMap.path).value
end

function this:_getParam(offset)
  local str = core:GetVString(offset, this.indexMap.param).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "string")
end

function this:_getOuput(offset)
  return core:GetInt(offset, this.indexMap.ouput)
end

function this:_getElementalcurrencylimitincrease(offset)
  local str = core:GetVString(offset, this.indexMap.elementalCurrencyLimitIncrease).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getIspopout(offset)
  return core:GetBool(offset, this.indexMap.isPopout)
end

function this:_getPopoutsize(offset)
  local str = core:GetVString(offset, this.indexMap.popoutSize).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDormavatarpos(offset)
  local str = core:GetVString(offset, this.indexMap.dormAvatarPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  groupId = this._getGroupid,
  objId = this._getObjid,
  upgradeObjId = this._getUpgradeobjid,
  level = this._getLevel,
  name = this._getName,
  frameTexture = this._getFrametexture,
  buildingPixelIcon = this._getBuildingpixelicon,
  desc = this._getDesc,
  desc_2 = this._getDesc_2,
  upgradeDesc = this._getUpgradedesc,
  upgradeCondition = this._getUpgradecondition,
  material = this._getMaterial,
  time = this._getTime,
  technologyExp = this._getTechnologyexp,
  nextLevel = this._getNextlevel,
  stackNum = this._getStacknum,
  slotNumber = this._getSlotnumber,
  trough = this._getTrough,
  isShowName = this._getIsshowname,
  dormCharacterNum = this._getDormcharacternum,
  dormPixelIconSmall = this._getDormpixeliconsmall,
  dormPixelIconBig = this._getDormpixeliconbig,
  exp = this._getExp,
  prosperity = this._getProsperity,
  path = this._getPath,
  param = this._getParam,
  ouput = this._getOuput,
  elementalCurrencyLimitIncrease = this._getElementalcurrencylimitincrease,
  isPopout = this._getIspopout,
  popoutSize = this._getPopoutsize,
  dormAvatarPos = this._getDormavatarpos
}
return this
