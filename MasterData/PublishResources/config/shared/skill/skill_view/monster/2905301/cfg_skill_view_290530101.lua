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
      " PlayCasterMaterialAnim,animName=effanim_2905301_skill01_body; PlayAudio,audioID=6291,audioType=1; PlayCasterTurnToPlayer; PlayCasterBindEffect,effectID=290530105; PlayCasterAnimation,animName=Skill01; Wait,waitTime=1200; DataSelectDamage,damageIndex=1; PlayEffectAtTargetGrid,effectID=290530106; Wait,waitTime=100; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlaySummonMeantimeLimit,forceMeanTime=1; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
