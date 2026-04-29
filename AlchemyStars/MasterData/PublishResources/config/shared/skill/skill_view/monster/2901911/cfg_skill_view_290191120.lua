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
      " PlayTurnToTeleportNewPos; PlayCasterAnimation,animName = Skill02; PlayAudio,audioID=6175,audioType=1; PlayCasterBindEffect,effectID=3430; PlayCasterMaterialAnim,animName=effanim_2901911_skill02_body01; "
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
      " Wait,waitTime=200; PlayEffectTeleportNewPos,effectID=3431,useCasterDir=1; Wait,waitTime=300; PlayCasterAnimation,animName = Skill022; PlayCasterBindEffect,effectID=3432; PlayTeleportAsMoving,time=100; PlayCasterMaterialAnim,animName=effanim_2901911_skill02_body03; PlayCasterBindEffect,effectID=3433; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " Wait,waitTime=400; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3434,turnToTarget=1; "
    }
  }
}
return config, "ID", key
