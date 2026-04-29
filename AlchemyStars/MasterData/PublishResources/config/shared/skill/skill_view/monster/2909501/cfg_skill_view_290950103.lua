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
      " PlayCasterAnimation,animName = Death1; Wait,waitTime=1833; PlayCasterAnimation,animName = Transport; PlayCasterBindEffect,effectID=290950102; PlayTeleportTargetAsMoving,time=1000,oriOffSetX=1,oriOffSetY=1; PlayChangeBodyArea; Wait,waitTime=1200; PlayAudio,audioID = 29095012,audioType=1; PlayAllHitBack; Wait,waitTime=500; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1960,
    {
      " PlayCasterBindEffect,effectID=290950106; PlayEntityLegacyAnimation,animNames=effanim_2909501_skill_jitui,casterEffectID=290950106; Wait,waitTime=2500 "
    }
  }
}
return config, "ID", key
