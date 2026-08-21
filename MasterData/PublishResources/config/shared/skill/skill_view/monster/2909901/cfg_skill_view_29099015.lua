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
      " PlayCasterBindEffect,effectID=290990102; PlayCasterMaterialAnim,animName=effanim_2909901_buff_main02_m; PlayAudio,audioID=29099013,audioType=1; Wait,waitTime=3000; PlayAddHpText; Wait,waitTime=1000; DataSelectSummonThing,index=1; ShowSummonThing,label=redoShow; DataSelectNextSummonThing; Jump,condition=CheckSummonThingValid,goto=redoShow; Wait,waitTime=2000; "
    }
  }
}
return config, "ID", key
