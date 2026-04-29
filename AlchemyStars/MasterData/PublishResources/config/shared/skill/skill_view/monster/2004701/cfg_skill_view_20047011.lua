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
      " PlayCasterAnimation,animName =Atk; PlayCasterMaterialAnim,animName=effanim_2004701_skill01; PlayCasterBindEffect,effectID=200470101; Wait,waitTime=500; PlayAudio,audioID=2507,audioType=1; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=200470103,turnToTarget=1,deathClear=0; "
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
      " PlayRoleTeleport, type=3; PlayEffectTeleportNewPos , effectID=200470102,useCasterDir=1; Wait,waitTime=500; PlayRoleTeleport, type=5; PlayRoleTeleport, type=6; PlayCasterMaterialAnim,animName=effanim_2004701_skill01_2; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
