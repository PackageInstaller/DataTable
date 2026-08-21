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
      "PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 2601,audioType=1; PlayCasterBindEffect,effectID=150190105; PlayCasterBindEffect,effectID=150190108; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    550,
    {
      " DataSelectDamage,damageIndex=1; PlayMataiChainDamage,casterEffectID=150190106,defenderEffectDelayMs=0,defenderEffectID=150190109,hitDelayMs=750,hitAnimName=Hit,hitEffectID=150190107,turnToTarget=1,deathClear=0,label=doAgain,waitBeHitFinish=1; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2500; "
    }
  }
}
return config, "ID", key
