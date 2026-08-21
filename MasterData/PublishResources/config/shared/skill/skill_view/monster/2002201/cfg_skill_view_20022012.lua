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
      " PlayTrapMoveAndDamage,time=200,moveAni=SkillMove,idleAni=Idle,outAni=2002201_change_op,attackAni=2002201_change_op,hitDelayTime=0,attackAudioID=2043,hitAnimName=Hit,hitEffectID=200220102; Wait,waitTime=200; "
    }
  }
}
return config, "ID", key
