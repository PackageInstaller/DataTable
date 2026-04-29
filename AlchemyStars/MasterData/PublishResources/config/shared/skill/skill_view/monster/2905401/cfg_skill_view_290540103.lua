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
      " PlayCasterHUDVisible,visible=0; PlayShowLineRenderer,show=0,selfAll=1,isTrap=1; PlayCasterBindEffect,effectID =290540117; PlayCasterMaterialAnim,animName=eff_2905401_skill03_out; Wait,waitTime=500; PlayAudio,audioID=6298,audioType=1; Wait,waitTime=1300; PlayCasterVisible,visible=0; Wait,waitTime=1500; PlayCasterVisible,visible=1; PlayShowLineRenderer,show=1,selfAll=1,isTrap=1; PlayCasterBindEffect,effectID =290540116; PlayCasterMaterialAnim,animName=eff_2905401_skill03_in; Wait,waitTime=1800; PlayCasterHUDVisible,visible=1; Wait,waitTime=1000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    0,
    {
      " Wait,waitTime=500; PlayJohuaTrapEffect,effectID=PARAM.boomEffect,startWait=500,intervalTime1=80,intervalEffect1=PARAM.geziEffect,intervalWait=1160,intervalTime2=40,intervalEffect2=290540111,trapIDList=2802201|2802202|2802203|2802204,materialAnim=PARAM.animName; "
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
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0; PlayTargetTurnToSelectTrap,trapIDList=2802201|2802202|2802203|2802204; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
