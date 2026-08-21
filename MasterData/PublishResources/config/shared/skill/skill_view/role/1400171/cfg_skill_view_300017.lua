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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1400171,waitTime = 2000; PlayAudio,audioID = 2115,audioType=1; PlayCasterBindEffect,effectID=399; PlayCasterAnimation,animName=AtkUlt; Wait,waitTime=1900; PlayRoleTeleport, type=3; PlayRoleTeleport, type=5, onlySelf=0; Wait,waitTime=1000; PlayRoleTeleport, type=6; PlayRoleTeleport, type=9; PlayCasterAnimation,animName=AtkUlt1; PlayCasterBindEffect,effectID=400; Wait,waitTime=500; DataSelectDamage,damageIndex = 1; DataSelectDamageInfo,damageInfoIndex=1,label=doAgain; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=398,turnToTarget=1,deathClear=0; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=2200; "
    }
  }
}
return config, "ID", key
