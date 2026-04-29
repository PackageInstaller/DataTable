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
    2,
    0,
    0,
    {
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=1643; PlayAudio,audioID = 3060,audioType=1; Wait,waitTime=333; DataSelectResult,effectType=85,index=1; PlayCostCasterHP; Wait,waitTime=767; PlaySelectCenterGridEffect,effectID=1644; Wait,waitTime=1350; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; PlayTargetAddBuff,buffID=20031; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlayCasterAddBuff,buffID=430045; Wait,waitTime=1250; "
    }
  }
}
return config, "ID", key
