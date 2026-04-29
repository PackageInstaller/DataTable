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
      " Wait,waitTime=1000; PlayCasterAnimation,animName =Revolve; PlayRubikCube,startWaitTime=1000,rotateTime=2000,startEffectID=3819,rotateEffectID=3820,completeEffectID=3821,glowEffectID1=3822,glowEffectID2=3823; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=1500; PlayAudio,audioID = 6207,audioType=1; "
    }
  }
}
return config, "ID", key
