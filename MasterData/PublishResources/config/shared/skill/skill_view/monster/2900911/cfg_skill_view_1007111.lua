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
      " PlayCasterVisible,visible=1; PlayTurnToSpecifiedDir,dirX=0,dirY=-1; PlayCasterAnimation,animName=Reborn; PlayCasterBindEffect,effectID =3030; PlayAudio,audioID = 6113,audioType=1; Wait,waitTime=1500; DataSelectDamage,damageIndex=1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; DataSelectResult,effectType=79,index=1; PlayDestroyTrap,label=foreach; DataSelectNextResult,effectType=79; Jump,condition=CheckEffectResultIndex,param=79,goto=foreach; Wait,waitTime=1500; "
    }
  }
}
return config, "ID", key
