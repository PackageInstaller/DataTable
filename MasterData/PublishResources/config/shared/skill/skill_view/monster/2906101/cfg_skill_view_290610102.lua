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
      " PlayTeamHUDVisible,visible=0; PlayAudio,audioID=7068,audioType=1; PlayCasterAnimation,animName=Skill02; PlayCasterBindEffect,effectID =290610107; Wait,waitTime=1070; PlayCasterBindEffect,effectID =290610108; PlayMarchForward,marchTime=300; Wait,waitTime=1000; PlayPushBoard, dirX=0, dirY=-1; Wait,waitTime=1000; PlayTeamHUDVisible,visible=1; "
    }
  }
}
return config, "ID", key
