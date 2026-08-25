local System = require("System.System")
local readonly = System.readonly
local CommonID = readonly({
  Slot_Strike = {
    ID = "Slot_Strike",
    CnID = "槽位.打击",
    BaseSortID = 1
  },
  Slot_Defend = {
    ID = "Slot_Defend",
    CnID = "槽位.防御",
    BaseSortID = 2
  },
  Slot_Super = {
    ID = "Slot_Super",
    CnID = "槽位.狂气爆发",
    BaseSortID = 3
  },
  Slot_Awake = {
    ID = "Slot_Awake",
    CnID = "槽位.灵知觉醒",
    BaseSortID = 4
  },
  Slot_Skill1 = {
    ID = "Slot_Skill1",
    CnID = "槽位.技能1",
    BaseSortID = 5
  },
  Slot_Skill2 = {
    ID = "Slot_Skill2",
    CnID = "槽位.技能2",
    BaseSortID = 6
  },
  Slot_Skill3 = {
    ID = "Slot_Skill3",
    CnID = "槽位.技能3",
    BaseSortID = 7
  },
  Slot_Extend1 = {
    ID = "Slot_Extend1",
    CnID = "槽位.衍生1",
    BaseSortID = 8
  },
  Slot_Extend2 = {
    ID = "Slot_Extend2",
    CnID = "槽位.衍生2",
    BaseSortID = 9
  },
  Slot_Extend3 = {
    ID = "Slot_Extend3",
    CnID = "槽位.衍生3",
    BaseSortID = 10
  },
  Slot_Extend4 = {
    ID = "Slot_Extend4",
    CnID = "槽位.衍生4",
    BaseSortID = 11
  },
  Slot_Extend5 = {
    ID = "Slot_Extend5",
    CnID = "槽位.衍生5",
    BaseSortID = 12
  },
  Slot_Extend6 = {
    ID = "Slot_Extend6",
    CnID = "槽位.衍生6",
    BaseSortID = 13
  },
  Slot_Extend7 = {
    ID = "Slot_Extend7",
    CnID = "槽位.衍生7",
    BaseSortID = 14
  },
  Slot_Extend8 = {
    ID = "Slot_Extend8",
    CnID = "槽位.衍生8",
    BaseSortID = 15
  },
  Slot_Extend9 = {
    ID = "Slot_Extend9",
    CnID = "槽位.衍生9",
    BaseSortID = 16
  },
  Slot_Extend10 = {
    ID = "Slot_Extend10",
    CnID = "槽位.衍生10",
    BaseSortID = 17
  },
  Slot_Extend11 = {
    ID = "Slot_Extend11",
    CnID = "槽位.衍生11",
    BaseSortID = 18
  },
  Slot_Extend12 = {
    ID = "Slot_Extend12",
    CnID = "槽位.衍生12",
    BaseSortID = 19
  },
  Slot_Extend13 = {
    ID = "Slot_Extend13",
    CnID = "槽位.衍生13",
    BaseSortID = 20
  },
  Slot_Extend14 = {
    ID = "Slot_Extend14",
    CnID = "槽位.衍生14",
    BaseSortID = 21
  },
  Slot_Extend15 = {
    ID = "Slot_Extend15",
    CnID = "槽位.衍生15",
    BaseSortID = 22
  },
  Slot_Extend16 = {
    ID = "Slot_Extend16",
    CnID = "槽位.衍生16",
    BaseSortID = 23
  },
  Slot_Extend17 = {
    ID = "Slot_Extend17",
    CnID = "槽位.衍生17",
    BaseSortID = 24
  },
  Slot_Extend18 = {
    ID = "Slot_Extend18",
    CnID = "槽位.衍生18",
    BaseSortID = 25
  },
  Slot_Extend19 = {
    ID = "Slot_Extend19",
    CnID = "槽位.衍生19",
    BaseSortID = 26
  },
  Slot_Extend20 = {
    ID = "Slot_Extend20",
    CnID = "槽位.衍生20",
    BaseSortID = 27
  },
  Slot_Extend21 = {
    ID = "Slot_Extend21",
    CnID = "槽位.衍生21",
    BaseSortID = 28
  },
  Slot_Extend22 = {
    ID = "Slot_Extend22",
    CnID = "槽位.衍生22",
    BaseSortID = 29
  },
  Slot_Extend23 = {
    ID = "Slot_Extend23",
    CnID = "槽位.衍生23",
    BaseSortID = 30
  },
  Slot_Extend24 = {
    ID = "Slot_Extend24",
    CnID = "槽位.衍生24",
    BaseSortID = 31
  },
  Slot_Extend25 = {
    ID = "Slot_Extend25",
    CnID = "槽位.衍生25",
    BaseSortID = 32
  },
  Slot_Extend26 = {
    ID = "Slot_Extend26",
    CnID = "槽位.衍生26",
    BaseSortID = 33
  },
  Slot_Extend27 = {
    ID = "Slot_Extend27",
    CnID = "槽位.衍生27",
    BaseSortID = 34
  },
  Slot_Extend28 = {
    ID = "Slot_Extend28",
    CnID = "槽位.衍生28",
    BaseSortID = 35
  },
  Slot_Extend29 = {
    ID = "Slot_Extend29",
    CnID = "槽位.衍生29",
    BaseSortID = 36
  },
  Slot_Extend30 = {
    ID = "Slot_Extend30",
    CnID = "槽位.衍生30",
    BaseSortID = 37
  },
  Slot_Extend31 = {
    ID = "Slot_Extend31",
    CnID = "槽位.衍生31",
    BaseSortID = 38
  },
  Slot_Extend32 = {
    ID = "Slot_Extend32",
    CnID = "槽位.衍生32",
    BaseSortID = 39
  },
  Slot_Extend33 = {
    ID = "Slot_Extend33",
    CnID = "槽位.衍生33",
    BaseSortID = 40
  },
  Keeper_Skill = {
    ID = "Keeper_Skill",
    CnID = "主角技能",
    BaseSortID = 41,
    Desc = "CommonID_Keeper_Skill_Desc|主角技能"
  },
  Card_Skill = {
    ID = "Card_Skill",
    CnID = "技能卡",
    BaseSortID = 42,
    Desc = "CommonID_Card_Skill_Desc|技能卡"
  },
  Card_Strike = {
    ID = "Card_Strike",
    CnID = "打击卡",
    BaseSortID = 43,
    Desc = "CommonID_Card_Strike_Desc|打击卡"
  },
  Card_Defend = {
    ID = "Card_Defend",
    CnID = "防御卡",
    BaseSortID = 44,
    Desc = "CommonID_Card_Defend_Desc|防御卡"
  },
  Ulti_Skill = {
    ID = "Ulti_Skill",
    CnID = "狂气爆发",
    BaseSortID = 45,
    Desc = "CommonID_Ulti_Skill_Desc|狂气爆发"
  },
  Card_Awake = {
    ID = "Card_Awake",
    CnID = "灵知觉醒",
    BaseSortID = 46,
    Desc = "CommonID_Card_Awake_Desc|灵知觉醒"
  },
  Card_Curse = {
    ID = "Card_Curse",
    CnID = "症状卡",
    BaseSortID = 47,
    Desc = "CommonID_Card_Curse_Desc|症状卡"
  },
  Card_State = {
    ID = "Card_State",
    CnID = "状态卡",
    BaseSortID = 48,
    Desc = "CommonID_Card_State_Desc|状态卡"
  },
  Card_Potion = {
    ID = "Card_Potion",
    CnID = "药水卡",
    BaseSortID = 49,
    Desc = "CommonID_Card_Potion_Desc|药水卡"
  },
  Card_Weapon = {
    ID = "Card_Weapon",
    CnID = "命轮卡",
    BaseSortID = 50,
    Desc = "CommonID_Card_Weapon_Desc|命轮卡"
  },
  Card_KeeperSkill = {
    ID = "Card_KeeperSkill",
    CnID = "钥令卡",
    BaseSortID = 51,
    Desc = "CommonID_Card_KeeperSkill_Desc|钥令卡"
  },
  Card_Developing = {
    ID = "Card_Developing",
    CnID = "开发中",
    BaseSortID = 52,
    Desc = "CommonID_Card_Developing_Desc|开发中"
  },
  Card_Extend = {
    ID = "Card_Extend",
    CnID = "衍生卡",
    BaseSortID = 53,
    Desc = "CommonID_Card_Extend_Desc|衍生卡"
  },
  Card_Imagery = {
    ID = "Card_Imagery",
    CnID = "意象",
    BaseSortID = 54,
    Desc = "CommonID_Card_Imagery_Desc|意象"
  },
  Card_AdvancedImagery = {
    ID = "Card_AdvancedImagery",
    CnID = "高级意象",
    BaseSortID = 55,
    Desc = "CommonID_Card_AdvancedImagery_Desc|高级意象"
  },
  Card_AttachPost = {
    ID = "Card_AttachPost",
    CnID = "追击",
    BaseSortID = 56,
    Desc = "CommonID_Card_AttachPost_Desc|追击"
  },
  Card_Fraud = {
    ID = "Card_Fraud",
    CnID = "欺诈",
    BaseSortID = 57,
    Desc = "CommonID_Card_Fraud_Desc|欺诈"
  },
  Intent_Attack = {
    ID = "Intent_Attack",
    CnID = "怪物意图攻击",
    BaseSortID = 58,
    Desc = "CommonID_Intent_Attack_Desc|怪物意图攻击"
  },
  Intent_HeavyAttack = {
    ID = "Intent_HeavyAttack",
    CnID = "怪物意图重攻击",
    BaseSortID = 59,
    Desc = "CommonID_Intent_HeavyAttack_Desc|怪物意图重攻击"
  },
  Intent_HeavyAttackDCB02 = {
    ID = "Intent_HeavyAttackDCB02",
    CnID = "怪物意图人面犬重攻击",
    BaseSortID = 60,
    Desc = "CommonID_Intent_HeavyAttackDCB02_Desc|怪物意图重攻击"
  },
  Intent_Debuff = {
    ID = "Intent_Debuff",
    CnID = "怪物意图削弱",
    BaseSortID = 61,
    Desc = "CommonID_Intent_Debuff_Desc|怪物意图削弱"
  },
  Intent_StrongDebuff = {
    ID = "Intent_StrongDebuff",
    CnID = "怪物意图强力削弱",
    BaseSortID = 62,
    Desc = "CommonID_Intent_StrongDebuff_Desc|怪物意图强力削弱"
  },
  Intent_Buff = {
    ID = "Intent_Buff",
    CnID = "怪物意图强化",
    BaseSortID = 63,
    Desc = "CommonID_Intent_Buff_Desc|怪物意图强化"
  },
  Intent_StrongBuff = {
    ID = "Intent_StrongBuff",
    CnID = "怪物意图强力强化",
    BaseSortID = 64,
    Desc = "CommonID_Intent_StrongBuff_Desc|怪物意图强力强化"
  },
  Intent_Burst = {
    ID = "Intent_Burst",
    CnID = "怪物意图狂气",
    BaseSortID = 65,
    Desc = "CommonID_Intent_Burst_Desc|怪物意图狂气"
  },
  Intent_Burst2 = {
    ID = "Intent_Burst2",
    CnID = "怪物意图狂气非攻击",
    BaseSortID = 66,
    Desc = "CommonID_Intent_Burst2_Desc|怪物意图狂气非攻击"
  },
  Intent_Burst3 = {
    ID = "Intent_Burst3",
    CnID = "怪物意图超级狂气",
    BaseSortID = 67,
    Desc = "CommonID_Intent_Burst3_Desc|怪物意图超级狂气"
  },
  Intent_Burst4 = {
    ID = "Intent_Burst4",
    CnID = "怪物意图释放终结",
    BaseSortID = 68,
    Desc = "CommonID_Intent_Burst4_Desc|怪物意图释放终结"
  },
  Intent_Defence = {
    ID = "Intent_Defence",
    CnID = "怪物意图防御",
    BaseSortID = 69,
    Desc = "CommonID_Intent_Defence_Desc|怪物意图防御"
  },
  Intent_AttackDefence = {
    ID = "Intent_AttackDefence",
    CnID = "怪物意图攻击和防御",
    BaseSortID = 70,
    Desc = "CommonID_Intent_AttackDefence_Desc|怪物意图攻击和防御"
  },
  Intent_AttackDebuff = {
    ID = "Intent_AttackDebuff",
    CnID = "怪物意图攻击和削弱",
    BaseSortID = 71,
    Desc = "CommonID_Intent_AttackDebuff_Desc|怪物意图攻击和削弱"
  },
  Intent_AttackBuff = {
    ID = "Intent_AttackBuff",
    CnID = "怪物意图攻击和强化",
    BaseSortID = 72,
    Desc = "CommonID_Intent_AttackBuff_Desc|怪物意图攻击和强化"
  },
  Intent_DefenceBuff = {
    ID = "Intent_DefenceBuff",
    CnID = "怪物意图防御和强化",
    BaseSortID = 73,
    Desc = "CommonID_Intent_DefenceBuff_Desc|怪物意图防御和强化"
  },
  Intent_DefenceDebuff = {
    ID = "Intent_DefenceDebuff",
    CnID = "怪物意图防御和削弱",
    BaseSortID = 74,
    Desc = "CommonID_Intent_DefenceDebuff_Desc|怪物意图防御和削弱"
  },
  Intent_Dizzy = {
    ID = "Intent_Dizzy",
    CnID = "怪物意图眩晕",
    BaseSortID = 75,
    Desc = "CommonID_Intent_Dizzy_Desc|怪物意图眩晕"
  },
  Intent_Unknown = {
    ID = "Intent_Unknown",
    CnID = "怪物意图不明",
    BaseSortID = 76,
    Desc = "CommonID_Intent_Unknown_Desc|怪物意图不明"
  },
  Intent_Unknown1 = {
    ID = "Intent_Unknown1",
    CnID = "怪物意图不明呢喃1",
    BaseSortID = 77,
    Desc = "CommonID_Intent_Unknown1_Desc|怪物意图不明"
  },
  Intent_Unknown2 = {
    ID = "Intent_Unknown2",
    CnID = "怪物意图不明呢喃2",
    BaseSortID = 78,
    Desc = "CommonID_Intent_Unknown2_Desc|怪物意图不明"
  },
  Intent_Unknown3 = {
    ID = "Intent_Unknown3",
    CnID = "怪物意图不明呢喃3",
    BaseSortID = 79,
    Desc = "CommonID_Intent_Unknown3_Desc|怪物意图不明"
  },
  Intent_Unknown4 = {
    ID = "Intent_Unknown4",
    CnID = "怪物意图不明呢喃4",
    BaseSortID = 80,
    Desc = "CommonID_Intent_Unknown4_Desc|怪物意图不明"
  },
  Intent_Unknown5 = {
    ID = "Intent_Unknown5",
    CnID = "怪物意图不明呢喃5",
    BaseSortID = 81,
    Desc = "CommonID_Intent_Unknown5_Desc|怪物意图不明"
  },
  Intent_Unknown6 = {
    ID = "Intent_Unknown6",
    CnID = "怪物意图不明呢喃6",
    BaseSortID = 82,
    Desc = "CommonID_Intent_Unknown6_Desc|怪物意图不明"
  },
  Intent_AttackDebuffD09Skill2 = {
    ID = "Intent_AttackDebuffD09Skill2",
    CnID = "怪物意图攻击和削弱卡茜亚隔空取物",
    BaseSortID = 83,
    Desc = "CommonID_Intent_AttackDebuffD09Skill2_Desc|怪物意图攻击和削弱"
  },
  Intent_DCB022Buff = {
    ID = "Intent_DCB022Buff",
    CnID = "怪物意图强化DCB02_2",
    BaseSortID = 84,
    Desc = "CommonID_Intent_DCB022Buff_Desc|怪物意图强化"
  },
  Intent_DCB024Buff = {
    ID = "Intent_DCB024Buff",
    CnID = "怪物意图强化DCB02_4",
    BaseSortID = 85,
    Desc = "CommonID_Intent_DCB024Buff_Desc|怪物意图强化"
  },
  CastSkillLevel = {
    ID = "CastSkillLevel",
    CnID = "施法技能等级",
    BaseSortID = 86,
    Desc = "CommonID_CastSkillLevel_Desc|施法技能等级"
  },
  SlotCardLevel = {
    ID = "SlotCardLevel",
    CnID = "原始槽位等级",
    BaseSortID = 87,
    Desc = "CommonID_SlotCardLevel_Desc|原始槽位等级"
  },
  TRUE = {
    ID = "TRUE",
    CnID = "是",
    BaseSortID = 88,
    Desc = "CommonID_TRUE_Desc|是"
  },
  FALSE = {
    ID = "FALSE",
    CnID = "否",
    BaseSortID = 89,
    Desc = "CommonID_FALSE_Desc|否"
  },
  Elite = {
    ID = "Elite",
    CnID = "精英",
    BaseSortID = 90,
    Desc = "CommonID_Elite_Desc|精英"
  },
  Boss = {
    ID = "Boss",
    CnID = "首领",
    BaseSortID = 91,
    Desc = "CommonID_Boss_Desc|首领"
  },
  Common = {
    ID = "Common",
    CnID = "普通",
    BaseSortID = 92,
    Desc = "CommonID_Common_Desc|普通"
  },
  MonsterGrade1 = {
    ID = "MonsterGrade1",
    CnID = "一档小怪",
    BaseSortID = 93,
    Desc = "CommonID_MonsterGrade1_Desc|一档小怪"
  },
  MonsterGrade2 = {
    ID = "MonsterGrade2",
    CnID = "二档小怪",
    BaseSortID = 94,
    Desc = "CommonID_MonsterGrade2_Desc|二档小怪"
  },
  AwakerMonster = {
    ID = "AwakerMonster",
    CnID = "唤醒体首领",
    BaseSortID = 95,
    Desc = "CommonID_AwakerMonster_Desc|唤醒体首领"
  },
  NotAwakerMonster = {
    ID = "NotAwakerMonster",
    CnID = "非唤醒体首领",
    BaseSortID = 96,
    Desc = "CommonID_NotAwakerMonster_Desc|非唤醒体首领"
  },
  MotherTreeMonster = {
    ID = "MotherTreeMonster",
    CnID = "丰穰母树",
    BaseSortID = 97,
    Desc = "CommonID_MotherTreeMonster_Desc|丰穰母树"
  },
  TaweiMonster = {
    ID = "TaweiMonster",
    CnID = "暗塔薇",
    BaseSortID = 98,
    Desc = "CommonID_TaweiMonster_Desc|暗塔薇"
  },
  Relic = {
    ID = "Relic",
    CnID = "造物",
    BaseSortID = 99,
    Desc = "CommonID_Relic_Desc|造物"
  },
  Enchant = {
    ID = "Enchant",
    CnID = "刻印",
    BaseSortID = 100,
    Desc = "CommonID_Enchant_Desc|刻印"
  },
  SellCard = {
    ID = "SellCard",
    CnID = "卖卡",
    BaseSortID = 101,
    Desc = "CommonID_SellCard_Desc|卖卡"
  },
  T = {
    ID = "T",
    CnID = "防御型",
    BaseSortID = 102,
    Desc = "CommonID_T_Desc|防御型"
  },
  SUP = {
    ID = "SUP",
    CnID = "辅助型",
    BaseSortID = 103,
    Desc = "CommonID_SUP_Desc|辅助型"
  },
  DPS = {
    ID = "DPS",
    CnID = "伤害型",
    BaseSortID = 104,
    Desc = "CommonID_DPS_Desc|伤害型"
  },
  White = {
    ID = "White",
    CnID = "白银",
    BaseSortID = 105,
    Desc = "CommonID_White_Desc|白银"
  },
  Blue = {
    ID = "Blue",
    CnID = "蓝色",
    BaseSortID = 106,
    Desc = "CommonID_Blue_Desc|蓝色"
  },
  Orange = {
    ID = "Orange",
    CnID = "黄金",
    BaseSortID = 107,
    Desc = "CommonID_Orange_Desc|黄金"
  },
  Red = {
    ID = "Red",
    CnID = "诅咒",
    BaseSortID = 108,
    Desc = "CommonID_Red_Desc|诅咒"
  },
  All = {
    ID = "All",
    CnID = "所有",
    BaseSortID = 109,
    Desc = "CommonID_All_Desc|所有"
  },
  Purple = {
    ID = "Purple",
    CnID = "时灵摆",
    BaseSortID = 110,
    Desc = "CommonID_Purple_Desc|时灵摆"
  },
  Sin = {
    ID = "Sin",
    CnID = "原罪",
    BaseSortID = 111,
    Desc = "CommonID_Sin_Desc|原罪"
  },
  Holy = {
    ID = "Holy",
    CnID = "圣化",
    BaseSortID = 112,
    Desc = "CommonID_Holy_Desc|圣化"
  },
  Forged = {
    ID = "Forged",
    CnID = "强化",
    BaseSortID = 113,
    Desc = "CommonID_Forged_Desc|强化"
  },
  Change_Skill = {
    ID = "Change_Skill",
    CnID = "替换技能",
    BaseSortID = 114,
    Desc = "CommonID_Change_Skill_Desc|替换技能"
  },
  Add_State = {
    ID = "Add_State",
    CnID = "添加状态",
    BaseSortID = 115,
    Desc = "CommonID_Add_State_Desc|添加状态"
  },
  Skill_LevelUp = {
    ID = "Skill_LevelUp",
    CnID = "升级技能",
    BaseSortID = 116,
    Desc = "CommonID_Skill_LevelUp_Desc|升级技能"
  },
  CardSlots_LevelUp = {
    ID = "CardSlots_LevelUp",
    CnID = "升级槽位",
    BaseSortID = 117,
    Desc = "CommonID_CardSlots_LevelUp_Desc|升级槽位"
  },
  Attr_Promote = {
    ID = "Attr_Promote",
    CnID = "属性提升",
    BaseSortID = 118,
    Desc = "CommonID_Attr_Promote_Desc|属性提升"
  },
  UtlSkill_Promote = {
    ID = "UtlSkill_Promote",
    CnID = "超限狂气爆发",
    BaseSortID = 119,
    Desc = "CommonID_UtlSkill_Promote_Desc|超限狂气爆发"
  },
  LevelLimit_Promote = {
    ID = "LevelLimit_Promote",
    CnID = "等级上限提升",
    BaseSortID = 120,
    Desc = "CommonID_LevelLimit_Promote_Desc|等级上限提升"
  },
  PassiveSkill = {
    ID = "PassiveSkill",
    CnID = "被动技能",
    BaseSortID = 121,
    Desc = "CommonID_PassiveSkill_Desc|被动技能"
  },
  ComingSoon = {
    ID = "ComingSoon",
    CnID = "敬请期待",
    BaseSortID = 122,
    Desc = "CommonID_ComingSoon_Desc|敬请期待"
  },
  CommonAttr = {
    ID = "CommonAttr",
    CnID = "通用属性加成",
    BaseSortID = 123,
    Desc = "CommonID_CommonAttr_Desc|通用属性加成"
  },
  cast = {
    ID = "cast",
    CnID = "事件帧1",
    BaseSortID = 124
  },
  cast2 = {
    ID = "cast2",
    CnID = "事件帧2",
    BaseSortID = 125
  },
  cast3 = {
    ID = "cast3",
    CnID = "事件帧3",
    BaseSortID = 126
  },
  timeline_end = {
    ID = "timeline_end",
    CnID = "结尾",
    BaseSortID = 127
  },
  ["UI_Story_D_Image_Face_Surprise1.png"] = {
    ID = "UI_Story_D_Image_Face_Surprise1.png",
    CnID = "惊讶1",
    BaseSortID = 128
  },
  ["UI_Story_D_Image_Face_Surprise2.png"] = {
    ID = "UI_Story_D_Image_Face_Surprise2.png",
    CnID = "惊讶2",
    BaseSortID = 129
  },
  ["UI_Story_D_Image_Face_Happy.png"] = {
    ID = "UI_Story_D_Image_Face_Happy.png",
    CnID = "开心",
    BaseSortID = 130
  },
  ["UI_Story_D_Image_Face_Sweat.png"] = {
    ID = "UI_Story_D_Image_Face_Sweat.png",
    CnID = "流汗",
    BaseSortID = 131
  },
  ["UI_Story_D_Image_Face_Angry.png"] = {
    ID = "UI_Story_D_Image_Face_Angry.png",
    CnID = "生气",
    BaseSortID = 132
  },
  ["UI_Story_D_Image_Face_Speechless.png"] = {
    ID = "UI_Story_D_Image_Face_Speechless.png",
    CnID = "无语",
    BaseSortID = 133
  },
  avg_dialog_Amplification = {
    ID = "avg_dialog_Amplification",
    CnID = "放大",
    BaseSortID = 134
  },
  avg_dialog_Lessen = {
    ID = "avg_dialog_Lessen",
    CnID = "缩小",
    BaseSortID = 135
  },
  UI_Story_Panel_AvgDialogBg_zuoyou_vx = {
    ID = "UI_Story_Panel_AvgDialogBg_zuoyou_vx",
    CnID = "左右平移",
    BaseSortID = 136
  },
  UI_Story_Panel_AvgDialogBg_doudong_vx = {
    ID = "UI_Story_Panel_AvgDialogBg_doudong_vx",
    CnID = "屏幕抖动",
    BaseSortID = 137
  },
  UI_Story_Panel_AvgDialogBg_fangda_vx = {
    ID = "UI_Story_Panel_AvgDialogBg_fangda_vx",
    CnID = "放大背景",
    BaseSortID = 138
  },
  UI_Story_Panel_Group_Dialog_doudong_vx = {
    ID = "UI_Story_Panel_Group_Dialog_doudong_vx",
    CnID = "对话框抖动",
    BaseSortID = 139
  },
  UI_Story_shouji_yty_vx = {
    ID = "UI_Story_shouji_yty_vx",
    CnID = "白光受击",
    BaseSortID = 140
  },
  UI_Story_Panel_AvgDialogBg_doudong_vx_01 = {
    ID = "UI_Story_Panel_AvgDialogBg_doudong_vx_01",
    CnID = "屏幕抖动2",
    BaseSortID = 141
  },
  UI_Story_Panel_AvgDialogBg_zuoyou_vx_01 = {
    ID = "UI_Story_Panel_AvgDialogBg_zuoyou_vx_01",
    CnID = "左右平移2",
    BaseSortID = 142
  },
  PlayVideoCaption = {
    ID = "PlayVideoCaption",
    CnID = "播放视频字幕",
    BaseSortID = 143
  },
  AvgFontSmall = {
    ID = "AvgFontSmall",
    CnID = "avg字号@小",
    BaseSortID = 144
  },
  AvgFontNormal = {
    ID = "AvgFontNormal",
    CnID = "avg字号@默认",
    BaseSortID = 145
  },
  AvgFontBig = {
    ID = "AvgFontBig",
    CnID = "avg字号@大",
    BaseSortID = 146
  },
  AvgHorizontal = {
    ID = "AvgHorizontal",
    CnID = "横版立绘",
    BaseSortID = 147
  },
  AvgVertical = {
    ID = "AvgVertical",
    CnID = "竖版立绘",
    BaseSortID = 148
  },
  AvgBig = {
    ID = "AvgBig",
    CnID = "近景立绘",
    BaseSortID = 149
  },
  smoke = {
    ID = "smoke",
    CnID = "烟雾",
    BaseSortID = 150
  },
  awake = {
    ID = "awake",
    CnID = "睁眼",
    BaseSortID = 151
  },
  retro = {
    ID = "retro",
    CnID = "回忆",
    BaseSortID = 152
  },
  mucus = {
    ID = "mucus",
    CnID = "粘液",
    BaseSortID = 153
  },
  flame = {
    ID = "flame",
    CnID = "火焰",
    BaseSortID = 154
  },
  rain = {
    ID = "rain",
    CnID = "下雨",
    BaseSortID = 155
  },
  snow = {
    ID = "snow",
    CnID = "下雪",
    BaseSortID = 156
  },
  disturb = {
    ID = "disturb",
    CnID = "眩晕",
    BaseSortID = 157
  },
  speedLine = {
    ID = "speedLine",
    CnID = "疾风",
    BaseSortID = 158
  },
  continueShake = {
    ID = "continueShake",
    CnID = "持续抖动",
    BaseSortID = 159
  },
  keyWorkVideo = {
    ID = "keyWorkVideo",
    CnID = "银钥发动视频",
    BaseSortID = 160
  },
  keyWorkEffect = {
    ID = "keyWorkEffect",
    CnID = "银钥发动特效",
    BaseSortID = 161
  },
  whiteSmoke = {
    ID = "whiteSmoke",
    CnID = "薄雾",
    BaseSortID = 162
  },
  lightRain = {
    ID = "lightRain",
    CnID = "小雨",
    BaseSortID = 163
  },
  oldFilm = {
    ID = "oldFilm",
    CnID = "老胶片",
    BaseSortID = 164
  },
  redScreen = {
    ID = "redScreen",
    CnID = "红光一闪",
    BaseSortID = 165
  },
  closeEye = {
    ID = "closeEye",
    CnID = "闭眼",
    BaseSortID = 166
  },
  redFlower = {
    ID = "redFlower",
    CnID = "红花",
    BaseSortID = 167
  },
  blackFlower = {
    ID = "blackFlower",
    CnID = "黑花",
    BaseSortID = 168
  },
  bloodSmoke = {
    ID = "bloodSmoke",
    CnID = "血雾",
    BaseSortID = 169
  },
  blinkEye = {
    ID = "blinkEye",
    CnID = "眨眼",
    BaseSortID = 170
  },
  blackSmoke = {
    ID = "blackSmoke",
    CnID = "黑雾",
    BaseSortID = 171
  },
  redLoop = {
    ID = "redLoop",
    CnID = "持续红色",
    BaseSortID = 172
  },
  starlight = {
    ID = "starlight",
    CnID = "星光",
    BaseSortID = 173
  },
  lamplight = {
    ID = "lamplight",
    CnID = "灯光",
    BaseSortID = 174
  },
  sandStorm = {
    ID = "sandStorm",
    CnID = "沙暴",
    BaseSortID = 175
  },
  erosion = {
    ID = "erosion",
    CnID = "融蚀",
    BaseSortID = 176
  },
  disturbFx = {
    ID = "disturbFx",
    CnID = "眩晕纯特效",
    BaseSortID = 177
  },
  whiteSmokeFall = {
    ID = "whiteSmokeFall",
    CnID = "白烟下坠",
    BaseSortID = 178
  },
  whiteSmokeFallLoop = {
    ID = "whiteSmokeFallLoop",
    CnID = "白烟下坠循环",
    BaseSortID = 179
  },
  ["0.5,0.5"] = {
    ID = "0.5,0.5",
    CnID = "屏幕中心",
    BaseSortID = 180
  },
  ["0.5,0"] = {
    ID = "0.5,0",
    CnID = "屏幕底部中心",
    BaseSortID = 181
  },
  ["0.5,1"] = {
    ID = "0.5,1",
    CnID = "屏幕顶部中心",
    BaseSortID = 182
  },
  ["0.5,0.2"] = {
    ID = "0.5,0.2",
    CnID = "屏幕下方中心",
    BaseSortID = 183
  },
  ["0.5,0.75"] = {
    ID = "0.5,0.75",
    CnID = "屏幕上方中心",
    BaseSortID = 184
  },
  ["0.25,0.25"] = {
    ID = "0.25,0.25",
    CnID = "屏幕左下中心",
    BaseSortID = 185
  },
  ["0.25,0.75"] = {
    ID = "0.25,0.75",
    CnID = "屏幕左上中心",
    BaseSortID = 186
  },
  ["0.75,0.75"] = {
    ID = "0.75,0.75",
    CnID = "屏幕右上中心",
    BaseSortID = 187
  },
  ["0.75,0.25"] = {
    ID = "0.75,0.25",
    CnID = "屏幕右下中心",
    BaseSortID = 188
  },
  ["0.25,0.5"] = {
    ID = "0.25,0.5",
    CnID = "屏幕左侧中心",
    BaseSortID = 189
  },
  ["0.75,0.5"] = {
    ID = "0.75,0.5",
    CnID = "屏幕右侧中心",
    BaseSortID = 190
  },
  GO_UP = {
    ID = "GO_UP",
    CnID = "组件上方",
    BaseSortID = 191
  },
  GO_DOWN = {
    ID = "GO_DOWN",
    CnID = "组件下方",
    BaseSortID = 192
  },
  GO_CENTER = {
    ID = "GO_CENTER",
    CnID = "组件中间",
    BaseSortID = 193
  },
  GO_LEFT = {
    ID = "GO_LEFT",
    CnID = "组件左边",
    BaseSortID = 194
  },
  GO_RIGHT = {
    ID = "GO_RIGHT",
    CnID = "组件右边",
    BaseSortID = 195
  },
  ["UIRoot.UI_Battle_Panel_Dbg(Clone).Group_Endofturn"] = {
    ID = "UIRoot.UI_Battle_Panel_Dbg(Clone).Group_Endofturn",
    CnID = "指引组件@回合结束按钮",
    BaseSortID = 196
  },
  ["SceneRoot.UI_Battle_Item_Intention(Clone)"] = {
    ID = "SceneRoot.UI_Battle_Item_Intention(Clone)",
    CnID = "指引组件@第一个怪物意图",
    BaseSortID = 197
  },
  ["UIRoot.UI_Dbgcopy_Panel_Main(Clone).UIDbgcopyItem_1"] = {
    ID = "UIRoot.UI_Dbgcopy_Panel_Main(Clone).UIDbgcopyItem_1",
    CnID = "指引组件@第一个造物",
    BaseSortID = 198
  },
  GuideGearItem = {
    ID = "GuideGearItem",
    CnID = "指引组件@触发事件节点",
    BaseSortID = 199
  },
  GuideBattleAwakerHead = {
    ID = "GuideBattleAwakerHead",
    CnID = "指引组件@战斗知者头像",
    BaseSortID = 200
  },
  ["UIRoot.UI_Battle_Panel_Dbg(Clone).Card_Content"] = {
    ID = "UIRoot.UI_Battle_Panel_Dbg(Clone).Card_Content",
    CnID = "指引组件@战斗手牌堆",
    BaseSortID = 201
  },
  ["UI_Main_Panel_1(Clone).Btn_Recruit"] = {
    ID = "UI_Main_Panel_1(Clone).Btn_Recruit",
    CnID = "指引组件@唤醒界面按钮",
    BaseSortID = 202
  },
  GuideGo_NormalSummonBtn = {
    ID = "GuideGo_NormalSummonBtn",
    CnID = "指引组件@界域研习标签",
    BaseSortID = 203
  },
  GuideGo_SummonFiveBtn = {
    ID = "GuideGo_SummonFiveBtn",
    CnID = "指引组件@唤醒5次按钮",
    BaseSortID = 204
  },
  ["UI_Summon_Popup_Total_Show(Clone).UI_Common_Btn_Back3.Image_Icon"] = {
    ID = "UI_Summon_Popup_Total_Show(Clone).UI_Common_Btn_Back3.Image_Icon",
    CnID = "指引组件@抽卡结果退出按钮",
    BaseSortID = 205
  },
  ["UI_Summon_Panel_Main(Clone).UI_Common_Btn_Back3.Image_Icon"] = {
    ID = "UI_Summon_Panel_Main(Clone).UI_Common_Btn_Back3.Image_Icon",
    CnID = "指引组件@唤醒退出按钮",
    BaseSortID = 206
  },
  ["UI_Main_Panel_1(Clone).Btn_Dbg"] = {
    ID = "UI_Main_Panel_1(Clone).Btn_Dbg",
    CnID = "指引组件@幕间演习按钮",
    BaseSortID = 207
  },
  ["UI_Dungeons_Main_View(Clone).UI_Common_Btn_Question"] = {
    ID = "UI_Dungeons_Main_View(Clone).UI_Common_Btn_Question",
    CnID = "指引组件@幕间演习-唤醒体试玩-规则",
    BaseSortID = 208
  },
  GuideGo_ExitAwakerTrail = {
    ID = "GuideGo_ExitAwakerTrail",
    CnID = "指引组件@幕间演习-关闭",
    BaseSortID = 209
  },
  ["UI_Main_Panel_1(Clone).Btn_Awaker"] = {
    ID = "UI_Main_Panel_1(Clone).Btn_Awaker",
    CnID = "指引组件@唤醒体按钮",
    BaseSortID = 210
  },
  GuideGo_EnterAwakerDetailBtn = {
    ID = "GuideGo_EnterAwakerDetailBtn",
    CnID = "指引组件@唤醒体详情按钮",
    BaseSortID = 211
  },
  ["UI_Awaker_Panel_Main(Clone).UI_Awaker_Item_Info.Btn_Level_Up"] = {
    ID = "UI_Awaker_Panel_Main(Clone).UI_Awaker_Item_Info.Btn_Level_Up",
    CnID = "指引组件@唤醒体进入升级按钮",
    BaseSortID = 212
  },
  ["UI_Awaker_Panel_Main(Clone).UI_Awaker_Item_Topped_DetailUp.Btn_Breakthrough.Group_High"] = {
    ID = "UI_Awaker_Panel_Main(Clone).UI_Awaker_Item_Topped_DetailUp.Btn_Breakthrough.Group_High",
    CnID = "指引组件@唤醒体升级按钮",
    BaseSortID = 213
  },
  GuideGo_AwakerLvUpBackBtn = {
    ID = "GuideGo_AwakerLvUpBackBtn",
    CnID = "指引组件@唤醒体升级成功返回",
    BaseSortID = 214
  },
  ["UI_Awaker_Panel_Main(Clone).UI_Awaker_Item_Topped_DetailUp.UI_Awaker_Button_Addition"] = {
    ID = "UI_Awaker_Panel_Main(Clone).UI_Awaker_Item_Topped_DetailUp.UI_Awaker_Button_Addition",
    CnID = "指引组件@唤醒体升级自动置入",
    BaseSortID = 215
  },
  GuideGo_AwakerBackBtn = {
    ID = "GuideGo_AwakerBackBtn",
    CnID = "指引组件@唤醒体返回按钮",
    BaseSortID = 216
  },
  GuideGo_AwakerCloseBtn = {
    ID = "GuideGo_AwakerCloseBtn",
    CnID = "指引组件@唤醒体关闭按钮",
    BaseSortID = 217
  },
  ["UI_Main_Panel_1(Clone).Btn_Formation"] = {
    ID = "UI_Main_Panel_1(Clone).Btn_Formation",
    CnID = "指引组件@编队按钮",
    BaseSortID = 218
  },
  ["UI_Team_Panel_Main(Clone).Btn_Fast.Group_High.bg"] = {
    ID = "UI_Team_Panel_Main(Clone).Btn_Fast.Group_High.bg",
    CnID = "指引组件@编队-快速编队按钮",
    BaseSortID = 219
  },
  GuideGo_QuickBuildAwaker1 = {
    ID = "GuideGo_QuickBuildAwaker1",
    CnID = "指引组件@编队-唤醒体1",
    BaseSortID = 220
  },
  GuideGo_QuickBuildAwaker2 = {
    ID = "GuideGo_QuickBuildAwaker2",
    CnID = "指引组件@编队-唤醒体2",
    BaseSortID = 221
  },
  GuideGo_QuickBuildAwaker3 = {
    ID = "GuideGo_QuickBuildAwaker3",
    CnID = "指引组件@编队-唤醒体3",
    BaseSortID = 222
  },
  GuideGo_QuickBuildAwaker4 = {
    ID = "GuideGo_QuickBuildAwaker4",
    CnID = "指引组件@编队-唤醒体4",
    BaseSortID = 223
  },
  GuideGo_QuickSaveBtn = {
    ID = "GuideGo_QuickSaveBtn",
    CnID = "指引组件@编队-保存",
    BaseSortID = 224
  },
  ["UI_Team_Panel_Main(Clone).UI_Common_Btn_Back3.Image_Icon"] = {
    ID = "UI_Team_Panel_Main(Clone).UI_Common_Btn_Back3.Image_Icon",
    CnID = "指引组件@编队-退出",
    BaseSortID = 225
  },
  GuideGo_AwakerWeapon1 = {
    ID = "GuideGo_AwakerWeapon1",
    CnID = "指引组件@唤醒体命轮按钮1",
    BaseSortID = 226
  },
  GuideGo_EquipWeapon1 = {
    ID = "GuideGo_EquipWeapon1",
    CnID = "指引组件@命轮列表1",
    BaseSortID = 227
  },
  GuideGo_EquipWeaponSave = {
    ID = "GuideGo_EquipWeaponSave",
    CnID = "指引组件@命轮装备按钮",
    BaseSortID = 228
  },
  GuideGo_EquipWeaponClose = {
    ID = "GuideGo_EquipWeaponClose",
    CnID = "指引组件@命轮界面退出",
    BaseSortID = 229
  },
  ["UI_Team_Panel_Main(Clone).Btn_Skill"] = {
    ID = "UI_Team_Panel_Main(Clone).Btn_Skill",
    CnID = "指引组件@钥令",
    BaseSortID = 230
  },
  ["UI_Keeper_Skill_Panel(Clone).UI_Keeper_Skill_Item(Clone)"] = {
    ID = "UI_Keeper_Skill_Panel(Clone).UI_Keeper_Skill_Item(Clone)",
    CnID = "指引组件@钥令列表1",
    BaseSortID = 231
  },
  GuideGo_KeeperSkillSave = {
    ID = "GuideGo_KeeperSkillSave",
    CnID = "指引组件@钥令选择按钮",
    BaseSortID = 232
  },
  GuideGo_KeeperSkillClose = {
    ID = "GuideGo_KeeperSkillClose",
    CnID = "指引组件@钥令退出",
    BaseSortID = 233
  },
  ["UI_Main_Panel_1(Clone).Btn_MQ"] = {
    ID = "UI_Main_Panel_1(Clone).Btn_MQ",
    CnID = "指引组件@调查按钮",
    BaseSortID = 234
  },
  GuideGo_BtnChapter1 = {
    ID = "GuideGo_BtnChapter1",
    CnID = "指引组件@第一章按钮",
    BaseSortID = 235
  },
  ["UI_Chapter_Panel_Main(Clone).UI_Chaper_Item_Level_Content(Clone)"] = {
    ID = "UI_Chapter_Panel_Main(Clone).UI_Chaper_Item_Level_Content(Clone)",
    CnID = "指引组件@关卡1-1",
    BaseSortID = 236
  },
  GuideGo_GoldVoucherInvestigation = {
    ID = "GuideGo_GoldVoucherInvestigation",
    CnID = "指引组件@幕间演习-融蚀之墟-金币本",
    BaseSortID = 237
  },
  GuideGo_PotionRefinement = {
    ID = "GuideGo_PotionRefinement",
    CnID = "指引组件@幕间演习-融蚀之墟-经验本",
    BaseSortID = 238
  },
  GuideGo_OrganicAfterimage = {
    ID = "GuideGo_OrganicAfterimage",
    CnID = "指引组件@幕间演习-融蚀之墟-混沌升格素材本",
    BaseSortID = 239
  },
  AwakerUpgradedCompleted = {
    ID = "AwakerUpgradedCompleted",
    CnID = "指引结束条件@已完成唤醒体升级",
    BaseSortID = 240
  },
  TeamFormationCompleted = {
    ID = "TeamFormationCompleted",
    CnID = "指引结束条件@已完成编队",
    BaseSortID = 241
  },
  WeaponFormationCompleted = {
    ID = "WeaponFormationCompleted",
    CnID = "指引结束条件@已装备命轮",
    BaseSortID = 242
  },
  SkillFormationCompleted = {
    ID = "SkillFormationCompleted",
    CnID = "指引结束条件@已装备钥令",
    BaseSortID = 243
  },
  ThreeOrMoreSchoolAwaker = {
    ID = "ThreeOrMoreSchoolAwaker",
    CnID = "指引结束条件@三个界域及以上唤醒体",
    BaseSortID = 244
  },
  ["UI_Main_Panel_1(Clone).Btn_Mission"] = {
    ID = "UI_Main_Panel_1(Clone).Btn_Mission",
    CnID = "指引组件@学籍档案按钮",
    BaseSortID = 245
  },
  ["UI_Task_Panel_Main_New(Clone).Btn_Task7"] = {
    ID = "UI_Task_Panel_Main_New(Clone).Btn_Task7",
    CnID = "指引组件@实战教学页签",
    BaseSortID = 246
  },
  ["UI_Dungeons_BattleTeaching_View.GuideRoot"] = {
    ID = "UI_Dungeons_BattleTeaching_View.GuideRoot",
    CnID = "指引组件@实战教学关卡组",
    BaseSortID = 247
  },
  ["UI_Dungeons_BattleTeaching_View.Btn_Enter"] = {
    ID = "UI_Dungeons_BattleTeaching_View.Btn_Enter",
    CnID = "指引组件@实战教学开始训练按钮",
    BaseSortID = 248
  },
  DungeonBattleTeachingView = {
    ID = "DungeonBattleTeachingView",
    CnID = "指引界面@实战教学界面",
    BaseSortID = 249
  },
  TaskCareerView = {
    ID = "TaskCareerView",
    CnID = "指引界面@学籍档案",
    BaseSortID = 250
  },
  MainPanel = {
    ID = "MainPanel",
    CnID = "指引界面@主界面",
    BaseSortID = 251
  },
  SummonPanel = {
    ID = "SummonPanel",
    CnID = "指引界面@唤醒界面",
    BaseSortID = 252
  },
  GuidePanel_NormalSummon = {
    ID = "GuidePanel_NormalSummon",
    CnID = "指引界面@唤醒-界域研习",
    BaseSortID = 253
  },
  ["UI.Summon.Panel.SummonedAwakerPanel"] = {
    ID = "UI.Summon.Panel.SummonedAwakerPanel",
    CnID = "指引界面@抽卡结果",
    BaseSortID = 254
  },
  FreeTrialView = {
    ID = "FreeTrialView",
    CnID = "指引界面@幕间演习-唤醒体试玩",
    BaseSortID = 255
  },
  AwakerBasePanel = {
    ID = "AwakerBasePanel",
    CnID = "指引界面@唤醒体界面",
    BaseSortID = 256
  },
  GuidePanel_AwakerInfoDetail = {
    ID = "GuidePanel_AwakerInfoDetail",
    CnID = "指引界面@唤醒体详情界面",
    BaseSortID = 257
  },
  GuidePanel_AwakerLevelDetail = {
    ID = "GuidePanel_AwakerLevelDetail",
    CnID = "指引界面@唤醒体升级界面",
    BaseSortID = 258
  },
  DBGTeamBuildMainPanel = {
    ID = "DBGTeamBuildMainPanel",
    CnID = "指引界面@编队",
    BaseSortID = 259
  },
  GuidePanel_QuickTeamBuild = {
    ID = "GuidePanel_QuickTeamBuild",
    CnID = "指引界面@编队-快速编队",
    BaseSortID = 260
  },
  TeamWeaponEquipView = {
    ID = "TeamWeaponEquipView",
    CnID = "指引界面@命轮",
    BaseSortID = 261
  },
  KeeperSkillView = {
    ID = "KeeperSkillView",
    CnID = "指引界面@钥令界面",
    BaseSortID = 262
  },
  CopyMainChapterView = {
    ID = "CopyMainChapterView",
    CnID = "指引界面@调查界面",
    BaseSortID = 263
  },
  MainCopyChapterPanel = {
    ID = "MainCopyChapterPanel",
    CnID = "指引界面@章节界面",
    BaseSortID = 264
  },
  GuideTouchEvent = {
    ID = "GuideTouchEvent",
    CnID = "指引条件@点击任意处",
    BaseSortID = 265
  },
  GuideRoleMove = {
    ID = "GuideRoleMove",
    CnID = "指引条件@关卡内移动",
    BaseSortID = 266
  },
  GuideAwakerRage100 = {
    ID = "GuideAwakerRage100",
    CnID = "指引条件@知者狂气为100",
    BaseSortID = 267
  },
  GuideCloseShop = {
    ID = "GuideCloseShop",
    CnID = "指引条件@商店关闭",
    BaseSortID = 268
  },
  GuideBattleUseCard = {
    ID = "GuideBattleUseCard",
    CnID = "指引条件@出牌后",
    BaseSortID = 269
  },
  GuideAwakerUseSkill = {
    ID = "GuideAwakerUseSkill",
    CnID = "指引条件@知者狂气爆发后",
    BaseSortID = 270
  },
  GuideEndLock_Card_Awaker = {
    ID = "GuideEndLock_Card_Awaker",
    CnID = "指引条件@回合结束锁",
    BaseSortID = 271
  },
  GuideEndLock_Card_Awaker_Keeper = {
    ID = "GuideEndLock_Card_Awaker_Keeper",
    CnID = "指引条件@回合结束锁+主角技能锁",
    BaseSortID = 272
  },
  TurnLockCard = {
    ID = "TurnLockCard",
    CnID = "指引条件@回合结束锁卡牌",
    BaseSortID = 273
  },
  TurnLockExSkill = {
    ID = "TurnLockExSkill",
    CnID = "指引条件@回合结束锁狂气",
    BaseSortID = 274
  },
  TurnLockPosse = {
    ID = "TurnLockPosse",
    CnID = "指引条件@回合结束锁主角技能",
    BaseSortID = 275
  },
  NormalRoot = {
    ID = "NormalRoot",
    CnID = "层级@底层",
    BaseSortID = 276
  },
  TipPopRoot = {
    ID = "TipPopRoot",
    CnID = "层级@顶层",
    BaseSortID = 277
  },
  GuideForbidBattleEnd = {
    ID = "GuideForbidBattleEnd",
    CnID = "指引动作@禁用回合结束",
    BaseSortID = 278
  },
  GuideResumeBattleEnd = {
    ID = "GuideResumeBattleEnd",
    CnID = "指引动作@恢复回合结束",
    BaseSortID = 279
  },
  AllAwaker = {
    ID = "AllAwaker",
    CnID = "所有唤醒体",
    BaseSortID = 280
  },
  EnterAvg = {
    ID = "EnterAvg",
    CnID = "进入avg时",
    BaseSortID = 281
  },
  ExitAvg = {
    ID = "ExitAvg",
    CnID = "退出avg时",
    BaseSortID = 282
  },
  EnterCopy = {
    ID = "EnterCopy",
    CnID = "进入探索时",
    BaseSortID = 283
  },
  EnterGame = {
    ID = "EnterGame",
    CnID = "进入游戏时",
    BaseSortID = 284
  },
  EnterMainPanel = {
    ID = "EnterMainPanel",
    CnID = "进入主界面时",
    BaseSortID = 285
  },
  Daily = {
    ID = "Daily",
    CnID = "日常",
    BaseSortID = 286
  },
  Battle = {
    ID = "Battle",
    CnID = "战斗",
    BaseSortID = 287,
    Desc = "CommonID_Battle_Desc|战斗"
  },
  GetAwaker = {
    ID = "GetAwaker",
    CnID = "获得唤醒体",
    BaseSortID = 288
  },
  AwakerPromote = {
    ID = "AwakerPromote",
    CnID = "唤醒体提升",
    BaseSortID = 289
  },
  StageStart = {
    ID = "StageStart",
    CnID = "关卡开始",
    BaseSortID = 290
  },
  StageVictory = {
    ID = "StageVictory",
    CnID = "关卡胜利",
    BaseSortID = 291
  },
  StageFail = {
    ID = "StageFail",
    CnID = "关卡失败",
    BaseSortID = 292
  },
  Hit = {
    ID = "Hit",
    CnID = "受击",
    BaseSortID = 293
  },
  ActivatePotency_1 = {
    ID = "ActivatePotency_1",
    CnID = "唤醒体第一个启灵点激活",
    BaseSortID = 294
  },
  ActivatePotency_2 = {
    ID = "ActivatePotency_2",
    CnID = "唤醒体第二个启灵点激活",
    BaseSortID = 295
  },
  ActivatePotency_3 = {
    ID = "ActivatePotency_3",
    CnID = "唤醒体第三个启灵点激活",
    BaseSortID = 296
  },
  ActivatePotency_4 = {
    ID = "ActivatePotency_4",
    CnID = "唤醒体第四个启灵点激活",
    BaseSortID = 297
  },
  ActivatePotency_5 = {
    ID = "ActivatePotency_5",
    CnID = "唤醒体第五个启灵点激活",
    BaseSortID = 298
  },
  ActivatePotency_6 = {
    ID = "ActivatePotency_6",
    CnID = "唤醒体第六个启灵点激活",
    BaseSortID = 299
  },
  ActivatePotency_7 = {
    ID = "ActivatePotency_7",
    CnID = "唤醒体第七个启灵点激活",
    BaseSortID = 300
  },
  ClickAwaker = {
    ID = "ClickAwaker",
    CnID = "点击唤醒体",
    BaseSortID = 301
  },
  AwakerAppear = {
    ID = "AwakerAppear",
    CnID = "唤醒体出现",
    BaseSortID = 302
  },
  LongPressAwaker = {
    ID = "LongPressAwaker",
    CnID = "长按唤醒体",
    BaseSortID = 303
  },
  Main = {
    ID = "Main",
    CnID = "机位@普通",
    BaseSortID = 304
  },
  NormalBoss = {
    ID = "NormalBoss",
    CnID = "机位@BOSS",
    BaseSortID = 305
  },
  StageBoss = {
    ID = "StageBoss",
    CnID = "机位@关底BOSS",
    BaseSortID = 306
  },
  StageBoss1 = {
    ID = "StageBoss1",
    CnID = "机位@关底BOSS1",
    BaseSortID = 307
  },
  StageBoss2 = {
    ID = "StageBoss2",
    CnID = "机位@关底BOSS2",
    BaseSortID = 308
  },
  StageBoss3 = {
    ID = "StageBoss3",
    CnID = "机位@关底BOSS3",
    BaseSortID = 309
  },
  StageBoss4 = {
    ID = "StageBoss4",
    CnID = "机位@关底BOSS4",
    BaseSortID = 310
  },
  StageBoss5 = {
    ID = "StageBoss5",
    CnID = "机位@关底BOSS5",
    BaseSortID = 311
  },
  StageBoss6 = {
    ID = "StageBoss6",
    CnID = "机位@关底BOSS6",
    BaseSortID = 312
  },
  StageBoss6_2 = {
    ID = "StageBoss6_2",
    CnID = "机位@关底BOSS6_2",
    BaseSortID = 313
  },
  StageBoss7 = {
    ID = "StageBoss7",
    CnID = "机位@关底BOSS7",
    BaseSortID = 314
  },
  StageBoss7_2 = {
    ID = "StageBoss7_2",
    CnID = "机位@关底BOSS7_2",
    BaseSortID = 315
  },
  StageBoss8 = {
    ID = "StageBoss8",
    CnID = "机位@关底BOSS8",
    BaseSortID = 316
  },
  StageBoss8_2 = {
    ID = "StageBoss8_2",
    CnID = "机位@关底BOSS8_2",
    BaseSortID = 317
  },
  StageBoss9 = {
    ID = "StageBoss9",
    CnID = "机位@关底BOSS9",
    BaseSortID = 318
  },
  StageBoss9_2 = {
    ID = "StageBoss9_2",
    CnID = "机位@关底BOSS9_2",
    BaseSortID = 319
  },
  StageBossS201 = {
    ID = "StageBossS201",
    CnID = "机位@StageBossS201",
    BaseSortID = 320
  },
  StageBossS202 = {
    ID = "StageBossS202",
    CnID = "机位@StageBossS202",
    BaseSortID = 321
  },
  StageBossS203 = {
    ID = "StageBossS203",
    CnID = "机位@StageBossS203",
    BaseSortID = 322
  },
  StageBossS204 = {
    ID = "StageBossS204",
    CnID = "机位@StageBossS204",
    BaseSortID = 323
  },
  StageBossS204_2 = {
    ID = "StageBossS204_2",
    CnID = "机位@StageBossS204_2",
    BaseSortID = 324
  },
  StageBossS205 = {
    ID = "StageBossS205",
    CnID = "机位@StageBossS205",
    BaseSortID = 325
  },
  StageBossS205_2 = {
    ID = "StageBossS205_2",
    CnID = "机位@StageBossS205_2",
    BaseSortID = 326
  },
  StageBossS206 = {
    ID = "StageBossS206",
    CnID = "机位@StageBossS206",
    BaseSortID = 327
  },
  StageBossS207 = {
    ID = "StageBossS207",
    CnID = "机位@StageBossS207",
    BaseSortID = 328
  },
  StageBossS208 = {
    ID = "StageBossS208",
    CnID = "机位@StageBossS208",
    BaseSortID = 329
  },
  StageBossS209 = {
    ID = "StageBossS209",
    CnID = "机位@StageBossS209",
    BaseSortID = 330
  },
  ASceneMain = {
    ID = "ASceneMain",
    CnID = "机位@材料本测试",
    BaseSortID = 331
  },
  PVPMain = {
    ID = "PVPMain",
    CnID = "机位@PVP",
    BaseSortID = 332
  },
  Switch = {
    ID = "Switch",
    CnID = "开关",
    BaseSortID = 333,
    Desc = "CommonID_Switch_Desc|开关"
  },
  DropdownList = {
    ID = "DropdownList",
    CnID = "下拉列表",
    BaseSortID = 334,
    Desc = "CommonID_DropdownList_Desc|下拉列表"
  },
  Slider = {
    ID = "Slider",
    CnID = "数值滑块",
    BaseSortID = 335,
    Desc = "CommonID_Slider_Desc|数值滑块"
  },
  BundleShortcutKey = {
    ID = "BundleShortcutKey",
    CnID = "按键绑定",
    BaseSortID = 336,
    Desc = "CommonID_BundleShortcutKey_Desc|按键绑定"
  },
  Entrance = {
    ID = "Entrance",
    CnID = "弹窗入口",
    BaseSortID = 337,
    Desc = "CommonID_Entrance_Desc|弹窗入口"
  },
  Web = {
    ID = "Web",
    CnID = "网页跳转",
    BaseSortID = 338,
    Desc = "CommonID_Web_Desc|网页跳转"
  },
  Open = {
    ID = "Open",
    CnID = "开",
    BaseSortID = 339,
    Desc = "CommonID_Open_Desc|开"
  },
  Close = {
    ID = "Close",
    CnID = "关",
    BaseSortID = 340,
    Desc = "CommonID_Close_Desc|关"
  },
  VeryHigh = {
    ID = "VeryHigh",
    CnID = "极高",
    BaseSortID = 341,
    Desc = "CommonID_VeryHigh_Desc|极高"
  },
  Custom = {
    ID = "Custom",
    CnID = "自定义",
    BaseSortID = 342,
    Desc = "CommonID_Custom_Desc|自定义"
  },
  High = {
    ID = "High",
    CnID = "高",
    BaseSortID = 343,
    Desc = "CommonID_High_Desc|高"
  },
  Middle = {
    ID = "Middle",
    CnID = "中",
    BaseSortID = 344,
    Desc = "CommonID_Middle_Desc|中"
  },
  Low = {
    ID = "Low",
    CnID = "低",
    BaseSortID = 345,
    Desc = "CommonID_Low_Desc|低"
  },
  VeryLow = {
    ID = "VeryLow",
    CnID = "极低",
    BaseSortID = 346,
    Desc = "CommonID_VeryLow_Desc|极低"
  },
  Chinese = {
    ID = "Chinese",
    CnID = "汉语",
    BaseSortID = 347,
    Desc = "CommonID_Chinese_Desc|汉语"
  },
  TW = {
    ID = "TW",
    CnID = "繁体中文",
    BaseSortID = 348,
    Desc = "CommonID_TW_Desc|繁体中文"
  },
  CN = {
    ID = "CN",
    CnID = "简体中文",
    BaseSortID = 349,
    Desc = "CommonID_CN_Desc|简体中文"
  },
  EN = {
    ID = "EN",
    CnID = "英语",
    BaseSortID = 350,
    Desc = "CommonID_EN_Desc|English (beta)"
  },
  JP = {
    ID = "JP",
    CnID = "日语",
    BaseSortID = 351,
    Desc = "CommonID_JP_Desc|日语 (alpha)"
  },
  KR = {
    ID = "KR",
    CnID = "韩语",
    BaseSortID = 352,
    Desc = "CommonID_KR_Desc|韩语 (alpha)"
  },
  RU = {
    ID = "RU",
    CnID = "俄语",
    BaseSortID = 353,
    Desc = "CommonID_RU_Desc|俄语 (alpha)"
  },
  FR = {
    ID = "FR",
    CnID = "法语",
    BaseSortID = 354,
    Desc = "CommonID_FR_Desc|法语 (alpha)"
  },
  VN = {
    ID = "VN",
    CnID = "越南语",
    BaseSortID = 355,
    Desc = "CommonID_VN_Desc|越南语 (alpha)"
  },
  TH = {
    ID = "TH",
    CnID = "泰语",
    BaseSortID = 356,
    Desc = "CommonID_TH_Desc|泰语 (alpha)"
  },
  PT = {
    ID = "PT",
    CnID = "葡萄牙语",
    BaseSortID = 357,
    Desc = "CommonID_PT_Desc|葡萄牙语 (alpha)"
  },
  ID = {
    ID = "ID",
    CnID = "印尼语",
    BaseSortID = 358,
    Desc = "CommonID_ID_Desc|印尼语 (alpha)"
  },
  ES = {
    ID = "ES",
    CnID = "西班牙语",
    BaseSortID = 359,
    Desc = "CommonID_ES_Desc|西班牙语 (alpha)"
  },
  DE = {
    ID = "DE",
    CnID = "德语",
    BaseSortID = 360,
    Desc = "CommonID_DE_Desc|德语 (alpha)"
  },
  IT = {
    ID = "IT",
    CnID = "意大利语",
    BaseSortID = 361,
    Desc = "CommonID_IT_Desc|意大利语 (alpha)"
  },
  TR = {
    ID = "TR",
    CnID = "土耳其语",
    BaseSortID = 362,
    Desc = "CommonID_TR_Desc|土耳其语 (alpha)"
  },
  BN = {
    ID = "BN",
    CnID = "孟加拉语",
    BaseSortID = 363,
    Desc = "CommonID_BN_Desc|孟加拉语 (alpha)"
  },
  Management = {
    ID = "Management",
    CnID = "前往管理",
    BaseSortID = 364,
    Desc = "CommonID_Management_Desc|前往管理"
  },
  Click = {
    ID = "Click",
    CnID = "点击跳转",
    BaseSortID = 365,
    Desc = "CommonID_Click_Desc|点击跳转"
  },
  ClickToView = {
    ID = "ClickToView",
    CnID = "点击查看",
    BaseSortID = 366,
    Desc = "CommonID_ClickToView_Desc|点击查看"
  },
  Redeem = {
    ID = "Redeem",
    CnID = "前往兑换",
    BaseSortID = 367,
    Desc = "CommonID_Redeem_Desc|前往兑换"
  },
  View = {
    ID = "View",
    CnID = "前往查看",
    BaseSortID = 368,
    Desc = "CommonID_View_Desc|前往查看"
  },
  Modify = {
    ID = "Modify",
    CnID = "点击修改",
    BaseSortID = 369,
    Desc = "CommonID_Modify_Desc|点击修改"
  },
  Repair = {
    ID = "Repair",
    CnID = "前往修复",
    BaseSortID = 370,
    Desc = "CommonID_Repair_Desc|前往修复"
  },
  Tips = {
    ID = "Tips",
    CnID = "提示",
    BaseSortID = 371,
    Desc = "CommonID_Tips_Desc|提示"
  },
  System = {
    ID = "System",
    CnID = "系统",
    BaseSortID = 372,
    Desc = "CommonID_System_Desc|系统"
  },
  Image = {
    ID = "Image",
    CnID = "图像",
    BaseSortID = 373,
    Desc = "CommonID_Image_Desc|图像"
  },
  WindowNotFocusVoice = {
    ID = "WindowNotFocusVoice",
    CnID = "窗口未聚焦音效",
    BaseSortID = 374,
    Desc = "CommonID_WindowNotFocusVoice_Desc|窗口未聚焦音效"
  },
  GmaeVoice = {
    ID = "GmaeVoice",
    CnID = "游戏音",
    BaseSortID = 375,
    Desc = "CommonID_GmaeVoice_Desc|游戏音"
  },
  Mute = {
    ID = "Mute",
    CnID = "静音",
    BaseSortID = 376,
    Desc = "CommonID_Mute_Desc|静音"
  },
  ContinuousSound = {
    ID = "ContinuousSound",
    CnID = "持续播放",
    BaseSortID = 377,
    Desc = "CommonID_ContinuousSound_Desc|持续播放"
  },
  Voice = {
    ID = "Voice",
    CnID = "声音",
    BaseSortID = 378,
    Desc = "CommonID_Voice_Desc|声音"
  },
  Key = {
    ID = "Key",
    CnID = "按键",
    BaseSortID = 379,
    Desc = "CommonID_Key_Desc|按键"
  },
  Language = {
    ID = "Language",
    CnID = "语言",
    BaseSortID = 380,
    Desc = "CommonID_Language_Desc|语言"
  },
  Account = {
    ID = "Account",
    CnID = "账户",
    BaseSortID = 381,
    Desc = "CommonID_Account_Desc|账户"
  },
  Hall = {
    ID = "Hall",
    CnID = "大厅",
    BaseSortID = 382,
    Desc = "CommonID_Hall_Desc|大厅"
  },
  PersonalProfile = {
    ID = "PersonalProfile",
    CnID = "个人档案",
    BaseSortID = 383,
    Desc = "CommonID_PersonalProfile_Desc|个人档案"
  },
  MasterVolume = {
    ID = "MasterVolume",
    CnID = "主音量",
    BaseSortID = 384,
    Desc = "CommonID_MasterVolume_Desc|整体控制"
  },
  SoundBalance = {
    ID = "SoundBalance",
    CnID = "声音平衡",
    BaseSortID = 385,
    Desc = "CommonID_SoundBalance_Desc|声音平衡"
  },
  ItemManagement = {
    ID = "ItemManagement",
    CnID = "物品",
    BaseSortID = 386,
    Desc = "CommonID_ItemManagement_Desc|物品"
  },
  MessagePush = {
    ID = "MessagePush",
    CnID = "消息推送",
    BaseSortID = 387,
    Desc = "CommonID_MessagePush_Desc|消息推送"
  },
  ShortcutKey = {
    ID = "ShortcutKey",
    CnID = "快捷键",
    BaseSortID = 388,
    Desc = "CommonID_ShortcutKey_Desc|快捷键"
  },
  ChooseHandCard = {
    ID = "ChooseHandCard",
    CnID = "选择手牌",
    BaseSortID = 389,
    Desc = "CommonID_ChooseHandCard_Desc|选择手牌"
  },
  TranslationLabel = {
    ID = "TranslationLabel",
    CnID = "正式翻译标识",
    BaseSortID = 390,
    Desc = "CommonID_TranslationLabel_Desc|正式翻译标识"
  },
  CardBorder = {
    ID = "CardBorder",
    CnID = "卡牌外观",
    BaseSortID = 391,
    Desc = "CommonID_CardBorder_Desc|卡牌外观"
  },
  Potency = {
    ID = "Potency",
    CnID = "启灵",
    BaseSortID = 392,
    Desc = "CommonID_Potency_Desc|启灵"
  },
  Through1 = {
    ID = "Through1",
    CnID = "被动技能1",
    BaseSortID = 393,
    Desc = "CommonID_Through1_Desc|被动技能1"
  },
  Through2 = {
    ID = "Through2",
    CnID = "被动技能2",
    BaseSortID = 394,
    Desc = "CommonID_Through2_Desc|被动技能2"
  },
  ResNeedReduce = {
    ID = "ResNeedReduce",
    CnID = "需求资源减少",
    BaseSortID = 395,
    Desc = "CommonID_ResNeedReduce_Desc|需求资源减少"
  },
  AppointTaskRewardAdd = {
    ID = "AppointTaskRewardAdd",
    CnID = "委派增加奖励",
    BaseSortID = 396,
    Desc = "CommonID_AppointTaskRewardAdd_Desc|委派增加奖励"
  },
  HarvestAdd = {
    ID = "HarvestAdd",
    CnID = "家园增加奖励",
    BaseSortID = 397,
    Desc = "CommonID_HarvestAdd_Desc|家园增加奖励"
  },
  StageDropAdd = {
    ID = "StageDropAdd",
    CnID = "副本增加产出",
    BaseSortID = 398,
    Desc = "CommonID_StageDropAdd_Desc|副本增加产出"
  },
  MaterialsReturn = {
    ID = "MaterialsReturn",
    CnID = "返还消耗资源",
    BaseSortID = 399,
    Desc = "CommonID_MaterialsReturn_Desc|返还消耗资源"
  },
  MultiplierXP = {
    ID = "MultiplierXP",
    CnID = "多倍经验强化",
    BaseSortID = 400,
    Desc = "CommonID_MultiplierXP_Desc|多倍经验强化"
  },
  FreeBattlePos = {
    ID = "FreeBattlePos",
    CnID = "自由上阵",
    BaseSortID = 401,
    Desc = "CommonID_FreeBattlePos_Desc|自由上阵"
  },
  BanBattlePos = {
    ID = "BanBattlePos",
    CnID = "不可上阵",
    BaseSortID = 402,
    Desc = "CommonID_BanBattlePos_Desc|不可上阵"
  },
  DisableTrinketSuitEffect = {
    ID = "DisableTrinketSuitEffect",
    CnID = "禁用密契",
    BaseSortID = 403,
    Desc = "CommonID_DisableTrinketSuitEffect_Desc|禁用密契"
  },
  DisableWeapon = {
    ID = "DisableWeapon",
    CnID = "禁用命轮",
    BaseSortID = 404,
    Desc = "CommonID_DisableWeapon_Desc|禁用命轮"
  },
  Gender_Boy = {
    ID = "Gender_Boy",
    CnID = "男",
    BaseSortID = 405,
    Desc = "CommonID_Gender_Boy_Desc|男"
  },
  Gender_Girl = {
    ID = "Gender_Girl",
    CnID = "女",
    BaseSortID = 406,
    Desc = "CommonID_Gender_Girl_Desc|女"
  },
  FastCaption = {
    ID = "FastCaption",
    CnID = "快速字幕",
    BaseSortID = 407
  },
  MiddleCaption = {
    ID = "MiddleCaption",
    CnID = "中速字幕",
    BaseSortID = 408
  },
  SlowCaption = {
    ID = "SlowCaption",
    CnID = "慢速字幕",
    BaseSortID = 409
  },
  OptionEnd = {
    ID = "OptionEnd",
    CnID = "循环选项结束到",
    BaseSortID = 410
  },
  CanNotSkip = {
    ID = "CanNotSkip",
    CnID = "不可跳过选项",
    BaseSortID = 411
  },
  EndTransit = {
    ID = "EndTransit",
    CnID = "结束过渡",
    BaseSortID = 412
  },
  WhiteTransit = {
    ID = "WhiteTransit",
    CnID = "白色过渡",
    BaseSortID = 413
  },
  BgScale = {
    ID = "BgScale",
    CnID = "背景缩放",
    BaseSortID = 414
  },
  AvgRoleScale = {
    ID = "AvgRoleScale",
    CnID = "立绘放大",
    BaseSortID = 415
  },
  AvgRoleScaleRevert = {
    ID = "AvgRoleScaleRevert",
    CnID = "立绘放大还原",
    BaseSortID = 416
  },
  ReplaceBg = {
    ID = "ReplaceBg",
    CnID = "替换背景",
    BaseSortID = 417
  },
  ReplaceAnim = {
    ID = "ReplaceAnim",
    CnID = "替换动画",
    BaseSortID = 418
  },
  ReplaceEndAnim = {
    ID = "ReplaceEndAnim",
    CnID = "替换结尾动画",
    BaseSortID = 419
  },
  ReplaceVideo = {
    ID = "ReplaceVideo",
    CnID = "替换视频",
    BaseSortID = 420
  },
  ResetAvgOption = {
    ID = "ResetAvgOption",
    CnID = "重置选项",
    BaseSortID = 421
  },
  SubplotActivity = {
    ID = "SubplotActivity",
    CnID = "支线关卡活动",
    BaseSortID = 422
  },
  AbyssChallengeActivity = {
    ID = "AbyssChallengeActivity",
    CnID = "融蚀深渊活动",
    BaseSortID = 423
  },
  SevenDayLoginActivity = {
    ID = "SevenDayLoginActivity",
    CnID = "七天登录活动",
    BaseSortID = 424
  },
  TaskListActivity = {
    ID = "TaskListActivity",
    CnID = "任务列表活动",
    BaseSortID = 425
  },
  DoubleOutputActivity = {
    ID = "DoubleOutputActivity",
    CnID = "双倍产出活动",
    BaseSortID = 426
  },
  DoubleExperienceActivity = {
    ID = "DoubleExperienceActivity",
    CnID = "双倍经验活动",
    BaseSortID = 427
  },
  AwakerTrialActivity = {
    ID = "AwakerTrialActivity",
    CnID = "角色试玩活动",
    BaseSortID = 428
  },
  SignReceiveAwakerActivity = {
    ID = "SignReceiveAwakerActivity",
    CnID = "任选往期UP唤醒体活动",
    BaseSortID = 429
  },
  SignReceiveAnyWeaponActivity = {
    ID = "SignReceiveAnyWeaponActivity",
    CnID = "任选往期UP命轮活动",
    BaseSortID = 430
  },
  FiveDaySignActivity = {
    ID = "FiveDaySignActivity",
    CnID = "五日签到活动",
    BaseSortID = 431
  },
  SignReceiveWeaponActivity = {
    ID = "SignReceiveWeaponActivity",
    CnID = "签到领取命轮活动",
    BaseSortID = 432
  },
  SpecialTaskList = {
    ID = "SpecialTaskList",
    CnID = "特别任务列表活动",
    BaseSortID = 433
  },
  ShopActivity = {
    ID = "ShopActivity",
    CnID = "商店活动",
    BaseSortID = 434
  },
  PreOrderActivity = {
    ID = "PreOrderActivity",
    CnID = "版本预购礼包活动",
    BaseSortID = 435
  },
  NewPreOrderActivity = {
    ID = "NewPreOrderActivity",
    CnID = "版本预约活动",
    BaseSortID = 436
  },
  HomologyDoubleActivity = {
    ID = "HomologyDoubleActivity",
    CnID = "同调率翻倍活动",
    BaseSortID = 437
  },
  ConfessionEventDiscountActivity = {
    ID = "ConfessionEventDiscountActivity",
    CnID = "表白事件优惠解锁活动",
    BaseSortID = 438
  },
  WorldBossActivity = {
    ID = "WorldBossActivity",
    CnID = "世界BOSS活动",
    BaseSortID = 439
  },
  StageOnlyActivity = {
    ID = "StageOnlyActivity",
    CnID = "仅关卡活动",
    BaseSortID = 440
  },
  GoldenWeekActivity = {
    ID = "GoldenWeekActivity",
    CnID = "黄金周活动",
    BaseSortID = 441
  },
  DeepSeaInvasionDefensiveActiviity = {
    ID = "DeepSeaInvasionDefensiveActiviity",
    CnID = "深海入侵击退战活动",
    BaseSortID = 442
  },
  TwoAnniversaryWorldBossActivity = {
    ID = "TwoAnniversaryWorldBossActivity",
    CnID = "2周年世界BOSS活动",
    BaseSortID = 443
  },
  TwoAndAHalfAnniversaryRAIDActiviity = {
    ID = "TwoAndAHalfAnniversaryRAIDActiviity",
    CnID = "2.5周年RAID活动",
    BaseSortID = 444
  },
  TwoAndAHalfAnniversaryRechargeActiviity = {
    ID = "TwoAndAHalfAnniversaryRechargeActiviity",
    CnID = "2.5周年限时累充活动",
    BaseSortID = 445
  },
  RailWayActivity = {
    ID = "RailWayActivity",
    CnID = "疾驰的欢愉专列",
    BaseSortID = 446
  },
  RailWaySeasonRankActivity = {
    ID = "RailWaySeasonRankActivity",
    CnID = "疾驰的欢愉专列赛季排行活动",
    BaseSortID = 447
  },
  MagicStoryActivity = {
    ID = "MagicStoryActivity",
    CnID = "莉莉活动",
    BaseSortID = 448
  },
  WandaActivity = {
    ID = "WandaActivity",
    CnID = "旺达活动",
    BaseSortID = 449
  },
  SalvadorActivity = {
    ID = "SalvadorActivity",
    CnID = "萨尔瓦多活动",
    BaseSortID = 450
  },
  A24Activity = {
    ID = "A24Activity",
    CnID = "24活动",
    BaseSortID = 451
  },
  ThaisActivity = {
    ID = "ThaisActivity",
    CnID = "泰旖丝活动",
    BaseSortID = 452
  },
  MagicStoryActivityReproduce = {
    ID = "MagicStoryActivityReproduce",
    CnID = "莉莉复刻活动",
    BaseSortID = 453
  },
  MiryamActivity = {
    ID = "MiryamActivity",
    CnID = "弥利亚姆活动",
    BaseSortID = 454
  },
  SorelActivity = {
    ID = "SorelActivity",
    CnID = "索蕾尔活动",
    BaseSortID = 455
  },
  HorlaActivity = {
    ID = "HorlaActivity",
    CnID = "奥尔拉活动",
    BaseSortID = 456
  },
  MurphyActivity = {
    ID = "MurphyActivity",
    CnID = "墨菲活动",
    BaseSortID = 457
  },
  RykerActivity = {
    ID = "RykerActivity",
    CnID = "莱克活动",
    BaseSortID = 458
  },
  SalvadorActivityReproduce = {
    ID = "SalvadorActivityReproduce",
    CnID = "萨尔瓦多复刻活动",
    BaseSortID = 459
  },
  HamelnActivity = {
    ID = "HamelnActivity",
    CnID = "哈姆林活动",
    BaseSortID = 460
  },
  A24ActivityReproduce = {
    ID = "A24ActivityReproduce",
    CnID = "24复刻活动",
    BaseSortID = 461
  },
  OriginHelotActivity = {
    ID = "OriginHelotActivity",
    CnID = "本源希洛活动",
    BaseSortID = 462
  },
  WandaActivityReproduce = {
    ID = "WandaActivityReproduce",
    CnID = "旺达复刻活动",
    BaseSortID = 463
  },
  MiryamActivityReproduce = {
    ID = "MiryamActivityReproduce",
    CnID = "弥利亚姆复刻活动",
    BaseSortID = 464
  },
  TawilActivity = {
    ID = "TawilActivity",
    CnID = "塔薇活动",
    BaseSortID = 465
  },
  TuluActivity = {
    ID = "TuluActivity",
    CnID = "图鲁活动",
    BaseSortID = 466
  },
  PVPReverseRoundActivity = {
    ID = "PVPReverseRoundActivity",
    CnID = "逆转回合活动",
    BaseSortID = 467
  },
  OriginDollActivity = {
    ID = "OriginDollActivity",
    CnID = "本源朵尔活动",
    BaseSortID = 468
  },
  DaffodilActivity = {
    ID = "DaffodilActivity",
    CnID = "达芙黛尔活动",
    BaseSortID = 469
  },
  ClementineActivity = {
    ID = "ClementineActivity",
    CnID = "克莱门汀活动",
    BaseSortID = 470
  },
  StElmosFireActivity = {
    ID = "StElmosFireActivity",
    CnID = "克珀珊特活动",
    BaseSortID = 471
  },
  CastorActivity = {
    ID = "CastorActivity",
    CnID = "卡斯托尔活动",
    BaseSortID = 472
  },
  DoresainActivity = {
    ID = "DoresainActivity",
    CnID = "杜勒赛因活动",
    BaseSortID = 473
  },
  KathiguRaActivity = {
    ID = "KathiguRaActivity",
    CnID = "凯蒂古拉活动",
    BaseSortID = 474
  },
  PickManActivity = {
    ID = "PickManActivity",
    CnID = "皮克曼活动",
    BaseSortID = 475
  },
  PolluxActivity = {
    ID = "PolluxActivity",
    CnID = "波吕克斯活动",
    BaseSortID = 476
  },
  OriginMurphyActivity = {
    ID = "OriginMurphyActivity",
    CnID = "本源墨菲活动",
    BaseSortID = 477
  },
  MouchetteActivity = {
    ID = "MouchetteActivity",
    CnID = "茉夏活动",
    BaseSortID = 478
  },
  XuActivity = {
    ID = "XuActivity",
    CnID = "徐活动",
    BaseSortID = 479
  },
  MoskActivity = {
    ID = "MoskActivity",
    CnID = "莫丝活动",
    BaseSortID = 480
  },
  ArachneActivity = {
    ID = "ArachneActivity",
    CnID = "阿拉克涅活动",
    BaseSortID = 481
  },
  SayaActivity = {
    ID = "SayaActivity",
    CnID = "沙耶活动",
    BaseSortID = 482
  },
  PontosActivity = {
    ID = "PontosActivity",
    CnID = "庞托斯活动",
    BaseSortID = 483
  },
  LotanCetarchonActivity = {
    ID = "LotanCetarchonActivity",
    CnID = "蚀灭·萝坦活动",
    BaseSortID = 484
  },
  TaisuiActivity = {
    ID = "TaisuiActivity",
    CnID = "太岁活动",
    BaseSortID = 485
  },
  CarabooActivity = {
    ID = "CarabooActivity",
    CnID = "卡拉布活动",
    BaseSortID = 486
  },
  GenesisOgierActivity = {
    ID = "GenesisOgierActivity",
    CnID = "本源奥吉尔活动",
    BaseSortID = 487
  },
  GenesisTinctActivity = {
    ID = "GenesisTinctActivity",
    CnID = "暮星·汀克特活动",
    BaseSortID = 488
  },
  ModiglianActivity = {
    ID = "ModiglianActivity",
    CnID = "莫尔迪基安活动",
    BaseSortID = 489
  },
  AntrakActivity = {
    ID = "AntrakActivity",
    CnID = "昂特拉克活动",
    BaseSortID = 490
  },
  LulimActivity = {
    ID = "LulimActivity",
    CnID = "鲁利姆活动",
    BaseSortID = 491
  },
  OriginTuluActivity = {
    ID = "OriginTuluActivity",
    CnID = "本源图鲁活动",
    BaseSortID = 492
  },
  AwakerActivityLottery = {
    ID = "AwakerActivityLottery",
    CnID = "玩法活动抽奖",
    BaseSortID = 493
  },
  AwakerActivityShop = {
    ID = "AwakerActivityShop",
    CnID = "玩法活动商店",
    BaseSortID = 494
  },
  HalfAnniversaryCelebrationActivity = {
    ID = "HalfAnniversaryCelebrationActivity",
    CnID = "半周年庆活动",
    BaseSortID = 495
  },
  RomeActivity = {
    ID = "RomeActivity",
    CnID = "罗马活动",
    BaseSortID = 496
  },
  ReturnEvent = {
    ID = "ReturnEvent",
    CnID = "回归活动",
    BaseSortID = 497
  },
  BattlePassActivity = {
    ID = "BattlePassActivity",
    CnID = "通行证活动",
    BaseSortID = 498
  },
  SummerChapter1Activity = {
    ID = "SummerChapter1Activity",
    CnID = "夏日活动上",
    BaseSortID = 499
  },
  SummerChapter2Activity = {
    ID = "SummerChapter2Activity",
    CnID = "夏日活动下",
    BaseSortID = 500
  },
  TriggerOnceEvent = {
    ID = "TriggerOnceEvent",
    CnID = "条件触发一次性连锁礼包",
    BaseSortID = 501
  },
  PeriodTrigger = {
    ID = "PeriodTrigger",
    CnID = "周期触发连锁礼包",
    BaseSortID = 502
  },
  LimitedTimeSale = {
    ID = "LimitedTimeSale",
    CnID = "限时连锁礼包",
    BaseSortID = 503
  },
  FirstTimeLimitedSale = {
    ID = "FirstTimeLimitedSale",
    CnID = "首次限时礼包活动",
    BaseSortID = 504
  },
  YearAndAHalfCelebrationActivity = {
    ID = "YearAndAHalfCelebrationActivity",
    CnID = "1.5周年庆活动",
    BaseSortID = 505
  },
  TwoYearCelebrationActivity = {
    ID = "TwoYearCelebrationActivity",
    CnID = "2周年庆活动",
    BaseSortID = 506
  },
  TwoAndAHalfCelebrationActivity = {
    ID = "TwoAndAHalfCelebrationActivity",
    CnID = "2.5周年庆活动",
    BaseSortID = 507
  },
  MouchetteCrossoverActivity = {
    ID = "MouchetteCrossoverActivity",
    CnID = "茉夏联动福利活动",
    BaseSortID = 508
  },
  Duration = {
    ID = "Duration",
    CnID = "持续时长",
    BaseSortID = 509
  },
  DurationHourAfterTrigger = {
    ID = "DurationHourAfterTrigger",
    CnID = "触发后持续小时",
    BaseSortID = 510
  },
  PlayerLevel = {
    ID = "PlayerLevel",
    CnID = "玩家等级",
    BaseSortID = 511
  },
  StageClearance = {
    ID = "StageClearance",
    CnID = "关卡通关",
    BaseSortID = 512
  },
  AfterCreateRole = {
    ID = "AfterCreateRole",
    CnID = "创角后",
    BaseSortID = 513
  },
  Permanent = {
    ID = "Permanent",
    CnID = "永久",
    BaseSortID = 514
  },
  FixedTime = {
    ID = "FixedTime",
    CnID = "固定时间",
    BaseSortID = 515
  },
  TaskDrivenEnd = {
    ID = "TaskDrivenEnd",
    CnID = "条件结束",
    BaseSortID = 516
  },
  TaskCount = {
    ID = "TaskCount",
    CnID = "每日挑战任务进度显示模式@计数",
    BaseSortID = 517,
    Desc = "CommonID_TaskCount_Desc|计数"
  },
  TaskInProgress = {
    ID = "TaskInProgress",
    CnID = "每日挑战任务进度显示模式@进行中",
    BaseSortID = 518,
    Desc = "CommonID_TaskInProgress_Desc|进行中"
  },
  GoldAchieve = {
    ID = "GoldAchieve",
    CnID = "成就品质@金",
    BaseSortID = 519,
    Desc = "CommonID_GoldAchieve_Desc|金"
  },
  SilverAchieve = {
    ID = "SilverAchieve",
    CnID = "成就品质@银",
    BaseSortID = 520,
    Desc = "CommonID_SilverAchieve_Desc|银"
  },
  CopperAchieve = {
    ID = "CopperAchieve",
    CnID = "成就品质@铜",
    BaseSortID = 521,
    Desc = "CommonID_CopperAchieve_Desc|铜"
  },
  AchieveType0 = {
    ID = "AchieveType0",
    CnID = "成就类型@全部",
    BaseSortID = 522,
    Desc = "CommonID_AchieveType0_Desc|全部成就"
  },
  AchieveType1 = {
    ID = "AchieveType1",
    CnID = "成就类型@成长",
    BaseSortID = 523,
    Desc = "CommonID_AchieveType1_Desc|成长故事"
  },
  AchieveType2 = {
    ID = "AchieveType2",
    CnID = "成就类型@探索",
    BaseSortID = 524,
    Desc = "CommonID_AchieveType2_Desc|调查印记"
  },
  AchieveType3 = {
    ID = "AchieveType3",
    CnID = "成就类型@战斗",
    BaseSortID = 525,
    Desc = "CommonID_AchieveType3_Desc|作战记录"
  },
  AchieveType4 = {
    ID = "AchieveType4",
    CnID = "成就类型@其他",
    BaseSortID = 526,
    Desc = "CommonID_AchieveType4_Desc|守密生涯"
  },
  AchieveCommemorativeData_Time = {
    ID = "AchieveCommemorativeData_Time",
    CnID = "成就纪念数据@时间",
    BaseSortID = 527,
    Desc = "CommonID_AchieveCommemorativeData_Time_Desc|完成时间"
  },
  AchieveCommemorativeData_Dmg = {
    ID = "AchieveCommemorativeData_Dmg",
    CnID = "成就纪念数据@伤害",
    BaseSortID = 528,
    Desc = "CommonID_AchieveCommemorativeData_Dmg_Desc|最高伤害"
  },
  AchieveCommemorativeData_Poison = {
    ID = "AchieveCommemorativeData_Poison",
    CnID = "成就纪念数据@中毒",
    BaseSortID = 529,
    Desc = "CommonID_AchieveCommemorativeData_Poison_Desc|最高层数"
  },
  YellowGlow = {
    ID = "YellowGlow",
    CnID = "黄色光效",
    BaseSortID = 530,
    Desc = "CommonID_YellowGlow_Desc|黄色光效"
  },
  RedGlow = {
    ID = "RedGlow",
    CnID = "红色光效",
    BaseSortID = 531,
    Desc = "CommonID_RedGlow_Desc|红色光效"
  },
  RequiredPlayerLevel = {
    ID = "RequiredPlayerLevel",
    CnID = "使用时所需的守密人等级",
    BaseSortID = 532
  },
  AvailableAwaker = {
    ID = "AvailableAwaker",
    CnID = "可用唤醒体",
    BaseSortID = 533
  },
  DirectPromotionLevel = {
    ID = "DirectPromotionLevel",
    CnID = "直升等级",
    BaseSortID = 534
  },
  DirectSkillPromotionLevel = {
    ID = "DirectSkillPromotionLevel",
    CnID = "直升技能等级",
    BaseSortID = 535
  },
  DirectBreakthroughStage = {
    ID = "DirectBreakthroughStage",
    CnID = "直升突破等阶",
    BaseSortID = 536
  },
  BreakthroughSkill1Unlocked = {
    ID = "BreakthroughSkill1Unlocked",
    CnID = "突破技能1是否解锁",
    BaseSortID = 537
  },
  BreakthroughSkill2Unlocked = {
    ID = "BreakthroughSkill2Unlocked",
    CnID = "突破技能2是否解锁",
    BaseSortID = 538
  },
  Challenge = {
    ID = "Challenge",
    CnID = "调查",
    BaseSortID = 539,
    Desc = "CommonID_Challenge_Desc|调查"
  },
  FirstGetAnyEnchant = {
    ID = "FirstGetAnyEnchant",
    CnID = "首次获得任意刻印后",
    BaseSortID = 540
  },
  FirstGetAnyRelic = {
    ID = "FirstGetAnyRelic",
    CnID = "首次获得任意造物后",
    BaseSortID = 541
  },
  FirstGetSpecifiedItemType = {
    ID = "FirstGetSpecifiedItemType",
    CnID = "首次获得指定类型的道具",
    BaseSortID = 542
  },
  FirstMoveToNode = {
    ID = "FirstMoveToNode",
    CnID = "首次移动到该节点时",
    BaseSortID = 543
  },
  SystemUnlock = {
    ID = "SystemUnlock",
    CnID = "系统解锁后",
    BaseSortID = 544
  },
  FirstUpgradeAnySkill = {
    ID = "FirstUpgradeAnySkill",
    CnID = "首次能够升级任意技能时",
    BaseSortID = 545
  },
  FirstUnlockReappear = {
    ID = "FirstUnlockReappear",
    CnID = "首次解锁重现后",
    BaseSortID = 546
  },
  FirstClickSignboardGirl = {
    ID = "FirstClickSignboardGirl",
    CnID = "首次点击看板娘时",
    BaseSortID = 547
  },
  FirstFormDimensionTeam = {
    ID = "FirstFormDimensionTeam",
    CnID = "在编队中首次编组超维队伍时",
    BaseSortID = 548
  },
  FirstFormOceanTeam = {
    ID = "FirstFormOceanTeam",
    CnID = "在编队中首次编组深海队伍时",
    BaseSortID = 549
  },
  FirstFormBloodTeam = {
    ID = "FirstFormBloodTeam",
    CnID = "在编队中首次编组血肉队伍时",
    BaseSortID = 550
  },
  FirstFormChaosTeam = {
    ID = "FirstFormChaosTeam",
    CnID = "在编队中首次编组混沌队伍时",
    BaseSortID = 551
  },
  FirstGetState = {
    ID = "FirstGetState",
    CnID = "首次获得该状态后",
    BaseSortID = 552
  },
  FirstFightAfterBattlePassUnlocked = {
    ID = "FirstFightAfterBattlePassUnlocked",
    CnID = "解锁课题后首次战斗",
    BaseSortID = 553
  },
  FirstGetMaxPotency = {
    ID = "FirstGetMaxPotency",
    CnID = "首次激活终极启灵",
    BaseSortID = 554
  },
  FirstGetPrestigeCard = {
    ID = "FirstGetPrestigeCard",
    CnID = "首次获得同调率20级奖励",
    BaseSortID = 555
  },
  AnyStageFirstClear = {
    ID = "AnyStageFirstClear",
    CnID = "任一关卡首次通关",
    BaseSortID = 556,
    Desc = "CommonID_AnyStageFirstClear_Desc|任务完成条件：列表中任一关卡首次通关"
  },
  AnyAvgFirstTrigger = {
    ID = "AnyAvgFirstTrigger",
    CnID = "触发过任一剧情节点",
    BaseSortID = 557,
    Desc = "CommonID_AnyAvgFirstTrigger_Desc|任务完成条件：触发过任一剧情节点"
  },
  AnyEventFirstTrigger = {
    ID = "AnyEventFirstTrigger",
    CnID = "触发过任一事件",
    BaseSortID = 558,
    Desc = "CommonID_AnyEventFirstTrigger_Desc|任务完成条件：触发过任一事件"
  },
  AnyRelicFirstGet = {
    ID = "AnyRelicFirstGet",
    CnID = "获得过任一造物",
    BaseSortID = 559,
    Desc = "CommonID_AnyRelicFirstGet_Desc|任务完成条件：获得过任一造物"
  },
  AnyItemFirstGet = {
    ID = "AnyItemFirstGet",
    CnID = "获得过任一道具",
    BaseSortID = 560,
    Desc = "CommonID_AnyItemFirstGet_Desc|任务完成条件：获得过任一道具"
  },
  AnyNodeTypeFirstTrigger = {
    ID = "AnyNodeTypeFirstTrigger",
    CnID = "触发过任一节点类型",
    BaseSortID = 561,
    Desc = "CommonID_AnyNodeTypeFirstTrigger_Desc|任务完成条件：触发过任一节点类型"
  },
  AnyEntryInGroupUnlock = {
    ID = "AnyEntryInGroupUnlock",
    CnID = "分组下任一图鉴条目解锁",
    BaseSortID = 562,
    Desc = "CommonID_AnyEntryInGroupUnlock_Desc|任务完成条件：分组下任一图鉴条目解锁"
  },
  SpecificCommunicateTrig = {
    ID = "SpecificCommunicateTrig",
    CnID = "已触发指定通讯器对话",
    BaseSortID = 563,
    Desc = "CommonID_SpecificCommunicateTrig_Desc|任务完成条件：已触发指定通讯器对话"
  },
  HaveAwaker = {
    ID = "HaveAwaker",
    CnID = "拥有特定唤醒体",
    BaseSortID = 564,
    Desc = "CommonID_HaveAwaker_Desc|任务完成条件：拥有列表中任一唤醒体"
  },
  DisableKeeperSkill = {
    ID = "DisableKeeperSkill",
    CnID = "禁用主角技能",
    BaseSortID = 565,
    Desc = "CommonID_DisableKeeperSkill_Desc|禁用主角技能"
  },
  LineupSpecific = {
    ID = "LineupSpecific",
    CnID = "具体",
    BaseSortID = 566
  },
  LineupRange = {
    ID = "LineupRange",
    CnID = "范围",
    BaseSortID = 567
  },
  NoobLineup = {
    ID = "NoobLineup",
    CnID = "阵容组@萌新阵容组",
    BaseSortID = 568
  },
  TimeoutAILineup = {
    ID = "TimeoutAILineup",
    CnID = "阵容组@超时阵容组",
    BaseSortID = 569
  },
  TrainingLineup = {
    ID = "TrainingLineup",
    CnID = "阵容组@训练阵容组",
    BaseSortID = 570
  },
  CollectionTypeAwaker = {
    ID = "CollectionTypeAwaker",
    CnID = "收藏类型@唤醒体",
    BaseSortID = 571
  },
  CollectionTypeWeapon = {
    ID = "CollectionTypeWeapon",
    CnID = "收藏类型@命轮",
    BaseSortID = 572
  },
  CollectionTypeKeeperSkill = {
    ID = "CollectionTypeKeeperSkill",
    CnID = "收藏类型@钥令",
    BaseSortID = 573
  },
  Privacy = {
    ID = "Privacy",
    CnID = "隐私",
    BaseSortID = 574,
    Desc = "CommonID_Privacy_Desc|隐私"
  },
  PlayerFiles = {
    ID = "PlayerFiles",
    CnID = "守密人档案",
    BaseSortID = 575,
    Desc = "CommonID_PlayerFiles_Desc|守密人档案"
  },
  EmojiType_1 = {
    ID = "EmojiType_1",
    CnID = "软软弥萨格",
    BaseSortID = 576,
    Desc = "CommonID_EmojiType_1_Desc|软软弥萨格"
  },
  EmojiType_2 = {
    ID = "EmojiType_2",
    CnID = "团团前夜",
    BaseSortID = 577,
    Desc = "CommonID_EmojiType_2_Desc|团团前夜"
  },
  EmojiType_3 = {
    ID = "EmojiType_3",
    CnID = "尘世百相",
    BaseSortID = 578,
    Desc = "CommonID_EmojiType_3_Desc|尘世百相"
  },
  EmojiType_4 = {
    ID = "EmojiType_4",
    CnID = "忘Q前夜",
    BaseSortID = 579,
    Desc = "CommonID_EmojiType_4_Desc|忘Q前夜"
  },
  EmojiType_5 = {
    ID = "EmojiType_5",
    CnID = "相位通讯",
    BaseSortID = 580,
    Desc = "CommonID_EmojiType_5_Desc|相位通讯"
  },
  EmojiType_6 = {
    ID = "EmojiType_6",
    CnID = "闪耀弥萨格",
    BaseSortID = 581,
    Desc = "CommonID_EmojiType_6_Desc|闪耀弥萨格"
  },
  EmojiType_7 = {
    ID = "EmojiType_7",
    CnID = "发疯弥萨格",
    BaseSortID = 582,
    Desc = "CommonID_EmojiType_7_Desc|发疯弥萨格"
  },
  EmojiType_8 = {
    ID = "EmojiType_8",
    CnID = "轻松弥萨格",
    BaseSortID = 583,
    Desc = "CommonID_EmojiType_8_Desc|轻松弥萨格"
  },
  EmojiType_9 = {
    ID = "EmojiType_9",
    CnID = "智慧弥萨格",
    BaseSortID = 584,
    Desc = "CommonID_EmojiType_9_Desc|智慧弥萨格"
  },
  EmojiType_10 = {
    ID = "EmojiType_10",
    CnID = "小小弥萨格",
    BaseSortID = 585,
    Desc = "CommonID_EmojiType_10_Desc|小小弥萨格"
  },
  EmojiType_11 = {
    ID = "EmojiType_11",
    CnID = "逆转回合",
    BaseSortID = 586,
    Desc = "CommonID_EmojiType_11_Desc|逆转回合"
  },
  EmojiType_12 = {
    ID = "EmojiType_12",
    CnID = "弥萨格日常",
    BaseSortID = 587,
    Desc = "CommonID_EmojiType_12_Desc|弥萨格日常"
  },
  EmojiType_13 = {
    ID = "EmojiType_13",
    CnID = "快乐弥萨格",
    BaseSortID = 588,
    Desc = "CommonID_EmojiType_13_Desc|快乐弥萨格"
  },
  EmojiType_14 = {
    ID = "EmojiType_14",
    CnID = "不高兴弥萨格",
    BaseSortID = 589,
    Desc = "CommonID_EmojiType_14_Desc|不高兴弥萨格"
  },
  EmojiType_15 = {
    ID = "EmojiType_15",
    CnID = "校园生活篇",
    BaseSortID = 590,
    Desc = "CommonID_EmojiType_15_Desc|校园生活篇"
  },
  EmojiType_16 = {
    ID = "EmojiType_16",
    CnID = "和平的一天",
    BaseSortID = 591,
    Desc = "CommonID_EmojiType_16_Desc|和平的一天"
  },
  EmojiType_17 = {
    ID = "EmojiType_17",
    CnID = "课余时间篇",
    BaseSortID = 592,
    Desc = "CommonID_EmojiType_17_Desc|课余时间篇"
  },
  EmojiType_18 = {
    ID = "EmojiType_18",
    CnID = "比心弥萨格",
    BaseSortID = 593,
    Desc = "CommonID_EmojiType_18_Desc|比心弥萨格"
  },
  EmojiType_19 = {
    ID = "EmojiType_19",
    CnID = "弥萨格假期",
    BaseSortID = 594,
    Desc = "CommonID_EmojiType_19_Desc|弥萨格假期"
  },
  EmojiType_20 = {
    ID = "EmojiType_20",
    CnID = "冬渡弥萨格",
    BaseSortID = 595,
    Desc = "CommonID_EmojiType_20_Desc|冬渡弥萨格"
  },
  EmojiType_21 = {
    ID = "EmojiType_21",
    CnID = "姜饼派对",
    BaseSortID = 596,
    Desc = "CommonID_EmojiType_21_Desc|姜饼派对"
  },
  EmojiType_22 = {
    ID = "EmojiType_22",
    CnID = "校园趣闻",
    BaseSortID = 597,
    Desc = "CommonID_EmojiType_22_Desc|校园趣闻"
  },
  EmojiType_23 = {
    ID = "EmojiType_23",
    CnID = "弥萨格调查员",
    BaseSortID = 598,
    Desc = "CommonID_EmojiType_23_Desc|弥萨格调查员"
  },
  EmojiType_24 = {
    ID = "EmojiType_24",
    CnID = "弥萨格幕间剧",
    BaseSortID = 599,
    Desc = "CommonID_EmojiType_24_Desc|弥萨格幕间剧"
  },
  EmojiType_25 = {
    ID = "EmojiType_25",
    CnID = "沙耶之歌",
    BaseSortID = 600,
    Desc = "CommonID_EmojiType_25_Desc|沙耶之歌"
  },
  DepressionHit = {
    ID = "DepressionHit",
    CnID = "受击抑郁",
    BaseSortID = 601,
    Desc = "CommonID_DepressionHit_Desc|受击抑郁"
  },
  ManiaHit = {
    ID = "ManiaHit",
    CnID = "受击狂躁",
    BaseSortID = 602,
    Desc = "CommonID_ManiaHit_Desc|受击狂躁"
  },
  GetLikeLevel = {
    ID = "GetLikeLevel",
    CnID = "获取同调率等级",
    BaseSortID = 603,
    Desc = "CommonID_GetLikeLevel_Desc|函数"
  },
  Display = {
    ID = "Display",
    CnID = "画面",
    BaseSortID = 604,
    Desc = "CommonID_Display_Desc|画面"
  },
  Window = {
    ID = "Window",
    CnID = "窗口",
    BaseSortID = 605,
    Desc = "CommonID_Window_Desc|窗口"
  },
  FullScreen = {
    ID = "FullScreen",
    CnID = "全屏",
    BaseSortID = 606,
    Desc = "CommonID_FullScreen_Desc|全屏"
  },
  PVP = {
    ID = "PVP",
    CnID = "相位对弈",
    BaseSortID = 607,
    Desc = "CommonID_PVP_Desc|相位对弈"
  },
  ClickToQuit = {
    ID = "ClickToQuit",
    CnID = "点击退出",
    BaseSortID = 608,
    Desc = "CommonID_ClickToQuit_Desc|点击退出"
  },
  DialogType1 = {
    ID = "DialogType1",
    CnID = "对话",
    BaseSortID = 609
  },
  DialogType2 = {
    ID = "DialogType2",
    CnID = "图片",
    BaseSortID = 610
  },
  DialogType3 = {
    ID = "DialogType3",
    CnID = "表情",
    BaseSortID = 611
  },
  DialogType4 = {
    ID = "DialogType4",
    CnID = "选项",
    BaseSortID = 612
  },
  DialogType5 = {
    ID = "DialogType5",
    CnID = "表情选项",
    BaseSortID = 613
  },
  Android = {
    ID = "Android",
    CnID = "安卓",
    BaseSortID = 614
  },
  Apple = {
    ID = "Apple",
    CnID = "苹果",
    BaseSortID = 615
  },
  PC = {
    ID = "PC",
    CnID = "PC",
    BaseSortID = 616
  },
  LoginByMonthActivity = {
    ID = "LoginByMonthActivity",
    CnID = "二十八天签到活动组",
    BaseSortID = 617
  },
  ReturnEventGroup = {
    ID = "ReturnEventGroup",
    CnID = "回归活动组",
    BaseSortID = 618
  },
  TurntableActivity = {
    ID = "TurntableActivity",
    CnID = "转盘活动",
    BaseSortID = 619
  },
  ShopType = {
    ID = "ShopType",
    CnID = "商店类型",
    BaseSortID = 620
  },
  ChargeGroupFirstTimeSale = {
    ID = "ChargeGroupFirstTimeSale",
    CnID = "充值组@首次超值礼包",
    BaseSortID = 621
  },
  ChargeGroup7DayReturn = {
    ID = "ChargeGroup7DayReturn",
    CnID = "充值组@7天回归纪行",
    BaseSortID = 622
  },
  ChargeGroup14DayReturn = {
    ID = "ChargeGroup14DayReturn",
    CnID = "充值组@14天回归纪行",
    BaseSortID = 623
  },
  ChargeGroupTripleLuckyBagAttack = {
    ID = "ChargeGroupTripleLuckyBagAttack",
    CnID = "充值组@三倍福袋攻击型",
    BaseSortID = 624
  },
  ChargeGroupTripleLuckyBagDefence = {
    ID = "ChargeGroupTripleLuckyBagDefence",
    CnID = "充值组@三倍福袋防御型",
    BaseSortID = 625
  },
  ChargeGroupTripleLuckyBagAssist = {
    ID = "ChargeGroupTripleLuckyBagAssist",
    CnID = "充值组@三倍福袋辅助型",
    BaseSortID = 626
  },
  PlayActAvg = {
    ID = "PlayActAvg",
    CnID = "播放活动剧情",
    BaseSortID = 627
  },
  SkinTask = {
    ID = "SkinTask",
    CnID = "时装兑换券任务",
    BaseSortID = 628
  },
  GuideCompIntroduceEnemyIntention = {
    ID = "GuideCompIntroduceEnemyIntention",
    CnID = "指引组件@序章怪物意图",
    BaseSortID = 629
  },
  CommonillustratePanel = {
    ID = "CommonillustratePanel",
    CnID = "指引组件@战斗规则说明弹窗",
    BaseSortID = 630
  },
  GuideCondillustratePanelClose = {
    ID = "GuideCondillustratePanelClose",
    CnID = "指引条件@战斗规则说明弹窗关闭",
    BaseSortID = 631
  },
  GuideCondBoutBegin = {
    ID = "GuideCondBoutBegin",
    CnID = "指引条件@回合开始时",
    BaseSortID = 632
  },
  GuideCondKeeperSkillEnergyFull = {
    ID = "GuideCondKeeperSkillEnergyFull",
    CnID = "指引条件@银钥能量已满",
    BaseSortID = 633
  },
  GuideCondOceanHide = {
    ID = "GuideCondOceanHide",
    CnID = "指引条件@深海形态切换交互隐藏",
    BaseSortID = 634
  },
  GuideCondOceanModeSwitched = {
    ID = "GuideCondOceanModeSwitched",
    CnID = "指引条件@深海切换形态后",
    BaseSortID = 635
  },
  GuideCompOceanModeSwtichToDefence = {
    ID = "GuideCompOceanModeSwtichToDefence",
    CnID = "指引组件@触腕姿态切换静海特效引导组件",
    BaseSortID = 636
  },
  GuideCompOceanModeSwtichToFrantic = {
    ID = "GuideCompOceanModeSwtichToFrantic",
    CnID = "指引组件@触腕姿态切换怒涛特效引导组件",
    BaseSortID = 637
  },
  GuideCompBloodSchoolSkill = {
    ID = "GuideCompBloodSchoolSkill",
    CnID = "指引组件@血肉猩红熔炉特效引导组件",
    BaseSortID = 638
  },
  GuideCompDimensionSchoolSkill = {
    ID = "GuideCompDimensionSchoolSkill",
    CnID = "指引组件@超维湮灭特效引导组件",
    BaseSortID = 639
  },
  GuideCompAwakerUltiSkill_1 = {
    ID = "GuideCompAwakerUltiSkill_1",
    CnID = "指引组件@唤醒体大招框特效引导组件1",
    BaseSortID = 640
  },
  GuideCompAwakerUltiSkill_2 = {
    ID = "GuideCompAwakerUltiSkill_2",
    CnID = "指引组件@唤醒体大招框特效引导组件2",
    BaseSortID = 641
  },
  GuideCompAwakerUltiSkill_3 = {
    ID = "GuideCompAwakerUltiSkill_3",
    CnID = "指引组件@唤醒体大招框特效引导组件3",
    BaseSortID = 642
  },
  GuideCompAwakerUltiSkill_4 = {
    ID = "GuideCompAwakerUltiSkill_4",
    CnID = "指引组件@唤醒体大招框特效引导组件4",
    BaseSortID = 643
  },
  GuideCondBloodSchoolSkillUsed = {
    ID = "GuideCondBloodSchoolSkillUsed",
    CnID = "指引条件@血肉猩红熔炉使用后",
    BaseSortID = 644
  },
  GuideCondDimensionSchoolSkillUsed = {
    ID = "GuideCondDimensionSchoolSkillUsed",
    CnID = "指引条件@超维湮灭使用后",
    BaseSortID = 645
  },
  GuideCondBoutFirstCard = {
    ID = "GuideCondBoutFirstCard",
    CnID = "指引条件@回合打出一张牌",
    BaseSortID = 646
  },
  GuideCondAfterUseUltiSkill = {
    ID = "GuideCondAfterUseUltiSkill",
    CnID = "指引条件@狂气爆发后",
    BaseSortID = 647
  },
  GuideCondAvgEnd = {
    ID = "GuideCondAvgEnd",
    CnID = "指引条件@Avg播放完毕",
    BaseSortID = 648
  },
  GuideCondOpenedEnemyIntentionView = {
    ID = "GuideCondOpenedEnemyIntentionView",
    CnID = "指引条件@打开怪物意图后",
    BaseSortID = 649
  },
  PlayerEnter = {
    ID = "PlayerEnter",
    CnID = "进场",
    BaseSortID = 650,
    Desc = "CommonID_PlayerEnter_Desc|游戏开始，玩家选完牌后"
  },
  ReletedAwakerInEnemies = {
    ID = "ReletedAwakerInEnemies",
    CnID = "对方阵营出现关系唤醒体",
    BaseSortID = 651,
    Desc = "CommonID_ReletedAwakerInEnemies_Desc|对方阵营中的唤醒体和我方唤醒体有关系对话"
  },
  OperationStop = {
    ID = "OperationStop",
    CnID = "操作停滞",
    BaseSortID = 652,
    Desc = "CommonID_OperationStop_Desc|我方回合思考时长累积到达最大值（配置在常量表中）"
  },
  CountingStart = {
    ID = "CountingStart",
    CnID = "倒计时开始",
    BaseSortID = 653,
    Desc = "CommonID_CountingStart_Desc|我方回合中倒计时开始"
  },
  OperationImpossible = {
    ID = "OperationImpossible",
    CnID = "操作不可行",
    BaseSortID = 654,
    Desc = "CommonID_OperationImpossible_Desc|玩家由于各种原因（算力不足、非己方回合、被封印或石化等）操作不成功（出牌、狂气爆发）"
  },
  SkillReady = {
    ID = "SkillReady",
    CnID = "可进行狂气爆发",
    BaseSortID = 655,
    Desc = "CommonID_SkillReady_Desc|狂气槽满并可以点击进行狂气爆发的瞬间"
  },
  AwakerDied = {
    ID = "AwakerDied",
    CnID = "生命值归零",
    BaseSortID = 656,
    Desc = "CommonID_AwakerDied_Desc|唤醒体死亡"
  },
  TurntableCount = {
    ID = "TurntableCount",
    CnID = "转盘次数",
    BaseSortID = 657
  },
  HeadType_1 = {
    ID = "HeadType_1",
    CnID = "以银钥之名",
    BaseSortID = 658,
    Desc = "CommonID_HeadType_1_Desc|以银钥之名"
  },
  HeadType_2 = {
    ID = "HeadType_2",
    CnID = "呆呆档案照",
    BaseSortID = 659,
    Desc = "CommonID_HeadType_2_Desc|呆呆档案照"
  },
  HeadType_3 = {
    ID = "HeadType_3",
    CnID = "永不褪色的昨天",
    BaseSortID = 660,
    Desc = "CommonID_HeadType_3_Desc|永不褪色的昨天"
  },
  HeadType_4 = {
    ID = "HeadType_4",
    CnID = "典藏邮票",
    BaseSortID = 661,
    Desc = "CommonID_HeadType_4_Desc|典藏邮票"
  },
  KeyType_1 = {
    ID = "KeyType_1",
    CnID = "忘却篇",
    BaseSortID = 662,
    Desc = "CommonID_KeyType_1_Desc|忘却篇"
  },
  KeyType_2 = {
    ID = "KeyType_2",
    CnID = "混沌界域",
    BaseSortID = 663,
    Desc = "CommonID_KeyType_2_Desc|混沌界域"
  },
  KeyType_3 = {
    ID = "KeyType_3",
    CnID = "深海界域",
    BaseSortID = 664,
    Desc = "CommonID_KeyType_3_Desc|深海界域"
  },
  KeyType_4 = {
    ID = "KeyType_4",
    CnID = "血肉界域",
    BaseSortID = 665,
    Desc = "CommonID_KeyType_4_Desc|血肉界域"
  },
  KeyType_5 = {
    ID = "KeyType_5",
    CnID = "超维界域",
    BaseSortID = 666,
    Desc = "CommonID_KeyType_5_Desc|超维界域"
  },
  BattleTeachingActivity = {
    ID = "BattleTeachingActivity",
    CnID = "战斗训练活动",
    BaseSortID = 667
  }
})
return CommonID
