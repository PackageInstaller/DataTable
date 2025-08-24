local t = {
  {
    {
      BuffArg = {
        {
          20,
          200,
          1
        }
      },
      BuffID = {15},
      CostCnt = 550,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.02,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_gj",
      Id = 1001,
      MagicId = 0,
      Name = "攻击Ⅰ",
      Pos = 1,
      PosGroup = 1,
      PreBlessId = {},
      ShowType = 1,
      StatisticsDesc = "全队攻击力提升{1}",
      UpgradeDesc = ""
    },
    {
      BuffArg = {
        {26, 200}
      },
      BuffID = {15},
      CostCnt = 550,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.02,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_zs",
      Id = 1002,
      MagicId = 0,
      Name = "增伤Ⅰ",
      Pos = 2,
      PosGroup = 1,
      PreBlessId = {1001},
      ShowType = 2,
      StatisticsDesc = "全队伤害增幅提升{1}",
      UpgradeDesc = ""
    },
    {
      BuffArg = {
        {
          4,
          300,
          1
        }
      },
      BuffID = {15},
      CostCnt = 550,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.03,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_sm",
      Id = 1003,
      MagicId = 0,
      Name = "生命Ⅰ",
      Pos = 3,
      PosGroup = 1,
      PreBlessId = {},
      ShowType = 3,
      StatisticsDesc = "全队生命值提升{1}",
      UpgradeDesc = ""
    },
    {
      BuffArg = {
        {
          22,
          300,
          1
        }
      },
      BuffID = {15},
      CostCnt = 900,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.03,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_fy",
      Id = 1004,
      MagicId = 0,
      Name = "防御Ⅰ",
      Pos = 4,
      PosGroup = 1,
      PreBlessId = {1003},
      ShowType = 4,
      StatisticsDesc = "全队防御力提升{1}",
      UpgradeDesc = ""
    },
    {
      BuffArg = {
        {500001, 50}
      },
      BuffID = {14},
      CostCnt = 900,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 50,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_jb",
      Id = 1005,
      MagicId = 0,
      Name = "财富Ⅰ",
      Pos = 5,
      PosGroup = 1,
      PreBlessId = {},
      ShowType = 5,
      StatisticsDesc = "初始【光尘】增加{1}",
      UpgradeDesc = ""
    },
    {
      BuffArg = {
        {25, 200}
      },
      BuffID = {15},
      CostCnt = 900,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.02,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_bj",
      Id = 1006,
      MagicId = 0,
      Name = "耐力Ⅰ",
      Pos = 6,
      PosGroup = 1,
      PreBlessId = {1005},
      ShowType = 6,
      StatisticsDesc = "全队伤害抗性提升{1}",
      UpgradeDesc = ""
    },
    {
      BuffArg = 0,
      BuffID = {},
      CostCnt = 1350,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0,
      FuncParam = 1,
      FuncType = 1,
      Icon = "Icon/BlessingIcon/Event_icon_tsbig",
      Id = 1007,
      MagicId = 0,
      Name = "祝福Ⅰ",
      Pos = 7,
      PosGroup = 1,
      PreBlessId = {
        1002,
        1004,
        1006
      },
      ShowType = 7,
      StatisticsDesc = "开局额外获得片语、奇珍或光尘",
      UpgradeDesc = ""
    }
  },
  {
    {
      BuffArg = {
        {
          20,
          200,
          1
        }
      },
      BuffID = {15},
      CostCnt = 1000,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.02,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_gj",
      Id = 1008,
      MagicId = 0,
      Name = "攻击Ⅱ",
      Pos = 1,
      PosGroup = 2,
      PreBlessId = {1007},
      ShowType = 1,
      StatisticsDesc = "全队攻击力提升{1}",
      UpgradeDesc = ""
    },
    {
      BuffArg = {
        {26, 200}
      },
      BuffID = {15},
      CostCnt = 1000,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.02,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_zs",
      Id = 1009,
      MagicId = 0,
      Name = "增伤Ⅱ",
      Pos = 2,
      PosGroup = 2,
      PreBlessId = {1008},
      ShowType = 2,
      StatisticsDesc = "全队伤害增幅提升{1}",
      UpgradeDesc = ""
    },
    {
      BuffArg = {
        {
          4,
          300,
          1
        }
      },
      BuffID = {15},
      CostCnt = 1000,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.03,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_sm",
      Id = 1010,
      MagicId = 0,
      Name = "生命Ⅱ",
      Pos = 3,
      PosGroup = 2,
      PreBlessId = {1007},
      ShowType = 3,
      StatisticsDesc = "全队生命值提升{1}",
      UpgradeDesc = "符文等级提升至30"
    },
    {
      BuffArg = {
        {
          22,
          300,
          1
        }
      },
      BuffID = {15},
      CostCnt = 1250,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.03,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_fy",
      Id = 1011,
      MagicId = 0,
      Name = "防御Ⅱ",
      Pos = 4,
      PosGroup = 2,
      PreBlessId = {1010},
      ShowType = 4,
      StatisticsDesc = "全队防御力提升{1}",
      UpgradeDesc = "【光尘】提升至1000"
    },
    {
      BuffArg = {
        {500001, 50}
      },
      BuffID = {14},
      CostCnt = 1250,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 50,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_jb",
      Id = 1012,
      MagicId = 0,
      Name = "财富Ⅱ",
      Pos = 5,
      PosGroup = 2,
      PreBlessId = {1007},
      ShowType = 5,
      StatisticsDesc = "初始【光尘】增加{1}",
      UpgradeDesc = "生命值增加提升至2000"
    },
    {
      BuffArg = {
        {25, 200}
      },
      BuffID = {15},
      CostCnt = 1250,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.02,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_bj",
      Id = 1013,
      MagicId = 0,
      Name = "耐力Ⅱ",
      Pos = 6,
      PosGroup = 2,
      PreBlessId = {1012},
      ShowType = 6,
      StatisticsDesc = "全队伤害抗性提升{1}",
      UpgradeDesc = "攻击力增加提升至60"
    },
    {
      BuffArg = 0,
      BuffID = nil,
      CostCnt = 1600,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 1,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_tsbig",
      Id = 1014,
      MagicId = 0,
      Name = "进货Ⅰ",
      Pos = 7,
      PosGroup = 2,
      PreBlessId = {
        1009,
        1011,
        1013
      },
      ShowType = 8,
      StatisticsDesc = "交易章节增加{1}个商品",
      UpgradeDesc = ""
    }
  },
  {
    {
      BuffArg = {
        {
          20,
          200,
          1
        }
      },
      BuffID = {15},
      CostCnt = 1350,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.02,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_gj",
      Id = 1015,
      MagicId = 0,
      Name = "攻击Ⅲ",
      Pos = 1,
      PosGroup = 3,
      PreBlessId = {1014},
      ShowType = 1,
      StatisticsDesc = "全队攻击力提升{1}",
      UpgradeDesc = ""
    },
    {
      BuffArg = {
        {26, 200}
      },
      BuffID = {15},
      CostCnt = 1350,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.02,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_zs",
      Id = 1016,
      MagicId = 0,
      Name = "增伤Ⅲ",
      Pos = 2,
      PosGroup = 3,
      PreBlessId = {1015},
      ShowType = 2,
      StatisticsDesc = "全队伤害增幅提升{1}",
      UpgradeDesc = ""
    },
    {
      BuffArg = {
        {
          4,
          300,
          1
        }
      },
      BuffID = {15},
      CostCnt = 1350,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.03,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_sm",
      Id = 1017,
      MagicId = 0,
      Name = "生命Ⅲ",
      Pos = 3,
      PosGroup = 3,
      PreBlessId = {1014},
      ShowType = 3,
      StatisticsDesc = "全队生命值提升{1}",
      UpgradeDesc = "符文等级提升至30"
    },
    {
      BuffArg = {
        {
          22,
          300,
          1
        }
      },
      BuffID = {15},
      CostCnt = 1600,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.03,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_fy",
      Id = 1018,
      MagicId = 0,
      Name = "防御Ⅲ",
      Pos = 4,
      PosGroup = 3,
      PreBlessId = {1017},
      ShowType = 4,
      StatisticsDesc = "全队防御力提升{1}",
      UpgradeDesc = "【光尘】提升至1000"
    },
    {
      BuffArg = {
        {500001, 50}
      },
      BuffID = {14},
      CostCnt = 1600,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 50,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_jb",
      Id = 1019,
      MagicId = 0,
      Name = "财富Ⅲ",
      Pos = 5,
      PosGroup = 3,
      PreBlessId = {1014},
      ShowType = 5,
      StatisticsDesc = "初始【光尘】增加{1}",
      UpgradeDesc = "生命值增加提升至2000"
    },
    {
      BuffArg = {
        {25, 200}
      },
      BuffID = {15},
      CostCnt = 1600,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.02,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_bj",
      Id = 1020,
      MagicId = 0,
      Name = "耐力Ⅲ",
      Pos = 6,
      PosGroup = 3,
      PreBlessId = {1019},
      ShowType = 6,
      StatisticsDesc = "全队伤害抗性提升{1}",
      UpgradeDesc = "攻击力增加提升至60"
    },
    {
      BuffArg = 0,
      BuffID = nil,
      CostCnt = 2050,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0,
      FuncParam = 2,
      FuncType = 1,
      Icon = "Icon/BlessingIcon/Event_icon_tsbig",
      Id = 1021,
      MagicId = 0,
      Name = "祝福Ⅱ",
      Pos = 7,
      PosGroup = 3,
      PreBlessId = {
        1016,
        1018,
        1020
      },
      ShowType = 9,
      StatisticsDesc = "开局原初祝语奖励更好",
      UpgradeDesc = ""
    }
  },
  {
    {
      BuffArg = {
        {
          20,
          200,
          1
        }
      },
      BuffID = {15},
      CostCnt = 1850,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.02,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_gj",
      Id = 1022,
      MagicId = 0,
      Name = "攻击Ⅳ",
      Pos = 1,
      PosGroup = 4,
      PreBlessId = {1021},
      ShowType = 1,
      StatisticsDesc = "全队攻击力提升{1}",
      UpgradeDesc = ""
    },
    {
      BuffArg = {
        {26, 200}
      },
      BuffID = {15},
      CostCnt = 1850,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.02,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_zs",
      Id = 1023,
      MagicId = 0,
      Name = "增伤Ⅳ",
      Pos = 2,
      PosGroup = 4,
      PreBlessId = {1022},
      ShowType = 2,
      StatisticsDesc = "全队伤害增幅提升{1}",
      UpgradeDesc = ""
    },
    {
      BuffArg = {
        {
          4,
          300,
          1
        }
      },
      BuffID = {15},
      CostCnt = 1850,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.03,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_sm",
      Id = 1024,
      MagicId = 0,
      Name = "生命Ⅳ",
      Pos = 3,
      PosGroup = 4,
      PreBlessId = {1021},
      ShowType = 3,
      StatisticsDesc = "全队生命值提升{1}",
      UpgradeDesc = "符文等级提升至30"
    },
    {
      BuffArg = {
        {
          22,
          300,
          1
        }
      },
      BuffID = {15},
      CostCnt = 2200,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.03,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_fy",
      Id = 1025,
      MagicId = 0,
      Name = "防御Ⅳ",
      Pos = 4,
      PosGroup = 4,
      PreBlessId = {1024},
      ShowType = 4,
      StatisticsDesc = "全队防御力提升{1}",
      UpgradeDesc = "【光尘】提升至1000"
    },
    {
      BuffArg = {
        {500001, 50}
      },
      BuffID = {14},
      CostCnt = 2200,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 50,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_jb",
      Id = 1026,
      MagicId = 0,
      Name = "财富Ⅳ",
      Pos = 5,
      PosGroup = 4,
      PreBlessId = {1021},
      ShowType = 5,
      StatisticsDesc = "初始【光尘】增加{1}",
      UpgradeDesc = "生命值增加提升至2000"
    },
    {
      BuffArg = {
        {25, 200}
      },
      BuffID = {15},
      CostCnt = 2200,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 0.02,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_bj",
      Id = 1027,
      MagicId = 0,
      Name = "耐力Ⅳ",
      Pos = 6,
      PosGroup = 4,
      PreBlessId = {1026},
      ShowType = 6,
      StatisticsDesc = "全队伤害抗性提升{1}",
      UpgradeDesc = "攻击力增加提升至60"
    },
    {
      BuffArg = 0,
      BuffID = nil,
      CostCnt = 2600,
      CostItem = 29,
      Desc = "废弃列",
      DescParam = 1,
      FuncParam = 0,
      FuncType = 0,
      Icon = "Icon/BlessingIcon/Event_icon_tsbig",
      Id = 1028,
      MagicId = 0,
      Name = "进货Ⅱ",
      Pos = 7,
      PosGroup = 4,
      PreBlessId = {
        1023,
        1025,
        1027
      },
      ShowType = 8,
      StatisticsDesc = "交易章节增加{1}个商品",
      UpgradeDesc = ""
    }
  }
}
t[2][7].BuffID = t[1][7].BuffID
t[3][7].BuffID = t[1][7].BuffID
t[4][7].BuffID = t[1][7].BuffID
return t
