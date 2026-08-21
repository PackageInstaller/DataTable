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
      " PlaySkillHolderEffectOnBuffHolder,effectID=1619; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitEffectID=1621,turnToTarget=1,deathClear=0; PlayTargetAddBuff,buffID=20011; "
    }
  },
  {
    2,
    2,
    43,
    1,
    1,
    0,
    {
      audioID = 3086,
      atkSoundDelay = 0,
      longAtkSoundDelay = 160,
      audioType = 1
    }
  }
}
return config, "ID", key
