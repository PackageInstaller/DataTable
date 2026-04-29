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
      " PlayCasterBindEffect,effectID=3278; PlayAudio,audioID=6138,audioType=1; PlayCasterAnimation,animName=birth; PlayCasterMaterialAnim,animName=eff_2901801_birth_in; PlayCasterVisible,visible=1; PlayCasterHUDVisible,visible=1; Wait,waitTime=3000; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " PlaySummonOnFixPosLimit,isDestroy=1; DataSelectSummonOnFixPos,index=1; PlayCasterTurnToTargetGrid,label=redoShow; PlayCasterAnimation,animName=Skill03; PlayCasterBindEffect,effectID=3283; PlayAudio,audioID=6142,audioType=1; Wait,waitTime=1000; PlayFlyEffectCasterToTarget,flyEffectID=3283,flyTime=600,flyTrace=1,originalBoneName=Bip001 L Hand,isBlock=1; PlayEffectAtTargetGrid,effectID=3284; PlayAudio,audioID=6143,audioType=1; Wait,waitTime=500; PlaySummonOnFixPosLimit,isDestroy=0; DataSelectNextSummonOnFixPos; Jump,condition=CheckSummonOnFixPosValid,goto=redoShow; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    0,
    {
      " PlayCasterTurnToPlayer; "
    }
  }
}
return config, "ID", key
