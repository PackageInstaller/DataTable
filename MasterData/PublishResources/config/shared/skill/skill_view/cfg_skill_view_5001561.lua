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
    100,
    {
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap,trapID=160156100; PlayDestroyTrap,trapID=160156101; PlayDestroyTrap,trapID=160156102; PlayDestroyTrap,trapID=160156103; PlayDestroyTrap,trapID=160156104; PlayDestroyTrap,trapID=160156105; PlayDestroyTrap,trapID=160156106; PlayDestroyTrap,trapID=160156107; PlayDestroyTrap,trapID=160156108; PlayDestroyTrap,trapID=160156109; PlayDestroyTrap,trapID=160156110; PlayDestroyTrap,trapID=160156111; "
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
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=wait,label=checkbuff; PlayTargetAddBuff,buffEffectType =430015601; PlayTargetAddBuff,buffEffectType =430015602; PlayTargetAddBuff,buffEffectType =4001561; PlayTargetAddBuff,buffEffectType =410156; PlayTargetAddBuff,buffEffectType =43001560; PlayTargetAddBuff,buffEffectType =43031560; PlayTargetAddBuff,buffEffectType =43061560; PlayTargetAddBuff,buffEffectType =43101560; PlayTargetAddBuff,buffEffectType =43131560; PlayTargetAddBuff,buffEffectType =43161560; PlayTargetAddBuff,buffEffectType =43201560; PlayTargetAddBuff,buffEffectType =43231560; PlayTargetAddBuff,buffEffectType =43261560; PlayTargetAddBuff,buffEffectType =43301560; PlayTargetAddBuff,buffEffectType =43331560; PlayTargetAddBuff,buffEffectType =43361560; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=checkbuff;"
    }
  }
}
return config, "ID", key
