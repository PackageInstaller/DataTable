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
      " PlayAudio,audioID = 6303,audioType=1; Wait,waitTime=100; DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = skill04; PlayCasterBindEffect,effectID=290280106; Wait,waitTime=1500; PlayEffectAtCasterPos, effectID=290280107,gridDirX=0,gridDirY=90; PlayEffectAtCasterPos, effectID=290280107,gridDirX=0,gridDirY=-90; PlayEffectAtCasterPos, effectID=290280107,gridDirX=90,gridDirY=0; PlayEffectAtCasterPos, effectID=290280107,gridDirX=-90,gridDirY=0; Wait,waitTime=150; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290280109,turnToTarget=1,deathClear=0; Wait,waitTime=850; "
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
      " PlaySummonTrap,trapID=2902801; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
