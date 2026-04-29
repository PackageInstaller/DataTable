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
      " PlayCasterAttachEffectHolder,effHolderType=BeforeFly,effId=1234; PlayCasterEffectHolder,effHolderType=BeforeFly,isShow=0; PlayAudio,audioID = 6023,audioType=1; Wait,waitTime=200; PlayCasterVisible, visible=1; PlayCasterAnimation,animName = Birth; Wait,waitTime=500; PlayEffectAtCasterPos,effectID=1231; Wait,waitTime=3000; PlayEffectAtCasterPos, effectID=1232; DataSelectDamage,damageIndex = 1; DataSelectDamageInfo,damageInfoIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    2000,
    {
      " PlaySummonTrap,trapID=PARAM.trapID; "
    }
  }
}
return config, "ID", key
