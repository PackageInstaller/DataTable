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
      " DataSelectDamage,damageIndex = 1; PlayEffectAGridPos,effectID=3045,gridPosX=5,gridPosY=5,gridDirX=0,gridDirY=0; PlayAudio,audioID =6120,audioType=1; PlayAudio,audioID = 6117,audioType=1; Wait,waitTime=150; PlayRoleTeleport,type=5, onlySelf=1; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterTurnToTarget; PlayCasterMaterialAnim,animName=2901001_shader_effects_appear; PlayCasterAnimation,animName = Skill01; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayCasterBindEffect,effectID=PARAM.effectID2; Wait,waitTime=1030; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=PARAM.effectID3,turnToTarget=1,deathClear=0; Wait,waitTime=730; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    1000,
    {
      "PlayRoleTeleport,type=9;"
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
