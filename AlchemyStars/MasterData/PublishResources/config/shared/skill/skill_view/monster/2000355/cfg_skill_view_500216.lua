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
    51,
    1,
    0,
    0,
    {isPlay = false}
  },
  {
    2,
    2,
    0,
    1,
    1,
    33,
    {
      " PlayAudio,audioID = 5065,audioType=1; PlayCasterAnimation,animName=Charge; PlayCasterEffectHolder,effHolderType=Idle,isShow=0; PlayCasterEffectHolder,effHolderType=Charge,isShow=1; PlayCasterEffectHolder,effHolderType=Invincible,isShow=0; EffectHolderLegacyAnimation,effHolderType=Permanent,animNames=eff_2900391_red; Wait,waitTime=2000; PlayMonsterStoryTips,prob=100,tipsList=(290039102); "
    }
  },
  {
    3,
    3,
    29,
    1,
    1,
    2000,
    {
      warningCenterPosType = 2,
      warningCenterPosParam = {
        [1] = {x = 1.5, y = 4.5},
        [2] = {x = 3.5, y = 6.5},
        [3] = {x = 3.5, y = 2.5},
        [4] = {x = 7.5, y = 6.5},
        [5] = {x = 6.5, y = 1.5},
        [6] = {x = 8.5, y = 3.5}
      },
      warningTextEffectID = 339,
      areaRes = ""
    }
  }
}
return config, "ID", key
