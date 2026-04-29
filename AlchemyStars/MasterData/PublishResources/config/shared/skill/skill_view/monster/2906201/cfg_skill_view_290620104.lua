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
      " PlayCasterBindEffect,effectID=290620109; PlayAudio,audioID=290920106,audioType=1; PlayCasterMaterialAnim,animName=eff_2906201_skill01_main02; Wait,waitTime=600; PlayCasterRenderTeleportToTeamPos,dirType=2; PlayCasterMaterialAnim,animName=eff_2906201_skill01_main01; PlayCasterAnimation,animName = Atk01; PlayCasterBindEffect,effectID=290620110; Wait,waitTime=561; PlayCasterBindEffect,effectID=290620108; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=2000; "
    }
  },
  {
    2,
    2,
    34,
    1,
    1,
    1261,
    {
      gridEffectDelayTime = 0,
      gridIntervalTime = 0,
      showTimeDelay = 0
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
      " PlayCasterBindEffect,effectID=290620109; PlayCasterMaterialAnim,animName=eff_2906201_skill01_main02; Wait,waitTime=500; PlayRoleTeleport, type=3; Wait,waitTime=200; PlayRoleTeleport, type=5; PlayRoleTeleport, type=6; PlayCasterMaterialAnim,animName=eff_2906201_skill01_main01; PlayCasterBindEffect,effectID=290620110; "
    }
  }
}
return config, "ID", key
