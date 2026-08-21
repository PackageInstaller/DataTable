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
      " PlayCasterAnimation,animName = Skill01; Wait,waitTime=500; PlayCasterBindEffect,effectID=PARAM.effectID1; DataSelectDamage,damageIndex = 1; PlayAudio,audioID = 7007,audioType=1; Wait,waitTime=1400; PlaySummonTrap,trapID=2000900; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
