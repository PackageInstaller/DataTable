local this = class("home_dorm_scene_shell", G_BaseConfig)
local core = G_Tables.TDHomeDormSceneTable.GetInstance()

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
  heroId = 0,
  canEnterDorm = 1,
  heroSpawnerId = 2,
  heroOutdoorAiTree = 3,
  heroDefaultPajamaSpawnerId = 4,
  heroPajamaSpawnerId = 5,
  heroIndoorAiTree = 6,
  unlockItem = 7,
  exclusivedormScene = 8,
  exclusivename = 9,
  dormIcon = 10,
  exclusivedormSceneNight = 11,
  jumpid = 12,
  sceneId = 13,
  name = 14,
  icon = 15,
  sceneIdNight = 16,
  inDormWeight = 17,
  inSquareWeight = 18,
  interactOptions = 19,
  interactOverrideParams = 20,
  regularTalkId = 21,
  sleepTalkId = 22,
  bathTalkId = 23,
  dailyStory = 24,
  outdoorBehavior = 25,
  outdoorBehaviorTag = 26
}

function this:_getHeroid(offset)
  return core:GetInt(offset, this.indexMap.heroId)
end

function this:_getCanenterdorm(offset)
  return core:GetBool(offset, this.indexMap.canEnterDorm)
end

function this:_getHerospawnerid(offset)
  return core:GetInt(offset, this.indexMap.heroSpawnerId)
end

function this:_getHerooutdooraitree(offset)
  return core:GetInt(offset, this.indexMap.heroOutdoorAiTree)
end

function this:_getHerodefaultpajamaspawnerid(offset)
  return core:GetInt(offset, this.indexMap.heroDefaultPajamaSpawnerId)
end

function this:_getHeropajamaspawnerid(offset)
  local str = core:GetVString(offset, this.indexMap.heroPajamaSpawnerId).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getHeroindooraitree(offset)
  return core:GetInt(offset, this.indexMap.heroIndoorAiTree)
end

function this:_getUnlockitem(offset)
  local str = core:GetVString(offset, this.indexMap.unlockItem).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getExclusivedormscene(offset)
  local str = core:GetVString(offset, this.indexMap.exclusivedormScene).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getExclusivename(offset)
  local langStrList = G_TableMgrIns:GetListLangStr("home_dorm_scene", core:GetVString(offset, this.indexMap.exclusivename))
  return G_ConfigParser.ParseConfigStr(langStrList, G_ConfigConst.ParseType.listLangstring, "home_dorm_scene")
end

function this:_getDormicon(offset)
  local str = core:GetVString(offset, this.indexMap.dormIcon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getExclusivedormscenenight(offset)
  local str = core:GetVString(offset, this.indexMap.exclusivedormSceneNight).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getJumpid(offset)
  local str = core:GetVString(offset, this.indexMap.jumpid).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getSceneid(offset)
  return core:GetInt(offset, this.indexMap.sceneId)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("home_dorm_scene", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIcon(offset)
  local str = core:GetVString(offset, this.indexMap.icon).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.resourceStr, 1)
end

function this:_getSceneidnight(offset)
  return core:GetInt(offset, this.indexMap.sceneIdNight)
end

function this:_getIndormweight(offset)
  return core:GetInt(offset, this.indexMap.inDormWeight)
end

function this:_getInsquareweight(offset)
  return core:GetInt(offset, this.indexMap.inSquareWeight)
end

function this:_getInteractoptions(offset)
  local str = core:GetVString(offset, this.indexMap.interactOptions).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

function this:_getInteractoverrideparams(offset)
  local str = core:GetVString(offset, this.indexMap.interactOverrideParams).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "string")
end

function this:_getRegulartalkid(offset)
  return core:GetInt(offset, this.indexMap.regularTalkId)
end

function this:_getSleeptalkid(offset)
  return core:GetInt(offset, this.indexMap.sleepTalkId)
end

function this:_getBathtalkid(offset)
  return core:GetInt(offset, this.indexMap.bathTalkId)
end

function this:_getDailystory(offset)
  local str = core:GetVString(offset, this.indexMap.dailyStory).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getOutdoorbehavior(offset)
  local str = core:GetVString(offset, this.indexMap.outdoorBehavior).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.compositeList, "number")
end

function this:_getOutdoorbehaviortag(offset)
  local str = core:GetVString(offset, this.indexMap.outdoorBehaviorTag).value
  return G_ConfigParser.ParseConfigStr(str, G_ConfigConst.ParseType.list, "number")
end

this.keyToMethodsMap = {
  heroId = this._getHeroid,
  canEnterDorm = this._getCanenterdorm,
  heroSpawnerId = this._getHerospawnerid,
  heroOutdoorAiTree = this._getHerooutdooraitree,
  heroDefaultPajamaSpawnerId = this._getHerodefaultpajamaspawnerid,
  heroPajamaSpawnerId = this._getHeropajamaspawnerid,
  heroIndoorAiTree = this._getHeroindooraitree,
  unlockItem = this._getUnlockitem,
  exclusivedormScene = this._getExclusivedormscene,
  exclusivename = this._getExclusivename,
  dormIcon = this._getDormicon,
  exclusivedormSceneNight = this._getExclusivedormscenenight,
  jumpid = this._getJumpid,
  sceneId = this._getSceneid,
  name = this._getName,
  icon = this._getIcon,
  sceneIdNight = this._getSceneidnight,
  inDormWeight = this._getIndormweight,
  inSquareWeight = this._getInsquareweight,
  interactOptions = this._getInteractoptions,
  interactOverrideParams = this._getInteractoverrideparams,
  regularTalkId = this._getRegulartalkid,
  sleepTalkId = this._getSleeptalkid,
  bathTalkId = this._getBathtalkid,
  dailyStory = this._getDailystory,
  outdoorBehavior = this._getOutdoorbehavior,
  outdoorBehaviorTag = this._getOutdoorbehaviortag
}
return this
