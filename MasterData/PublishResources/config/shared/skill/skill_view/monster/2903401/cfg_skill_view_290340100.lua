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
      " PlayCasterControlGridDown,enable=0; PlayCasterControlOutLine,enable=0; PlayEffectAGridPos,effectID=290340110,gridPosX=5,gridPosY=5,gridDirX=0,gridDirY=0;PlayAudio,audioID = 6227,audioType=1; Wait,waitTime=400; PlayMonsterTrajectoryBirth,effectID=290340114,pos=5|5,offset=0|0.7|0,flyTime=1000,block=0; Wait,waitTime=800; PlayCasterBindEffect,effectID=290340111; PlayCasterBindEffect,effectID=290340106; PlayCasterVisible,visible=1; PlayCasterMaterialAnim,animName=effanim_2903401_birth; PlayCasterAnimation,animName = Birth; Wait,waitTime=350; PlayCasterHUDVisible,visible=1; PlayCasterControlGridDown,enable=1; PlayCasterControlOutLine,enable=1; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
