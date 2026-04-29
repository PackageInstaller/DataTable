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
      " PlayCasterVisible,visible=1; PlayCasterAnimation,animName=birth; PlayAudio,audioID = 29091011,audioType=1; PlayCasterMaterialAnim,animName=effanim_2909101_birth; PlayCasterBindEffect,effectID=290910110; Wait,waitTime=2500; PlayCasterBindEffect,effectID=290910109; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
