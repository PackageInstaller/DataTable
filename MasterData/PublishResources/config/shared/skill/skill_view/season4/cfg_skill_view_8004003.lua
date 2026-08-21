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
      " DataSelectDamage,damageIndex = 1; Wait,waitTime=300; PlayCasterMaterialAnim,animName=eff_2900681_skill02; PlayAudio,audioID = 6123,audioType=1; Wait,waitTime=550; PlayCasterBindEffect,effectID=3126; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; PlayCasterControlGridDown,enable=0; PlayCasterControlOutLine,enable=0; Wait,waitTime=200; Wait,waitTime=300; PlaySummonTrap,trapID=8004013; PlaySummonTrap,trapID=8004014; PlaySummonTrap,trapID=8004015; PlaySummonTrap,trapID=8004016; DataSelectResult,effectType=120,index=1; PlayDestroyMonster; "
    }
  },
  {
    2,
    2,
    0,
    1,
    0,
    0,
    {
      " Wait,waitTime=1050; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; "
    }
  }
}
return config, "ID", key
