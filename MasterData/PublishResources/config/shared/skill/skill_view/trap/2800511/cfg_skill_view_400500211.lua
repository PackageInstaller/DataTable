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
      " PlayCasterBindEffectWithTeleportDir,effectID=3251; PlayTeleportAsMoving,speed=2; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    1000,
    {
      " PlayAudio,audioID=8005,audioType=1; PlayCasterLaserGunAndExtend,effectID=3249,extendEffectID=3247,extendWaitTime=700; "
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
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=3310,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    2,
    2,
    0,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=PARAM.buffID1,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  },
  {
    5,
    5,
    38,
    2,
    3,
    0,
    {
      effectIDList = {3251}
    }
  },
  {
    6,
    6,
    0,
    2,
    5,
    0,
    {
      " Wait,waitTime=1000; "
    }
  },
  {
    7,
    7,
    36,
    2,
    2,
    0,
    {
      gridEffectID = 200230102,
      gridEffectDelayTime = 0,
      gridIntervalTime = 10,
      showTimeDelay = 0
    }
  }
}
return config, "ID", key
