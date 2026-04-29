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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601431,waitTime = 2000; "
    }
  },
  {
    2,
    2,
    60,
    2,
    1,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 4},
        effectID = 160175107
      }
    }
  },
  {
    3,
    3,
    60,
    2,
    1,
    0,
    {
      [1] = {
        gridPos = {x = 5, y = 4},
        effectID = 160175114
      }
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    0,
    {
      " DataSelectResult,effectType=79,index=1; Jump,condition=CheckEffectResultIndex,param=79,goto=phaseEnd; PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2555,audioType=1; PlayCasterBindEffect,effectID=160175106; PlayEffectAtPickUpIndexGrid,effectID=160175110,pickUpIndex=1; Wait,waitTime=2200; PlaySummonTrap,trapID=16017511; PlaySummonTrap,trapID=16017512; PlaySummonTrap,trapID=16017513; PlaySummonTrap,trapID=16017514; Wait,waitTime=1000; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    0,
    {
      " DataSelectResult,effectType=11,index=1; Jump,condition=CheckEffectResultIndex,param=11,goto=phaseEnd; PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2556,audioType=1; PlayCasterBindEffect,effectID=160175106; PlayEffectAtPickUpIndexGrid,effectID=160175108,pickUpIndex=1; PlayEffectAtCasterPos,effectID=160175109; Wait,waitTime=2030; DataSelectResult,effectType=79,index=1; PlayDestroyTrap; Wait,waitTime=303; PlayAddHpText; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
