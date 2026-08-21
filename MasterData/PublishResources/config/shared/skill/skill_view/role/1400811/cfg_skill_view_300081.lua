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
      "PlaySkillCGEffect,effectRes = eff_ui_cutin_red.prefab,petID = 1600251,waitTime = 2000;"
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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=1761; PlayAudio,audioID = 3074,audioType=1; Wait,waitTime=800; PlayMultiTraction; PlayCasterVisible,visible=0; DataSelectDamage,damageIndex = 1; Wait,waitTime=600; PlayRandomBindEffectOnAnyTarget,effectIDArray=1762|1763|1764,label=doAgain; PlayAudio,audioID = 3075,audioType=1; PlayTargetTurnToCaster; PlayTargetBeHitEffect,hitEffectID=1765; Wait,waitTime=150; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=800; PlayCasterVisible,visible=1; PlayCasterAnimation,animName = AtkUlt2; PlayCasterBindEffect,effectID=1766; PlayAudio,audioID = 3076,audioType=1; Wait,waitTime=500; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1767,turnToTarget=1,deathClear=0,label=doAgain2; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain2; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
