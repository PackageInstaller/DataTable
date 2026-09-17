local this = class("hero_clothing_shell", G_BaseConfig)
local core = G_Tables.TDHeroClothingTable.GetInstance()

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
  clothingid = 0,
  hero = 1,
  order = 2,
  battleInfo = 3,
  rank = 4,
  isUnlock = 5,
  name = 6,
  funcDesc = 7,
  Desc = 8,
  icon = 9,
  rarity = 10,
  way = 11,
  wayDesc = 12,
  preview = 13,
  illustration = 14,
  illustrationSpine = 15,
  recommendST = 16,
  recommendET = 17,
  unitId = 18,
  avatarTexture = 19,
  weaponDefault = 20,
  weaponSlots = 21,
  uiperform = 22,
  uibackground = 23,
  uibackgroundColor = 24,
  uibackgroundGift = 25,
  levelUpParam = 26,
  StarlinkParam = 27,
  shopGradeDesc = 28,
  shopGradeTitle = 29,
  shopGradeIcon = 30,
  shopGradeScenebgPic = 31,
  shopGradeotherDesc = 32,
  clothingGetBg = 33,
  videoCover = 34,
  clothingVideo = 35,
  gachaVideo = 36,
  gachaVideolength = 37,
  gachaSpine = 38,
  gachatext = 39,
  gachavoiceevent = 40,
  resourceoffset = 41
}

function this:_getClothingid(offset)
  return core:GetInt(offset, this.indexMap.clothingid)
end

function this:_getHero(offset)
  return core:GetInt(offset, this.indexMap.hero)
end

function this:_getOrder(offset)
  return core:GetInt(offset, this.indexMap.order)
end

function this:_getBattleinfo(offset)
  return core:GetInt(offset, this.indexMap.battleInfo)
end

function this:_getRank(offset)
  return core:GetInt(offset, this.indexMap.rank)
end

function this:_getIsunlock(offset)
  return core:GetInt(offset, this.indexMap.isUnlock)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_clothing", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getFuncdesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_clothing", core:GetVString(offset, this.indexMap.funcDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "funcDesc")
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_clothing", core:GetVString(offset, this.indexMap.Desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Desc")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getWay(offset)
  local str = core:GetVString(offset, this.indexMap.way).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getWaydesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("hero_clothing", core:GetVString(offset, this.indexMap.wayDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "hero_clothing")
end

function this:_getPreview(offset)
  local str = core:GetVString(offset, this.indexMap.preview).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIllustration(offset)
  local str = core:GetVString(offset, this.indexMap.illustration).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getIllustrationspine(offset)
  local str = core:GetVString(offset, this.indexMap.illustrationSpine).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getRecommendst(offset)
  return core:GetVString(offset, this.indexMap.recommendST).value
end

function this:_getRecommendet(offset)
  return core:GetVString(offset, this.indexMap.recommendET).value
end

function this:_getUnitid(offset)
  return core:GetInt(offset, this.indexMap.unitId)
end

function this:_getAvatartexture(offset)
  local str = core:GetVString(offset, this.indexMap.avatarTexture).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 12)
end

function this:_getWeapondefault(offset)
  return core:GetInt(offset, this.indexMap.weaponDefault)
end

function this:_getWeaponslots(offset)
  local str = core:GetVString(offset, this.indexMap.weaponSlots).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getUiperform(offset)
  local str = core:GetVString(offset, this.indexMap.uiperform).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getUibackground(offset)
  local str = core:GetVString(offset, this.indexMap.uibackground).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getUibackgroundcolor(offset)
  return core:GetVString(offset, this.indexMap.uibackgroundColor).value
end

function this:_getUibackgroundgift(offset)
  local str = core:GetVString(offset, this.indexMap.uibackgroundGift).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getLevelupparam(offset)
  local str = core:GetVString(offset, this.indexMap.levelUpParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getStarlinkparam(offset)
  local str = core:GetVString(offset, this.indexMap.StarlinkParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getShopgradedesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_clothing", core:GetVString(offset, this.indexMap.shopGradeDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "shopGradeDesc")
end

function this:_getShopgradetitle(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("hero_clothing", core:GetVString(offset, this.indexMap.shopGradeTitle))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "hero_clothing")
end

function this:_getShopgradeicon(offset)
  local str = core:GetVString(offset, this.indexMap.shopGradeIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getShopgradescenebgpic(offset)
  local str = core:GetVString(offset, this.indexMap.shopGradeScenebgPic).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getShopgradeotherdesc(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("hero_clothing", core:GetVString(offset, this.indexMap.shopGradeotherDesc))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "hero_clothing")
end

function this:_getClothinggetbg(offset)
  local str = core:GetVString(offset, this.indexMap.clothingGetBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getVideocover(offset)
  local str = core:GetVString(offset, this.indexMap.videoCover).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getClothingvideo(offset)
  local str = core:GetVString(offset, this.indexMap.clothingVideo).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getGachavideo(offset)
  local str = core:GetVString(offset, this.indexMap.gachaVideo).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getGachavideolength(offset)
  return core:GetInt(offset, this.indexMap.gachaVideolength)
end

function this:_getGachaspine(offset)
  local str = core:GetVString(offset, this.indexMap.gachaSpine).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getGachatext(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero_clothing", core:GetVString(offset, this.indexMap.gachatext))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "gachatext")
end

function this:_getGachavoiceevent(offset)
  return core:GetVString(offset, this.indexMap.gachavoiceevent).value
end

function this:_getResourceoffset(offset)
  local str = core:GetVString(offset, this.indexMap.resourceoffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

this.keyToMethodsMap = {
  clothingid = this._getClothingid,
  hero = this._getHero,
  order = this._getOrder,
  battleInfo = this._getBattleinfo,
  rank = this._getRank,
  isUnlock = this._getIsunlock,
  name = this._getName,
  funcDesc = this._getFuncdesc,
  Desc = this._getDesc,
  icon = this._getIcon,
  rarity = this._getRarity,
  way = this._getWay,
  wayDesc = this._getWaydesc,
  preview = this._getPreview,
  illustration = this._getIllustration,
  illustrationSpine = this._getIllustrationspine,
  recommendST = this._getRecommendst,
  recommendET = this._getRecommendet,
  unitId = this._getUnitid,
  avatarTexture = this._getAvatartexture,
  weaponDefault = this._getWeapondefault,
  weaponSlots = this._getWeaponslots,
  uiperform = this._getUiperform,
  uibackground = this._getUibackground,
  uibackgroundColor = this._getUibackgroundcolor,
  uibackgroundGift = this._getUibackgroundgift,
  levelUpParam = this._getLevelupparam,
  StarlinkParam = this._getStarlinkparam,
  shopGradeDesc = this._getShopgradedesc,
  shopGradeTitle = this._getShopgradetitle,
  shopGradeIcon = this._getShopgradeicon,
  shopGradeScenebgPic = this._getShopgradescenebgpic,
  shopGradeotherDesc = this._getShopgradeotherdesc,
  clothingGetBg = this._getClothinggetbg,
  videoCover = this._getVideocover,
  clothingVideo = this._getClothingvideo,
  gachaVideo = this._getGachavideo,
  gachaVideolength = this._getGachavideolength,
  gachaSpine = this._getGachaspine,
  gachatext = this._getGachatext,
  gachavoiceevent = this._getGachavoiceevent,
  resourceoffset = this._getResourceoffset
}
return this
