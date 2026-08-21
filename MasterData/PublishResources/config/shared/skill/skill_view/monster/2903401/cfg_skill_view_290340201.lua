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
      " PlayCasterAnimation,animName=Skill01_a; PlayAudio,audioID=6229,audioType=1; PlayCasterBindEffect,effectID=290340113; Wait,waitTime=500; PlayCasterShowLineRenderer,show=0; PlayRoleTeleport,type=3; PlayCasterControlGridDown,enable=0; PlayCasterControlOutLine,enable=0; PlayCasterHUDVisible,visible=0; PlayRoleTeleport,type=5, onlySelf=1; Wait,waitTime=500; PlayCasterTurnToPlayer; PlayCasterBindEffect,effectID=290340113; Wait,waitTime=300; PlayRoleTeleport,type=6, onlySelf=1; PlayCasterControlGridDown,enable=1; PlayCasterControlOutLine,enable=1; PlayCasterHUDVisible,visible=1; PlayCasterShowLineRenderer,show=1; PlayAudio,audioID=6229,audioType=1; PlayCasterAnimation,animName=Skill01_b2; Wait,waitTime=1300; "
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
      " DataSelectDamage,damageIndex = 1; PlayCasterTurnToTarget; PlayCasterBindEffect,effectID=290340109; PlayCasterBindEffect,effectID=290340108; Wait,waitTime=800; PlayAudio,audioID=6232,audioType=1; PlayCasterAnimation,animName=Skill04; PlayWaitWithCasterAndTargetDis,baseTime=1930,oneGridTime=33; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290340107,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
