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
      " PlayAudio,audioID=290900101,audioType=1; PlayCasterAnimation,animName=Skill1_L; Wait,waitTime=750; PlayCasterBindEffect,effectID=200400101; PlayCrabMoveAndAttack,speed=4.5,hitEffectID=200400102,materialAnim=effanim_2004001_skill01_mat,baseHitTime=20,oneMoveHitTime=70; Wait,waitTime=700; "
    }
  }
}
return config, "ID", key
