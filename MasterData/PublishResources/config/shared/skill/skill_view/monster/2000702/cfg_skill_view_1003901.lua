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
      " PlayCasterBindEffect,effectID=2540; PlayCasterMaterialAnim,animName=eff_2000702_skill01_01; PlayCasterAnimation,animName = Skill01; PlayAudio,audioID = 7029,audioType=1; Wait,waitTime=1200; "
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
      " PlayCasterAnimation,animName = Skill01_2; PlayCasterBindEffect,effectID=2541; PlayAudio,audioID = 6044,audioType=1; PlayTeleportAsMoving,speed=12; "
    }
  },
  {
    3,
    3,
    38,
    2,
    2,
    0,
    {
      effectIDList = {2541}
    }
  },
  {
    4,
    4,
    0,
    2,
    2,
    50,
    {
      " DataSelectDamage,damageIndex = 1; PlayCasterTurnToTarget; PlayCasterAnimation,animName = Skill01_3; PlayCasterMaterialAnim,animName=eff_2000702_skill01_02; PlayCasterBindEffect,effectID=2542; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
