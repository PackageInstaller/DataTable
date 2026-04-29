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
      " PlayAudio,audioID=6183,audioType=1; PlaySwitchBodyArea,leftAnim=Skill03_2,rightAnim=Skill03_1,turnAnim=Skill03_3,leftAnimLen=1400,rightAnimLen=1400,turnAnimLen=1600; Wait,waitTime=500; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=600; PlayCasterBindEffect,effectID=3530; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
