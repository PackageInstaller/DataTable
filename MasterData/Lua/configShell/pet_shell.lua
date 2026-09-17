local this = class("pet_shell", G_BaseConfig)
local core = G_Tables.TDPetTable.GetInstance()

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
  unitId = 2,
  element = 3,
  egg = 4,
  petrare = 5,
  race = 6,
  petStage = 7,
  isRename = 8,
  isRelease = 9,
  battleTag = 10,
  size = 11,
  desc = 12,
  petTalentDna = 13,
  unitRotationType = 14,
  houseType = 15,
  bodyType = 16,
  unitPositionGet = 17,
  unitRotationGet = 18,
  unitScale = 19,
  unitPosition = 20,
  unitCameraPosition = 21,
  starsoulId = 22,
  starsoulItem = 23,
  starsoulCamPosition = 24,
  starsoulCamRotation = 25,
  playercard_dress_pet = 26,
  playercard_dress_pet_1 = 27,
  petBattleIcon = 28,
  petIcon = 29,
  petIconSp = 30,
  petPixelIcon = 31,
  petPixelIconSp = 32,
  petPixelPosition = 33,
  kiboBoxCardIcon = 34,
  kiboBoxCardIconSp = 35,
  kiboCardIcon = 36,
  kiboCardIconSp = 37,
  petTalkIcon = 38,
  petTalkIconSp = 39,
  kiboMultiTeamHubCardIcon = 40,
  kiboMultiTeamHubCardFv = 41,
  kiboMultiTeamHubCardBg = 42,
  nameSp = 43,
  petPixelPositionSp = 44,
  gradeScoreSp = 45,
  petBattleIconSp = 46,
  petSpecial = 47,
  petSpecialWeight = 48,
  petColorParam = 49,
  petColorName = 50,
  attrRecommend = 51,
  AddDropId = 52,
  gradeScore = 53,
  IsCatch = 54,
  catchHP = 55,
  catchModulus = 56,
  catchRadianModulus = 57,
  growthAttribute = 58,
  baseAttribute = 59,
  dna = 60,
  dnaRecommend = 61,
  isMutation = 62,
  isBattle = 63,
  petStayType = 64,
  stayTime = 65,
  behaviorType = 66,
  signatureSkillList = 67,
  blinkSkillList = 68,
  skillListCount = 69,
  skillList = 70,
  rPropertyskillCount = 71,
  rPropertyskillList = 72,
  fPropertyskillList = 73,
  breakSkillList = 74,
  fixedSkillList = 75,
  mountSkill = 76,
  skillBytesPath = 77,
  propertyId = 78,
  collisionType = 79,
  kiboDuelTag = 80,
  kiboSkillList = 81,
  bPropertyskillList = 82,
  kiboBPropertyskillList = 83,
  aimRange = 84,
  kiboArenaBaseTemplateID = 85,
  cf = 86,
  kiboSetTime = 87,
  kiboType = 88,
  kiboAutoCastSkill = 89,
  kiboBaseAttribute = 90,
  feature = 91,
  petlongIcon = 92,
  puzzleType = 93,
  petPuzzleIcon = 94,
  speciesId = 95,
  worldProperty = 96,
  moveType = 97,
  defaultMoveType = 98,
  playercard_dress = 99,
  iconographyNum = 100,
  iconographyNumSuffix = 101,
  iconographyshow = 102,
  iconographyTaskId = 103,
  iconographyUnitPosition = 104,
  iconographyDrop = 105,
  iconographyMapPos = 106,
  kiboDnaList = 107,
  noShadow = 108,
  petDailyRefreshProb = 109,
  petOnceRefreshProb = 110,
  petNestProb = 111,
  petFoundleEffect = 112,
  iconographyreportreward = 113,
  iconographyreporttimes = 114,
  iconographyreportnormalreward = 115
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getUnitid(offset)
  return core:GetInt(offset, this.indexMap.unitId)
end

function this:_getElement(offset)
  local str = core:GetVString(offset, this.indexMap.element).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getEgg(offset)
  return core:GetInt(offset, this.indexMap.egg)
end

function this:_getPetrare(offset)
  return core:GetInt(offset, this.indexMap.petrare)
end

function this:_getRace(offset)
  local str = core:GetVString(offset, this.indexMap.race).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetstage(offset)
  return core:GetInt(offset, this.indexMap.petStage)
end

function this:_getIsrename(offset)
  return core:GetBool(offset, this.indexMap.isRename)
end

function this:_getIsrelease(offset)
  return core:GetBool(offset, this.indexMap.isRelease)
end

function this:_getBattletag(offset)
  local str = core:GetVString(offset, this.indexMap.battleTag).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSize(offset)
  return core:GetInt(offset, this.indexMap.size)
end

function this:_getDesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet", core:GetVString(offset, this.indexMap.desc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "desc")
end

function this:_getPettalentdna(offset)
  local str = core:GetVString(offset, this.indexMap.petTalentDna).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUnitrotationtype(offset)
  return core:GetInt(offset, this.indexMap.unitRotationType)
end

function this:_getHousetype(offset)
  return core:GetInt(offset, this.indexMap.houseType)
end

function this:_getBodytype(offset)
  return core:GetInt(offset, this.indexMap.bodyType)
end

function this:_getUnitpositionget(offset)
  local str = core:GetVString(offset, this.indexMap.unitPositionGet).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUnitrotationget(offset)
  local str = core:GetVString(offset, this.indexMap.unitRotationGet).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUnitscale(offset)
  return core:GetInt(offset, this.indexMap.unitScale)
end

function this:_getUnitposition(offset)
  local str = core:GetVString(offset, this.indexMap.unitPosition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUnitcameraposition(offset)
  local str = core:GetVString(offset, this.indexMap.unitCameraPosition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getStarsoulid(offset)
  return core:GetInt(offset, this.indexMap.starsoulId)
end

function this:_getStarsoulitem(offset)
  return core:GetInt(offset, this.indexMap.starsoulItem)
end

function this:_getStarsoulcamposition(offset)
  local str = core:GetVString(offset, this.indexMap.starsoulCamPosition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getStarsoulcamrotation(offset)
  local str = core:GetVString(offset, this.indexMap.starsoulCamRotation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPlayercard_dress_pet(offset)
  local str = core:GetVString(offset, this.indexMap.playercard_dress_pet).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPlayercard_dress_pet_1(offset)
  local str = core:GetVString(offset, this.indexMap.playercard_dress_pet_1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPetbattleicon(offset)
  local str = core:GetVString(offset, this.indexMap.petBattleIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getPeticon(offset)
  local str = core:GetVString(offset, this.indexMap.petIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPeticonsp(offset)
  local str = core:GetVString(offset, this.indexMap.petIconSp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getPetpixelicon(offset)
  local str = core:GetVString(offset, this.indexMap.petPixelIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPetpixeliconsp(offset)
  local str = core:GetVString(offset, this.indexMap.petPixelIconSp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getPetpixelposition(offset)
  local str = core:GetVString(offset, this.indexMap.petPixelPosition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getKiboboxcardicon(offset)
  local str = core:GetVString(offset, this.indexMap.kiboBoxCardIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 5)
end

function this:_getKiboboxcardiconsp(offset)
  local str = core:GetVString(offset, this.indexMap.kiboBoxCardIconSp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getKibocardicon(offset)
  local str = core:GetVString(offset, this.indexMap.kiboCardIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getKibocardiconsp(offset)
  local str = core:GetVString(offset, this.indexMap.kiboCardIconSp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getPettalkicon(offset)
  local str = core:GetVString(offset, this.indexMap.petTalkIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPettalkiconsp(offset)
  local str = core:GetVString(offset, this.indexMap.petTalkIconSp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getKibomultiteamhubcardicon(offset)
  local str = core:GetVString(offset, this.indexMap.kiboMultiTeamHubCardIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getKibomultiteamhubcardfv(offset)
  return core:GetVString(offset, this.indexMap.kiboMultiTeamHubCardFv).value
end

function this:_getKibomultiteamhubcardbg(offset)
  local str = core:GetVString(offset, this.indexMap.kiboMultiTeamHubCardBg).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getNamesp(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("pet", core:GetVString(offset, this.indexMap.nameSp))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "pet")
end

function this:_getPetpixelpositionsp(offset)
  local str = core:GetVString(offset, this.indexMap.petPixelPositionSp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getGradescoresp(offset)
  local str = core:GetVString(offset, this.indexMap.gradeScoreSp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetbattleiconsp(offset)
  local str = core:GetVString(offset, this.indexMap.petBattleIconSp).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getPetspecial(offset)
  local str = core:GetVString(offset, this.indexMap.petSpecial).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetspecialweight(offset)
  local str = core:GetVString(offset, this.indexMap.petSpecialWeight).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getPetcolorparam(offset)
  local str = core:GetVString(offset, this.indexMap.petColorParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getPetcolorname(offset)
  local langStr = G_TableMgrIns:GetLangStr("pet", core:GetVString(offset, this.indexMap.petColorName))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "petColorName")
end

function this:_getAttrrecommend(offset)
  local str = core:GetVString(offset, this.indexMap.attrRecommend).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getAdddropid(offset)
  local str = core:GetVString(offset, this.indexMap.AddDropId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getGradescore(offset)
  return core:GetInt(offset, this.indexMap.gradeScore)
end

function this:_getIscatch(offset)
  return core:GetBool(offset, this.indexMap.IsCatch)
end

function this:_getCatchhp(offset)
  return core:GetInt(offset, this.indexMap.catchHP)
end

function this:_getCatchmodulus(offset)
  return core:GetInt(offset, this.indexMap.catchModulus)
end

function this:_getCatchradianmodulus(offset)
  return core:GetInt(offset, this.indexMap.catchRadianModulus)
end

function this:_getGrowthattribute(offset)
  local str = core:GetVString(offset, this.indexMap.growthAttribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getBaseattribute(offset)
  local str = core:GetVString(offset, this.indexMap.baseAttribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getDna(offset)
  local str = core:GetVString(offset, this.indexMap.dna).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getDnarecommend(offset)
  local str = core:GetVString(offset, this.indexMap.dnaRecommend).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIsmutation(offset)
  return core:GetBool(offset, this.indexMap.isMutation)
end

function this:_getIsbattle(offset)
  return core:GetBool(offset, this.indexMap.isBattle)
end

function this:_getPetstaytype(offset)
  return core:GetInt(offset, this.indexMap.petStayType)
end

function this:_getStaytime(offset)
  return core:GetInt(offset, this.indexMap.stayTime)
end

function this:_getBehaviortype(offset)
  return core:GetInt(offset, this.indexMap.behaviorType)
end

function this:_getSignatureskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.signatureSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBlinkskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.blinkSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSkilllistcount(offset)
  return core:GetInt(offset, this.indexMap.skillListCount)
end

function this:_getSkilllist(offset)
  local str = core:GetVString(offset, this.indexMap.skillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getRpropertyskillcount(offset)
  return core:GetInt(offset, this.indexMap.rPropertyskillCount)
end

function this:_getRpropertyskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.rPropertyskillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getFpropertyskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.fPropertyskillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getBreakskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.breakSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getFixedskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.fixedSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getMountskill(offset)
  local str = core:GetVString(offset, this.indexMap.mountSkill).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getSkillbytespath(offset)
  local str = core:GetVString(offset, this.indexMap.skillBytesPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getPropertyid(offset)
  return core:GetInt(offset, this.indexMap.propertyId)
end

function this:_getCollisiontype(offset)
  return core:GetInt(offset, this.indexMap.collisionType)
end

function this:_getKibodueltag(offset)
  local str = core:GetVString(offset, this.indexMap.kiboDuelTag).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getKiboskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.kiboSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getBpropertyskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.bPropertyskillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getKibobpropertyskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.kiboBPropertyskillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getAimrange(offset)
  local str = core:GetVString(offset, this.indexMap.aimRange).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getKiboarenabasetemplateid(offset)
  return core:GetInt(offset, this.indexMap.kiboArenaBaseTemplateID)
end

function this:_getCf(offset)
  return core:GetVString(offset, this.indexMap.cf).value
end

function this:_getKibosettime(offset)
  return core:GetInt(offset, this.indexMap.kiboSetTime)
end

function this:_getKibotype(offset)
  return core:GetInt(offset, this.indexMap.kiboType)
end

function this:_getKiboautocastskill(offset)
  return core:GetBool(offset, this.indexMap.kiboAutoCastSkill)
end

function this:_getKibobaseattribute(offset)
  local str = core:GetVString(offset, this.indexMap.kiboBaseAttribute).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getFeature(offset)
  local str = core:GetVString(offset, this.indexMap.feature).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetlongicon(offset)
  local str = core:GetVString(offset, this.indexMap.petlongIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getPuzzletype(offset)
  local str = core:GetVString(offset, this.indexMap.puzzleType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPetpuzzleicon(offset)
  local str = core:GetVString(offset, this.indexMap.petPuzzleIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSpeciesid(offset)
  return core:GetInt(offset, this.indexMap.speciesId)
end

function this:_getWorldproperty(offset)
  local str = core:GetVString(offset, this.indexMap.worldProperty).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "string", "number")
end

function this:_getMovetype(offset)
  local str = core:GetVString(offset, this.indexMap.moveType).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDefaultmovetype(offset)
  return core:GetInt(offset, this.indexMap.defaultMoveType)
end

function this:_getPlayercard_dress(offset)
  local str = core:GetVString(offset, this.indexMap.playercard_dress).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getIconographynum(offset)
  return core:GetInt(offset, this.indexMap.iconographyNum)
end

function this:_getIconographynumsuffix(offset)
  return core:GetVString(offset, this.indexMap.iconographyNumSuffix).value
end

function this:_getIconographyshow(offset)
  return core:GetInt(offset, this.indexMap.iconographyshow)
end

function this:_getIconographytaskid(offset)
  local str = core:GetVString(offset, this.indexMap.iconographyTaskId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIconographyunitposition(offset)
  local str = core:GetVString(offset, this.indexMap.iconographyUnitPosition).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIconographydrop(offset)
  local str = core:GetVString(offset, this.indexMap.iconographyDrop).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getIconographymappos(offset)
  local str = core:GetVString(offset, this.indexMap.iconographyMapPos).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getKibodnalist(offset)
  local str = core:GetVString(offset, this.indexMap.kiboDnaList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNoshadow(offset)
  local str = core:GetVString(offset, this.indexMap.noShadow).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "string")
end

function this:_getPetdailyrefreshprob(offset)
  local str = core:GetVString(offset, this.indexMap.petDailyRefreshProb).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getPetoncerefreshprob(offset)
  local str = core:GetVString(offset, this.indexMap.petOnceRefreshProb).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getPetnestprob(offset)
  local str = core:GetVString(offset, this.indexMap.petNestProb).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getPetfoundleeffect(offset)
  return core:GetInt(offset, this.indexMap.petFoundleEffect)
end

function this:_getIconographyreportreward(offset)
  local str = core:GetVString(offset, this.indexMap.iconographyreportreward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getIconographyreporttimes(offset)
  return core:GetInt(offset, this.indexMap.iconographyreporttimes)
end

function this:_getIconographyreportnormalreward(offset)
  local str = core:GetVString(offset, this.indexMap.iconographyreportnormalreward).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  unitId = this._getUnitid,
  element = this._getElement,
  egg = this._getEgg,
  petrare = this._getPetrare,
  race = this._getRace,
  petStage = this._getPetstage,
  isRename = this._getIsrename,
  isRelease = this._getIsrelease,
  battleTag = this._getBattletag,
  size = this._getSize,
  desc = this._getDesc,
  petTalentDna = this._getPettalentdna,
  unitRotationType = this._getUnitrotationtype,
  houseType = this._getHousetype,
  bodyType = this._getBodytype,
  unitPositionGet = this._getUnitpositionget,
  unitRotationGet = this._getUnitrotationget,
  unitScale = this._getUnitscale,
  unitPosition = this._getUnitposition,
  unitCameraPosition = this._getUnitcameraposition,
  starsoulId = this._getStarsoulid,
  starsoulItem = this._getStarsoulitem,
  starsoulCamPosition = this._getStarsoulcamposition,
  starsoulCamRotation = this._getStarsoulcamrotation,
  playercard_dress_pet = this._getPlayercard_dress_pet,
  playercard_dress_pet_1 = this._getPlayercard_dress_pet_1,
  petBattleIcon = this._getPetbattleicon,
  petIcon = this._getPeticon,
  petIconSp = this._getPeticonsp,
  petPixelIcon = this._getPetpixelicon,
  petPixelIconSp = this._getPetpixeliconsp,
  petPixelPosition = this._getPetpixelposition,
  kiboBoxCardIcon = this._getKiboboxcardicon,
  kiboBoxCardIconSp = this._getKiboboxcardiconsp,
  kiboCardIcon = this._getKibocardicon,
  kiboCardIconSp = this._getKibocardiconsp,
  petTalkIcon = this._getPettalkicon,
  petTalkIconSp = this._getPettalkiconsp,
  kiboMultiTeamHubCardIcon = this._getKibomultiteamhubcardicon,
  kiboMultiTeamHubCardFv = this._getKibomultiteamhubcardfv,
  kiboMultiTeamHubCardBg = this._getKibomultiteamhubcardbg,
  nameSp = this._getNamesp,
  petPixelPositionSp = this._getPetpixelpositionsp,
  gradeScoreSp = this._getGradescoresp,
  petBattleIconSp = this._getPetbattleiconsp,
  petSpecial = this._getPetspecial,
  petSpecialWeight = this._getPetspecialweight,
  petColorParam = this._getPetcolorparam,
  petColorName = this._getPetcolorname,
  attrRecommend = this._getAttrrecommend,
  AddDropId = this._getAdddropid,
  gradeScore = this._getGradescore,
  IsCatch = this._getIscatch,
  catchHP = this._getCatchhp,
  catchModulus = this._getCatchmodulus,
  catchRadianModulus = this._getCatchradianmodulus,
  growthAttribute = this._getGrowthattribute,
  baseAttribute = this._getBaseattribute,
  dna = this._getDna,
  dnaRecommend = this._getDnarecommend,
  isMutation = this._getIsmutation,
  isBattle = this._getIsbattle,
  petStayType = this._getPetstaytype,
  stayTime = this._getStaytime,
  behaviorType = this._getBehaviortype,
  signatureSkillList = this._getSignatureskilllist,
  blinkSkillList = this._getBlinkskilllist,
  skillListCount = this._getSkilllistcount,
  skillList = this._getSkilllist,
  rPropertyskillCount = this._getRpropertyskillcount,
  rPropertyskillList = this._getRpropertyskilllist,
  fPropertyskillList = this._getFpropertyskilllist,
  breakSkillList = this._getBreakskilllist,
  fixedSkillList = this._getFixedskilllist,
  mountSkill = this._getMountskill,
  skillBytesPath = this._getSkillbytespath,
  propertyId = this._getPropertyid,
  collisionType = this._getCollisiontype,
  kiboDuelTag = this._getKibodueltag,
  kiboSkillList = this._getKiboskilllist,
  bPropertyskillList = this._getBpropertyskilllist,
  kiboBPropertyskillList = this._getKibobpropertyskilllist,
  aimRange = this._getAimrange,
  kiboArenaBaseTemplateID = this._getKiboarenabasetemplateid,
  cf = this._getCf,
  kiboSetTime = this._getKibosettime,
  kiboType = this._getKibotype,
  kiboAutoCastSkill = this._getKiboautocastskill,
  kiboBaseAttribute = this._getKibobaseattribute,
  feature = this._getFeature,
  petlongIcon = this._getPetlongicon,
  puzzleType = this._getPuzzletype,
  petPuzzleIcon = this._getPetpuzzleicon,
  speciesId = this._getSpeciesid,
  worldProperty = this._getWorldproperty,
  moveType = this._getMovetype,
  defaultMoveType = this._getDefaultmovetype,
  playercard_dress = this._getPlayercard_dress,
  iconographyNum = this._getIconographynum,
  iconographyNumSuffix = this._getIconographynumsuffix,
  iconographyshow = this._getIconographyshow,
  iconographyTaskId = this._getIconographytaskid,
  iconographyUnitPosition = this._getIconographyunitposition,
  iconographyDrop = this._getIconographydrop,
  iconographyMapPos = this._getIconographymappos,
  kiboDnaList = this._getKibodnalist,
  noShadow = this._getNoshadow,
  petDailyRefreshProb = this._getPetdailyrefreshprob,
  petOnceRefreshProb = this._getPetoncerefreshprob,
  petNestProb = this._getPetnestprob,
  petFoundleEffect = this._getPetfoundleeffect,
  iconographyreportreward = this._getIconographyreportreward,
  iconographyreporttimes = this._getIconographyreporttimes,
  iconographyreportnormalreward = this._getIconographyreportnormalreward
}
return this
