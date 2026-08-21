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
      " DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    300,
    {
      " PlayCasterAnimation,animName=Skill_01; PlayCasterMaterialAnim,animName=effanim_2909301_skil01; PlayAudio,audioID = 6231,audioType=1; Wait,waitTime=430; PlayCasterBindEffect,effectID=29093013; PlayCasterBindEffect,effectID=29093014; PlayTeleportAsMoving,time=500; PlayRoleTeleport,type=9; PlayCasterBindEffect,effectID=29093015; "
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    830,
    {
      " DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  },
  {
    4,
    4,
    0,
    2,
    2,
    2500,
    {
      " PlayTeamHUDVisible,visible=0; Wait,waitTime=300; PlayPushBoard, dirX=0, dirY=-1; Wait,waitTime=1000; PlayTeamHUDVisible,visible=1; PlayRefreshAllHPPos,forceRefreshHPPercent=1; "
    }
  },
  {
    5,
    5,
    0,
    2,
    2,
    3500,
    {
      " PlaySummonTrap,trapID=2909301; "
    }
  },
  {
    6,
    6,
    0,
    2,
    2,
    3600,
    {
      " DataSelectBuff,buffIndex=1; PlayTargetAddBuff,buffID=2909302,label=doAgain; DataSelectNextBuff; Jump,condition=CheckBuffIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
