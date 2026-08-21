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
      " Wait,waitTime=800; PlayCasterMaterialAnim,animName=effanim_2904701_buff_red; PlayAudio,audioID=6271,audioType=1; "
    }
  }
}
return config, "ID", key
