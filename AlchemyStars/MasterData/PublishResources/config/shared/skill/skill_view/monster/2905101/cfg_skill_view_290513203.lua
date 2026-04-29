local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7
}
local config = {
  {
    1,
    1,
    102,
    1,
    0,
    0,
    {
      startAction = "skill03-2",
      startEffectID = 290510201,
      lineDelayMs = 600,
      monsterClassID = 2905102,
      mainLineEffectID = 290510202,
      subLineEffectID = 290510202,
      mainLineMonsterBone = "Root",
      mainLinePetBone = "Hit",
      subLineTrapBone = "gezi",
      subLinePetBone = "Hit",
      hitDelayMs = 50,
      hitAnim = "Hit",
      hitEffectID = 290510203,
      trapPosEffectID = 290510204,
      monsterLineOff = "0,2.392,-0.891",
      trapDieDelayMs = 700
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " Wait,waitTime=300; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,delay=0,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; "
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    0,
    {
      " PlayAudio,audioID=6279,audioType=1; "
    }
  }
}
return config, "ID", key
