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
      " DataSelectDamage,damageIndex = 1; PlayCasterMaterialAnim,animName=2901001_shader_effects_appear; PlayAudio,audioID =6120,audioType=1; PlayRoleTeleport,type=5, onlySelf=1; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterTurnToTarget; PlayEffectAGridPos,effectID=3045,gridPosX=5,gridPosY=5,gridDirX=0,gridDirY=0; Wait,waitTime=150; PlayCasterAnimation,animName = Skill02; PlayAudio,audioID = 6118,audioType=1; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayCasterBindEffect,effectID=PARAM.effectID2; Wait,waitTime=1030; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
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
      " PlaySummonTrap,trapID=60,effectID=PARAM.effectID3; "
    }
  },
  {
    3,
    3,
    38,
    1,
    0,
    0,
    {
      effectIDList = {3062}
    }
  }
}
return config, "ID", key
