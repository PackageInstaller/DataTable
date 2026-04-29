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
      " PlayCasterAnimation,animName=Skill03; PlayCasterBindEffect,effectID=PARAM.Disappear; PlayCasterMaterialAnim,animName=eff_2904101_skill01_main_role; Wait,waitTime=400; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterAddBornBuff; PlayCasterTurnToPlayer; PlayCasterBindEffect,effectID=PARAM.Appear; PlayCasterMaterialAnim,animName=eff_2904101_skill01_main_role01; PlayCasterAnimation,animName=Skill032; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    43,
    1,
    0,
    0,
    {audioID = 6247, audioType = 1}
  }
}
return config, "ID", key
