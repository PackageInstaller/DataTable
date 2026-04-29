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
      " PlayCasterAnimation,animName=Death; PlayCasterMaterialAnim,animName=eff_2900912_death; PlayCasterBindEffect,effectID =3029; PlayAudio,audioID = 6060,audioType=1; PlaySummonTrap,trapID=2800341; PlaySummonTrap,trapID=2800342; Wait,waitTime=2500; "
    }
  }
}
return config, "ID", key
