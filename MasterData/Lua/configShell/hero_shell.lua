local this = class("hero_shell", G_BaseConfig)
local core = G_Tables.TDHeroTable.GetInstance()

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
  englishName = 2,
  isCollect = 3,
  favor = 4,
  rarity = 5,
  groups = 6,
  cost = 7,
  position = 8,
  battleTag = 9,
  element = 10,
  subElement = 11,
  kiboId = 12,
  unitId = 13,
  voice = 14,
  uiCharging = 15,
  uiChargingParam = 16,
  attackSkill = 17,
  levelUpType = 18,
  skillList = 19,
  aerialSkillList = 20,
  passiveSkillList = 21,
  homeSkillList = 22,
  backupSkillList = 23,
  skillBytesPath = 24,
  lifeskillDesc = 25,
  weaponType = 26,
  weaponDefault = 27,
  skillSystem = 28,
  dec = 29,
  propertyId = 30,
  leaveBehaviorId = 31,
  isUsable = 32,
  mainElementld = 33,
  collisionType = 34,
  swimParam = 35,
  nestCoopTeam = 36,
  nestCoopTeamAction = 37,
  partyMain = 38,
  partyMainAction = 39,
  kiboDuelAvatar = 40,
  kiboDuelInfo = 41,
  kiboDuelEnemyInfo = 42,
  kiboDuelFormation = 43,
  GiftLookat = 44,
  GiftInfo = 45,
  GiftAction = 46,
  fishAction = 47,
  cutStoneParam = 48,
  cutTreeParam = 49,
  playercard_dress = 50,
  enterSkillOffset = 51,
  heroPixelIdle = 52,
  heroPixelWalk = 53,
  nestcoopSuccessAction = 54,
  gradeUpItem = 55,
  gradeTemplate = 56,
  recommend_soulessence1 = 57,
  recommend_soulessence2 = 58,
  handbookheroScale = 59,
  handbookheroPositionOffset = 60,
  handbookheroRotation = 61,
  skillMaintainDistance = 62,
  exitSkillInterruptFrame = 63,
  setTroopPicParam = 64,
  formationPetsell = 65,
  englishNamewithBreak = 66
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getEnglishname(offset)
  return core:GetVString(offset, this.indexMap.englishName).value
end

function this:_getIscollect(offset)
  return core:GetInt(offset, this.indexMap.isCollect)
end

function this:_getFavor(offset)
  return core:GetInt(offset, this.indexMap.favor)
end

function this:_getRarity(offset)
  return core:GetInt(offset, this.indexMap.rarity)
end

function this:_getGroups(offset)
  return core:GetInt(offset, this.indexMap.groups)
end

function this:_getCost(offset)
  return core:GetInt(offset, this.indexMap.cost)
end

function this:_getPosition(offset)
  return core:GetInt(offset, this.indexMap.position)
end

function this:_getBattletag(offset)
  local str = core:GetVString(offset, this.indexMap.battleTag).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getElement(offset)
  return core:GetInt(offset, this.indexMap.element)
end

function this:_getSubelement(offset)
  return core:GetInt(offset, this.indexMap.subElement)
end

function this:_getKiboid(offset)
  local str = core:GetVString(offset, this.indexMap.kiboId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getUnitid(offset)
  return core:GetInt(offset, this.indexMap.unitId)
end

function this:_getVoice(offset)
  return core:GetVString(offset, this.indexMap.voice).value
end

function this:_getUicharging(offset)
  return core:GetVString(offset, this.indexMap.uiCharging).value
end

function this:_getUichargingparam(offset)
  return core:GetInt(offset, this.indexMap.uiChargingParam)
end

function this:_getAttackskill(offset)
  return core:GetInt(offset, this.indexMap.attackSkill)
end

function this:_getLeveluptype(offset)
  return core:GetInt(offset, this.indexMap.levelUpType)
end

function this:_getSkilllist(offset)
  local str = core:GetVString(offset, this.indexMap.skillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getAerialskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.aerialSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.dictionary, "number", "number")
end

function this:_getPassiveskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.passiveSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHomeskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.homeSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getBackupskilllist(offset)
  local str = core:GetVString(offset, this.indexMap.backupSkillList).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSkillbytespath(offset)
  local str = core:GetVString(offset, this.indexMap.skillBytesPath).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceListStr)
end

function this:_getLifeskilldesc(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero", core:GetVString(offset, this.indexMap.lifeskillDesc))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "lifeskillDesc")
end

function this:_getWeapontype(offset)
  return core:GetInt(offset, this.indexMap.weaponType)
end

function this:_getWeapondefault(offset)
  return core:GetInt(offset, this.indexMap.weaponDefault)
end

function this:_getSkillsystem(offset)
  local str = core:GetVString(offset, this.indexMap.skillSystem).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getDec(offset)
  local langStr = G_TableMgrIns:GetLangStr("hero", core:GetVString(offset, this.indexMap.dec))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "dec")
end

function this:_getPropertyid(offset)
  return core:GetInt(offset, this.indexMap.propertyId)
end

function this:_getLeavebehaviorid(offset)
  return core:GetInt(offset, this.indexMap.leaveBehaviorId)
end

function this:_getIsusable(offset)
  return core:GetInt(offset, this.indexMap.isUsable)
end

function this:_getMainelementld(offset)
  local str = core:GetVString(offset, this.indexMap.mainElementld).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCollisiontype(offset)
  return core:GetInt(offset, this.indexMap.collisionType)
end

function this:_getSwimparam(offset)
  local str = core:GetVString(offset, this.indexMap.swimParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getNestcoopteam(offset)
  local str = core:GetVString(offset, this.indexMap.nestCoopTeam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getNestcoopteamaction(offset)
  return core:GetVString(offset, this.indexMap.nestCoopTeamAction).value
end

function this:_getPartymain(offset)
  local str = core:GetVString(offset, this.indexMap.partyMain).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getPartymainaction(offset)
  return core:GetVString(offset, this.indexMap.partyMainAction).value
end

function this:_getKiboduelavatar(offset)
  local str = core:GetVString(offset, this.indexMap.kiboDuelAvatar).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 2)
end

function this:_getKiboduelinfo(offset)
  local str = core:GetVString(offset, this.indexMap.kiboDuelInfo).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getKiboduelenemyinfo(offset)
  local str = core:GetVString(offset, this.indexMap.kiboDuelEnemyInfo).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getKiboduelformation(offset)
  local str = core:GetVString(offset, this.indexMap.kiboDuelFormation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getGiftlookat(offset)
  local str = core:GetVString(offset, this.indexMap.GiftLookat).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getGiftinfo(offset)
  local str = core:GetVString(offset, this.indexMap.GiftInfo).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getGiftaction(offset)
  return core:GetVString(offset, this.indexMap.GiftAction).value
end

function this:_getFishaction(offset)
  return core:GetInt(offset, this.indexMap.fishAction)
end

function this:_getCutstoneparam(offset)
  local str = core:GetVString(offset, this.indexMap.cutStoneParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getCuttreeparam(offset)
  local str = core:GetVString(offset, this.indexMap.cutTreeParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getPlayercard_dress(offset)
  local str = core:GetVString(offset, this.indexMap.playercard_dress).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getEnterskilloffset(offset)
  return core:GetFloat(offset, this.indexMap.enterSkillOffset)
end

function this:_getHeropixelidle(offset)
  local str = core:GetVString(offset, this.indexMap.heroPixelIdle).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getHeropixelwalk(offset)
  local str = core:GetVString(offset, this.indexMap.heroPixelWalk).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getNestcoopsuccessaction(offset)
  return core:GetVString(offset, this.indexMap.nestcoopSuccessAction).value
end

function this:_getGradeupitem(offset)
  local str = core:GetVString(offset, this.indexMap.gradeUpItem).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getGradetemplate(offset)
  return core:GetInt(offset, this.indexMap.gradeTemplate)
end

function this:_getRecommend_soulessence1(offset)
  local str = core:GetVString(offset, this.indexMap.recommend_soulessence1).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getRecommend_soulessence2(offset)
  local str = core:GetVString(offset, this.indexMap.recommend_soulessence2).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHandbookheroscale(offset)
  return core:GetInt(offset, this.indexMap.handbookheroScale)
end

function this:_getHandbookheropositionoffset(offset)
  local str = core:GetVString(offset, this.indexMap.handbookheroPositionOffset).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getHandbookherorotation(offset)
  local str = core:GetVString(offset, this.indexMap.handbookheroRotation).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getSkillmaintaindistance(offset)
  return core:GetFloat(offset, this.indexMap.skillMaintainDistance)
end

function this:_getExitskillinterruptframe(offset)
  return core:GetInt(offset, this.indexMap.exitSkillInterruptFrame)
end

function this:_getSettrooppicparam(offset)
  local str = core:GetVString(offset, this.indexMap.setTroopPicParam).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getFormationpetsell(offset)
  local str = core:GetVString(offset, this.indexMap.formationPetsell).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getEnglishnamewithbreak(offset)
  return core:GetVString(offset, this.indexMap.englishNamewithBreak).value
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  englishName = this._getEnglishname,
  isCollect = this._getIscollect,
  favor = this._getFavor,
  rarity = this._getRarity,
  groups = this._getGroups,
  cost = this._getCost,
  position = this._getPosition,
  battleTag = this._getBattletag,
  element = this._getElement,
  subElement = this._getSubelement,
  kiboId = this._getKiboid,
  unitId = this._getUnitid,
  voice = this._getVoice,
  uiCharging = this._getUicharging,
  uiChargingParam = this._getUichargingparam,
  attackSkill = this._getAttackskill,
  levelUpType = this._getLeveluptype,
  skillList = this._getSkilllist,
  aerialSkillList = this._getAerialskilllist,
  passiveSkillList = this._getPassiveskilllist,
  homeSkillList = this._getHomeskilllist,
  backupSkillList = this._getBackupskilllist,
  skillBytesPath = this._getSkillbytespath,
  lifeskillDesc = this._getLifeskilldesc,
  weaponType = this._getWeapontype,
  weaponDefault = this._getWeapondefault,
  skillSystem = this._getSkillsystem,
  dec = this._getDec,
  propertyId = this._getPropertyid,
  leaveBehaviorId = this._getLeavebehaviorid,
  isUsable = this._getIsusable,
  mainElementld = this._getMainelementld,
  collisionType = this._getCollisiontype,
  swimParam = this._getSwimparam,
  nestCoopTeam = this._getNestcoopteam,
  nestCoopTeamAction = this._getNestcoopteamaction,
  partyMain = this._getPartymain,
  partyMainAction = this._getPartymainaction,
  kiboDuelAvatar = this._getKiboduelavatar,
  kiboDuelInfo = this._getKiboduelinfo,
  kiboDuelEnemyInfo = this._getKiboduelenemyinfo,
  kiboDuelFormation = this._getKiboduelformation,
  GiftLookat = this._getGiftlookat,
  GiftInfo = this._getGiftinfo,
  GiftAction = this._getGiftaction,
  fishAction = this._getFishaction,
  cutStoneParam = this._getCutstoneparam,
  cutTreeParam = this._getCuttreeparam,
  playercard_dress = this._getPlayercard_dress,
  enterSkillOffset = this._getEnterskilloffset,
  heroPixelIdle = this._getHeropixelidle,
  heroPixelWalk = this._getHeropixelwalk,
  nestcoopSuccessAction = this._getNestcoopsuccessaction,
  gradeUpItem = this._getGradeupitem,
  gradeTemplate = this._getGradetemplate,
  recommend_soulessence1 = this._getRecommend_soulessence1,
  recommend_soulessence2 = this._getRecommend_soulessence2,
  handbookheroScale = this._getHandbookheroscale,
  handbookheroPositionOffset = this._getHandbookheropositionoffset,
  handbookheroRotation = this._getHandbookherorotation,
  skillMaintainDistance = this._getSkillmaintaindistance,
  exitSkillInterruptFrame = this._getExitskillinterruptframe,
  setTroopPicParam = this._getSettrooppicparam,
  formationPetsell = this._getFormationpetsell,
  englishNamewithBreak = this._getEnglishnamewithbreak
}
return this
