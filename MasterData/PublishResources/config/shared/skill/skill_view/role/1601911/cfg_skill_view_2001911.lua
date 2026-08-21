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
      " PlayAudio,audioID = 2615,audioType=1; DataSelectResult,effectType=191,index=1; PlayCasterTurnToTargetGrid; PlayCasterMaterialAnim,animName=eff_1601911_atkchain_chuxian; PlayPetHatiChainJumpDamage, casterAnimateTrigger =AtkChain, hideEffectID=160191103, jumpTimeMs=460, landingTimeMs=700, mainEffectID=160191104, mainEffTimeMs=300, roundEffDelayFromStartMs=1070, roundDamageDelayMs= 10, roundGridEffectID= 160191105, resetPosEffectID=160191106, damageToHideTimeMs=750, hideToEffTimeMs=160, resetPosTimeMs=50; Wait,waitTime = 1000; "
    }
  },
  {
    2,
    2,
    0,
    1,
    1,
    460,
    {
      "PlayAudio,audioID = 2616,audioType=1;"
    }
  }
}
return config, "ID", key
