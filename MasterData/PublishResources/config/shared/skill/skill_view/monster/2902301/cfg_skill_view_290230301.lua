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
      " Wait,waitTime=400; PlayCasterBindEffect,effectID=3624; Wait,waitTime=100; PlaySummonTrap,trapID=2800701; DataSelectResult,effectType=79,index=1; PlayDestroyTrap; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " PlayCasterMaterialAnim,animName=eff_2602301_skill03_out; Wait,waitTime=10; PlayCasterBindEffect,effectID=3621; Wait,waitTime=440; PlayRideOn,rideOnDelay=100; PlayCasterMaterialAnim,animName=eff_2602301_skill03_in; Wait,waitTime=50; PlayCasterBindEffect,effectID=3622; Wait,waitTime=950; "
    }
  },
  {
    3,
    3,
    0,
    1,
    0,
    0,
    {
      " DataSelectDamage,damageIndex=1; PlayCasterBindEffect,effectID=3625; PlayAudio,audioID = 6193,audioType=1; Wait,waitTime=690; PlayCasterAnimation,animName = skill3; Wait,waitTime=320; PlayEffectAtTargetGrid,effectID=3626; Wait,waitTime=1000; PlayEffectAtTargetGrid,effectID=3627; PlayCameraEffect,effectID=3628; Wait,waitTime=100; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3629,turnToTarget=1,deathClear=0; Wait,waitTime=900; "
    }
  },
  {
    4,
    4,
    27,
    1,
    0,
    600,
    {
      hitAnim = "Hit",
      hitEffectID = 0,
      turnToTarget = 1
    }
  }
}
return config, "ID", key
