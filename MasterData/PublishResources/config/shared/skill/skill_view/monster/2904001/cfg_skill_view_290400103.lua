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
      " PlayAudio,audioID = 6245,audioType=1; StopCasterMaterialAnim,animName=eff_2904001_skin_@crazy; PlayCasterTurnToPlayer; PlayCasterAnimation,animName=Skill03; PlayCasterBindEffect,effectID=290400106; PlayEffectAGridPos,effectID=290400107,gridPosX=5,gridPosY=5,gridDirX=0,gridDirY=0; PlayCasterSubMaterialAnim,nodeName=2904001_weapon,animName=effanim_2904001_skill3_Object001; Wait,waitTime=3500; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=3900; "
    }
  },
  {
    2,
    2,
    38,
    1,
    1,
    0,
    {
      effectIDList = {290400109}
    }
  }
}
return config, "ID", key
