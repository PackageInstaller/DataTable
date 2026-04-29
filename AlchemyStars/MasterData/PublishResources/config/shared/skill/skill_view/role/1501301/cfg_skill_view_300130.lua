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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,petID=1200501,waitTime = 2000; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID =3900; PlayEffectAtPickUpIndexGrid,effectID=3901,pickUpIndex=1; PlayAudio,audioID = 2532; PlayLevelTrapCommonSummon,destroyEffectID=3902,maxLevelCamEffectID=3899, summonDelay=1100,destroyInterval=50,maxLevelAudioID=2531; Wait,waitTime=3000; "
    }
  }
}
return config, "ID", key
