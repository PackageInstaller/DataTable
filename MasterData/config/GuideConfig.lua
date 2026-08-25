local System = require("System.System")
local readonly = System.readonly
local GuideConfig = readonly({
  [1] = {
    ID = 1,
    data_list = readonly({
      readonly({
        CloseState = "GuideRoleMove",
        Stage = 7687,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuidePos = "0.5,0.2",
        Content = "GuideConfig_1_Content_1|守密人，现在可以向前探索。"
      })
    })
  },
  [2] = {
    ID = 2,
    data_list = readonly({
      readonly({
        Stage = 7687,
        Gear = 11442,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        IsFocus = true,
        GuideGameObj = "GuideGearItem",
        GuidePos = "0.5,0.2",
        Content = "GuideConfig_2_Content_1|是弥萨格的联络点，用银钥共鸣可以恢复生命，这正是我们需要的。"
      })
    })
  },
  [3] = {
    ID = 3,
    data_list = readonly({
      readonly({
        Stage = 7687,
        Gear = 12140,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        IsFocus = true,
        GuideGameObj = "GuideGearItem",
        GuidePos = "0.5,0.2",
        Content = "GuideConfig_3_Content_1|尽快击败<RedQuality:暴走的鲸跃>吧，我不想再目睹刚才那样的悲剧了。"
      })
    })
  },
  [4] = {
    ID = 4,
    data_list = readonly({
      readonly({
        Stage = 7687,
        Gear = 11396,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        IsFocus = true,
        GuideGameObj = "GuideGearItem",
        GuidePos = "0.5,0.2",
        Content = "GuideConfig_4_Content_1|黑印可以献祭给密境的<Yellow:融痕>，获得各类<Yellow:造物>，对战斗大有助益。"
      })
    })
  },
  [5] = {
    ID = 5,
    data_list = readonly({
      readonly({
        Stage = 7687,
        Gear = 11776,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        IsFocus = true,
        GuideGameObj = "GuideGearItem",
        GuidePos = "0.5,0.2",
        Content = "GuideConfig_5_Content_1|发现<Yellow:融痕>了，投入积攒的黑印吧。"
      })
    })
  },
  [6] = {
    ID = 6,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCloseShop",
        CloseState = "GuideTouchEvent",
        Stage = 7687,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        IsFocus = true,
        GuideGameObj = "UIRoot.UI_Dbgcopy_Panel_Main(Clone).UIDbgcopyItem_1",
        GuidePos = "0.5,0.2",
        Content = "GuideConfig_6_Content_1|这就是<Yellow:造物>，源自密境之物，你很快就能感知到它的力量。可惜，造物离开密境就会消散。"
      })
    })
  },
  [7] = {
    ID = 7,
    data_list = readonly({
      readonly({
        Stage = 7687,
        Gear = 12142,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        IsFocus = true,
        GuideGameObj = "GuideGearItem",
        GuidePos = "0.5,0.2",
        Content = "GuideConfig_7_Content_1|前方似乎有突发<Yellow:事件>，去看看吧。说不定能够获得意料之外的强化……虽然有时伴随着代价。"
      })
    })
  },
  [8] = {
    ID = 8,
    data_list = readonly({
      readonly({
        Stage = 7687,
        Gear = 12350,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuidePos = "0.5,0.2",
        Content = "GuideConfig_8_Content_1|前方似乎仍有敌人。"
      })
    })
  },
  [9] = {
    ID = 9,
    data_list = readonly({
      readonly({
        Stage = 7687,
        Gear = 11527,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        IsFocus = true,
        GuideGameObj = "GuideGearItem",
        GuidePos = "0.5,0.2",
        Content = "GuideConfig_9_Content_1|这是一个单向通道,应该通向地下大厅,走吧,完成我们的使命"
      })
    })
  },
  [10] = {
    ID = 10,
    data_list = readonly({
      readonly({
        CloseState = "GuideTouchEvent",
        Stage = 7687,
        Gear = 12136,
        GuideLayer = "NormalRoot",
        IsFocus = true,
        GuideGameObj = "GuideGearItem",
        GuidePos = "0.5,0.2",
        Content = "GuideConfig_10_Content_1|不远的前方，矗立着一个<RedQuality:银色六翼巨物>，散发出令人目眩的光辉"
      })
    })
  },
  [11] = {
    ID = 11,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCloseShop",
        CloseState = "GuideTouchEvent",
        Stage = 7687,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuidePos = "0.5,0.2",
        Content = "GuideConfig_11_Content_1|我们可以直面祂……或者清理完这里流窜的怪物，寻找联络点。到你做决定的时候了，守密人。"
      })
    })
  },
  [12] = {
    ID = 12,
    data_list = readonly({
      readonly({
        CloseState = "GuideBattleUseCard",
        StartAction = "GuideForbidBattleEnd",
        EndAction = "GuideResumeBattleEnd",
        CanRepeat = true,
        Stage = 7687,
        BoutIndex = 1,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuideGameObj = "UIRoot.UI_Battle_Panel_Dbg(Clone).Card_Content",
        GuidePos = "GO_UP",
        Content = "GuideConfig_12_Content_1|按住指令卡，向上拖动，即可发出指令"
      })
    })
  },
  [13] = {
    ID = 13,
    data_list = readonly({
      readonly({
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        Stage = 7687,
        BoutIndex = 2,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuideGameObj = "SceneRoot.UI_Battle_Item_Intention(Clone)",
        GuidePos = "GO_UP",
        Content = "GuideConfig_13_Content_1|敌人将要攻击造成致命伤害。输出防御指令吧，守密人！"
      })
    })
  },
  [14] = {
    ID = 14,
    data_list = readonly({
      readonly({
        CloseState = "GuideBattleUseCard",
        CanRepeat = true,
        Stage = 7687,
        BoutIndex = 3,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuideGameObj = "UIRoot.UI_Battle_Panel_Dbg(Clone).Card_Content",
        GuidePos = "GO_UP",
        Content = "GuideConfig_14_Content_1|反复释放女王之剑能使攻势变得迅猛。要试试用这一招终结对手吗？"
      })
    })
  },
  [15] = {
    ID = 15,
    data_list = readonly({
      readonly({
        CanRepeat = true,
        Stage = 7687,
        BoutIndex = 1,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuideGameObj = "UIRoot.UI_Battle_Panel_Dbg(Clone).Card_Content",
        GuidePos = "GO_UP",
        Content = "GuideConfig_15_Content_1|执行攻击指令会获得狂气，狂气充盈时即可释放强力的狂气爆发。"
      })
    })
  },
  [16] = {
    ID = 16,
    data_list = readonly({
      readonly({
        CanRepeat = true,
        BattleIndex = 8322,
        BoutIndex = 0,
        AvgDialog = 10139
      })
    })
  },
  [17] = {
    ID = 17,
    data_list = readonly({
      readonly({
        CanRepeat = true,
        BattleIndex = 8322,
        BoutIndex = 2,
        AvgDialog = 10120
      })
    })
  },
  [18] = {
    ID = 18,
    data_list = readonly({
      readonly({
        CanRepeat = true,
        BattleIndex = 8322,
        BoutIndex = 3,
        AvgDialog = 10138
      })
    })
  },
  [19] = {
    ID = 19,
    data_list = readonly({
      readonly({
        CanRepeat = true,
        BattleIndex = 8322,
        BoutIndex = 4,
        AvgDialog = 10122
      })
    })
  },
  [20] = {
    ID = 20,
    data_list = readonly({
      readonly({
        CloseState = "GuideAwakerUseSkill",
        StartAction = "GuideForbidBattleEnd",
        EndAction = "GuideResumeBattleEnd",
        CanRepeat = true,
        BattleIndex = 8320,
        BoutIndex = 1,
        AvgDialog = 10140
      })
    })
  },
  [22] = {
    ID = 22,
    data_list = readonly({
      readonly({
        CanRepeat = true,
        BattleIndex = 8320,
        BoutIndex = 4,
        AvgDialog = 10136
      })
    })
  },
  [23] = {
    ID = 23,
    data_list = readonly({
      readonly({
        CanRepeat = true,
        BattleIndex = 8320,
        BoutIndex = 5,
        AvgDialog = 10124
      })
    })
  },
  [29] = {
    ID = 29,
    data_list = readonly({
      readonly({
        Stage = 7998,
        GearDone = 12244,
        AvgDialog = 10121
      })
    })
  },
  [30] = {
    ID = 30,
    data_list = readonly({
      readonly({Stage = 7998, AvgDialog = 10129})
    })
  },
  [31] = {
    ID = 31,
    data_list = readonly({
      readonly({
        CanRepeat = true,
        BattleIndex = 8320,
        BoutIndex = 2
      })
    })
  },
  [32] = {
    ID = 32,
    data_list = readonly({
      readonly({
        CanRepeat = true,
        BattleIndex = 8321,
        BoutIndex = 2,
        AvgDialog = 10134
      })
    })
  },
  [33] = {
    ID = 33,
    data_list = readonly({
      readonly({
        CanRepeat = true,
        BattleIndex = 8321,
        BoutIndex = 1,
        AvgDialog = 10132
      })
    })
  },
  [34] = {
    ID = 34,
    data_list = readonly({
      readonly({
        TriggerState = "TurnLockCard",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        BattleIndex = 8322,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuideGameObj = "UIRoot.UI_Battle_Panel_Dbg(Clone).Group_Endofturn",
        GuidePos = "GO_UP",
        ShiftPos = {0, -30},
        Content = "GuideConfig_34_Content_1|当前处于战斗教学阶段，还有指令卡可打出。完成教学后可自由发挥。",
        DisappearTime = 3
      })
    })
  },
  [35] = {
    ID = 35,
    data_list = readonly({
      readonly({
        TriggerState = "TurnLockCard",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        BattleIndex = 8320,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuideGameObj = "UIRoot.UI_Battle_Panel_Dbg(Clone).Group_Endofturn",
        GuidePos = "GO_UP",
        ShiftPos = {0, -30},
        Content = "GuideConfig_35_Content_1|当前处于战斗教学阶段，还有指令卡可打出。完成教学后可自由发挥。",
        DisappearTime = 3
      })
    })
  },
  [36] = {
    ID = 36,
    data_list = readonly({
      readonly({
        TriggerState = "TurnLockCard",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        BattleIndex = 8321,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuideGameObj = "UIRoot.UI_Battle_Panel_Dbg(Clone).Group_Endofturn",
        GuidePos = "GO_UP",
        ShiftPos = {0, -30},
        Content = "GuideConfig_36_Content_1|当前处于战斗教学阶段，还有指令卡可打出。完成教学后可自由发挥。",
        DisappearTime = 3
      })
    })
  },
  [37] = {
    ID = 37,
    data_list = readonly({
      readonly({
        TriggerState = "TurnLockCard",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        BattleIndex = 8324,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuideGameObj = "UIRoot.UI_Battle_Panel_Dbg(Clone).Group_Endofturn",
        GuidePos = "GO_UP",
        ShiftPos = {0, -30},
        Content = "GuideConfig_37_Content_1|当前处于战斗教学阶段，还有指令卡可打出。完成教学后可自由发挥。",
        DisappearTime = 3
      })
    })
  },
  [38] = {
    ID = 38,
    data_list = readonly({
      readonly({
        TriggerState = "TurnLockExSkill",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        BattleIndex = 8322,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuideGameObj = "UIRoot.UI_Battle_Panel_Dbg(Clone).Group_Endofturn",
        GuidePos = "GO_UP",
        ShiftPos = {0, -30},
        Content = "GuideConfig_38_Content_1|当前处于战斗教学阶段，还有狂气爆发可使用。完成教学后可自由发挥。",
        DisappearTime = 3
      })
    })
  },
  [39] = {
    ID = 39,
    data_list = readonly({
      readonly({
        TriggerState = "TurnLockExSkill",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        BattleIndex = 8320,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuideGameObj = "UIRoot.UI_Battle_Panel_Dbg(Clone).Group_Endofturn",
        GuidePos = "GO_UP",
        ShiftPos = {0, -30},
        Content = "GuideConfig_39_Content_1|当前处于战斗教学阶段，还有狂气爆发可使用。完成教学后可自由发挥。",
        DisappearTime = 3
      })
    })
  },
  [40] = {
    ID = 40,
    data_list = readonly({
      readonly({
        TriggerState = "TurnLockExSkill",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        BattleIndex = 8321,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuideGameObj = "UIRoot.UI_Battle_Panel_Dbg(Clone).Group_Endofturn",
        GuidePos = "GO_UP",
        ShiftPos = {0, -30},
        Content = "GuideConfig_40_Content_1|当前处于战斗教学阶段，还有狂气爆发可使用。完成教学后可自由发挥。",
        DisappearTime = 3
      })
    })
  },
  [41] = {
    ID = 41,
    data_list = readonly({
      readonly({
        TriggerState = "TurnLockExSkill",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        BattleIndex = 8324,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuideGameObj = "UIRoot.UI_Battle_Panel_Dbg(Clone).Group_Endofturn",
        GuidePos = "GO_UP",
        ShiftPos = {0, -30},
        Content = "GuideConfig_41_Content_1|当前处于战斗教学阶段，还有狂气爆发可使用。完成教学后可自由发挥。",
        DisappearTime = 3
      })
    })
  },
  [42] = {
    ID = 42,
    data_list = readonly({
      readonly({
        TriggerState = "TurnLockPosse",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        BattleIndex = 8320,
        AwakerHead = 15595,
        GuideLayer = "NormalRoot",
        GuideGameObj = "UIRoot.UI_Battle_Panel_Dbg(Clone).Group_Endofturn",
        GuidePos = "GO_UP",
        ShiftPos = {0, -30},
        Content = "GuideConfig_42_Content_1|当前处于战斗教学阶段，还有钥令可使用。完成教学后可自由发挥。",
        DisappearTime = 3
      })
    })
  },
  [43] = {
    ID = 43,
    data_list = readonly({
      readonly({
        BattleIndex = 8541,
        BoutIndex = 1,
        AvgDialog = 80319
      })
    })
  },
  [47] = {
    ID = 47,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondBoutBegin",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        Stage = 90490,
        BattleIndex = 90496,
        BoutIndex = 1,
        GuideGameObj = "CommonillustratePanel",
        GuidePos = "0.5,0.2",
        TipsTitle = "GuideConfig_47_TipsTitle_1|混沌界域",
        Content = "GuideConfig_47_Content_1|混沌界域与银钥有强烈的共鸣，每回合能够获得 250 点银钥能量，帮助你更快速地释放钥令。若队伍中没有其他界域的唤醒体还会在进入关卡的时候获得一个白银造物，利用造物的帮助战胜敌人吧。",
        BattleOnlyOnce = 1
      })
    })
  },
  [48] = {
    ID = 48,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondBoutBegin",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        Stage = 90490,
        BattleIndex = 90496,
        BoutIndex = 2,
        AvgDialog = 96405,
        BattleOnlyOnce = 1
      })
    })
  },
  [49] = {
    ID = 49,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondBoutBegin",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        Stage = 94464,
        BattleIndex = 94484,
        BoutIndex = 1,
        GuideGameObj = "CommonillustratePanel",
        GuidePos = "0.5,0.2",
        TipsTitle = "GuideConfig_49_TipsTitle_1|深海界域",
        Content = "GuideConfig_49_Content_1|深海界域在战斗开始时会生成 1 条触腕，触腕在每个回合结束时会攻击前排敌人。深海唤醒体们能够为触腕提供各类增幅，可以通过触腕图标下方数值了解当前的触腕伤害。",
        BattleOnlyOnce = 1
      })
    })
  },
  [50] = {
    ID = 50,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondOceanHide",
        CanRepeat = true,
        Stage = 94464,
        BattleIndex = 94484,
        BoutIndex = 1,
        AvgDialog = 94645
      })
    })
  },
  [51] = {
    ID = 51,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondBoutBegin",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        Stage = 94464,
        BattleIndex = 94484,
        BoutIndex = 2,
        AvgDialog = 94643,
        BattleOnlyOnce = 1
      })
    })
  },
  [52] = {
    ID = 52,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondAvgEnd",
        CloseState = "GuideCondOceanModeSwitched",
        CanRepeat = true,
        Stage = 94464,
        BattleIndex = 94484,
        BoutIndex = 2,
        GuideGameObj = "GuideCompOceanModeSwtichToDefence",
        BattleOnlyOnce = 1
      })
    })
  },
  [53] = {
    ID = 53,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondBoutBegin",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        Stage = 94464,
        BattleIndex = 94484,
        BoutIndex = 3,
        AvgDialog = 94642,
        BattleOnlyOnce = 1
      })
    })
  },
  [54] = {
    ID = 54,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondAvgEnd",
        CloseState = "GuideCondOceanModeSwitched",
        CanRepeat = true,
        Stage = 94464,
        BattleIndex = 94484,
        BoutIndex = 3,
        GuideGameObj = "GuideCompOceanModeSwtichToFrantic",
        BattleOnlyOnce = 1
      })
    })
  },
  [55] = {
    ID = 55,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondBoutBegin",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        Stage = 94465,
        BattleIndex = 94483,
        BoutIndex = 1,
        GuideGameObj = "CommonillustratePanel",
        GuidePos = "0.5,0.2",
        TipsTitle = "GuideConfig_55_TipsTitle_1|血肉界域",
        Content = "GuideConfig_55_Content_1|血肉界域每回合都会积攒胚胎融合和猩红熔炉，生命越低积攒效率越高。胚胎融合度达到上限时会生成一张胚胎置入手牌中。胚胎能够直接使用，让对应唤醒体获得狂气和临时暴击率；也能够被血肉界域唤醒体通过狂气爆发吞噬，触发额外效果。",
        BattleOnlyOnce = 1
      })
    })
  },
  [56] = {
    ID = 56,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondillustratePanelClose",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        Stage = 94465,
        BattleIndex = 94483,
        BoutIndex = 1,
        AvgDialog = 94644,
        BattleOnlyOnce = 1
      })
    })
  },
  [57] = {
    ID = 57,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondAvgEnd",
        CloseState = "GuideCondBloodSchoolSkillUsed",
        CanRepeat = true,
        Stage = 94465,
        BattleIndex = 94483,
        BoutIndex = 1,
        GuideGameObj = "GuideCompBloodSchoolSkill",
        Content = "GuideConfig_57_Content_1|使用「猩红熔炉」回复生命来应对攻击吧！",
        BattleOnlyOnce = 1
      })
    })
  },
  [58] = {
    ID = 58,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondBoutBegin",
        CloseState = "GuideCondAfterUseUltiSkill",
        CanRepeat = true,
        Stage = 94465,
        BattleIndex = 94483,
        BoutIndex = 2,
        GuideGameObj = "GuideCompAwakerUltiSkill_1",
        Content = "GuideConfig_58_Content_1|血肉界域唤醒体释放狂气爆发时，可以吞噬手中的胚胎，强化狂气爆发效果。释放万古之眸，触发吞噬吧！",
        BattleOnlyOnce = 1
      })
    })
  },
  [60] = {
    ID = 60,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondBoutBegin",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        Stage = 94466,
        BattleIndex = 94482,
        BoutIndex = 1,
        GuideGameObj = "CommonillustratePanel",
        GuidePos = "0.5,0.2",
        TipsTitle = "GuideConfig_60_TipsTitle_1|超维界域",
        Content = "GuideConfig_60_Content_1|超维界域中，每回合打出的首张指令卡的临时复制会进入超维空间。当超维空间达到上限时，可以进入一个新回合。在新回合中不会抽牌而是将超维空间的卡牌置入手中。",
        BattleOnlyOnce = 1
      })
    })
  },
  [61] = {
    ID = 61,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondBoutBegin",
        CloseState = "GuideTouchEvent",
        CanRepeat = true,
        Stage = 94466,
        BattleIndex = 94482,
        BoutIndex = 2,
        AvgDialog = 94641,
        BattleOnlyOnce = 1
      })
    })
  },
  [62] = {
    ID = 62,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondAvgEnd",
        CloseState = "GuideCondDimensionSchoolSkillUsed",
        CanRepeat = true,
        Stage = 94466,
        BattleIndex = 94482,
        BoutIndex = 2,
        GuideGameObj = "GuideCompDimensionSchoolSkill",
        BattleOnlyOnce = 1
      })
    })
  },
  [63] = {
    ID = 63,
    data_list = readonly({
      readonly({
        TriggerState = "GuideCondBoutFirstCard",
        CloseState = "GuideBattleUseCard",
        CanRepeat = true,
        Stage = 94466,
        BattleIndex = 94482,
        BoutIndex = 3,
        AvgDialog = 94646,
        BattleOnlyOnce = 1
      })
    })
  }
})
return GuideConfig
