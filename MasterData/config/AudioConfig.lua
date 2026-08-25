local System = require("System.System")
local readonly = System.readonly
local AudioConfig = readonly({
  [15993] = {
    ID = 15993,
    CnID = "音频@获得金币",
    BaseSortID = 1,
    SoundId = "GAIN_GOLD",
    WwiseEvent = {
      "Play_Ui_Com_Get_Gold"
    }
  },
  [16250] = {
    ID = 16250,
    CnID = "音频@商店购买道具成功时",
    BaseSortID = 2,
    SoundId = "SHOP_BUY_ITEM",
    WwiseEvent = {
      "Play_Ui_Com_Buy_Something"
    }
  },
  [15984] = {
    ID = 15984,
    CnID = "音频@获得道具逐个",
    BaseSortID = 3,
    SoundId = "GAIN_ITEM_SINGLE",
    WwiseEvent = {
      "Play_Ui_Com_Get_Item"
    }
  },
  [16056] = {
    ID = 16056,
    CnID = "音频@获得道具批量",
    BaseSortID = 4,
    SoundId = "GAIN_ITEM_BATCH",
    WwiseEvent = {
      "Play_Ui_Com_Get_Many_Item"
    }
  },
  [16092] = {
    ID = 16092,
    CnID = "音频@唤醒体强化成功",
    BaseSortID = 5,
    SoundId = "AWAKER_ENHANCE",
    WwiseEvent = {
      "Play_UI_Com_Upgrade"
    }
  },
  [16123] = {
    ID = 16123,
    CnID = "音频@启灵进阶时播放",
    BaseSortID = 6,
    SoundId = "AWAKER_EVOVLE",
    WwiseEvent = {
      "Play_UI_Com_Big_Upgrade"
    }
  },
  [16019] = {
    ID = 16019,
    CnID = "音频@SSR音效",
    BaseSortID = 7,
    SoundId = "SSR",
    WwiseEvent = {
      "Play_UI_Com_Get_SSR"
    }
  },
  [15981] = {
    ID = 15981,
    CnID = "音频@R-SR音效",
    BaseSortID = 8,
    SoundId = "SR_OR_LESS",
    WwiseEvent = {
      "Play_UI_Com_Get_RandSR"
    }
  },
  [16033] = {
    ID = 16033,
    CnID = "音频@R音效",
    BaseSortID = 9,
    SoundId = "R_OR_LESS",
    WwiseEvent = {
      "Play_UI_Com_Get_R"
    }
  },
  [16141] = {
    ID = 16141,
    CnID = "音频@登录成功",
    BaseSortID = 10,
    SoundId = "LOGIN",
    WwiseEvent = {
      "Play_UI_Com_Start_Game"
    }
  },
  [16275] = {
    ID = 16275,
    CnID = "音频@战斗编队完成开始战斗",
    BaseSortID = 11,
    SoundId = "TEAM_START_FIGHT",
    WwiseEvent = {
      "Play_UI_Com_Start_Fight"
    }
  },
  [16038] = {
    ID = 16038,
    CnID = "音频@造物增加音效",
    BaseSortID = 12,
    SoundId = "INGAME_GET_RELIC",
    WwiseEvent = {
      "Play_SFX_UI_Addition_item"
    }
  },
  [16194] = {
    ID = 16194,
    CnID = "音频@获得黑印音效",
    BaseSortID = 13,
    SoundId = "INGAME_GET_COIN",
    WwiseEvent = {
      "Play_SFX_UI_Addition_Black_Coin"
    }
  },
  [16142] = {
    ID = 16142,
    CnID = "音频@压力提升音效",
    BaseSortID = 14,
    SoundId = "PRESSURE_UP",
    WwiseEvent = {
      "Play_SFX_UI_Pressure_State"
    }
  },
  [16137] = {
    ID = 16137,
    CnID = "音频@压力提升到最大音效",
    BaseSortID = 15,
    SoundId = "PRESSURE_UP_TO_MAX",
    WwiseEvent = {
      "Play_SFX_UI_Pressure_State_MAX"
    }
  },
  [16076] = {
    ID = 16076,
    CnID = "音频@卡牌刻印音效（普通）",
    BaseSortID = 16,
    SoundId = "CARD_ENCHANT_NORMAL",
    WwiseEvent = {
      "Play_SFX_UI_Enchant_General_Card"
    }
  },
  [16051] = {
    ID = 16051,
    CnID = "音频@卡牌刻印音效（高级）",
    BaseSortID = 17,
    SoundId = "CARD_ENCHANT_ADVANCED",
    WwiseEvent = {
      "Play_SFX_UI_Enchant_Advanced_Card"
    }
  },
  [16100] = {
    ID = 16100,
    CnID = "音频@卡牌刻印音效（腐化）",
    BaseSortID = 18,
    SoundId = "CARD_ENCHANT_DEBUFF",
    WwiseEvent = {
      "Play_SFX_UI_Enchant_Corrupt_Card"
    }
  },
  [16032] = {
    ID = 16032,
    CnID = "音频@卡牌移除成功音效",
    BaseSortID = 19,
    SoundId = "CARD_DELETED",
    WwiseEvent = {
      "Play_SFX_UI_Delete_Card"
    }
  },
  [16216] = {
    ID = 16216,
    CnID = "音频@唤醒体觉醒成功音效",
    BaseSortID = 20,
    SoundId = "INGAME_AWAKER_AWAKEN",
    WwiseEvent = {
      "Play_SFX_UI_Exalt_Card"
    }
  },
  [16144] = {
    ID = 16144,
    CnID = "音频@卡牌封印成功音效",
    BaseSortID = 21,
    SoundId = "INGAME_CARD_SEALED",
    WwiseEvent = {
      "Play_SFX_UI_Seal_Card"
    }
  },
  [16280] = {
    ID = 16280,
    CnID = "音频@获得物品音效",
    BaseSortID = 22,
    SoundId = "INGAME_GET_ITEM",
    WwiseEvent = {
      "Play_SFX_UI_Get_Addition_item"
    }
  },
  [16112] = {
    ID = 16112,
    CnID = "音频@获得症状卡音效",
    BaseSortID = 23,
    SoundId = "INGAME_GET_CARD_CURSED",
    WwiseEvent = {
      "Play_SFX_UI_Get_Curse_Card"
    }
  },
  [16205] = {
    ID = 16205,
    CnID = "音频@获得卡牌音效",
    BaseSortID = 24,
    SoundId = "INGAME_GET_CARD",
    WwiseEvent = {
      "Play_SFX_UI_Get_Card_OUT"
    }
  },
  [16054] = {
    ID = 16054,
    CnID = "音频@探索回血音效",
    BaseSortID = 25,
    SoundId = "EXPLORE_HEAL",
    WwiseEvent = {
      "Play_SFX_UI_Increased_BloodVolume"
    }
  },
  [16099] = {
    ID = 16099,
    CnID = "音频@探索掉血音效",
    BaseSortID = 26,
    SoundId = "EXPLORE_HURT",
    WwiseEvent = {
      "Play_SFX_UI_Decreased_BloodVolume"
    }
  },
  [16246] = {
    ID = 16246,
    CnID = "音频@序章新手引导对话框音效",
    BaseSortID = 27,
    SoundId = "UI_NPC_GUIDE",
    WwiseEvent = {
      "Play_SFX_UI_The_NPC_VO"
    }
  },
  [16065] = {
    ID = 16065,
    CnID = "音频@非抽卡获得人物音效",
    BaseSortID = 28,
    SoundId = "EXPLORE_CHR_GET",
    WwiseEvent = {
      "Play_SFX_UI_Awaker_Get_Friends"
    }
  },
  [16315] = {
    ID = 16315,
    CnID = "音频@敌方通用buff音效",
    BaseSortID = 29,
    SoundId = "SFX_FT_BUFF_CM_EN",
    WwiseEvent = {
      "Play_SFX_Ft_Buff_Cm_En"
    }
  },
  [16220] = {
    ID = 16220,
    CnID = "音频@敌方通用debuff音效",
    BaseSortID = 30,
    SoundId = "SFX_FT_DEBUFF_CM_EN",
    WwiseEvent = {
      "Play_SFX_Ft_Debuff_Cm_En"
    }
  },
  [16289] = {
    ID = 16289,
    CnID = "音频@敌方回血音效",
    BaseSortID = 31,
    SoundId = "SFX_FT_HEALING_EN",
    WwiseEvent = {
      "Play_SFX_Ft_Healing_En"
    }
  },
  [16317] = {
    ID = 16317,
    CnID = "音频@敌方中毒音效",
    BaseSortID = 32,
    SoundId = "SFX_FT_DEBUFF_POISON_EN",
    WwiseEvent = {
      "Play_SFX_Ft_Debuff_Poison_En"
    }
  },
  [15977] = {
    ID = 15977,
    CnID = "音频@敌方中毒受伤音效",
    BaseSortID = 33,
    SoundId = "SFX_FT_HURT_POISON_EN",
    WwiseEvent = {
      "Play_SFX_Ft_Hurt_Poison_En"
    }
  },
  [16164] = {
    ID = 16164,
    CnID = "音频@敌方反击buff音效",
    BaseSortID = 34,
    SoundId = "SFX_FT_BUFF_COUNTER_EN",
    WwiseEvent = {
      "Play_SFX_Ft_Buff_Counter_En"
    }
  },
  [15979] = {
    ID = 15979,
    CnID = "音频@敌方反击受伤音效",
    BaseSortID = 35,
    SoundId = "SFX_FT_HURT_COUNTER_EN",
    WwiseEvent = {
      "Play_SFX_Ft_Hurt_Counter_En"
    }
  },
  [16111] = {
    ID = 16111,
    CnID = "音频@己方通用buff音效",
    BaseSortID = 36,
    SoundId = "SFX_FT_BUFF_CM_PLAYER",
    WwiseEvent = {
      "Play_SFX_Ft_Buff_Cm_Player"
    }
  },
  [16160] = {
    ID = 16160,
    CnID = "音频@己方通用debuff音效",
    BaseSortID = 37,
    SoundId = "SFX_FT_DEBUFF_CM_PLAYER",
    WwiseEvent = {
      "Play_SFX_Ft_Debuff_Cm_Player"
    }
  },
  [16322] = {
    ID = 16322,
    CnID = "音频@己方回血音效",
    BaseSortID = 38,
    SoundId = "SFX_FT_HEALING_PLAYER",
    WwiseEvent = {
      "Play_SFX_Ft_Healing_Player"
    }
  },
  [16091] = {
    ID = 16091,
    CnID = "音频@己方中毒音效",
    BaseSortID = 39,
    SoundId = "SFX_FT_DEBUFF_POISON_PLAYER",
    WwiseEvent = {
      "Play_SFX_Ft_Debuff_Poison_Player"
    }
  },
  [16209] = {
    ID = 16209,
    CnID = "音频@己方中毒受伤音效",
    BaseSortID = 40,
    SoundId = "SFX_FT_HURT_POISON_PLAYER",
    WwiseEvent = {
      "Play_SFX_Ft_Hurt_Poison_Player"
    }
  },
  [16001] = {
    ID = 16001,
    CnID = "音频@己方反击buff音效",
    BaseSortID = 41,
    SoundId = "SFX_FT_BUFF_COUNTER_PLAYER",
    WwiseEvent = {
      "Play_SFX_Ft_Buff_Counter_Player"
    }
  },
  [16135] = {
    ID = 16135,
    CnID = "音频@己方反击受伤音效",
    BaseSortID = 42,
    SoundId = "SFX_FT_HURT_COUNTER_PLAYER",
    WwiseEvent = {
      "Play_SFX_Ft_Hurt_Counter_Player"
    }
  },
  [16311] = {
    ID = 16311,
    CnID = "音频@血肉界限-胚胎融合度槽上升",
    BaseSortID = 43,
    SoundId = "SFX_REALM_B_BLOOD_FILL",
    WwiseEvent = {
      "Play_SFX_Realm_B_Blood_Gen"
    }
  },
  [16284] = {
    ID = 16284,
    CnID = "音频@血肉界限-胚胎融合度槽上升停止",
    BaseSortID = 44,
    SoundId = "SFX_REALM_B_BLOOD_FILLEND",
    WwiseEvent = {
      "Play_SFX_Realm_B_Blood_Gen"
    }
  },
  [16128] = {
    ID = 16128,
    CnID = "音频@血肉界限-吞噬胚胎",
    BaseSortID = 45,
    SoundId = "SFX_REALM_B_EMBRYO_CONSUME",
    WwiseEvent = {
      "Play_SFX_Realm_B_Embryo_Consume"
    }
  },
  [15978] = {
    ID = 15978,
    CnID = "音频@血肉界限-生成胚胎",
    BaseSortID = 46,
    SoundId = "SFX_REALM_B_EMBRYO_GEN",
    WwiseEvent = {
      "Play_SFX_Realm_B_Embryo_Gen"
    }
  },
  [16277] = {
    ID = 16277,
    CnID = "音频@超维界限-超维卡槽填充",
    BaseSortID = 47,
    SoundId = "SFX_REALM_D_SLOT_FILL",
    WwiseEvent = {
      "Play_SFX_Realm_D_Slot_Fill"
    }
  },
  [15992] = {
    ID = 15992,
    CnID = "音频@超维界限-超维卡槽充满",
    BaseSortID = 48,
    SoundId = "SFX_REALM_D_SLOT_MAX",
    WwiseEvent = {
      "Play_SFX_Realm_D_Slot_Max"
    }
  },
  [16007] = {
    ID = 16007,
    CnID = "音频@超维界限-超维空间开启",
    BaseSortID = 49,
    SoundId = "SFX_REALM_D_SPACE_START",
    WwiseEvent = {
      "Play_SFX_Realm_D_Space_Start"
    }
  },
  [16261] = {
    ID = 16261,
    CnID = "音频@超维界限-超维空间结束",
    BaseSortID = 50,
    SoundId = "SFX_REALM_D_SPACE_END",
    WwiseEvent = {
      "Play_SFX_Realm_D_Space_End"
    }
  },
  [16072] = {
    ID = 16072,
    CnID = "音频@深海界限-触手攻击",
    BaseSortID = 51,
    SoundId = "SFX_REALM_O_TENTACLE_ATK",
    WwiseEvent = {
      "Play_SFX_Realm_O_Tentacle_Atk"
    }
  },
  [16147] = {
    ID = 16147,
    CnID = "音频@深海界限-生成触手",
    BaseSortID = 52,
    SoundId = "SFX_REALM_O_TENTACLE_GEN",
    WwiseEvent = {
      "Play_SFX_Realm_O_Tentacle_Gen"
    }
  },
  [16253] = {
    ID = 16253,
    CnID = "音频@深海界限-触手击中",
    BaseSortID = 53,
    SoundId = "SFX_REALM_O_TENTACLE_HIT",
    WwiseEvent = {
      "Play_SFX_Realm_O_Tentacle_Hit"
    }
  },
  [16328] = {
    ID = 16328,
    CnID = "音频@战斗开始精英来袭时音效",
    BaseSortID = 54,
    SoundId = "FIGHT_START_ELITE",
    WwiseEvent = {
      "Play_NTC_FightStart_Elite_BOSS",
      "Set_State_Aa_00None"
    }
  },
  [15991] = {
    ID = 15991,
    CnID = "音频@战斗开始时音效",
    BaseSortID = 55,
    SoundId = "FIGHT_START_CM",
    WwiseEvent = {
      "Play_NTC_FightStart_Nor",
      "Set_State_Aa_00None"
    }
  },
  [16057] = {
    ID = 16057,
    CnID = "音频@战斗UI我方行动弹出音效",
    BaseSortID = 56,
    SoundId = "Audio_UI_My_Round_Que",
    WwiseEvent = {
      "Play_NTC_RoundCue_Player"
    }
  },
  [16223] = {
    ID = 16223,
    CnID = "音频@战斗UI敌方行动弹出音效",
    BaseSortID = 57,
    SoundId = "Audio_UI_Enemy_Round_Que",
    WwiseEvent = {
      "Play_NTC_RoundCue_En"
    }
  },
  [16155] = {
    ID = 16155,
    CnID = "音频@战斗胜利音乐",
    BaseSortID = 58,
    SoundId = "FIGHT_WIN_MUSIC",
    WwiseEvent = {
      "Play_NTC_Ft_FightWin"
    }
  },
  [16097] = {
    ID = 16097,
    CnID = "音频@唤醒体狂气充满提示音效",
    BaseSortID = 59,
    SoundId = "FIGHT_EXSKILL_MAX_NOTICE",
    WwiseEvent = {
      "Play_NTC_Ft_Exskill_Max"
    }
  },
  [16257] = {
    ID = 16257,
    CnID = "音频@战斗-造物升级提示音效",
    BaseSortID = 60,
    SoundId = "NTC_FT_RELIC_LVLUP",
    WwiseEvent = {
      "Play_NTC_Ft_Relic_Lvlup"
    }
  },
  [16249] = {
    ID = 16249,
    CnID = "音频@战斗-通用信息弹窗",
    BaseSortID = 61,
    SoundId = "POPUP_CM_WND_INFO_ON",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Info_On"
    }
  },
  [16084] = {
    ID = 16084,
    CnID = "音频@战斗-点击唤醒体头像按钮",
    BaseSortID = 62,
    SoundId = "UI_FT_BTN_AWAKEREXSKILL_CLICK",
    WwiseEvent = {
      "Play_UI_Ft_Btn_AwakerExskill_Click"
    }
  },
  [16184] = {
    ID = 16184,
    CnID = "音频@战斗-通用点击",
    BaseSortID = 63,
    SoundId = "UI_FT_BTN_CLICK_BASIC",
    WwiseEvent = {
      "Play_UI_Ft_Btn_Click_Basic"
    }
  },
  [16161] = {
    ID = 16161,
    CnID = "音频@战斗-大招释放确认",
    BaseSortID = 64,
    SoundId = "UI_FT_BTN_EXSKILLCONFIRM_CLICK",
    WwiseEvent = {
      "Play_UI_Ft_Btn_ExskillConfirm_Click"
    }
  },
  [54702] = {
    ID = 54702,
    CnID = "音频@战斗-超限大招释放确认",
    BaseSortID = 65,
    SoundId = "UI_FT_BTN_SUPEXSKILLCONFIRM_CLICK",
    WwiseEvent = {
      "Play_UI_Ft_Btn_SuperExSkillConfirm_Click"
    }
  },
  [16240] = {
    ID = 16240,
    CnID = "音频@战斗-点击造物",
    BaseSortID = 66,
    SoundId = "UI_FT_BTN_RELIC_CLICK",
    WwiseEvent = {
      "Play_UI_Ft_Btn_Relic_Click"
    }
  },
  [16177] = {
    ID = 16177,
    CnID = "音频@战斗-点击结束回合按钮",
    BaseSortID = 67,
    SoundId = "UI_FT_BTN_ROUNDEND_CLICK",
    WwiseEvent = {
      "Play_UI_Ft_Btn_Roundend_Click"
    }
  },
  [16006] = {
    ID = 16006,
    CnID = "音频@战斗-获得卡牌",
    BaseSortID = 68,
    SoundId = "UI_POKER_GETCARD",
    WwiseEvent = {
      "Play_UI_Poker_Getcard"
    }
  },
  [16104] = {
    ID = 16104,
    CnID = "音频@战斗-回合结束弃牌音效",
    BaseSortID = 69,
    SoundId = "UI_POKER_ROUNDEND",
    WwiseEvent = {
      "Play_UI_Poker_Roundend"
    }
  },
  [15983] = {
    ID = 15983,
    CnID = "音频@战斗-回合开始发牌音效",
    BaseSortID = 70,
    SoundId = "UI_POKER_ROUNDSTART",
    WwiseEvent = {
      "Play_UI_Poker_Roundstart"
    }
  },
  [16073] = {
    ID = 16073,
    CnID = "音频@卡牌刻印音效（幸运）",
    BaseSortID = 71,
    SoundId = "CARD_ENCHANT_LUCKY",
    WwiseEvent = {
      "Play_SFX_UI_Enchant_Lucky_Card"
    }
  },
  [16234] = {
    ID = 16234,
    CnID = "音频@序章新手引导动画音效",
    BaseSortID = 72,
    SoundId = "UI_ANIM_GUIDE"
  },
  [16022] = {
    ID = 16022,
    CnID = "音频@探索-氛围风音效",
    BaseSortID = 73,
    SoundId = "EXPLORE_AMB_WIND",
    WwiseEvent = {
      "Play_Explore_Amb_Wind"
    }
  },
  [16187] = {
    ID = 16187,
    CnID = "音频@探索-氛围风音效-停止",
    BaseSortID = 74,
    SoundId = "EXPLORE_AMB_WIND_STOP",
    WwiseEvent = {
      "Stop_Explore_Amb_Wind"
    }
  },
  [16239] = {
    ID = 16239,
    CnID = "音频@探索-氛围雨音效",
    BaseSortID = 75,
    SoundId = "EXPLORE_AMB_RAIN",
    WwiseEvent = {
      "Play_Explore_Amb_Wind"
    }
  },
  [15969] = {
    ID = 15969,
    CnID = "音频@探索-氛围雨音效-停止",
    BaseSortID = 76,
    SoundId = "EXPLORE_AMB_RAIN_STOP",
    WwiseEvent = {
      "Stop_Explore_Amb_Wind"
    }
  },
  [16075] = {
    ID = 16075,
    CnID = "音频@探索-氛围霜音效",
    BaseSortID = 77,
    SoundId = "EXPLORE_AMB_FROST",
    WwiseEvent = {
      "Play_Explore_Amb_Rain"
    }
  },
  [16049] = {
    ID = 16049,
    CnID = "音频@探索-氛围霜音效-停止",
    BaseSortID = 78,
    SoundId = "EXPLORE_AMB_FROST_STOP",
    WwiseEvent = {
      "Stop_Explore_Amb_Rain"
    }
  },
  [16066] = {
    ID = 16066,
    CnID = "音频@探索-氛围雪音效",
    BaseSortID = 79,
    SoundId = "EXPLORE_AMB_SNOW",
    WwiseEvent = {
      "Play_Explore_Amb_Wind"
    }
  },
  [16068] = {
    ID = 16068,
    CnID = "音频@探索-氛围雪音效-停止",
    BaseSortID = 80,
    SoundId = "EXPLORE_AMB_SNOW_STOP",
    WwiseEvent = {
      "Stop_Explore_Amb_Wind"
    }
  },
  [16043] = {
    ID = 16043,
    CnID = "音频@探索-格子陷落",
    BaseSortID = 81,
    SoundId = "EXPLORE_BLOCK_FALL",
    WwiseEvent = {
      "Play_Explore_Block_Fall"
    }
  },
  [16195] = {
    ID = 16195,
    CnID = "音频@探索-烧红",
    BaseSortID = 82,
    SoundId = "EXPLORE_VFX_BURN",
    WwiseEvent = {
      "Play_Explore_Vfx_Burn"
    }
  },
  [16124] = {
    ID = 16124,
    CnID = "音频@探索-BOSS氛围",
    BaseSortID = 83,
    SoundId = "EXPLORE_BOSS",
    WwiseEvent = {
      "Play_Explore_Vfx_MistDispel"
    }
  },
  [16320] = {
    ID = 16320,
    CnID = "音频@探索-BOSS氛围-停止",
    BaseSortID = 84,
    SoundId = "EXPLORE_BOSS_STOP",
    WwiseEvent = {
      "Play_Explore_Vfx_MistDispel"
    }
  },
  [16059] = {
    ID = 16059,
    CnID = "音频@探索-迷雾驱散",
    BaseSortID = 85,
    SoundId = "EXPLORE_VFX_MISTDISPEL",
    WwiseEvent = {
      "Play_Explore_Vfx_MistDispel"
    }
  },
  [16326] = {
    ID = 16326,
    CnID = "音频@探索-毒地块-触发中毒",
    BaseSortID = 86,
    SoundId = "EXPLORE_BLOCK_POISON_HURT",
    WwiseEvent = {
      "Play_Explore_Block_Poison_Hurt"
    }
  },
  [15988] = {
    ID = 15988,
    CnID = "音频@探索-混沌地块-触发变化",
    BaseSortID = 87,
    SoundId = "EXPLORE_BLOCK_CHAOS_TRANSFORM",
    WwiseEvent = {
      "Play_Explore_Block_Chaos_Transform"
    }
  },
  [16244] = {
    ID = 16244,
    CnID = "音频@探索-联络处弹窗-弹出",
    BaseSortID = 88,
    SoundId = "EXPLORE_CONTACT_POP",
    WwiseEvent = {
      "Play_Explore_Contact_Pop"
    }
  },
  [16016] = {
    ID = 16016,
    CnID = "音频@探索-门扉弹窗-弹出",
    BaseSortID = 89,
    SoundId = "EXPLORE_DOORLOCK_POP",
    WwiseEvent = {
      "Play_Explore_DoorLock_Pop"
    }
  },
  [16213] = {
    ID = 16213,
    CnID = "音频@探索-驱雾结晶窗口-弹出",
    BaseSortID = 90,
    SoundId = "EXPLORE_FOGCRYSTAL_POP",
    WwiseEvent = {
      "Play_Explore_FogCrystal_Pop"
    }
  },
  [15980] = {
    ID = 15980,
    CnID = "音频@探索-商店弹窗-弹出",
    BaseSortID = 91,
    SoundId = "EXPLORE_SHOP_POP",
    WwiseEvent = {
      "Play_Explore_Shop_Pop"
    }
  },
  [16174] = {
    ID = 16174,
    CnID = "音频@探索-幻象弹窗-弹出",
    BaseSortID = 92,
    SoundId = "EXPLORE_PHANTOM_POP",
    WwiseEvent = {
      "Play_Explore_Phantom_Pop"
    }
  },
  [16081] = {
    ID = 16081,
    CnID = "音频@探索-隧道弹窗-弹出",
    BaseSortID = 93,
    SoundId = "EXPLORE_PASSAGE_POP",
    WwiseEvent = {
      "Play_Explore_Passage_Pop"
    }
  },
  [16288] = {
    ID = 16288,
    CnID = "音频@探索-单行密道（入口）弹窗-弹出",
    BaseSortID = 94,
    SoundId = "EXPLORE_SECRETAISLE_POP",
    WwiseEvent = {
      "Play_Explore_SecretAisle_Pop"
    }
  },
  [16260] = {
    ID = 16260,
    CnID = "音频@探索-单行密道（出口）弹窗-弹出",
    BaseSortID = 95,
    SoundId = "EXPLORE_SECRETAISLEOUT_POP",
    WwiseEvent = {
      "Play_Explore_SecretAisleOUT_Pop"
    }
  },
  [16222] = {
    ID = 16222,
    CnID = "音频@探索-牌堆窗口-弹出",
    BaseSortID = 96,
    SoundId = "EXPLORE_DECK_POP",
    WwiseEvent = {
      "Play_Explore_Deck_Pop"
    }
  },
  [16048] = {
    ID = 16048,
    CnID = "音频@探索-选中造物卡",
    BaseSortID = 97,
    SoundId = "EXPLORE_SELECTPROPS_POP",
    WwiseEvent = {
      "Play_Explore_SelectProps_Pop"
    }
  },
  [16120] = {
    ID = 16120,
    CnID = "音频@探索-选中卡牌",
    BaseSortID = 98,
    SoundId = "EXPLORE_SELECTCARD_POP",
    WwiseEvent = {
      "Play_Explore_SelectCard_Pop"
    }
  },
  [15982] = {
    ID = 15982,
    CnID = "音频@探索-门扉交互-玩家移动",
    BaseSortID = 99,
    SoundId = "EXPLORE_DOOR_PLAYERSEND",
    WwiseEvent = {
      "Play_Explore_Door_PlayerSend"
    }
  },
  [16202] = {
    ID = 16202,
    CnID = "音频@探索-弹窗-选项按钮-点击",
    BaseSortID = 100,
    SoundId = "EXPLORE_SELECT_BUTTON",
    WwiseEvent = {
      "Play_Explore_Select_Button"
    }
  },
  [16183] = {
    ID = 16183,
    CnID = "音频@探索-单行密道交互-玩家移动",
    BaseSortID = 101,
    SoundId = "EXPLORE_SECRETAISLE_PLAYERSEND",
    WwiseEvent = {
      "Play_Explore_SecretAisle_PlayerSend"
    }
  },
  [15976] = {
    ID = 15976,
    CnID = "音频@探索-隧道交互-玩家移动",
    BaseSortID = 102,
    SoundId = "EXPLORE_PASSAGE_PLAYERSEND",
    WwiseEvent = {
      "Play_Explore_Passage_PlayerSend"
    }
  },
  [16050] = {
    ID = 16050,
    CnID = "音频@探索-卡牌入库",
    BaseSortID = 103,
    SoundId = "EXPLORE_DECK_CARDENTRY",
    WwiseEvent = {
      "Play_Explore_Deck_CardEntry"
    }
  },
  [16012] = {
    ID = 16012,
    CnID = "音频@探索-获得银芯",
    BaseSortID = 104,
    SoundId = "EXPLORE_SILVERCORE_PLAYERGET",
    WwiseEvent = {
      "Play_Explore_SilverCore_PlayerGet"
    }
  },
  [16236] = {
    ID = 16236,
    CnID = "音频@探索-牌堆按钮-点击",
    BaseSortID = 105,
    SoundId = "EXPLORE_DECK_BUTTON",
    WwiseEvent = {
      "Play_Explore_Deck_Button"
    }
  },
  [16034] = {
    ID = 16034,
    CnID = "音频@探索-驱雾结晶互动-驱散",
    BaseSortID = 106,
    SoundId = "EXPLORE_FOGCRYSTAL_TAKEEFFECT",
    WwiseEvent = {
      "Play_Explore_FogCrystal_TakeEffect"
    }
  },
  [16268] = {
    ID = 16268,
    CnID = "音频@探索-获得共鸣之心",
    BaseSortID = 107,
    SoundId = "EXPLORE_RESONANCEHEART_PLAYERGET",
    WwiseEvent = {
      "Play_Explore_ResonanceHeart_PlayerGet"
    }
  },
  [16015] = {
    ID = 16015,
    CnID = "音频@探索-随机事件弹窗-弹出",
    BaseSortID = 108,
    SoundId = "EXPLORE_RANDOMEVENT_POP",
    WwiseEvent = {
      "Play_Explore_RandomEvent_Pop"
    }
  },
  [16082] = {
    ID = 16082,
    CnID = "音频@探索-营地-删除卡牌",
    BaseSortID = 109,
    SoundId = "PLAY_EXPLORE_CONTACT_DELETECARD",
    WwiseEvent = {
      "Play_Explore_Contact_DeleteCard"
    }
  },
  [16327] = {
    ID = 16327,
    CnID = "音频@探索-（第一章）共鸣点弹窗-弹出",
    BaseSortID = 110,
    SoundId = "EXPLORE_RESONANCEEVENT_POP_C01",
    WwiseEvent = {
      "Play_Explore_ResonanceEvent_Pop_C01"
    }
  },
  [16169] = {
    ID = 16169,
    CnID = "音频@探索-（第二章）共鸣点弹窗-弹出",
    BaseSortID = 111,
    SoundId = "EXPLORE_RESONANCEEVENT_POP_C02",
    WwiseEvent = {
      "Play_Explore_ResonanceEvent_Pop_C02"
    }
  },
  [15961] = {
    ID = 15961,
    CnID = "音频@探索-（第三章）共鸣点弹窗-弹出",
    BaseSortID = 112,
    SoundId = "EXPLORE_RESONANCEEVENT_POP_C03",
    WwiseEvent = {
      "Play_Explore_ResonanceEvent_Pop_C03"
    }
  },
  [16307] = {
    ID = 16307,
    CnID = "音频@探索-（第四章）共鸣点弹窗-弹出",
    BaseSortID = 113,
    SoundId = "EXPLORE_RESONANCEEVENT_POP_C04",
    WwiseEvent = {
      "Play_Explore_ResonanceEvent_Pop_C04"
    }
  },
  [16129] = {
    ID = 16129,
    CnID = "音频@探索-（第五章）共鸣点弹窗-弹出",
    BaseSortID = 114,
    SoundId = "EXPLORE_RESONANCEEVENT_POP_C05",
    WwiseEvent = {
      "Play_Explore_ResonanceEvent_Pop_C05"
    }
  },
  [16190] = {
    ID = 16190,
    CnID = "音频@探索-（第六章）共鸣点弹窗-弹出",
    BaseSortID = 115,
    SoundId = "EXPLORE_RESONANCEEVENT_POP_C06",
    WwiseEvent = {
      "Play_Explore_ResonanceEvent_Pop_C06"
    }
  },
  [16266] = {
    ID = 16266,
    CnID = "音频@探索-（第七章）共鸣点弹窗-弹出",
    BaseSortID = 116,
    SoundId = "EXPLORE_RESONANCEEVENT_POP_C07",
    WwiseEvent = {
      "Play_Explore_ResonanceEvent_Pop_C07"
    }
  },
  [16218] = {
    ID = 16218,
    CnID = "音频@探索-（第八章）共鸣点弹窗-弹出",
    BaseSortID = 117,
    SoundId = "EXPLORE_RESONANCEEVENT_POP_C08",
    WwiseEvent = {
      "Play_Explore_ResonanceEvent_Pop_C08"
    }
  },
  [16002] = {
    ID = 16002,
    CnID = "音频@探索-（第九章）共鸣点弹窗-弹出",
    BaseSortID = 118,
    SoundId = "EXPLORE_RESONANCEEVENT_POP_C09",
    WwiseEvent = {
      "Play_Explore_ResonanceEvent_Pop_C09"
    }
  },
  [16285] = {
    ID = 16285,
    CnID = "音频@探索-（第十章）共鸣点弹窗-弹出",
    BaseSortID = 119,
    SoundId = "EXPLORE_RESONANCEEVENT_POP_C10",
    WwiseEvent = {
      "Play_Explore_ResonanceEvent_Pop_C10"
    }
  },
  [16186] = {
    ID = 16186,
    CnID = "音频@探索-设置窗口-弹出",
    BaseSortID = 120,
    SoundId = "UI_EXP_SETTINGMENU_ON",
    WwiseEvent = {
      "Play_UI_Exp_SettingMenu_On"
    }
  },
  [15967] = {
    ID = 15967,
    CnID = "音频@探索-设置窗口-收回",
    BaseSortID = 121,
    SoundId = "UI_EXP_SETTINGMENU_OFF",
    WwiseEvent = {
      "Play_UI_Exp_SettingMenu_Off"
    }
  },
  [16306] = {
    ID = 16306,
    CnID = "音频@探索-联络处点击冥想",
    BaseSortID = 122,
    SoundId = "UI_EXP_CONTACT_MEDIT_CLICK",
    WwiseEvent = {
      "UI_Exp_Contact_Medit_Click"
    }
  },
  [16079] = {
    ID = 16079,
    CnID = "音频@探索-钥匙弹窗",
    BaseSortID = 123,
    SoundId = "POPUP_EXP_KEY",
    WwiseEvent = {
      "Popup_Exp_Key"
    }
  },
  [16062] = {
    ID = 16062,
    CnID = "音频@探索-单行密道弹窗",
    BaseSortID = 124,
    SoundId = "POPUP_EXP_PASSAGE_ONEWAY",
    WwiseEvent = {
      "Popup_Exp_Passage_OneWay"
    }
  },
  [16199] = {
    ID = 16199,
    CnID = "音频@探索-单行密道进入",
    BaseSortID = 125,
    SoundId = "UI_EXP_PASSAGE_ONEWAY_IN",
    WwiseEvent = {
      "UI_Exp_Passage_OneWay_In"
    }
  },
  [16269] = {
    ID = 16269,
    CnID = "音频@探索-进入碎裂地块",
    BaseSortID = 126,
    SoundId = "SFX_EXP_BLOCK_CRACK_ENTER",
    WwiseEvent = {
      "Play_Explore_Block_Crack_Enter"
    }
  },
  [16014] = {
    ID = 16014,
    CnID = "音频@探索-地块碎裂",
    BaseSortID = 127,
    SoundId = "SFX_EXP_BLOCK_CRACK_LEAVE",
    WwiseEvent = {
      "Play_Explore_Block_Crack_Leave"
    }
  },
  [16010] = {
    ID = 16010,
    CnID = "音频@探索-事件弹窗（失魂暮气）",
    BaseSortID = 128,
    SoundId = "POPUP_EXP_EVENT_MIST",
    WwiseEvent = {
      "Popup_Exp_Event_Mist"
    }
  },
  [15999] = {
    ID = 15999,
    CnID = "音频@探索-点击穿过失魂暮气",
    BaseSortID = 129,
    SoundId = "UI_EXP_MIST_PASSTHROUGH",
    WwiseEvent = {
      "UI_Exp_Mist_PassThrough"
    }
  },
  [16134] = {
    ID = 16134,
    CnID = "音频@基础-空白点击",
    BaseSortID = 130,
    SoundId = "SFX_EMPTY_SOUND",
    WwiseEvent = {
      "Play_Sfx_Empty_Sound"
    }
  },
  [16312] = {
    ID = 16312,
    CnID = "音频@通用控件-基础点击",
    BaseSortID = 131,
    SoundId = "UI_CM_BTN_BASIC_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Basic_Click"
    }
  },
  [16267] = {
    ID = 16267,
    CnID = "音频@通用控件-一级按钮（确认）",
    BaseSortID = 132,
    SoundId = "UI_CM_BTN_LV1_ENTER",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Lv1_Enter"
    }
  },
  [16115] = {
    ID = 16115,
    CnID = "音频@通用控件-一级按钮（取消）",
    BaseSortID = 133,
    SoundId = "UI_CM_BTN_LV1_CANCEL",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Lv1_Cancel"
    }
  },
  [16232] = {
    ID = 16232,
    CnID = "音频@通用控件-特殊一级按钮（确认）",
    BaseSortID = 134,
    SoundId = "UI_CM_BTN_LV1SP_ENTER",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Lv1sp_Enter"
    }
  },
  [16290] = {
    ID = 16290,
    CnID = "音频@通用控件-特殊一级按钮（取消）",
    BaseSortID = 135,
    SoundId = "UI_CM_BTN_LV1SP_CANCEL",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Lv1sp_Cancel"
    }
  },
  [16278] = {
    ID = 16278,
    CnID = "音频@通用控件-二级按钮（确认）",
    BaseSortID = 136,
    SoundId = "UI_CM_BTN_LV2_ENTER",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Lv2_Enter"
    }
  },
  [16303] = {
    ID = 16303,
    CnID = "音频@通用控件-二级按钮（取消）",
    BaseSortID = 137,
    SoundId = "UI_CM_BTN_LV2_CANCEL",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Lv2_Cancel"
    }
  },
  [16026] = {
    ID = 16026,
    CnID = "音频@通用控件-三级按钮（确认）",
    BaseSortID = 138,
    SoundId = "UI_CM_BTN_LV3_ENTER",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Lv3_Enter"
    }
  },
  [16196] = {
    ID = 16196,
    CnID = "音频@通用控件-三级按钮（取消）",
    BaseSortID = 139,
    SoundId = "UI_CM_BTN_LV3_CANCEL",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Lv3_Cancel"
    }
  },
  [16298] = {
    ID = 16298,
    CnID = "音频@通用控件-收藏按钮（确认）",
    BaseSortID = 140,
    SoundId = "UI_CM_BTN_COLLECT_ENTER",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Collect_Enter"
    }
  },
  [16185] = {
    ID = 16185,
    CnID = "音频@通用控件-收藏按钮（取消）",
    BaseSortID = 141,
    SoundId = "UI_CM_BTN_COLLECT_CANCEL",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Collect_Cancel"
    }
  },
  [16282] = {
    ID = 16282,
    CnID = "音频@通用控件-页签按钮（点击）",
    BaseSortID = 142,
    SoundId = "UI_CM_BTN_TAB_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Tab_Click"
    }
  },
  [16020] = {
    ID = 16020,
    CnID = "音频@通用控件-滑动按钮（点击）",
    BaseSortID = 143,
    SoundId = "UI_CM_BTN_PAGES_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Pages_Click"
    }
  },
  [16125] = {
    ID = 16125,
    CnID = "音频@通用控件-详情按钮（点击）",
    BaseSortID = 144,
    SoundId = "UI_CM_BTN_DETAIL_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Detail_Click"
    }
  },
  [16301] = {
    ID = 16301,
    CnID = "音频@通用控件-异型按钮（点击）",
    BaseSortID = 145,
    SoundId = "UI_CM_BTN_SP1_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Sp1_Click"
    }
  },
  [16192] = {
    ID = 16192,
    CnID = "音频@通用控件-关闭按钮（点击）",
    BaseSortID = 146,
    SoundId = "UI_CM_BTN_TURNOFF_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Turnoff_Click"
    }
  },
  [16295] = {
    ID = 16295,
    CnID = "音频@通用控件-其他按钮（点击）",
    BaseSortID = 147,
    SoundId = "UI_CM_BTN_OTHER_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Other_Click"
    }
  },
  [16003] = {
    ID = 16003,
    CnID = "音频@通用控件-领取按钮（小）点击",
    BaseSortID = 148,
    SoundId = "UI_CM_BTN_RECEIVE_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Receive_Click"
    }
  },
  [16094] = {
    ID = 16094,
    CnID = "音频@通用控件-可手动操作的数量滑条（移动）",
    BaseSortID = 149,
    SoundId = "UI_CM_FADER_MOVE",
    WwiseEvent = {
      "Play_UI_Cm_Fader_Move"
    }
  },
  [16118] = {
    ID = 16118,
    CnID = "音频@通用控件-可手动操作的数量滑条（停止移动）",
    BaseSortID = 150,
    SoundId = "UI_CM_FADER_STOP",
    WwiseEvent = {
      "Play_UI_Cm_Fader_Stop"
    }
  },
  [16107] = {
    ID = 16107,
    CnID = "音频@通用控件-纯显示的数量滑条（移动）",
    BaseSortID = 151,
    SoundId = "UI_CM_PROGBAR_MOVE",
    WwiseEvent = {
      "Play_UI_Cm_Progbar_Move"
    }
  },
  [16291] = {
    ID = 16291,
    CnID = "音频@通用控件-纯显示的数量滑条（停止移动）",
    BaseSortID = 152,
    SoundId = "UI_CM_PROGBAR_STOP",
    WwiseEvent = {
      "Play_UI_Cm_Progbar_Stop"
    }
  },
  [16215] = {
    ID = 16215,
    CnID = "音频@通用控件-浅色选择框（点击）",
    BaseSortID = 153,
    SoundId = "UI_CM_SELECTBOX_LIGHT_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Selectbox_Light_Click"
    }
  },
  [16117] = {
    ID = 16117,
    CnID = "音频@通用控件-深色选择框（点击）",
    BaseSortID = 154,
    SoundId = "UI_CM_SELECTBOX_DARK_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Selectbox_Dark_Click"
    }
  },
  [16040] = {
    ID = 16040,
    CnID = "音频@通用控件-页签（选中）",
    BaseSortID = 155,
    SoundId = "UI_CM_TAB_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Tab_Click"
    }
  },
  [16302] = {
    ID = 16302,
    CnID = "音频@通用控件-登录按钮（点击）",
    BaseSortID = 156,
    SoundId = "UI_CM_BTN_LOADING_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Loading_Click"
    }
  },
  [16248] = {
    ID = 16248,
    CnID = "音频@通用控件-主界面按钮（点击）",
    BaseSortID = 157,
    SoundId = "UI_CM_BTN_MAININTERFACE_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Btn_MainInterface_Click"
    }
  },
  [16083] = {
    ID = 16083,
    CnID = "音频@通用控件-物品框（选中）",
    BaseSortID = 158,
    SoundId = "UI_CM_ITEMBOX_SELECT",
    WwiseEvent = {
      "Play_UI_Cm_Itembox_Select"
    }
  },
  [16093] = {
    ID = 16093,
    CnID = "音频@通用控件-确认框（勾选）",
    BaseSortID = 159,
    SoundId = "UI_CM_CONFIRMBOX_SELECT",
    WwiseEvent = {
      "Play_UI_Cm_Confirmbox_Select"
    }
  },
  [16200] = {
    ID = 16200,
    CnID = "音频@通用控件-添加按钮（点击）",
    BaseSortID = 160,
    SoundId = "UI_CM_BTN_ADD_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Add_Click"
    }
  },
  [16023] = {
    ID = 16023,
    CnID = "音频@通用控件-资源栏（点击）",
    BaseSortID = 161,
    SoundId = "UI_CM_BTN_MATERIALBAR_CLICK",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Materialbar_Click"
    }
  },
  [16105] = {
    ID = 16105,
    CnID = "音频@通用控件-勾选（选中）",
    BaseSortID = 162,
    SoundId = "UI_CM_CHECKBOX_SELECT",
    WwiseEvent = {
      "Play_UI_Cm_Checkbox_Select"
    }
  },
  [16241] = {
    ID = 16241,
    CnID = "音频@通用窗口-确认弹窗（大）-弹出",
    BaseSortID = 163,
    SoundId = "POPUP_CM_WND_CONFIRM_LV1_ON",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Confirm_Lv1_On"
    }
  },
  [16055] = {
    ID = 16055,
    CnID = "音频@通用窗口-确认弹窗（大）-关闭",
    BaseSortID = 164,
    SoundId = "POPUP_CM_WND_CONFIRM_LV1_OFF",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Confirm_Lv1_Off"
    }
  },
  [16270] = {
    ID = 16270,
    CnID = "音频@通用窗口-确认弹窗（中）-弹出",
    BaseSortID = 165,
    SoundId = "POPUP_CM_WND_CONFIRM_LV2_ON",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Confirm_Lv2_On"
    }
  },
  [16207] = {
    ID = 16207,
    CnID = "音频@通用窗口-确认弹窗（中）-关闭",
    BaseSortID = 166,
    SoundId = "POPUP_CM_WND_CONFIRM_LV2_OFF",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Confirm_Lv2_Off"
    }
  },
  [16191] = {
    ID = 16191,
    CnID = "音频@通用窗口-确认弹窗（小）-弹出",
    BaseSortID = 167,
    SoundId = "POPUP_CM_WND_CONFIRM_LV3_ON",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Confirm_Lv3_On"
    }
  },
  [16063] = {
    ID = 16063,
    CnID = "音频@通用窗口-确认弹窗（小）-关闭",
    BaseSortID = 168,
    SoundId = "POPUP_CM_WND_CONFIRM_LV3_OFF",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Confirm_Lv3_Off"
    }
  },
  [16151] = {
    ID = 16151,
    CnID = "音频@通用窗口-说明弹窗（小）-弹出",
    BaseSortID = 169,
    SoundId = "POPUP_CM_WND_INFO_LV1_ON",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Info_Lv1_On"
    }
  },
  [16150] = {
    ID = 16150,
    CnID = "音频@通用窗口-说明弹窗（小）-关闭",
    BaseSortID = 170,
    SoundId = "POPUP_CM_WND_INFO_LV1_OFF",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Info_Lv1_Off"
    }
  },
  [16103] = {
    ID = 16103,
    CnID = "音频@通用窗口-说明弹窗（大）-弹出",
    BaseSortID = 171,
    SoundId = "POPUP_CM_WND_INFO_LV2_ON",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Info_Lv2_On"
    }
  },
  [16154] = {
    ID = 16154,
    CnID = "音频@通用窗口-说明弹窗（大）-关闭",
    BaseSortID = 172,
    SoundId = "POPUP_CM_WND_INFO_LV2_OFF",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Info_Lv2_Off"
    }
  },
  [16146] = {
    ID = 16146,
    CnID = "音频@通用窗口-通屏弹窗-弹出",
    BaseSortID = 173,
    SoundId = "POPUP_CM_WND_ACROSS_ON",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Across_On"
    }
  },
  [16047] = {
    ID = 16047,
    CnID = "音频@通用窗口-通屏弹窗-关闭",
    BaseSortID = 174,
    SoundId = "POPUP_CM_WND_ACROSS_OFF",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Across_Off"
    }
  },
  [15998] = {
    ID = 15998,
    CnID = "音频@通用窗口-提示弹条",
    BaseSortID = 175,
    SoundId = "POPUP_CM_BAR_INFO_LV1",
    WwiseEvent = {
      "Play_Popup_Cm_Bar_Info_Lv1"
    }
  },
  [15987] = {
    ID = 15987,
    CnID = "音频@通用窗口-物件信息弹窗-弹出",
    BaseSortID = 176,
    SoundId = "POPUP_CM_WND_ITEMINFO_ON",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_ItemInfo_On"
    }
  },
  [16156] = {
    ID = 16156,
    CnID = "音频@通用窗口-物件信息弹窗-关闭",
    BaseSortID = 177,
    SoundId = "POPUP_CM_WND_ITEMINFO_OFF",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_ItemInfo_Off"
    }
  },
  [16027] = {
    ID = 16027,
    CnID = "音频@通用窗口-选择清单-弹出",
    BaseSortID = 178,
    SoundId = "POPUP_CM_SELECTBOX_ON",
    WwiseEvent = {
      "Play_Popup_Cm_Selectbox_On"
    }
  },
  [16090] = {
    ID = 16090,
    CnID = "音频@通用窗口-选择清单-关闭",
    BaseSortID = 179,
    SoundId = "POPUP_CM_SELECTBOX_OFF",
    WwiseEvent = {
      "Play_Popup_Cm_Selectbox_Off"
    }
  },
  [16255] = {
    ID = 16255,
    CnID = "音频@通用控件-锁按钮（关锁）",
    BaseSortID = 180,
    SoundId = "UI_CM_BTN_LOCK_ON",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Lock_On"
    }
  },
  [16243] = {
    ID = 16243,
    CnID = "音频@通用控件-锁按钮（开锁）",
    BaseSortID = 181,
    SoundId = "UI_CM_BTN_LOCK_OFF",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Lock_Off"
    }
  },
  [16201] = {
    ID = 16201,
    CnID = "音频@通用控件-左侧圆形按钮",
    BaseSortID = 182,
    SoundId = "PLAY_UI_CM_BTN_SIDE_ROUND",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Side_Round"
    }
  },
  [16029] = {
    ID = 16029,
    CnID = "音频@通用控件-主界面模块按钮",
    BaseSortID = 183,
    SoundId = "PLAY_UI_CM_BTN_MAIN_INTERFACE",
    WwiseEvent = {
      "Play_UI_Cm_Btn_Main_Interface"
    }
  },
  [15997] = {
    ID = 15997,
    CnID = "音频@通用控件-特殊框选（蓝）按钮",
    BaseSortID = 184,
    SoundId = "PLAY_UI_CM_BTN_SACREDBOX_SELECT",
    WwiseEvent = {
      "Play_UI_Cm_Btn_SacredBox_Select"
    }
  },
  [16182] = {
    ID = 16182,
    CnID = "音频@通用控件-冶炼成功动画-弹出",
    BaseSortID = 185,
    SoundId = "PLAY_UI_WHOOSH_LV_TOSMELT",
    WwiseEvent = {
      "Play_UI_Whoosh_Lv_ToSmelt"
    }
  },
  [16263] = {
    ID = 16263,
    CnID = "音频@通用控件-获得物资-弹出",
    BaseSortID = 186,
    SoundId = "POPUP_CM_WIND_ACROSS_GETITEM_ON",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Across_GetItem_On"
    }
  },
  [16211] = {
    ID = 16211,
    CnID = "音频@等级提升白条弹窗-一级提示",
    BaseSortID = 187,
    SoundId = "PLAY_UI_PLAYER_LV_POP",
    WwiseEvent = {
      "Play_UI_Player_Lv_Pop"
    }
  },
  [15990] = {
    ID = 15990,
    CnID = "音频@等级提升白条弹窗-二级提示",
    BaseSortID = 188,
    SoundId = "PLAY_UI_WHOOSH_LV_POP",
    WwiseEvent = {
      "Play_UI_Whoosh_Lv_Pop"
    }
  },
  [16287] = {
    ID = 16287,
    CnID = "音频@章节解锁提示弹窗",
    BaseSortID = 189,
    SoundId = "PLAY_POPUP_CM_WND_ACROSS_OFF",
    WwiseEvent = {
      "Play_Popup_Cm_Wnd_Across_Off"
    }
  },
  [16314] = {
    ID = 16314,
    CnID = "音频@转场-主线章节选择-进入",
    BaseSortID = 190,
    SoundId = "ANIM_INTERFACE_TRANS_STORY_ENTER",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Story_Enter"
    }
  },
  [16045] = {
    ID = 16045,
    CnID = "音频@转场-主线章节选择-退出",
    BaseSortID = 191,
    SoundId = "ANIM_INTERFACE_TRANS_STORY_EXIT",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Story_Exit"
    }
  },
  [15973] = {
    ID = 15973,
    CnID = "音频@转场-幻梦试炼幻梦试炼界面-进入",
    BaseSortID = 192,
    SoundId = "ANIM_INTERFACE_TRANS_MATERIAL_ENTER",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Material_Enter"
    }
  },
  [16030] = {
    ID = 16030,
    CnID = "音频@转场-幻梦试炼幻梦试炼界面-退出",
    BaseSortID = 193,
    SoundId = "ANIM_INTERFACE_TRANS_MATERIAL_EXIT",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Material_Exit"
    }
  },
  [16085] = {
    ID = 16085,
    CnID = "音频@转场-课题纪录课题纪录界面-进入",
    BaseSortID = 194,
    SoundId = "ANIM_INTERFACE_TRANS_TOPIC_ENTER",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Topic_Enter"
    }
  },
  [16005] = {
    ID = 16005,
    CnID = "音频@转场-课题纪录课题纪录界面-退出",
    BaseSortID = 195,
    SoundId = "ANIM_INTERFACE_TRANS_TOPIC_EXIT",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Topic_Exit"
    }
  },
  [16237] = {
    ID = 16237,
    CnID = "音频@转场-守密人手册守密人手册界面-进入",
    BaseSortID = 196,
    SoundId = "ANIM_INTERFACE_TRANS_NOTE_ENTER",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Note_Enter"
    }
  },
  [16036] = {
    ID = 16036,
    CnID = "音频@转场-守密人手册守密人手册界面-退出",
    BaseSortID = 197,
    SoundId = "ANIM_INTERFACE_TRANS_NOTE_EXIT",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Note_Exit"
    }
  },
  [16116] = {
    ID = 16116,
    CnID = "音频@转场-研究中心研究中心界面-进入",
    BaseSortID = 198,
    SoundId = "ANIM_INTERFACE_TRANS_LAB_ENTER",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Lab_Enter"
    }
  },
  [16238] = {
    ID = 16238,
    CnID = "音频@转场-研究中心研究中心界面-退出",
    BaseSortID = 199,
    SoundId = "ANIM_INTERFACE_TRANS_LAB_EXIT",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Lab_Exit"
    }
  },
  [16052] = {
    ID = 16052,
    CnID = "音频@转场-物资物资界面-进入",
    BaseSortID = 200,
    SoundId = "ANIM_INTERFACE_TRANS_OBJECT_ENTER",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Object_Enter"
    }
  },
  [16067] = {
    ID = 16067,
    CnID = "音频@转场-物资物资界面-退出",
    BaseSortID = 201,
    SoundId = "ANIM_INTERFACE_TRANS_OBJECT_EXIT",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Object_Exit"
    }
  },
  [16198] = {
    ID = 16198,
    CnID = "音频@转场-唤醒唤醒界面-进入",
    BaseSortID = 202,
    SoundId = "ANIM_INTERFACE_TRANS_AWAKING_ENTER",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Awaking_Enter"
    }
  },
  [16300] = {
    ID = 16300,
    CnID = "音频@转场-唤醒唤醒界面-退出",
    BaseSortID = 203,
    SoundId = "ANIM_INTERFACE_TRANS_AWAKING_EXIT",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Awaking_Exit"
    }
  },
  [16106] = {
    ID = 16106,
    CnID = "音频@转场-弥萨格弥萨格界面-进入",
    BaseSortID = 204,
    SoundId = "ANIM_INTERFACE_TRANS_MYTHAGSTORE_ENTER",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_MythagStore_Enter"
    }
  },
  [15971] = {
    ID = 15971,
    CnID = "音频@转场-弥萨格弥萨格界面-退出",
    BaseSortID = 205,
    SoundId = "ANIM_INTERFACE_TRANS_MYTHAGSTORE_EXIT",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_MythagStore_Exit"
    }
  },
  [16088] = {
    ID = 16088,
    CnID = "音频@转场-唤醒体唤醒体选中界面-进入",
    BaseSortID = 206,
    SoundId = "ANIM_INTERFACE_TRANS_AWAKER_ENTER",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Awaker_Enter"
    }
  },
  [16087] = {
    ID = 16087,
    CnID = "音频@转场-唤醒体唤醒体选中界面-退出",
    BaseSortID = 207,
    SoundId = "ANIM_INTERFACE_TRANS_AWAKER_EXIT",
    WwiseEvent = {
      "Play_Anim_Interface_Trans_Awaker_Exit"
    }
  },
  [16126] = {
    ID = 16126,
    CnID = "音频@转场-二级界面-进入",
    BaseSortID = 208,
    SoundId = "PLAY_ANIM_INTERFACE_TRANS2_ENTER",
    WwiseEvent = {
      "Play_Anim_Interface_Trans2_Enter"
    }
  },
  [16139] = {
    ID = 16139,
    CnID = "音频@转场-二级界面-退出",
    BaseSortID = 209,
    SoundId = "PLAY_ANIM_INTERFACE_TRANS2_EXIT",
    WwiseEvent = {
      "Play_Anim_Interface_Trans2_Exit"
    }
  },
  [16028] = {
    ID = 16028,
    CnID = "音频@转场-三级界面-进入",
    BaseSortID = 210,
    SoundId = "PLAY_ANIM_INTERFACE_TRANS3_ENTER",
    WwiseEvent = {
      "Play_Anim_Interface_Trans3_Enter"
    }
  },
  [16281] = {
    ID = 16281,
    CnID = "音频@转场-三级界面-退出",
    BaseSortID = 211,
    SoundId = "PLAY_ANIM_INTERFACE_TRANS3_EXIT",
    WwiseEvent = {
      "Play_Anim_Interface_Trans3_Exit"
    }
  },
  [16042] = {
    ID = 16042,
    CnID = "音频@主界面-模块功能按钮（点击）",
    BaseSortID = 212,
    SoundId = "UI_MAIN_BTN_CLICK",
    WwiseEvent = {
      "Play_UI_Main_Btn_Click"
    }
  },
  [15964] = {
    ID = 15964,
    CnID = "音频@结算界面-获得星星1",
    BaseSortID = 213,
    SoundId = "ANIM_SUM_GETSTAR01",
    WwiseEvent = {
      "Play_Anim_Sum_GetStar01"
    }
  },
  [15962] = {
    ID = 15962,
    CnID = "音频@结算界面-获得星星2",
    BaseSortID = 214,
    SoundId = "ANIM_SUM_GETSTAR02",
    WwiseEvent = {
      "Play_Anim_Sum_GetStar02"
    }
  },
  [15963] = {
    ID = 15963,
    CnID = "音频@结算界面-获得星星3",
    BaseSortID = 215,
    SoundId = "ANIM_SUM_GETSTAR03",
    WwiseEvent = {
      "Play_Anim_Sum_GetStar03"
    }
  },
  [16217] = {
    ID = 16217,
    CnID = "音频@设置界面-开启按钮（点击）",
    BaseSortID = 216,
    SoundId = "UI_SET_BTN_ON_CLICK",
    WwiseEvent = {
      "Play_UI_Set_Btn_On_Click"
    }
  },
  [16018] = {
    ID = 16018,
    CnID = "音频@设置界面-关闭按钮（点击）",
    BaseSortID = 217,
    SoundId = "UI_SET_BTN_OFF_CLICK",
    WwiseEvent = {
      "Play_UI_Set_Btn_Off_Click"
    }
  },
  [16122] = {
    ID = 16122,
    CnID = "音频@设置界面-下拉菜单（关闭）",
    BaseSortID = 218,
    SoundId = "UI_SET_DROPDOWN_CLOSE",
    WwiseEvent = {
      "Play_UI_Set_Dropdown_Close"
    }
  },
  [16121] = {
    ID = 16121,
    CnID = "音频@设置界面-下拉菜单（展开）",
    BaseSortID = 219,
    SoundId = "UI_SET_DROPDOWN_OPEN",
    WwiseEvent = {
      "Play_UI_Set_Dropdown_Open"
    }
  },
  [16109] = {
    ID = 16109,
    CnID = "音频@故事界面-章节选择界面-章节图片（点击）",
    BaseSortID = 220,
    SoundId = "UI_STORY_CHAPSELECT_CHAPBOX_CLICK",
    WwiseEvent = {
      "Play_UI_Story_ChapSelect_Chapbox_Click"
    }
  },
  [16173] = {
    ID = 16173,
    CnID = "音频@故事界面-章节选择界面-章节图片（展开）",
    BaseSortID = 221,
    SoundId = "UI_STORY_CHAPSELECT_CHAPBOX_OPEN",
    WwiseEvent = {
      "Play_UI_Story_ChapSelect_Chapbox_Open"
    }
  },
  [16013] = {
    ID = 16013,
    CnID = "音频@唤醒体界面-技能文本框改变",
    BaseSortID = 222,
    SoundId = "UI_AWAKER_SKILL_TESTCHANGE",
    WwiseEvent = {
      "Play_UI_Awaker_Skill_Testchange"
    }
  },
  [16133] = {
    ID = 16133,
    CnID = "音频@唤醒体界面-密契转动",
    BaseSortID = 223,
    SoundId = "ANIM_AWAKER_COVENANT_ROTATE",
    WwiseEvent = {
      "Play_Anim_Awaker_Covenant_Rotate"
    }
  },
  [16037] = {
    ID = 16037,
    CnID = "音频@唤醒体界面-进入密契界面",
    BaseSortID = 224,
    SoundId = "UI_AWAKER_COVENANT_PAGE_ENTER",
    WwiseEvent = {
      "Play_UI_Awaker_Covenant_Page_Enter"
    }
  },
  [16078] = {
    ID = 16078,
    CnID = "音频@唤醒体界面-密契选择",
    BaseSortID = 225,
    SoundId = "UI_AWAKER_COVENANT_ITEM_CLICK",
    WwiseEvent = {
      "Play_UI_Awaker_Covenant_Item_Click"
    }
  },
  [16071] = {
    ID = 16071,
    CnID = "音频@唤醒体界面-信息栏改变",
    BaseSortID = 226,
    SoundId = "ANIM_AWAKER_INFOPAGE_CHANGE",
    WwiseEvent = {
      "Play_Anim_Awaker_InfoPage_Change"
    }
  },
  [16167] = {
    ID = 16167,
    CnID = "音频@材料本界面-任务类别选择（点击）",
    BaseSortID = 227,
    SoundId = "UI_MATERIAL_BTN_LV1_CLICK",
    WwiseEvent = {
      "Play_UI_Material_Btn_Lv1_Click"
    }
  },
  [16136] = {
    ID = 16136,
    CnID = "音频@材料本界面-一级菜单翻页",
    BaseSortID = 228,
    SoundId = "UI_MATERIAL_PAGE_FLIP",
    WwiseEvent = {
      "Play_UI_Material_Page_Flip"
    }
  },
  [16035] = {
    ID = 16035,
    CnID = "音频@邮箱界面-退出",
    BaseSortID = 229,
    SoundId = "ANIM_MAILBOX_EXIT",
    WwiseEvent = {
      "Play_Anim_Mailbox_Exit"
    }
  },
  [16319] = {
    ID = 16319,
    CnID = "音频@邮箱界面-进入",
    BaseSortID = 230,
    SoundId = "ANIM_MAILBOX_ENTER",
    WwiseEvent = {
      "Play_Anim_Mailbox_Enter"
    }
  },
  [16089] = {
    ID = 16089,
    CnID = "音频@商店界面-月卡动画",
    BaseSortID = 231,
    SoundId = "PLAY_UI_ANI_MOONCARD",
    WwiseEvent = {
      "Play_UI_Ani_MoonCard"
    }
  },
  [15975] = {
    ID = 15975,
    CnID = "音频@抽卡界面-抽卡动画R",
    BaseSortID = 232,
    SoundId = "ANIM_AWAKING_RAFFLE_R",
    WwiseEvent = {
      "Play_Anim_Awaking_Raffle_R"
    }
  },
  [16041] = {
    ID = 16041,
    CnID = "音频@抽卡界面-抽卡动画SR",
    BaseSortID = 233,
    SoundId = "ANIM_AWAKING_RAFFLE_SR",
    WwiseEvent = {
      "Play_Anim_Awaking_Raffle_SR"
    }
  },
  [16157] = {
    ID = 16157,
    CnID = "音频@抽卡界面-抽卡动画SSR",
    BaseSortID = 234,
    SoundId = "ANIM_AWAKING_RAFFLE_SSR",
    WwiseEvent = {
      "Play_Anim_Awaking_Raffle_SSR"
    }
  },
  [16256] = {
    ID = 16256,
    CnID = "音频@抽卡界面-抽卡动画（停止）",
    BaseSortID = 235,
    SoundId = "STOP_ANIM_AWAKING_RAFFLE",
    WwiseEvent = {
      "Stop_Anim_Awaking_Raffle"
    }
  },
  [16254] = {
    ID = 16254,
    CnID = "音频@抽卡界面-品质揭晓动画R",
    BaseSortID = 236,
    SoundId = "ANIM_AWAKING_UNVEIL_LEVEL_R",
    WwiseEvent = {
      "Play_Anim_Awaking_Unveil_Level_R"
    }
  },
  [16171] = {
    ID = 16171,
    CnID = "音频@抽卡界面-品质揭晓动画SR",
    BaseSortID = 237,
    SoundId = "ANIM_AWAKING_UNVEIL_LEVEL_SSR",
    WwiseEvent = {
      "Play_Anim_Awaking_Unveil_Level_SSR"
    }
  },
  [16245] = {
    ID = 16245,
    CnID = "音频@抽卡界面-品质揭晓动画SSR",
    BaseSortID = 238,
    SoundId = "ANIM_AWAKING_UNVEIL_LEVEL_SR",
    WwiseEvent = {
      "Play_Anim_Awaking_Unveil_Level_SR"
    }
  },
  [16031] = {
    ID = 16031,
    CnID = "音频@抽卡界面-品质揭晓动画（停止）",
    BaseSortID = 239,
    SoundId = "STOP_ANIM_AWAKING_UNVEIL_LEVEL",
    WwiseEvent = {
      "Stop_Anim_Awaking_Unveil_Level"
    }
  },
  [16069] = {
    ID = 16069,
    CnID = "音频@抽卡界面-内容揭晓动画R",
    BaseSortID = 240,
    SoundId = "ANIM_AWAKING_UNVEIL_CONTENT_R",
    WwiseEvent = {
      "Play_Anim_Awaking_Unveil_Content_R"
    }
  },
  [16113] = {
    ID = 16113,
    CnID = "音频@抽卡界面-内容揭晓动画SR",
    BaseSortID = 241,
    SoundId = "ANIM_AWAKING_UNVEIL_CONTENT_SR",
    WwiseEvent = {
      "Play_Anim_Awaking_Unveil_Content_SR"
    }
  },
  [16221] = {
    ID = 16221,
    CnID = "音频@抽卡界面-内容揭晓动画SSR",
    BaseSortID = 242,
    SoundId = "ANIM_AWAKING_UNVEIL_CONTENT_SSR",
    WwiseEvent = {
      "Play_Anim_Awaking_Unveil_Content_SSR"
    }
  },
  [16233] = {
    ID = 16233,
    CnID = "音频@抽卡界面-内容揭晓动画（停止）",
    BaseSortID = 243,
    SoundId = "STOP_ANIM_AWAKING_UNVEIL_CONTENT",
    WwiseEvent = {
      "Stop_Anim_Awaking_Unveil_Content"
    }
  },
  [15986] = {
    ID = 15986,
    CnID = "音频@抽卡界面-结算界面（进入）",
    BaseSortID = 244,
    SoundId = "TRANS_AWAKING_SUM_ENTER",
    WwiseEvent = {
      "Play_Trans_Awaking_Sum_Enter"
    }
  },
  [16235] = {
    ID = 16235,
    CnID = "音频@抽卡界面-高光特效SSR",
    BaseSortID = 245,
    SoundId = "VFX_AWAKING_SUM_SPOTLIGHT_SSR",
    WwiseEvent = {
      "Play_Vfx_Awaking_Sum_Spotlight_SSR"
    }
  },
  [16143] = {
    ID = 16143,
    CnID = "音频@抽卡界面-高光特效SR",
    BaseSortID = 246,
    SoundId = "VFX_AWAKING_SUM_SPOTLIGHT_SR",
    WwiseEvent = {
      "Play_Vfx_Awaking_Sum_Spotlight_SR"
    }
  },
  [16271] = {
    ID = 16271,
    CnID = "音频@抽卡界面-碎片特效",
    BaseSortID = 247,
    SoundId = "VFX_AWAKING_SUM_FRAGMENTCONVERT",
    WwiseEvent = {
      "Play_Vfx_Awaking_Sum_FragmentConvert"
    }
  },
  [16077] = {
    ID = 16077,
    CnID = "音频@探索-天气音效（雪）",
    BaseSortID = 248,
    SoundId = "PLAY_AMB_EXPLORE_SNOW",
    WwiseEvent = {
      "Play_Amb_Explore_Snow"
    }
  },
  [16293] = {
    ID = 16293,
    CnID = "音频@探索-天气音效（雾）",
    BaseSortID = 249,
    SoundId = "PLAY_AMB_EXPLORE_FOG",
    WwiseEvent = {
      "Play_Amb_Explore_Fog"
    }
  },
  [16279] = {
    ID = 16279,
    CnID = "音频@探索-天气音效（雨）",
    BaseSortID = 250,
    SoundId = "PLAY_AMB_EXPLORE_RAIN_LIGHT",
    WwiseEvent = {
      "Play_Amb_Explore_Rain_Light"
    }
  },
  [16011] = {
    ID = 16011,
    CnID = "音频@停止探索-天气音效（雪）",
    BaseSortID = 251,
    SoundId = "STOP_AMB_EXPLORE_SNOW",
    WwiseEvent = {
      "Stop_Amb_Explore_Snow"
    }
  },
  [16251] = {
    ID = 16251,
    CnID = "音频@停止探索-天气音效（雾）",
    BaseSortID = 252,
    SoundId = "STOP_AMB_EXPLORE_FOG",
    WwiseEvent = {
      "Stop_Amb_Explore_Fog"
    }
  },
  [16262] = {
    ID = 16262,
    CnID = "音频@停止探索-天气音效（雨）",
    BaseSortID = 253,
    SoundId = "STOP_AMB_EXPLORE_RAIN_LIGHT",
    WwiseEvent = {
      "Stop_Amb_Explore_Rain_Light"
    }
  },
  [16299] = {
    ID = 16299,
    CnID = "音频@战斗-天气音效（雪）",
    BaseSortID = 254,
    SoundId = "PLAY_AMB_FT_SNOW",
    WwiseEvent = {
      "Play_Amb_Ft_Snow"
    }
  },
  [15985] = {
    ID = 15985,
    CnID = "音频@战斗-天气音效（雾）",
    BaseSortID = 255,
    SoundId = "PLAY_AMB_FT_FOG",
    WwiseEvent = {
      "Play_Amb_Ft_Fog"
    }
  },
  [16044] = {
    ID = 16044,
    CnID = "音频@战斗-天气音效（雨）",
    BaseSortID = 256,
    SoundId = "PLAY_AMB_FT_RAIN_LIGHT",
    WwiseEvent = {
      "Play_Amb_Ft_Rain_Light"
    }
  },
  [16227] = {
    ID = 16227,
    CnID = "音频@停止战斗-天气音效（雪）",
    BaseSortID = 257,
    SoundId = "STOP_AMB_FT_SNOW",
    WwiseEvent = {
      "Stop_Amb_Ft_Snow"
    }
  },
  [16080] = {
    ID = 16080,
    CnID = "音频@停止战斗-天气音效（雾）",
    BaseSortID = 258,
    SoundId = "STOP_AMB_FT_FOG",
    WwiseEvent = {
      "Stop_Amb_Ft_Fog"
    }
  },
  [16021] = {
    ID = 16021,
    CnID = "音频@停止战斗-天气音效（雨）",
    BaseSortID = 259,
    SoundId = "STOP_AMB_FT_RAIN_LIGHT",
    WwiseEvent = {
      "Stop_Amb_Ft_Rain_Light"
    }
  },
  [16229] = {
    ID = 16229,
    CnID = "音频@唤醒体界面状态",
    BaseSortID = 260,
    SoundId = "SET_STATE_A_INTERFACE_AWAKER",
    WwiseEvent = {
      "Set_State_Aa_Interface_Awaker"
    }
  },
  [16316] = {
    ID = 16316,
    CnID = "音频@幻梦试炼界面状态",
    BaseSortID = 261,
    SoundId = "SET_STATE_A_INTERFACE_MATERIAL",
    WwiseEvent = {
      "Set_State_Aa_Interface_Material"
    }
  },
  [15974] = {
    ID = 15974,
    CnID = "音频@交换商店界面状态",
    BaseSortID = 262,
    SoundId = "SET_STATE_A_INTERFACE_STORE_EXCHANGE",
    WwiseEvent = {
      "Set_State_Aa_Interface_Store_Exchange"
    }
  },
  [16219] = {
    ID = 16219,
    CnID = "音频@守密人手册界面状态",
    BaseSortID = 263,
    SoundId = "SET_STATE_A_INTERFACE_NOTE",
    WwiseEvent = {
      "Set_State_Aa_Interface_Note"
    }
  },
  [16165] = {
    ID = 16165,
    CnID = "音频@研究中心界面状态",
    BaseSortID = 264,
    SoundId = "SET_STATE_A_INTERFACE_LAB",
    WwiseEvent = {
      "Set_State_Aa_Interface_Lab"
    }
  },
  [16025] = {
    ID = 16025,
    CnID = "音频@物资界面状态",
    BaseSortID = 265,
    SoundId = "SET_STATE_A_INTERFACE_OBJECT",
    WwiseEvent = {
      "Set_State_Aa_Interface_Object"
    }
  },
  [15966] = {
    ID = 15966,
    CnID = "音频@进入主线界面状态",
    BaseSortID = 266,
    SoundId = "SET_STATE_A_INTERFACE_STORY",
    WwiseEvent = {
      "Set_State_Aa_Interface_Story"
    }
  },
  [16308] = {
    ID = 16308,
    CnID = "音频@弥撒格商店界面状态",
    BaseSortID = 267,
    SoundId = "SET_STATE_A_INTERFACE_STORE_MYTHAG",
    WwiseEvent = {
      "Set_State_Aa_Interface_Store_Mythag"
    }
  },
  [16176] = {
    ID = 16176,
    CnID = "音频@抽卡界面状态",
    BaseSortID = 268,
    SoundId = "SET_STATE_A_INTERFACE_AWAKING",
    WwiseEvent = {
      "Set_State_Aa_Interface_Awaking"
    }
  },
  [16259] = {
    ID = 16259,
    CnID = "音频@邮件界面状态",
    BaseSortID = 269,
    SoundId = "SET_STATE_A_INTERFACE_MAILBOX",
    WwiseEvent = {
      "Set_State_Aa_Interface_Mailbox"
    }
  },
  [16110] = {
    ID = 16110,
    CnID = "音频@公告栏界面状态",
    BaseSortID = 270,
    SoundId = "SET_STATE_A_INTERFACE_PINBOARD",
    WwiseEvent = {
      "Set_State_Aa_Interface_Pinboard"
    }
  },
  [16153] = {
    ID = 16153,
    CnID = "音频@社交界面状态",
    BaseSortID = 271,
    SoundId = "SET_STATE_A_INTERFACE_CHAT",
    WwiseEvent = {
      "Set_State_Aa_Interface_Chat"
    }
  },
  [16024] = {
    ID = 16024,
    CnID = "音频@设置界面状态",
    BaseSortID = 272,
    SoundId = "SET_STATE_A_INTERFACE_SETTING",
    WwiseEvent = {
      "Set_State_Aa_Interface_Setting"
    }
  },
  [16304] = {
    ID = 16304,
    CnID = "音频@战斗手牌或卡组界面状态",
    BaseSortID = 273,
    SoundId = "SET_STATE_A_FT_CARDVIEW",
    WwiseEvent = {
      "Set_State_Aa_Ft_Cardview"
    }
  },
  [16127] = {
    ID = 16127,
    CnID = "音频@退出战斗手牌或卡组界面状态",
    BaseSortID = 274,
    SoundId = "SET_STATE_A_FT_CARDVIEW_END",
    WwiseEvent = {
      "Set_State_Aa_00None"
    }
  },
  [16197] = {
    ID = 16197,
    CnID = "音频@副本界面展开第1章",
    BaseSortID = 275,
    SoundId = "SET_STATE_B_C01_COMMON",
    WwiseEvent = {
      "Set_State_B_C01_Common"
    }
  },
  [16210] = {
    ID = 16210,
    CnID = "音频@副本界面展开第2章",
    BaseSortID = 276,
    SoundId = "SET_STATE_B_C02_COMMON",
    WwiseEvent = {
      "Set_State_B_C02_Common"
    }
  },
  [16108] = {
    ID = 16108,
    CnID = "音频@副本界面展开第3章",
    BaseSortID = 277,
    SoundId = "SET_STATE_B_C03_COMMON",
    WwiseEvent = {
      "Set_State_B_C03_Common"
    }
  },
  [16004] = {
    ID = 16004,
    CnID = "音频@副本界面展开第4章",
    BaseSortID = 278,
    SoundId = "SET_STATE_B_C04_COMMON",
    WwiseEvent = {
      "Set_State_B_C04_Common"
    }
  },
  [16264] = {
    ID = 16264,
    CnID = "音频@副本界面展开第5章",
    BaseSortID = 279,
    SoundId = "SET_STATE_B_C05_COMMON",
    WwiseEvent = {
      "Set_State_B_C05_Common"
    }
  },
  [16162] = {
    ID = 16162,
    CnID = "音频@副本界面展开第6章",
    BaseSortID = 280,
    SoundId = "SET_STATE_B_C06_COMMON",
    WwiseEvent = {
      "Set_State_B_C06_Common"
    }
  },
  [16060] = {
    ID = 16060,
    CnID = "音频@副本界面展开第7章",
    BaseSortID = 281,
    SoundId = "SET_STATE_B_C07_COMMON",
    WwiseEvent = {
      "Set_State_B_C07_Common"
    }
  },
  [16310] = {
    ID = 16310,
    CnID = "音频@副本界面展开第8章",
    BaseSortID = 282,
    SoundId = "SET_STATE_B_C08_COMMON",
    WwiseEvent = {
      "Set_State_B_C08_Common"
    }
  },
  [16212] = {
    ID = 16212,
    CnID = "音频@副本界面展开第9章",
    BaseSortID = 283,
    SoundId = "SET_STATE_B_C09_COMMON",
    WwiseEvent = {
      "Set_State_B_C09_Common"
    }
  },
  [15995] = {
    ID = 15995,
    CnID = "音频@屏幕加速开启",
    BaseSortID = 284,
    SoundId = "AVG_SPEEDUP_STATE_ON",
    WwiseEvent = {
      "Set_State_Avg_Speedup_CTRL_On"
    }
  },
  [16231] = {
    ID = 16231,
    CnID = "音频@屏幕加速关闭",
    BaseSortID = 285,
    SoundId = "AVG_SPEEDUP_STATE_OFF",
    WwiseEvent = {
      "Set_State_Avg_Speedup_CTRL_Off"
    }
  },
  [16242] = {
    ID = 16242,
    CnID = "音频@战斗音效二倍速开启",
    BaseSortID = 286,
    SoundId = "BATTLE_DOUBLESPEED_ON",
    WwiseEvent = {
      "Set_State_Ingame_DoubleSpeed_on"
    }
  },
  [16149] = {
    ID = 16149,
    CnID = "音频@战斗音效二倍速关闭",
    BaseSortID = 287,
    SoundId = "BATTLE_DOUBLESPEED_OFF",
    WwiseEvent = {
      "Set_State_Ingame_DoubleSpeed_off"
    }
  },
  [16178] = {
    ID = 16178,
    CnID = "音频@暂停互动音乐",
    BaseSortID = 288,
    SoundId = "PAUSE_NONE_AVG_MUSIC",
    WwiseEvent = {
      "Stop_Ingame_Fight_SFXandVoice"
    }
  },
  [15994] = {
    ID = 15994,
    CnID = "音频@退出AVG的音频总控制",
    BaseSortID = 289,
    SoundId = "AVG_EXIT_AUDIO_UNICTRL",
    WwiseEvent = {
      "Resume_Mus",
      "Stop_Avg_Audio",
      "Resume_Ingame_Fight_SFXandVoice"
    }
  },
  [16330] = {
    ID = 16330,
    CnID = "音频@停止互动音乐",
    BaseSortID = 290,
    SoundId = "STOP_MUSIC",
    WwiseEvent = {"Stop_Mus"}
  },
  [16258] = {
    ID = 16258,
    CnID = "音频@对话框插入音乐避让开启",
    BaseSortID = 291,
    SoundId = "POPUP_DUCK_MUSIC_ON",
    WwiseEvent = {
      "Set_State_Mus_Ducking_On"
    }
  },
  [15972] = {
    ID = 15972,
    CnID = "音频@对话框插入音乐避让关闭",
    BaseSortID = 292,
    SoundId = "POPUP_DUCK_MUSIC_OFF",
    WwiseEvent = {
      "Set_State_Mus_Ducking_Off"
    }
  },
  [22401] = {
    ID = 22401,
    CnID = "音频@载入界面音乐",
    BaseSortID = 293,
    SoundId = "LOADING_MUSIC",
    WwiseEvent = {
      "Play_Mus_Loading"
    }
  },
  [16323] = {
    ID = 16323,
    CnID = "音频@登录音乐",
    BaseSortID = 294,
    SoundId = "LOGIN_MUSIC",
    WwiseEvent = {
      "Play_Mus_Login"
    }
  },
  [16096] = {
    ID = 16096,
    CnID = "音频@登录音乐回调登录视频",
    BaseSortID = 295,
    SoundId = "LOGIN_VIDEO_CALLBACK",
    WwiseEvent = {
      "Login_Video_Callback"
    }
  },
  [16140] = {
    ID = 16140,
    CnID = "音频@主界面背景音乐",
    BaseSortID = 296,
    SoundId = "MAININTERFACE_MUSIC",
    WwiseEvent = {
      "Set_State_A_Interface_Main",
      "Set_State_Aa_00None"
    }
  },
  [16163] = {
    ID = 16163,
    CnID = "音频@播放探索关卡0-通用",
    BaseSortID = 297,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_E_Out",
      "Set_State_B_C01_Common",
      "Set_State_A_Ingame",
      "Set_State_Aa_00None"
    }
  },
  [16329] = {
    ID = 16329,
    CnID = "音频@播放探索关卡1-1",
    BaseSortID = 298,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_E_Out",
      "Set_State_B_C01_Common",
      "Set_State_A_Ingame",
      "Set_State_Aa_00None"
    }
  },
  [16074] = {
    ID = 16074,
    CnID = "音频@播放探索关卡2-通用",
    BaseSortID = 299,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_E_Out",
      "Set_State_B_C02_Common",
      "Set_State_A_Ingame",
      "Set_State_Aa_00None"
    }
  },
  [16276] = {
    ID = 16276,
    CnID = "音频@播放战斗音乐outro",
    BaseSortID = 300,
    SoundId = "BATTLE_WIN_MUSIC",
    WwiseEvent = {
      "Play_Fight_Win"
    }
  },
  [16247] = {
    ID = 16247,
    CnID = "音频@战斗结束返回探索",
    BaseSortID = 301,
    WwiseEvent = {
      "Set_State_E_Succeed",
      "Set_State_Aa_00None"
    }
  },
  [16204] = {
    ID = 16204,
    CnID = "音频@播放战斗章节0普通-通用",
    BaseSortID = 302,
    WwiseEvent = {
      "Set_State_D_Street",
      "Set_State_E_In",
      "Set_State_Aa_00None"
    }
  },
  [16159] = {
    ID = 16159,
    CnID = "音频@播放战斗章节0普通-通用-跳过探索界面时使用",
    BaseSortID = 303,
    WwiseEvent = {
      "Play_Mus_Ingame_Ft_C01_Street"
    }
  },
  [16131] = {
    ID = 16131,
    CnID = "音频@播放战斗章节0Boss-通用-跳过探索界面时使用",
    BaseSortID = 304,
    WwiseEvent = {
      "Play_Mus_Ingame_Ft_C01_Boss_Cm"
    }
  },
  [16265] = {
    ID = 16265,
    CnID = "音频@播放战斗章节1街道普通",
    BaseSortID = 305,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_A_Ingame",
      "Set_State_D_Street",
      "Set_State_E_In",
      "Set_State_Aa_00None"
    }
  },
  [16273] = {
    ID = 16273,
    CnID = "音频@结束战斗章节1街道普通",
    BaseSortID = 306,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_A_Ingame",
      "Set_State_D_Street",
      "Set_State_E_In"
    }
  },
  [16208] = {
    ID = 16208,
    CnID = "音频@播放战斗章节1钟楼普通",
    BaseSortID = 307,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_A_Ingame",
      "Set_State_D_Basement",
      "Set_State_E_In"
    }
  },
  [16226] = {
    ID = 16226,
    CnID = "音频@结束战斗章节1钟楼普通",
    BaseSortID = 308,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_A_Ingame",
      "Set_State_D_Basement",
      "Set_State_E_In"
    }
  },
  [16193] = {
    ID = 16193,
    CnID = "音频@播放战斗章节1地下室普通",
    BaseSortID = 309,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_A_Ingame",
      "Set_State_D_Basement",
      "Set_State_E_In",
      "Set_State_Aa_00None"
    }
  },
  [16321] = {
    ID = 16321,
    CnID = "音频@章节2普通战_通用音乐",
    BaseSortID = 310,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_A_Ingame",
      "Set_State_B_C02_Common",
      "Set_State_D_Street",
      "Set_State_E_In",
      "Set_State_Aa_00None"
    }
  },
  [16274] = {
    ID = 16274,
    CnID = "音频@塔薇BOSS战音乐",
    BaseSortID = 311,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_A_Ingame",
      "Set_State_B_C00_Common",
      "Set_State_D_Boss",
      "Set_State_E_In",
      "Set_State_Aa_00None"
    }
  },
  [15968] = {
    ID = 15968,
    CnID = "音频@章节1通用BOSS战音乐",
    BaseSortID = 312,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_A_Ingame",
      "Set_State_B_C01_Common",
      "Set_State_D_Boss",
      "Set_State_E_In",
      "Set_State_Aa_00None"
    }
  },
  [16294] = {
    ID = 16294,
    CnID = "音频@章节2通用BOSS战音乐",
    BaseSortID = 313,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_A_Ingame",
      "Set_State_B_C02_Common",
      "Set_State_D_Boss",
      "Set_State_E_In",
      "Set_State_Aa_00None"
    }
  },
  [16039] = {
    ID = 16039,
    CnID = "音频@艾继丝BOSS战音乐",
    BaseSortID = 314,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_A_Ingame",
      "Set_State_B_C01_E12_2",
      "Set_State_D_Boss",
      "Set_State_E_In",
      "Set_State_Aa_00None"
    }
  },
  [16172] = {
    ID = 16172,
    CnID = "音频@罗杰斯BOSS战音乐",
    BaseSortID = 315,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_A_Ingame",
      "Set_State_B_C02_Fn",
      "Set_State_D_Boss",
      "Set_State_E_In",
      "Set_State_Aa_00None"
    }
  },
  [16000] = {
    ID = 16000,
    CnID = "音频@播放战斗章节1Boss",
    BaseSortID = 316,
    WwiseEvent = {
      "Resume_Mus",
      "Set_State_A_Ingame",
      "Set_State_D_Boss",
      "Set_State_E_In"
    }
  },
  [16272] = {
    ID = 16272,
    CnID = "音频@结束战斗章节1Boss",
    BaseSortID = 317,
    WwiseEvent = {
      "Set_State_D_Boss",
      "Set_State_E_In"
    }
  },
  [16053] = {
    ID = 16053,
    CnID = "音频@停止战斗音效及语音",
    BaseSortID = 318,
    SoundId = "STOP_FIGHT_SFX_AND_VOICE",
    WwiseEvent = {
      "Stop_Ingame_Fight_SFXandVoice"
    }
  },
  [16180] = {
    ID = 16180,
    CnID = "音频@停止avg音频",
    BaseSortID = 319,
    SoundId = "STOP_AVG_AUDIO",
    WwiseEvent = {
      "Stop_Avg_Audio"
    }
  },
  [16046] = {
    ID = 16046,
    CnID = "音频@关卡胜利音乐",
    BaseSortID = 320,
    SoundId = "CHAPTER_WIN_MUSIC",
    WwiseEvent = {
      "Set_State_E_ChapterComplete",
      "Play_Mus_Ingame_Chapter_Complete"
    }
  },
  [16064] = {
    ID = 16064,
    CnID = "音频@关卡失败音乐",
    BaseSortID = 321,
    SoundId = "CHAPTER_FAIL_MUSIC",
    WwiseEvent = {
      "Set_State_E_Fail",
      "Play_Mus_Ingame_Chapter_Fail"
    }
  },
  [16095] = {
    ID = 16095,
    CnID = "音频@关卡退出音乐",
    BaseSortID = 322,
    SoundId = "CHAPTER_QUIT_MUSIC",
    WwiseEvent = {
      "Set_State_E_Fail",
      "Play_Mus_Ingame_Chapter_Fail"
    }
  },
  [16166] = {
    ID = 16166,
    CnID = "音频@冲突-低烈度战斗",
    BaseSortID = 323,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Conflict",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [16189] = {
    ID = 16189,
    CnID = "音频@遭遇-低烈度战斗",
    BaseSortID = 324,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Encounter",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [16318] = {
    ID = 16318,
    CnID = "音频@夜中-低烈度战斗",
    BaseSortID = 325,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Night",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [15970] = {
    ID = 15970,
    CnID = "音频@阴暗之处-低烈度战斗",
    BaseSortID = 326,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_InShadow",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [16119] = {
    ID = 16119,
    CnID = "音频@华丽之战-低烈度战斗",
    BaseSortID = 327,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Gorgeous",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [16061] = {
    ID = 16061,
    CnID = "音频@恐怖之战-低烈度战斗",
    BaseSortID = 328,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Terror",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [16009] = {
    ID = 16009,
    CnID = "音频@爬塔-低烈度战斗",
    BaseSortID = 329,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Summit",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [47159] = {
    ID = 47159,
    CnID = "音频@爬塔2-低烈度战斗",
    BaseSortID = 330,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Summit",
      "Set_State_D_LV1_Vari01",
      "Set_State_E_In"
    }
  },
  [47163] = {
    ID = 47163,
    CnID = "音频@爬塔3-低烈度战斗",
    BaseSortID = 331,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Summit",
      "Set_State_D_LV1_Vari02",
      "Set_State_E_In"
    }
  },
  [16158] = {
    ID = 16158,
    CnID = "音频@地下铁-低烈度战斗",
    BaseSortID = 332,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Subway",
      "Set_State_E_In"
    }
  },
  [16333] = {
    ID = 16333,
    CnID = "音频@意识空间-低烈度战斗",
    BaseSortID = 333,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Consciousness",
      "Set_State_E_In"
    }
  },
  [16179] = {
    ID = 16179,
    CnID = "音频@英国小镇-低烈度战斗",
    BaseSortID = 334,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Town",
      "Set_State_E_In"
    }
  },
  [16325] = {
    ID = 16325,
    CnID = "音频@西洛角色-中烈度战斗",
    BaseSortID = 335,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_XiluoNormal",
      "Set_State_E_In"
    }
  },
  [16070] = {
    ID = 16070,
    CnID = "音频@西洛角色-高烈度战斗",
    BaseSortID = 336,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_XiluoBoss",
      "Set_State_E_In"
    }
  },
  [16332] = {
    ID = 16332,
    CnID = "音频@日挑-低烈度战斗",
    BaseSortID = 337,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Challenge_Daily",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [47160] = {
    ID = 47160,
    CnID = "音频@日挑2-低烈度战斗",
    BaseSortID = 338,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Challenge_Daily",
      "Set_State_D_LV1_Vari01",
      "Set_State_E_In"
    }
  },
  [16292] = {
    ID = 16292,
    CnID = "音频@材料-低烈度战斗",
    BaseSortID = 339,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Material",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [16203] = {
    ID = 16203,
    CnID = "音频@激烈冲突I-中烈度战斗",
    BaseSortID = 340,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Conflict",
      "Set_State_D_LV2",
      "Set_State_E_In"
    }
  },
  [16214] = {
    ID = 16214,
    CnID = "音频@遭遇战I-中烈度战斗",
    BaseSortID = 341,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Encounter",
      "Set_State_D_LV2",
      "Set_State_E_In"
    }
  },
  [16138] = {
    ID = 16138,
    CnID = "音频@遭遇战II-中烈度战斗",
    BaseSortID = 342,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Encounter",
      "Set_State_D_LV2_Vari01",
      "Set_State_E_In"
    }
  },
  [16175] = {
    ID = 16175,
    CnID = "音频@歇斯底里-中烈度战斗",
    BaseSortID = 343,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Hysteria",
      "Set_State_D_LV2",
      "Set_State_E_In"
    }
  },
  [16017] = {
    ID = 16017,
    CnID = "音频@急迫1-中烈度战斗",
    BaseSortID = 344,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Urging",
      "Set_State_D_LV2",
      "Set_State_E_In"
    }
  },
  [16309] = {
    ID = 16309,
    CnID = "音频@硬打-中烈度战斗",
    BaseSortID = 345,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_ToughFight",
      "Set_State_D_LV2",
      "Set_State_E_In"
    }
  },
  [16132] = {
    ID = 16132,
    CnID = "音频@异度之战-低烈度战斗",
    BaseSortID = 346,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_XENO",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [16188] = {
    ID = 16188,
    CnID = "音频@工业战斗-低烈度战斗",
    BaseSortID = 347,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_IndustrialSpace",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [16008] = {
    ID = 16008,
    CnID = "音频@幻光甲板-探索音乐",
    BaseSortID = 348,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_IllusionDeck",
      "Set_State_E_Out"
    }
  },
  [16313] = {
    ID = 16313,
    CnID = "音频@工业空间-探索音乐",
    BaseSortID = 349,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_IndustrialSpace",
      "Set_State_E_Out"
    }
  },
  [16305] = {
    ID = 16305,
    CnID = "音频@冷静思考-探索音乐",
    BaseSortID = 350,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Thinking",
      "Set_State_E_Out"
    }
  },
  [15996] = {
    ID = 15996,
    CnID = "音频@危机重重-探索音乐",
    BaseSortID = 351,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Crisis",
      "Set_State_E_Out"
    }
  },
  [16058] = {
    ID = 16058,
    CnID = "音频@急迫-探索音乐",
    BaseSortID = 352,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Urging",
      "Set_State_E_Out"
    }
  },
  [16101] = {
    ID = 16101,
    CnID = "音频@华丽恐怖-探索音乐",
    BaseSortID = 353,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Terror",
      "Set_State_E_Out"
    }
  },
  [16296] = {
    ID = 16296,
    CnID = "音频@爬塔-探索音乐",
    BaseSortID = 354,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Summit",
      "Set_State_E_Out"
    }
  },
  [16086] = {
    ID = 16086,
    CnID = "音频@日挑-探索音乐",
    BaseSortID = 355,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Challenge_Daily",
      "Set_State_E_Out"
    }
  },
  [16225] = {
    ID = 16225,
    CnID = "音频@准备战斗-探索音乐",
    BaseSortID = 356,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_PrepareWar",
      "Set_State_E_Out"
    }
  },
  [16286] = {
    ID = 16286,
    CnID = "音频@意识空间-探索音乐",
    BaseSortID = 357,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Consciousness",
      "Set_State_E_Out"
    }
  },
  [16181] = {
    ID = 16181,
    CnID = "音频@非常急迫-探索音乐",
    BaseSortID = 358,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_VeryUrging",
      "Set_State_E_Out"
    }
  },
  [16102] = {
    ID = 16102,
    CnID = "音频@地狱犬角色-高烈度战斗",
    BaseSortID = 359,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_DogFight",
      "Set_State_E_In"
    }
  },
  [16228] = {
    ID = 16228,
    CnID = "音频@弥利亚姆角色-高烈度战斗",
    BaseSortID = 360,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Awaker_Miryam",
      "Set_State_D_LV3",
      "Set_State_E_In"
    }
  },
  [16130] = {
    ID = 16130,
    CnID = "音频@压迫I-中烈度战斗",
    BaseSortID = 361,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Oppress",
      "Set_State_E_In"
    }
  },
  [20807] = {
    ID = 20807,
    CnID = "音频@无暇赴死-探索音乐",
    BaseSortID = 362,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_NoTime2Die",
      "Set_State_E_Out"
    }
  },
  [20812] = {
    ID = 20812,
    CnID = "音频@阴暗空间-探索音乐",
    BaseSortID = 363,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Dark",
      "Set_State_E_Out"
    }
  },
  [20810] = {
    ID = 20810,
    CnID = "音频@粉红色梦幻-探索音乐",
    BaseSortID = 364,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_PinkDream",
      "Set_State_E_Out"
    }
  },
  [20814] = {
    ID = 20814,
    CnID = "音频@荒原-探索音乐",
    BaseSortID = 365,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Wasteland",
      "Set_State_E_Out"
    }
  },
  [20809] = {
    ID = 20809,
    CnID = "音频@荒原冰原-探索音乐",
    BaseSortID = 366,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Wasteland_Ice",
      "Set_State_E_Out"
    }
  },
  [20811] = {
    ID = 20811,
    CnID = "音频@北欧小镇夜间-探索音乐",
    BaseSortID = 367,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_NorthEuropeTown_Night",
      "Set_State_E_Out"
    }
  },
  [20808] = {
    ID = 20808,
    CnID = "音频@北欧小镇日间-探索音乐",
    BaseSortID = 368,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_NorthEuropeTown_Day",
      "Set_State_E_Out"
    }
  },
  [20815] = {
    ID = 20815,
    CnID = "音频@荒原-低烈度战斗",
    BaseSortID = 369,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Wasteland",
      "Set_State_E_In"
    }
  },
  [20816] = {
    ID = 20816,
    CnID = "音频@荒原冰原-低烈度战斗",
    BaseSortID = 370,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Wasteland_Ice",
      "Set_State_E_In"
    }
  },
  [20813] = {
    ID = 20813,
    CnID = "音频@达芙黛尔-中烈度战斗",
    BaseSortID = 371,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Awaker_Daffodil",
      "Set_State_E_In"
    }
  },
  [21705] = {
    ID = 21705,
    CnID = "音频@沙漠-低烈度战斗",
    BaseSortID = 372,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Desert",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [21706] = {
    ID = 21706,
    CnID = "音频@沙漠-探索音乐",
    BaseSortID = 373,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Desert",
      "Set_State_E_Out"
    }
  },
  [21974] = {
    ID = 21974,
    CnID = "音频@PVP-战斗音乐（默认）",
    BaseSortID = 374,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_PVP_Default",
      "Set_State_E_In"
    }
  },
  [24974] = {
    ID = 24974,
    CnID = "音频@悠闲溜达-探索音乐",
    BaseSortID = 375,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_HangOut",
      "Set_State_E_Out"
    }
  },
  [24975] = {
    ID = 24975,
    CnID = "音频@N-中烈度战斗",
    BaseSortID = 376,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Monster_N",
      "Set_State_E_In"
    }
  },
  [25143] = {
    ID = 25143,
    CnID = "音频@搞笑-低烈度战斗",
    BaseSortID = 377,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Funny",
      "Set_State_E_In"
    }
  },
  [35172] = {
    ID = 35172,
    CnID = "音频@逗逼-探索音乐",
    BaseSortID = 378,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Funny",
      "Set_State_E_Out"
    }
  },
  [36149] = {
    ID = 36149,
    CnID = "音频@石头空间-探索音乐",
    BaseSortID = 379,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_RockSpace",
      "Set_State_E_Out"
    }
  },
  [36150] = {
    ID = 36150,
    CnID = "音频@石头空间-低烈度战斗",
    BaseSortID = 380,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_RockSpace",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [36147] = {
    ID = 36147,
    CnID = "音频@特别苦战-中烈度战斗",
    BaseSortID = 381,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Struggle",
      "Set_State_D_LV2",
      "Set_State_E_In"
    }
  },
  [36148] = {
    ID = 36148,
    CnID = "音频@伏击-中烈度战斗",
    BaseSortID = 382,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Ambush",
      "Set_State_D_LV2",
      "Set_State_E_In"
    }
  },
  [36721] = {
    ID = 36721,
    CnID = "音频@圣婴-BOSS战",
    BaseSortID = 383,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_BossFt_HolyBaby",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [37988] = {
    ID = 37988,
    CnID = "音频@溶蚀废墟-探索音乐",
    BaseSortID = 384,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Ruins",
      "Set_State_E_Out"
    }
  },
  [43810] = {
    ID = 43810,
    CnID = "音频@临时战斗音乐事件",
    BaseSortID = 385,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Conflict",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [43811] = {
    ID = 43811,
    CnID = "音频@临时探索音乐事件",
    BaseSortID = 386,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_Aa_00None",
      "Set_State_B_Thinking",
      "Set_State_E_Out"
    }
  },
  [45179] = {
    ID = 45179,
    CnID = "音频@提灯教会-探索音乐",
    BaseSortID = 387,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Lantern",
      "Set_State_E_Out"
    }
  },
  [45180] = {
    ID = 45180,
    CnID = "音频@提灯教会-低烈度战斗",
    BaseSortID = 388,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Lantern",
      "Set_State_E_In"
    }
  },
  [45194] = {
    ID = 45194,
    CnID = "音频@教堂-探索音乐",
    BaseSortID = 389,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Scene_Church",
      "Set_State_E_Out"
    }
  },
  [45195] = {
    ID = 45195,
    CnID = "音频@教堂-低烈度战斗",
    BaseSortID = 390,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Scene_Church",
      "Set_State_E_In"
    }
  },
  [47162] = {
    ID = 47162,
    CnID = "音频@冰封-低烈度战斗",
    BaseSortID = 391,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Scene_Frozen",
      "Set_State_E_In"
    }
  },
  [47161] = {
    ID = 47161,
    CnID = "音频@森林-低烈度战斗",
    BaseSortID = 392,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Scene_Forrest",
      "Set_State_E_In"
    }
  },
  [50025] = {
    ID = 50025,
    CnID = "音频@绿洲白天-低烈度战斗",
    BaseSortID = 393,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Oasis_Day",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [50027] = {
    ID = 50027,
    CnID = "音频@绿洲夜晚-低烈度战斗",
    BaseSortID = 394,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Oasis_Night",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [50024] = {
    ID = 50024,
    CnID = "音频@母树空间-低烈度战斗",
    BaseSortID = 395,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_MotherTree",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [50026] = {
    ID = 50026,
    CnID = "音频@绿洲白天-探索",
    BaseSortID = 396,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Oasis_Day",
      "Set_State_E_Out"
    }
  },
  [50023] = {
    ID = 50023,
    CnID = "音频@绿洲夜晚-探索",
    BaseSortID = 397,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Oasis_Night",
      "Set_State_E_Out"
    }
  },
  [50028] = {
    ID = 50028,
    CnID = "音频@母树空间-探索",
    BaseSortID = 398,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_MotherTree",
      "Set_State_E_Out"
    }
  },
  [51147] = {
    ID = 51147,
    CnID = "音频@母树-BOSS战",
    BaseSortID = 399,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_BossFt_MotherTree",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [56363] = {
    ID = 56363,
    CnID = "音频@花的世界-探索音乐",
    BaseSortID = 400,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Dis_Flower",
      "Set_State_E_Out"
    }
  },
  [56362] = {
    ID = 56362,
    CnID = "音频@诗歌-低烈度战斗",
    BaseSortID = 401,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Ft_Poem",
      "Set_State_E_In"
    }
  },
  [56395] = {
    ID = 56395,
    CnID = "音频@跳过打小怪胜利",
    BaseSortID = 402,
    SoundId = "FIGHT_WIN_MUSIC_ESCAPE",
    WwiseEvent = {
      "Play_SFX_POP_WIN_Fast"
    }
  },
  [60599] = {
    ID = 60599,
    CnID = "音频@音乐教室-低烈度战斗",
    BaseSortID = 403,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_MusicRoom",
      "Set_State_E_In"
    }
  },
  [61048] = {
    ID = 61048,
    CnID = "音频@音乐教室-探索音乐",
    BaseSortID = 404,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_MusicRoom",
      "Set_State_E_Out"
    }
  },
  [62350] = {
    ID = 62350,
    CnID = "音频@塔微双子-BOSS战",
    BaseSortID = 405,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_TaweiDouble",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [67430] = {
    ID = 67430,
    CnID = "音频@首战托乎瓦波-BOSS战",
    BaseSortID = 406,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_First_Tuohuwabo",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [67428] = {
    ID = 67428,
    CnID = "音频@悲伤I-中烈度战斗",
    BaseSortID = 407,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_SadFight_1",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [67429] = {
    ID = 67429,
    CnID = "音频@悲伤II-中烈度战斗",
    BaseSortID = 408,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_SadFight_2",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [67427] = {
    ID = 67427,
    CnID = "音频@突击-中烈度战斗",
    BaseSortID = 409,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_RaidFight",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [67795] = {
    ID = 67795,
    CnID = "音频@悲伤-探索音乐",
    BaseSortID = 410,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Sad",
      "Set_State_E_Out"
    }
  },
  [68949] = {
    ID = 68949,
    CnID = "音频@活动托乎瓦波-艾吉斯",
    BaseSortID = 411,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Aijisi_Tuohuwabo",
      "Set_State_E_In"
    }
  },
  [68942] = {
    ID = 68942,
    CnID = "音频@活动托乎瓦波-詹金",
    BaseSortID = 412,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Zhanjin_Tuohuwabo",
      "Set_State_E_In"
    }
  },
  [68947] = {
    ID = 68947,
    CnID = "音频@活动托乎瓦波-希洛",
    BaseSortID = 413,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Xiluo_Tuohuwabo",
      "Set_State_E_In"
    }
  },
  [68944] = {
    ID = 68944,
    CnID = "音频@活动托乎瓦波-莉莉",
    BaseSortID = 414,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Lily_Tuohuwabo",
      "Set_State_E_In"
    }
  },
  [68943] = {
    ID = 68943,
    CnID = "音频@活动托乎瓦波-米粒",
    BaseSortID = 415,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Mili_Tuohuwabo",
      "Set_State_E_In"
    }
  },
  [68948] = {
    ID = 68948,
    CnID = "音频@活动托乎瓦波-图鲁",
    BaseSortID = 416,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Tulu_Tuohuwabo",
      "Set_State_E_In"
    }
  },
  [68946] = {
    ID = 68946,
    CnID = "音频@活动托乎瓦波-羊妈",
    BaseSortID = 417,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Yang_Tuohuwabo",
      "Set_State_E_In"
    }
  },
  [68945] = {
    ID = 68945,
    CnID = "音频@终战托乎瓦波-BOSS战",
    BaseSortID = 418,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Final_Tuohuwabo",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [70278] = {
    ID = 70278,
    CnID = "音频@登录音乐一周年",
    BaseSortID = 419,
    SoundId = "LOGIN_MUSIC_ONEYEAR",
    WwiseEvent = {
      "Play_Mus_Login_OneYear"
    }
  },
  [70380] = {
    ID = 70380,
    CnID = "音频@慷慨赴死-探索音乐",
    BaseSortID = 420,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_ReadyToDie",
      "Set_State_E_Out"
    }
  },
  [71859] = {
    ID = 71859,
    CnID = "音频@登录音乐半周年",
    BaseSortID = 421,
    SoundId = "LOGIN_MUSIC_HALFYEAR",
    WwiseEvent = {
      "Play_Mus_Login_HalfYear"
    }
  },
  [71858] = {
    ID = 71858,
    CnID = "音频@登录音乐V20",
    BaseSortID = 422,
    SoundId = "LOGIN_MUSIC_V20",
    WwiseEvent = {
      "Play_Mus_Login_V20"
    }
  },
  [72080] = {
    ID = 72080,
    CnID = "音频@热闹-低烈度战斗",
    BaseSortID = 423,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Funny2",
      "Set_State_E_In"
    }
  },
  [74941] = {
    ID = 74941,
    CnID = "音频@轮转-中烈度战斗",
    BaseSortID = 424,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_NeverEnd",
      "Set_State_E_In"
    }
  },
  [74942] = {
    ID = 74942,
    CnID = "音频@实验室-低烈度战斗",
    BaseSortID = 425,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Lab",
      "Set_State_E_In"
    }
  },
  [78597] = {
    ID = 78597,
    CnID = "音频@本朵BOSS-高烈度战斗",
    BaseSortID = 426,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_BenduoBoss",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [79258] = {
    ID = 79258,
    CnID = "音频@PVP-战斗音乐-逆转回合",
    BaseSortID = 427,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_PVP_NiZhuan",
      "Set_State_E_In"
    }
  },
  [81412] = {
    ID = 81412,
    CnID = "音频@夏盖BOSS-高烈度战斗",
    BaseSortID = 428,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_XiaGaiBoss",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [96607] = {
    ID = 96607,
    CnID = "音频@古堡-低烈度战斗",
    BaseSortID = 429,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Gubao",
      "Set_State_E_In"
    }
  },
  [97282] = {
    ID = 97282,
    CnID = "音频@杜勒BOSS-高烈度战斗",
    BaseSortID = 430,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_DuleBoss",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [99084] = {
    ID = 99084,
    CnID = "音频@热带-低烈度战斗",
    BaseSortID = 431,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Hot",
      "Set_State_E_In"
    }
  },
  [122446] = {
    ID = 122446,
    CnID = "音频@本墨BOSS-高烈度战斗",
    BaseSortID = 432,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_BenMoBoss",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [122448] = {
    ID = 122448,
    CnID = "音频@幻光甲板-低烈度战斗",
    BaseSortID = 433,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_deck",
      "Set_State_E_In"
    }
  },
  [122449] = {
    ID = 122449,
    CnID = "音频@深海阵营乱斗-中烈度战斗",
    BaseSortID = 434,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Deep_sea_brawl",
      "Set_State_E_In"
    }
  },
  [122447] = {
    ID = 122447,
    CnID = "音频@蹈海者连战-中烈度战斗",
    BaseSortID = 435,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Fish_Battle",
      "Set_State_E_In"
    }
  },
  [123492] = {
    ID = 123492,
    CnID = "音频@PVP-战斗音乐-轮选模式",
    BaseSortID = 436,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_PVP_Runoff",
      "Set_State_E_In"
    }
  },
  [124749] = {
    ID = 124749,
    CnID = "音频@迷雾战斗-中烈度战斗",
    BaseSortID = 437,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_mist",
      "Set_State_E_In"
    }
  },
  [126566] = {
    ID = 126566,
    CnID = "音频@战斗音乐扩充-海上迷雾战斗-中烈度战斗",
    BaseSortID = 438,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Sea_fog",
      "Set_State_E_In"
    }
  },
  [126565] = {
    ID = 126565,
    CnID = "音频@战斗音乐扩充-激烈战斗-中烈度战斗",
    BaseSortID = 439,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Intense_battles",
      "Set_State_E_In"
    }
  },
  [126564] = {
    ID = 126564,
    CnID = "音频@战斗音乐扩充-追击-中烈度战斗",
    BaseSortID = 440,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_pursuit",
      "Set_State_E_In"
    }
  },
  [132893] = {
    ID = 132893,
    CnID = "音频@阿拉克涅Boss战",
    BaseSortID = 441,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_AlakenieBoss",
      "Set_State_D_LV1",
      "Set_State_E_In"
    }
  },
  [134183] = {
    ID = 134183,
    CnID = "音频@剧院优雅战斗-中烈度战斗",
    BaseSortID = 442,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_theater",
      "Set_State_E_In"
    }
  },
  [134184] = {
    ID = 134184,
    CnID = "音频@潇洒的战斗-低烈度战斗",
    BaseSortID = 443,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_bar",
      "Set_State_E_In"
    }
  },
  [134182] = {
    ID = 134182,
    CnID = "音频@萨拉热窝-低烈度战斗",
    BaseSortID = 444,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_revolt",
      "Set_State_E_In"
    }
  },
  [141016] = {
    ID = 141016,
    CnID = "音频@沙耶血肉-中烈度战斗",
    BaseSortID = 445,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Shaye",
      "Set_State_E_In"
    }
  },
  [149796] = {
    ID = 149796,
    CnID = "音频@逃亡-中烈度战斗",
    BaseSortID = 446,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_escape",
      "Set_State_E_In"
    }
  },
  [149795] = {
    ID = 149795,
    CnID = "音频@混战-中烈度战斗",
    BaseSortID = 447,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_melee",
      "Set_State_E_In"
    }
  },
  [149797] = {
    ID = 149797,
    CnID = "音频@虫族-中烈度战斗",
    BaseSortID = 448,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_insect",
      "Set_State_E_In"
    }
  },
  [149806] = {
    ID = 149806,
    CnID = "音频@压抑雪山-探索音乐",
    BaseSortID = 449,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Suppressing_Snow_Mountain",
      "Set_State_E_Out"
    }
  },
  [149805] = {
    ID = 149805,
    CnID = "音频@严肃神秘雪山-探索音乐",
    BaseSortID = 450,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Mysterious_Snow_Mountain",
      "Set_State_E_Out"
    }
  },
  [149804] = {
    ID = 149804,
    CnID = "音频@恐怖雪山-探索音乐",
    BaseSortID = 451,
    WwiseEvent = {
      "Set_State_A_Ingame",
      "Set_State_B_Ingame_Snow_Mountain_Terror",
      "Set_State_E_Out"
    }
  },
  [16114] = {
    ID = 16114,
    CnID = "音频@默认场景光影音效",
    BaseSortID = 452,
    SoundId = "LIGHTEFFECT_DEFAULT",
    WwiseEvent = {
      "Trigger_Exp_MScene_999"
    }
  },
  [16230] = {
    ID = 16230,
    CnID = "音频@场景002光影音效",
    BaseSortID = 453,
    SoundId = "LIGHTEFFECT_MSCENE_002",
    WwiseEvent = {
      "Trigger_Exp_MScene_999"
    }
  },
  [16283] = {
    ID = 16283,
    CnID = "音频@战斗胜利音效",
    BaseSortID = 454,
    SoundId = "Audio_Result_Fight_Win",
    WwiseEvent = {
      "Play_Fight_Win"
    }
  },
  [16152] = {
    ID = 16152,
    CnID = "音频@战斗UI查看手牌-放大音效",
    BaseSortID = 455,
    SoundId = "Audio_UI_Poker_Show_Card",
    WwiseEvent = {
      "Play_UI_Poker_Show_Card"
    }
  },
  [16148] = {
    ID = 16148,
    CnID = "音频@战斗UI查看手牌-缩小音效",
    BaseSortID = 456,
    SoundId = "Audio_UI_Poker_Show_Card_Withdraw",
    WwiseEvent = {
      "Play_UI_Poker_Show_Card_Withdraw"
    }
  },
  [16297] = {
    ID = 16297,
    CnID = "音频@战斗UI拖出手牌音效",
    BaseSortID = 457,
    SoundId = "Audio_UI_Poker_Drag",
    WwiseEvent = {
      "Play_UI_Poker_Drag"
    }
  },
  [16145] = {
    ID = 16145,
    CnID = "音频@战斗UI取消拖出手牌音效",
    BaseSortID = 458,
    SoundId = "Audio_UI_Poker_Withdraw",
    WwiseEvent = {
      "Play_UI_Poker_Withdraw"
    }
  },
  [16170] = {
    ID = 16170,
    CnID = "音频@战斗UI聚光灯下选择敌人",
    BaseSortID = 459,
    SoundId = "Audio_UI_Poker_Card_Slc",
    WwiseEvent = {
      "Play_UI_Poker_Card_Slc"
    }
  },
  [16324] = {
    ID = 16324,
    CnID = "音频@战斗UI卡牌生效出牌音效",
    BaseSortID = 460,
    SoundId = "Audio_UI_Poker_Comfirm",
    WwiseEvent = {
      "Play_UI_Poker_Comfirm"
    }
  },
  [15965] = {
    ID = 15965,
    CnID = "音频@战斗UI卡牌销毁音效",
    BaseSortID = 461,
    SoundId = "Audio_UI_Poker_Dis",
    WwiseEvent = {
      "Play_UI_Poker_Dis"
    }
  },
  [16168] = {
    ID = 16168,
    CnID = "音频@战斗UI弃牌堆返回音效",
    BaseSortID = 462,
    SoundId = "Audio_UI_Poker_Button_Fold_Back",
    WwiseEvent = {
      "Play_UI_Poker_Button_Fold_Back"
    }
  },
  [15989] = {
    ID = 15989,
    CnID = "音频@战斗UI抽牌堆返回音效",
    BaseSortID = 463,
    SoundId = "Audio_UI_Poker_Button_Draw_Back",
    WwiseEvent = {
      "Play_UI_Poker_Button_Draw_Back"
    }
  },
  [16331] = {
    ID = 16331,
    CnID = "音频@战斗UI弃牌堆Back音效",
    BaseSortID = 464,
    SoundId = "Audio_UI_Poker_Button_Dis_Back",
    WwiseEvent = {
      "Play_UI_Poker_Button_Dis_Back"
    }
  },
  [16252] = {
    ID = 16252,
    CnID = "音频@选择非手牌卡牌音效",
    BaseSortID = 465,
    SoundId = "Audio_UI_Com_Selec_Card",
    WwiseEvent = {
      "Play_UI_Com_Selec_Card"
    }
  },
  [16224] = {
    ID = 16224,
    CnID = "音频@查看非手牌卡牌音效",
    BaseSortID = 466,
    SoundId = "Audio_UI_Com_Show_Card_Info",
    WwiseEvent = {
      "Play_UI_Com_Show_Card_Info"
    }
  },
  [16098] = {
    ID = 16098,
    CnID = "音频@卡牌飞入手牌音效",
    BaseSortID = 467,
    SoundId = "Audio_UI_Poker_Get_Card",
    WwiseEvent = {
      "Play_UI_Poker_Get_Card"
    }
  },
  [16206] = {
    ID = 16206,
    CnID = "音频@默认按钮点击音效",
    BaseSortID = 468,
    SoundId = "DefaultButtonAudioEvent",
    WwiseEvent = {
      "Play_SFX_UI_Button_DefaultEvent"
    }
  },
  [84465] = {
    ID = 84465,
    CnID = "音频@时装抽取音乐入场",
    BaseSortID = 469,
    SoundId = "SET_STATE_ANIM_FASHION_MARCHIN",
    WwiseEvent = {
      "Set_State_Aa_Interface_Anim_Fashion_Waiting"
    }
  },
  [84467] = {
    ID = 84467,
    CnID = "音频@时装抽取音乐蓝",
    BaseSortID = 470,
    SoundId = "SET_STATE_ANIM_FASHION_R",
    WwiseEvent = {
      "Set_State_Aa_Interface_Anim_Trig_Fashion_Raffle_R"
    }
  },
  [84460] = {
    ID = 84460,
    CnID = "音频@时装抽取音乐紫",
    BaseSortID = 471,
    SoundId = "SET_STATE_ANIM_FASHION_SR",
    WwiseEvent = {
      "Set_State_Aa_Interface_Anim_Trig_Fashion_Raffle_SR"
    }
  },
  [84464] = {
    ID = 84464,
    CnID = "音频@时装抽取音乐金",
    BaseSortID = 472,
    SoundId = "SET_STATE_ANIM_FASHION_SSR",
    WwiseEvent = {
      "Set_State_Aa_Interface_Anim_Trig_Fashion_Raffle_SSR"
    }
  },
  [84466] = {
    ID = 84466,
    CnID = "音频@时装抽取音乐结算",
    BaseSortID = 473,
    SoundId = "SET_STATE_ANIM_FASHION_SUM",
    WwiseEvent = {
      "Set_State_Aa_Interface_Anim_Fashion_Unveil_Sum"
    }
  },
  [84462] = {
    ID = 84462,
    CnID = "音频@时装抽取音效入场",
    BaseSortID = 474,
    SoundId = "PLAY_ANIM_FASHION_MARCHIN",
    WwiseEvent = {
      "Play_Anim_ClotherLottery_Result_MarchIn"
    }
  },
  [84459] = {
    ID = 84459,
    CnID = "音频@时装抽取音效蓝",
    BaseSortID = 475,
    SoundId = "PLAY_ANIM_FASHION_R",
    WwiseEvent = {
      "Play_Anim_ClotherLottery_Result_R"
    }
  },
  [84463] = {
    ID = 84463,
    CnID = "音频@时装抽取音效紫",
    BaseSortID = 476,
    SoundId = "PLAY_ANIM_FASHION_SR",
    WwiseEvent = {
      "Play_Anim_ClotherLottery_Result_SR"
    }
  },
  [84461] = {
    ID = 84461,
    CnID = "音频@时装抽取音效金",
    BaseSortID = 477,
    SoundId = "PLAY_ANIM_FASHION_SSR",
    WwiseEvent = {
      "Play_Anim_ClotherLottery_Result_SSR"
    }
  }
})
return AudioConfig
