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
      " PlayCasterAnimation,animName = AtkUlt02; Wait,waitTime=300; PlayEffectAtPickUpIndexGrid,effectID=3503,pickUpIndex=1; Wait,waitTime=1000; PlayEffectAtPickUpIndexGrid,effectID=35051,pickUpIndex=1; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {audioID = 2440, audioType = 1}
  },
  {
    3,
    3,
    0,
    1,
    1,
    1300,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
