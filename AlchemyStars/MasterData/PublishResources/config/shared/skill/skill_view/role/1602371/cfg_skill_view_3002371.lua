local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
}
local config = {
  {
    1,
    1,
    0,
    1,
    0,
    0,
    {
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1601551,waitTime = 2000;"
    }
  },
  {
    2,
    2,
    111,
    2,
    1,
    0,
    {
      monsterAnim = "AtkUlt1",
      monsterEffID = 160237109,
      monsterAudioID = 160237103,
      yieldTime = 0,
      noMonsterAnim = "AtkUlt",
      noMonsterEffID = 160237110,
      noMonsterAudioID = 160237103,
      yieldTimeNoMonster = 0,
      monsterWeaponEffID = 160237111,
      yieldTime1 = 550,
      noMonsterWeaponEffID = 160237112,
      yieldTime1NoMonster = 550,
      trapIDs = {8002371},
      trajectoryEffID = 160237113,
      trajectoryEndEff = 160237117,
      flyTime = 1000,
      trajectoryIntervalTime = 0,
      yieldTime2 = 1250,
      yieldTime2TrapNoMonster = 400,
      yieldTime2Monster = 2250,
      yieldTime2NoMonster = 1400,
      lastPosEffID = 160237115,
      lastPosAudioID = 160237104,
      yieldTime3 = 1500,
      teleportAnim = "AtkUlt2",
      teleportAnimTime = 450,
      teleportWaitTime = 300,
      teleportEffID = 160237114,
      teleportTime = 1000
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    500,
    {
      " DataSelectScopeGridRange,effectType=11; DataSortScopeGridRange,sortType=0; DataSelectScopeGridRangeIndex,index=1; Jump,condition=CheckCurrentScopeGridRangeIndexValid,result=0,goto=phaseEnd; PlaySummonTrap,trapID=2803501; DataSelectNextScopeGridRange; Jump,condition=CheckCurrentScopeGridRangeIndexValid,goto=playRangeEffect; "
    }
  }
}
return config, "ID", key
