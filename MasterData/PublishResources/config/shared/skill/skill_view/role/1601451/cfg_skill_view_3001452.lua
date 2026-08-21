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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601451,waitTime = 2000;"
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
      " DataSelectResult,effectType=11,index=1; Jump,condition=CheckEffectResultIndex,param=11,goto=phaseEnd; DataSelectResult,effectType=8,index=1; PlayCasterTurnToTargetGrid; PlayCasterAnimation,animName = AtkUlt01; PlayEffectAtCasterPos,effectID=3424; PlayAudio,audioID = 2428,audioType=1; PlayRoleTeleport, type=3; PlayRoleTeleport, type=5, onlySelf=0; Wait,waitTime=100; PlayEffectAtCasterPos,effectID = 3425; PlayRoleTeleport, type=13; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayCasterAnimation,animName = AtkUlt02_1; Wait,waitTime=200; PlayCasterBindEffect,effectID=3428; Wait,waitTime=1500; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " DataSelectResult,effectType=8,index=1; Jump,condition=CheckEffectResultIndex,param=8,goto=phaseEnd; DataSelectResult,effectType=11,index=1; PlayCasterTurnToTargetGrid; PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 2426,audioType=1; PlayCasterBindEffect,effectID=3422; Wait,waitTime=1500; PlaySummonTrap,trapID=16014511; Wait,waitTime=1000; "
    }
  },
  {
    4,
    4,
    89,
    2,
    1,
    350,
    {
      hitAnim = "Hit",
      hitDelayTime = 760,
      hitEffectID = 3420,
      eachDamageTime = 50,
      trapGridEffID = 3426,
      trapStartDelay = 0,
      trapTrajectoryID = 3427,
      trapStartHeight = 0,
      trapEndHeight = 0,
      trapFlyTotalTime = 200
    }
  }
}
return config, "ID", key
