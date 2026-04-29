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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_blue.prefab,petID = 1500331,waitTime = 2000;"
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
      " DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayAudio,audioID = 2151; PlayCasterAnimation,animName = AtkUlt01; PlayAudio,audioID = 3088,audioType=1; Wait,waitTime=600; PlayCasterBindEffect,effectID=1624; Wait,waitTime=233; "
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
      " DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayShowCasterOnCenter; PlayCasterBindEffect,effectID=1625; Wait,waitTime=500; PlayCasterBindEffect,effectID=1626; Wait,waitTime=800; PlayCasterBindEffect,effectID=1626; Wait,waitTime=200; PlayTargetBeHitEffect,hitEffectID=1631,randomDir=1,randomMin=90,randomMax=90; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; PlayAudio,audioID = 3089,audioType=1; DataSelectNextDamage; PlayCasterAnimation,animName = AtkUlt02; PlayCasterBindEffect,effectID=1629,label=ult_loop; PlayAudio,audioID = 3089,audioType=1; PlayTargetBeHitEffect,hitEffectID=1631,randomDir=1,randomMin=90,randomMax=90; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; Wait,waitTime=333; DataSelectNextDamage; Jump,condition=CheckIsLastDamage,result=0,goto=ult_loop; PlayCasterAnimation,animName = AtkUlt03; Wait,waitTime=400; PlayCasterBindEffect,effectID=1630; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1632,turnToTarget=1,deathClear=0; PlayAudio,audioID = 3090,audioType=1; Wait,waitTime=900; PlayCasterBindEffect,effectID=1627; Wait,waitTime=200; "
    },
    {"", "1,-1"}
  },
  {
    4,
    4,
    0,
    2,
    3,
    0,
    {
      " DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayShowCasterOnCenter,reset=1; PlayCasterBindEffect,effectID=1628; PlayAudio,audioID = 3091,audioType=1; Wait,waitTime=1500; "
    },
    {"", "0,1"}
  }
}
return config, "ID", key
