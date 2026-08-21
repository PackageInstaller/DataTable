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
      "PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1400071,waitTime = 2000;"
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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterMaterialAnim,animName=eff_1400071_atkult_weapon_new; PlayAudio,audioID = 2217,audioType=1; PlayEffectAtCasterPos, effectID=1843; Wait,waitTime=700; PlayEffectCrossToGridEdges,effectID=1844,waitTimeStart=400,waitTimeEnd=1600; Wait,waitTime=800; StopCasterMaterialAnim,animName=eff_1400071_atkult_weapon_new; Wait,waitTime=800; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    1133,
    {
      "DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1845,turnToTarget=0,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=500;"
    }
  }
}
return config, "ID", key
