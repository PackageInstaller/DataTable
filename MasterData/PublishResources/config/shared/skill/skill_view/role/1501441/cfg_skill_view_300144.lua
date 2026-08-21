local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1501441,waitTime = 2000;"
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
      " PlayEffectAtCasterPos, effectID=3400; PlayAudio,audioID = 2414,audioType=1; PlayEffectAGridPos,effectID=3401,gridPosX=5,gridPosY=5; PlayFormerLeaderMaterialAnim,animName=effanim_1501441_ult_01; PlayCameraEffect,effectID=3402; Wait,waitTime=1000; PlayFormerLeaderVisible,visible=0; StopCasterMaterialAnim,animName=effanim_1501441_ult_01; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = AtkUlt; PlayCasterMaterialAnim,animName=effanim_1501441_ult_02; Wait,waitTime=1000; StopCasterMaterialAnim,animName=effanim_1501441_ult_02; Wait,waitTime=4000; PlaySwapPetTeamOrder; "
    },
    {"", "1,-1"}
  }
}
return config, "ID", key
