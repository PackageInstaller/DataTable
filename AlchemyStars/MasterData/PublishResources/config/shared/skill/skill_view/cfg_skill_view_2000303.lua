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
      " PlayCasterHUDVisible,visible=0; PlayCasterBindEffect,effectID=200030101; PlayCasterMaterialAnim,animName=effanim_2000301_death; DataSelectResult,effectType=36,index=1; PlayFlyEffectCasterToTarget,flyEffectID=200030102,flyTime=500,flyTrace=2,offsetx=-0.27,offsety=0.5,offsetz=0.12,flyEaseType= InCirc,targetPos=Hit; Wait,waitTime=650; PlayTargetBindEffect,effectID=200030103; PlayTargetMaterialAnim,animName=effanim_2900271_shield; PlayAddHpText; "
    }
  }
}
return config, "ID", key
