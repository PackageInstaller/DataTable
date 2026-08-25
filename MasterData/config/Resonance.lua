local System = require("System.System")
local readonly = System.readonly
local Resonance = readonly({
  [21888] = {
    ID = 21888,
    CnID = "共鸣@章一_共鸣0",
    BaseSortID = 1,
    data_list = readonly({
      readonly({
        BaseSortID = 1,
        Level = 1,
        Name = "Resonance_21888_Name_1|善意的礼物",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_023.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_023.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_023.png",
        BelongGroup = "ResonanceGroupChapter1",
        UnlockCommon = 0,
        Consume = 0,
        Desc = "Resonance_21888_Desc_1|在节点【善意的礼物】处，可将 1 张「天真的回礼」加入牌库 —— 算力消耗 1，给予狂气最低的一名唤醒体 30 狂气，消耗。"
      })
    })
  },
  [17594] = {
    ID = 17594,
    CnID = "共鸣@章一_共鸣1",
    BaseSortID = 2,
    data_list = readonly({
      readonly({
        BaseSortID = 2,
        Level = 1,
        Name = "Resonance_17594_Name_1|游戏时间",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroupChapter1",
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {10},
        Desc = "Resonance_17594_Desc_1|使用「天真的回礼」狂气回复 +10"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_17594_Name_2|游戏时间",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroupChapter1",
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {20},
        Desc = "Resonance_17594_Desc_2|使用「天真的回礼」狂气回复 +20"
      }),
      readonly({
        Level = 3,
        Name = "Resonance_17594_Name_3|游戏时间",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroupChapter1",
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {30},
        Desc = "Resonance_17594_Desc_3|使用「天真的回礼」狂气回复 +30"
      })
    })
  },
  [17595] = {
    ID = 17595,
    CnID = "共鸣@章一_共鸣2",
    BaseSortID = 3,
    data_list = readonly({
      readonly({
        BaseSortID = 3,
        Level = 1,
        Name = "Resonance_17595_Name_1|影子幻想",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupChapter1",
        PreResonance = {17594},
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {1},
        Desc = "Resonance_17595_Desc_1|「天真的回礼」可以指定任意一名唤醒体。"
      })
    })
  },
  [17596] = {
    ID = 17596,
    CnID = "共鸣@章一_共鸣3",
    BaseSortID = 4,
    data_list = readonly({
      readonly({
        BaseSortID = 4,
        Level = 1,
        Name = "Resonance_17596_Name_1|伙伴约定",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_033.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_033.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_033.png",
        BelongGroup = "ResonanceGroupChapter1",
        PreResonance = {17595},
        UnlockCommon = 0,
        Consume = 5,
        StatePara = {1},
        Desc = "Resonance_17596_Desc_1|「天真的回礼」消耗算力降低 1。"
      })
    })
  },
  [17572] = {
    ID = 17572,
    CnID = "共鸣@章一_共鸣4",
    BaseSortID = 5,
    data_list = readonly({
      readonly({
        BaseSortID = 5,
        Level = 1,
        Name = "Resonance_17572_Name_1|珍贵的花香",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroupChapter1",
        PreResonance = {17595},
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {3},
        Desc = "Resonance_17572_Desc_1|在特殊节点时，从「易伤、虚弱、妙手、筹算、铁壁」刻印中随机出现 3 个，选择 1 个将其赋予「天真的回礼」。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_17572_Name_2|珍贵的花香",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroupChapter1",
        PreResonance = {17595},
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {3},
        Desc = "Resonance_17572_Desc_2|在特殊节点时，从「易伤、虚弱、妙手、筹算、铁壁」高级刻印中随机出现 3 个，选择 1 个将其赋予「天真的回礼」。"
      })
    })
  },
  [17590] = {
    ID = 17590,
    CnID = "共鸣@章一_共鸣5",
    BaseSortID = 6,
    data_list = readonly({
      readonly({
        BaseSortID = 6,
        Level = 1,
        Name = "Resonance_17590_Name_1|梦中的回忆",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroupChapter1",
        PreResonance = {17572},
        UnlockCommon = 0,
        Consume = 9,
        StatePara = {3},
        Desc = "Resonance_17590_Desc_1|「天真的回礼」在首领战斗中，使用 3 次后才会被消耗。"
      })
    })
  },
  [21889] = {
    ID = 21889,
    CnID = "共鸣@章二_共鸣0",
    BaseSortID = 7,
    data_list = readonly({
      readonly({
        BaseSortID = 7,
        Level = 1,
        Name = "Resonance_21889_Name_1|未完的蜡像",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupChapter2",
        UnlockCommon = 0,
        Consume = 0,
        Desc = "Resonance_21889_Desc_1|在节点【未完的蜡像】处，可选择 1 张卡牌，使其算力消耗降低1。"
      })
    })
  },
  [17574] = {
    ID = 17574,
    CnID = "共鸣@章二_共鸣1",
    BaseSortID = 8,
    data_list = readonly({
      readonly({
        BaseSortID = 8,
        Level = 1,
        Name = "Resonance_17574_Name_1|普鲁士蓝",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_021.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_021.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_021.png",
        BelongGroup = "ResonanceGroupChapter2",
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {30},
        Desc = "Resonance_17574_Desc_1|选择的卡牌打出后额外获得 30 钥能。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_17574_Name_2|普鲁士蓝",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_021.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_021.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_021.png",
        BelongGroup = "ResonanceGroupChapter2",
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {60},
        Desc = "Resonance_17574_Desc_2|选择的卡牌打出后额外获得 60 钥能。"
      }),
      readonly({
        Level = 3,
        Name = "Resonance_17574_Name_3|普鲁士蓝",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_021.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_021.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_021.png",
        BelongGroup = "ResonanceGroupChapter2",
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {100},
        Desc = "Resonance_17574_Desc_3|选择的卡牌打出后额外获得 100 钥能。"
      })
    })
  },
  [17575] = {
    ID = 17575,
    CnID = "共鸣@章二_共鸣2",
    BaseSortID = 9,
    data_list = readonly({
      readonly({
        BaseSortID = 9,
        Level = 1,
        Name = "Resonance_17575_Name_1|眼球的梦",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroupChapter2",
        PreResonance = {17574},
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {1},
        Desc = "Resonance_17575_Desc_1|选择的卡牌获得固有。"
      })
    })
  },
  [17576] = {
    ID = 17576,
    CnID = "共鸣@章二_共鸣3",
    BaseSortID = 10,
    data_list = readonly({
      readonly({
        BaseSortID = 10,
        Level = 1,
        Name = "Resonance_17576_Name_1|蜜蜡之约",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_023.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_023.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_023.png",
        BelongGroup = "ResonanceGroupChapter2",
        PreResonance = {17574},
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {1},
        Desc = "Resonance_17576_Desc_1|选择的卡牌从「易伤、虚弱、妙手、筹算、铁壁」中随机获得 1 个刻印。"
      })
    })
  },
  [17577] = {
    ID = 17577,
    CnID = "共鸣@章二_共鸣4",
    BaseSortID = 11,
    data_list = readonly({
      readonly({
        BaseSortID = 11,
        Level = 1,
        Name = "Resonance_17577_Name_1|刻刀的追忆",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_024.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_024.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_024.png",
        BelongGroup = "ResonanceGroupChapter2",
        PreResonance = {17575},
        UnlockCommon = 0,
        Consume = 5,
        StatePara = {3},
        Desc = "Resonance_17577_Desc_1|选择的卡牌额外获得保留。"
      })
    })
  },
  [17578] = {
    ID = 17578,
    CnID = "共鸣@章二_共鸣5",
    BaseSortID = 12,
    data_list = readonly({
      readonly({
        BaseSortID = 12,
        Level = 1,
        Name = "Resonance_17578_Name_1|伽拉忒亚的面纱",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_025.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_025.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_025.png",
        BelongGroup = "ResonanceGroupChapter2",
        PreResonance = {17576},
        UnlockCommon = 0,
        Consume = 5,
        StatePara = {1},
        Desc = "Resonance_17578_Desc_1|选择的卡牌算力消耗额外降低1。"
      })
    })
  },
  [17579] = {
    ID = 17579,
    CnID = "共鸣@章二_共鸣6",
    BaseSortID = 13,
    data_list = readonly({
      readonly({
        BaseSortID = 13,
        Level = 1,
        Name = "Resonance_17579_Name_1|再衍化",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroupChapter2",
        PreResonance = {17577, 17578},
        UnlockCommon = 0,
        Consume = 9,
        StatePara = {1},
        Desc = "Resonance_17579_Desc_1|首领战斗中，获得一张选择卡牌的复制加入牌库。"
      })
    })
  },
  [21891] = {
    ID = 21891,
    CnID = "共鸣@章三_共鸣0",
    BaseSortID = 14,
    data_list = readonly({
      readonly({
        BaseSortID = 14,
        Level = 1,
        Name = "Resonance_21891_Name_1|古怪脓疱",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_036.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_036.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_036.png",
        BelongGroup = "ResonanceGroupChapter3",
        UnlockCommon = 0,
        Consume = 0,
        Desc = "Resonance_21891_Desc_1|在节点【古怪脓疱】处，可将一张「畸变之心」加入牌库，算力消耗 0，打出后弃掉所有手牌并抽取弃牌数+1的牌，消耗。"
      })
    })
  },
  [17586] = {
    ID = 17586,
    CnID = "共鸣@章三_共鸣1",
    BaseSortID = 15,
    data_list = readonly({
      readonly({
        BaseSortID = 15,
        Level = 1,
        Name = "Resonance_17586_Name_1|极寒磨砺",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_021.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_021.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_021.png",
        BelongGroup = "ResonanceGroupChapter3",
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {1},
        Desc = "Resonance_17586_Desc_1|从「易伤、虚弱、妙手、筹算、铁壁、爆发、衰竭、灵感」刻印中随机出现 3 个，选择一个将其赋予给畸变之心。"
      })
    })
  },
  [17588] = {
    ID = 17588,
    CnID = "共鸣@章三_共鸣2",
    BaseSortID = 16,
    data_list = readonly({
      readonly({
        BaseSortID = 16,
        Level = 1,
        Name = "Resonance_17588_Name_1|顽抗之志",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroupChapter3",
        PreResonance = {17586},
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {1},
        Desc = "Resonance_17588_Desc_1|「畸变之心」额外抽取 1 张牌。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_17588_Name_2|顽抗之志",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroupChapter3",
        PreResonance = {17586},
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {2},
        Desc = "Resonance_17588_Desc_2|「畸变之心」额外抽取 2 张牌。"
      })
    })
  },
  [17587] = {
    ID = 17587,
    CnID = "共鸣@章三_共鸣3",
    BaseSortID = 17,
    data_list = readonly({
      readonly({
        BaseSortID = 17,
        Level = 1,
        Name = "Resonance_17587_Name_1|凝胶狂涌",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_023.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_023.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_023.png",
        BelongGroup = "ResonanceGroupChapter3",
        PreResonance = {17586},
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {1},
        Desc = "Resonance_17587_Desc_1|「畸变之心」附加「固有」效果。"
      })
    })
  },
  [17583] = {
    ID = 17583,
    CnID = "共鸣@章三_共鸣4",
    BaseSortID = 18,
    data_list = readonly({
      readonly({
        BaseSortID = 18,
        Level = 1,
        Name = "Resonance_17583_Name_1|脓液覆盖",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroupChapter3",
        PreResonance = {17588, 17587},
        UnlockCommon = 0,
        Consume = 5,
        StatePara = {2},
        Desc = "Resonance_17583_Desc_1|首领战斗中，「畸变之心」可以使用 2 次。"
      })
    })
  },
  [17582] = {
    ID = 17582,
    CnID = "共鸣@章三_共鸣5",
    BaseSortID = 19,
    data_list = readonly({
      readonly({
        BaseSortID = 19,
        Level = 1,
        Name = "Resonance_17582_Name_1|负隅之镜",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_024.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_024.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_024.png",
        BelongGroup = "ResonanceGroupChapter3",
        PreResonance = {17583},
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {1},
        Desc = "Resonance_17582_Desc_1|将「畸变之心」的刻印升级为高级刻印。"
      })
    })
  },
  [17585] = {
    ID = 17585,
    CnID = "共鸣@章三_共鸣6",
    BaseSortID = 20,
    data_list = readonly({
      readonly({
        BaseSortID = 20,
        Level = 1,
        Name = "Resonance_17585_Name_1|tokulili",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_025.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_025.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_025.png",
        BelongGroup = "ResonanceGroupChapter3",
        PreResonance = {17583},
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {5},
        Desc = "Resonance_17585_Desc_1|「畸变之心」打出后所有友方获得 5 狂气。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_17585_Name_2|tokulili",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_025.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_025.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_025.png",
        BelongGroup = "ResonanceGroupChapter3",
        PreResonance = {17583},
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {10},
        Desc = "Resonance_17585_Desc_2|「畸变之心」打出后所有友方获得 10 狂气。"
      }),
      readonly({
        Level = 3,
        Name = "Resonance_17585_Name_3|tokulili",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_025.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_025.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_025.png",
        BelongGroup = "ResonanceGroupChapter3",
        PreResonance = {17583},
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {15},
        Desc = "Resonance_17585_Desc_3|「畸变之心」打出后所有友方获得 15 狂气。"
      })
    })
  },
  [17584] = {
    ID = 17584,
    CnID = "共鸣@章三_共鸣7",
    BaseSortID = 21,
    data_list = readonly({
      readonly({
        BaseSortID = 21,
        Level = 1,
        Name = "Resonance_17584_Name_1|档案中的隐秘",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroupChapter3",
        PreResonance = {17582, 17585},
        UnlockCommon = 0,
        Consume = 9,
        StatePara = {1},
        Desc = "Resonance_17584_Desc_1|首领战斗中打出时，重新抽取的牌本回合算力消耗降低 1 。"
      })
    })
  },
  [21892] = {
    ID = 21892,
    CnID = "共鸣@章四_共鸣0",
    BaseSortID = 22,
    data_list = readonly({
      readonly({
        BaseSortID = 22,
        Level = 1,
        Name = "Resonance_21892_Name_1|蜂蜜甜酒",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroupChapter4",
        UnlockCommon = 0,
        Consume = 0,
        Desc = "Resonance_21892_Desc_1|在节点【蜂蜜甜酒】处，可将一张「蜂蜜甜酒」加入牌库 —— 算力消耗 1，获得 1 层临时屏障，消耗。"
      })
    })
  },
  [17581] = {
    ID = 17581,
    CnID = "共鸣@章四_共鸣1",
    BaseSortID = 23,
    data_list = readonly({
      readonly({
        BaseSortID = 23,
        Level = 1,
        Name = "Resonance_17581_Name_1|致无知者",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroupChapter4",
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {1},
        Desc = "Resonance_17581_Desc_1|「蜂蜜甜酒」使下回合开始时额外获得 1 算力"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_17581_Name_2|致无知者",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroupChapter4",
        UnlockCommon = 0,
        Consume = 3,
        StatePara = {2},
        Desc = "Resonance_17581_Desc_2|「蜂蜜甜酒」使下回合开始时额外获得 2 算力"
      })
    })
  },
  [17580] = {
    ID = 17580,
    CnID = "共鸣@章四_共鸣2",
    BaseSortID = 24,
    data_list = readonly({
      readonly({
        BaseSortID = 24,
        Level = 1,
        Name = "Resonance_17580_Name_1|冗余学识",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupChapter4",
        PreResonance = {17581},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_17580_Desc_1|「蜂蜜甜酒」使下回合抽牌数提高 1 。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_17580_Name_2|冗余学识",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupChapter4",
        PreResonance = {17581},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_17580_Desc_2|「蜂蜜甜酒」使下回合抽牌数提高 2 。"
      })
    })
  },
  [17593] = {
    ID = 17593,
    CnID = "共鸣@章四_共鸣3",
    BaseSortID = 25,
    data_list = readonly({
      readonly({
        BaseSortID = 25,
        Level = 1,
        Name = "Resonance_17593_Name_1|无价真理",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_033.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_033.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_033.png",
        BelongGroup = "ResonanceGroupChapter4",
        PreResonance = {17580},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_17593_Desc_1|「蜂蜜甜酒」获得\"固有\""
      })
    })
  },
  [17592] = {
    ID = 17592,
    CnID = "共鸣@章四_共鸣4",
    BaseSortID = 26,
    data_list = readonly({
      readonly({
        BaseSortID = 26,
        Level = 1,
        Name = "Resonance_17592_Name_1|超越禁忌",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_033.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_033.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_033.png",
        BelongGroup = "ResonanceGroupChapter4",
        PreResonance = {17580},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_17592_Desc_1|「蜂蜜甜酒」获得\"保留\""
      })
    })
  },
  [17591] = {
    ID = 17591,
    CnID = "共鸣@章四_共鸣5",
    BaseSortID = 27,
    data_list = readonly({
      readonly({
        BaseSortID = 27,
        Level = 1,
        Name = "Resonance_17591_Name_1|高维视野",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroupChapter4",
        PreResonance = {17593, 17580},
        UnlockCommon = 0,
        Consume = 5,
        Desc = "Resonance_17591_Desc_1|「蜂蜜甜酒」的屏障数提高 1"
      })
    })
  },
  [17573] = {
    ID = 17573,
    CnID = "共鸣@章四_共鸣6",
    BaseSortID = 28,
    data_list = readonly({
      readonly({
        BaseSortID = 28,
        Level = 1,
        Name = "Resonance_17573_Name_1|跃迁之手",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroupChapter4",
        PreResonance = {17591},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_17573_Desc_1|「蜂蜜甜酒」将 1 张灵感置入抽牌堆"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_17573_Name_2|跃迁之手",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroupChapter4",
        PreResonance = {17591},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_17573_Desc_2|「蜂蜜甜酒」将 2 张灵感置入抽牌堆"
      })
    })
  },
  [17589] = {
    ID = 17589,
    CnID = "共鸣@章四_共鸣7",
    BaseSortID = 29,
    data_list = readonly({
      readonly({
        BaseSortID = 29,
        Level = 1,
        Name = "Resonance_17589_Name_1|万维之旅",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroupChapter4",
        PreResonance = {17591},
        UnlockCommon = 0,
        Consume = 9,
        Desc = "Resonance_17589_Desc_1|首领战中打出「蜂蜜甜酒」后，所有唤醒体获得 30 狂气，并解除封印状态"
      })
    })
  },
  [21890] = {
    ID = 21890,
    CnID = "共鸣@章五_共鸣0",
    BaseSortID = 30,
    data_list = readonly({
      readonly({
        BaseSortID = 30,
        Level = 1,
        Name = "Resonance_21890_Name_1|代行者的同行",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_025.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_025.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_025.png",
        BelongGroup = "ResonanceGroupChapter5",
        UnlockCommon = 0,
        Consume = 0,
        Desc = "Resonance_21890_Desc_1|于「沉溺之徒」及之后关卡的「代行之仪」节点处，获得「神国腕肢」效果——回合结束后对前排敌方造成自身队伍 10% 最大生命的伤害。\n可将一张「代行者的裁决」加入牌库——0算力消耗，打出后失去 10% 当前生命，使「神国腕肢」对后排敌方造成 3 倍伤害，若在首领战中则造成 10 倍伤害。消耗。"
      })
    })
  },
  [17597] = {
    ID = 17597,
    CnID = "共鸣@章五_共鸣1",
    BaseSortID = 31,
    data_list = readonly({
      readonly({
        BaseSortID = 31,
        Level = 1,
        Name = "Resonance_17597_Name_1|代行者的祭仪",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_024.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_024.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_024.png",
        BelongGroup = "ResonanceGroupChapter5",
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_17597_Desc_1|「神国腕肢」每击杀 1 个敌人，造成的伤害提高 2% 最大生命值，最多提高 5 次。"
      })
    })
  },
  [17598] = {
    ID = 17598,
    CnID = "共鸣@章五_共鸣2",
    BaseSortID = 32,
    data_list = readonly({
      readonly({
        BaseSortID = 32,
        Level = 1,
        Name = "Resonance_17598_Name_1|代行者的呼唤",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_023.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_023.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_023.png",
        BelongGroup = "ResonanceGroupChapter5",
        PreResonance = {17597},
        UnlockCommon = 0,
        Consume = 5,
        Desc = "Resonance_17598_Desc_1|每当唤醒体使用狂气爆发，就使「神国腕肢」在回合结束后额外发动 1 次攻击。"
      })
    })
  },
  [17599] = {
    ID = 17599,
    CnID = "共鸣@章五_共鸣3",
    BaseSortID = 33,
    data_list = readonly({
      readonly({
        BaseSortID = 33,
        Level = 1,
        Name = "Resonance_17599_Name_1|代行者的愤慨",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_036.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_036.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_036.png",
        BelongGroup = "ResonanceGroupChapter5",
        PreResonance = {17597},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_17599_Desc_1|每当守密人使用钥令，就使「神国腕肢」在回合结束后发动的攻击变为全体敌方。"
      })
    })
  },
  [17600] = {
    ID = 17600,
    CnID = "共鸣@章五_共鸣4",
    BaseSortID = 34,
    data_list = readonly({
      readonly({
        BaseSortID = 34,
        Level = 1,
        Name = "Resonance_17600_Name_1|代行者的复苏",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroupChapter5",
        PreResonance = {17598, 17599},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_17600_Desc_1|「代行者的裁决」驱散自身所有易伤、虚弱、脆弱状态。"
      })
    })
  },
  [17601] = {
    ID = 17601,
    CnID = "共鸣@章五_共鸣5",
    BaseSortID = 35,
    data_list = readonly({
      readonly({
        BaseSortID = 35,
        Level = 1,
        Name = "Resonance_17601_Name_1|代行者的同调",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupChapter5",
        PreResonance = {17599},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_17601_Desc_1|「代行者的裁决」在手牌中时，回合结束时获得 150 点银钥能量。"
      })
    })
  },
  [17602] = {
    ID = 17602,
    CnID = "共鸣@章五_共鸣6",
    BaseSortID = 36,
    data_list = readonly({
      readonly({
        BaseSortID = 36,
        Level = 1,
        Name = "Resonance_17602_Name_1|代行者的眷顾",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroupChapter5",
        PreResonance = {17600, 17601},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_17602_Desc_1|「代行者的裁决」获得保留，固有。获得 35% 最大生命的护盾。"
      })
    })
  },
  [17603] = {
    ID = 17603,
    CnID = "共鸣@章五_共鸣7",
    BaseSortID = 37,
    data_list = readonly({
      readonly({
        BaseSortID = 37,
        Level = 1,
        Name = "Resonance_17603_Name_1|神王的链接",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroupChapter5",
        PreResonance = {17602},
        UnlockCommon = 0,
        Consume = 9,
        Desc = "Resonance_17603_Desc_1|在首领战中，每当守密人使用钥令，就使「神国腕肢」造成的伤害提高 5% 最大生命值的伤害。"
      })
    })
  },
  [35108] = {
    ID = 35108,
    CnID = "共鸣@莉莉活动_共鸣0",
    BaseSortID = 38,
    data_list = readonly({
      readonly({
        BaseSortID = 38,
        Level = 1,
        Name = "Resonance_35108_Name_1|制片人的迷思",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_025.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_025.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_025.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        UnlockCommon = 0,
        Consume = 0,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_35108_Desc_1|在共鸣事件「制片人的迷思」处，选项「求助合伙人」可以获得高级刻印 3 选 1 。"
      })
    })
  },
  [35107] = {
    ID = 35107,
    CnID = "共鸣@莉莉活动_共鸣1",
    BaseSortID = 39,
    data_list = readonly({
      readonly({
        BaseSortID = 39,
        Level = 1,
        Name = "Resonance_35107_Name_1|充分睡眠",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_35107_Desc_1|在联络点选择休息后，获得普通刻印 3 选 1 的机会。",
        Story = "Resonance_35107_Story_1|莉莉不希望你熬夜，也不想让你在片场睡觉。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_35107_Name_2|充分睡眠",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_35107_Desc_2|在联络点选择休息后，获得高级刻印 3 选 1 的机会。"
      })
    })
  },
  [35110] = {
    ID = 35110,
    CnID = "共鸣@莉莉活动_共鸣2",
    BaseSortID = 40,
    data_list = readonly({
      readonly({
        BaseSortID = 40,
        Level = 1,
        Name = "Resonance_35110_Name_1|片场统筹",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35107},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_35110_Desc_1|在共鸣事件「制片人的迷思」处出现额外选项「片场统筹」，可以获得一个「黄金造物+」。",
        Story = "Resonance_35110_Story_1|得有头羊吆喝着，羊群才能跑起来。"
      })
    })
  },
  [35109] = {
    ID = 35109,
    CnID = "共鸣@莉莉活动_共鸣3",
    BaseSortID = 41,
    data_list = readonly({
      readonly({
        BaseSortID = 41,
        Level = 1,
        Name = "Resonance_35109_Name_1|演出指导",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_024.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_024.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_024.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35110},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        AwakerAttrs = readonly({basic_damage_per = 33}),
        Desc = "Resonance_35109_Desc_1|所有唤醒体的伤害强效增加 33%。",
        Story = "Resonance_35109_Story_1|卡茜亚大师会提供所有你需要的演出指导，当然，她也是从别人那儿学来的。切记：部分吸取。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_35109_Name_2|演出指导",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_024.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_024.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_024.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35110},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        AwakerAttrs = readonly({basic_damage_per = 66}),
        Desc = "Resonance_35109_Desc_2|所有唤醒体的伤害强效增加 66%。"
      }),
      readonly({
        Level = 3,
        Name = "Resonance_35109_Name_3|演出指导",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_024.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_024.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_024.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35110},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        AwakerAttrs = readonly({basic_damage_per = 100}),
        Desc = "Resonance_35109_Desc_3|所有唤醒体的伤害强效增加 100%。"
      })
    })
  },
  [35112] = {
    ID = 35112,
    CnID = "共鸣@莉莉活动_共鸣4",
    BaseSortID = 42,
    data_list = readonly({
      readonly({
        BaseSortID = 42,
        Level = 1,
        Name = "Resonance_35112_Name_1|灵感调度",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35109},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_35112_Desc_1|在「幻象」中额外将 1 张「灵感」加入牌库。",
        Story = "Resonance_35112_Story_1|幻象是天赐的灵感。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_35112_Name_2|灵感调度",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35109},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_35112_Desc_2|在「幻象」中额外将 2 张「灵感」加入牌库。"
      })
    })
  },
  [35111] = {
    ID = 35111,
    CnID = "共鸣@莉莉活动_共鸣5",
    BaseSortID = 43,
    data_list = readonly({
      readonly({
        BaseSortID = 43,
        Level = 1,
        Name = "Resonance_35111_Name_1|成本核算",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {35257},
        StateTarget1 = "PlayerRole",
        StatePara1 = {5},
        Desc = "Resonance_35111_Desc_1|击败怪物后额外获得 5 黑印。",
        Story = "Resonance_35111_Story_1|不会比弥萨格大学的微积分课程更难计算，除非是八位数以上的口算。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_35111_Name_2|成本核算",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {35257},
        StateTarget1 = "PlayerRole",
        StatePara1 = {10},
        Desc = "Resonance_35111_Desc_2|击败怪物后额外获得 10 黑印。"
      })
    })
  },
  [35114] = {
    ID = 35114,
    CnID = "共鸣@莉莉活动_共鸣6",
    BaseSortID = 44,
    data_list = readonly({
      readonly({
        BaseSortID = 44,
        Level = 1,
        Name = "Resonance_35114_Name_1|商业计划",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_021.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_021.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_021.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35111},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {35233},
        StateTarget1 = "PlayerRole",
        StatePara1 = {50},
        Desc = "Resonance_35114_Desc_1|探索开始时，获得 50 黑印。",
        Story = "Resonance_35114_Story_1|这是德克斯特小姐偷偷塞给你的零用，她很担心你会因为提前花光了预算而玩得不开心。"
      })
    })
  },
  [35113] = {
    ID = 35113,
    CnID = "共鸣@莉莉活动_共鸣7",
    BaseSortID = 45,
    data_list = readonly({
      readonly({
        BaseSortID = 45,
        Level = 1,
        Name = "Resonance_35113_Name_1|院线合作",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35114},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        AwakerAttrs = readonly({keeper_energy_eff_2 = 33}),
        Desc = "Resonance_35113_Desc_1|所有唤醒体的银钥充能等级增加 33%。",
        Story = "Resonance_35113_Story_1|弥萨格大学藏着一个名为「菲林诗社」的团体，或许他们会对莉莉主演的电影感兴趣。但要怎么才能联系上他们呢？"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_35113_Name_2|院线合作",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35114},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        AwakerAttrs = readonly({keeper_energy_eff_2 = 66}),
        Desc = "Resonance_35113_Desc_2|所有唤醒体的银钥充能等级增加 66%。"
      }),
      readonly({
        Level = 3,
        Name = "Resonance_35113_Name_3|院线合作",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35114},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        AwakerAttrs = readonly({keeper_energy_eff_2 = 100}),
        Desc = "Resonance_35113_Desc_3|所有唤醒体的银钥充能等级增加 100%。"
      })
    })
  },
  [35106] = {
    ID = 35106,
    CnID = "共鸣@莉莉活动_共鸣8",
    BaseSortID = 46,
    data_list = readonly({
      readonly({
        BaseSortID = 46,
        Level = 1,
        Name = "Resonance_35106_Name_1|道具采购",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_023.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_023.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_023.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35113},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        StatePara = {2, 25},
        Desc = "Resonance_35106_Desc_1|商店刷新次数+2。",
        Story = "Resonance_35106_Story_1|请注意保留购物凭证，不然本次开销，全部走守密人的私人钱包。"
      })
    })
  },
  [35105] = {
    ID = 35105,
    CnID = "共鸣@莉莉活动_共鸣9",
    BaseSortID = 47,
    data_list = readonly({
      readonly({
        BaseSortID = 47,
        Level = 1,
        Name = "Resonance_35105_Name_1|延时摄影",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_033.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_033.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_033.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {35273},
        StateTarget1 = "PlayerRole",
        StatePara1 = {10},
        Desc = "Resonance_35105_Desc_1|触发死亡抵抗后每次衰减比例从 50% 降低为 40% 。",
        Story = "Resonance_35105_Story_1|参与拍摄的大家根本不知道「延时摄影」是什么意思，只觉得这个词很酷。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_35105_Name_2|延时摄影",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_033.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_033.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_033.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {35273},
        StateTarget1 = "PlayerRole",
        StatePara1 = {20},
        Desc = "Resonance_35105_Desc_2|触发死亡抵抗后每次衰减比例从 50% 降低为 30% 。"
      })
    })
  },
  [35116] = {
    ID = 35116,
    CnID = "共鸣@莉莉活动_共鸣10",
    BaseSortID = 48,
    data_list = readonly({
      readonly({
        BaseSortID = 48,
        Level = 1,
        Name = "Resonance_35116_Name_1|蒙太奇回旋",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35105},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {51752},
        StateTarget1 = "PlayerRole",
        Desc = "Resonance_35116_Desc_1|击败精英后，额外进行一次白银造物3选1",
        Story = "Resonance_35116_Story_1|卡茜亚最擅长的把戏：用快速的场景切换迷晕你们的脑子。"
      })
    })
  },
  [35115] = {
    ID = 35115,
    CnID = "共鸣@莉莉活动_共鸣11",
    BaseSortID = 49,
    data_list = readonly({
      readonly({
        BaseSortID = 49,
        Level = 1,
        Name = "Resonance_35115_Name_1|单张关键帧",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35116},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        AwakerAttrs = readonly({ulti_energy_plus_3 = 33}),
        Desc = "Resonance_35115_Desc_1|所有唤醒体的狂气回充等级增加 33%。",
        Story = "Resonance_35115_Story_1|守密人希望莉莉的笑容能停在这张关键帧上，但……「关键帧」好像不是这么用的。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_35115_Name_2|单张关键帧",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35116},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        AwakerAttrs = readonly({ulti_energy_plus_3 = 66}),
        Desc = "Resonance_35115_Desc_2|所有唤醒体的狂气回充等级增加 66%。"
      }),
      readonly({
        Level = 3,
        Name = "Resonance_35115_Name_3|单张关键帧",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35116},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        AwakerAttrs = readonly({ulti_energy_plus_3 = 100}),
        Desc = "Resonance_35115_Desc_3|所有唤醒体的狂气回充等级增加 100%。"
      })
    })
  },
  [35118] = {
    ID = 35118,
    CnID = "共鸣@莉莉活动_共鸣12",
    BaseSortID = 50,
    data_list = readonly({
      readonly({
        BaseSortID = 50,
        Level = 1,
        Name = "Resonance_35118_Name_1|交叠剪辑",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35115},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {51753},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_35118_Desc_1|造物上限 +1。",
        Story = "Resonance_35118_Story_1|什么是「剪辑」？奥瑞塔如此问道。\n大家面面相觑，没有一个人能回答这个问题。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_35118_Name_2|交叠剪辑",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35115},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {51753},
        StateTarget1 = "PlayerRole",
        StatePara1 = {2},
        Desc = "Resonance_35118_Desc_2|造物上限 +2。"
      }),
      readonly({
        Level = 3,
        Name = "Resonance_35118_Name_3|交叠剪辑",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {35115},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {51753},
        StateTarget1 = "PlayerRole",
        StatePara1 = {3},
        Desc = "Resonance_35118_Desc_3|造物上限 +3。"
      })
    })
  },
  [35117] = {
    ID = 35117,
    CnID = "共鸣@莉莉活动_共鸣13",
    BaseSortID = 51,
    data_list = readonly({
      readonly({
        BaseSortID = 51,
        Level = 1,
        Name = "Resonance_35117_Name_1|现象级狂热",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_036.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_036.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_036.png",
        BelongGroup = "ResonanceGroupMagicStoryActivity",
        PreResonance = {
          35112,
          35106,
          35118
        },
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_35117_Desc_1|在共鸣事件「制片人的迷思」处出现额外选项「现象级狂热」，可以获得一个「时灵摆」造物。",
        Story = "Resonance_35117_Story_1|达芙黛尔夫人观赏过全片后，派人送来了她的赞誉：如果这部影片能公开上映，肯定有很多人愿意成为莉莉的「母亲」。"
      })
    })
  },
  [35745] = {
    ID = 35745,
    CnID = "共鸣@章六_共鸣0",
    BaseSortID = 52,
    data_list = readonly({
      readonly({
        BaseSortID = 52,
        Level = 1,
        Name = "Resonance_35745_Name_1|纯白之帆",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_039.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_039.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_039.png",
        BelongGroup = "ResonanceGroupChapter6",
        UnlockCommon = 0,
        Consume = 0,
        Desc = "Resonance_35745_Desc_1|于「纯白之帆」处，将一张「乌托邦帷幕」加入牌库。1 算力消耗，查看 3 个与当前携带不同的钥令，选择 1 个立即释放，不会触发钥令冷却。首领战中可额外使用 1 次。消耗。"
      })
    })
  },
  [35744] = {
    ID = 35744,
    CnID = "共鸣@章六_共鸣1",
    BaseSortID = 53,
    data_list = readonly({
      readonly({
        BaseSortID = 53,
        Level = 1,
        Name = "Resonance_35744_Name_1|北角灯塔",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_021.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_021.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_021.png",
        BelongGroup = "ResonanceGroupChapter6",
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_35744_Desc_1|「乌托邦帷幕」获得 300 银钥能量。"
      })
    })
  },
  [35747] = {
    ID = 35747,
    CnID = "共鸣@章六_共鸣2",
    BaseSortID = 54,
    data_list = readonly({
      readonly({
        BaseSortID = 54,
        Level = 1,
        Name = "Resonance_35747_Name_1|撒拉伦的高墙",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroupChapter6",
        PreResonance = {35744},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_35747_Desc_1|「乌托邦帷幕」获得保留。"
      })
    })
  },
  [35746] = {
    ID = 35746,
    CnID = "共鸣@章六_共鸣3",
    BaseSortID = 55,
    data_list = readonly({
      readonly({
        BaseSortID = 55,
        Level = 1,
        Name = "Resonance_35746_Name_1|欢愉不再之地",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroupChapter6",
        PreResonance = {35747},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_35746_Desc_1|「乌托邦帷幕」不再消耗算力，反而提供 1 点算力。"
      })
    })
  },
  [35749] = {
    ID = 35749,
    CnID = "共鸣@章六_共鸣4",
    BaseSortID = 56,
    data_list = readonly({
      readonly({
        BaseSortID = 56,
        Level = 1,
        Name = "Resonance_35749_Name_1|传说南岸",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroupChapter6",
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_35749_Desc_1|「乌托邦帷幕」获得 5~15% 最大生命的护盾，损失生命越高效果越高。"
      })
    })
  },
  [35748] = {
    ID = 35748,
    CnID = "共鸣@章六_共鸣5",
    BaseSortID = 57,
    data_list = readonly({
      readonly({
        BaseSortID = 57,
        Level = 1,
        Name = "Resonance_35748_Name_1|玄武岩石柱",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_036.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_036.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_036.png",
        BelongGroup = "ResonanceGroupChapter6",
        PreResonance = {35749},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_35748_Desc_1|「乌托邦帷幕」驱散自身所有中毒、封印、迟缓状态。"
      })
    })
  },
  [35751] = {
    ID = 35751,
    CnID = "共鸣@章六_共鸣6",
    BaseSortID = 58,
    data_list = readonly({
      readonly({
        BaseSortID = 58,
        Level = 1,
        Name = "Resonance_35751_Name_1|自东而来的风暴",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroupChapter6",
        PreResonance = {35748},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_35751_Desc_1|「乌托邦帷幕」回复与获得护盾等量的生命。"
      })
    })
  },
  [35750] = {
    ID = 35750,
    CnID = "共鸣@章六_共鸣7",
    BaseSortID = 59,
    data_list = readonly({
      readonly({
        BaseSortID = 59,
        Level = 1,
        Name = "Resonance_35750_Name_1|索纳尼尔的海角",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupChapter6",
        PreResonance = {35751, 35746},
        UnlockCommon = 1,
        Consume = 5,
        Desc = "Resonance_35750_Desc_1|首领战中，「乌托邦帷幕」可以额外使用 1 次。"
      })
    })
  },
  [35752] = {
    ID = 35752,
    CnID = "共鸣@章六_共鸣8",
    BaseSortID = 60,
    data_list = readonly({
      readonly({
        BaseSortID = 60,
        Level = 1,
        Name = "Resonance_35752_Name_1|自南方而来的白船",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_038.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_038.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_038.png",
        BelongGroup = "ResonanceGroupChapter6",
        PreResonance = {35750},
        UnlockCommon = 0,
        Consume = 9,
        Desc = "Resonance_35752_Desc_1|首领战中，当死亡前呼唤一次希莱斯特的援助，回复所有生命、狂气、银钥能量。"
      })
    })
  },
  [36904] = {
    ID = 36904,
    CnID = "共鸣@旺达活动_共鸣0",
    BaseSortID = 61,
    data_list = readonly({
      readonly({
        BaseSortID = 61,
        Level = 1,
        Name = "Resonance_36904_Name_1|开源节流",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_024.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_024.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_024.png",
        BelongGroup = "ResonanceGroupWangda",
        UnlockCommon = 0,
        Consume = 0,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_36904_Desc_1|「代行密令」事件中获得35黑印，然后再获得随机白银造物",
        Story = "Resonance_36904_Story_1|「你提出了一个放诸四海皆准的道理，它就像人类见面聊的天气一样毫无价值。」\n女王不满地扬起眉。\n「我需要更具体的建议。」"
      })
    })
  },
  [36903] = {
    ID = 36903,
    CnID = "共鸣@旺达活动_共鸣1",
    BaseSortID = 62,
    data_list = readonly({
      readonly({
        BaseSortID = 62,
        Level = 1,
        Name = "Resonance_36903_Name_1|休养生息",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroupWangda",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_36903_Desc_1|「联络点」中回复生命的同时可获得35黑印",
        Story = "Resonance_36903_Story_1|女王撤走了驻扎在古德里安伯爵封地附近的军队，所有人都松了一口气。"
      })
    })
  },
  [36902] = {
    ID = 36902,
    CnID = "共鸣@旺达活动_共鸣2",
    BaseSortID = 63,
    data_list = readonly({
      readonly({
        BaseSortID = 63,
        Level = 1,
        Name = "Resonance_36902_Name_1|税收达人",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroupWangda",
        PreResonance = {36903},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        AwakerAttrs = readonly({blackcoin_upgrade_per = 100}),
        Desc = "Resonance_36902_Desc_1|玩家的额外黑印掉落属性+100%",
        Story = "Resonance_36902_Story_1|制定税收政策需要审慎的无情与天马行空的想象力。\n你冥思苦想，最后规定所有居民必须为家中的牲畜缴纳放屁税——老鼠除外。\n面对你的大胆献策，女王冷冰冰地笑了起来。\n「你真是个天才。」"
      })
    })
  },
  [36901] = {
    ID = 36901,
    CnID = "共鸣@旺达活动_共鸣3",
    BaseSortID = 64,
    data_list = readonly({
      readonly({
        BaseSortID = 64,
        Level = 1,
        Name = "Resonance_36901_Name_1|领土扩张",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroupWangda",
        PreResonance = {36902},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        ItemDropAddition = readonly({
          [38704] = 0.5
        }),
        ItemDropAdditionStageGroupType = {23, 40},
        State1 = {39306},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_36901_Desc_1|「原生胫骨」掉落量 +50%，造物上限+1",
        Story = "Resonance_36901_Story_1|没有永恒的和平。既然战争不可避免，何不让它来得更早一些？\n兵贵神速，你们很快占领了老伯爵的封地。"
      })
    })
  },
  [36900] = {
    ID = 36900,
    CnID = "共鸣@旺达活动_共鸣4",
    BaseSortID = 65,
    data_list = readonly({
      readonly({
        BaseSortID = 65,
        Level = 1,
        Name = "Resonance_36900_Name_1|小猪快跑",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_033.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_033.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_033.png",
        BelongGroup = "ResonanceGroupWangda",
        PreResonance = {36901},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_36900_Desc_1|「幻象」中增加新的选项，扣除当前10%生命破除幻象，同时获得 35 黑印",
        Story = "Resonance_36900_Story_1|你派出一小队斥候，他们翻过古德里安封地的篱笆，将附近的猪悄悄绑走了。"
      })
    })
  },
  [36899] = {
    ID = 36899,
    CnID = "共鸣@旺达活动_共鸣5",
    BaseSortID = 66,
    data_list = readonly({
      readonly({
        BaseSortID = 66,
        Level = 1,
        Name = "Resonance_36899_Name_1|点石成金",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroupWangda",
        PreResonance = {36900},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_36899_Desc_1|共鸣获得的黑印效果享受额外黑印掉落属性影响",
        Story = "Resonance_36899_Story_1|「下如同上，上如同下；依此成全太一的奇迹……」\n你回忆着《翠玉录》中的箴言，希望从中悟出什么点石成金的法子。\n一周后，你理所当然地失败了。\n但你并非毫无收获——\n至少那些残余的贵金属粉末还能卖个好价钱。"
      })
    })
  },
  [36898] = {
    ID = 36898,
    CnID = "共鸣@旺达活动_共鸣6",
    BaseSortID = 67,
    data_list = readonly({
      readonly({
        BaseSortID = 67,
        Level = 1,
        Name = "Resonance_36898_Name_1|采石场",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_040.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_040.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_040.png",
        BelongGroup = "ResonanceGroupWangda",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_36898_Desc_1|「夏里奇市集」售卖高级刻印",
        Story = "Resonance_36898_Story_1|相传坎布里安西部的无名废墟中，掩埋着体型肥硕的可怖怪物。\n你率人前往此地。\n很可惜，除了一些篆刻神秘符文的刻印外，你一无所获。"
      })
    })
  },
  [36897] = {
    ID = 36897,
    CnID = "共鸣@旺达活动_共鸣7",
    BaseSortID = 68,
    data_list = readonly({
      readonly({
        BaseSortID = 68,
        Level = 1,
        Name = "Resonance_36897_Name_1|淘金者",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_025.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_025.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_025.png",
        BelongGroup = "ResonanceGroupWangda",
        PreResonance = {36898},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_36897_Desc_1|「夏里奇市集」出售特殊的升级版黄金造物",
        Story = "Resonance_36897_Story_1|你命士兵闯入你所在的教会，将埋藏地窖的黄金圣物全都挖了出来，放入市集售卖。\n愿父神宽恕你。"
      })
    })
  },
  [36906] = {
    ID = 36906,
    CnID = "共鸣@旺达活动_共鸣8",
    BaseSortID = 69,
    data_list = readonly({
      readonly({
        BaseSortID = 69,
        Level = 1,
        Name = "Resonance_36906_Name_1|非强制收容",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_021.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_021.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_021.png",
        BelongGroup = "ResonanceGroupWangda",
        PreResonance = {36897},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        ItemDropAddition = readonly({
          [38703] = 0.5
        }),
        ItemDropAdditionStageGroupType = {23, 40},
        State1 = {39304},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_36906_Desc_1|「圆叶菊石」掉落量 +50%，造物上限+1",
        Story = "Resonance_36906_Story_1|你们收容了在边境流窜的波西米亚人。\n为表感谢，他们向坎布里奇献上了所剩无几的金钱、音乐与满满的跳蚤。"
      })
    })
  },
  [36905] = {
    ID = 36905,
    CnID = "共鸣@旺达活动_共鸣9",
    BaseSortID = 70,
    data_list = readonly({
      readonly({
        BaseSortID = 70,
        Level = 1,
        Name = "Resonance_36905_Name_1|大慈善家",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_023.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_023.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_023.png",
        BelongGroup = "ResonanceGroupWangda",
        PreResonance = {36906},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_36905_Desc_1|「夏里奇市集」售卖时灵摆造物",
        Story = "Resonance_36905_Story_1|在你的劝说下，女王不太甘愿地打开保险柜，将自己珍藏已久的宝物交了出来。\n「我是个领主，又不是慈善家。」\n「那是当然——慈善家可做不了领主。」"
      })
    })
  },
  [36893] = {
    ID = 36893,
    CnID = "共鸣@旺达活动_共鸣10",
    BaseSortID = 71,
    data_list = readonly({
      readonly({
        BaseSortID = 71,
        Level = 1,
        Name = "Resonance_36893_Name_1|重商主义",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_039.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_039.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_039.png",
        BelongGroup = "ResonanceGroupWangda",
        PreResonance = {36905},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        StatePara = {2},
        Desc = "Resonance_36893_Desc_1|「夏里奇市集」增加2次刷新次数，每次25黑印",
        Story = "Resonance_36893_Story_1|在你的坚持下，夏里奇从两周一次变为一周一次开放。\n市集热闹无比，就连女王破天荒露面并买了一个红宝石胸针。\n当天晚上，女王命你将胸针别在长袍上。\n没有她的命令，永远不许摘下。"
      })
    })
  },
  [36892] = {
    ID = 36892,
    CnID = "共鸣@旺达活动_共鸣11",
    BaseSortID = 72,
    data_list = readonly({
      readonly({
        BaseSortID = 72,
        Level = 1,
        Name = "Resonance_36892_Name_1|是！女王陛下！",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_036.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_036.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_036.png",
        BelongGroup = "ResonanceGroupWangda",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_36892_Desc_1|「代行密令」事件中增加选项，可获得诅咒造物",
        Story = "Resonance_36892_Story_1|洪积@2年6月，王国女王的御撵抵达了她忠实的坎布里安。\n女王此次南下巡游，仅在宫殿逗留不到半日。\n奇怪的是，你丢失了有关女王的大部分记忆——\n除了那层层峦峦的黑纱，将她肥硕的身躯裹于其中，\n仿佛一口暮气沉沉的棺木。"
      })
    })
  },
  [36891] = {
    ID = 36891,
    CnID = "共鸣@旺达活动_共鸣12",
    BaseSortID = 73,
    data_list = readonly({
      readonly({
        BaseSortID = 73,
        Level = 1,
        Name = "Resonance_36891_Name_1|观星者协会",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroupWangda",
        PreResonance = {36892},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_36891_Desc_1|「代行密令」事件中获得的白银造物数量+1",
        Story = "Resonance_36891_Story_1|你为坎布里安的占星师们组建了一个协会。\n协会成员需要定期交流学术、占卜、为居民表演节目。\n女王对此嗤之以鼻。\n「我从不相信星座。我是天蝎座，生性多疑。」"
      })
    })
  },
  [36890] = {
    ID = 36890,
    CnID = "共鸣@旺达活动_共鸣13",
    BaseSortID = 74,
    data_list = readonly({
      readonly({
        BaseSortID = 74,
        Level = 1,
        Name = "Resonance_36890_Name_1|必要性远征",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroupWangda",
        PreResonance = {36891},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        ItemDropAddition = readonly({
          [38702] = 0.5
        }),
        ItemDropAdditionStageGroupType = {23, 40},
        State1 = {39305},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_36890_Desc_1|「螺旋遗迹」掉落量 +50%，造物上限+1",
        Story = "Resonance_36890_Story_1|坎布里安的临终倒计时仍在继续。\n对于它附近的领主而言，这可是天大的好事。\n我们急需一场胜利吓退四周逡巡的野狗。"
      })
    })
  },
  [36896] = {
    ID = 36896,
    CnID = "共鸣@旺达活动_共鸣14",
    BaseSortID = 75,
    data_list = readonly({
      readonly({
        BaseSortID = 75,
        Level = 1,
        Name = "Resonance_36896_Name_1|骑士精神",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_038.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_038.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_038.png",
        BelongGroup = "ResonanceGroupWangda",
        PreResonance = {36890},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_36896_Desc_1|「代行密令」事件中增加选项，可获得黄金造物",
        Story = "Resonance_36896_Story_1|「在这庄严的时刻，我代表领主夫人向您授予崇高的荣誉……」\n你册封了数名骑士。\n这些年轻人眼含热泪，发誓将为领主献出一切。"
      })
    })
  },
  [36895] = {
    ID = 36895,
    CnID = "共鸣@旺达活动_共鸣15",
    BaseSortID = 76,
    data_list = readonly({
      readonly({
        BaseSortID = 76,
        Level = 1,
        Name = "Resonance_36895_Name_1|启蒙运动",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupWangda",
        PreResonance = {36896},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_36895_Desc_1|「代行密令」事件在获得25黑印的同时随机觉醒一个唤醒体",
        Story = "Resonance_36895_Story_1|坎布里安的第一所学堂正式建成。\n身为方圆数英里学识最高的修士，你成为了学堂里唯一的老师。\n天文、神学、养猪……\n是的，你还需要教会大家如何科学养猪。"
      })
    })
  },
  [36894] = {
    ID = 36894,
    CnID = "共鸣@旺达活动_共鸣16",
    BaseSortID = 77,
    data_list = readonly({
      readonly({
        BaseSortID = 77,
        Level = 1,
        Name = "Resonance_36894_Name_1|终曲",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_041.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_041.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_041.png",
        BelongGroup = "ResonanceGroupWangda",
        PreResonance = {
          36895,
          36893,
          36899
        },
        UnlockCommon = 1,
        Consume = 3,
        ResonantConversion = {10108, 5000},
        State1 = {39307},
        StateTarget1 = "PlayerRole",
        StatePara1 = {5},
        Desc = "Resonance_36894_Desc_1|造物上限+5",
        Story = "Resonance_36894_Story_1|政令如雪花般飘出宫殿，飞向坎布里安的每个角落。\n出乎意料的是，你的小小改革效果不错。\n「完美的临终关怀，现在你终于有点像个修士了。」\n你摊了摊手。\n「很遗憾，这场改革只进行了不到三个月。」\n女王笑着望向窗外冒出新芽的田地，眼神温和。\n「快乐的记忆，哪怕只有一瞬间——也会被永远铭记。」"
      })
    })
  },
  [44175] = {
    ID = 44175,
    CnID = "共鸣@萨尔瓦多活动_共鸣0",
    BaseSortID = 78,
    data_list = readonly({
      readonly({
        BaseSortID = 78,
        Level = 1,
        Name = "Resonance_44175_Name_1|迷途的起点",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_042.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_042.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_042.png",
        BelongGroup = "ResonanceGroupSEWD",
        UnlockCommon = 0,
        Consume = 0,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_44175_Desc_1|「欲望」事件获得随机原罪造物；「忏悔」事件将负罪造物净化为受祝造物；「救赎」事件可以删除症状卡获得奖励。",
        Story = "Resonance_44175_Story_1|三个不同的灵魂在歧路上徘徊。它们邀请你做它们旅程的见证者，目睹它们的选择。\n「我们恳求你，苍白的使者，在我们消散前给予我们你公正的判决。」"
      })
    })
  },
  [44193] = {
    ID = 44193,
    CnID = "共鸣@萨尔瓦多活动_共鸣1",
    BaseSortID = 79,
    data_list = readonly({
      readonly({
        BaseSortID = 79,
        Level = 1,
        Name = "Resonance_44193_Name_1|主教的劝告",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_023.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_023.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_023.png",
        BelongGroup = "ResonanceGroupSEWD",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_44193_Desc_1|「欲望」事件获得原罪造物变为 3 选 1 。",
        Story = "Resonance_44193_Story_1|迷茫的灵魂向主教祈祷，希望能获得他的指引。\n「不要因为你的苦难而失去希望，不要因为经受过诱惑而彷徨。\n「紧握你的信念，我的孩子，然后跟随父神的光前行。」"
      })
    })
  },
  [44403] = {
    ID = 44403,
    CnID = "共鸣@萨尔瓦多活动_共鸣2",
    BaseSortID = 80,
    data_list = readonly({
      readonly({
        BaseSortID = 80,
        Level = 1,
        Name = "Resonance_44403_Name_1|自我放纵",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_036.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_036.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_036.png",
        BelongGroup = "ResonanceGroupSEWD",
        PreResonance = {44193},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_44403_Desc_1|在「黑印」事件中，新增选项：获得 1 张症状卡和 3 选 1 高级刻印。",
        Story = "Resonance_44403_Story_1|哪里是黑，哪里是白？在这个灰色的世界，光与暗的界限是如此模糊。\n你看着那个灵魂在道路的交叉点徘徊，然后——\n「我想要用不完的金钱，吃不完的美食，想要地位至高无上。我有什么错？」"
      })
    })
  },
  [44402] = {
    ID = 44402,
    CnID = "共鸣@萨尔瓦多活动_共鸣3",
    BaseSortID = 81,
    data_list = readonly({
      readonly({
        BaseSortID = 81,
        Level = 1,
        Name = "Resonance_44402_Name_1|拥抱黑暗",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroupSEWD",
        PreResonance = {44448},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_44402_Desc_1|在「欲望」事件中获得支援卡后，新增选项：获得 1 张症状卡，随机觉醒 1 名唤醒体。",
        Story = "Resonance_44402_Story_1|在这条漆黑的道路上，灵魂不断前行。\n它忘记了主教的劝告，忘记了光明。它的光芒愈发暗淡，几乎被黑色淹没。\n「真不知道我之前在纠结什么，」灵魂说着，朝着更深重的黑暗走去，「人总是有愿望的，我不过是在实现我的愿望罢了。」"
      })
    })
  },
  [44410] = {
    ID = 44410,
    CnID = "共鸣@萨尔瓦多活动_共鸣4",
    BaseSortID = 82,
    data_list = readonly({
      readonly({
        BaseSortID = 82,
        Level = 1,
        Name = "Resonance_44410_Name_1|肆意狂欢",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_033.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_033.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_033.png",
        BelongGroup = "ResonanceGroupSEWD",
        PreResonance = {44402},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_44410_Desc_1|「幻象」中新增选项：获得 2 张随机症状卡，获得 35 黑印。",
        Story = "Resonance_44410_Story_1|即时的欢愉往往不计后果，迷失的灵魂举起刀刃，将周遭的一切当做祭品，就是为了能长久地停留在享乐中。\n你已经完全看不到它了——黑暗已经将它吞噬，只有欢笑在空中回响。"
      })
    })
  },
  [44446] = {
    ID = 44446,
    CnID = "共鸣@萨尔瓦多活动_共鸣5",
    BaseSortID = 83,
    data_list = readonly({
      readonly({
        BaseSortID = 83,
        Level = 1,
        Name = "Resonance_44446_Name_1|听从教诲",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_025.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_025.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_025.png",
        BelongGroup = "ResonanceGroupSEWD",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_44446_Desc_1|在「救赎」事件中，可以选择消耗 2 张症状卡，获得 3 选 1 高级刻印。",
        Story = "Resonance_44446_Story_1|染上了斑驳罪孽灵魂向主教祈祷，希望能获得他的指引。\n「我们过去的错误不能决定我们的未来。只要你以后坚定地行走在父神的路上，终能回归祂的怀抱。」"
      })
    })
  },
  [44447] = {
    ID = 44447,
    CnID = "共鸣@萨尔瓦多活动_共鸣6",
    BaseSortID = 84,
    data_list = readonly({
      readonly({
        BaseSortID = 84,
        Level = 1,
        Name = "Resonance_44447_Name_1|坚定信念",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupSEWD",
        PreResonance = {44446},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_44447_Desc_1|可以花费 5 黑印解锁「迷雾结节」，解锁时额外获得 1 张灵感。",
        Story = "Resonance_44447_Story_1|浓雾遮蔽了灵魂的视线。即便是最明亮的路，也难免遭遇阴霾。\n「父神的路是笔直的，是光亮的，」灵魂闭上了眼，坚定地向前迈步，「我必将偿还我的过错，不再摆向左右，直到我生命的终结。」"
      })
    })
  },
  [44470] = {
    ID = 44470,
    CnID = "共鸣@萨尔瓦多活动_共鸣7",
    BaseSortID = 85,
    data_list = readonly({
      readonly({
        BaseSortID = 85,
        Level = 1,
        Name = "Resonance_44470_Name_1|天道酬勤",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroupSEWD",
        PreResonance = {44448},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_44470_Desc_1|在「救赎」事件中，可以选择消耗 4 张症状卡，获得 3 选 1 黄金造物+。",
        Story = "Resonance_44470_Story_1|笔直的道路也并不好走，隆起的山峰是最常见的阻碍，深不见底的悬崖则是严峻的考验。\n即便遍体鳞伤，即便体力不支，灵魂依旧在向前。而你能看到，随着它的前行，它身上的斑驳也在一点点褪去。"
      })
    })
  },
  [44471] = {
    ID = 44471,
    CnID = "共鸣@萨尔瓦多活动_共鸣8",
    BaseSortID = 86,
    data_list = readonly({
      readonly({
        BaseSortID = 86,
        Level = 1,
        Name = "Resonance_44471_Name_1|回归正途",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_039.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_039.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_039.png",
        BelongGroup = "ResonanceGroupSEWD",
        PreResonance = {44470},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_44471_Desc_1|在「救赎」事件中，可以选择消耗 6 张症状卡，获得 3 选 1 时灵摆。",
        Story = "Resonance_44471_Story_1|终点近在眼前了。\n笔直的道路仍旧笔直，斑驳的灵魂却不再斑驳。它更加轻盈，更加明亮，宛如一颗明星。\n「父神的路是笔直的，是光亮的，」灵魂重复道，「而我在父神的路上行走，我终将得到救赎。」"
      })
    })
  },
  [44476] = {
    ID = 44476,
    CnID = "共鸣@萨尔瓦多活动_共鸣9",
    BaseSortID = 87,
    data_list = readonly({
      readonly({
        BaseSortID = 87,
        Level = 1,
        Name = "Resonance_44476_Name_1|轻松的方式",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroupSEWD",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_44476_Desc_1|解锁「市民的善意」，每小时可获得 60 义卖券，最多储存 25 小时，可在活动页左下角领取。",
        Story = "Resonance_44476_Story_1|听完主教的劝告，灰色的灵魂不屑一顾。\n「什么父神的路，什么克制，麻烦得很。\n「听说洪积前的教廷有过一个制度：只要用肉眼可见的方式展示自己的虔诚，就能洗脱罪恶。既然这样……」\n灰色的灵魂决定修建一座新的圣堂，要比伦蒂尼恩的大圣堂更宏伟，比中央教廷更华丽——当然，这不能由它一个人来。只要一场义卖活动，它就能实现风险均摊。"
      })
    })
  },
  [44477] = {
    ID = 44477,
    CnID = "共鸣@萨尔瓦多活动_共鸣10",
    BaseSortID = 88,
    data_list = readonly({
      readonly({
        BaseSortID = 88,
        Level = 1,
        Name = "Resonance_44477_Name_1|与我同行",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupSEWD",
        PreResonance = {44476},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        ItemDropAddition = readonly({
          [10056] = 1
        }),
        ItemDropAdditionStageGroupType = {24, 38},
        Desc = "Resonance_44477_Desc_1|探索完成后获得的同调率翻倍。",
        Story = "Resonance_44477_Story_1|义卖的消息迅速传了开来，不少与它有相似颜色的灵魂纷纷前来，参与到这场盛会之中。\n「多么好的方法啊。」它们感叹，「这样一定能帮助更多的灵魂吧。」\n「那当然，」灰色的灵魂拍着胸脯保证，「听我的，我们都能获得救赎。」"
      })
    })
  },
  [44475] = {
    ID = 44475,
    CnID = "共鸣@萨尔瓦多活动_共鸣11",
    BaseSortID = 89,
    data_list = readonly({
      readonly({
        BaseSortID = 89,
        Level = 1,
        Name = "Resonance_44475_Name_1|赎罪，赎罪",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroupSEWD",
        PreResonance = {44448},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_44475_Desc_1|「市民的善意」每小时可额外获得 1800 蔷薇金券。",
        Story = "Resonance_44475_Story_1|将你的罪恶换成善举，将你的钱财换成信仰。只要为父神修建一座圣堂，你的过错就能一笔勾销。\n一切荣光归于祂，我们仁慈仁爱的父神。"
      })
    })
  },
  [44478] = {
    ID = 44478,
    CnID = "共鸣@萨尔瓦多活动_共鸣12",
    BaseSortID = 90,
    data_list = readonly({
      readonly({
        BaseSortID = 90,
        Level = 1,
        Name = "Resonance_44478_Name_1|我听到钟声",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroupSEWD",
        PreResonance = {44475},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        AwakerAttrs = readonly({occupation_master = 50}),
        Desc = "Resonance_44478_Desc_1|界域精通属性变为初始的 150%。",
        Story = "Resonance_44478_Story_1|圣堂落成，洪亮的钟声响彻天际。\n虽然这座圣堂并不宏伟，也不华丽，但灰色的灵魂对此非常满意。\n「父神一定不会介意的，」它说着，将剩下的捐款放入床底的保险柜中，「这不过是一些应得的报酬嘛。」"
      })
    })
  },
  [44448] = {
    ID = 44448,
    CnID = "共鸣@萨尔瓦多活动_共鸣13",
    BaseSortID = 91,
    data_list = readonly({
      readonly({
        BaseSortID = 91,
        Level = 1,
        Name = "Resonance_44448_Name_1|宽恕罪过",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_043.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_043.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_043.png",
        BelongGroup = "ResonanceGroupSEWD",
        PreResonance = {
          44403,
          44447,
          44477
        },
        UnlockCommon = 1,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_44448_Desc_1|「欲望」事件会额外获得神父的支援卡「主教的奉献」。",
        Story = "Resonance_44448_Story_1|主教又一次出现在灵魂面前。\n他看着这个经历了变化的灵魂，眼罩被同情的泪水浸透。\n「可怜的孩子，父神的羔羊，我看到你的痛苦，看到你的挣扎，」他伸出手，为灵魂带来一丝慰藉，「愿父神宽恕你的罪过，减轻你身上的负担，让你得以更轻松地前行。」"
      })
    })
  },
  [44490] = {
    ID = 44490,
    CnID = "共鸣@萨尔瓦多活动_共鸣14",
    BaseSortID = 92,
    data_list = readonly({
      readonly({
        BaseSortID = 92,
        Level = 1,
        Name = "Resonance_44490_Name_1|一切归于父神",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_044.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_044.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_044.png",
        BelongGroup = "ResonanceGroupSEWD",
        PreResonance = {
          44410,
          44471,
          44478
        },
        UnlockCommon = 1,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_44490_Desc_1|神父的支援卡「主教的奉献」在首领战中可以使用 3 次。",
        Story = "Resonance_44490_Story_1|所有的道路、所有的选择都将汇聚在此。此即一切的终点，此即万物的归宿。\n「我的快乐能否持续？」迷茫的灵魂问。\n「我的坚持是否有意义？」斑驳的灵魂问。\n「我的赎罪是否有效？」灰色的灵魂问。\n你不知道。但在死亡面前，一切都无关紧要。"
      })
    })
  },
  [47865] = {
    ID = 47865,
    CnID = "共鸣@「24」活动_共鸣0",
    BaseSortID = 93,
    data_list = readonly({
      readonly({
        BaseSortID = 93,
        Level = 1,
        Name = "Resonance_47865_Name_1|例行诊疗",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_045.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_045.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_045.png",
        BelongGroup = "ResonanceGroup24",
        UnlockCommon = 0,
        Consume = 0,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_47865_Desc_1|在「催眠蛇」事件中指定一名唤醒体使其精神分裂，失去初始的四张指令卡，此后，前进的道路才会出现并使你获得 3 选 1 黄金造物。\n你可以在后续的四个「自性觉知」事件中逐个找回失去的指令卡，找回的指令卡将直接拥有独特的「合奏」刻印。\n「合奏」刻印：使被刻印的卡牌在每回合第一次打出时生效 2 次。\n在精英战之后，你将可能遇到「清醒梦」事件，可获得高级随机刻印。\n在首领战之前，你将可能遇到「主体融合」事件，随机为 2 张卡牌赋予「合奏」刻印。",
        Story = "Resonance_47865_Story_1|洪积315年8月@2日，伯纳德医生诊所。\n一间普通的诊所，一次普通的诊疗。\n不普通的，只有里面的医生和病人。"
      })
    })
  },
  [47866] = {
    ID = 47866,
    CnID = "共鸣@「24」活动_共鸣1",
    BaseSortID = 94,
    data_list = readonly({
      readonly({
        BaseSortID = 94,
        Level = 1,
        Name = "Resonance_47866_Name_1|无意识觉醒",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroup24",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_47866_Desc_1|在「催眠蛇」事件中，在选择初始奖励时，增加一种选项：选择觉醒 2 名唤醒体，并使其灵知觉醒卡牌算力消耗降低 1。",
        Story = "Resonance_47866_Story_1|医生命她服下某种酊剂。\n1毫升下肚，世间万物皆显示于她。\n伤口流下的粘液、触手以及无数转动的眼球。\n幻象隐去，然后在她心里生根、发芽。\n真相一旦觉醒，便再也不会消失。"
      })
    })
  },
  [47863] = {
    ID = 47863,
    CnID = "共鸣@「24」活动_共鸣2",
    BaseSortID = 95,
    data_list = readonly({
      readonly({
        BaseSortID = 95,
        Level = 1,
        Name = "Resonance_47863_Name_1|自由联想",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroup24",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_47863_Desc_1|在「催眠蛇」事件中，在选择初始奖励时，增加一种选项：获得 3 个随机白银造物。",
        Story = "Resonance_47863_Story_1|她不喜欢「联想」这个词。\n它招来误会，滋生仇恨。\n它引人发疯，探寻不该涉足的禁忌领地……\n是的，她曾是最循规蹈矩的市民，现在却落入最疯狂的境地。\n事情就是这样。"
      })
    })
  },
  [47864] = {
    ID = 47864,
    CnID = "共鸣@「24」活动_共鸣3",
    BaseSortID = 96,
    data_list = readonly({
      readonly({
        BaseSortID = 96,
        Level = 1,
        Name = "Resonance_47864_Name_1|诊断：人格分裂",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroup24",
        PreResonance = {47866, 47863},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_47864_Desc_1|在「联络点」中，回复生命时可随机为 1 张卡牌赋予<EnsembleKeywords:「合奏」>刻印，并复制 1 张该卡牌的原始版本。\n解锁「边缘存储」，每小时可获得 60 「记忆拼图α」，最多储存 25 小时，在活动页左下角领取。",
        Story = "Resonance_47864_Story_1|她被宣判有病。\n或许存在一个世界，有病的人才是大多数？\n届时她一定会被授予「最正常市民」的荣誉勋章。"
      })
    })
  },
  [47869] = {
    ID = 47869,
    CnID = "共鸣@「24」活动_共鸣4",
    BaseSortID = 97,
    data_list = readonly({
      readonly({
        BaseSortID = 97,
        Level = 1,
        Name = "Resonance_47869_Name_1|静脉注射",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroup24",
        PreResonance = {47864},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_47869_Desc_1|在完成「记忆编码」挑战或重现时获得 20 点灵啡肽（癫狂难度除外）。",
        Story = "Resonance_47869_Story_1|医生热衷调配各式各样的药剂，并在她身上一一试用。\n她平静地接受了。\n这是一家免费治疗的诊所，但她明白：世上没有什么是免费的。"
      })
    })
  },
  [47870] = {
    ID = 47870,
    CnID = "共鸣@「24」活动_共鸣5",
    BaseSortID = 98,
    data_list = readonly({
      readonly({
        BaseSortID = 98,
        Level = 1,
        Name = "Resonance_47870_Name_1|认知同调",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroup24",
        PreResonance = {47864},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        ItemDropAddition = readonly({
          [10056] = 1
        }),
        ItemDropAdditionStageGroupType = {25, 39},
        Desc = "Resonance_47870_Desc_1|在完成「记忆编码」探索时获得的同调率翻倍。\n「边缘存储」每小时可额外获得 30 「记忆拼图β」。",
        Story = "Resonance_47870_Story_1|她折磨自己的灵魂，就像中世纪苦修的僧侣。\n肉体的疼痛越剧烈，便越笃信神迹。\n因为神是全知的，神是慈悲的。\n神是确信存在的。不是吗？"
      })
    })
  },
  [47867] = {
    ID = 47867,
    CnID = "共鸣@「24」活动_共鸣6",
    BaseSortID = 99,
    data_list = readonly({
      readonly({
        BaseSortID = 99,
        Level = 1,
        Name = "Resonance_47867_Name_1|诊断：人格紊乱",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_025.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_025.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_025.png",
        BelongGroup = "ResonanceGroup24",
        PreResonance = {47869, 47870},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        ItemDropAddition = readonly({
          [46606] = 0.1,
          [46607] = 0.1,
          [46608] = 0.1
        }),
        ItemDropAdditionStageGroupType = {25, 39},
        Desc = "Resonance_47867_Desc_1|在「主体融合」事件中，赋予<EnsembleKeywords:「合奏」>刻印的卡牌数量翻倍。\n使掉落的「记忆拼图」数量提高 10%。",
        Story = "Resonance_47867_Story_1|病情开始恶化，她丢掉了工作。\n现在，她将希望都寄托在医生身上。\n\n就像一尾搁浅的鱼，被抛至名为虚无的彼岸，渴望回归名为苦难的现实。"
      })
    })
  },
  [47868] = {
    ID = 47868,
    CnID = "共鸣@「24」活动_共鸣7",
    BaseSortID = 100,
    data_list = readonly({
      readonly({
        BaseSortID = 100,
        Level = 1,
        Name = "Resonance_47868_Name_1|清醒梦：圣堂之路",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_021.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_021.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_021.png",
        BelongGroup = "ResonanceGroup24",
        PreResonance = {47867},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_47868_Desc_1|在「催眠蛇」事件中，能够额外选择一份特殊奖励：额外获得随机负罪造物。\n在「清醒梦」事件中，增加一种选项：将负罪造物转化为受祝造物。",
        Story = "Resonance_47868_Story_1|她做很多很多的梦。\n梦里有血月、镜子和受难的神父。\n也有她自己。她从那些百姓脸上看到了自己。\n时代更迭，王权兴衰。\n唯有他们的苦难永恒。"
      })
    })
  },
  [47871] = {
    ID = 47871,
    CnID = "共鸣@「24」活动_共鸣8",
    BaseSortID = 101,
    data_list = readonly({
      readonly({
        BaseSortID = 101,
        Level = 1,
        Name = "Resonance_47871_Name_1|清醒梦：代行密令",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_024.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_024.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_024.png",
        BelongGroup = "ResonanceGroup24",
        PreResonance = {47867},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_47871_Desc_1|在「催眠蛇」事件中，能够额外选择一份特殊奖励：额外获得随机黄金造物+。\n在「清醒梦」事件中，增加一种选项：获得随机时灵摆。",
        Story = "Resonance_47871_Story_1|她做很多很多的梦。\n梦里有湖泊、灰烬和孤独的女王。\n唯独没有她自己。\n她变成湖泊、小苍兰，默默凝视一切。\n这一刻，她终于摆脱了名为身体的囚笼。"
      })
    })
  },
  [47872] = {
    ID = 47872,
    CnID = "共鸣@「24」活动_共鸣9",
    BaseSortID = 102,
    data_list = readonly({
      readonly({
        BaseSortID = 102,
        Level = 1,
        Name = "Resonance_47872_Name_1|诊断：人格瓦解",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroup24",
        PreResonance = {47868, 47871},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        ItemDropAddition = readonly({
          [46606] = 0.15,
          [46607] = 0.15,
          [46608] = 0.15
        }),
        ItemDropAdditionStageGroupType = {25, 39},
        State1 = {48123},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_47872_Desc_1|在「融痕」中，删除 1 张带有<EnsembleKeywords:「合奏」>刻印的卡牌会随机为 2 张卡牌赋予<EnsembleKeywords:「合奏」>刻印。\n使掉落的「记忆拼图」数量提高 15%。",
        Story = "Resonance_47872_Story_1|她看到了医生眼里的愉悦，就在他宣告病情无可救药的瞬间。\n但她选择保持沉默。当死亡无可避免，不如看看事情还能糟糕到什么程度。\n他们成了一对隐秘的共犯。"
      })
    })
  },
  [47860] = {
    ID = 47860,
    CnID = "共鸣@「24」活动_共鸣10",
    BaseSortID = 103,
    data_list = readonly({
      readonly({
        BaseSortID = 103,
        Level = 1,
        Name = "Resonance_47860_Name_1|理智链接",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_042.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_042.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_042.png",
        BelongGroup = "ResonanceGroup24",
        PreResonance = {47872},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        AwakerAttrs = readonly({keeper_energy_eff_2 = 100}),
        State1 = {48153},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_47860_Desc_1|所有唤醒体的银钥充能等级变为初始的 200%，造物上限+2。",
        Story = "Resonance_47860_Story_1|当她放下对生命的执着，生活的绘卷才在她面前徐徐展开。\n她开始期待那一个个偶然的瞬间。\n就像五彩的颜料，将她的生活一一涂抹。\n她愿意拥抱一切残缺和意外。"
      })
    })
  },
  [47861] = {
    ID = 47861,
    CnID = "共鸣@「24」活动_共鸣11",
    BaseSortID = 104,
    data_list = readonly({
      readonly({
        BaseSortID = 104,
        Level = 1,
        Name = "Resonance_47861_Name_1|电击疗法",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroup24",
        PreResonance = {47872},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        AwakerAttrs = readonly({ulti_energy_plus_3 = 100}),
        State1 = {48154},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_47861_Desc_1|所有唤醒体的狂气回充等级变为初始的 200%，造物上限+2。",
        Story = "Resonance_47861_Story_1|医生对她的变化很不满。\n「不该是这样的。\n你应该表现得更加……激烈一些。」\n他开始尝试更加激进的治疗，却毫无进展。"
      })
    })
  },
  [47862] = {
    ID = 47862,
    CnID = "共鸣@「24」活动_共鸣12",
    BaseSortID = 105,
    data_list = readonly({
      readonly({
        BaseSortID = 105,
        Level = 1,
        Name = "Resonance_47862_Name_1|诊断：已痊愈",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_046.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_046.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_046.png",
        BelongGroup = "ResonanceGroup24",
        PreResonance = {47860, 47861},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        ItemDropAddition = readonly({
          [46606] = 0.25,
          [46607] = 0.25,
          [46608] = 0.25
        }),
        ItemDropAdditionStageGroupType = {25, 39},
        Desc = "Resonance_47862_Desc_1|在「主体融合」事件中，增加一种选项：将牌库中所有的<EnsembleKeywords:「合奏」>刻印升级为<SeniorEnsembleKeywords:「高级合奏」>刻印。\n使掉落的「记忆拼图」数量提高 25%。",
        Story = "Resonance_47862_Story_1|这是她对自己的诊断：已痊愈。\n医生对此有不同的看法。让医生见鬼去吧。\n她大步离开，却不知道自己即将落入新的陷阱：\n毒蛇从不放过它的猎物。"
      })
    })
  },
  [48935] = {
    ID = 48935,
    CnID = "共鸣@章七_共鸣0",
    BaseSortID = 106,
    data_list = readonly({
      readonly({
        BaseSortID = 106,
        Level = 1,
        Name = "Resonance_48935_Name_1|浓醇的酒浆",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_047.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_047.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_047.png",
        BelongGroup = "ResonanceGroupChapter7",
        UnlockCommon = 0,
        Consume = 0,
        Desc = "Resonance_48935_Desc_1|探索起点附近，会遭遇特殊的共鸣事件——【孕育之母】，选择一张指令卡，使其获得特殊的【孕育】刻印，但也使你获得 3 张随机症状卡。【孕育】刻印：使卡牌获得保留，回合结束时若在手中，获得一张附加 保留和消耗 的 原始复制。",
        Story = "Resonance_48935_Story_1|酿造的酒浆甘甜适口，不知不觉中便催人情醉。"
      })
    })
  },
  [49117] = {
    ID = 49117,
    CnID = "共鸣@章七_共鸣A1",
    BaseSortID = 107,
    data_list = readonly({
      readonly({
        BaseSortID = 107,
        Level = 1,
        Name = "Resonance_49117_Name_1|迷幻的梦呓",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_036.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_036.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_036.png",
        BelongGroup = "ResonanceGroupChapter7",
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_49117_Desc_1|最大算力+1。",
        Story = "Resonance_49117_Story_1|无法宣之于口的情欲，在酒精的催化下化作迷幻的梦呓。"
      })
    })
  },
  [49116] = {
    ID = 49116,
    CnID = "共鸣@章七_共鸣A2",
    BaseSortID = 108,
    data_list = readonly({
      readonly({
        BaseSortID = 108,
        Level = 1,
        Name = "Resonance_49116_Name_1|深陷的温床",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_025.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_025.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_025.png",
        BelongGroup = "ResonanceGroupChapter7",
        PreResonance = {49117},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_49116_Desc_1|【孕育之母】选择的指令卡获得固有。",
        Story = "Resonance_49116_Story_1|漫布星子的天空是亚兰的席被，余热未散的流沙是亚兰的温床。"
      })
    })
  },
  [49115] = {
    ID = 49115,
    CnID = "共鸣@章七_共鸣A3",
    BaseSortID = 109,
    data_list = readonly({
      readonly({
        BaseSortID = 109,
        Level = 1,
        Name = "Resonance_49115_Name_1|喜悦的颤栗",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroupChapter7",
        PreResonance = {49116},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_49115_Desc_1|【孕育之母】选择的指令卡与其复制打出后获得 100 银钥能量。",
        Story = "Resonance_49115_Story_1|那是极乐的喷涌，是至高的欢愉。"
      })
    })
  },
  [49114] = {
    ID = 49114,
    CnID = "共鸣@章七_共鸣A4",
    BaseSortID = 110,
    data_list = readonly({
      readonly({
        BaseSortID = 110,
        Level = 1,
        Name = "Resonance_49114_Name_1|再生的渴求",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroupChapter7",
        PreResonance = {49115},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_49114_Desc_1|【孕育之母】选择的指令卡与其复制获得预备1。",
        Story = "Resonance_49114_Story_1|短暂的歇息，是为了再次登上顶峰。"
      })
    })
  },
  [49113] = {
    ID = 49113,
    CnID = "共鸣@章七_共鸣A5",
    BaseSortID = 111,
    data_list = readonly({
      readonly({
        BaseSortID = 111,
        Level = 1,
        Name = "Resonance_49113_Name_1|无涯的情欲",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_046.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_046.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_046.png",
        BelongGroup = "ResonanceGroupChapter7",
        PreResonance = {49114},
        UnlockCommon = 0,
        Consume = 5,
        Desc = "Resonance_49113_Desc_1|手牌上限+2。",
        Story = "Resonance_49113_Story_1|再一次。再一次。再一次。播撒种子，收获种子，直到天明。"
      })
    })
  },
  [49122] = {
    ID = 49122,
    CnID = "共鸣@章七_共鸣B1",
    BaseSortID = 112,
    data_list = readonly({
      readonly({
        BaseSortID = 112,
        Level = 1,
        Name = "Resonance_49122_Name_1|二重分娩",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroupChapter7",
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_49122_Desc_1|在击败精英后，额外获得 1 次造物。",
        Story = "Resonance_49122_Story_1|多胞胎常见于亚兰的分娩仪式中。"
      })
    })
  },
  [49120] = {
    ID = 49120,
    CnID = "共鸣@章七_共鸣B2",
    BaseSortID = 113,
    data_list = readonly({
      readonly({
        BaseSortID = 113,
        Level = 1,
        Name = "Resonance_49120_Name_1|银钥洗礼",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupChapter7",
        PreResonance = {49122},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_49120_Desc_1|【血污之池】可以选择以所有银钥能量为代价消除血污之池，但银钥能量为 0 时无法选择该选项。",
        Story = "Resonance_49120_Story_1|涅弗鲁瑞，我的在银钥洗礼下诞生的孩子，你必将成为亚兰族新的希望。"
      })
    })
  },
  [49121] = {
    ID = 49121,
    CnID = "共鸣@章七_共鸣B3",
    BaseSortID = 114,
    data_list = readonly({
      readonly({
        BaseSortID = 114,
        Level = 1,
        Name = "Resonance_49121_Name_1|乳汁哺育",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_044.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_044.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_044.png",
        BelongGroup = "ResonanceGroupChapter7",
        PreResonance = {49120},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_49121_Desc_1|获得 1 个随机白银造物。",
        Story = "Resonance_49121_Story_1|母树的乳汁化作圣河的源流，哺育世世代代亚兰子民。"
      })
    })
  },
  [49118] = {
    ID = 49118,
    CnID = "共鸣@章七_共鸣B4",
    BaseSortID = 115,
    data_list = readonly({
      readonly({
        BaseSortID = 115,
        Level = 1,
        Name = "Resonance_49118_Name_1|野性生长",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_045.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_045.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_045.png",
        BelongGroup = "ResonanceGroupChapter7",
        PreResonance = {49121},
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_49118_Desc_1|每消除一个【血污之池】，获得 20 黑印。",
        Story = "Resonance_49118_Story_1|沙漠的孩子不需要细致入微的关照，他们落地而生，被沙风催长。"
      })
    })
  },
  [49119] = {
    ID = 49119,
    CnID = "共鸣@章七_共鸣B5",
    BaseSortID = 116,
    data_list = readonly({
      readonly({
        BaseSortID = 116,
        Level = 1,
        Name = "Resonance_49119_Name_1|沐浴鲜血的黎明",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroupChapter7",
        PreResonance = {49118},
        UnlockCommon = 0,
        Consume = 5,
        Desc = "Resonance_49119_Desc_1|造物上限+4。",
        Story = "Resonance_49119_Story_1|在崭新的黎明时刻，新的婴孩沐血而诞。"
      })
    })
  },
  [48929] = {
    ID = 48929,
    CnID = "共鸣@章七_共鸣6",
    BaseSortID = 117,
    data_list = readonly({
      readonly({
        BaseSortID = 117,
        Level = 1,
        Name = "Resonance_48929_Name_1|丰穰之核",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_048.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_048.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_048.png",
        BelongGroup = "ResonanceGroupChapter7",
        PreResonance = {49113, 49119},
        UnlockCommon = 1,
        Consume = 9,
        Desc = "Resonance_48929_Desc_1|【孕育之母】可以选择两张指令卡进行孕育，并且不再给予症状卡。每消除一个【血污之池】使生命上限提高 5%。",
        Story = "Resonance_48929_Story_1|这是她的骨，她的血，她唯一也是最后的种子。"
      })
    })
  },
  [52103] = {
    ID = 52103,
    CnID = "共鸣@弥利亚姆活动_共鸣0",
    BaseSortID = 118,
    data_list = readonly({
      readonly({
        BaseSortID = 118,
        Level = 1,
        Name = "Resonance_52103_Name_1|天灾之下",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroupO07Activity",
        UnlockCommon = 0,
        Consume = 0,
        ResonantConversion = {10108, 5000},
        State1 = {52316},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_52103_Desc_1|探索开始时将 3 张算力消耗为 0 的增益卡加入牌库：\n「温暖的家庭」：获得 2 点算力。\n「诚挚的朋友」：虚弱和易伤所有敌人 1 回合。\n「安定的生活」：抽 2 张牌。",
        Story = "Resonance_52103_Story_1|利莫里亚的天灾盘桓千年，天灾之下人人过着朝不保夕的生活。"
      })
    })
  },
  [52114] = {
    ID = 52114,
    CnID = "共鸣@弥利亚姆活动_共鸣1",
    BaseSortID = 119,
    data_list = readonly({
      readonly({
        BaseSortID = 119,
        Level = 1,
        Name = "Resonance_52114_Name_1|祭献试炼",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroupO07Activity",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {52326},
        StateTarget1 = "PlayerRole",
        StatePara1 = {2},
        Desc = "Resonance_52114_Desc_1|牌库中每加入 1 张症状，最大生命提高 2%。\n解锁「王的谕旨」，每小时自动储存  60 「祀者之泪」，最多可存储 1500 「祀者之泪」。",
        Story = "Resonance_52114_Story_1|主祭记不清这是他第几次主持试炼了，那些有着澄澈眼神的孩子在鱼人仪式上呈现出各异的神情，有些兴奋、有些犹豫、有些苦恼、有些麻木，但弥利亚姆是不一样的。弥利亚姆的痛苦，凌驾于那些承受仪式的鱼人之上。"
      })
    })
  },
  [52113] = {
    ID = 52113,
    CnID = "共鸣@弥利亚姆活动_共鸣2",
    BaseSortID = 120,
    data_list = readonly({
      readonly({
        BaseSortID = 120,
        Level = 1,
        Name = "Resonance_52113_Name_1|安稳日常",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_023.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_023.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_023.png",
        BelongGroup = "ResonanceGroupO07Activity",
        PreResonance = {52114},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        ItemDropAddition = readonly({
          [52039] = 0.15
        }),
        ItemDropAdditionStageGroupType = {29, 41},
        Desc = "Resonance_52113_Desc_1|<DerivativeCardKeywords_59:「安定的生活」>获得保留。使掉落的「祀者之泪」数量 +15%",
        Story = "Resonance_52113_Story_1|每个风平浪静的日子，利莫里亚的人都在内心悄悄许愿这样的时间能够永恒存续。当然，弥利亚姆也不例外。"
      })
    })
  },
  [52104] = {
    ID = 52104,
    CnID = "共鸣@弥利亚姆活动_共鸣3",
    BaseSortID = 121,
    data_list = readonly({
      readonly({
        BaseSortID = 121,
        Level = 1,
        Name = "Resonance_52104_Name_1|祭司使命",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_025.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_025.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_025.png",
        BelongGroup = "ResonanceGroupO07Activity",
        PreResonance = {52113},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {52325},
        StateTarget1 = "PlayerRole",
        StatePara1 = {50},
        Desc = "Resonance_52104_Desc_1|探索开始时，获得 50 黑印。",
        Story = "Resonance_52104_Story_1|穿上这身祭司服装，握住这把闪光匕首……从今往后，你将成为利莫里亚教派的一份子，而你的使命，就是斩断过去，为祂的降临虔诚祈祷。"
      })
    })
  },
  [52111] = {
    ID = 52111,
    CnID = "共鸣@弥利亚姆活动_共鸣4",
    BaseSortID = 122,
    data_list = readonly({
      readonly({
        BaseSortID = 122,
        Level = 1,
        Name = "Resonance_52111_Name_1|由衷虔信",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_024.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_024.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_024.png",
        BelongGroup = "ResonanceGroupO07Activity",
        PreResonance = {52114},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {52324},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_52111_Desc_1|打出症状后，获得 1% 最大生命值的力量。",
        Story = "Resonance_52111_Story_1|何人对神怀抱有最虔诚的信仰？没有退路之人。"
      })
    })
  },
  [52110] = {
    ID = 52110,
    CnID = "共鸣@弥利亚姆活动_共鸣5",
    BaseSortID = 123,
    data_list = readonly({
      readonly({
        BaseSortID = 123,
        Level = 1,
        Name = "Resonance_52110_Name_1|家族羁绊",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_043.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_043.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_043.png",
        BelongGroup = "ResonanceGroupO07Activity",
        PreResonance = {52111},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        ItemDropAddition = readonly({
          [52038] = 0.15
        }),
        ItemDropAdditionStageGroupType = {29, 41},
        Desc = "Resonance_52110_Desc_1|<DerivativeCardKeywords_57:「温暖的家庭」>获得保留。\n使掉落的「祀者之血」数量+15%。",
        Story = "Resonance_52110_Story_1|弥利亚姆很小很小的时候，那时候母亲还没去世，萨拉还没降生，弥利亚姆和大着肚子的母亲坐在温暖的篝火前，等待渔猎回来的父亲。\n那个画面烙印在弥利亚姆的脑海深处，直至成为遥远的前世幻觉。"
      })
    })
  },
  [52109] = {
    ID = 52109,
    CnID = "共鸣@弥利亚姆活动_共鸣6",
    BaseSortID = 124,
    data_list = readonly({
      readonly({
        BaseSortID = 124,
        Level = 1,
        Name = "Resonance_52109_Name_1|不虞之遇",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_044.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_044.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_044.png",
        BelongGroup = "ResonanceGroupO07Activity",
        PreResonance = {52110},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {52368},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_52109_Desc_1|在击败精英后，额外获得1次 黄金造物+ 3选1。",
        Story = "Resonance_52109_Story_1|弥利亚姆跪在祷告室中央。她的鱼人父亲的嘴一张一合。她勉力去记住他膨胀的眼球，鳃腺的弧度，鳞片的层次……为了重逢之日。"
      })
    })
  },
  [52108] = {
    ID = 52108,
    CnID = "共鸣@弥利亚姆活动_共鸣7",
    BaseSortID = 125,
    data_list = readonly({
      readonly({
        BaseSortID = 125,
        Level = 1,
        Name = "Resonance_52108_Name_1|变生疯狂",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_036.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_036.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_036.png",
        BelongGroup = "ResonanceGroupO07Activity",
        PreResonance = {52111},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_52108_Desc_1|在「联络点」增加「堕入疯狂」选项：随机觉醒 2 名唤醒体，获得 1 张随机症状卡。",
        Story = "Resonance_52108_Story_1|人类与疯狂不期而遇。触发的契机是对权力和欲望的贪婪渴望，以及一枚小小的银色金属。"
      })
    })
  },
  [52112] = {
    ID = 52112,
    CnID = "共鸣@弥利亚姆活动_共鸣8",
    BaseSortID = 126,
    data_list = readonly({
      readonly({
        BaseSortID = 126,
        Level = 1,
        Name = "Resonance_52112_Name_1|无瑕信赖",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroupO07Activity",
        PreResonance = {52108},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        ItemDropAddition = readonly({
          [52037] = 0.15
        }),
        ItemDropAdditionStageGroupType = {29, 41},
        Desc = "Resonance_52112_Desc_1|<DerivativeCardKeywords_58:「诚挚的朋友」>获得保留。\n使掉落的「祀者之髓」数量+15%。",
        Story = "Resonance_52112_Story_1|黛博拉，黛博拉。明明是你告诉我，那些选择了利莫里亚的人是更勇敢的人。明明是你告诉我，我们会一起成为王的祭司，将神国带到利莫里亚。\n黛博拉，为什么你要推阻，为什么你要抗拒呢？你的孩子……将成为神国新的希望啊。"
      })
    })
  },
  [52102] = {
    ID = 52102,
    CnID = "共鸣@弥利亚姆活动_共鸣9",
    BaseSortID = 127,
    data_list = readonly({
      readonly({
        BaseSortID = 127,
        Level = 1,
        Name = "Resonance_52102_Name_1|逾常祭品",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroupO07Activity",
        PreResonance = {52112},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_52102_Desc_1|在「迎接吧，神国」生效后，增加「献上额外祭品」的选项：额外删除 1 张指令卡，将 3 种「神国幻影」各 1 张加入牌库。",
        Story = "Resonance_52102_Story_1|索求更多，就要献上更多。这并非交易，而是世间的公理。"
      })
    })
  },
  [52107] = {
    ID = 52107,
    CnID = "共鸣@弥利亚姆活动_共鸣10",
    BaseSortID = 128,
    data_list = readonly({
      readonly({
        BaseSortID = 128,
        Level = 1,
        Name = "Resonance_52107_Name_1|剖腹而诞",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroupO07Activity",
        PreResonance = {52108},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_52107_Desc_1|在「天灾」中「牺牲珍视之物」选项变为「献祭珍视之物」：可选择失去的增益卡，失去时，随机 1 张「神国幻影」加入牌库。",
        Story = "Resonance_52107_Story_1|神的孩子必须在正确的时间降生，这是不容辩驳之事。\n至于胎儿的母亲，「她早已做好了为神国奉献的准备」。"
      })
    })
  },
  [52106] = {
    ID = 52106,
    CnID = "共鸣@弥利亚姆活动_共鸣11",
    BaseSortID = 129,
    data_list = readonly({
      readonly({
        BaseSortID = 129,
        Level = 1,
        Name = "Resonance_52106_Name_1|不灭执念",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_049.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_049.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_049.png",
        BelongGroup = "ResonanceGroupO07Activity",
        PreResonance = {52107},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_52106_Desc_1|在「天灾」中「献祭珍视之物」选项获得的「神国幻影」不再消耗。",
        Story = "Resonance_52106_Story_1|在一个风平浪静的夜晚，弥利亚姆路过戈利亚烛火摇曳的房门外。\n「那个女人已经疯了。」她听见戈利亚这么说。但弥利亚姆心里很清楚，自己没有疯，只是不被凡庸理解的人，终究变成了自己。"
      })
    })
  },
  [52105] = {
    ID = 52105,
    CnID = "共鸣@弥利亚姆活动_共鸣12",
    BaseSortID = 130,
    data_list = readonly({
      readonly({
        BaseSortID = 130,
        Level = 1,
        Name = "Resonance_52105_Name_1|神国必将再临",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_050.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_050.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_050.png",
        BelongGroup = "ResonanceGroupO07Activity",
        PreResonance = {52106},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        ItemDropAddition = readonly({
          [52037] = 0.35,
          [52038] = 0.35,
          [52039] = 0.35
        }),
        ItemDropAdditionStageGroupType = {29, 41},
        State1 = {52371},
        StateTarget1 = "PlayerRole",
        Desc = "Resonance_52105_Desc_1|首领战中，打出第 10 张症状后，获得图鲁的支援卡<DerivativeCardKeywords_60:「王权」>。\n「王权」：造成大量伤害，并昏迷目标 1 回合。\n使掉落的「祀者之泪」、「祀者之血」、「祀者之髓」数量 +35%。",
        Story = "Resonance_52105_Story_1|神国终将降临。神国必会降临。神国必须降临。弥利亚姆始终坚定地相信着。\n除此之外，她已没有什么可相信的了。"
      })
    })
  },
  [55543] = {
    ID = 55543,
    CnID = "共鸣@奥尔拉活动_共鸣0",
    BaseSortID = 131,
    data_list = readonly({
      readonly({
        BaseSortID = 131,
        Level = 1,
        Name = "Resonance_55543_Name_1|诗的萌芽",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_048.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_048.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_048.png",
        BelongGroup = "ResonanceGroupHorla",
        UnlockCommon = 0,
        Consume = 0,
        ResonantConversion = {10108, 5000},
        State1 = {55871},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_55543_Desc_1|探索开始时获得初始造物「奥尔拉的笔与墨」：打出「意象」或「献诗」后，抽 1 张牌。战斗结束后获得 1 层「笔墨」，「笔墨」达到 2 层后消耗，随机将 1 张「意象」置入牌库。\n可在特殊的共鸣事件【春天的赠礼】中选择「创作献诗」：选择 3 张「意象」卡，让奥尔拉为你创作「献诗」。",
        Story = "Resonance_55543_Story_1|“以后，这里就是我们的家了！”\n第一次，两位女孩有了她们的栖身之所。\n在这简陋的花园里，玫瑰与诗都正悄然萌芽。"
      })
    })
  },
  [55544] = {
    ID = 55544,
    CnID = "共鸣@奥尔拉活动_共鸣1",
    BaseSortID = 132,
    data_list = readonly({
      readonly({
        BaseSortID = 132,
        Level = 1,
        Name = "Resonance_55544_Name_1|万物生长",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroupHorla",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_55544_Desc_1|解锁「缪斯之吻」，每小时自动储存  60 「惆怅的诗文」，最多可存储 1500 「惆怅的诗文」。",
        Story = "Resonance_55544_Story_1|星星，土地，雀鸟……她无法离开花园，但花园对她来说已足够宽广。\n花园中的一切，都是诗句。"
      })
    })
  },
  [55545] = {
    ID = 55545,
    CnID = "共鸣@奥尔拉活动_共鸣2",
    BaseSortID = 133,
    data_list = readonly({
      readonly({
        BaseSortID = 133,
        Level = 1,
        Name = "Resonance_55545_Name_1|意味隽永",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_024.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_024.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_024.png",
        BelongGroup = "ResonanceGroupHorla",
        PreResonance = {55544},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {56022},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_55545_Desc_1|所有「意象」获得保留，在探索开始时，选择获得 1 张「意象」。",
        Story = "Resonance_55545_Story_1|伟大的诗句就像人与人之间的感情一样，应当是隽永的。\n她看着一株枯萎的金合欢，这样想到。"
      })
    })
  },
  [55546] = {
    ID = 55546,
    CnID = "共鸣@奥尔拉活动_共鸣3",
    BaseSortID = 134,
    data_list = readonly({
      readonly({
        BaseSortID = 134,
        Level = 1,
        Name = "Resonance_55546_Name_1|盛放于荆棘",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_033.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_033.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_033.png",
        BelongGroup = "ResonanceGroupHorla",
        PreResonance = {55545},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_55546_Desc_1|在「缪斯的眷顾」选择「斩断荆棘」后，可选择「靠近光点」：提高下一场战斗难度，将 1 张「意象」升级至高级「意象」。",
        Story = "Resonance_55546_Story_1|“最美的花朵，都盛开在荆棘里。我知道该怎么处理那些荆棘，这些花朵，就让我来带给你吧。”"
      })
    })
  },
  [55547] = {
    ID = 55547,
    CnID = "共鸣@奥尔拉活动_共鸣4",
    BaseSortID = 135,
    data_list = readonly({
      readonly({
        BaseSortID = 135,
        Level = 1,
        Name = "Resonance_55547_Name_1|奇思妙想",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupHorla",
        PreResonance = {55545},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {56028},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_55547_Desc_1|「奥尔拉的笔与墨」获得「意象」时改为 3 选 1 获得。",
        Story = "Resonance_55547_Story_1|为什么蝴蝶不能陪人说话？为什么院子外的有轨电车不是一只毛毛虫？\n柯蕾特不在的时候，她总是自己在花房里胡思乱想。"
      })
    })
  },
  [55548] = {
    ID = 55548,
    CnID = "共鸣@奥尔拉活动_共鸣5",
    BaseSortID = 136,
    data_list = readonly({
      readonly({
        BaseSortID = 136,
        Level = 1,
        Name = "Resonance_55548_Name_1|疼痛与歌",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroupHorla",
        PreResonance = {55547},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_55548_Desc_1|在「缪斯的眷顾」选择「拨开荆棘」后，可选择「靠近光点」：降低 10% 生命上限，可选择升级 1 张「意象」。",
        Story = "Resonance_55548_Story_1|柯蕾特的手指被割出了许多口子，那双手粗糙得完全不像是属于少女。\n鲜血滴落在奥尔拉的诗句上。她需要为她做些什么。"
      })
    })
  },
  [55549] = {
    ID = 55549,
    CnID = "共鸣@奥尔拉活动_共鸣6",
    BaseSortID = 137,
    data_list = readonly({
      readonly({
        BaseSortID = 137,
        Level = 1,
        Name = "Resonance_55549_Name_1|惊世之作",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroupHorla",
        PreResonance = {55547},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_55549_Desc_1|在「联络点」选择休息后，可选择「创作献诗」：所有唤醒体失去狂气，合成为一张「献诗」卡牌，拥有三张「意象卡」所有效果。",
        Story = "Resonance_55549_Story_1|那一天，整个上流社会都在议论这首新诗。它惊奇的想象和强烈的情绪感染力，让整个西岱的呼吸为之凝滞。\n这座城市迎来了一位天才诗人。"
      })
    })
  },
  [55550] = {
    ID = 55550,
    CnID = "共鸣@奥尔拉活动_共鸣7",
    BaseSortID = 138,
    data_list = readonly({
      readonly({
        BaseSortID = 138,
        Level = 1,
        Name = "Resonance_55550_Name_1|以诗换花",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_040.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_040.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_040.png",
        BelongGroup = "ResonanceGroupHorla",
        PreResonance = {55549},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_55550_Desc_1|「缪斯之吻」每小时可额外获得 60 「遗憾的诗文」。",
        Story = "Resonance_55550_Story_1|天才诗人所创作的新诗，换来了半年的食物。生活不再是一件困难的事，少女的手也不再粗糙。\n您是怎样创作出这样美丽的诗歌的呢？人们问道。\n我的灵感藏在花房里。柯蕾特这样回答。"
      })
    })
  },
  [55541] = {
    ID = 55541,
    CnID = "共鸣@奥尔拉活动_共鸣8",
    BaseSortID = 139,
    data_list = readonly({
      readonly({
        BaseSortID = 139,
        Level = 1,
        Name = "Resonance_55541_Name_1|不蔓不支",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_024.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_024.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_024.png",
        BelongGroup = "ResonanceGroupHorla",
        PreResonance = {55549},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {56145},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_55541_Desc_1|「奥尔拉的笔与墨」在战斗后额外获得 1 层「笔墨」。",
        Story = "Resonance_55541_Story_1|诗歌与花一样，需要精炼的语言，才能创作出好的诗歌来。\n创作出更优秀的诗歌，才能帮柯蕾特分担得更多。"
      })
    })
  },
  [55542] = {
    ID = 55542,
    CnID = "共鸣@奥尔拉活动_共鸣9",
    BaseSortID = 140,
    data_list = readonly({
      readonly({
        BaseSortID = 140,
        Level = 1,
        Name = "Resonance_55542_Name_1|花园的集册",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_046.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_046.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_046.png",
        BelongGroup = "ResonanceGroupHorla",
        PreResonance = {55550},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_55542_Desc_1|「奥尔拉的笔与墨」使手牌上限 +2，回合开始时，抽 1 张牌。",
        Story = "Resonance_55542_Story_1|她用一根别针把那些散乱的诗笺扎了起来，在上面放上了一片玫瑰花瓣。\n这本将震惊西岱的诗集，是她送给柯蕾特的礼物。"
      })
    })
  },
  [55539] = {
    ID = 55539,
    CnID = "共鸣@奥尔拉活动_共鸣10",
    BaseSortID = 141,
    data_list = readonly({
      readonly({
        BaseSortID = 141,
        Level = 1,
        Name = "Resonance_55539_Name_1|燃烧的诗稿",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_023.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_023.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_023.png",
        BelongGroup = "ResonanceGroupHorla",
        PreResonance = {55541},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {56229},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_55539_Desc_1|在「联络点」选择觉醒后，可选择删除 1 张「意象」卡，随机将 1 张「意象」升级为「高级意象」。",
        Story = "Resonance_55539_Story_1|崇拜者们的问题让她仓促离开了。她无法回答那些关于诗歌的问题，她无法看懂奥尔拉写的那些诗。她也不明白，凭什么一个什么都没有牺牲的人，就能轻易得到所有的赞意。\n她烧掉了自己写的废稿，看着火焰，她明白了一切：\n诗歌与花，都不属于她。她的一生，只与火焰有关。"
      })
    })
  },
  [55540] = {
    ID = 55540,
    CnID = "共鸣@奥尔拉活动_共鸣11",
    BaseSortID = 142,
    data_list = readonly({
      readonly({
        BaseSortID = 142,
        Level = 1,
        Name = "Resonance_55540_Name_1|玫瑰啊，玫瑰",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_051.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_051.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_051.png",
        BelongGroup = "ResonanceGroupHorla",
        PreResonance = {55542, 55539},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {56176},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_55540_Desc_1|「缪斯的眷顾」选择「离开荆棘」时，额外获得 1 层「笔墨」；「斩断荆棘」和「拨开荆棘」额外获得 1 张相同的「意象」卡。",
        Story = "Resonance_55540_Story_1|花园在燃烧。诗稿在燃烧。玫瑰在燃烧。她用尽全力呼唤柯蕾特的名字，回应她的只有火焰的呼啸。\n柯蕾特现在应该还在外面，这场大火伤不到她。只是，当她回来看到这一切，应该会很难过吧？\n无数的情绪与灵感闯入她的脑海。玫瑰的余烬漫天飞舞，如同一场大雨。\n这场雨，是春天对花园的告别。"
      })
    })
  },
  [55538] = {
    ID = 55538,
    CnID = "共鸣@奥尔拉活动_共鸣12",
    BaseSortID = 143,
    data_list = readonly({
      readonly({
        BaseSortID = 143,
        Level = 1,
        Name = "Resonance_55538_Name_1|最后的诗篇",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_041.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_041.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_041.png",
        BelongGroup = "ResonanceGroupHorla",
        PreResonance = {55540},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_55538_Desc_1|「春天的赠礼」中选择「创作献诗」后，可额外再选择 1 次「创作献诗」。",
        Story = "Resonance_55538_Story_1|她搜遍了整座花园。一切都已化为灰烬，没有留下任何证据。\n只在花房的泥土下，她看到一张残存的纸条：\n“……《春天对花园的告别》。致柯蕾特。奥尔拉，于火中。”"
      })
    })
  },
  [59207] = {
    ID = 59207,
    CnID = "共鸣@章八_共鸣0",
    BaseSortID = 144,
    data_list = readonly({
      readonly({
        BaseSortID = 144,
        Level = 1,
        Name = "Resonance_59207_Name_1|开学典礼",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_041.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_041.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_041.png",
        BelongGroup = "ResonanceGroupChapter8",
        UnlockCommon = 0,
        Consume = 0,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_59207_Desc_1|探索起点附近，会遭遇特殊的共鸣事件——【入学仪式】，将【极夜微光】加入牌库。\n【极夜微光】：从抽牌堆或弃牌堆中选择 1 张指令卡置入手中，并使其算力消耗变为 0。保留。消耗",
        Story = "Resonance_59207_Story_1|这是故事伊始的光。\n在这里，你们被授予一个称号，一个身份，一张证明，成为彼此的同行者。\n每个弥萨格学生的征程都从这里开始，但并非每个人的都会在这里结束。"
      })
    })
  },
  [59206] = {
    ID = 59206,
    CnID = "共鸣@章八_共鸣1",
    BaseSortID = 145,
    data_list = readonly({
      readonly({
        BaseSortID = 145,
        Level = 1,
        Name = "Resonance_59206_Name_1|守密人通识",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_023.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_023.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_023.png",
        BelongGroup = "ResonanceGroupChapter8",
        UnlockCommon = 0,
        Consume = 3,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_59206_Desc_1|「极夜微光」使指令卡对应唤醒体获得 50 点狂气。",
        Story = "Resonance_59206_Story_1|这堂课由诃勒特担任主讲。\n她的讲义只环绕着两个主题，「为了人类」和「活下去」。"
      })
    })
  },
  [59194] = {
    ID = 59194,
    CnID = "共鸣@章八_共鸣2",
    BaseSortID = 146,
    data_list = readonly({
      readonly({
        BaseSortID = 146,
        Level = 1,
        Name = "Resonance_59194_Name_1|造物鉴赏",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroupChapter8",
        PreResonance = {59206},
        UnlockCommon = 0,
        Consume = 3,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_59194_Desc_1|手牌上限和造物上限+2。",
        Story = "Resonance_59194_Story_1|这堂课由德克斯特勋爵担任主讲。\n那些来自德克斯特家族的价值连城的藏品被他随意地搁置在教室的书架和桌椅上。"
      })
    })
  },
  [59195] = {
    ID = 59195,
    CnID = "共鸣@章八_共鸣3",
    BaseSortID = 147,
    data_list = readonly({
      readonly({
        BaseSortID = 147,
        Level = 1,
        Name = "Resonance_59195_Name_1|外科护理",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroupChapter8",
        PreResonance = {59194},
        UnlockCommon = 0,
        Consume = 3,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_59195_Desc_1|「极夜微光」回复 10% 已损失生命。",
        Story = "Resonance_59195_Story_1|这堂课由艾尔瓦担任主讲。\n没有人质疑她的权威，不是因为她那终日严肃的面容，而是因为她的那双腿——精密得令人望而生畏的机械义肢。"
      })
    })
  },
  [59201] = {
    ID = 59201,
    CnID = "共鸣@章八_共鸣4",
    BaseSortID = 148,
    data_list = readonly({
      readonly({
        BaseSortID = 148,
        Level = 1,
        Name = "Resonance_59201_Name_1|战备准则",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_021.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_021.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_021.png",
        BelongGroup = "ResonanceGroupChapter8",
        PreResonance = {59194},
        UnlockCommon = 0,
        Consume = 3,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_59201_Desc_1|极夜微光获得固有。",
        Story = "Resonance_59201_Story_1|这堂课由威廉担任主讲。\n有备而无患是他的法则，他习惯筹谋万全再踏上战场，但在这个融蚀遍布的世界里，任何人都不可能算无遗策。"
      })
    })
  },
  [59200] = {
    ID = 59200,
    CnID = "共鸣@章八_共鸣5",
    BaseSortID = 149,
    data_list = readonly({
      readonly({
        BaseSortID = 149,
        Level = 1,
        Name = "Resonance_59200_Name_1|高压作战",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroupChapter8",
        PreResonance = {59194},
        UnlockCommon = 0,
        Consume = 5,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_59200_Desc_1|首领战开始时，将额外 1 张「极夜微光」置入弃牌堆。",
        Story = "Resonance_59200_Story_1|这堂课由萝坦担任主讲。\n说是主讲，她只是凭借自己双剑的威力让所有学生领略何谓「高压」罢了。"
      })
    })
  },
  [59199] = {
    ID = 59199,
    CnID = "共鸣@章八_共鸣6",
    BaseSortID = 150,
    data_list = readonly({
      readonly({
        BaseSortID = 150,
        Level = 1,
        Name = "Resonance_59199_Name_1|潜行战术",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_024.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_024.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_024.png",
        BelongGroup = "ResonanceGroupChapter8",
        PreResonance = {59200},
        UnlockCommon = 0,
        Consume = 3,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_59199_Desc_1|可以伏击守卫，消耗所有唤醒体狂气，获得 30 黑印并移除守卫威胁。",
        Story = "Resonance_59199_Story_1|这堂课由茜尔维娅担任主讲。\n希望每个学生都能如她一般在校园中神出鬼没，随时为你递上一杯热腾腾的红茶——天知道她是怎么带着锡制茶壶四处瞬移的。"
      })
    })
  },
  [59198] = {
    ID = 59198,
    CnID = "共鸣@章八_共鸣7",
    BaseSortID = 151,
    data_list = readonly({
      readonly({
        BaseSortID = 151,
        Level = 1,
        Name = "Resonance_59198_Name_1|泛融蚀理论",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroupChapter8",
        PreResonance = {59200},
        UnlockCommon = 0,
        Consume = 3,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_59198_Desc_1|被守卫警觉时，可以选择不获得症状，而是失去 20% 最大生命。",
        Story = "Resonance_59198_Story_1|这堂课由阿利斯泰尔担任主讲。\n所有人都知道阿利斯泰尔来主持这门课程颇有些大材小用，但没有谁比他和融蚀的接触更密切。那沉浸于黑池之底激荡的银芯，正源源不绝地和每一枚银钥匙共振。"
      })
    })
  },
  [59197] = {
    ID = 59197,
    CnID = "共鸣@章八_共鸣8",
    BaseSortID = 152,
    data_list = readonly({
      readonly({
        BaseSortID = 152,
        Level = 1,
        Name = "Resonance_59197_Name_1|外域医学",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_046.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_046.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_046.png",
        BelongGroup = "ResonanceGroupChapter8",
        PreResonance = {59200},
        UnlockCommon = 0,
        Consume = 3,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_59197_Desc_1|死亡抵抗+200%。",
        Story = "Resonance_59197_Story_1|这堂课由朵尔担任主讲。\n人类的躯体脆不堪言，来自外域的医学仅能聊为修补一二。"
      })
    })
  },
  [59196] = {
    ID = 59196,
    CnID = "共鸣@章八_共鸣9",
    BaseSortID = 153,
    data_list = readonly({
      readonly({
        BaseSortID = 153,
        Level = 1,
        Name = "Resonance_59196_Name_1|钥冢仪式",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_043.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_043.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_043.png",
        BelongGroup = "ResonanceGroupChapter8",
        PreResonance = {59197},
        UnlockCommon = 0,
        Consume = 5,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_59196_Desc_1|每次触发死亡抵抗，将 1 张「极夜微光」置入手中，每场战斗最多触发 3 次。",
        Story = "Resonance_59196_Story_1|这是预科结束的标志。\n你们将在这片墓冢中刻下自己的姓名，与三百年的历史一同沉淀。"
      })
    })
  },
  [59205] = {
    ID = 59205,
    CnID = "共鸣@章八_共鸣10",
    BaseSortID = 154,
    data_list = readonly({
      readonly({
        BaseSortID = 154,
        Level = 1,
        Name = "Resonance_59205_Name_1|繁育之理",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_048.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_048.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_048.png",
        BelongGroup = "ResonanceGroupChapter8",
        UnlockCommon = 0,
        Consume = 0,
        ConsumeType = 60163,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_59205_Desc_1|在共鸣点处，额外选择一张卡牌获得「繁育之理」刻印。「繁育之理」：打出后获得 3 张附加「保留」和「消耗」的原始复制，每场战斗仅生效 1 次。",
        Story = "Resonance_59205_Story_1|源自欲之质体的力量。\n生命不会擅长复制它自己，欲望驱动生命的本质流转。"
      })
    })
  },
  [59204] = {
    ID = 59204,
    CnID = "共鸣@章八_共鸣11",
    BaseSortID = 155,
    data_list = readonly({
      readonly({
        BaseSortID = 155,
        Level = 1,
        Name = "Resonance_59204_Name_1|欢愉之理",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_044.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_044.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_044.png",
        BelongGroup = "ResonanceGroupChapter8",
        PreResonance = {59205},
        UnlockCommon = 0,
        Consume = 0,
        ConsumeType = 60165,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_59204_Desc_1|在共鸣点处，额外选择一张卡牌获得「欢愉之理」刻印。「欢愉之理」：打出后弃掉所有该唤醒体以外的卡牌，获得 5 张随机非唤醒体卡牌，每场战斗仅生效 1 次。",
        Story = "Resonance_59204_Story_1|源自悦之质体的力量。\n生命有别于机械，永恒的重复与苦难终会磨灭生存的激情。所以我们需要欢愉，我们追逐欢愉，我们沉溺欢愉。"
      })
    })
  },
  [59203] = {
    ID = 59203,
    CnID = "共鸣@章八_共鸣12",
    BaseSortID = 156,
    data_list = readonly({
      readonly({
        BaseSortID = 156,
        Level = 1,
        Name = "Resonance_59203_Name_1|智识之理",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroupChapter8",
        PreResonance = {59204},
        UnlockCommon = 0,
        Consume = 0,
        ConsumeType = 60164,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_59203_Desc_1|在共鸣点处，额外选择一张卡牌获得「智识之理」刻印。「智识之理」：打出后抽 2 张牌，它们算力消耗降低刻印卡牌实际消耗算力，每场战斗仅生效 1 次。",
        Story = "Resonance_59203_Story_1|源自智之质体的力量。\n智慧唤醒空茫麻木的躯壳，让他们不止步于重复，不溺于混乱，如启明星般指引他们在长夜里孜孜前行。"
      })
    })
  },
  [59202] = {
    ID = 59202,
    CnID = "共鸣@章八_共鸣13",
    BaseSortID = 157,
    data_list = readonly({
      readonly({
        BaseSortID = 157,
        Level = 1,
        Name = "Resonance_59202_Name_1|无上意志",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroupChapter8",
        PreResonance = {
          59205,
          59204,
          59203
        },
        UnlockCommon = 1,
        Consume = 9,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_59202_Desc_1|释放极夜微光后，选择一张获得过三大质体刻印的卡牌置入手中。",
        Story = "Resonance_59202_Story_1|倒悬的无目之瞳睁开空洞的眼睛，在无意识中用祂的意志重塑整个卡达斯。\n卡达斯本就是你的梦境。"
      })
    })
  },
  [62160] = {
    ID = 62160,
    CnID = "共鸣@本源希洛活动_共鸣0",
    BaseSortID = 158,
    data_list = readonly({
      readonly({
        BaseSortID = 158,
        Level = 1,
        Name = "Resonance_62160_Name_1|饥饿追猎",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroupOriginHelot",
        UnlockCommon = 0,
        Consume = 0,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_62160_Desc_1|获得初始造物「科考团」：初始拥有 30 科考团人数。战斗开始时，将 5 张「猜疑」置入牌库中。「猜疑」：打出后将选择消耗不同的科考团人数，获得不同效果。\n在探索的过程中，将不断地面临「猜疑」的抉择，科考团人员的损失，触发联络处有机会获得救援，最后安全撤离时根据剩余科考团人数获得「救难勋章」，撤离人数越多「救难勋章」越强大。",
        Story = "Resonance_62160_Story_1|黑暗中的山影如同择人而噬的巨口，你们被困在了雪山的胃袋中。"
      })
    })
  },
  [62161] = {
    ID = 62161,
    CnID = "共鸣@本源希洛活动_共鸣1",
    BaseSortID = 159,
    data_list = readonly({
      readonly({
        BaseSortID = 159,
        Level = 1,
        Name = "Resonance_62161_Name_1|步步为营",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_042.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_042.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_042.png",
        BelongGroup = "ResonanceGroupOriginHelot",
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_62161_Desc_1|联络点将出现第二次选择「支援」，可以根据科考团人数获得奖励或寻找失散团员。",
        Story = "Resonance_62161_Story_1|在死亡的账单上精打细算吧，小心负债累累。"
      })
    })
  },
  [62158] = {
    ID = 62158,
    CnID = "共鸣@本源希洛活动_共鸣2",
    BaseSortID = 160,
    data_list = readonly({
      readonly({
        BaseSortID = 160,
        Level = 1,
        Name = "Resonance_62158_Name_1|野兽项圈",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_036.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_036.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_036.png",
        BelongGroup = "ResonanceGroupOriginHelot",
        PreResonance = {62161},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_62158_Desc_1|「猜疑」新增选项：【全力配合】抽 2 张牌，获得 2 算力。清空所有唤醒体狂气，失去 15% 最大生命。\n你选择约束希洛，并使用唤醒体的力量全力保护团员。",
        Story = "Resonance_62158_Story_1|野兽的忠诚是一项无法证实的命题，只要那獠牙高悬一日，人们便一日不得安宁。"
      })
    })
  },
  [62159] = {
    ID = 62159,
    CnID = "共鸣@本源希洛活动_共鸣3",
    BaseSortID = 161,
    data_list = readonly({
      readonly({
        BaseSortID = 161,
        Level = 1,
        Name = "Resonance_62159_Name_1|疑心暗鬼",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroupOriginHelot",
        PreResonance = {62161},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_62159_Desc_1|「猜疑」保留时敌人获得的力量降低 33%。",
        Story = "Resonance_62159_Story_1|重重疑团笼罩着紧绷的神经，怀疑的眼能看到虚幻的幽灵。"
      })
    })
  },
  [62156] = {
    ID = 62156,
    CnID = "共鸣@本源希洛活动_共鸣4",
    BaseSortID = 162,
    data_list = readonly({
      readonly({
        BaseSortID = 162,
        Level = 1,
        Name = "Resonance_62156_Name_1|危机备案",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroupOriginHelot",
        PreResonance = {62158},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {65572},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_62156_Desc_1|若科考团人数小于等于 5，战斗开始时所有唤醒体获得 30 点狂气和 15% 暴击率。",
        Story = "Resonance_62156_Story_1|你翻开调查员危机应对手册，写下第26条突发情况备案。"
      })
    })
  },
  [62157] = {
    ID = 62157,
    CnID = "共鸣@本源希洛活动_共鸣5",
    BaseSortID = 163,
    data_list = readonly({
      readonly({
        BaseSortID = 163,
        Level = 1,
        Name = "Resonance_62157_Name_1|团结绳索",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_038.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_038.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_038.png",
        BelongGroup = "ResonanceGroupOriginHelot",
        PreResonance = {62159},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {65464},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_62157_Desc_1|手牌上限和造物上限+2。",
        Story = "Resonance_62157_Story_1|将绳索绑在腰上吧，所有人的生命紧紧相连，如同羊群紧紧相依。"
      })
    })
  },
  [62154] = {
    ID = 62154,
    CnID = "共鸣@本源希洛活动_共鸣6",
    BaseSortID = 164,
    data_list = readonly({
      readonly({
        BaseSortID = 164,
        Level = 1,
        Name = "Resonance_62154_Name_1|最大利益",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroupOriginHelot",
        PreResonance = {62156},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_62154_Desc_1|联络点处支援增加选项：失去 10 名科考团员，选择获得一个黄金+造物。",
        Story = "Resonance_62154_Story_1|牺牲一些，保护更多。\n你会如何配比生命的天平？"
      })
    })
  },
  [62155] = {
    ID = 62155,
    CnID = "共鸣@本源希洛活动_共鸣7",
    BaseSortID = 165,
    data_list = readonly({
      readonly({
        BaseSortID = 165,
        Level = 1,
        Name = "Resonance_62155_Name_1|希望之光",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_023.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_023.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_023.png",
        BelongGroup = "ResonanceGroupOriginHelot",
        PreResonance = {62157},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        Desc = "Resonance_62155_Desc_1|灯塔增加效果：补充 3 名科考团员。",
        Story = "Resonance_62155_Story_1|黑夜中有安全的灯火远远闪烁，人们化为趋光的飞蛾。"
      })
    })
  },
  [62152] = {
    ID = 62152,
    CnID = "共鸣@本源希洛活动_共鸣8",
    BaseSortID = 166,
    data_list = readonly({
      readonly({
        BaseSortID = 166,
        Level = 1,
        Name = "Resonance_62152_Name_1|缜密心思",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_041.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_041.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_041.png",
        BelongGroup = "ResonanceGroupOriginHelot",
        PreResonance = {62154},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {65467},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_62152_Desc_1|精英战结束后若科考团成员大于 20 名，额外选择 1 次造物奖励，否则补充 5 名团员。",
        Story = "Resonance_62152_Story_1|越是怀疑，越是清醒。\n你的双眼已看破一切。"
      })
    })
  },
  [62153] = {
    ID = 62153,
    CnID = "共鸣@本源希洛活动_共鸣9",
    BaseSortID = 167,
    data_list = readonly({
      readonly({
        BaseSortID = 167,
        Level = 1,
        Name = "Resonance_62153_Name_1|共存决心",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_043.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_043.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_043.png",
        BelongGroup = "ResonanceGroupOriginHelot",
        PreResonance = {62155},
        UnlockCommon = 0,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {65466},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_62153_Desc_1|科考团初始人数+5。",
        Story = "Resonance_62153_Story_1|一双双手交叠在一起，共同合成脆弱的决心。"
      })
    })
  },
  [62162] = {
    ID = 62162,
    CnID = "共鸣@本源希洛活动_共鸣10",
    BaseSortID = 168,
    data_list = readonly({
      readonly({
        BaseSortID = 168,
        Level = 1,
        Name = "Resonance_62162_Name_1|绝境真心",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_046.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_046.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_046.png",
        BelongGroup = "ResonanceGroupOriginHelot",
        PreResonance = {62152, 62153},
        UnlockCommon = 1,
        Consume = 1,
        ResonantConversion = {10108, 5000},
        State1 = {65465},
        StateTarget1 = "PlayerRole",
        StatePara1 = {1},
        Desc = "Resonance_62162_Desc_1|「救难勋章」每回合额外获得 1 张「人性光辉」，「独行者之徽」获得的力量翻倍。",
        Story = "Resonance_62162_Story_1|在死亡面前，生命的本真重新苏醒。\n一切过往消散，灰色的心灵也变得真诚。"
      })
    })
  },
  [67082] = {
    ID = 67082,
    CnID = "共鸣@章九_共鸣0",
    BaseSortID = 169,
    data_list = readonly({
      readonly({
        BaseSortID = 169,
        Level = 1,
        Name = "Resonance_67082_Name_1|纯银的初心",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroupChapter9",
        UnlockCommon = 0,
        Consume = 0,
        State1 = {
          59523,
          59558,
          59517
        },
        Desc = "Resonance_67082_Desc_1|探索起点附近，会遭遇特殊的共鸣事件——【入学仪式】，将【极夜微光】加入牌库。\n会继承第八章的所有共鸣效果。",
        Story = "Resonance_67082_Story_1|终末的灾难降临了。\n你睁开眼，前方是无可阻挡的深渊。\n你低下头。陪伴在你身边的，是你从未忘却的初心。"
      })
    })
  },
  [67081] = {
    ID = 67081,
    CnID = "共鸣@章九_共鸣1",
    BaseSortID = 170,
    data_list = readonly({
      readonly({
        BaseSortID = 170,
        Level = 1,
        Name = "Resonance_67081_Name_1|终结与伊始",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_041.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_041.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_041.png",
        BelongGroup = "ResonanceGroupChapter9",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_67081_Desc_1|「智识之理」额外抽 2 张牌。",
        Story = "Resonance_67081_Story_1|你彻底明悟了智识之理。\n终结与伊始，是造物主的吐息，是这宇宙的至高法则。\n但不会是今天，不会是在你面前。"
      })
    })
  },
  [67084] = {
    ID = 67084,
    CnID = "共鸣@章九_共鸣2",
    BaseSortID = 171,
    data_list = readonly({
      readonly({
        BaseSortID = 171,
        Level = 1,
        Name = "Resonance_67084_Name_1|繁衍与灭亡",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_046.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_046.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_046.png",
        BelongGroup = "ResonanceGroupChapter9",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_67084_Desc_1|「繁育之理」复制的卡牌算力消耗降低 1。",
        Story = "Resonance_67084_Story_1|你彻底明悟了繁育之理。\n卡达斯的族群繁衍生息。卡达斯的族群灰飞烟灭。\n存续是文明最古老最终极的追求。今日，你为文明的存续而战。"
      })
    })
  },
  [67083] = {
    ID = 67083,
    CnID = "共鸣@章九_共鸣3",
    BaseSortID = 172,
    data_list = readonly({
      readonly({
        BaseSortID = 172,
        Level = 1,
        Name = "Resonance_67083_Name_1|虚幻与真实",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroupChapter9",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_67083_Desc_1|「欢愉之理」获得状态和症状卡的概率降低。",
        Story = "Resonance_67083_Story_1|你彻底明悟了欢愉之理。\n死亡，自由，孤独，无意义……虚幻的愉悦与真实的苦痛无可定义、无可分辨。\n为人类从造物主手中夺回选择的权利，这是你的存在主义。"
      })
    })
  },
  [74079] = {
    ID = 74079,
    CnID = "共鸣@星辰章一_共鸣1",
    BaseSortID = 173,
    data_list = readonly({
      readonly({
        BaseSortID = 173,
        Level = 1,
        Name = "Resonance_74079_Name_1|备用脑缸",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroup2Chapter1",
        UnlockCommon = 0,
        Consume = 0,
        Desc = "Resonance_74079_Desc_1|在「尚未流失的意识」事件处，将 「备用脑缸」洗入牌库。打出非消耗指令卡时若「备用脑缸」中没有此卡牌，会将其消耗复制置入「备用脑缸」，每回合最多生效 1 次。",
        Story = "Resonance_74079_Story_1|熔毁·朵尔从不清点她的脑缸。\n「没有必要，」熔毁·朵尔将电极刺入新鲜的脑子，冰冷的双眼紧盯着抽搐的皮层，「有些东西，只有落在天才手中才是无价的宝物，落在庸人手中只是廉价的脂肪和蛋白质。」"
      })
    })
  },
  [74080] = {
    ID = 74080,
    CnID = "共鸣@星辰章一_共鸣2A",
    BaseSortID = 174,
    data_list = readonly({
      readonly({
        BaseSortID = 174,
        Level = 1,
        Name = "Resonance_74080_Name_1|精密存储",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroup2Chapter1",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_74080_Desc_1|备用脑缸每场战斗首次打出时算力消耗为 0。",
        Story = "Resonance_74080_Story_1|你在讽刺我吗？\n难以分辨成分的污垢如同病态的血液，将脑缸的玻璃染成一片斑驳腐朽的乌黑，其内容物令人不安却又有着奇异的吸引力。\n褪色的标签布满了暗色的污点，黯淡的笔迹暗示着可疑的内容——关于囚禁、野心和死亡。"
      })
    })
  },
  [74078] = {
    ID = 74078,
    CnID = "共鸣@星辰章一_共鸣2B",
    BaseSortID = 175,
    data_list = readonly({
      readonly({
        BaseSortID = 175,
        Level = 1,
        Name = "Resonance_74078_Name_1|排序算法",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroup2Chapter1",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_74078_Desc_1|备用脑缸获得「固有」。",
        Story = "Resonance_74078_Story_1|宇宙中有许多种规划优先级的方式。\n熔毁·朵尔选择优先毁灭那些充盈希望的维度。因为希望是最诱人的毒药，令人深陷于极夜般漫长的痛苦。"
      })
    })
  },
  [74076] = {
    ID = 74076,
    CnID = "共鸣@星辰章一_共鸣3A",
    BaseSortID = 176,
    data_list = readonly({
      readonly({
        BaseSortID = 176,
        Level = 1,
        Name = "Resonance_74076_Name_1|高性能演算",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroup2Chapter1",
        PreResonance = {74080},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_74076_Desc_1|在「尚未流失的意识」事件中选择加入备用脑缸后，还可以将最多 2 张指令卡删除，将他们加入备用脑缸。",
        Story = "Resonance_74076_Story_1|一万、一亿、一千兆。\n夜空中的繁星一颗一颗熄灭。\n她掌控的世界一个一个毁灭。"
      })
    })
  },
  [74077] = {
    ID = 74077,
    CnID = "共鸣@星辰章一_共鸣3B",
    BaseSortID = 177,
    data_list = readonly({
      readonly({
        BaseSortID = 177,
        Level = 1,
        Name = "Resonance_74077_Name_1|样本筛查",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroup2Chapter1",
        PreResonance = {74078},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_74077_Desc_1|战斗开始时将 1 张「灵感」置入备用脑缸。",
        Story = "Resonance_74077_Story_1|有些渣滓的灰烬只是污染，不必加入银芯熔炼的火堆。"
      })
    })
  },
  [74074] = {
    ID = 74074,
    CnID = "共鸣@星辰章一_共鸣4A",
    BaseSortID = 178,
    data_list = readonly({
      readonly({
        BaseSortID = 178,
        Level = 1,
        Name = "Resonance_74074_Name_1|核心扩容",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroup2Chapter1",
        PreResonance = {74076},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_74074_Desc_1|手牌上限+2。",
        Story = "Resonance_74074_Story_1|熔毁·朵尔的实验室布置得毫无特色，她停留在实验室中的时间也不多。\n她总是穿梭在各个亟待毁灭的维度之间，行动悄无声息，像穿着死神长袍的幽灵。\n当实验室能够监控到的维度越来越多，她的行动也愈发频繁。\n这里的空间太过狭小了，把隔壁也改造成实验室的一部分吧。别担心，那里早就没有居住者了。"
      })
    })
  },
  [74075] = {
    ID = 74075,
    CnID = "共鸣@星辰章一_共鸣4B",
    BaseSortID = 179,
    data_list = readonly({
      readonly({
        BaseSortID = 179,
        Level = 1,
        Name = "Resonance_74075_Name_1|意识匹配",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_033.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_033.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_033.png",
        BelongGroup = "ResonanceGroup2Chapter1",
        PreResonance = {74077},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_74075_Desc_1|所有唤醒体专属造物出现率提高 100%。",
        Story = "Resonance_74075_Story_1|熔毁·朵尔对维度空间的造物已有所了解。唤醒意识的风险之一是异常的躯体支配能力，那是错位匹配的一种，它是所有熔炼效率降低的罪魁祸首。\n意识匹配流程需要消耗三个工作日以上的时间，但这样做是值得的。"
      })
    })
  },
  [74073] = {
    ID = 74073,
    CnID = "共鸣@星辰章一_共鸣5A",
    BaseSortID = 180,
    data_list = readonly({
      readonly({
        BaseSortID = 180,
        Level = 1,
        Name = "Resonance_74073_Name_1|义体克隆",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_033.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_033.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_033.png",
        BelongGroup = "ResonanceGroup2Chapter1",
        PreResonance = {74076},
        UnlockCommon = 0,
        Consume = 2,
        Desc = "Resonance_74073_Desc_1|打出卡牌触发「备用脑缸」时，额外置入一张附加消耗的原始复制。",
        Story = "Resonance_74073_Story_1|废弃的人偶小山一样堆放在实验室角落。\n它们的四肢无力地垂下，形成肢体的密网，在网格的孔隙间透出粉色的长发，每一个人偶都长着朵尔的脸。"
      })
    })
  },
  [74072] = {
    ID = 74072,
    CnID = "共鸣@星辰章一_共鸣5B",
    BaseSortID = 181,
    data_list = readonly({
      readonly({
        BaseSortID = 181,
        Level = 1,
        Name = "Resonance_74072_Name_1|堆栈处理",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroup2Chapter1",
        PreResonance = {74077},
        UnlockCommon = 0,
        Consume = 2,
        Desc = "Resonance_74072_Desc_1|回合结束时，「备用脑缸」中算力消耗最高的卡牌算力消耗降低 2 点。",
        Story = "Resonance_74072_Story_1|监测守密人的活动轨迹，朵尔拍了拍温柯尔的肩膀，没有守密人的世界就无需投入太多精力了，它们会自行迈入毁灭的。"
      })
    })
  },
  [74082] = {
    ID = 74082,
    CnID = "共鸣@星辰章一_共鸣6",
    BaseSortID = 182,
    data_list = readonly({
      readonly({
        BaseSortID = 182,
        Level = 1,
        Name = "Resonance_74082_Name_1|终末熔毁",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroup2Chapter1",
        PreResonance = {74074, 74075},
        UnlockCommon = 1,
        Consume = 1,
        Desc = "Resonance_74082_Desc_1|首领战中将一张拥有「消耗」的「狂乱熔毁」置入备用脑缸：算力 5，所有唤醒体获得 50 点狂气，虚弱和易伤所有敌人 2 回合。",
        Story = "Resonance_74082_Story_1|让所有维度的存在跟随脑缸中的意识一同毁灭吧。\n诞生本就毫无意义，死亡更是命定的终结。\n那就燃烧吧，燃烧吧！终将消逝之物，不如绽放在熔毁的烈焰中。"
      })
    })
  },
  [74081] = {
    ID = 74081,
    CnID = "共鸣@星辰章一_共鸣7",
    BaseSortID = 183,
    data_list = readonly({
      readonly({
        BaseSortID = 183,
        Level = 1,
        Name = "Resonance_74081_Name_1|机械回收",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroup2Chapter1",
        PreResonance = {74082},
        UnlockCommon = 0,
        Consume = 2,
        Desc = "Resonance_74081_Desc_1|备用脑缸获得预备 1，且打出后回到手中。",
        Story = "Resonance_74081_Story_1|人偶的关节在跳舞。\n舒展的，紧绷的，悠扬的，颓丧的。僵硬的表情凝固在人偶的脸上，人偶只能以扭曲的舞姿倾吐内心的情感。"
      })
    })
  },
  [79421] = {
    ID = 79421,
    CnID = "共鸣@星辰章二_共鸣1",
    BaseSortID = 184,
    data_list = readonly({
      readonly({
        BaseSortID = 184,
        Level = 1,
        Name = "Resonance_79421_Name_1|生命仪式",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroup2Chapter2",
        UnlockCommon = 0,
        Consume = 0,
        Desc = "Resonance_79421_Desc_1|在「生命的蜕变」事件处，选择一名唤醒体转化为「虫族」。\n「虫族」的狂气回充和银钥充能提高 25%，所有非衍生指令卡算力消耗 -1，但打出后会消耗。",
        Story = "Resonance_79421_Story_1|脆弱是人类的定义，死亡是人类的结局。\n但你有机会改变这一切——\n嘶鸣吧！蜕变吧！在这个不可名状的残酷世界，生存总要付出代价。"
      })
    })
  },
  [79422] = {
    ID = 79422,
    CnID = "共鸣@星辰章二_共鸣2A",
    BaseSortID = 185,
    data_list = readonly({
      readonly({
        BaseSortID = 185,
        Level = 1,
        Name = "Resonance_79422_Name_1|虫巢共鸣",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroup2Chapter2",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_79422_Desc_1|每当其它唤醒体打出「打击」或「防御」时，将一张「虫族」的对应卡牌置入手中，每回合最多生效 1 次。",
        Story = "Resonance_79422_Story_1|听到那些嘶鸣了吗？那是虫巢对于新生成员的回应。\n无论需要跨越多少维度，我们都与所有同族的意志，永远链接，永恒共存。"
      })
    })
  },
  [79420] = {
    ID = 79420,
    CnID = "共鸣@星辰章二_共鸣2B",
    BaseSortID = 186,
    data_list = readonly({
      readonly({
        BaseSortID = 186,
        Level = 1,
        Name = "Resonance_79420_Name_1|认知渗透",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroup2Chapter2",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_79420_Desc_1|「虫族」打出卡牌后所有唤醒体获得 2 点狂气。",
        Story = "Resonance_79420_Story_1|人类会本能模仿同伴的行为，这是他们作为智人的底层设计。\n而我们，当然是他们的「同伴」——\n当蜕去人类的皮囊，只留下赤裸的意识，谁又分得清自己到底属于什么？"
      })
    })
  },
  [79426] = {
    ID = 79426,
    CnID = "共鸣@星辰章二_共鸣3",
    BaseSortID = 187,
    data_list = readonly({
      readonly({
        BaseSortID = 187,
        Level = 1,
        Name = "Resonance_79426_Name_1|存在性超越",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroup2Chapter2",
        PreResonance = {79422, 79420},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_79426_Desc_1|「虫族」的属性得到增强，狂气回充和银钥充能提高为 35%。",
        Story = "Resonance_79426_Story_1|直面死亡与虚无，会获得生命的升华。你却不必如此。\n宇宙中数万同族振翅的嗡鸣，就是你力量的来源。\n你的存在本身，便是生命的超越。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_79426_Name_2|存在性超越",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroup2Chapter2",
        PreResonance = {79422, 79420},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_79426_Desc_2|「虫族」的属性得到增强，狂气回充和银钥充能提高为 50%。"
      })
    })
  },
  [79423] = {
    ID = 79423,
    CnID = "共鸣@星辰章二_共鸣4",
    BaseSortID = 188,
    data_list = readonly({
      readonly({
        BaseSortID = 188,
        Level = 1,
        Name = "Resonance_79423_Name_1|人格伪装",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroup2Chapter2",
        PreResonance = {79426},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_79423_Desc_1|手牌上限和造物上限+1。",
        Story = "Resonance_79423_Story_1|人类的心理与行为同样是一门可以归纳、推演的学科。\n瞧，只要将一切成为人所需要的知识尽数掌握，一张毫无破绽的人皮便已经塑成。"
      })
    })
  },
  [79424] = {
    ID = 79424,
    CnID = "共鸣@星辰章二_共鸣4A",
    BaseSortID = 189,
    data_list = readonly({
      readonly({
        BaseSortID = 189,
        Level = 1,
        Name = "Resonance_79424_Name_1|蚕食",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroup2Chapter2",
        PreResonance = {79423},
        UnlockCommon = 0,
        Consume = 2,
        Desc = "Resonance_79424_Desc_1|每当「虫族」以外的唤醒体释放狂气爆发后，随机将一张「虫族」的「技能卡」置入手中，每回合最多生效 1 次。",
        Story = "Resonance_79424_Story_1|「啊，我闻到了，痛苦的甜美气息。\n感谢你奉上的绝望记忆，我会尽量慢慢地、慢慢地充分品尝。」"
      })
    })
  },
  [79425] = {
    ID = 79425,
    CnID = "共鸣@星辰章二_共鸣4B",
    BaseSortID = 190,
    data_list = readonly({
      readonly({
        BaseSortID = 190,
        Level = 1,
        Name = "Resonance_79425_Name_1|灵智操纵",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroup2Chapter2",
        PreResonance = {79423},
        UnlockCommon = 0,
        Consume = 2,
        Desc = "Resonance_79425_Desc_1|每当「虫族」释放狂气爆发后，其他唤醒体获得 10 点狂气。",
        Story = "Resonance_79425_Story_1|最开始，只是轻微不适。毕竟刚植入的幼虫还不足以影响整个宿主。\n但很快，痛苦和绝望就会化为养料，催化它的成长，就此，整个脑沟都是它的游乐场。\n不必惊讶自己的言不由衷、行不由心，那只是它终于成熟。"
      })
    })
  },
  [79418] = {
    ID = 79418,
    CnID = "共鸣@星辰章二_共鸣5",
    BaseSortID = 191,
    data_list = readonly({
      readonly({
        BaseSortID = 191,
        Level = 1,
        Name = "Resonance_79418_Name_1|合一体验",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_033.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_033.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_033.png",
        BelongGroup = "ResonanceGroup2Chapter2",
        PreResonance = {79423},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_79418_Desc_1|「虫族」的专属造物出现率提高 300%。",
        Story = "Resonance_79418_Story_1|「从现在起，你将超越个体的界限，与宇宙无限的灵性共鸣。\n那些虫鸣和振翅声吗？不必太在意，这只是人脑因机能有限产生的耳鸣罢了。」"
      })
    })
  },
  [81025] = {
    ID = 81025,
    CnID = "共鸣@星辰章二_共鸣5A",
    BaseSortID = 192,
    data_list = readonly({
      readonly({
        BaseSortID = 192,
        Level = 1,
        Name = "Resonance_81025_Name_1|躯壳畸变",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_033.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_033.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_033.png",
        BelongGroup = "ResonanceGroup2Chapter2",
        PreResonance = {79418},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_81025_Desc_1|「虫族」的「防御」获得最大生命 1% 的临时戒备，每回合最多生效 2 次。",
        Story = "Resonance_81025_Story_1|想要了解宇宙的真实，必须超脱人类的限制。\n这个想法突兀地出现在脑中，被奉为真理。因此你忽略了——\n忽略了不断增生的复眼、触角、甲壳，直到彻底畸变。"
      })
    })
  },
  [81024] = {
    ID = 81024,
    CnID = "共鸣@星辰章二_共鸣5B",
    BaseSortID = 193,
    data_list = readonly({
      readonly({
        BaseSortID = 193,
        Level = 1,
        Name = "Resonance_81024_Name_1|精神剥削",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroup2Chapter2",
        PreResonance = {79418},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_81024_Desc_1|「虫族」的「打击」获得最大生命 4% 的临时力量，每回合最多生效 2 次。",
        Story = "Resonance_81024_Story_1|精神剥削，从心理学层面，它们的行为可以这样概括。\n但真正的残酷，无法定义。\n疯狂与死亡，只是这过程中最微不足道的副产物。"
      })
    })
  },
  [81023] = {
    ID = 81023,
    CnID = "共鸣@星辰章二_共鸣6",
    BaseSortID = 194,
    data_list = readonly({
      readonly({
        BaseSortID = 194,
        Level = 1,
        Name = "Resonance_81023_Name_1|痊愈新生",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroup2Chapter2",
        PreResonance = {81025, 81024},
        UnlockCommon = 1,
        Consume = 3,
        Desc = "Resonance_81023_Desc_1|在首领战中，打出 20 张「虫族」非衍生指令卡后，将一张「巢群意志」置入手中。\n「巢群意志」：将所有手牌弃掉，更换为「虫族」的随机指令卡。「虫族」每回合能够释放 2 次狂气爆发。",
        Story = "Resonance_81023_Story_1|「恭喜你，已经痊愈。」\n温柔的声音回响在你头顶，伴奏是你亵渎的嘶鸣与振翅声。\n「现在，享受你全新的身体，享受这无与伦比的……新生。」"
      })
    })
  },
  [90557] = {
    ID = 90557,
    CnID = "共鸣@星辰章三_共鸣1",
    BaseSortID = 195,
    data_list = readonly({
      readonly({
        BaseSortID = 195,
        Level = 1,
        Name = "Resonance_90557_Name_1|宾客权利",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_044.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_044.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_044.png",
        BelongGroup = "ResonanceGroup2Chapter3",
        UnlockCommon = 0,
        Consume = 0,
        Desc = "Resonance_90557_Desc_1|在「宴前仪礼」事件处，将 1 张「祭灵夜特调」置入牌库。\n打出「祭灵夜特调」后，将 1 种材料置入其中，使其在本场战斗中永久获得特定效果！",
        Story = "Resonance_90557_Story_1|食尸鬼侍者向你鞠躬致意。精致的餐盘上，颅骨杯盏空洞的眼睛望向你，鲜红的液体在杯中泛起优雅的波纹。\n收下它吧。这是食尸鬼之王的赠礼，这是你身为宾客的权利。\n你当然不会拒绝它的，对吗？"
      })
    })
  },
  [90560] = {
    ID = 90560,
    CnID = "共鸣@星辰章三_共鸣1A",
    BaseSortID = 196,
    data_list = readonly({
      readonly({
        BaseSortID = 196,
        Level = 1,
        Name = "Resonance_90560_Name_1|轻嗅",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroup2Chapter3",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_90560_Desc_1|「祭灵夜特调」获得「固有」和「保留」。",
        Story = "Resonance_90560_Story_1|没错，不必急于饮下它。\n俯下身，将鼻尖贴近颅骨光滑的杯沿。让你的每一次呼吸，都沉浸在那浓烈复杂的芬芳里。\n等待，是对一杯佳酿最好的赞颂。"
      })
    })
  },
  [90559] = {
    ID = 90559,
    CnID = "共鸣@星辰章三_共鸣1B",
    BaseSortID = 197,
    data_list = readonly({
      readonly({
        BaseSortID = 197,
        Level = 1,
        Name = "Resonance_90559_Name_1|浅酌",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroup2Chapter3",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_90559_Desc_1|「祭灵夜特调」算力消耗降低 1。",
        Story = "Resonance_90559_Story_1|锋利而清晰的铁腥味，被醇厚的甜意包裹，如同浸透了蜜糖的腐败花瓣，在你的口中融化。\n在你想要扔下杯盏之前，你尝试了第二口，第三口……\n你熟悉了那种独特的味道。你与那种味道融为一体。\n你再也无法离开它。"
      })
    })
  },
  [90562] = {
    ID = 90562,
    CnID = "共鸣@星辰章三_共鸣2",
    BaseSortID = 198,
    data_list = readonly({
      readonly({
        BaseSortID = 198,
        Level = 1,
        Name = "Resonance_90562_Name_1|墓园的欢歌",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroup2Chapter3",
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_90562_Desc_1|首次击杀或击破敌人，抽 1 张「祭灵夜特调」。",
        Story = "Resonance_90562_Story_1|鲜血从墓碑上涌出，盛满你手中的酒杯。\n当敌人的尸体被送入棺椁，整座墓园都在为你欢歌。"
      })
    })
  },
  [90556] = {
    ID = 90556,
    CnID = "共鸣@星辰章三_共鸣3",
    BaseSortID = 199,
    data_list = readonly({
      readonly({
        BaseSortID = 199,
        Level = 1,
        Name = "Resonance_90556_Name_1|微醺",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroup2Chapter3",
        PreResonance = {90562},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_90556_Desc_1|手牌上限+1，每回合额外抽 1 张牌。",
        Story = "Resonance_90556_Story_1|你看见坟墓在旋转。你看见月亮在舞蹈。你看见鲜血汇成河流，你与所有的尸体一同栽倒，随着醉意的浪涛，飘向那无尽的欢愉之地。"
      })
    })
  },
  [90564] = {
    ID = 90564,
    CnID = "共鸣@星辰章三_共鸣4A",
    BaseSortID = 200,
    data_list = readonly({
      readonly({
        BaseSortID = 200,
        Level = 1,
        Name = "Resonance_90564_Name_1|鲜血荆棘",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_045.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_045.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_045.png",
        BelongGroup = "ResonanceGroup2Chapter3",
        PreResonance = {90556},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_90564_Desc_1|「祭灵夜特调」初始暴击率和暴击伤害提高 10%。",
        Story = "Resonance_90564_Story_1|锈迹斑驳的青铜箭簇与灼热的岩浆一同刺向你的味蕾，你的舌头被洞穿、融化、重塑。\n食尸鬼之王将鲜血荆棘的汁液倾入你的杯中。品尝吧，品尝痛楚。\n在味觉美学的大厦中，痛楚是最重要的支柱。"
      })
    })
  },
  [90558] = {
    ID = 90558,
    CnID = "共鸣@星辰章三_共鸣4B",
    BaseSortID = 201,
    data_list = readonly({
      readonly({
        BaseSortID = 201,
        Level = 1,
        Name = "Resonance_90558_Name_1|猩红果实",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_024.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_024.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_024.png",
        BelongGroup = "ResonanceGroup2Chapter3",
        PreResonance = {90556},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_90558_Desc_1|每场战斗结束后，最大生命提高 5%。",
        Story = "Resonance_90558_Story_1|紧致的那颗是眼球。坚硬的那块是指骨。柔软的那块是嘴唇……\n你一一品尝杯中的血块。想象着他们曾经鲜活的模样。\n在这想象里，你们融为一体。"
      })
    })
  },
  [90561] = {
    ID = 90561,
    CnID = "共鸣@星辰章三_共鸣5A",
    BaseSortID = 202,
    data_list = readonly({
      readonly({
        BaseSortID = 202,
        Level = 1,
        Name = "Resonance_90561_Name_1|多重调和",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroup2Chapter3",
        PreResonance = {90564},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_90561_Desc_1|「祭灵夜特调」在首领战中，调和次数提高 1。",
        Story = "Resonance_90561_Story_1|味觉的叠加不一定会让一杯饮品变得更好，但在真正尝试之前，没有人知道它会是什么样的味道。\n食尸鬼之王在你耳边低语。试试吧，朋友。一个崭新的味道，就是一个崭新的世界。"
      })
    })
  },
  [90555] = {
    ID = 90555,
    CnID = "共鸣@星辰章三_共鸣5B",
    BaseSortID = 203,
    data_list = readonly({
      readonly({
        BaseSortID = 203,
        Level = 1,
        Name = "Resonance_90555_Name_1|幽魂赠礼",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_036.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_036.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_036.png",
        BelongGroup = "ResonanceGroup2Chapter3",
        PreResonance = {90558},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_90555_Desc_1|进入探索后死亡抵抗变为初始值的 150%。每次触发死亡抵抗，抽 1 张「祭灵夜特调」。",
        Story = "Resonance_90555_Story_1|见底的杯中，你看见你自己的倒影，看见亡者的幽魂。\n它们欢呼，舞蹈，向你垂首致哀，为你高歌欢笑。\n它们为你斟满杯中血，列队迎接，迎接你成为它们的一员。"
      })
    })
  },
  [90563] = {
    ID = 90563,
    CnID = "共鸣@星辰章三_共鸣6",
    BaseSortID = 204,
    data_list = readonly({
      readonly({
        BaseSortID = 204,
        Level = 1,
        Name = "Resonance_90563_Name_1|欢愉的秘密",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_025.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_025.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_025.png",
        BelongGroup = "ResonanceGroup2Chapter3",
        PreResonance = {90561, 90555},
        UnlockCommon = 1,
        Consume = 3,
        Desc = "Resonance_90563_Desc_1|「祭灵夜特调」在首领战中调和次数提高 1，且若当回合没有打出［祭灵夜特调］，下回合开始时进行 1 次「调和」。",
        Story = "Resonance_90563_Story_1|一盏幽暗的熔炉在胃里点燃。一道至纯的光芒在灵魂深处亮起。甜美与暴烈，芬芳与腐朽，创造与毁灭……\n所有的味道都被倾入杯中，世界在你舌尖厮杀，在你体内对立、统一。你在这味觉里死去又重生。\n食尸鬼之王满意地看着你。现在，你终于明悟了关于欢愉的一切秘密。"
      })
    })
  },
  [117265] = {
    ID = 117265,
    CnID = "共鸣@星辰章四_共鸣1",
    BaseSortID = 205,
    data_list = readonly({
      readonly({
        BaseSortID = 205,
        Level = 1,
        Name = "Resonance_117265_Name_1|墨菲的幻影",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_044.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_044.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_044.png",
        BelongGroup = "ResonanceGroup2Chapter4",
        UnlockCommon = 0,
        Consume = 0,
        Desc = "Resonance_117265_Desc_1|在事件「墨菲的幻影」处，将 3 张「循环的倒影」置入牌库。\n「循环的倒影」：发现一个「追忆效果」将其释放，预备 1，消耗。余波：所有唤醒体获得 5 点狂气。",
        Story = "Resonance_117265_Story_1|海平面上升起淡薄的白雾，将万物笼罩在一片朦胧之中。\n跨越生与死的界限，跨越门扉内外的距离，跨越漫长得褪色的记忆，你看见撑着阳伞的淑女逆光的身影。\n与她共度的时光已经逝去，正如她那单薄却鲜妍的亮色青春。\n等待虚假的日轮升起，薄雾破碎于无形，她的侧影也在梦中摇晃着化为轻飘的虚妄泡沫，向你致以无声的告别。"
      })
    })
  },
  [117266] = {
    ID = 117266,
    CnID = "共鸣@星辰章四_共鸣1A",
    BaseSortID = 206,
    data_list = readonly({
      readonly({
        BaseSortID = 206,
        Level = 1,
        Name = "Resonance_117266_Name_1|起始的循环",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = "ResonanceGroup2Chapter4",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_117266_Desc_1|战斗开始时，抽 1 张「循环的倒影」。",
        Story = "Resonance_117266_Story_1|意料之外的故人重逢。然而，这里却不是你记忆中的那座游轮。\n这里安逸而和平，所有人来自迥然不同的起点，却心无旁骛地航向同一个终点——利莫里亚。\n在新的世界、新的索纳尼尔，某个人建立了她的理想国。"
      })
    })
  },
  [117268] = {
    ID = 117268,
    CnID = "共鸣@星辰章四_共鸣1B",
    BaseSortID = 207,
    data_list = readonly({
      readonly({
        BaseSortID = 207,
        Level = 1,
        Name = "Resonance_117268_Name_1|迷惘的循环",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_026.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_026.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_026.png",
        BelongGroup = "ResonanceGroup2Chapter4",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_117268_Desc_1|「循环的倒影」打出后获得 250 点银钥能量。",
        Story = "Resonance_117268_Story_1|是噩梦，还是轮回？能回应你所有疑问的，只有来自遥远陆地的海风和拍打船舷的浪尖。\n你必须靠自己的双眼、双手和双脚来找出答案。"
      })
    })
  },
  [117267] = {
    ID = 117267,
    CnID = "共鸣@星辰章四_共鸣2",
    BaseSortID = 208,
    data_list = readonly({
      readonly({
        BaseSortID = 208,
        Level = 1,
        Name = "Resonance_117267_Name_1|噩梦的循环",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroup2Chapter4",
        UnlockCommon = 0,
        Consume = 3,
        Desc = "Resonance_117267_Desc_1|在「墨菲的幻影」处，选择 2 张卡牌赋予「渊海回声」刻印：拥有该刻印的卡牌打出时生效 2 次，附加<DepleteIconKeywords:消耗>、<RippleKeywords:余波>：抽 2 张牌。",
        Story = "Resonance_117267_Story_1|黑日高悬，无情地俯瞰着漆黑的死亡。\n这里是清平幻象的背面，是殷切假意的阴影，也是不可直视的炼狱。"
      })
    })
  },
  [117271] = {
    ID = 117271,
    CnID = "共鸣@星辰章四_共鸣3A",
    BaseSortID = 209,
    data_list = readonly({
      readonly({
        BaseSortID = 209,
        Level = 1,
        Name = "Resonance_117271_Name_1|背水的循环",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_045.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_045.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_045.png",
        BelongGroup = "ResonanceGroup2Chapter4",
        PreResonance = {117267, 117266},
        UnlockCommon = 1,
        Consume = 1,
        Desc = "Resonance_117271_Desc_1|首领战开始时，死亡抵抗+100％。每次触发死亡抵抗，将 1 张「循环的倒影」置入手中。",
        Story = "Resonance_117271_Story_1|很接近、很接近了。\n你已通晓关键。\n你已准备万全。"
      })
    })
  },
  [117270] = {
    ID = 117270,
    CnID = "共鸣@星辰章四_共鸣3B",
    BaseSortID = 210,
    data_list = readonly({
      readonly({
        BaseSortID = 210,
        Level = 1,
        Name = "Resonance_117270_Name_1|涉险的循环",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroup2Chapter4",
        PreResonance = {117267, 117268},
        UnlockCommon = 1,
        Consume = 1,
        Desc = "Resonance_117270_Desc_1|「循环的倒影」随机将 1 张被消耗的具有「渊海回声」刻印的卡牌洗入弃牌堆。",
        Story = "Resonance_117270_Story_1|问题未必都会有解答，但在故事终结之前，哪怕只有一线希望，请不要放弃尝试。\n命运总会犒赏坚持不懈的求索者。\n请相信，一切都会是@1@2的选择。"
      })
    })
  },
  [117264] = {
    ID = 117264,
    CnID = "共鸣@星辰章四_共鸣4",
    BaseSortID = 211,
    data_list = readonly({
      readonly({
        BaseSortID = 211,
        Level = 1,
        Name = "Resonance_117264_Name_1|造梦的循环",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_024.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_024.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_024.png",
        BelongGroup = "ResonanceGroup2Chapter4",
        PreResonance = {117267},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_117264_Desc_1|首领战开始时，将「久远的幻梦」置入手中。「久远的幻梦」：弃掉所有手牌并抽 5 张牌，将「循环的倒影」置入手牌堆、抽牌堆、弃牌堆。保留。",
        Story = "Resonance_117264_Story_1|许诺她美好的梦。许诺她永恒的梦。许诺她苍白的梦。\n许诺她名为自由的梦。\n如果无法抵达那个完美的结局，至少留给她一场足以怀恋的梦。"
      })
    })
  },
  [117269] = {
    ID = 117269,
    CnID = "共鸣@星辰章四_共鸣5",
    BaseSortID = 212,
    data_list = readonly({
      readonly({
        BaseSortID = 212,
        Level = 1,
        Name = "Resonance_117269_Name_1|终极的循环",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroup2Chapter4",
        PreResonance = {117264},
        UnlockCommon = 0,
        Consume = 5,
        Desc = "Resonance_117269_Desc_1|「久远的幻梦」可以使用 3 次。",
        Story = "Resonance_117269_Story_1|揭开夜的帷幕，让一切回归原始的真相。"
      })
    })
  },
  [130329] = {
    ID = 130329,
    CnID = "共鸣@星辰章五_共鸣1",
    BaseSortID = 213,
    data_list = readonly({
      readonly({
        BaseSortID = 213,
        Level = 1,
        Name = "Resonance_130329_Name_1|命运的剧场",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = "ResonanceGroup2Chapter5",
        UnlockCommon = 0,
        Consume = 0,
        Desc = "Resonance_130329_Desc_1|在事件「宿命舞台」处将 1 张「提线木偶」置入牌库。\n「提线木偶」：算力消耗 5，抽牌阶段后若在手中，「强制打出」 1 张随机指令卡并使其生效 2 次。打出后，下张打出的指令卡额外生效 2 次。打出 3 次后消耗。固有，保留。",
        Story = "Resonance_130329_Story_1|当你的双足踏上剧院的台阶，目光便再无法从这座舞台移开。\n命运丝线牵引着长河沙数的故事在此流转——过往的尘埃、此刻的光影、未来的迷雾，皆在台前翻涌不息。\n你遗忘了自己来自何方、想要去往何处，关于「自我」的印记在帷幕的阴影里消融殆尽。此刻，你是座下静默的观者，也是台上燃烧的伶人。\n你存在的全部意义，坍缩成两道刻痕：凝望，与献演。"
      })
    })
  },
  [130332] = {
    ID = 130332,
    CnID = "共鸣@星辰章五_共鸣1A",
    BaseSortID = 214,
    data_list = readonly({
      readonly({
        BaseSortID = 214,
        Level = 1,
        Name = "Resonance_130332_Name_1|命运的感召",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_045.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_045.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_045.png",
        BelongGroup = "ResonanceGroup2Chapter5",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_130332_Desc_1|「提线木偶」获得保留：获得 250 银钥能量。",
        Story = "Resonance_130332_Story_1|那本应是平凡的一天。拌嘴的家人，被延迟了三次的闹铃，冒着热气的早餐。\n在故事的开头，平凡是一种罪恶。\n于是，命运轻轻拨动丝线。曾经的一切在眼前崩毁。\n于是，木偶踏上了属于它的旅程。它遥不可及的终点，是回到开始时的那天。"
      })
    })
  },
  [130335] = {
    ID = 130335,
    CnID = "共鸣@星辰章五_共鸣1B",
    BaseSortID = 215,
    data_list = readonly({
      readonly({
        BaseSortID = 215,
        Level = 1,
        Name = "Resonance_130335_Name_1|命运的建构",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroup2Chapter5",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_130335_Desc_1|「提线木偶」获得预备 1。",
        Story = "Resonance_130335_Story_1|看，这是它的期盼，这是它的眷恋，这是它隐秘的罪恶，这是它最难以启齿的苦难。\n命运的丝线将木偶精细地解剖，为观众一一呈现。他们的目光向其间窥视、窥视。\n当命运的丝线将木偶重新缝合，他们的灵魂与木偶融为一体。"
      })
    })
  },
  [130333] = {
    ID = 130333,
    CnID = "共鸣@星辰章五_共鸣2A",
    BaseSortID = 216,
    data_list = readonly({
      readonly({
        BaseSortID = 216,
        Level = 1,
        Name = "Resonance_130333_Name_1|命运的伏笔",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_041.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_041.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_041.png",
        BelongGroup = "ResonanceGroup2Chapter5",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_130333_Desc_1|算力上限和手牌上限提高 1。",
        Story = "Resonance_130333_Story_1|枕边的书籍，死去的宠物，签下的合同，借出的项链……木偶所触碰之物，不可见的丝线轻轻颤动。\n啊，不用去刻意记住它们，亲爱的观众。很快，那些早被昭示的命运，便会清楚地呈现在你眼前。"
      })
    })
  },
  [130336] = {
    ID = 130336,
    CnID = "共鸣@星辰章五_共鸣2B",
    BaseSortID = 217,
    data_list = readonly({
      readonly({
        BaseSortID = 217,
        Level = 1,
        Name = "Resonance_130336_Name_1|命运的纷争",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_036.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_036.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_036.png",
        BelongGroup = "ResonanceGroup2Chapter5",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_130336_Desc_1|打出「提线木偶」时所有唤醒体获得 10 点狂气。",
        Story = "Resonance_130336_Story_1|拿起你的枪，士兵，将准心对准敌人的头颅。\n当然，你当然会有敌人。他们摧毁了你的生活，抢夺你的财富与荣誉，拦在你追寻真理的道路。他们是你站在这座舞台上的缘由。\n你温和善良，有情有义。你热爱和平，厌恶杀戮。\n命运赐予你千种理由，于是，你将毫无负担地扣动扳机。"
      })
    })
  },
  [130334] = {
    ID = 130334,
    CnID = "共鸣@星辰章五_共鸣3",
    BaseSortID = 218,
    data_list = readonly({
      readonly({
        BaseSortID = 218,
        Level = 1,
        Name = "Resonance_130334_Name_1|命运的低谷",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroup2Chapter5",
        UnlockCommon = 0,
        Consume = 4,
        Desc = "Resonance_130334_Desc_1|「提线木偶」若在手中，改为从手牌中的随机 2 张指令中选择 1 张强制打出。",
        Story = "Resonance_130334_Story_1|旅途的中点，英雄的木偶坠入绝望的深渊。一切美好的在它眼前破碎，重新拥有的被再次夺走。\n木偶放弃了选择，放任自己无力反抗的身体在深渊中坠落。\n直到黑暗的尽头，亮起那道它期盼一生的光点。"
      })
    })
  },
  [130328] = {
    ID = 130328,
    CnID = "共鸣@星辰章五_共鸣3A",
    BaseSortID = 219,
    data_list = readonly({
      readonly({
        BaseSortID = 219,
        Level = 1,
        Name = "Resonance_130328_Name_1|命运的转折",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_033.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_033.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_033.png",
        BelongGroup = "ResonanceGroup2Chapter5",
        PreResonance = {130334},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_130328_Desc_1|每打出 1 张「症状卡」，「提线木偶」算力消耗降低 1。",
        Story = "Resonance_130328_Story_1|振作起来吧，亲爱的木偶，沿着既定的道路，从谷底重新踏上旅程。\n苦难中曾刺穿你的棘刺，将是你最为锋利的武器。"
      })
    })
  },
  [130327] = {
    ID = 130327,
    CnID = "共鸣@星辰章五_共鸣3B",
    BaseSortID = 220,
    data_list = readonly({
      readonly({
        BaseSortID = 220,
        Level = 1,
        Name = "Resonance_130327_Name_1|命运的弧光",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_025.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_025.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_025.png",
        BelongGroup = "ResonanceGroup2Chapter5",
        PreResonance = {130334},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_130327_Desc_1|首领战中死亡抵抗 +100%。触发「死亡抵抗」后下回合「提线木偶」不再强制打出随机指令卡，改为选择一张手中指令卡打出。",
        Story = "Resonance_130327_Story_1|看呐，那英雄的木偶重新站在你们面前！它的眼睛多么的坚定！它手中的剑多么的锋利！风吹起它辉煌的战袍，你是否听见了那振奋人心的呼喊？\n英雄的木偶举起利剑，强大得仿佛身上从未存在那些命运的丝线。"
      })
    })
  },
  [130330] = {
    ID = 130330,
    CnID = "共鸣@星辰章五_共鸣4",
    BaseSortID = 221,
    data_list = readonly({
      readonly({
        BaseSortID = 221,
        Level = 1,
        Name = "Resonance_130330_Name_1|命运的高潮",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroup2Chapter5",
        PreResonance = {130334},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_130330_Desc_1|「提线木偶」打出后下张指令卡算力消耗降低 2 点。",
        Story = "Resonance_130330_Story_1|最终的时刻到来了！那曾经无法战胜的敌人便站在你的面前！\n冲锋吧，英雄！无畏地冲向那个苦难的源头，刺破祂的铠甲，撕咬祂的皮肉，让你们的血融于一处，在累累伤痕中，挥动利刃砍下去！\n以命运的名义，英雄的木偶终将胜利。\n木偶举起敌人的头颅。它的身侧除了鲜血，空无一物。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_130330_Name_2|命运的高潮",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroup2Chapter5",
        PreResonance = {130334},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_130330_Desc_2|「提线木偶」打出后下张指令卡算力消耗降低为 0。",
        Story = "Resonance_130330_Story_2|最终的时刻到来了！那曾经无法战胜的敌人便站在你的面前！\n冲锋吧，英雄！无畏地冲向那个苦难的源头，刺破祂的铠甲，撕咬祂的皮肉，让你们的血融于一处，在累累伤痕中，挥动利刃砍下去！\n以命运的名义，英雄的木偶终将胜利。\n木偶举起敌人的头颅。它的身侧除了鲜血，空无一物。"
      })
    })
  },
  [130331] = {
    ID = 130331,
    CnID = "共鸣@星辰章五_共鸣5",
    BaseSortID = 222,
    data_list = readonly({
      readonly({
        BaseSortID = 222,
        Level = 1,
        Name = "Resonance_130331_Name_1|命运的落幕",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_043.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_043.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_043.png",
        BelongGroup = "ResonanceGroup2Chapter5",
        PreResonance = {130330},
        UnlockCommon = 0,
        Consume = 4,
        Desc = "Resonance_130331_Desc_1|「提线木偶」被消耗后，之后每回合打出的第一张指令卡额外生效 2 次。\n若为首领战，所有唤醒体获得 50 点狂气，获得 1000 点银钥能量。",
        Story = "Resonance_130331_Story_1|拌嘴的家人，被延迟了三次的闹铃，冒着热气的早餐。\n在故事的结尾，平凡是一种罪恶。\n命运不再拨动丝线。祂微笑着等待，等待那位英雄的木偶，再次祈求踏上旅途的那一天。"
      })
    })
  },
  [146481] = {
    ID = 146481,
    CnID = "共鸣@星辰章六_共鸣1",
    BaseSortID = 223,
    data_list = readonly({
      readonly({
        BaseSortID = 223,
        Level = 1,
        Name = "Resonance_146481_Name_1|上现蜃景",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = "ResonanceGroup2Chapter6",
        UnlockCommon = 0,
        Consume = 0,
        Desc = "Resonance_146481_Desc_1|战斗开始后，生成 1 张随机「万化之果」置入牌库。\n「万化之果」是若干张能够大幅强化使用者能力的卡牌，但使用时可能会出现些意外状况！\n「万化之果」消耗后，下回合抽牌阶段后生成 1 张新的「万化之果」置入抽牌堆。",
        Story = "Resonance_146481_Story_1|茫茫雪原一望无际，寒风卷不起半点声响，一道说不清来处的幻影悄然浮现，递来一枚温热的果实。\n甜香混着雾气，扑进旅人冻得发麻的鼻腔。 \n这片雪域早已被死亡浸透，空气里飘着腐败与冰寒的反胃气味，唯有掌心这颗果实饱满欲滴，宛如少女诱人的许诺。"
      })
    })
  },
  [148529] = {
    ID = 148529,
    CnID = "共鸣@星辰章六_共鸣2",
    BaseSortID = 224,
    data_list = readonly({
      readonly({
        BaseSortID = 224,
        Level = 1,
        Name = "Resonance_148529_Name_1|远眺群山",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroup2Chapter6",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_148529_Desc_1|「万化之果」选择的唤醒体获得 10 点狂气。",
        Story = "Resonance_148529_Story_1|煨桑仪式的顺利举行并不意味着群山对侵犯的首肯。\n它只是提醒你，在迈入雪山之际，勿忘怀着虔敬的心。\n——嘘，群山在聆听。"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_148529_Name_2|远眺群山",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_022.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_022.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_022.png",
        BelongGroup = "ResonanceGroup2Chapter6",
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_148529_Desc_2|「万化之果」选择的唤醒体获得 20 点狂气。",
        Story = "Resonance_148529_Story_2|煨桑仪式的顺利举行并不意味着群山对侵犯的首肯。\n它只是提醒你，在迈入雪山之际，勿忘怀着虔敬的心。\n——嘘，群山在聆听。"
      })
    })
  },
  [146480] = {
    ID = 146480,
    CnID = "共鸣@星辰章六_共鸣3",
    BaseSortID = 225,
    data_list = readonly({
      readonly({
        BaseSortID = 225,
        Level = 1,
        Name = "Resonance_146480_Name_1|敛入倒影",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_025.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_025.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_025.png",
        BelongGroup = "ResonanceGroup2Chapter6",
        PreResonance = {148529},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_146480_Desc_1|「万化之果」获得保留：所有唤醒体获得 5 点狂气。",
        Story = "Resonance_146480_Story_1|湖泊中倒映着千万年以前的星辰，那是她苦寻而不得的梦幻泡影。\n她坐在湖底歌唱，四周堆满腐烂的尸骨。\n若拯救终究无法降临，那就歌唱吧，歌唱吧，唱到喉咙溃烂，唱到万物凋朽，唱到宇宙也迎来祂的尽头。"
      })
    })
  },
  [148530] = {
    ID = 148530,
    CnID = "共鸣@星辰章六_共鸣7",
    BaseSortID = 226,
    data_list = readonly({
      readonly({
        BaseSortID = 226,
        Level = 1,
        Name = "Resonance_148530_Name_1|本应眷顾之运",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_051.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_051.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_051.png",
        BelongGroup = "ResonanceGroup2Chapter6",
        PreResonance = {148529},
        UnlockCommon = 0,
        Consume = 2,
        Desc = "Resonance_148530_Desc_1|造物上限+5。「万化之果」移除手中选择唤醒体卡牌的「迟缓」效果。",
        Story = "Resonance_148530_Story_1|少女轻轻牵住了远来的丝线，半信半疑地步入黑暗之中。\n在舍弃欺骗之后，这是她唯一能交付信任之物。"
      })
    })
  },
  [146476] = {
    ID = 146476,
    CnID = "共鸣@星辰章六_共鸣4",
    BaseSortID = 227,
    data_list = readonly({
      readonly({
        BaseSortID = 227,
        Level = 1,
        Name = "Resonance_146476_Name_1|飘摇于昨日风雪",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_031.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_031.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_031.png",
        BelongGroup = "ResonanceGroup2Chapter6",
        PreResonance = {146480},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_146476_Desc_1|手牌上限+2，每回合额外抽 1 张牌。",
        Story = "Resonance_146476_Story_1|从诞生开始，我们就在一起。我们是宇宙中不可分离的两个渺小细胞。\n就让风雪卷走所有的谎言与祝福，而你我相拥于积雪下安眠。"
      })
    })
  },
  [148528] = {
    ID = 148528,
    CnID = "共鸣@星辰章六_共鸣8",
    BaseSortID = 228,
    data_list = readonly({
      readonly({
        BaseSortID = 228,
        Level = 1,
        Name = "Resonance_148528_Name_1|现已扭曲之命",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_046.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_046.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_046.png",
        BelongGroup = "ResonanceGroup2Chapter6",
        PreResonance = {148530},
        UnlockCommon = 0,
        Consume = 2,
        Desc = "Resonance_148528_Desc_1|探索中免疫一次死亡，触发后回复 50% 最大生命并获得 2000 点银钥能量，但随机施加 3 次「暗藏杀机」效果：随机承受 1 个负面状态。",
        Story = "Resonance_148528_Story_1|少女牢牢抓紧了手中的稻草，任由它在掌心割出细密的血痕。\n在学会坠落之前，这是她仅有之物。"
      })
    })
  },
  [146482] = {
    ID = 146482,
    CnID = "共鸣@星辰章六_共鸣5",
    BaseSortID = 229,
    data_list = readonly({
      readonly({
        BaseSortID = 229,
        Level = 1,
        Name = "Resonance_146482_Name_1|噩梦如期而至",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_036.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_036.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_036.png",
        BelongGroup = "ResonanceGroup2Chapter6",
        PreResonance = {146476},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_146482_Desc_1|每有 1 张「万化之果」在手中，所有唤醒体造成主动伤害时附加 10% 出血。",
        Story = "Resonance_146482_Story_1|别期盼。别渴望。别寄托。\n信任是最恶毒的诅咒，陈酿越久便化为越刺骨的毒。\n没有人能够逃脱。"
      })
    })
  },
  [148527] = {
    ID = 148527,
    CnID = "共鸣@星辰章六_共鸣6",
    BaseSortID = 230,
    data_list = readonly({
      readonly({
        BaseSortID = 230,
        Level = 1,
        Name = "Resonance_148527_Name_1|真相姗姗来迟",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = "ResonanceGroup2Chapter6",
        PreResonance = {146482},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_148527_Desc_1|「万化之果」获得「预备」，打出时触发手中所有的预备效果。",
        Story = "Resonance_148527_Story_1|他行走于这片大地时，曾无数次询问：我因何而来，我所追寻之物究竟身在何方。\n两个疑问，一次解决。"
      })
    })
  },
  [148526] = {
    ID = 148526,
    CnID = "共鸣@星辰章六_共鸣9",
    BaseSortID = 231,
    data_list = readonly({
      readonly({
        BaseSortID = 231,
        Level = 1,
        Name = "Resonance_148526_Name_1|献礼之刻，死亦新生",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_048.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_048.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_048.png",
        BelongGroup = "ResonanceGroup2Chapter6",
        PreResonance = {148527, 148528},
        UnlockCommon = 1,
        Consume = 5,
        Desc = "Resonance_148526_Desc_1|「万化之果」的能力新增「永恒之冠」：抽 1 张该唤醒体的指令卡并使其算力消耗变为 0，该唤醒体下次狂气爆发视为超限爆发，若已为超限爆发则返还 100% 基础狂气。\n首领战中额外将 1 张「万化之果」置入牌库。",
        Story = "Resonance_148526_Story_1|献礼于王。\n祂以双目直视着万古长梦的崩毁，循环虚妄的溃散。\n纷纷扬扬的烟尘沉坠，如同万物大限降临，落在所有生者与死者身上。\n唯有死亡永恒不朽。"
      })
    })
  },
  [116441] = {
    ID = 116441,
    CnID = "共鸣@尖塔肉鸽共鸣1",
    BaseSortID = 232,
    data_list = readonly({
      readonly({
        BaseSortID = 232,
        Level = 1,
        Name = "Resonance_116441_Name_1|共鸣1",
        IsDefaultTalentNode = 1,
        Type = "normal",
        Coordinates = {0.1, 0.5},
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_023.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_023.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_023.png",
        BelongGroup = 116444,
        UnlockCommon = 0,
        Consume = 0,
        Desc = "Resonance_116441_Desc_1|尖塔肉鸽共鸣1"
      })
    })
  },
  [116439] = {
    ID = 116439,
    CnID = "共鸣@尖塔肉鸽共鸣2",
    BaseSortID = 233,
    data_list = readonly({
      readonly({
        BaseSortID = 233,
        Level = 1,
        Name = "Resonance_116439_Name_1|共鸣2",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Coordinates = {0.2, 0.5},
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = 116444,
        PreResonance = {116441},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_116439_Desc_1|尖塔肉鸽共鸣2"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_116439_Name_2|共鸣2",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = 116444,
        PreResonance = {116441},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_116439_Desc_2|尖塔肉鸽共鸣2"
      }),
      readonly({
        Level = 3,
        Name = "Resonance_116439_Name_3|共鸣2",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_035.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_035.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_035.png",
        BelongGroup = 116444,
        PreResonance = {116441},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_116439_Desc_3|尖塔肉鸽共鸣2"
      })
    })
  },
  [116440] = {
    ID = 116440,
    CnID = "共鸣@尖塔肉鸽共鸣3",
    BaseSortID = 234,
    data_list = readonly({
      readonly({
        BaseSortID = 234,
        Level = 1,
        Name = "Resonance_116440_Name_1|共鸣3",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Coordinates = {0.3, 0.5},
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_032.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_032.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_032.png",
        BelongGroup = 116444,
        PreResonance = {116439},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_116440_Desc_1|尖塔肉鸽共鸣3"
      })
    })
  },
  [116442] = {
    ID = 116442,
    CnID = "共鸣@尖塔肉鸽共鸣4",
    BaseSortID = 235,
    data_list = readonly({
      readonly({
        BaseSortID = 235,
        Level = 1,
        Name = "Resonance_116442_Name_1|共鸣4",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Coordinates = {0.4, 0.5},
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_033.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_033.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_033.png",
        BelongGroup = 116444,
        PreResonance = {116440},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_116442_Desc_1|尖塔肉鸽共鸣4"
      })
    })
  },
  [116443] = {
    ID = 116443,
    CnID = "共鸣@尖塔肉鸽共鸣5",
    BaseSortID = 236,
    data_list = readonly({
      readonly({
        BaseSortID = 236,
        Level = 1,
        Name = "Resonance_116443_Name_1|共鸣5",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Coordinates = {0.5, 0.5},
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = 116444,
        PreResonance = {116442},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_116443_Desc_1|尖塔肉鸽共鸣5"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_116443_Name_2|共鸣5",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_034.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_034.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_034.png",
        BelongGroup = 116444,
        PreResonance = {116442},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_116443_Desc_2|尖塔肉鸽共鸣5"
      })
    })
  },
  [116438] = {
    ID = 116438,
    CnID = "共鸣@尖塔肉鸽共鸣6",
    BaseSortID = 237,
    data_list = readonly({
      readonly({
        BaseSortID = 237,
        Level = 1,
        Name = "Resonance_116438_Name_1|共鸣6",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Coordinates = {0.6, 0.5},
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_037.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_037.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_037.png",
        BelongGroup = 116444,
        PreResonance = {116443},
        UnlockCommon = 0,
        Consume = 1,
        Desc = "Resonance_116438_Desc_1|尖塔肉鸽共鸣6"
      })
    })
  },
  [129148] = {
    ID = 129148,
    CnID = "共鸣@疾驰的欢愉专列_共鸣1",
    BaseSortID = 238,
    data_list = readonly({
      readonly({
        BaseSortID = 238,
        Level = 1,
        Name = "Resonance_129148_Name_1|列车出发",
        IsDefaultTalentNode = 1,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_040.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_040.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_040.png",
        BelongGroup = "ResonanceGroupRailway",
        UnlockCommon = 0,
        Consume = 0,
        State1 = {
          129741,
          129734,
          129295,
          129820
        },
        StateTarget1 = "PlayerRole",
        StatePara1 = {8, 0},
        Desc = "Resonance_129148_Desc_1|探索开始时，将额外一套指令卡加入牌库，并使造物上限+8。",
        Story = "Resonance_129148_Story_1|「呜呜呜——」\n尊敬的各位乘客，欢愉列车即将发车，请拿出票据对号入座。同时请看管好您的随身物品，避免被善良可爱的小精灵偷走。\n「咳咳，现在是午夜26点27分，我们正准备跨越时空黑洞，本次旅程结束后您可能会有失忆、眩晕等负面反应，这是时空旅行的正常现象，还请谅解~」\n「我是本次旅行的列车长小N，现在我宣布，开往弥萨格的欢愉列车，正式出发！」"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_129148_Name_2|列车出发",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_040.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_040.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_040.png",
        BelongGroup = "ResonanceGroupRailway",
        UnlockCommon = 0,
        Consume = 1,
        State1 = {
          129741,
          129734,
          129295,
          129820
        },
        StateTarget1 = "PlayerRole",
        StatePara1 = {16, 0},
        Desc = "Resonance_129148_Desc_2|探索开始时，将额外一套指令卡加入牌库，并使造物上限+16。"
      }),
      readonly({
        Level = 3,
        Name = "Resonance_129148_Name_3|列车出发",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_040.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_040.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_040.png",
        BelongGroup = "ResonanceGroupRailway",
        UnlockCommon = 0,
        Consume = 1,
        State1 = {
          129741,
          129734,
          129295,
          129820
        },
        StateTarget1 = "PlayerRole",
        StatePara1 = {28, 0},
        Desc = "Resonance_129148_Desc_3|探索开始时，将额外一套指令卡加入牌库，并使造物上限+28。"
      })
    })
  },
  [129150] = {
    ID = 129150,
    CnID = "共鸣@疾驰的欢愉专列_共鸣2",
    BaseSortID = 239,
    data_list = readonly({
      readonly({
        BaseSortID = 239,
        Level = 1,
        Name = "Resonance_129150_Name_1|黄金蜜饯干",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_052.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_052.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_052.png",
        BelongGroup = "ResonanceGroupRailway",
        UnlockCommon = 1,
        Consume = 1,
        AddAttrsTarget = 1,
        AwakerAttrs = readonly({physique = 25}),
        Desc = "Resonance_129150_Desc_1|所有唤醒体体质+25%。",
        Story = "Resonance_129150_Story_1|甜度恰到好处的蜜饯干，只要吃上一口，一整天都会心情愉悦。\n当然，叫它「黄金蜜饯干」不是因为它有黄金比例的甜度配比，而是这里面真的有黄金，以及比黄金还珍贵的蜜酒。"
      })
    })
  },
  [129162] = {
    ID = 129162,
    CnID = "共鸣@疾驰的欢愉专列_共鸣3",
    BaseSortID = 240,
    data_list = readonly({
      readonly({
        BaseSortID = 240,
        Level = 1,
        Name = "Resonance_129162_Name_1|火辣蟾蜍眼",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_021.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_021.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_021.png",
        BelongGroup = "ResonanceGroupRailway",
        UnlockCommon = 1,
        Consume = 1,
        AddAttrsTarget = 1,
        AwakerAttrs = readonly({atk = 25}),
        Desc = "Resonance_129162_Desc_1|所有唤醒体攻击+25%。",
        Story = "Resonance_129162_Story_1|从某个女仆那里进货的甜点，吃下后可以显著提高攻击力。\n嗯？你问为什么？\n因为这东西难吃到需要让人迫切地殴打一顿提供者，才能释放心中的怒气。\n「哇——我是真的觉得好吃才进货的，别，别打了！」"
      })
    })
  },
  [129161] = {
    ID = 129161,
    CnID = "共鸣@疾驰的欢愉专列_共鸣4",
    BaseSortID = 241,
    data_list = readonly({
      readonly({
        BaseSortID = 241,
        Level = 1,
        Name = "Resonance_129161_Name_1|香草煎鳟鱼",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_053.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_053.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_053.png",
        BelongGroup = "ResonanceGroupRailway",
        UnlockCommon = 1,
        Consume = 1,
        AddAttrsTarget = 1,
        AwakerAttrs = readonly({def = 25}),
        Desc = "Resonance_129161_Desc_1|所有唤醒体防御+25%。",
        Story = "Resonance_129161_Story_1|鳟鱼俱乐部金牌会员提供的顶级鳟鱼，搭配上列车厨师长的精湛厨艺，匠心制作而成的顶级主菜。\n仅凭香气就能让全列车的人垂涎三尺。\n厨师长是谁？\n嗯……有时候无知也是一种幸福呢。\n「冤枉啊，这次我真的没有想看乐子。」"
      })
    })
  },
  [129149] = {
    ID = 129149,
    CnID = "共鸣@疾驰的欢愉专列_共鸣5",
    BaseSortID = 242,
    data_list = readonly({
      readonly({
        BaseSortID = 242,
        Level = 1,
        Name = "Resonance_129149_Name_1|庆功宴",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_046.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_046.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_046.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {
          129150,
          129162,
          129161
        },
        UnlockCommon = 1,
        Consume = 1,
        State1 = {129294},
        StateTarget1 = "PlayerRole",
        StatePara1 = {0.5},
        Desc = "Resonance_129149_Desc_1|战胜首领后，死亡抵抗恢复至初始值，并回复50%已损失的生命值。",
        Story = "Resonance_129149_Story_1|为了庆祝我们卡达斯的拯救者，弥萨格最后的守密人，跨越维度的旅者又击败了一批敌人所举办的宴会。\n「本想这么说，可是房间太小，坐不下这么多……」\n「玩笑，玩笑，看在由小N买单的份上，大伙先把家伙收起来……」"
      })
    })
  },
  [129158] = {
    ID = 129158,
    CnID = "共鸣@疾驰的欢愉专列_共鸣6",
    BaseSortID = 243,
    data_list = readonly({
      readonly({
        BaseSortID = 243,
        Level = 1,
        Name = "Resonance_129158_Name_1|梅菲斯娜",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_052.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_052.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_052.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {129149},
        UnlockCommon = 1,
        Consume = 1,
        AddAttrsTarget = 4,
        AwakerAttrs = readonly({
          atk = 25,
          def = 25,
          physique = 25
        }),
        Desc = "Resonance_129158_Desc_1|辅助型唤醒体体质、攻击、防御+25%。",
        Story = "Resonance_129158_Story_1|传说，那位手持银钥者身边有一个无所不知的大恶魔。\n那位大恶魔会在手持银钥者身边低语，诱惑其走上她的道路。\n哦，何等的暴行——将干枯扭曲的尸体浸入液体中，啜饮它们的析出物，将未出世的孩子打碎，缠裹在母亲的尸体上，投入滚烫的甘油三酯中。\n「小N……闭上了双眼……」\n小N名画——《拉蒙娜和守密人正在享用炸鸡和红茶》\n「好香……请立刻投喂小N。」"
      })
    })
  },
  [129152] = {
    ID = 129152,
    CnID = "共鸣@疾驰的欢愉专列_共鸣7",
    BaseSortID = 244,
    data_list = readonly({
      readonly({
        BaseSortID = 244,
        Level = 1,
        Name = "Resonance_129152_Name_1|萝坦与野兽",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_021.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_021.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_021.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {129149},
        UnlockCommon = 1,
        Consume = 1,
        AddAttrsTarget = 2,
        AwakerAttrs = readonly({
          atk = 25,
          def = 25,
          physique = 25
        }),
        Desc = "Resonance_129152_Desc_1|伤害型唤醒体体质、攻击、防御+25%。",
        Story = "Resonance_129152_Story_1|野兽一见到萝坦的模样，就忍不住浑身打战。\n尤其是她身后还有一千七百四十具野兽尸体的时候。\n「哦~可怜的家伙，恐怕要被真正的野兽撕碎了。」\n「嗯……被撕碎前来笑一个？不然拍出来的照片不好看啊。」"
      })
    })
  },
  [129145] = {
    ID = 129145,
    CnID = "共鸣@疾驰的欢愉专列_共鸣8",
    BaseSortID = 245,
    data_list = readonly({
      readonly({
        BaseSortID = 245,
        Level = 1,
        Name = "Resonance_129145_Name_1|奥·吉诃德",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_053.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_053.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_053.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {129149},
        UnlockCommon = 1,
        Consume = 1,
        AddAttrsTarget = 3,
        AwakerAttrs = readonly({
          atk = 25,
          def = 25,
          physique = 25
        }),
        Desc = "Resonance_129145_Desc_1|防御型唤醒体体质、攻击、防御+25%。",
        Story = "Resonance_129145_Story_1|骑士冲向了风车，多么滑稽的场面。\n凡人嗤笑，凡人嘲讽，凡人挥洒恶毒的诅咒。\n骑士不怪他们，因为他们早已被蒙蔽了双眼。\n但是骑士看得到，看得到那流着脓毒的巨人。\n看啊！为了守护他宣誓效忠的主君，最后的骑士发起了英勇的冲锋！\n「到底是凡人将巨人视作风车，还是骑士把风车当做巨人？」\n「嘻嘻，谁知道呢？毕竟被风车吃掉的人，可不会出来说话~」"
      })
    })
  },
  [129160] = {
    ID = 129160,
    CnID = "共鸣@疾驰的欢愉专列_共鸣9",
    BaseSortID = 246,
    data_list = readonly({
      readonly({
        BaseSortID = 246,
        Level = 1,
        Name = "Resonance_129160_Name_1|一千零一个朵尔",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_042.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_042.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_042.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {
          129158,
          129152,
          129145
        },
        UnlockCommon = 1,
        Consume = 1,
        Desc = "Resonance_129160_Desc_1|第一阶开始随机获得的共鸣「善意的礼物」、「未完的蜡像」、「古怪脓疱」、「蜂蜜甜酒」将获得完全强化。",
        Story = "Resonance_129160_Story_1|这个故事在二百六十八天讲过了。——不笑朵尔。\n为什么我们要在这里给他讲故事？——捕鱼朵尔。\n而且这里时间和逻辑都不正常，怎么想我都不会复制一千个自己。——智者朵尔。\n没有原因，因为他就是想看看一千个我们聚在一起会发生什么。——本体朵尔。\n朵尔叹了口气，平静地打开画有蜡笔画的故事书。\n「接下来是最后一个故事——《守密人与五十三唤醒体》。」"
      }),
      readonly({
        Level = 2,
        Name = "Resonance_129160_Name_2|一千零一个朵尔",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_042.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_042.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_042.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {
          129158,
          129152,
          129145
        },
        UnlockCommon = 1,
        Consume = 1,
        Desc = "Resonance_129160_Desc_2|第二阶开始随机获得的共鸣「代行者的同行」、「纯白之帆」、「浓醇的酒浆」、「开学典礼」将获得完全强化。"
      }),
      readonly({
        Level = 3,
        Name = "Resonance_129160_Name_3|一千零一个朵尔",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_042.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_042.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_042.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {
          129158,
          129152,
          129145
        },
        UnlockCommon = 1,
        Consume = 1,
        Desc = "Resonance_129160_Desc_3|第三阶开始随机获得的共鸣「备用脑缸」、「生命仪式」、「宾客权利」、「墨菲的幻影」将获得完全强化。"
      })
    })
  },
  [129154] = {
    ID = 129154,
    CnID = "共鸣@疾驰的欢愉专列_共鸣10",
    BaseSortID = 247,
    data_list = readonly({
      readonly({
        BaseSortID = 247,
        Level = 1,
        Name = "Resonance_129154_Name_1|大莉莉和小猎犬",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_057.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_057.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_057.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {129160},
        UnlockCommon = 1,
        Consume = 1,
        AddAttrsTarget = 5,
        AwakerAttrs = readonly({
          atk = 25,
          def = 25,
          physique = 25
        }),
        Desc = "Resonance_129154_Desc_1|混沌唤醒体体质、攻击、防御+25%。",
        Story = "Resonance_129154_Story_1|莉莉的家在拉伊疗养院，是家里的独生女。\n有一天，莉莉跟妈妈走失了，在次元裂隙里昏昏沉沉地睡了过去。\n醒来时，莉莉惊奇地发现，那是一个身高不足6英寸的小猎犬。\n「坏猎犬，打死！」\n「《莉莉游记》：初入小猎犬国，完结！」"
      })
    })
  },
  [129155] = {
    ID = 129155,
    CnID = "共鸣@疾驰的欢愉专列_共鸣11",
    BaseSortID = 248,
    data_list = readonly({
      readonly({
        BaseSortID = 248,
        Level = 1,
        Name = "Resonance_129155_Name_1|图鲁在睡觉",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_059.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_059.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_059.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {129160},
        UnlockCommon = 1,
        Consume = 1,
        AddAttrsTarget = 6,
        AwakerAttrs = readonly({
          atk = 25,
          def = 25,
          physique = 25
        }),
        Desc = "Resonance_129155_Desc_1|深海唤醒体体质、攻击、防御+25%。",
        Story = "Resonance_129155_Story_1|现在，有一座美丽的神殿，神殿里住着沉睡的神明。\n神殿周围缠绕着无数触手，只有最虔诚的祭司能破开触手，达到神殿最深处。\n哦？我们来自深海的祭司冲上了赛道，她带来了刚才击败的怪物掉落的云云毛绒枕！\n「那么，她会是唤醒祂的……这触手是哪来的？」\n「周围怎么变了？什么叫……我已在图鲁梦中？？」"
      })
    })
  },
  [129157] = {
    ID = 129157,
    CnID = "共鸣@疾驰的欢愉专列_共鸣12",
    BaseSortID = 249,
    data_list = readonly({
      readonly({
        BaseSortID = 249,
        Level = 1,
        Name = "Resonance_129157_Name_1|丰穰公主",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_056.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_056.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_056.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {129160},
        UnlockCommon = 1,
        Consume = 1,
        AddAttrsTarget = 7,
        AwakerAttrs = readonly({
          atk = 25,
          def = 25,
          physique = 25
        }),
        Desc = "Resonance_129157_Desc_1|血肉唤醒体体质、攻击、防御+25%。",
        Story = "Resonance_129157_Story_1|她的肌肤如蜜般甜腻；她的嘴唇如血般艳丽；她的头发如雪般洁白。\n看，她麾下七万个骁勇善战的大高人，正在痛打阻拦她的小树苗回家的家伙。\n「哎，哎？他们怎么冲我来了？泰旖丝！救命啊！」"
      })
    })
  },
  [129146] = {
    ID = 129146,
    CnID = "共鸣@疾驰的欢愉专列_共鸣13",
    BaseSortID = 250,
    data_list = readonly({
      readonly({
        BaseSortID = 250,
        Level = 1,
        Name = "Resonance_129146_Name_1|花衣詹金",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_058.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_058.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_058.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {129160},
        UnlockCommon = 1,
        Consume = 1,
        AddAttrsTarget = 8,
        AwakerAttrs = readonly({
          atk = 25,
          def = 25,
          physique = 25
        }),
        Desc = "Resonance_129146_Desc_1|超维唤醒体体质、攻击、防御+25%。",
        Story = "Resonance_129146_Story_1|很久很久以前，在没有烟雾的伦蒂尼恩，人们过着安宁又富足的生活。\n直到一位身着花衣的孩子，她用长长的笛子，召唤了持续300年的梦魇。\n「叽里咕噜说什么呢，这玩意真有用么？」\n身着花衣的詹金怀疑地看着手中长长的笛子，不明所以地摆弄着。\n「当然，只要放在嘴边，它就会自动发出声音。」\n「……信你一回。」\n…………\n笛声悠扬，怪物汇聚在五彩花衣身后，不通乐律的吹笛人带领他们横跨深海，穿越维度，来到欢愉之前。\n当最后一只怪物消失时，笛声才随之停止。"
      })
    })
  },
  [129159] = {
    ID = 129159,
    CnID = "共鸣@疾驰的欢愉专列_共鸣14",
    BaseSortID = 251,
    data_list = readonly({
      readonly({
        BaseSortID = 251,
        Level = 1,
        Name = "Resonance_129159_Name_1|真理开门",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_041.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_041.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_041.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {
          129154,
          129155,
          129157,
          129146
        },
        UnlockCommon = 1,
        Consume = 1,
        State1 = {129299},
        StateTarget1 = "PlayerRole",
        StatePara1 = {100},
        Desc = "Resonance_129159_Desc_1|探索开始时，灵识与物象研究深度+100%。",
        Story = "Resonance_129159_Story_1|这扇门后藏着最终的禁忌，不应被任何人窥视。\n但是守密人的话……\n\n银白的守护者看了下四周，把门推开一条缝，殊不知……\n\n「无声相机，记录所有的偷拍时刻。」\n「嘘——别告诉她我拍下来了。」"
      })
    })
  },
  [129151] = {
    ID = 129151,
    CnID = "共鸣@疾驰的欢愉专列_共鸣15",
    BaseSortID = 252,
    data_list = readonly({
      readonly({
        BaseSortID = 252,
        Level = 1,
        Name = "Resonance_129151_Name_1|绅士的沙龙",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_054.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_054.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_054.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {129159},
        UnlockCommon = 1,
        Consume = 1,
        AddAttrsTarget = 9,
        AwakerAttrs = readonly({
          atk = 25,
          def = 25,
          physique = 25
        }),
        Desc = "Resonance_129151_Desc_1|男性唤醒体体质、攻击、防御+25%。",
        Story = "Resonance_129151_Story_1|哦，各位绅士，欢迎来到我举办的沙龙。\n请穿好各位左手边的西装，戴上各位右手边的领带。\n在这里你可以畅所欲言，欢愉的沙龙从不限制来客。\n…………\n半小时后\n「该死，我就不该说那句话！现在，再加一条规则！」"
      })
    })
  },
  [129147] = {
    ID = 129147,
    CnID = "共鸣@疾驰的欢愉专列_共鸣16",
    BaseSortID = 253,
    data_list = readonly({
      readonly({
        BaseSortID = 253,
        Level = 1,
        Name = "Resonance_129147_Name_1|淑女的茶会",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_055.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_055.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_055.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {129159},
        UnlockCommon = 1,
        Consume = 1,
        AddAttrsTarget = 10,
        AwakerAttrs = readonly({
          atk = 25,
          def = 25,
          physique = 25
        }),
        Desc = "Resonance_129147_Desc_1|女性唤醒体体质、攻击、防御+25%。",
        Story = "Resonance_129147_Story_1|欢迎诸位参加本人举办的茶会，这里供应上好的甜品和红茶，以及超大落地窗给各位欣赏沿途的风景。\n我知道在座的有几位在我面前可能不是很淑女，虽然我跟他严格来说不是同一个体。\n但出于对贵宾心情以及本人安全的考虑，我已经提前溜到了一个安全的地方，绝对不会打扰到诸位。\n还望看在今天这个节日，以及诸位的好心情的份上，暂时放过我一马~\n若有茶会相关需求，您只需轻轻拍手，在下就会为您备好所需之物。\n——您鞠躬尽瘁的管家小N\n<Small:当然，还希望诸位允许我为这场难得的茶会拍照留影，以作纪念。>"
      })
    })
  },
  [129153] = {
    ID = 129153,
    CnID = "共鸣@疾驰的欢愉专列_共鸣17",
    BaseSortID = 254,
    data_list = readonly({
      readonly({
        BaseSortID = 254,
        Level = 1,
        Name = "Resonance_129153_Name_1|车轮滚滚向前",
        IsDefaultTalentNode = 0,
        Type = "elite",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_044.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_044.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_044.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {129151, 129147},
        UnlockCommon = 1,
        Consume = 1,
        State1 = {129296},
        StateTarget1 = "PlayerRole",
        StatePara1 = {5},
        Desc = "Resonance_129153_Desc_1|前 5 场战斗开始时使所有敌人生命变为 1。",
        Story = "Resonance_129153_Story_1|欢愉的车轮滚滚向前，把……\n「小N！车轮卡住了！」\n咳咳，也没说能滚多久嘛~"
      })
    })
  },
  [129156] = {
    ID = 129156,
    CnID = "共鸣@疾驰的欢愉专列_共鸣18",
    BaseSortID = 255,
    data_list = readonly({
      readonly({
        BaseSortID = 255,
        Level = 1,
        Name = "Resonance_129156_Name_1|「父神」的祝福",
        IsDefaultTalentNode = 0,
        Type = "normal",
        Icon = "Icon/Resonance/Icon_Resonance_Unlock_043.png",
        UnactIcon = "Icon/Resonance/Icon_Resonance_Unact_043.png",
        UnlockIcon = "Icon/Resonance/Icon_Resonance_lock_043.png",
        BelongGroup = "ResonanceGroupRailway",
        PreResonance = {129153},
        UnlockCommon = 1,
        Consume = 1,
        State1 = {129760},
        StateTarget1 = "PlayerRole",
        Desc = "Resonance_129156_Desc_1|探索开始时，获得 1 个随机受祝造物。",
        Story = "Resonance_129156_Story_1|「愿父神庇佑于你，苍白的使者。」\n「……愿父神庇佑于你！苍白的使者！」\n小N气急败坏地在桌子上学着萨尔瓦多的动作比划半天，但是什么都没有发生。\n「什么父神，这么不好使……」\n「算了，还是老样子吧。」\n小N跳下桌子，神秘一笑。\n「我要看乐子，欢愉的使者，给我打死他们。」\n漆黑的雾气弥漫包厢，每一缕都是来自祂的祝福。\n「搞来搞去，还是自己的名号好使。」"
      })
    })
  }
})
return Resonance
