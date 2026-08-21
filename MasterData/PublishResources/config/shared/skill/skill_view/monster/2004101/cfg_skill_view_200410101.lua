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
      " PlayTargetTurnToCaster; PlayCasterAnimation,animName = Atk; PlayCasterBindEffect,effectID =200410102; PlayCasterMaterialAnim,animName=eff_2004101_skill01_main_out; PlayAudio,audioID = 5081,audioType=1; Wait,waitTime=300; PlayCasterAnimation,animName = skill01; PlayCasterBindEffect,effectID =200410103; PlayCasterMaterialAnim,animName=eff_2004101_skill01_main_in; DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200410104,turnToTarget=1,deathClear=0; Wait,waitTime=100; DataSelectDamage,damageIndex = 1,damageStageIndex=2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    400,
    {
      " PlayTeleportAsMoving,time=500; "
    }
  }
}
return config, "ID", key
