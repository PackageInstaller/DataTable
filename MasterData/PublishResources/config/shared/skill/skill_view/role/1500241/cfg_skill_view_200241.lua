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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2239,audioType=1; PlayCasterBindEffect,effectID=2297; PlayCasterBindEffect,effectID=2299; PlayEffectCrossToGridEdges,effectID=2298,waitTimeStart=0,waitTimeEnd=1700; Wait,waitTime=800; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      "DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=2300,turnToTarget=0,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=500;"
    }
  }
}
return config, "ID", key
