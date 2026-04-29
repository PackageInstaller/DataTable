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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 15008571,waitTime = 2000;"
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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=3801; PlayAudio,audioID = 2505,audioType=1; Wait,waitTime=1089; PlayCasterVisible,visible=0; Wait,waitTime=4026; PlayCasterVisible,visible=1; PlayCasterAnimation,animName =AtkUlt1; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    3700,
    {
      " PlayConvertFlyTrajectorySummonTrap,flyEffectID=3798,fireTimeMin=0,fireTimeMax=700,flyTime=1000,flyRandomDis=8,flyRandomPointCount=3,targetHitOffsetMin=0,targetHitOffsetMax=0.1,fireEffectID=3799,disableRoot=1501651_daodan,destroyBulletDelay=1000,convertEffectID=3803,summonTrap=1,needLookAt=1,firstPosX=0,firstPosY=1,firstPosZ=0,firstPosRandom=0.5,offsetPosX=0,offsetPosY=1.5,offsetPosZ=-0.035;Wait,waitTime=300; "
    }
  }
}
return config, "ID", key
