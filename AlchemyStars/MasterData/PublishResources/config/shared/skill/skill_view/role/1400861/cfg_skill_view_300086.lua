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
      " PlayAudio,audioID = 9037,audioType=1; PlaySkillCGEffect,effectRes = eff_ui_cutin_green.prefab,petID = 1400861,waitTime = 2000; "
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
      " PlayCasterAnimation,animName = AtkUlt; PlayCasterBindEffect,effectID=1744; PlayAudio,audioID = 3079,audioType=1; Wait,waitTime=460; PlayCasterBindEffect,effectID=1748; Wait,waitTime=700; PlayCasterBindEffect,effectID=1746; PlayCasterBindEffect,effectID=1749; Wait,waitTime=520; PlayCasterBindEffect,effectID=1745; PlayCasterBindEffect,effectID=1747; Wait,waitTime=2000; PlayCasterBindEffect,effectID=1750; PlayCasterBindEffect,effectID=1751; PlayCasterBindEffect,effectID=1752; PlayCasterBindEffect,effectID=1753; PlayCasterBindEffect,effectID=1754; Wait,waitTime=3600; "
    }
  },
  {
    3,
    3,
    0,
    2,
    1,
    5400,
    {
      " PlayAddHpText; PlaySummonTrap,trapID=14; "
    }
  }
}
return config, "ID", key
