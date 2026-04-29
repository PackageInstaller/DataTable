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
      " DataSelectResult,effectType=120,index=1; PlayCasterHUDVisible,visible=0; PlayCasterControlGridDown,enable=0; PlayCasterControlOutLine,enable=0; PlayDestroyMonster; Wait,waitTime=800; "
    }
  }
}
return config, "ID", key
