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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1600191,waitTime = 2000;"
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
      " PlayCasterAnimation,animName = AtkUlt; PlayAudio,audioID = 3038,audioType=1; PlayCasterBindEffect,effectID=1603; Wait,waitTime=3200; PlayCasterMeshVisible,visible=0,objs=1600191_body_d|1600191_face|1600191_weapon_d; PlayCasterMeshVisible,visible=0,objs=1600192_body_d|1600192_face|1600192_weapon_d; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    900,
    {
      " PlayCasterMeshVisible,visible=1,objs=1600191_body_d|1600191_face|1600191_weapon_d; PlayCasterMeshVisible,visible=1,objs=1600192_body_d|1600192_face|1600192_weapon_d; PlayAddHpText; Wait,waitTime=2500; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    3200,
    {
      " DataSelectDamage,damageIndex = 1; Jump,condition=CheckDamageIndexValid,result=0,goto=phaseEnd; PlayFlyEffectCasterToTarget,flyEffectID =1604,flyTime = 500,flyTrace = 1,isBlock =0,offsety=1.5,offsetz=0.3,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1605,turnToTarget=1,deathClear=0; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    24,
    2,
    1,
    4700,
    {
      targetType = 1,
      trajectoryType = 1,
      gridEffectID = 1604,
      startHigh = 0.53,
      endHigh = 0.53,
      flyTotalTime = 500,
      flySpeed = 50,
      finishDelayTime = 0,
      deltaAngle = 0
    }
  }
}
return config, "ID", key
