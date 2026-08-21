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
      " PlayCasterAnimation,animName=Skill01_0; Wait,waitTime=300; PlayCasterBindEffect,effectID=3118; Wait,waitTime=215; PlayAudio,audioID = 6124,audioType=1; Wait,waitTime=385; PlayRoleTeleport,type=3, onlySelf=1; PlayCasterControlGridDown,enable=0; PlayCasterControlOutLine,enable=0; PlayCasterHUDVisible,visible=0; PlayRoleTeleport,type=5, onlySelf=1; Wait,waitTime=1000; PlayCasterBindEffect,effectID=3119; Wait,waitTime=410; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterTurnToPlayer; PlayCasterAnimation,animName=Skill01_1; PlayCasterMaterialAnim,animName=eff_2900681_birth_main; Wait,waitTime=300; PlayCasterControlGridDown,enable=1; PlayCasterControlOutLine,enable=1; PlayCasterHUDVisible,visible=1; "
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
      " DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName =Skill01_2; PlayCasterBindEffect,effectID=3125; Wait,waitTime=790; PlayAudio,audioID = 6121,audioType=1; Wait,waitTime=210; PlayTargetBeHitEffect,hitEffectID=3124; Wait,waitTime=200; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    50,
    {
      " PlayCasterAnimation,animName =Skill01_3; PlayCasterBindEffect,effectID=3120; Wait,waitTime=300; PlayCasterBindEffect,effectID=3122; Wait,waitTime=1000; PlayAudio,audioID = 6125,audioType=1; Wait,waitTime=1000; PlayCasterBindEffect,effectID=3123,isRotate=1,randomRotate=0.3; Wait,waitTime=300; PlayCasterBindEffect,effectID=3123,isRotate=1,randomRotate=0.3; Wait,waitTime=150; PlayCasterBindEffect,effectID=3123,isRotate=1,randomRotate=0.3; Wait,waitTime=150; "
    }
  },
  {
    4,
    4,
    34,
    2,
    2,
    2700,
    {
      gridEffectID = 3121,
      gridEffectDelayTime = 0,
      gridIntervalTime = 150,
      showTimeDelay = 150
    }
  }
}
return config, "ID", key
