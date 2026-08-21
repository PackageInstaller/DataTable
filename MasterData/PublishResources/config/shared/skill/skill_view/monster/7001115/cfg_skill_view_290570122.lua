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
      " PlayCasterAnimation,animName = skill012; PlayCasterMaterialAnim,animName=eff_2905701_skill01_in_mat; PlayAudio,audioID = 7055,audioType=1; Wait,waitTime=300; PlayCasterBindEffect,effectID=290570105; Wait,waitTime=1800; PlayRoleTeleport,type=3; PlayRoleTeleport,type=5; Wait,waitTime=500; PlayRoleTeleport,type=6; PlayCasterBindEffect,effectID=290570110; PlayCasterAnimation,animName = skill02; PlayAudio,audioID = 7057,audioType=1; PlayCasterMaterialAnim,animName=eff_2905701_skill02_mat; Wait,waitTime=1400; DataSelectDamage,damageIndex = 1; PlayFlyEffectCasterToTarget,flyEffectID=290570111,flyTime=1000,flyTrace=1,targetPos=Hit; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    4360,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290570112,turnToTarget=1,deathClear=0,label=doAgain; Wait,waitTime=300; PlaySummonTrap,trapID=70011151; Wait,waitTime=1000;"
    }
  }
}
return config, "ID", key
