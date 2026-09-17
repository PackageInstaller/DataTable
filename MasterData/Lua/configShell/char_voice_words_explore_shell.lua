local this = class("char_voice_words_explore_shell", G_BaseConfig)
local core = G_Tables.TDCharVoiceWordsExploreTable.GetInstance()

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
  Idle = 2,
  IdleFavorAbility = 3,
  GreetingMorning = 4,
  GreetingAfternoon = 5,
  GreetingEvening = 6,
  IdleWeather_01 = 7,
  IdleWeather_02 = 8,
  TreasureFound_01 = 9,
  TreasureFound_02 = 10,
  TreasureGet_01 = 11,
  TreasureGet_02 = 12,
  TreasureGet_03 = 13,
  ResourceFound_01 = 14,
  ResourceFound_02 = 15,
  ResourceGet_01 = 16,
  ResourceGet_02 = 17,
  ResourceGet_03 = 18,
  WorldPuzzleSolve = 19,
  NormalPuzzleSolve = 20,
  ItemRequired_01 = 21,
  ItemRequired_02 = 22,
  SwitchChara = 23,
  Scenery = 24,
  LandMark = 25,
  NormalEnemy = 26,
  StrongEnemy = 27,
  FoundbyEnemy = 28,
  EscapefromEnemy = 29,
  BackHPHigh = 30,
  BackHPMed = 31,
  BackHPLow = 32,
  BackFailed = 33,
  VictoryMVP = 34,
  VictoryAudience = 35,
  Victory = 36,
  HealWarning = 37,
  QuestTake = 38,
  QuestComplete_01 = 39,
  QuestComplete_02 = 40,
  Dash_001 = 41,
  Dash_002 = 42,
  Dash_003 = 43,
  Jump_001 = 44,
  Jump_002 = 45,
  Jump_003 = 46,
  Leap_001 = 47,
  Leap_002 = 48,
  MountRide = 49,
  MountFly = 50,
  MountSwim = 51,
  MountDive = 52,
  SummonPuzzle = 53,
  SummonBattle = 54,
  EnterMap = 55,
  EnterBirthPlace = 56,
  EnterSP = 57,
  UnLockTeleport = 58,
  UnLockTower = 59,
  QiboCapture = 60
}

function this:_getId(offset)
  return core:GetInt(offset, this.indexMap.id)
end

function this:_getName(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.name))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "name")
end

function this:_getIdle(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.Idle))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Idle")
end

function this:_getIdlefavorability(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.IdleFavorAbility))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "IdleFavorAbility")
end

function this:_getGreetingmorning(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.GreetingMorning))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "GreetingMorning")
end

function this:_getGreetingafternoon(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.GreetingAfternoon))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "GreetingAfternoon")
end

function this:_getGreetingevening(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.GreetingEvening))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "GreetingEvening")
end

function this:_getIdleweather_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.IdleWeather_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "IdleWeather_01")
end

function this:_getIdleweather_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.IdleWeather_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "IdleWeather_02")
end

function this:_getTreasurefound_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.TreasureFound_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "TreasureFound_01")
end

function this:_getTreasurefound_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.TreasureFound_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "TreasureFound_02")
end

function this:_getTreasureget_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.TreasureGet_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "TreasureGet_01")
end

function this:_getTreasureget_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.TreasureGet_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "TreasureGet_02")
end

function this:_getTreasureget_03(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.TreasureGet_03))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "TreasureGet_03")
end

function this:_getResourcefound_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.ResourceFound_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ResourceFound_01")
end

function this:_getResourcefound_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.ResourceFound_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ResourceFound_02")
end

function this:_getResourceget_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.ResourceGet_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ResourceGet_01")
end

function this:_getResourceget_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.ResourceGet_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ResourceGet_02")
end

function this:_getResourceget_03(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.ResourceGet_03))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ResourceGet_03")
end

function this:_getWorldpuzzlesolve(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.WorldPuzzleSolve))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "WorldPuzzleSolve")
end

function this:_getNormalpuzzlesolve(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.NormalPuzzleSolve))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "NormalPuzzleSolve")
end

function this:_getItemrequired_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.ItemRequired_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ItemRequired_01")
end

function this:_getItemrequired_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.ItemRequired_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "ItemRequired_02")
end

function this:_getSwitchchara(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.SwitchChara))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "SwitchChara")
end

function this:_getScenery(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.Scenery))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Scenery")
end

function this:_getLandmark(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.LandMark))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "LandMark")
end

function this:_getNormalenemy(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.NormalEnemy))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "NormalEnemy")
end

function this:_getStrongenemy(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.StrongEnemy))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "StrongEnemy")
end

function this:_getFoundbyenemy(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.FoundbyEnemy))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "FoundbyEnemy")
end

function this:_getEscapefromenemy(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.EscapefromEnemy))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "EscapefromEnemy")
end

function this:_getBackhphigh(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.BackHPHigh))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BackHPHigh")
end

function this:_getBackhpmed(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.BackHPMed))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BackHPMed")
end

function this:_getBackhplow(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.BackHPLow))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BackHPLow")
end

function this:_getBackfailed(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.BackFailed))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "BackFailed")
end

function this:_getVictorymvp(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.VictoryMVP))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "VictoryMVP")
end

function this:_getVictoryaudience(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.VictoryAudience))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "VictoryAudience")
end

function this:_getVictory(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.Victory))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Victory")
end

function this:_getHealwarning(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.HealWarning))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "HealWarning")
end

function this:_getQuesttake(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.QuestTake))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "QuestTake")
end

function this:_getQuestcomplete_01(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.QuestComplete_01))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "QuestComplete_01")
end

function this:_getQuestcomplete_02(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.QuestComplete_02))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "QuestComplete_02")
end

function this:_getDash_001(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.Dash_001))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Dash_001")
end

function this:_getDash_002(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.Dash_002))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Dash_002")
end

function this:_getDash_003(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.Dash_003))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Dash_003")
end

function this:_getJump_001(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.Jump_001))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Jump_001")
end

function this:_getJump_002(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.Jump_002))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Jump_002")
end

function this:_getJump_003(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.Jump_003))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Jump_003")
end

function this:_getLeap_001(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.Leap_001))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Leap_001")
end

function this:_getLeap_002(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.Leap_002))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "Leap_002")
end

function this:_getMountride(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.MountRide))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "MountRide")
end

function this:_getMountfly(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.MountFly))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "MountFly")
end

function this:_getMountswim(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.MountSwim))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "MountSwim")
end

function this:_getMountdive(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.MountDive))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "MountDive")
end

function this:_getSummonpuzzle(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.SummonPuzzle))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "SummonPuzzle")
end

function this:_getSummonbattle(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.SummonBattle))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "SummonBattle")
end

function this:_getEntermap(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.EnterMap))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "EnterMap")
end

function this:_getEnterbirthplace(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.EnterBirthPlace))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "EnterBirthPlace")
end

function this:_getEntersp(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.EnterSP))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "EnterSP")
end

function this:_getUnlockteleport(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.UnLockTeleport))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "UnLockTeleport")
end

function this:_getUnlocktower(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.UnLockTower))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "UnLockTower")
end

function this:_getQibocapture(offset)
  local langStr = G_TableMgrIns:GetLangStr("char_voice_words_explore", core:GetVString(offset, this.indexMap.QiboCapture))
  return G_ConfigParser.ParseConfigStr(langStr, G_ConfigConst.ParseType.langstring, "QiboCapture")
end

this.keyToMethodsMap = {
  id = this._getId,
  name = this._getName,
  Idle = this._getIdle,
  IdleFavorAbility = this._getIdlefavorability,
  GreetingMorning = this._getGreetingmorning,
  GreetingAfternoon = this._getGreetingafternoon,
  GreetingEvening = this._getGreetingevening,
  IdleWeather_01 = this._getIdleweather_01,
  IdleWeather_02 = this._getIdleweather_02,
  TreasureFound_01 = this._getTreasurefound_01,
  TreasureFound_02 = this._getTreasurefound_02,
  TreasureGet_01 = this._getTreasureget_01,
  TreasureGet_02 = this._getTreasureget_02,
  TreasureGet_03 = this._getTreasureget_03,
  ResourceFound_01 = this._getResourcefound_01,
  ResourceFound_02 = this._getResourcefound_02,
  ResourceGet_01 = this._getResourceget_01,
  ResourceGet_02 = this._getResourceget_02,
  ResourceGet_03 = this._getResourceget_03,
  WorldPuzzleSolve = this._getWorldpuzzlesolve,
  NormalPuzzleSolve = this._getNormalpuzzlesolve,
  ItemRequired_01 = this._getItemrequired_01,
  ItemRequired_02 = this._getItemrequired_02,
  SwitchChara = this._getSwitchchara,
  Scenery = this._getScenery,
  LandMark = this._getLandmark,
  NormalEnemy = this._getNormalenemy,
  StrongEnemy = this._getStrongenemy,
  FoundbyEnemy = this._getFoundbyenemy,
  EscapefromEnemy = this._getEscapefromenemy,
  BackHPHigh = this._getBackhphigh,
  BackHPMed = this._getBackhpmed,
  BackHPLow = this._getBackhplow,
  BackFailed = this._getBackfailed,
  VictoryMVP = this._getVictorymvp,
  VictoryAudience = this._getVictoryaudience,
  Victory = this._getVictory,
  HealWarning = this._getHealwarning,
  QuestTake = this._getQuesttake,
  QuestComplete_01 = this._getQuestcomplete_01,
  QuestComplete_02 = this._getQuestcomplete_02,
  Dash_001 = this._getDash_001,
  Dash_002 = this._getDash_002,
  Dash_003 = this._getDash_003,
  Jump_001 = this._getJump_001,
  Jump_002 = this._getJump_002,
  Jump_003 = this._getJump_003,
  Leap_001 = this._getLeap_001,
  Leap_002 = this._getLeap_002,
  MountRide = this._getMountride,
  MountFly = this._getMountfly,
  MountSwim = this._getMountswim,
  MountDive = this._getMountdive,
  SummonPuzzle = this._getSummonpuzzle,
  SummonBattle = this._getSummonbattle,
  EnterMap = this._getEntermap,
  EnterBirthPlace = this._getEnterbirthplace,
  EnterSP = this._getEntersp,
  UnLockTeleport = this._getUnlockteleport,
  UnLockTower = this._getUnlocktower,
  QiboCapture = this._getQibocapture
}
return this
