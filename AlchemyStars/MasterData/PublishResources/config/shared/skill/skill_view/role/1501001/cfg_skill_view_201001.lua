local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      "PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2262,audioType=1; PlayCasterBindEffect,effectID=2287; PlayCasterBindEffect,effectID=2288; Wait,waitTime=700; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2289,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2200; "
    }
  }
}
return config, "ID", key
