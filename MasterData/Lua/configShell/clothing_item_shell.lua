local this = class("clothing_item_shell", G_BaseConfig)
local core = G_Tables.TDClothingItemTable.GetInstance()

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
  typeId = 1,
  TypeDesc = 2,
  order = 3,
  point = 4,
  hideHead = 5,
  rarity = 6,
  pointPosOffSetM = 7,
  pointrotationOffSetM = 8,
  pointScaleM = 9,
  resPathM = 10,
  weaponAvatarM = 11,
  timelineWeaponM = 12,
  clothingAvatarM = 13,
  clothingHairM = 14,
  nameM = 15,
  clothingAstM = 16,
  funcDescM = 17,
  DescM = 18,
  iconM = 19,
  previewM = 20,
  maleColor = 21,
  nestCoopTeamM = 22,
  nestCoopTeamActionM = 23,
  pointPosOffSetF = 24,
  pointrotationOffSetF = 25,
  pointScaleF = 26,
  resPathF = 27,
  stocks = 28,
  weaponAvatarF = 29,
  timelineWeaponF = 30,
  clothingAvatarF = 31,
  clothingHairF = 32,
  nameF = 33,
  clothingAstF = 34,
  funcDescF = 35,
  DescF = 36,
  iconF = 37,
  previewF = 38,
  femaleColor = 39,
  nestCoopTeamF = 40,
  nestCoopTeamActionF = 41,
  teamPic = 42,
  way = 43,
  clothingGetBg = 44,
  wayDesc = 45,
  occupy = 46
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getTypeid(offset)
  return core:GetInt(offset, this.indexMap.typeId)
end

function this:_getTypedesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("clothing_item", core:GetVString(offset, this.indexMap.TypeDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "TypeDesc")
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getPoint(offset)
  return core:GetVString(offset, this.indexMap.point).value
end

function this:_getHidehead(offset)
  return core:GetBool(offset, this.indexMap.hideHead)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getPointposoffsetm(offset)
  local str = core:GetVString(offset, this.indexMap.pointPosOffSetM).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPointrotationoffsetm(offset)
  local str = core:GetVString(offset, this.indexMap.pointrotationOffSetM).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPointscalem(offset)
  local str = core:GetVString(offset, this.indexMap.pointScaleM).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRespathm(offset)
  return core:GetVString(offset, this.indexMap.resPathM).value
end

function this:_getWeaponavatarm(offset)
  local str = core:GetVString(offset, this.indexMap.weaponAvatarM).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getTimelineweaponm(offset)
  return core:GetVString(offset, this.indexMap.timelineWeaponM).value
end

function this:_getClothingavatarm(offset)
  return core:GetVString(offset, this.indexMap.clothingAvatarM).value
end

function this:_getClothinghairm(offset)
  return core:GetVString(offset, this.indexMap.clothingHairM).value
end

function this:_getNamem(offset)
  local langStr = G_TableMgrIns:GetLangStr("clothing_item", core:GetVString(offset, this.indexMap.nameM))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "nameM")
end

function this:_getClothingastm(offset)
  local str = core:GetVString(offset, this.indexMap.clothingAstM).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "string")
end

function this:_getFuncdescm(offset)
  local langStr = G_TableMgrIns:GetLangStr("clothing_item", core:GetVString(offset, this.indexMap.funcDescM))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "funcDescM")
end

function this:_getDescm(offset)
  local langStr = G_TableMgrIns:GetLangStr("clothing_item", core:GetVString(offset, this.indexMap.DescM))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "DescM")
end

function this:_getIconm(offset)
  local str = core:GetVString(offset, this.indexMap.iconM).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPreviewm(offset)
  local str = core:GetVString(offset, this.indexMap.previewM).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getMalecolor(offset)
  local str = core:GetVString(offset, this.indexMap.maleColor).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNestcoopteamm(offset)
  local str = core:GetVString(offset, this.indexMap.nestCoopTeamM).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getNestcoopteamactionm(offset)
  return core:GetVString(offset, this.indexMap.nestCoopTeamActionM).value
end

function this:_getPointposoffsetf(offset)
  local str = core:GetVString(offset, this.indexMap.pointPosOffSetF).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPointrotationoffsetf(offset)
  local str = core:GetVString(offset, this.indexMap.pointrotationOffSetF).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPointscalef(offset)
  local str = core:GetVString(offset, this.indexMap.pointScaleF).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRespathf(offset)
  return core:GetVString(offset, this.indexMap.resPathF).value
end

function this:_getStocks(offset)
  return core:GetBool(offset, this.indexMap.stocks)
end

function this:_getWeaponavatarf(offset)
  local str = core:GetVString(offset, this.indexMap.weaponAvatarF).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getTimelineweaponf(offset)
  return core:GetVString(offset, this.indexMap.timelineWeaponF).value
end

function this:_getClothingavatarf(offset)
  return core:GetVString(offset, this.indexMap.clothingAvatarF).value
end

function this:_getClothinghairf(offset)
  return core:GetVString(offset, this.indexMap.clothingHairF).value
end

function this:_getNamef(offset)
  local langStr = G_TableMgrIns:GetLangStr("clothing_item", core:GetVString(offset, this.indexMap.nameF))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "nameF")
end

function this:_getClothingastf(offset)
  local str = core:GetVString(offset, this.indexMap.clothingAstF).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "string")
end

function this:_getFuncdescf(offset)
  local langStr = G_TableMgrIns:GetLangStr("clothing_item", core:GetVString(offset, this.indexMap.funcDescF))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "funcDescF")
end

function this:_getDescf(offset)
  local langStr = G_TableMgrIns:GetLangStr("clothing_item", core:GetVString(offset, this.indexMap.DescF))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "DescF")
end

function this:_getIconf(offset)
  local str = core:GetVString(offset, this.indexMap.iconF).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPreviewf(offset)
  local str = core:GetVString(offset, this.indexMap.previewF).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getFemalecolor(offset)
  local str = core:GetVString(offset, this.indexMap.femaleColor).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNestcoopteamf(offset)
  local str = core:GetVString(offset, this.indexMap.nestCoopTeamF).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getNestcoopteamactionf(offset)
  return core:GetVString(offset, this.indexMap.nestCoopTeamActionF).value
end

function this:_getTeampic(offset)
  local str = core:GetVString(offset, this.indexMap.teamPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getWay(offset)
  local str = core:GetVString(offset, this.indexMap.way).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getClothinggetbg(offset)
  local str = core:GetVString(offset, this.indexMap.clothingGetBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getWaydesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("clothing_item", core:GetVString(offset, this.indexMap.wayDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "clothing_item")
end

function this:_getOccupy(offset)
  local str = core:GetVString(offset, this.indexMap.occupy).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  typeId = this._getTypeid,
  TypeDesc = this._getTypedesc,
  order = this._getOrder,
  point = this._getPoint,
  hideHead = this._getHidehead,
  rarity = this._getRarity,
  pointPosOffSetM = this._getPointposoffsetm,
  pointrotationOffSetM = this._getPointrotationoffsetm,
  pointScaleM = this._getPointscalem,
  resPathM = this._getRespathm,
  weaponAvatarM = this._getWeaponavatarm,
  timelineWeaponM = this._getTimelineweaponm,
  clothingAvatarM = this._getClothingavatarm,
  clothingHairM = this._getClothinghairm,
  nameM = this._getNamem,
  clothingAstM = this._getClothingastm,
  funcDescM = this._getFuncdescm,
  DescM = this._getDescm,
  iconM = this._getIconm,
  previewM = this._getPreviewm,
  maleColor = this._getMalecolor,
  nestCoopTeamM = this._getNestcoopteamm,
  nestCoopTeamActionM = this._getNestcoopteamactionm,
  pointPosOffSetF = this._getPointposoffsetf,
  pointrotationOffSetF = this._getPointrotationoffsetf,
  pointScaleF = this._getPointscalef,
  resPathF = this._getRespathf,
  stocks = this._getStocks,
  weaponAvatarF = this._getWeaponavatarf,
  timelineWeaponF = this._getTimelineweaponf,
  clothingAvatarF = this._getClothingavatarf,
  clothingHairF = this._getClothinghairf,
  nameF = this._getNamef,
  clothingAstF = this._getClothingastf,
  funcDescF = this._getFuncdescf,
  DescF = this._getDescf,
  iconF = this._getIconf,
  previewF = this._getPreviewf,
  femaleColor = this._getFemalecolor,
  nestCoopTeamF = this._getNestcoopteamf,
  nestCoopTeamActionF = this._getNestcoopteamactionf,
  teamPic = this._getTeampic,
  way = this._getWay,
  clothingGetBg = this._getClothinggetbg,
  wayDesc = this._getWaydesc,
  occupy = this._getOccupy
}
return this
