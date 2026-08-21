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
local common = {
  {"", "1,0"}
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
      " PlayCasterAnimation,animName = AtkChain; PlayAudio,audioID = 3054,audioType=1; PlayCasterBindEffect,effectID =1679; Wait,waitTime=2500; PlayCasterBindEffect,effectID =1680; "
    },
    common[1]
  },
  {
    2,
    2,
    0,
    1,
    1,
    1300,
    {
      " PlayFlyEffectCasterToTarget,flyEffectID = 1681,flySpeed = 133,flyTrace = 1,offsetx = -0.5,offsety = 2.5,isBlock = 0; PlayFlyEffectCasterToTarget,flyEffectID = 1681,flySpeed = 133,flyTrace = 1,offsetx = 0.8,offsety = 2.5,isBlock = 0; Wait,waitTime=67; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=1682,turnToTarget=1,deathClear=0,label=doAgain1; PlayTargetAddBuff,buffID=20021; PlayAudio,audioID = 3055,audioType=1; Wait,waitTime=200; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain1; "
    },
    common[1]
  },
  {
    3,
    3,
    0,
    2,
    2,
    300,
    {
      " Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
