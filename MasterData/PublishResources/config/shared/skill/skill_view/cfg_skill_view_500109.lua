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
      " PauseMove, matchers=MonsterID|PetPstID, moveAnim=1; Jump,condition=CheckDamageIndexValid,result=0,goto=fight; DataSelectDamage,damageIndex = 1; PlayCasterAnimation,animName = Atk, label=fight; PlayAudio,audioID = 5069,audioType=1; PlayCasterBindEffect,effectID=564; PlayFlyEffectCasterToTarget,flyEffectID = 566,flySpeed = 50,flyTrace = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=570,turnToTarget=1,deathClear=true; Wait,waitTime=500; ResumeMove, matchers=MonsterID|PetPstID, moveAnim=1; "
    }
  }
}
return config, "ID", key
