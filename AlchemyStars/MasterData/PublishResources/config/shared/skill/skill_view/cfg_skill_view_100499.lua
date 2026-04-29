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
      " PlayCasterBindEffect,effectID =1004991; Wait,waitTime=1600; PlayCasterBindEffect,effectID =1004992; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=PARAM.buffID; PlayCasterMaterialAnim,animName=common_shield; Wait,waitTime=800; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
