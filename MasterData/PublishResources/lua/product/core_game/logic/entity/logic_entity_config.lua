require("logic_entity_id")
require("pet_info")
require("mission_info")
require("game_turn_type")
LogicEntityConfig = {
  [EntityConfigIDConst.Network] = {
    EntityConfigID = EntityConfigIDConst.Network,
    EntityConfigName = "Network",
    EntityConfigComponents = {
      EntityType = {Type = "Network"},
      CommandReceiver = {
        DispatcherType = "PlayerCommandDispatcher"
      },
      CommandSender = {
        PreHandlerType = "PlayerCommandPreHandler"
      }
    }
  },
  [EntityConfigIDConst.Board] = {
    EntityConfigID = EntityConfigIDConst.Board,
    EntityConfigName = "Board",
    EntityConfigComponents = {
      EntityType = {Type = "Board"},
      Board = {},
      BoardMulti = {},
      BoardSplice = {},
      BoardPush = {},
      AIRecorder = {},
      AffixData = {},
      LogicChessPath = {},
      LogicFeature = {},
      AuraRange = {},
      Talent = {},
      Mirage = {},
      PopStarLogic = {},
      Attributes = {
        {
          AttributeName = "San",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = -1
        },
        {
          AttributeName = "SanMax",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = -1
        },
        {
          AttributeName = "OverloadEnergy",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        }
      },
      ShareSkillResult = {},
      UnscaledCountDownLogic = {}
    }
  },
  [EntityConfigIDConst.Team] = {
    EntityConfigID = EntityConfigIDConst.Team,
    EntityConfigName = "Team",
    EntityConfigComponents = {
      EntityType = {Type = "Team"},
      HP = {
        MaxHP = 1000,
        HPOffset = {
          0.0,
          0.3,
          0
        }
      },
      Team = {},
      Alignment = {
        AlignmentType = AlignmentType.LocalPlayer
      },
      GameTurn = {
        gameTurnType = GameTurnType.LocalPlayerTurn
      },
      Element = {},
      BodyArea = {
        {0, 0}
      },
      Attributes = {
        {
          AttributeName = "HP",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "MaxHP",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "Defense",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "DefencePercentage",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "DefenceConstantFix",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "MaxHPPercentage",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "MaxHPConstantFix",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "AddBloodRate",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "FinalBehitDamageParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "ChangeTeamLeaderCount",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "ExBeHitElementParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "DmgParamSingleTypeSkill",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "SuperChainCountAddValue",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        }
      },
      Buff = {},
      BuffView = {},
      EffectAttached = {},
      LogicPickUp = {},
      LogicRoundTeam = {},
      LogicChainPath = {},
      ActiveSkill = {},
      FeatureSkill = {}
    }
  },
  [EntityConfigIDConst.Pet] = {
    EntityConfigID = EntityConfigIDConst.Pet,
    EntityConfigName = "Pet",
    EntityConfigComponents = {
      EntityType = {Type = "Pet"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = ""
      },
      GridLocation = {
        Pos = {4, 2},
        Dir = {0, 1}
      },
      Pet = {},
      PetRender = {},
      Alignment = {
        AlignmentType = AlignmentType.LocalPlayer
      },
      GameTurn = {
        gameTurnType = GameTurnType.LocalPlayerTurn
      },
      Element = {
        PrimaryType = ElementType.ElementType_Green
      },
      BodyArea = {
        {0, 0}
      },
      AttackArea = {
        Type = AttackAreaType.PlayerArea
      },
      MoveFSM = {FSMID = "1"},
      HP = {
        MaxHP = 1000,
        HPOffset = {
          0.0,
          0.3,
          0
        }
      },
      SkillInfo = {
        NormalSkillConfigID = 100001,
        SuperSkillConfigID = 10,
        ChainSkillConfigID = {
          [1] = {Chain = 6, Skill = 200011}
        }
      },
      RenderAttributes = {},
      Attributes = {
        {
          AttributeName = "HP",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 1000
        },
        {
          AttributeName = "MaxHP",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 1000
        },
        {
          AttributeName = "Attack",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 100
        },
        {
          AttributeName = "Defense",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 50
        },
        {
          AttributeName = "LegendPower",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "AlchemyPower",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "Power",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "MaxPower",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "Ready",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "PrimarySecondaryParam",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 1
        },
        {
          AttributeName = "AttackPercentage",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "AttackConstantFix",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "DefencePercentage",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "DefenceConstantFix",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "MaxHPPercentage",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "MaxHPConstantFix",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "NormalSkillParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "ChainSkillParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "ActiveSkillParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "NormalSkillIncreaseParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "ChainSkillIncreaseParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "ActiveSkillIncreaseParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "NormalSkillFinalParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "ChainSkillFinalParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "ActiveSkillFinalParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "SanSkillFinalParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "ExElementParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "ExBeHitElementParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "AddBloodRate",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "AfterDamage",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "ChainSkillReleaseFix",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "TrueDamageFixParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "FinalBehitDamageParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "AdditionalCritProb",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "AdditionalCritParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "SecondaryAttackParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = BattleConst.PetSecondaryParam
        },
        {
          AttributeName = "AllAttackParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = BattleConst.PetAllParam
        },
        {
          AttributeName = "ChainSkillReleaseMul",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        }
      },
      SkillPetAttackData = {},
      SkillRoutine = {},
      Buff = {},
      BuffView = {},
      PetPstID = {},
      SkillContext = {},
      MatchPet = {},
      EquipRefine = {}
    }
  },
  [EntityConfigIDConst.Monster] = {
    EntityConfigID = EntityConfigIDConst.Monster,
    EntityConfigName = "Monster",
    EntityConfigComponents = {
      EntityType = {Type = "Monster"},
      BlockFlag = {},
      Alignment = {
        AlignmentType = AlignmentType.Monster
      },
      GameTurn = {
        gameTurnType = GameTurnType.LocalPlayerTurn
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = ""
      },
      GridLocation = {
        Offset = {0.5, 0.5}
      },
      BodyArea = {
        {0, 0},
        {0, 1},
        {1, 0},
        {1, 1}
      },
      HP = {
        MaxHP = 1000,
        HPOffset = {
          0,
          0.0,
          0
        }
      },
      SkillInfo = {NormalSkillEntityID = 12},
      AttackArea = {
        Type = AttackAreaType.AIArea
      },
      Element = {
        PrimaryType = ElementType.ElementType_Blue
      },
      Attributes = {
        {
          AttributeName = "HP",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 1000
        },
        {
          AttributeName = "MaxHP",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 1000
        },
        {
          AttributeName = "Attack",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 50
        },
        {
          AttributeName = "Defense",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "Evade",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "Mobility",
          AttrModifyType = "MultModifyValue_Complex",
          DefaultValue = 0
        },
        {
          AttributeName = "MaxMobility",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 99
        },
        {
          AttributeName = "AttackPercentage",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "AttackConstantFix",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "DefencePercentage",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "DefenceConstantFix",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "MaxHPPercentage",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "MaxHPConstantFix",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "MonsterSkillParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "MonsterSkillIncreaseParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "MonsterSkillFinalParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "ExElementParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "ExBeHitElementParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "DamagePercentAmpfily",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "AddBloodRate",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "FinalBehitDamageParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "ControlIncrease",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "AbsorbNormal",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "AbsorbChain",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "AbsorbActive",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "AbsorbEmblem",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "FinalBehitByTeamLeaderDamageParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "FinalBehitByTeamMemberDamageParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "DmgParamSingleTypeSkill",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "AntiSkillEnabled",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 1
        },
        {
          AttributeName = "OriginalWaitActiveSkillCount",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "OriginalMaxAntiSkillCountPerRound",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "WaitActiveSkillCount",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "MaxAntiSkillCountPerRound",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "AntiActiveSkillType",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = {}
        }
      },
      SkillPetAttackData = {},
      SkillRoutine = {},
      Buff = {},
      BuffView = {},
      MonsterID = {},
      MonsterRender = {},
      SkillContext = {},
      EffectHolder = {},
      MonsterAreaOutline = {},
      DropAsset = {}
    }
  },
  [EntityConfigIDConst.PetShadow] = {
    EntityConfigID = EntityConfigIDConst.PetShadow,
    EntityConfigName = "PetShadow",
    EntityConfigComponents = {
      EntityType = {Type = "PetShadow"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = ""
      },
      Alignment = {
        AlignmentType = AlignmentType.LocalPlayer
      },
      GameTurn = {
        gameTurnType = GameTurnType.LocalPlayerTurn
      },
      GridLocation = {
        Pos = {4, 2},
        Dir = {0, 1}
      },
      BodyArea = {
        {0, 0}
      },
      AttackArea = {
        Type = AttackAreaType.PlayerArea
      },
      SkillPetAttackData = {},
      SkillRoutine = {},
      SkillContext = {}
    }
  },
  [EntityConfigIDConst.SkillHolder] = {
    EntityConfigID = EntityConfigIDConst.SkillHolder,
    EntityConfigName = "SkillHolder",
    EntityConfigComponents = {
      EntityType = {
        Type = "SkillHolder"
      },
      GridLocation = {
        Pos = {4, 2},
        Dir = {0, 1}
      },
      Alignment = {
        AlignmentType = AlignmentType.LocalPlayer
      },
      GameTurn = {
        gameTurnType = GameTurnType.LocalPlayerTurn
      },
      BodyArea = {
        {0, 0}
      },
      AttackArea = {
        Type = AttackAreaType.AIArea
      },
      SkillPetAttackData = {},
      SkillRoutine = {},
      SkillContext = {},
      Buff = {},
      BuffView = {}
    }
  },
  [EntityConfigIDConst.Trap] = {
    EntityConfigID = EntityConfigIDConst.Trap,
    EntityConfigName = "Trap",
    EntityConfigComponents = {
      EntityType = {Type = "Trap"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = ""
      },
      Alignment = {
        AlignmentType = AlignmentType.Monster
      },
      GameTurn = {
        gameTurnType = GameTurnType.LocalPlayerTurn
      },
      GridLocation = {},
      BodyArea = {
        {0, 0}
      },
      AttackArea = {
        Type = AttackAreaType.AIArea
      },
      HP = {
        MaxHP = 1,
        HPOffset = {
          0.0,
          0.7,
          0
        }
      },
      Buff = {},
      BuffView = {},
      Trap = {},
      TrapID = {},
      Attributes = {
        {
          AttributeName = "HP",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 1
        },
        {
          AttributeName = "MaxHP",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 1
        },
        {
          AttributeName = "TrapPower",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "TrapPowerMax",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "OneRoundLimit",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 1
        },
        {
          AttributeName = "CastSkillRound",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = {}
        },
        {
          AttributeName = "SkillCount",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "SkillCountMax",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "ShowSkillCostPower",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "CanBeAttacked",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "Mobility",
          AttrModifyType = "MultModifyValue_Complex",
          DefaultValue = 0
        },
        {
          AttributeName = "MaxMobility",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 99
        },
        {
          AttributeName = "Attack",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "AttackConstantFix",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "AttackPercentage",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "Defense",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "DefenceConstantFix",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "DefencePercentage",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "MaxHPConstantFix",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "MaxHPPercentage",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "TrapSkillIncreaseParam",
          AttrModifyType = "MultModifyValue_Mul",
          DefaultValue = 1
        },
        {
          AttributeName = "FinalBehitDamageParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "ChainSkillFinalParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        },
        {
          AttributeName = "TotalRound",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "CurrentRound",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 1
        },
        {
          AttributeName = "OpenState",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 1
        },
        {
          AttributeName = "SummonTrapLimit",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 0
        },
        {
          AttributeName = "ExElementParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "ExBeHitElementParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        }
      },
      RenderAttributes = {},
      SkillRoutine = {},
      SkillContext = {},
      EffectHolder = {},
      TrapRender = {},
      DropAsset = {}
    }
  },
  [EntityConfigIDConst.ChessPet] = {
    EntityConfigID = EntityConfigIDConst.ChessPet,
    EntityConfigName = "ChessPet",
    EntityConfigComponents = {
      EntityType = {Type = "ChessPet"},
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = ""
      },
      GridLocation = {
        Pos = {4, 2},
        Dir = {0, 1}
      },
      ChessPet = {},
      Alignment = {
        AlignmentType = AlignmentType.LocalPlayer
      },
      GameTurn = {
        gameTurnType = GameTurnType.LocalPlayerTurn
      },
      Element = {
        PrimaryType = ElementType.ElementType_Green
      },
      BodyArea = {
        {0, 0}
      },
      AttackArea = {
        Type = AttackAreaType.PlayerArea
      },
      HP = {
        MaxHP = 1000,
        HPOffset = {
          0.0,
          0.3,
          0
        }
      },
      RenderAttributes = {},
      Attributes = {
        {
          AttributeName = "HP",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 1000
        },
        {
          AttributeName = "MaxHP",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 1000
        },
        {
          AttributeName = "Attack",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 100
        }
      },
      SkillRoutine = {},
      Buff = {},
      BuffView = {},
      SkillContext = {},
      ChessPetRender = {}
    }
  },
  [EntityConfigIDConst.PersonaSkillHolder] = {
    EntityConfigID = EntityConfigIDConst.PersonaSkillHolder,
    EntityConfigName = "PersonaSkillHolder",
    EntityConfigComponents = {
      EntityType = {
        Type = "PersonaSkillHolder"
      },
      GridLocation = {
        Pos = {4, 2},
        Dir = {0, 1}
      },
      Alignment = {
        AlignmentType = AlignmentType.LocalPlayer
      },
      GameTurn = {
        gameTurnType = GameTurnType.LocalPlayerTurn
      },
      BodyArea = {
        {0, 0}
      },
      AttackArea = {
        Type = AttackAreaType.AIArea
      },
      SkillPetAttackData = {},
      SkillRoutine = {},
      SkillContext = {},
      Buff = {},
      BuffView = {},
      Attributes = {
        {
          AttributeName = "Attack",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 100
        },
        {
          AttributeName = "AttackPercentage",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        }
      },
      Element = {
        PrimaryType = ElementType.ElementType_Green
      }
    }
  },
  [EntityConfigIDConst.AutoBeadSkillHolder] = {
    EntityConfigID = EntityConfigIDConst.AutoBeadSkillHolder,
    EntityConfigName = "AutoBeadSkillHolder",
    EntityConfigComponents = {
      EntityType = {
        Type = "AutoBeadSkillHolder"
      },
      Asset = {
        AssetType = "NativeUnityPrefabAsset",
        ResPath = "pfb_2005001.prefab"
      },
      GridLocation = {
        Pos = {4, 2},
        Dir = {0, 1}
      },
      Alignment = {
        AlignmentType = AlignmentType.LocalPlayer
      },
      GameTurn = {
        gameTurnType = GameTurnType.LocalPlayerTurn
      },
      BodyArea = {
        {0, 0}
      },
      AttackArea = {
        Type = AttackAreaType.AIArea
      },
      SkillPetAttackData = {},
      SkillAutoBeadAttackData = {},
      SkillRoutine = {},
      SkillContext = {},
      Buff = {},
      BuffView = {},
      Attributes = {
        {
          AttributeName = "Attack",
          AttrModifyType = "MultModifyValue_Last",
          DefaultValue = 100
        },
        {
          AttributeName = "AttackPercentage",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 0
        },
        {
          AttributeName = "AutoBeadSkillFinalParam",
          AttrModifyType = "MultModifyValue_Add",
          DefaultValue = 1
        }
      },
      Element = {
        PrimaryType = ElementType.ElementType_Green
      },
      LogicAutoBead = {}
    }
  }
}
