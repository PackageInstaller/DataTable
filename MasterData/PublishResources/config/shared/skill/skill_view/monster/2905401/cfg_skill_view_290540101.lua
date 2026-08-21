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
      " PlayCasterAnimation,animName=Skill01; PlayCasterBindEffect,effectID =290540101; PlayCasterBindEffect,effectID =290540102; PlayCasterSubMaterialAnim,nodeName=2905401_weapon,animName=eff_2905401_skill01_weapon; Wait,waitTime=550; PlayAudio,audioID=6296,audioType=1; Wait,waitTime=300; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=290540103,turnToTarget=1,deathClear=0; Wait,waitTime=1000; "
    }
  }
}
return config, "ID", key
