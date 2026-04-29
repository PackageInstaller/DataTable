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
      " PlaySuperMaterialAnim,animName=2901001_shader_effects_appear; Wait,waitTime=300; "
    }
  },
  {
    2,
    2,
    84,
    1,
    0,
    0,
    {
      teleportEffectID = 3045,
      teleportEffectDelay = 100,
      teleportAnimNameList = {
        "Skill03_1",
        "Skill03_2",
        "Skill03_3",
        "Skill03_4"
      },
      teleportOverTriggerName = {
        "Skill03_Over",
        "Skill03_Over",
        "Skill03_Over",
        "Skill03_Over"
      },
      gridEffectID = 2991,
      gridEffectDelay = 600,
      teleportWaitTime = 1000,
      audioID = 6119,
      audioDelay = 50,
      audioType = 1
    }
  },
  {
    3,
    3,
    0,
    2,
    2,
    1000,
    {
      "PlayRoleTeleport,type=9;"
    }
  },
  {
    4,
    4,
    38,
    2,
    1,
    0,
    {
      effectIDList = {3062}
    }
  }
}
return config, "ID", key
