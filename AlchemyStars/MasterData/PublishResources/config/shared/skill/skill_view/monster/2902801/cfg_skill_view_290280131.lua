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
      " PlayAudio,audioID = 6302,audioType=1; Wait,waitTime=200; PlayTurnToTeleportNewPos; PlayCasterAnimation,animName = skill03; PlayCasterBindEffect,effectID=290280101; PlayCasterMaterialAnim,animName=eff_2902801_skill03_xiaoshi; "
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
      " Wait,waitTime=200; PlayEffectTeleportNewPos,effectID=290280102,useCasterDir=1; PlayTeleportAsMoving,time=200; PlayCasterMaterialAnim,animName=eff_2902801_skill03_chuxian; "
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    0,
    {
      " Wait,waitTime=200; PlayTargetTurnToCaster; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290280103,turnToTarget=1,deathClear=0; Wait,waitTime=800; DataSelectDamage,damageIndex = 2; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
