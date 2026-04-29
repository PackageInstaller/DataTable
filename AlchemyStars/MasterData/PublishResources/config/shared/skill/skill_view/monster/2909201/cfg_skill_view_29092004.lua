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
      " PlayCasterAnimation,animName = Atk01_1; PlayCasterBindEffect,effectID =290920113; PlayAudio,audioID = 290920102,audioType=1; Wait,waitTime=667; PlayTeleportAsMoving,speed=33; PlayRoleTeleport,type=9; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    280,
    {
      "DataSelectDamage,damageIndex = 1,damageStageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290920114,turnToTarget=1,deathClear=0; DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=29092006,label=doAgain; PlayTargetAddBuff,buffID=20021; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain;"
    }
  }
}
return config, "ID", key
