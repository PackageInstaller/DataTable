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
    100,
    {
      " PlayCasterTurnToPlayer; PlayAudio,audioID=6293,audioType=1; DataSelectDamage,damageIndex = 1; PlayCasterBindEffect,effectID=290530110; PlayCasterAnimation,animName=Skill03_Start; PlayAudio,audioID=2615,audioType=1; Wait,waitTime=700; PlayRoleTeleport, type=5; Wait,waitTime=500; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayCasterTurnToPlayer; PlayCasterAnimation,animName=Skill03_End; Wait,waitTime=100; PlayCasterBindEffect,effectID=290530111; Wait,waitTime=100; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
