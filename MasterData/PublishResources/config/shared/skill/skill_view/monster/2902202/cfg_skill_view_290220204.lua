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
      " PlayAudio,audioID=6186,audioType=1; Wait,waitTime=200; PlayCasterBindEffect,effectID=3523; PlayCasterAnimation,animName=Skill04; Wait,waitTime=1633; PlayRoleTeleport,type=5,onlySelf=1; PlayRoleTeleport,type=6; PlayCasterMaterialAnim,animName=eff_2902202_skill04_body; PlayCasterBindEffect,effectID=3556; Wait,waitTime=700; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
