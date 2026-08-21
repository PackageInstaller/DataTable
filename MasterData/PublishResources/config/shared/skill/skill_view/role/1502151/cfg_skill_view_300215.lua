local key = {
  ID = 1,
  ViewPhase = 2,
  PhaseType = 3,
  DelayType = 4,
  DelayFromPhase = 5,
  DelayMS = 6,
  PhaseParam = 7,
  PhasePosDir = 8
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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_yellow.prefab,petID = 1601811,waitTime = 2000; "
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
      " PlayAudio,audioID = 150215104,audioType=1; PlayPet1502151RenderJump, casterAnim1=AtkUlt, casterAnim2=AtkUlt_1, casterAnim3=AtkUlt_2, casterAnimDelayMs1=0, casterAnimDelayMs2=627, casterAnimDelayMs3=1027, casterEffectID1=150215101, casterEffectDelayMs1=727, showHideEffectID1=150215102, showHideEffectID2=150215104, showHideEffectID3=150215105, showHideEffectID4=150215103, effectDelayMs1=400, effectDelayMs2=167, effectDelayMs3=810, effectDelayMs4=217, casterShowHideDelayMs1=467, casterShowHideDelayMs2=160, casterShowHideDelayMs3=867, casterShowHideDelayMs4=160, casterTeleportDelayMs1=627, casterTeleportDelayMs2=1027, centerEffectID=150215106, centerEffectDelayMs1=857, "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    627,
    {
      " PlayCasterSubMaterialAnim,nodeName=1502151_weapon,animName=eff_1502151_atkult_weapon; "
    }
  },
  {
    4,
    4,
    0,
    2,
    1,
    857,
    {
      " DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain; PlayForceMovement,speed=6; Wait,waitTime=200; PlaySummonTrap,trapID=2803501; "
    }
  }
}
return config, "ID", key
