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
      " PlayAudio,audioID=6253,audioType=1; PlayCasterBindEffect,effectID=290490103; PlayCasterMaterialAnim,animName=eff_2904901_idle_xiaoshi; Wait,waitTime=350; PlayRoleTeleport,type=3; PlayRoleTeleport,type=5; Wait,waitTime=250; PlayRoleTeleport,type=6; PlayCasterMaterialAnim,animName=eff_2904901_idle_chuxian; PlayCasterTurnToPlayer; PlayCasterBindEffect,effectID=290490104; Wait,waitTime=400; "
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
      " PlayAudio,audioID=6254,audioType=1; PlayCasterAnimation,animName=Skill01; PlayCasterBindEffect,effectID=290490105; Wait,waitTime=500; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=500; DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=290490101,label=buffLoop; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoop; Wait,waitTime=200; "
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
      " DataSelectBuff,buffIndex=1; PlayAddBuffView,buffID=290490102,label=buffLoopp; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=buffLoopp; Wait,waitTime=200; "
    }
  }
}
return config, "ID", key
