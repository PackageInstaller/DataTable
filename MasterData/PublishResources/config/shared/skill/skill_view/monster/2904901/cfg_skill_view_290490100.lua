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
      " PlayAudio,audioID=6252,audioType=1; PlayHorsemanIntro,introModel=2904900.prefab,introAnimateTrigger=Birth,introMaterialAnimateName=eff_2904900_birth_xiaoshi,introEffectID=290490101,introStateTimeMs=1600,realIntroEffectID=290490102,realStateTimeMs=800,realMaterialAnimateName=eff_2904900_birth_chuxian; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; Wait,waitTime=1600; "
    }
  }
}
return config, "ID", key
