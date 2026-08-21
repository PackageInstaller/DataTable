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
      " DataSelectResult,effectType=85,index=1; PlayCostCasterHP; Wait,waitTime=200; PlayAudio,audioID = 2617,audioType=1; PlayCasterBindEffect,effectID =160191106; PlayCasterBindEffect,effectID =160191108; PlayCasterAnimation,animName=AktUlt_Monster; PlayCasterBindEffect,effectID =160191109; Wait,waitTime=1000; PlayDarkScreen,enable=1; PlayRoleTeleport, type=5; PlayCasterTurnToPlayer; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; Wait,waitTime=150; PlayCasterBindEffect,effectID =160191107; Wait,waitTime=1750; PlayDarkScreen,enable=0; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
