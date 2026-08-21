function GetGMConfig()
  local gmproxy = GameGlobal.GetModule(GMProxyModule)
  
  local elementStr = {
    [ElementType.ElementType_Blue] = "水",
    [ElementType.ElementType_Red] = "火",
    [ElementType.ElementType_Green] = "森",
    [ElementType.ElementType_Yellow] = "雷",
    [ElementType.ElementType_None] = "无效",
    [ElementType.ElementType_Any] = "万色"
  }
  local cfg_pet = Cfg.cfg_pet({})
  local _pet_id_name = {}
  for petid, petcfg in pairs(cfg_pet) do
    local name = string.format("%d星/%s/%d-%s", petcfg.Star, elementStr[petcfg.FirstElement], petcfg.ID, StringTable.Get(petcfg.Name))
    _pet_id_name[name] = petid
  end
  local cfg_word = Cfg.cfg_word_buff({})
  local _word_id_name = {}
  for id, cfg in pairs(cfg_word) do
    if cfg.Word and cfg.Word[1] then
      local name = StringTable.Get(cfg.Word[1])
      _word_id_name[name] = id
    end
  end
  local cfg_item = Cfg.cfg_item({})
  local _item_id_name = {}
  for id, cfg in pairs(cfg_item) do
    if id < RoleAssetID.RoleAssetItemEnd then
      local name = StringTable.Get(cfg.Name)
      _item_id_name[name] = id
    end
  end
  local cfg_relic = Cfg.cfg_item_relic({})
  local _relic_id_name = {}
  for id, cfg in pairs(cfg_relic) do
    if id < 9996001 then
      local name = StringTable.Get(cfg_item[id].Name)
      _relic_id_name[name] = id
    end
  end
  local cfg_mission = Cfg.cfg_mission({})
  local _mission_id_name = {}
  for id, cfg in pairs(cfg_mission) do
    local name = StringTable.Get(cfg.Name)
    local indexName = "???"
    if Cfg.cfg_waypoint[id] then
      indexName = StringTable.Get(Cfg.cfg_waypoint[id].Name)
    end
    name = string.format("第%s章/%s %s", cfg.Chapter[1], indexName, name)
    _mission_id_name[name] = id
  end
  local asset_name = {}
  for key, id in pairs(RoleAssetID) do
    local cfgItem = Cfg.cfg_item[id]
    if cfgItem then
      local name = StringTable.Get(cfgItem.Name)
      asset_name[id .. "-" .. name] = id
    end
  end
  local config = {
    serverIP = gmproxy:GetServerIP(),
    userID = GameGlobal.GameLogic():GetOpenId(),
    outGame = {
      head = "局外系统",
      proxy = "gmtool",
      body = {
        {
          cmd = "quick_play {userid}",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "快速开始"
            }
          }
        },
        {
          cmd = "add_all_item {userid}",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "全部物品"
            }
          }
        },
        {
          cmd = "add_all_pet {userid}",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "全部星灵"
            }
          }
        },
        {
          cmd = "add_asset {userid} {petid} 1",
          ui = "btn petid",
          ext = {
            btn = {
              style = "Button",
              text = "增加1个星灵"
            },
            petid = {
              style = "Choose",
              text = "ID",
              dict = _pet_id_name
            }
          }
        },
        {
          cmd = "all_pet_full {userid}",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "全部星灵满级"
            }
          }
        },
        {
          cmd = "all_pet_plain {userid}",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "全部星灵1级"
            }
          }
        },
        {
          cmd = "CompleteAllMission {userid}",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "主线全部通关"
            }
          }
        },
        {
          cmd = "CompleteAssignMission {userid} {missionid}",
          ui = "btn missionid",
          ext = {
            btn = {
              style = "Button",
              text = "主线通关到指定关"
            },
            missionid = {
              style = "Choose",
              text = "选择关卡",
              dict = _mission_id_name
            }
          }
        },
        {
          cmd = "CompleteAllExtTask {userid} 0",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "番外全部通关"
            }
          }
        },
        {
          cmd = "unlock_allroom {userid}",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "风船满级"
            }
          }
        },
        {
          cmd = "reset_maze {userid}",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "重置迷宫"
            }
          }
        },
        {
          cmd = "clear_relics {userid}",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "清空圣物"
            }
          }
        },
        {
          cmd = "add_asset {userid} {assetid} {count}",
          ui = "btn assetid count",
          ext = {
            btn = {
              style = "Button",
              text = "增加财产"
            },
            assetid = {style = "Input", text = "ID"},
            count = {
              style = "Input",
              text = "数量",
              default = 1
            }
          }
        },
        {
          cmd = "add_asset {userid} {assetid} {count}",
          ui = "btn assetid count",
          ext = {
            btn = {
              style = "Button",
              text = "增加财产"
            },
            assetid = {
              style = "Choose",
              text = "ID",
              dict = asset_name
            },
            count = {
              style = "Input",
              text = "数量",
              default = 1
            }
          }
        },
        {
          cmd = "del_asset {userid} {assetid} {count}",
          ui = "btn assetid count",
          ext = {
            btn = {
              style = "Button",
              text = "删除财产"
            },
            assetid = {style = "Input", text = "ID"},
            count = {
              style = "Input",
              text = "数量",
              default = 1
            }
          }
        },
        {
          cmd = "unlock_md {userid} {md}",
          ui = "btn md",
          ext = {
            btn = {
              style = "Button",
              text = "解锁模块"
            },
            md = {
              style = "Choose",
              text = "选择模块",
              dict = GameModuleID
            }
          }
        },
        {
          cmd = "next_layer {userid}",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "迷宫下一层"
            }
          }
        },
        {
          cmd = "goto_step {userid} {step} {offset}",
          ui = "btn step offset",
          ext = {
            btn = {
              style = "Button",
              text = "迷宫跳步"
            },
            step = {style = "Input", text = "步数"},
            offset = {style = "Input", text = "偏移"}
          }
        },
        {
          cmd = "add_word {userid} {word}",
          ui = "btn word",
          ext = {
            btn = {
              style = "Button",
              text = "房间词缀"
            },
            word = {
              style = "Choose",
              text = "选择词缀",
              dict = _word_id_name
            }
          }
        },
        {
          cmd = "clear_archive {userid}",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "删除房间存档"
            }
          }
        },
        {
          cmd = "add_asset {userid} {assetid} {count}",
          ui = "btn assetid count",
          ext = {
            btn = {
              style = "Button",
              text = "添加物品"
            },
            assetid = {
              style = "Choose",
              text = "选择物品",
              dict = _item_id_name
            },
            count = {
              style = "Input",
              text = "数量",
              default = 9999
            }
          }
        },
        {
          cmd = "add_asset {userid} {assetid} {count}",
          ui = "btn assetid count",
          ext = {
            btn = {
              style = "Button",
              text = "添加圣物"
            },
            assetid = {
              style = "Choose",
              text = "选择圣物",
              dict = _relic_id_name
            },
            count = {
              style = "Input",
              text = "数量",
              default = 1
            }
          }
        },
        {
          cmd = "pet_eat_full {userid} {petid}",
          ui = "btn petid",
          ext = {
            btn = {
              style = "Button",
              text = "一个星灵满级"
            },
            petid = {
              style = "Choose",
              text = "选择星灵",
              dict = _pet_id_name
            }
          }
        },
        {
          cmd = "ChangePet {userid} {petid} {level} {grade} {awake} {affinity} {equip}",
          ui = "btn petid level grade awake affinity equip",
          ext = {
            btn = {
              style = "Button",
              text = "调整一个星灵属性"
            },
            petid = {
              style = "Choose",
              text = "选择星灵",
              dict = _pet_id_name
            },
            level = {
              style = "Input",
              text = "等级",
              default = 1
            },
            grade = {
              style = "Input",
              text = "觉醒",
              default = 0
            },
            awake = {
              style = "Input",
              text = "突破",
              default = 0
            },
            affinity = {
              style = "Input",
              text = "好感",
              default = 0
            },
            equip = {
              style = "Input",
              text = "装备",
              default = 0
            }
          }
        },
        {
          cmd = "pass_tower_level {userid} {tower_type} {level}",
          ui = "btn tower_type level",
          ext = {
            btn = {
              style = "Button",
              text = "爬塔通关"
            },
            tower_type = {
              style = "Choose",
              text = "爬塔类型",
              dict = ElementType
            },
            level = {
              style = "Input",
              text = "第几层",
              default = 0
            }
          }
        },
        {
          cmd = "enable_word {userid} {enable}",
          ui = "btn enable",
          ext = {
            btn = {
              style = "Button",
              text = "熟练的指挥开关"
            },
            enable = {
              style = "Choose",
              text = "启用禁用",
              dict = {enable = 1, disable = 0}
            }
          }
        },
        {
          cmd = "open_all_campaign  {userid} ",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "开启所有活动"
            }
          }
        }
      }
    },
    homeland = {
      head = "家园系统",
      proxy = "gmtool",
      body = {
        {
          cmd = "set_homeland_level  {userid} {level}",
          ui = "btn level",
          ext = {
            btn = {
              style = "Button",
              text = "设置家园等级"
            },
            level = {
              style = "Input",
              text = "等级",
              default = 1
            }
          }
        },
        {
          cmd = "UnlockAllArch {userid}",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "所有建筑解锁"
            }
          }
        }
      }
    },
    inGame = {
      head = "局内系统",
      proxy = "world",
      body = {
        {
          cmd = "BattleCheatHeroMaxHP()",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "队长满血"
            }
          }
        },
        {
          cmd = "BattleCheatTeamPowerFull()",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "全体满蓝"
            }
          }
        },
        {
          cmd = "BattleCheatMonsterInvincible()",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "怪物满血"
            }
          }
        },
        {
          cmd = "BattleCheatAttackMax({attack})",
          ui = "btn attack",
          ext = {
            btn = {
              style = "Button",
              text = "修改攻击"
            },
            attack = {
              style = "Input",
              text = "攻击力",
              default = 99999
            }
          }
        },
        {
          cmd = "BattleCheatGetRight()",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "恢复攻击"
            }
          }
        },
        {
          cmd = "BattleKillMonsters()",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "杀死所有怪"
            }
          }
        },
        {
          cmd = "BattleCheatAddBuffHero({buffid})",
          ui = "btn buffid",
          ext = {
            btn = {
              style = "Button",
              text = "队长挂BUFF"
            },
            buffid = {style = "Input", text = "BuffID"}
          }
        },
        {
          cmd = "BattleCheatAddBuffAllMonsters({buffid})",
          ui = "btn buffid",
          ext = {
            btn = {
              style = "Button",
              text = "怪物挂BUFF"
            },
            buffid = {style = "Input", text = "BuffID"}
          }
        },
        {
          cmd = "BattleCheatSetBoardPiece({piece})",
          ui = "btn piece",
          ext = {
            btn = {
              style = "Button",
              text = "全屏刷格子"
            },
            piece = {
              style = "Choose",
              text = "选择格子",
              dict = PieceType
            }
          }
        },
        {
          cmd = "GetService(\"TrapLogic\"):CreateTrap({trapid},Vector2({x},{y}),Vector2({a},{b}),false)",
          ui = "btn trapid x y",
          ext = {
            btn = {
              style = "Button",
              text = "创建陷阱"
            },
            trapid = {
              style = "Input",
              text = "选择陷阱"
            },
            x = {
              style = "Input",
              text = "PosX",
              default = 5
            },
            y = {
              style = "Input",
              text = "PosY",
              default = 5
            },
            a = {
              style = "Input",
              text = "DirX",
              default = 0
            },
            b = {
              style = "Input",
              text = "DirY",
              default = 1
            }
          }
        },
        {
          cmd = "BattleCheat_AutoSummon({listParam})",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "自动无限召唤"
            }
          }
        },
        {
          cmd = "BattleCheat_RebuildTeam({listParam})",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "换一批星灵"
            }
          }
        }
      }
    },
    global = {
      head = "全局命令",
      proxy = "global",
      body = {
        {
          cmd = "GameGlobal.StartProfiler()",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "StartLuaProfile"
            }
          }
        },
        {
          cmd = "GameGlobal.StopProfiler()",
          ui = "btn",
          ext = {
            btn = {
              style = "Button",
              text = "StopLuaProfile"
            }
          }
        }
      }
    }
  }
  return config
end
