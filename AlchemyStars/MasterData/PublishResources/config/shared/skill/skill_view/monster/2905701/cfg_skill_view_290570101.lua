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
      " PlayCasterAnimation,animName = skill01; PlayCasterMaterialAnim,animName=eff_2905701_skill01_in_mat; PlayAudio,audioID = 7055,audioType=1; Wait,waitTime=300; PlayCasterBindEffect,effectID=290570105; Wait,waitTime=1800; PlayRoleTeleport,type=3; PlayRoleTeleport,type=5; Wait,waitTime=500; PlayCasterBindEffect,effectID=290570107; Wait,waitTime=600; PlayRoleTeleport,type=6; PlayCasterAnimation,animName = skill01_1; PlayAudio,audioID = 7056,audioType=1; PlayCasterMaterialAnim,animName=eff_2905701_skill01_out_mat; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; Wait,waitTime=100; PlaySummonTrap,trapID=29057011; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
