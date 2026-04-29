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
      " PlayAudio,audioID = 6251,audioType=1; PlayCasterAnimation,animName=Skill01Start; PlayCasterBindEffect,effectID=290410101; PlayCasterBindEffect,effectID=290410102; PlayCasterMaterialAnim,animName=eff_2904101_skill01_main_role; Wait,waitTime=300; PlayRoleTeleport,type=3, onlySelf=1; PlayRoleTeleport,type=5, onlySelf=1; PlayCasterHUDVisible,visible=0; Wait,waitTime=500; PlayCasterTurnToPlayer; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterAnimation,animName=Skill01Trans; PlayCasterBindEffect,effectID=290410103; PlayCasterMaterialAnim,animName=eff_2904101_skill01_main_role01; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=29041011; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " Wait,waitTime=500; "
    }
  }
}
return config, "ID", key
