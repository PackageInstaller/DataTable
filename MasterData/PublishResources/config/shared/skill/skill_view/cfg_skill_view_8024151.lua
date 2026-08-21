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
      " PlayCasterAnimation,animName = Cure; PlaySkillCostFeatureStepPoint; PlayAudio,audioID = 5070,audioType=1; PlayCasterBindEffect,effectID =760; Wait,waitTime=1000; PlayAddHpText; Wait,waitTime=2500; "
    }
  }
}
return config, "ID", key
