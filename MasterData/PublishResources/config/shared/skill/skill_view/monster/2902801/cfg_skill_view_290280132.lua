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
      " PlayCasterVisible=1; PlayTurnToTeleportNewPos; PlayCasterAnimation,animName = skill03; PlayAudio,audioID = 6302,audioType=1; PlayCasterBindEffect,effectID=290280101; PlayCasterMaterialAnim,animName=eff_2902801_skill03_xiaoshi; "
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
      " Wait,waitTime=200; PlayEffectTeleportNewPos,effectID=290280102,useCasterDir=1; PlayTeleportAsMoving,time=200; PlayCasterMaterialAnim,animName=eff_2902801_skill03_chuxian; Wait,waitTime=1500; PlayCasterVisible=0; "
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
      " Wait,waitTime=200; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290280103,turnToTarget=1; "
    }
  }
}
return config, "ID", key
