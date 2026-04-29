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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1600601,waitTime = 2000; "
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
      " PlayAudio,audioID = 2654,audioType=1; PlayTurnToPickUpPosDirection,pickUpIndex=1; PlayCasterBindEffect,effectID =160204111; PlayCasterBindEffect,effectID =160204112; PlayCasterMaterialAnim,animName=eff_1602041_atkult_rongjie_in; PlayCasterAnimation,animName = AtkUlt; Wait,waitTime=1267; PlayShowCasterOnPickPosWithOff,disToPickPos=-2; Wait,waitTime=767; PlayShowCasterOnPickPosWithOff,reset=1; Wait,waitTime=1000; "
    }
  },
  {
    3,
    3,
    0,
    1,
    2,
    0,
    {
      " PlayBeHitEffectAtPickUpMonster,hitEffectID=160204113; "
    }
  },
  {
    4,
    4,
    0,
    1,
    2,
    1700,
    {
      " DataSelectBuff,buffIndex=1; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=3002040,label=buffAgain; PlayTargetAddBuff,buffID=3002041; PlayTargetAddBuff,buffID=3002042; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; "
    }
  },
  {
    5,
    5,
    0,
    2,
    1,
    1680,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetTurnToCaster; Jump,condition=CheckBuffIndexValid,result=0,goto=phaseEnd; PlayTargetAddBuff,buffID=43002042,label=buffAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffAgain; "
    }
  },
  {
    6,
    6,
    0,
    2,
    1,
    1700,
    {
      " DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; "
    }
  }
}
return config, "ID", key
