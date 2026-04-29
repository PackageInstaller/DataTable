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
      " PlayCasterRenderState,renderState=2,caster=Board; PlayCasterHUDVisible,visible=0; PlayCasterAnimation,animName=Death; PlayCasterBindEffect,effectID=PARAM.effectID1; PlayAudio,audioID =6068,audioType=1; Wait,waitTime=1000; PlayCasterMaterialAnim,animName=PARAM.materialEffectName; PlayWaveSummon,taskWaitTime=1000,flyDuration=1000,destroyTime=1400,eftID=PARAM.effectID2,eftPosYa=2.4,eftPosYb=0.7; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
