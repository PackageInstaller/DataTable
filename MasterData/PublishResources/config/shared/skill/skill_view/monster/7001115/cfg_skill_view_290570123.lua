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
      " PlayCasterAnimation,animName = skill013; PlayAudio,audioID = 7055,audioType=1; PlayCasterMaterialAnim,animName=eff_2905701_skill01_in_mat; PlayCasterBindEffect,effectID=290570114; Wait,waitTime=1200; PlayRoleTeleport,type=3,onlySelf=0; PlayRoleTeleport,type=5,onlySelf=0; Wait,waitTime=300; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1500,
    {
      "PlayAudio,audioID = 7058,audioType=1; PlayCasterBindEffect,effectID=290570115; Wait,waitTime=1500; PlayRoleTeleport,type=6,onlySelf=0; PlayCasterAnimation,animName = skill03; PlayCasterMaterialAnim,animName=effanim_2905701_skill03_main; Wait,waitTime=2400; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;"
    }
  },
  {
    3,
    3,
    0,
    1,
    1,
    1500,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=70011156,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
