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
      " PlayCasterTurnToPlayer; DataSelectDamage,damageIndex = 1; PlayCasterTurnToPlayer; PlayCasterBindEffect,effectID=160191103; PlayAudio,audioID=2615,audioType=1; PlayCasterMaterialAnim,animName=eff_1601911_atkchain_chuxian; Wait,waitTime=410; PlayRoleTeleport, type=5; PlayCasterBindEffect,effectID=160191103; PlayCasterTurnToPlayer; Wait,waitTime=50; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayCasterAnimation,animName=AtkUlt1; PlayCasterBindEffect,effectID=160191110; PlayCasterBindEffect,effectID=160191111; Wait,waitTime=150; PlayAudio,audioID=2618,audioType=1; Wait,waitTime=1000; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000;"
    }
  }
}
return config, "ID", key
