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
      " PlayCasterTurnToPlayer; PlayAudio,audioID=6292,audioType=1; DataSelectDamage,damageIndex = 1; PlayCasterBindEffect,effectID=290530108; PlayCasterAnimation,animName=Skill02; PlayCasterMaterialAnim,animName=effanim_2905301_skill02_body; PlayAudio,audioID=2615,audioType=1; Wait,waitTime=700; PlayRoleTeleport, type=5; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayCasterAnimation,animName=Skill02_2; Wait,waitTime=50; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290530109,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
