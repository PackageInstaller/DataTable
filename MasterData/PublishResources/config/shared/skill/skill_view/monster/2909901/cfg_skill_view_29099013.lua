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
      " PlayCasterAnimation,animName = Skill03; PlayCasterBindEffect,effectID=290990109; PlayCasterMaterialAnim,animName=eff_2909901_skill03_out; Wait,waitTime=1000; PlayAudio,audioID=29099017,audioType=1; Wait,waitTime=400; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterTurnToPlayer; PlayCasterMaterialAnim,animName=eff_2909901_skill03_in; PlayCasterBindEffect,effectID=290990110; "
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
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=291010104,turnToTarget=1,deathClear=0; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    500,
    {
      " DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
