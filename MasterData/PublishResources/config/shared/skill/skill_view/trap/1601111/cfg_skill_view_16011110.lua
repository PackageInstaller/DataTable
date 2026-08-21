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
      " PlayAudio,audioID = 2327,audioType=1; Wait,waitTime=210; PlayEffectAtCasterPos,effectID=2640; DataSelectDamage,damageIndex = 1; PlayCommonBeHit; Wait,waitTime=100; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,trapID=16011110; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    100,
    {
      "DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType =42011122; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff; Wait,waitTime=100;"
    }
  }
}
return config, "ID", key
