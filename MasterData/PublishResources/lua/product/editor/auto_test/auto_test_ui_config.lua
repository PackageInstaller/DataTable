function GetAutoTestUIConfig()
  local cfg_pet = Cfg.cfg_pet({})
  
  local _pet_id_name = {}
  for petid, petcfg in pairs(cfg_pet) do
    if petcfg.Formal == 1 then
      local name = petcfg.FirstElement .. " " .. StringTable.Get(petcfg.Name)
      _pet_id_name[name] = petid
    end
  end
  local _team_name = {
    ["我方队伍"] = "team",
    ["敌方队伍"] = "enemy"
  }
  local _battle_result = {
    ["胜利"] = 1,
    ["失败"] = 0
  }
  local _dir_type = {
    ["北(0,1)"] = 1,
    ["东北(1,1)"] = 2,
    ["东(1,0)"] = 3,
    ["东南(1,-1"] = 4,
    ["南(0,-1)"] = 5,
    ["西南(-1,-1)"] = 6,
    ["西(-1,0)"] = 7,
    ["西北(-1,1)"] = 8
  }
  local _card_composition_type = {
    ["星月凌日ABC"] = FeatureCardCompositionType.ABC,
    ["类聚同明AAA"] = FeatureCardCompositionType.AAA,
    ["类聚同明BBB"] = FeatureCardCompositionType.BBB,
    ["类聚同明CCC"] = FeatureCardCompositionType.CCC,
    ["异色双辉AAB"] = FeatureCardCompositionType.AAB,
    ["异色双辉AAC"] = FeatureCardCompositionType.AAC,
    ["异色双辉BBA"] = FeatureCardCompositionType.BBA,
    ["异色双辉BBC"] = FeatureCardCompositionType.BBC,
    ["异色双辉CCA"] = FeatureCardCompositionType.CCA,
    ["异色双辉CCB"] = FeatureCardCompositionType.CCB
  }
  local Star3Name2ID = {
    ["完成关卡"] = BonusObjectiveType.NoAdditional,
    ["血量不低于X%"] = BonusObjectiveType.Health,
    ["剩余回合数不少于X"] = BonusObjectiveType.LastWaveRoundNum,
    ["释放X次超级连锁"] = BonusObjectiveType.SuperChainCount,
    ["释放X次主动技能"] = BonusObjectiveType.ActiveSkillCount,
    ["队伍中包含全部属性光灵"] = BonusObjectiveType.AllElementTeam,
    ["队伍中有X个Y属性光灵"] = BonusObjectiveType.SelectElement,
    ["消除X个Y属性格子"] = BonusObjectiveType.MatchNum,
    ["被Y机关攻击次数少于X"] = BonusObjectiveType.TrapAttackTimes,
    ["被Y机关攻击伤害少于X"] = BonusObjectiveType.TrapAttackDammage,
    ["被Y机关攻击总次数少于X"] = BonusObjectiveType.TrapAttackTotalTimes,
    ["被Y机关攻击总伤害少于X"] = BonusObjectiveType.TrapAttackTotalDamage,
    ["打碎X个Y机关"] = BonusObjectiveType.SmashTrapCount,
    ["总共打碎X个Y机关"] = BonusObjectiveType.SmashTrapTotalCount,
    ["累计消除Y个X属性格子"] = BonusObjectiveType.TotalMatchPropertyNum,
    ["一次性消除Y个X属性格子"] = BonusObjectiveType.OnceMatchPropertyNum,
    ["一次连线普攻次数达到X"] = BonusObjectiveType.OnceMatchNorAttTimes,
    ["使用X次转色技能"] = BonusObjectiveType.ColorSkillCount,
    ["进入X次极光时刻"] = BonusObjectiveType.AuroraTimeCount,
    ["玩家受到伤害小于X次"] = BonusObjectiveType.PlayerBeHitCount,
    ["使用助战完成关卡"] = BonusObjectiveType.CompelHelpPet,
    ["不用助战完成关卡"] = BonusObjectiveType.ForbidHelpPet,
    ["在指定回合数以内击杀所有指定的怪物"] = BonusObjectiveType.KillMonstersInLimitedRound,
    ["击杀N个带有特定buff的指定怪物"] = BonusObjectiveType.KillMonstersWithBuff,
    ["拾取指定物品"] = BonusObjectiveType.CollectItems,
    ["更换队长次数少于等于N"] = BonusObjectiveType.UIChangeTeamLeaderCount,
    ["被指定技能击中次数小于等于N"] = BonusObjectiveType.HitBySkill,
    ["阵亡友方单位数小于X"] = BonusObjectiveType.ChessDeadPlayerPawnCount,
    ["Boss血量不大于X%"] = BonusObjectiveType.BossHealth
  }
  local config = {
    LevelBasic = {
      [1] = {
        arg = "setup",
        style = "Label",
        text = "关卡基本配置",
        group = ActionGroupType.LevelSetup
      },
      [2] = {
        arg = "matchType",
        style = "Choose",
        text = "关卡类型",
        dict = MatchType
      },
      [3] = {
        arg = "levelID",
        style = "InputInt",
        text = "关卡ID",
        default = 1
      },
      [4] = {
        arg = "wordIds",
        style = "InputIntList",
        text = "词缀列表"
      },
      [5] = {
        arg = "affixs",
        style = "InputIntList",
        text = "词条列表"
      },
      template = {
        setup = "LevelBasic",
        args = {
          matchType = 1,
          levelID = 1,
          wordIds = {},
          affixs = {}
        }
      }
    },
    SetLevelRoundCount = {
      [1] = {
        arg = "setup",
        style = "Label",
        text = "关卡回合数",
        group = ActionGroupType.LevelSetup
      },
      [2] = {
        arg = "levelRoundCount",
        style = "InputInt",
        text = "回合数"
      },
      template = {
        setup = "SetLevelRoundCount",
        args = {levelRoundCount = 99}
      }
    },
    SetLevelWaveIDList = {
      [1] = {
        arg = "setup",
        style = "Label",
        text = "关卡波次配置",
        group = ActionGroupType.LevelSetup
      },
      [2] = {
        arg = "waveIDList",
        style = "InputIntList",
        text = "波次ID列表"
      },
      template = {
        setup = "SetLevelWaveIDList",
        args = {
          waveIDList = {
            1,
            2,
            3
          }
        }
      }
    },
    Pet = {
      [1] = {
        arg = "id",
        style = "Choose",
        text = "光灵",
        dict = _pet_id_name
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "命名",
        default = "p1"
      },
      [3] = {
        arg = "level",
        style = "InputInt",
        text = "等级",
        default = 1
      },
      [4] = {
        arg = "grade",
        style = "InputInt",
        text = "觉醒",
        default = 0
      },
      [5] = {
        arg = "awakening",
        style = "InputInt",
        text = "突破",
        default = 0
      },
      [6] = {
        arg = "equiplv",
        style = "InputInt",
        text = "装备",
        default = 1
      },
      [7] = {
        arg = "equipRefineLv",
        style = "InputInt",
        text = "精炼",
        default = 0
      },
      template = {
        tag = "Pet",
        args = {
          id = 1600191,
          level = 1,
          grade = 0,
          awakening = 0,
          equiplv = 1,
          equipRefineLv = 0,
          name = "p1"
        }
      }
    },
    WaitGameFsm = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "等待操作结束",
        group = ActionGroupType.FakeInput
      },
      [2] = {
        arg = "id",
        style = "Choose",
        text = "等待状态",
        default = 5,
        dict = GameStateID
      },
      template = {
        action = "WaitGameFsm",
        args = {
          id = GameStateID.WaitInput
        }
      }
    },
    WaitGameOver = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "等待游戏结束",
        group = ActionGroupType.FakeInput
      },
      template = {
        action = "WaitGameOver",
        args = {}
      }
    },
    SetEntityHP = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "修改血量绝对值",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "hp",
        style = "InputInt",
        text = "绝对值",
        default = 9999999
      },
      template = {
        action = "SetEntityHP",
        args = {name = "team", hp = 999999}
      }
    },
    SetEntityHPPercent = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "修改血量百分比",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "percent",
        style = "InputFloat",
        text = "百分比"
      },
      template = {
        action = "SetEntityHPPercent",
        args = {name = "team", percent = 0.5}
      }
    },
    SetTeamPowerFull = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "修改队伍满蓝",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "name",
        style = "ChooseString",
        text = "选择队伍",
        dict = _team_name
      },
      template = {
        action = "SetTeamPowerFull",
        args = {name = "team"}
      }
    },
    SetTeamPosition = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "修改队伍位置",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "pos",
        style = "InputInt",
        text = "坐标",
        default = 502
      },
      template = {
        action = "SetTeamPosition",
        args = {pos = 505}
      }
    },
    SetEntityPosition = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "修改目标位置",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "pos",
        style = "InputInt",
        text = "坐标"
      },
      template = {
        action = "SetEntityPosition",
        args = {name = "e1", pos = 303}
      }
    },
    SetEntityAttack = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "修改目标攻击力",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "attack",
        style = "InputInt",
        text = "攻击力"
      },
      template = {
        action = "SetEntityAttack",
        args = {name = "p1", attack = 999999}
      }
    },
    SetEntityDefense = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "修改目标防御力",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "defense",
        style = "InputInt",
        text = "防御力"
      },
      template = {
        action = "SetEntityDefense",
        args = {name = "team", defense = 999999}
      }
    },
    SetEntityAttribute = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "修改目标数值",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "attr",
        style = "ChooseString",
        text = "选择属性",
        dict = BaseAttrDict
      },
      [4] = {
        arg = "val",
        style = "InputInt",
        text = "修改数值"
      },
      template = {
        action = "SetEntityAttribute",
        args = {
          name = "team",
          attr = "HP",
          val = 9999
        }
      }
    },
    AddMonster = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "添加怪物",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "命名",
        default = "m1"
      },
      [3] = {
        arg = "id",
        style = "InputInt",
        text = "怪物ID"
      },
      [4] = {
        arg = "pos",
        style = "InputInt",
        text = "坐标"
      },
      [5] = {
        arg = "dir",
        style = "Choose",
        text = "方向",
        dict = _dir_type
      },
      [6] = {
        arg = "disableai",
        style = "Check",
        text = "禁用AI",
        default = true
      },
      template = {
        action = "AddMonster",
        args = {
          id = 5100111,
          pos = 305,
          dir = 1,
          disableai = true,
          name = "e1"
        }
      }
    },
    KillAllMonsters = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "杀死全部怪物",
        group = ActionGroupType.CheatCommand
      },
      template = {
        action = "KillAllMonsters",
        args = {}
      }
    },
    AddBuffToEntity = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "给目标挂buff",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "buffID",
        style = "InputInt",
        text = "BuffID"
      },
      template = {
        action = "AddBuffToEntity",
        args = {name = "team", buffID = 10011}
      }
    },
    AddBuffToAllMonsters = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "所有怪物挂buff",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "buffID",
        style = "InputInt",
        text = "BuffID"
      },
      template = {
        action = "AddBuffToAllMonsters",
        args = {buffID = 10011}
      }
    },
    SetAllMonstersHPPercent = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "修改所有怪物血量百分比",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "percent",
        style = "InputFloat",
        text = "血量百分比"
      },
      template = {
        action = "SetAllMonstersHPPercent",
        args = {percent = 0.5}
      }
    },
    SetAllMonstersHP = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "修改所有怪物血量绝对值",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "value",
        style = "InputInt",
        text = "血量绝对值"
      },
      template = {
        action = "SetAllMonstersHP",
        args = {value = 1000}
      }
    },
    AddTrap = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "添加机关",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "命名",
        default = "t1"
      },
      [3] = {
        arg = "id",
        style = "InputInt",
        text = "机关ID"
      },
      [4] = {
        arg = "pos",
        style = "InputInt",
        text = "坐标"
      },
      [5] = {
        arg = "dir",
        style = "Choose",
        text = "方向",
        dict = _dir_type,
        default = 1
      },
      template = {
        action = "AddTrap",
        args = {
          id = 4,
          pos = 305,
          dir = 1,
          disableai = true,
          name = "e1"
        }
      }
    },
    SetPieceType = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "棋盘统一颜色",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "pieceType",
        style = "Choose",
        text = "颜色",
        dict = PieceType
      },
      template = {
        action = "SetPieceType",
        args = {pieceType = 3}
      }
    },
    SetOnePieceType = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "棋盘格子颜色",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "pos",
        style = "InputInt",
        text = "坐标"
      },
      [3] = {
        arg = "pieceType",
        style = "Choose",
        text = "颜色",
        dict = PieceType
      },
      template = {
        action = "SetOnePieceType",
        args = {pos = 505, pieceType = 3}
      }
    },
    SetEveryPieceType = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "棋盘指定颜色",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "pieceTypeArray",
        style = "InputString",
        text = "指定颜色",
        width = 500
      },
      template = {
        action = "SetEveryPieceType",
        args = {pieceTypeArray = ""}
      }
    },
    FakeInputChain = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "模拟划线",
        group = ActionGroupType.FakeInput
      },
      [2] = {
        arg = "chainPath",
        style = "InputIntList",
        text = "划线路径"
      },
      [3] = {
        arg = "pieceType",
        style = "Choose",
        text = "划线颜色",
        dict = PieceType
      },
      template = {
        action = "FakeInputChain",
        args = {
          chainPath = {502},
          pieceType = 1
        }
      }
    },
    FakeInputDoubleClick = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "模拟原地双击",
        group = ActionGroupType.FakeInput
      },
      template = {
        action = "FakeInputDoubleClick",
        args = {}
      }
    },
    FakeCastSkill = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "模拟释放大招",
        group = ActionGroupType.FakeInput
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "pickUpPos",
        style = "InputIntList",
        text = "点选位置"
      },
      [4] = {
        arg = "skillIndex",
        style = "InputInt",
        text = "技能序号"
      },
      template = {
        action = "FakeCastSkill",
        args = {
          name = "p1",
          pickUpPos = {504},
          skillIndex = 1
        }
      }
    },
    FakeCancelChainSkillCast = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "模拟取消传送门",
        group = ActionGroupType.FakeInput
      },
      template = {
        action = "FakeCancelChainSkillCast",
        args = {}
      }
    },
    FakeClickAutoFight = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "模拟点击自动战斗",
        group = ActionGroupType.FakeInput
      },
      template = {
        action = "FakeClickAutoFight",
        args = {}
      }
    },
    BlackFistFakeChainPath = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "黑拳赛敌方划线",
        group = ActionGroupType.FakeInput
      },
      [2] = {
        arg = "chainPath",
        style = "InputIntList",
        text = "划线路径"
      },
      [3] = {
        arg = "pieceType",
        style = "Choose",
        text = "划线颜色",
        dict = PieceType
      },
      template = {
        action = "BlackFistFakeChainPath",
        args = {
          chainPath = {505},
          pieceType = 1
        }
      }
    },
    BlackFistCastSkill = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "黑拳赛敌方大招",
        group = ActionGroupType.FakeInput
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "pickUpPos",
        style = "InputIntList",
        text = "点选位置"
      },
      template = {
        action = "BlackFistCastSkill",
        args = {
          name = "r1",
          pickUpPos = {505}
        }
      }
    },
    FakeDimensionDoorPickUp = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "模拟任意门点选",
        group = ActionGroupType.FakeInput
      },
      [2] = {
        arg = "pickUpPos",
        style = "InputInt",
        text = "点选位置"
      },
      template = {
        action = "FakeDimensionDoorPickUp",
        args = {pickUpPos = 505}
      }
    },
    CheckEntityChangeHP = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查目标血量变化",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "compare",
        style = "InputString",
        text = "比较方式",
        default = ">"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckEntityChangeHP",
        args = {
          trigger = 88,
          name = "e1",
          compare = ">"
        }
      }
    },
    CheckEntityHP = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查目标血量值",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "compare",
        style = "InputString",
        text = "比较方式",
        default = ">"
      },
      [4] = {
        arg = "hp",
        style = "InputInt",
        text = "比较血量",
        default = 0
      },
      [5] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckEntityHP",
        args = {
          trigger = 88,
          name = "e1",
          compare = ">",
          hp = 0
        }
      }
    },
    CheckCombo = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查普攻Combo变化",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "change",
        style = "InputInt",
        text = "变化值",
        default = "1"
      },
      [3] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckCombo",
        args = {trigger = 88, change = 2}
      }
    },
    CheckDoubleChain = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查二次连锁",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 89
      },
      template = {
        action = "CheckDoubleChain",
        args = {trigger = 89, name = "p1"}
      }
    },
    CheckEntityPos = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查目标位置",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "pos",
        style = "InputInt",
        text = "坐标"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckEntityPos",
        args = {
          trigger = 88,
          name = "e1",
          pos = 505
        }
      }
    },
    CheckPieceType = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查格子逻辑颜色",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "pos",
        style = "InputInt",
        text = "坐标"
      },
      [3] = {
        arg = "pieceType",
        style = "Choose",
        text = "期望颜色",
        dict = PieceType
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckPieceType",
        args = {
          trigger = 88,
          pos = 505,
          pieceType = PieceType.Blue
        }
      }
    },
    CheckGridTrap = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查格子上有机关",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "pos",
        style = "InputInt",
        text = "位置"
      },
      [3] = {
        arg = "trapIds",
        style = "InputIntList",
        text = "机关ID列表"
      },
      [4] = {
        arg = "exist",
        style = "Check",
        text = "是否存在",
        default = true
      },
      [5] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckGridTrap",
        args = {
          trigger = 88,
          pos = 505,
          trapIds = {14},
          exist = true
        }
      }
    },
    CheckTrapExist = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查场上存在机关",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "trapIds",
        style = "InputIntList",
        text = "机关ID列表"
      },
      [3] = {
        arg = "exist",
        style = "Check",
        text = "是否存在",
        default = true
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckTrapExist",
        args = {
          trigger = 88,
          trapIds = {14}
        },
        exist = true
      }
    },
    CheckEntityBuff = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查buffID",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "buffId",
        style = "InputInt",
        text = "buff ID"
      },
      [4] = {
        arg = "exist",
        style = "Check",
        text = "是否存在",
        default = true
      },
      [5] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckEntityBuff",
        args = {
          trigger = 88,
          name = "e1",
          buffId = 20011,
          exist = true
        }
      }
    },
    CheckBuffLogic = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查buff效果",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "logic",
        style = "ChooseString",
        text = "buff效果",
        dict = AutoTestBuffLogicTable
      },
      [4] = {
        arg = "exist",
        style = "Check",
        text = "是否存在",
        default = true
      },
      [5] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckBuffLogic",
        args = {
          name = "e1",
          logic = "ATBuffStun",
          exist = true,
          trigger = 88
        }
      }
    },
    CheckEntityBuffValue = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查buff值",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "key",
        style = "InputString",
        text = "key"
      },
      [4] = {
        arg = "value",
        style = "InputFloat",
        text = "值",
        default = 0
      },
      [5] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckEntityBuffValue",
        args = {
          trigger = 88,
          name = "e1",
          key = "SoulCount",
          value = 1
        }
      }
    },
    CheckEntityBuffLayer = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查Buff层数",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "layerType",
        style = "InputInt",
        text = "BuffEffect"
      },
      [4] = {
        arg = "layer",
        style = "InputInt",
        text = "期望层数"
      },
      [5] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckEntityBuffLayer",
        args = {
          trigger = 88,
          name = "e1",
          layerType = 1001,
          layer = 3
        }
      }
    },
    CheckEntityAttribute = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查目标属性值",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "attr",
        style = "ChooseString",
        text = "选择属性",
        dict = BaseAttrDict
      },
      [4] = {
        arg = "expect",
        style = "InputFloat",
        text = "期望值"
      },
      [5] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckEntityAttribute",
        args = {
          trigger = 88,
          name = "team",
          attr = "Attack",
          expect = 1000
        }
      }
    },
    CheckAttributeChange = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查目标属性变化",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "attr",
        style = "ChooseString",
        text = "选择属性",
        dict = BaseAttrDict
      },
      [4] = {
        arg = "cmp",
        style = "InputString",
        text = "比较方式"
      },
      [5] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 18
      },
      template = {
        action = "CheckAttributeChange",
        args = {
          trigger = 18,
          name = "team",
          attr = "Attack",
          cmp = "<"
        }
      }
    },
    CheckDump = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查不卡死",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckDump",
        args = {trigger = 88}
      }
    },
    CaptureDamageValue = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "捕获伤害值",
        group = ActionGroupType.CaptureValue
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "key",
        style = "InputString",
        text = "捕获变量"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 18
      },
      template = {
        action = "CaptureDamageValue",
        args = {
          trigger = 18,
          name = "e1",
          key = "v1"
        }
      }
    },
    CaptureDoubleChainDamageValue = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "捕获二次连锁伤害值",
        group = ActionGroupType.CaptureValue
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "key",
        style = "InputString",
        text = "捕获变量"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 18
      },
      template = {
        action = "CaptureDoubleChainDamageValue",
        args = {
          trigger = 18,
          name = "e1",
          key = "v1"
        }
      }
    },
    CaptureFormulaAttr = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "捕获公式参数",
        group = ActionGroupType.CaptureValue
      },
      [2] = {
        arg = "skillid",
        style = "InputInt",
        text = "技能ID"
      },
      [3] = {
        arg = "defname",
        style = "InputString",
        text = "被击者"
      },
      [4] = {
        arg = "key",
        style = "ChooseString",
        text = "选择公式",
        dict = FormulaKeyWord
      },
      [5] = {
        arg = "attr",
        style = "ChooseString",
        text = "选择参数",
        dict = FormulaAttrDict
      },
      [6] = {
        arg = "varname",
        style = "InputString",
        text = "保存变量名"
      },
      [7] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 102
      },
      [8] = {
        arg = "damageIndex",
        style = "InputInt",
        text = "伤害序号",
        default = 1
      },
      template = {
        action = "CaptureFormulaAttr",
        args = {
          trigger = 102,
          skillid = 100006,
          defname = "e1",
          key = "FinalAtk",
          attr = "attackPercentage",
          varname = "v1",
          damageIndex = 1
        }
      }
    },
    CompareLocalValue = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查捕获值关系",
        group = ActionGroupType.CaptureValue
      },
      [2] = {
        arg = "key1",
        style = "InputString",
        text = "变量1"
      },
      [3] = {
        arg = "cmp",
        style = "InputString",
        text = "比较方式"
      },
      [4] = {
        arg = "key2",
        style = "InputString",
        text = "变量2"
      },
      [5] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 18
      },
      template = {
        action = "CompareLocalValue",
        args = {
          trigger = 18,
          key1 = "v1",
          cmp = "<",
          key2 = "v2"
        }
      }
    },
    CompareLocalValueWithOperator = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "比较捕获值数值",
        group = ActionGroupType.CaptureValue
      },
      [2] = {
        arg = "key",
        style = "InputString",
        text = "变量1"
      },
      [3] = {
        arg = "cmp",
        style = "InputString",
        text = "比较方式"
      },
      [4] = {
        arg = "expect",
        style = "InputFloat",
        text = "期望值"
      },
      [5] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 18
      },
      template = {
        action = "CompareLocalValueWithOperator",
        args = {
          trigger = 18,
          key = "v1",
          cmp = "<",
          expect = "1.2"
        }
      }
    },
    CheckLocalValue = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查捕获值",
        group = ActionGroupType.CaptureValue
      },
      [2] = {
        arg = "varname",
        style = "InputString",
        text = "变量名"
      },
      [3] = {
        arg = "target",
        style = "InputFloat",
        text = "期望值"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckLocalValue",
        args = {
          varname = "v1",
          target = 0.01,
          trigger = 88
        }
      }
    },
    CheckBattleResult = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查战斗结果",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "victory",
        style = "Choose",
        text = "期望结果",
        dict = _battle_result,
        default = 1
      },
      [3] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 80
      },
      template = {
        action = "CheckBattleResult",
        args = {victory = 1, trigger = 80}
      }
    },
    CheckRenderPieceType = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查格子表现颜色",
        group = ActionGroupType.CheckRender
      },
      [2] = {
        arg = "pos",
        style = "InputInt",
        text = "坐标"
      },
      [3] = {
        arg = "pieceType",
        style = "Choose",
        text = "期望颜色",
        dict = PieceType
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckRenderPieceType",
        args = {
          trigger = 88,
          pos = 505,
          pieceType = PieceType.Blue
        }
      }
    },
    CheckUIPetLayerCount = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查光灵头像Buff层数",
        group = ActionGroupType.CheckRender
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "expect",
        style = "InputInt",
        text = "期望层数"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckUIPetLayerCount",
        args = {
          trigger = 88,
          name = "p1",
          expect = 1
        }
      }
    },
    CheckUIPetPassiveSkillBuffLayerCount = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查光灵头像Buff层数（双显时）",
        group = ActionGroupType.CheckRender
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "expect",
        style = "InputInt",
        text = "期望层数"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckUIPetPassiveSkillBuffLayerCount",
        args = {
          trigger = 88,
          name = "p1",
          expect = 1
        }
      }
    },
    CheckUILayerShieldCount = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查层数盾层数",
        group = ActionGroupType.CheckRender
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "expect",
        style = "InputInt",
        text = "期望层数"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckUILayerShieldCount",
        args = {
          trigger = 88,
          name = "team",
          expect = 1
        }
      }
    },
    CheckUIHPShieldExist = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查血条盾存在",
        group = ActionGroupType.CheckRender
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "exist",
        style = "Check",
        text = "是否存在",
        default = true
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckUIHPShieldExist",
        args = {
          trigger = 88,
          name = "team",
          exist = true
        }
      }
    },
    CheckUIBuffIcon = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查UI血条Buff层数",
        group = ActionGroupType.CheckRender
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "buffID",
        style = "InputInt",
        text = "BuffID"
      },
      [4] = {
        arg = "expect",
        style = "InputInt",
        text = "期望层数"
      },
      [5] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckUIBuffIcon",
        args = {
          trigger = 88,
          name = "team",
          buffID = 20011,
          expect = 1
        }
      }
    },
    Check3StarComplete = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查三星条件",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "conditionType",
        style = "Choose",
        text = "条件类型",
        dict = Star3Name2ID,
        default = 1
      },
      [3] = {
        arg = "conditionParam",
        style = "InputString",
        text = "条件参数"
      },
      [4] = {
        arg = "expect",
        style = "Check",
        text = "是否完成",
        default = true
      },
      [5] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "Check3StarComplete",
        args = {
          trigger = 88,
          conditionType = 1,
          conditionParam = "1",
          expect = true
        }
      }
    },
    CheckMonsterCount = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查场上怪物数量",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "monsterid",
        style = "InputInt",
        text = "怪物ID",
        default = 2010111
      },
      [3] = {
        arg = "count",
        style = "InputInt",
        text = "期望数量",
        default = 1
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckMonsterCount",
        args = {
          trigger = 88,
          monsterid = 2010111,
          count = 1
        }
      }
    },
    CheckFormulaAttr = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查公式参数",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "skillid",
        style = "InputInt",
        text = "技能ID"
      },
      [3] = {
        arg = "defname",
        style = "InputString",
        text = "被击者"
      },
      [4] = {
        arg = "key",
        style = "ChooseString",
        text = "选择公式",
        dict = FormulaKeyWord
      },
      [5] = {
        arg = "attr",
        style = "ChooseString",
        text = "选择参数",
        dict = FormulaAttrDict
      },
      [6] = {
        arg = "expect",
        style = "InputFloat",
        text = "期望值"
      },
      [7] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 102
      },
      template = {
        action = "CheckFormulaAttr",
        args = {
          trigger = 102,
          skillid = 100006,
          defname = "e1",
          key = "FinalAtk",
          attr = "attackPercentage",
          expect = 1
        }
      }
    },
    CheckSkillRange = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查技能范围",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "skillid",
        style = "InputInt",
        text = "技能ID"
      },
      [3] = {
        arg = "range",
        style = "InputIntList",
        text = "攻击范围"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 102
      },
      template = {
        action = "CheckSkillRange",
        args = {
          trigger = 102,
          skillid = 100006,
          range = {502, 503}
        }
      }
    },
    CastTrapSkill = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "释放机关技能",
        group = ActionGroupType.FakeInput
      },
      [2] = {
        arg = "pos",
        style = "InputInt",
        text = "机关位置"
      },
      [3] = {
        arg = "trapID",
        style = "InputInt",
        text = "机关ID"
      },
      [4] = {
        arg = "skillID",
        style = "InputInt",
        text = "技能ID"
      },
      [5] = {
        arg = "pickUpPos",
        style = "InputIntList",
        text = "点选位置"
      },
      template = {
        action = "CastTrapSkill",
        args = {
          pos = 502,
          trapID = 1,
          skillID = 1,
          pickUpPos = {504}
        }
      }
    },
    ChangeTeamLeader = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "更换队长",
        group = ActionGroupType.FakeInput
      },
      [2] = {
        arg = "index",
        style = "InputInt",
        text = "队伍位置"
      },
      template = {
        action = "ChangeTeamLeader",
        args = {index = 2}
      }
    },
    CheckTeamOrder = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查队伍位置",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "光灵名称"
      },
      [3] = {
        arg = "index",
        style = "InputInt",
        text = "队伍位置"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckTeamOrder",
        args = {
          name = "p1",
          index = 2,
          trigger = 88
        }
      }
    },
    CheckSanValue = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查San值",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "expect",
        style = "InputInt",
        text = "期望San值"
      },
      [3] = {
        arg = "compare",
        style = "InputString",
        text = "比较方式",
        default = ">"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckSanValue",
        args = {
          expect = 100,
          compare = ">",
          trigger = 88
        }
      }
    },
    ModifySanValue = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "修改San值",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "modifyValue",
        style = "InputInt",
        text = "修改数值"
      },
      template = {
        action = "ModifySanValue",
        args = {modifyValue = -50}
      }
    },
    CheckDayNightState = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查昼夜状态",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "expect",
        style = "InputInt",
        text = "期望状态(1-Day,2-Night)"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckDayNightState",
        args = {expect = 1, trigger = 88}
      }
    },
    CheckTrapCount = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查机关数量",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "trapIDs",
        style = "InputIntList",
        text = "机关ID列表"
      },
      [3] = {
        arg = "expect",
        style = "InputInt",
        text = "期望机关数量"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckTrapCount",
        args = {
          trapIDs = {14},
          expect = 4,
          trigger = 88
        }
      }
    },
    FakeCastFeaturePersonaSkill = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "模拟释放合击技",
        group = ActionGroupType.FakeInput
      },
      template = {
        action = "FakeCastFeaturePersonaSkill",
        args = {}
      }
    },
    AddCardByType = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "添加卡牌",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "cardTypeList",
        style = "InputIntList",
        text = "卡牌类型列表"
      },
      template = {
        action = "AddCardByType",
        args = {
          cardTypeList = {
            1,
            2,
            3
          }
        }
      }
    },
    FakeCastFeatureCardSkill = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "模拟释放卡牌技能",
        group = ActionGroupType.FakeInput
      },
      [2] = {
        arg = "cardCompositionType",
        style = "Choose",
        text = "卡牌组合类型",
        dict = _card_composition_type,
        default = 1
      },
      template = {
        action = "FakeCastFeatureCardSkill",
        args = {cardCompositionType = 1}
      }
    },
    CheckCardCount = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查卡牌数量",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "expect",
        style = "InputInt",
        text = "期望卡牌数量"
      },
      [3] = {
        arg = "compare",
        style = "InputString",
        text = "比较方式",
        default = ">"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckCardCount",
        args = {
          expect = 3,
          compare = ">",
          trigger = 88
        }
      }
    },
    CheckCurWaveLeftRound = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查剩余回合数",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "expect",
        style = "InputInt",
        text = "期望回合数"
      },
      [3] = {
        arg = "compare",
        style = "InputString",
        text = "比较方式",
        default = "=="
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckCurWaveLeftRound",
        args = {
          expect = 3,
          compare = "==",
          trigger = 88
        }
      }
    },
    CheckIsAuroraTime = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查极光时刻",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "expect",
        style = "Check",
        text = "是否",
        default = true
      },
      [3] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckIsAuroraTime",
        args = {expect = true, trigger = 88}
      }
    },
    CheckLocalValueWithPrecision = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查捕获值带精度",
        group = ActionGroupType.CaptureValue
      },
      [2] = {
        arg = "varname",
        style = "InputString",
        text = "变量名"
      },
      [3] = {
        arg = "target",
        style = "InputFloat",
        text = "期望值"
      },
      [3] = {
        arg = "precision",
        style = "InputInt",
        text = "精确到几位"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckLocalValueWithPrecision",
        args = {
          varname = "v1",
          target = 0.01,
          precision = 2,
          trigger = 88
        }
      }
    },
    CheckEntityBodyAreaCount = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查占格数",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "expect",
        style = "InputInt",
        text = "期望值"
      },
      [4] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckEntityBodyAreaCount",
        args = {
          trigger = 88,
          name = "e1",
          expect = 4
        }
      }
    },
    FakeCastFeatureScanTrap = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "阿克希亚选择机关",
        group = ActionGroupType.FakeInput
      },
      [2] = {
        arg = "chooseIndex",
        style = "InputInt",
        text = "选择序号"
      },
      template = {
        action = "FakeCastFeatureScanTrap",
        args = {chooseIndex = 0}
      }
    },
    WaitTime = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "等待时长",
        group = ActionGroupType.FakeInput
      },
      [2] = {
        arg = "timeMs",
        style = "InputInt",
        text = "等待时长"
      },
      template = {
        action = "WaitTime",
        args = {timeMs = 2000}
      }
    },
    FakeSwitchBulletWidget = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "雷霆切换开关",
        group = ActionGroupType.FakeInput
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      template = {
        action = "FakeSwitchBulletWidget",
        args = {name = "p1"}
      }
    },
    SetEntityBuffLayer = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "设置Buff层数",
        group = ActionGroupType.CheatCommand
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "layerType",
        style = "InputInt",
        text = "BuffEffect"
      },
      [4] = {
        arg = "layer",
        style = "InputInt",
        text = "设置层数"
      },
      [5] = {
        arg = "display",
        style = "Check",
        text = "执行表现",
        default = true
      },
      template = {
        action = "SetEntityBuffLayer",
        args = {
          name = "p1",
          layerType = 1001,
          layer = 3,
          display = true
        }
      }
    },
    CheckPetActiveSkillCanCast = {
      [1] = {
        arg = "action",
        style = "Label",
        text = "检查光灵主动技状态",
        group = ActionGroupType.CheckLogic
      },
      [2] = {
        arg = "name",
        style = "InputString",
        text = "目标名字"
      },
      [3] = {
        arg = "skillID",
        style = "InputInt",
        text = "技能ID"
      },
      [4] = {
        arg = "expect",
        style = "Check",
        text = "是否可释放",
        default = true
      },
      [5] = {
        arg = "trigger",
        style = "Choose",
        text = "检查时机",
        dict = AutoTestCheckNotifier,
        default = 88
      },
      template = {
        action = "CheckPetActiveSkillCanCast",
        args = {
          trigger = 88,
          name = "p1",
          skillID = 1,
          expect = true
        }
      }
    }
  }
  return config
end

ActionGroupType = {
  CheatCommand = 1,
  CheckLogic = 2,
  CheckRender = 3,
  CaptureValue = 4,
  FakeInput = 5,
  LevelSetup = 6
}
ActionGroupName = {
  [ActionGroupType.CaptureValue] = "捕获变量",
  [ActionGroupType.CheatCommand] = "作弊指令",
  [ActionGroupType.CheckLogic] = "逻辑检查",
  [ActionGroupType.CheckRender] = "表现检查",
  [ActionGroupType.FakeInput] = "模拟输入",
  [ActionGroupType.LevelSetup] = "关卡配置"
}

function GetTreeNodeTemplate()
  local t = {
    name = "新测试组",
    suites = {},
    nodes = {}
  }
  return t
end

function GetNodeSuiteTemplate()
  local affix = os.date("%y%m%d_%H%M%S")
  local t = {
    suite = "AutoTest_" .. affix,
    file = "auto_test_" .. affix .. ".lua",
    name = "新测试用例"
  }
  return t
end

function GetSuiteTemplate()
  local t = {
    name = "新测试用例",
    setup = {
      [1] = {
        setup = "LevelBasic",
        args = {matchType = 1, levelID = 1}
      }
    },
    petList = {
      [1] = {
        id = 1400071,
        level = 1,
        grade = 0,
        awakening = 0,
        equiplv = 1,
        name = "p1"
      }
    },
    remotePet = {
      [1] = {
        id = 1400071,
        level = 1,
        grade = 0,
        awakening = 0,
        equiplv = 1,
        name = "r1"
      }
    },
    cases = {
      [1] = {
        name = "新测试用例",
        [1] = {
          action = "WaitGameFsm",
          args = {
            id = GameStateID.WaitInput
          }
        }
      }
    }
  }
  return t
end

function GetCaseTemplate()
  local t = {
    name = "新测试用例",
    [1] = {
      action = "WaitGameFsm",
      args = {
        id = GameStateID.WaitInput
      }
    }
  }
  return t
end

function LuaTableAddTable(t, v, p)
  v = v or {}
  p = p or #t + 1
  table.insert(t, p, v)
  return t[p]
end

function LuaTableRemoveAt(t, idx)
  table.remove(t, idx)
end

function LuaTableRemove(t, v)
  table.removev(t, v)
end

function LuaTableSwap(t, a, b)
  t[a], t[b] = t[b], t[a]
end

function LuaTableClone(t)
  local u = table_to_class(t)
  return u
end
