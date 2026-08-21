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
      " PlayCasterRenderState,renderState=2,caster=Board; PlayCasterLegacyAnimation,animNames=eff_2800221_huode; PauseMove, matchers=MonsterID|PetPstID, moveAnim=1; "
    }
  },
  {
    2,
    2,
    0,
    2,
    1,
    0,
    {
      " DataSelectDamage,damageIndex = 1; PlayCasterEffectAtTargetPos,effectID=1402,randomDir=0,bone=EffectSlot; Wait,waitTime=460; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0; PlayAudio,audioID = 7001,audioType=1; "
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
      " ResumeMove, matchers=MonsterID|PetPstID, moveAnim=1; DataSelectResult,effectType=79,index=1; PlayDestroyTrap; PlayCasterRenderState,renderState=0,caster=Board; "
    }
  }
}
return config, "ID", key
