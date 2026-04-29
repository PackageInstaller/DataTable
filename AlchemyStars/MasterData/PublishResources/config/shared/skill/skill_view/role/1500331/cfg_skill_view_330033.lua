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
    0,
    1,
    0,
    0,
    {
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1500331,waitTime = 2000;"
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
      " DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayAudio,audioID = 2151; PlayCasterAnimation,animName = AtkUlt01; PlayCasterTurnToTarget; Wait,waitTime=767; PlayCasterBindRotationToTargetEffect,offsetx=0,offsety=1.688,offsetz=0.511,effectID=466; Wait,waitTime=100; PlayFlyEffectCasterToTarget,flyEffectID = 46500,flyTime = 100,offsetx=0,offsety=1.688,offsetz=0.511,flyTrace = 3; Wait,waitTime=100; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=46800,turnToTarget=1,deathClear=0; "
    }
  },
  {
    3,
    3,
    77,
    1,
    2,
    1100,
    {
      startIndex = 2,
      lastStartIndex = 2,
      audioID = 2152,
      animName = "AtkUlt02",
      waitEffectTime = 167,
      effectID = 46600,
      effectOffsetX = 0,
      effectOffsetY = 1.688,
      effectOffsetZ = 0.511,
      waitBulletEffectTime = 100,
      bulletEffectId = 46500,
      bulletFlySpeed = 100,
      bulletFlyTrace = 3,
      bulletEffectOffsetX = 0,
      bulletEffectOffsetY = 1.688,
      bulletEffectOffsetZ = 0.511,
      waitHitTime = 0,
      hitAnimName = "Hit",
      hitEffectID = 46800,
      turnToTarget = 1,
      deathClear = 0,
      waitAnimTime = 0
    }
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      " DataSelectLastDamage; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; Wait,waitTime=267; PlayAudio,audioID = 2153; PlayCasterTurnToTarget; PlayCasterAnimation,animName = AtkUlt03; Wait,waitTime=233; PlayCasterBindRotationToTargetEffect,offsetx=0,offsety=1.688,offsetz=0.511,effectID=46700; Wait,waitTime=500; PlayFlyEffectCasterToTarget,flyEffectID = 46500,flyTime = 100,offsetx=0,offsety=1.688,offsetz=0.511,flyTrace = 3; Wait,waitTime=0; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=46800,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
