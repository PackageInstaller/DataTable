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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1601211,waitTime = 2000;"
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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=160121405; PlayCasterBindEffect,effectID=3051; PlayAudio,audioID = 266600,audioType=1; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    0,
    {
      " PlayPet1601211Skin1601214Active; PlayCameraEffect, effectID=160121407; PlayHUDVisible,visible=0; UiBattleVisible,visible=0; Wait,waitTime=6000; PlayHUDVisible,visible=1; UiBattleVisible,visible=1; PlaySummonTrap,trapID=14,effectID=0; Wait,waitTime=500; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=0,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
