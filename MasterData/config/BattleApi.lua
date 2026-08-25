local System = require("System.System")
local readonly = System.readonly
local BattleApi = readonly({
  Arg1 = {
    ID = "Arg1",
    CnID = "参数1",
    BaseSortID = 1,
    ApiType = "参数"
  },
  Arg2 = {
    ID = "Arg2",
    CnID = "参数2",
    BaseSortID = 2,
    ApiType = "参数"
  },
  Arg3 = {
    ID = "Arg3",
    CnID = "参数3",
    BaseSortID = 3,
    ApiType = "参数"
  },
  Arg4 = {
    ID = "Arg4",
    CnID = "参数4",
    BaseSortID = 4,
    ApiType = "参数"
  },
  Arg5 = {
    ID = "Arg5",
    CnID = "参数5",
    BaseSortID = 5,
    ApiType = "参数"
  },
  Arg6 = {
    ID = "Arg6",
    CnID = "参数6",
    BaseSortID = 6,
    ApiType = "参数"
  },
  Arg7 = {
    ID = "Arg7",
    CnID = "参数7",
    BaseSortID = 7,
    ApiType = "参数"
  },
  Arg8 = {
    ID = "Arg8",
    CnID = "参数8",
    BaseSortID = 8,
    ApiType = "参数"
  },
  Arg9 = {
    ID = "Arg9",
    CnID = "参数9",
    BaseSortID = 9,
    ApiType = "参数"
  },
  Arg10 = {
    ID = "Arg10",
    CnID = "参数10",
    BaseSortID = 10,
    ApiType = "参数"
  },
  Arg11 = {
    ID = "Arg11",
    CnID = "参数11",
    BaseSortID = 11,
    ApiType = "参数"
  },
  Arg12 = {
    ID = "Arg12",
    CnID = "参数12",
    BaseSortID = 12,
    ApiType = "参数"
  },
  ParaPlus1 = {
    ID = "ParaPlus1",
    CnID = "固定值参数1",
    BaseSortID = 13,
    ApiType = "标记"
  },
  ParaPlus2 = {
    ID = "ParaPlus2",
    CnID = "固定值参数2",
    BaseSortID = 14,
    ApiType = "标记"
  },
  ParaPlus3 = {
    ID = "ParaPlus3",
    CnID = "固定值参数3",
    BaseSortID = 15,
    ApiType = "标记"
  },
  ParaPlus4 = {
    ID = "ParaPlus4",
    CnID = "固定值参数4",
    BaseSortID = 16,
    ApiType = "标记"
  },
  ParaPlus5 = {
    ID = "ParaPlus5",
    CnID = "固定值参数5",
    BaseSortID = 17,
    ApiType = "标记"
  },
  ParaPlus6 = {
    ID = "ParaPlus6",
    CnID = "固定值参数6",
    BaseSortID = 18,
    ApiType = "标记"
  },
  ParaPlus7 = {
    ID = "ParaPlus7",
    CnID = "固定值参数7",
    BaseSortID = 19,
    ApiType = "标记"
  },
  ParaPlus8 = {
    ID = "ParaPlus8",
    CnID = "固定值参数8",
    BaseSortID = 20,
    ApiType = "标记"
  },
  ParaPlus9 = {
    ID = "ParaPlus9",
    CnID = "固定值参数9",
    BaseSortID = 21,
    ApiType = "标记"
  },
  ParaPlus10 = {
    ID = "ParaPlus10",
    CnID = "固定值参数10",
    BaseSortID = 22,
    ApiType = "标记"
  },
  ParaPlus11 = {
    ID = "ParaPlus11",
    CnID = "固定值参数11",
    BaseSortID = 23,
    ApiType = "标记"
  },
  ParaPlus12 = {
    ID = "ParaPlus12",
    CnID = "固定值参数12",
    BaseSortID = 24,
    ApiType = "标记"
  },
  TempArg1 = {
    ID = "TempArg1",
    CnID = "变量1",
    BaseSortID = 25,
    ApiType = "指令变量"
  },
  TempArg2 = {
    ID = "TempArg2",
    CnID = "变量2",
    BaseSortID = 26,
    ApiType = "指令变量"
  },
  TempArg3 = {
    ID = "TempArg3",
    CnID = "变量3",
    BaseSortID = 27,
    ApiType = "指令变量"
  },
  TempArg4 = {
    ID = "TempArg4",
    CnID = "变量4",
    BaseSortID = 28,
    ApiType = "指令变量"
  },
  TempArg5 = {
    ID = "TempArg5",
    CnID = "变量5",
    BaseSortID = 29,
    ApiType = "指令变量"
  },
  TempArg6 = {
    ID = "TempArg6",
    CnID = "变量6",
    BaseSortID = 30,
    ApiType = "指令变量"
  },
  TempArg7 = {
    ID = "TempArg7",
    CnID = "变量7",
    BaseSortID = 31,
    ApiType = "指令变量"
  },
  TempArg8 = {
    ID = "TempArg8",
    CnID = "变量8",
    BaseSortID = 32,
    ApiType = "指令变量"
  },
  TempArg9 = {
    ID = "TempArg9",
    CnID = "变量9",
    BaseSortID = 33,
    ApiType = "指令变量"
  },
  TempArg10 = {
    ID = "TempArg10",
    CnID = "变量10",
    BaseSortID = 34,
    ApiType = "指令变量"
  },
  StateArg1 = {
    ID = "StateArg1",
    CnID = "状态参数1",
    BaseSortID = 35,
    ApiType = "参数"
  },
  StateArg2 = {
    ID = "StateArg2",
    CnID = "状态参数2",
    BaseSortID = 36,
    ApiType = "参数"
  },
  StateArg3 = {
    ID = "StateArg3",
    CnID = "状态参数3",
    BaseSortID = 37,
    ApiType = "参数"
  },
  StateArg4 = {
    ID = "StateArg4",
    CnID = "状态参数4",
    BaseSortID = 38,
    ApiType = "参数"
  },
  StateArg5 = {
    ID = "StateArg5",
    CnID = "状态参数5",
    BaseSortID = 39,
    ApiType = "参数"
  },
  StateArg6 = {
    ID = "StateArg6",
    CnID = "状态参数6",
    BaseSortID = 40,
    ApiType = "参数"
  },
  StateArg7 = {
    ID = "StateArg7",
    CnID = "状态参数7",
    BaseSortID = 41,
    ApiType = "参数"
  },
  StateArg8 = {
    ID = "StateArg8",
    CnID = "状态参数8",
    BaseSortID = 42,
    ApiType = "参数"
  },
  StateArg9 = {
    ID = "StateArg9",
    CnID = "状态参数9",
    BaseSortID = 43,
    ApiType = "参数"
  },
  StateArg10 = {
    ID = "StateArg10",
    CnID = "状态参数10",
    BaseSortID = 44,
    ApiType = "参数"
  },
  ["BESetAttr.hp"] = {
    ID = "BESetAttr.hp",
    CnID = "设定当前生命",
    BaseSortID = 45,
    ApiType = "指令"
  },
  ["BESetAttr.max_keeper_energy"] = {
    ID = "BESetAttr.max_keeper_energy",
    CnID = "设置基础钥能上限",
    BaseSortID = 46,
    ApiType = "指令"
  },
  BESetTempArg = {
    ID = "BESetTempArg",
    CnID = "创建临时变量",
    BaseSortID = 47,
    ApiType = "指令"
  },
  ["BESetAttr.max_hp"] = {
    ID = "BESetAttr.max_hp",
    CnID = "设定最大生命",
    BaseSortID = 48,
    ApiType = "指令"
  },
  ["BESetAttr.keeper_energy_eff"] = {
    ID = "BESetAttr.keeper_energy_eff",
    CnID = "设置银钥充能效率",
    BaseSortID = 49,
    ApiType = "指令"
  },
  ["BEChangeAttr.block"] = {
    ID = "BEChangeAttr.block",
    CnID = "改变护盾",
    BaseSortID = 50,
    ApiType = "指令"
  },
  ["BEChangeAttr.hp"] = {
    ID = "BEChangeAttr.hp",
    CnID = "改变当前生命",
    BaseSortID = 51,
    ApiType = "指令"
  },
  ["BEChangeAttr.hp_per"] = {
    ID = "BEChangeAttr.hp_per",
    CnID = "改变当前生命百分比加成",
    BaseSortID = 52,
    ApiType = "指令"
  },
  ["BEChangeAttr.death_resist"] = {
    ID = "BEChangeAttr.death_resist",
    CnID = "改变死亡抵抗",
    BaseSortID = 53,
    ApiType = "指令"
  },
  BEChangeMaxHp = {
    ID = "BEChangeMaxHp",
    CnID = "改变最大生命",
    BaseSortID = 54,
    ApiType = "指令"
  },
  ["BEChangeAttr.atk"] = {
    ID = "BEChangeAttr.atk",
    CnID = "改变基础攻击力",
    BaseSortID = 55,
    ApiType = "指令"
  },
  ["BEChangeAttr.atk_per"] = {
    ID = "BEChangeAttr.atk_per",
    CnID = "改变攻击力百分比加成",
    BaseSortID = 56,
    ApiType = "指令"
  },
  ["BEChangeAttr.def"] = {
    ID = "BEChangeAttr.def",
    CnID = "改变基础防御力",
    BaseSortID = 57,
    ApiType = "指令"
  },
  ["BEChangeAttr.def_per"] = {
    ID = "BEChangeAttr.def_per",
    CnID = "改变防御力百分比加成",
    BaseSortID = 58,
    ApiType = "指令"
  },
  ["BEChangeAttr.block_heal_per"] = {
    ID = "BEChangeAttr.block_heal_per",
    CnID = "改变护盾和治疗强效",
    BaseSortID = 59,
    ApiType = "指令"
  },
  ["BEChangeAttr.ulti_energy"] = {
    ID = "BEChangeAttr.ulti_energy",
    CnID = "改变狂气",
    BaseSortID = 60,
    ApiType = "指令"
  },
  ["BEChangeAttr.ulti_energy_passive"] = {
    ID = "BEChangeAttr.ulti_energy_passive",
    CnID = "改变狂气回复",
    BaseSortID = 61,
    ApiType = "指令"
  },
  ["BEChangeAttr.ulti_energy_init"] = {
    ID = "BEChangeAttr.ulti_energy_init",
    CnID = "改变开场狂气",
    BaseSortID = 62,
    ApiType = "指令"
  },
  ["BEChangeAttr.ulti_energy_return"] = {
    ID = "BEChangeAttr.ulti_energy_return",
    CnID = "改变狂气消耗降低",
    BaseSortID = 63,
    ApiType = "指令"
  },
  ["BEChangeAttr.damage_plus"] = {
    ID = "BEChangeAttr.damage_plus",
    CnID = "改变造成伤害固定值修正",
    BaseSortID = 64,
    ApiType = "指令"
  },
  ["BEChangeAttr.damage_per"] = {
    ID = "BEChangeAttr.damage_per",
    CnID = "改变造成伤害百分比修正",
    BaseSortID = 65,
    ApiType = "指令"
  },
  ["BEChangeAttr.be_damage_plus"] = {
    ID = "BEChangeAttr.be_damage_plus",
    CnID = "改变承受伤害固定值修正",
    BaseSortID = 66,
    ApiType = "指令"
  },
  ["BEChangeAttr.be_damage_per"] = {
    ID = "BEChangeAttr.be_damage_per",
    CnID = "改变承受主动和触腕伤害百分比修正",
    BaseSortID = 67,
    ApiType = "指令"
  },
  ["BEChangeAttr.heal_plus"] = {
    ID = "BEChangeAttr.heal_plus",
    CnID = "改变造成治疗固定值修正",
    BaseSortID = 68,
    ApiType = "指令"
  },
  ["BEChangeAttr.be_heal_plus"] = {
    ID = "BEChangeAttr.be_heal_plus",
    CnID = "改变承受治疗固定值修正",
    BaseSortID = 69,
    ApiType = "指令"
  },
  ["BEChangeAttr.be_heal_per"] = {
    ID = "BEChangeAttr.be_heal_per",
    CnID = "改变承受治疗百分比修正",
    BaseSortID = 70,
    ApiType = "指令"
  },
  ["BEChangeAttr.block_plus"] = {
    ID = "BEChangeAttr.block_plus",
    CnID = "改变造成护盾固定值修正",
    BaseSortID = 71,
    ApiType = "指令"
  },
  ["BEChangeAttr.gain_block_plus"] = {
    ID = "BEChangeAttr.gain_block_plus",
    CnID = "改变承受护盾固定值修正",
    BaseSortID = 72,
    ApiType = "指令"
  },
  ["BEChangeAttr.gain_block_per"] = {
    ID = "BEChangeAttr.gain_block_per",
    CnID = "改变承受护盾百分比修正",
    BaseSortID = 73,
    ApiType = "指令"
  },
  ["BEChangeAttr.ulti_energy_plus"] = {
    ID = "BEChangeAttr.ulti_energy_plus",
    CnID = "改变造成狂气固定值修正",
    BaseSortID = 74,
    ApiType = "指令"
  },
  ["BEChangeAttr.ulti_energy_per"] = {
    ID = "BEChangeAttr.ulti_energy_per",
    CnID = "改变造成狂气百分比修正",
    BaseSortID = 75,
    ApiType = "指令"
  },
  ["BEChangeAttr.gain_ulti_energy_plus"] = {
    ID = "BEChangeAttr.gain_ulti_energy_plus",
    CnID = "改变承受狂气固定值修正",
    BaseSortID = 76,
    ApiType = "指令"
  },
  ["BEChangeAttr.gain_ulti_energy_per"] = {
    ID = "BEChangeAttr.gain_ulti_energy_per",
    CnID = "改变承受狂气百分比修正",
    BaseSortID = 77,
    ApiType = "指令"
  },
  ["BEChangeAttr.weak_per"] = {
    ID = "BEChangeAttr.weak_per",
    CnID = "改变虚弱百分比修正",
    BaseSortID = 78,
    ApiType = "指令"
  },
  ["BEChangeAttr.vulnerable_per"] = {
    ID = "BEChangeAttr.vulnerable_per",
    CnID = "改变易伤百分比修正",
    BaseSortID = 79,
    ApiType = "指令"
  },
  ["BEChangeAttr.frail_per"] = {
    ID = "BEChangeAttr.frail_per",
    CnID = "改变脆弱百分比修正",
    BaseSortID = 80,
    ApiType = "指令"
  },
  ["BEChangeAttr.damagetimes_plus"] = {
    ID = "BEChangeAttr.damagetimes_plus",
    CnID = "改变伤害次数固定值修正",
    BaseSortID = 81,
    ApiType = "指令"
  },
  ["BEChangeAttr.block_reserve"] = {
    ID = "BEChangeAttr.block_reserve",
    CnID = "改变护盾保留",
    BaseSortID = 82,
    ApiType = "指令"
  },
  ["BEChangeAttr.anti_crit"] = {
    ID = "BEChangeAttr.anti_crit",
    CnID = "改变暴击抵抗",
    BaseSortID = 83,
    ApiType = "指令"
  },
  ["BEChangeAttr.heal_per"] = {
    ID = "BEChangeAttr.heal_per",
    CnID = "改变造成治疗百分比修正",
    BaseSortID = 84,
    ApiType = "指令"
  },
  ["BEChangeAttr.enchant_upgrade_per"] = {
    ID = "BEChangeAttr.enchant_upgrade_per",
    CnID = "改变幸运刻印率",
    BaseSortID = 85,
    ApiType = "指令"
  },
  ["BEChangeAttr.block_per"] = {
    ID = "BEChangeAttr.block_per",
    CnID = "改变造成护盾百分比修正",
    BaseSortID = 86,
    ApiType = "指令"
  },
  ["BEChangeAttr.blind"] = {
    ID = "BEChangeAttr.blind",
    CnID = "改变隐藏意图",
    BaseSortID = 87,
    ApiType = "指令"
  },
  ["BEChangeAttr.bout_ulti_times"] = {
    ID = "BEChangeAttr.bout_ulti_times",
    CnID = "改变狂气爆发冷却",
    BaseSortID = 88,
    ApiType = "指令"
  },
  blind = {
    ID = "blind",
    CnID = "隐藏怪物意图",
    BaseSortID = 89,
    ApiType = "角色属性"
  },
  BEPlayCardVFX = {
    ID = "BEPlayCardVFX",
    CnID = "播放卡牌特效",
    BaseSortID = 90,
    ApiType = "指令"
  },
  BEPlaySceneVFX = {
    ID = "BEPlaySceneVFX",
    CnID = "播放场景特效",
    BaseSortID = 91,
    ApiType = "指令"
  },
  ChangeCardIcon24 = {
    ID = "ChangeCardIcon24",
    CnID = "24切换卡面",
    BaseSortID = 92,
    ApiType = "标记",
    Data = "15601,{Card_Strike,Card_Defend,Card_Skill},Portrait/Card/Portrait_Card_Awaker_C06_AF_2.png"
  },
  ChangeCardIcon24_2 = {
    ID = "ChangeCardIcon24_2",
    CnID = "24切换卡面2",
    BaseSortID = 93,
    ApiType = "标记",
    Data = "15601,{Card_Strike,Card_Defend,Card_Skill},Portrait/Card/Portrait_Card_Awaker_C06_AF.png"
  },
  BEActiveDeathResist = {
    ID = "BEActiveDeathResist",
    CnID = "主动触发死亡抵抗",
    BaseSortID = 94,
    ApiType = "指令"
  },
  BEActiveDamage = {
    ID = "BEActiveDamage",
    CnID = "造成主动伤害",
    BaseSortID = 95,
    ApiType = "指令"
  },
  ["BEActiveDamage.State"] = {
    ID = "BEActiveDamage.State",
    CnID = "造成主动伤害并添加状态",
    BaseSortID = 96,
    ApiType = "指令"
  },
  BEPassiveDamage = {
    ID = "BEPassiveDamage",
    CnID = "造成纯粹伤害",
    BaseSortID = 97,
    ApiType = "指令"
  },
  BEFixedDamage = {
    ID = "BEFixedDamage",
    CnID = "造成固定伤害",
    BaseSortID = 98,
    ApiType = "指令"
  },
  BETentacleAttack = {
    ID = "BETentacleAttack",
    CnID = "造成触腕伤害",
    BaseSortID = 99,
    ApiType = "指令"
  },
  BEGainBlock = {
    ID = "BEGainBlock",
    CnID = "造成护盾",
    BaseSortID = 100,
    ApiType = "指令"
  },
  ["BEGainBlock.State"] = {
    ID = "BEGainBlock.State",
    CnID = "造成护盾并添加状态",
    BaseSortID = 101,
    ApiType = "指令"
  },
  BEHeal = {
    ID = "BEHeal",
    CnID = "造成治疗",
    BaseSortID = 102,
    ApiType = "指令"
  },
  BEGainUltiEnergy = {
    ID = "BEGainUltiEnergy",
    CnID = "造成狂气",
    BaseSortID = 103,
    ApiType = "指令"
  },
  BEAddState = {
    ID = "BEAddState",
    CnID = "添加状态",
    BaseSortID = 104,
    ApiType = "指令"
  },
  ["BEChangeAttr.crit"] = {
    ID = "BEChangeAttr.crit",
    CnID = "改变暴击率",
    BaseSortID = 105,
    ApiType = "指令"
  },
  ["BEChangeAttr.crit_damage"] = {
    ID = "BEChangeAttr.crit_damage",
    CnID = "改变暴击伤害",
    BaseSortID = 106,
    ApiType = "指令"
  },
  BESubStateLayer = {
    ID = "BESubStateLayer",
    CnID = "减少状态层数",
    BaseSortID = 107,
    ApiType = "指令"
  },
  BERemoveState = {
    ID = "BERemoveState",
    CnID = "移除状态",
    BaseSortID = 108,
    ApiType = "指令"
  },
  UnlockAwakenCard = {
    ID = "UnlockAwakenCard",
    CnID = "解锁灵知觉醒",
    BaseSortID = 109,
    ApiType = "指令"
  },
  LockAwakerCard = {
    ID = "LockAwakerCard",
    CnID = "锁定灵知觉醒",
    BaseSortID = 110,
    ApiType = "指令"
  },
  BEMonsterChangeSkillList = {
    ID = "BEMonsterChangeSkillList",
    CnID = "设置技能列表",
    BaseSortID = 111,
    ApiType = "指令"
  },
  BEMonsterChangeSkill = {
    ID = "BEMonsterChangeSkill",
    CnID = "设置当前技能",
    BaseSortID = 112,
    ApiType = "指令"
  },
  ["BEChangeAttr.inherent"] = {
    ID = "BEChangeAttr.inherent",
    CnID = "改变卡牌是否固有",
    BaseSortID = 113,
    ApiType = "指令"
  },
  ["BEChangeAttr.reserve"] = {
    ID = "BEChangeAttr.reserve",
    CnID = "改变卡牌是否保留",
    BaseSortID = 114,
    ApiType = "指令"
  },
  ["BEChangeAttr.card_use_times"] = {
    ID = "BEChangeAttr.card_use_times",
    CnID = "改变卡牌使用次数",
    BaseSortID = 115,
    ApiType = "指令"
  },
  BEMoveCard = {
    ID = "BEMoveCard",
    CnID = "移动卡牌",
    BaseSortID = 116,
    ApiType = "指令"
  },
  BECreateCard = {
    ID = "BECreateCard",
    CnID = "创造卡牌",
    BaseSortID = 117,
    ApiType = "指令"
  },
  BECopyCard = {
    ID = "BECopyCard",
    CnID = "复制卡牌",
    BaseSortID = 118,
    ApiType = "指令"
  },
  BECopyCardToDimension = {
    ID = "BECopyCardToDimension",
    CnID = "超维复制",
    BaseSortID = 119,
    ApiType = "指令"
  },
  BEDestroyCard = {
    ID = "BEDestroyCard",
    CnID = "永久移除卡牌",
    BaseSortID = 120,
    ApiType = "指令"
  },
  BEChangeCard = {
    ID = "BEChangeCard",
    CnID = "变化卡牌",
    BaseSortID = 121,
    ApiType = "指令"
  },
  BattleEffect60 = {
    ID = "BattleEffect60",
    CnID = "凝滞卡牌",
    BaseSortID = 122,
    ApiType = "指令"
  },
  BattleEffect61 = {
    ID = "BattleEffect61",
    CnID = "解除凝滞",
    BaseSortID = 123,
    ApiType = "指令"
  },
  BERunCardCmd = {
    ID = "BERunCardCmd",
    CnID = "释放卡牌技能",
    BaseSortID = 124,
    ApiType = "指令"
  },
  BEChangeDrawNum = {
    ID = "BEChangeDrawNum",
    CnID = "改变抽牌数",
    BaseSortID = 125,
    ApiType = "指令"
  },
  BEDrawCard = {
    ID = "BEDrawCard",
    CnID = "抽牌",
    BaseSortID = 126,
    ApiType = "指令"
  },
  GainRelic = {
    ID = "GainRelic",
    CnID = "获得造物",
    BaseSortID = 127,
    ApiType = "指令"
  },
  BattleEffect68 = {
    ID = "BattleEffect68",
    CnID = "选择获得造物",
    BaseSortID = 128,
    ApiType = "指令"
  },
  BERemoveRelic = {
    ID = "BERemoveRelic",
    CnID = "移除造物",
    BaseSortID = 129,
    ApiType = "指令"
  },
  BattleEffect70 = {
    ID = "BattleEffect70",
    CnID = "选择移除造物",
    BaseSortID = 130,
    ApiType = "指令"
  },
  BEUpgradeRelic = {
    ID = "BEUpgradeRelic",
    CnID = "升级造物",
    BaseSortID = 131,
    ApiType = "指令"
  },
  BEChangeTentacleDamage = {
    ID = "BEChangeTentacleDamage",
    CnID = "改变触腕伤害",
    BaseSortID = 132,
    ApiType = "指令"
  },
  BEChangeMaxTentacleCount = {
    ID = "BEChangeMaxTentacleCount",
    CnID = "改变触腕上限",
    BaseSortID = 133,
    ApiType = "指令"
  },
  BEChangeTentacleCount = {
    ID = "BEChangeTentacleCount",
    CnID = "改变触腕数量",
    BaseSortID = 134,
    ApiType = "指令"
  },
  BEScarletBloodChange = {
    ID = "BEScarletBloodChange",
    CnID = "改变胚胎融合度数量",
    BaseSortID = 135,
    ApiType = "指令"
  },
  BEScarletBloodMaxChange = {
    ID = "BEScarletBloodMaxChange",
    CnID = "改变胚胎融合度上限",
    BaseSortID = 136,
    ApiType = "指令"
  },
  BEScarletBloodSet = {
    ID = "BEScarletBloodSet",
    CnID = "造成胚胎融合度数量",
    BaseSortID = 137,
    ApiType = "指令"
  },
  DynamicScarleBlood = {
    ID = "DynamicScarleBlood",
    CnID = "传入胚胎融合度值",
    BaseSortID = 138,
    ApiType = "指令变量"
  },
  SetScarletBloodFormula = {
    ID = "SetScarletBloodFormula",
    CnID = "造成胚胎融合度数量公式",
    BaseSortID = 139,
    ApiType = "公式",
    Data = "math.ceil(DynamicScarleBlood*(1+CmdCaster.i_bloodchange_per/100)*(1+CmdCaster.o_bloodchange_per/100))"
  },
  BattleEffect76 = {
    ID = "BattleEffect76",
    CnID = "前往下个节点",
    BaseSortID = 140,
    ApiType = "指令"
  },
  BattleEffect77 = {
    ID = "BattleEffect77",
    CnID = "前往最终节点",
    BaseSortID = 141,
    ApiType = "指令"
  },
  BEExecuteCmd = {
    ID = "BEExecuteCmd",
    CnID = "执行指令",
    BaseSortID = 142,
    ApiType = "指令"
  },
  BEExecuteCmdByIndex = {
    ID = "BEExecuteCmdByIndex",
    CnID = "奥尔拉专用合成卡牌指令",
    BaseSortID = 143,
    ApiType = "指令"
  },
  BELastEffect = {
    ID = "BELastEffect",
    CnID = "执行上个子指令",
    BaseSortID = 144,
    ApiType = "指令"
  },
  BESummonMonster = {
    ID = "BESummonMonster",
    CnID = "创造怪物",
    BaseSortID = 145,
    ApiType = "指令"
  },
  GetCard = {
    ID = "GetCard",
    CnID = "获取卡牌",
    BaseSortID = 146,
    ApiType = "指令"
  },
  ["BEChangeAttr.damage_per_strikecard"] = {
    ID = "BEChangeAttr.damage_per_strikecard",
    CnID = "改变打击卡伤害百分比修正",
    BaseSortID = 147,
    ApiType = "指令"
  },
  ["BEChangeAttr.damage_per_card"] = {
    ID = "BEChangeAttr.damage_per_card",
    CnID = "改变卡牌伤害百分比修正",
    BaseSortID = 148,
    ApiType = "指令"
  },
  ["BEChangeAttr.damage_per_ex"] = {
    ID = "BEChangeAttr.damage_per_ex",
    CnID = "改变狂气爆发伤害百分比修正",
    BaseSortID = 149,
    ApiType = "指令"
  },
  OceanModel2Cond = {
    ID = "OceanModel2Cond",
    CnID = "触腕护卫姿态条件",
    BaseSortID = 150,
    ApiType = "公式",
    Data = "PlayerRole.GetStateLayer(80186)==0"
  },
  OceanModel3Cond = {
    ID = "OceanModel3Cond",
    CnID = "触腕疯狂姿态条件",
    BaseSortID = 151,
    ApiType = "公式",
    Data = "(PlayerRole.battle_tentacle_count+PlayerRole.permanent_tentacle_count)>1"
  },
  OceanModel4Cond = {
    ID = "OceanModel4Cond",
    CnID = "触腕疯狂姿态条件2",
    BaseSortID = 152,
    ApiType = "公式",
    Data = "PlayerRole.GetStateLayer(89748)==0"
  },
  OceanModel2CD = {
    ID = "OceanModel2CD",
    CnID = "触腕护卫姿态冷却回合数",
    BaseSortID = 153,
    ApiType = "公式",
    Data = "PlayerRole.GetStateLayer(80186)"
  },
  OceanModel3CD = {
    ID = "OceanModel3CD",
    CnID = "触腕疯狂姿态冷却回合数",
    BaseSortID = 154,
    ApiType = "公式",
    Data = "PlayerRole.GetStateLayer(89748)"
  },
  BEChangeStateParam = {
    ID = "BEChangeStateParam",
    CnID = "改变状态参数",
    BaseSortID = 155,
    ApiType = "指令"
  },
  BEChangeMoney = {
    ID = "BEChangeMoney",
    CnID = "改变贤石",
    BaseSortID = 156,
    ApiType = "指令"
  },
  BETriggerState = {
    ID = "BETriggerState",
    CnID = "触发状态",
    BaseSortID = 157,
    ApiType = "指令"
  },
  BEAddRandomState = {
    ID = "BEAddRandomState",
    CnID = "添加随机状态",
    BaseSortID = 158,
    ApiType = "指令"
  },
  BERevertChangedCard = {
    ID = "BERevertChangedCard",
    CnID = "还原卡牌",
    BaseSortID = 159,
    ApiType = "指令"
  },
  BELaunchSwallow = {
    ID = "BELaunchSwallow",
    CnID = "吞噬效果发动",
    BaseSortID = 160,
    ApiType = "指令"
  },
  BELaunchJump = {
    ID = "BELaunchJump",
    CnID = "跃迁效果发动",
    BaseSortID = 161,
    ApiType = "指令"
  },
  BEMonsterChangePos = {
    ID = "BEMonsterChangePos",
    CnID = "怪物位置移动",
    BaseSortID = 162,
    ApiType = "指令"
  },
  BEShowTips = {
    ID = "BEShowTips",
    CnID = "弹出提示语",
    BaseSortID = 163,
    ApiType = "指令"
  },
  BEMonsterBubble = {
    ID = "BEMonsterBubble",
    CnID = "弹出对话气泡",
    BaseSortID = 164,
    ApiType = "指令"
  },
  BEPlayStory = {
    ID = "BEPlayStory",
    CnID = "播放剧情",
    BaseSortID = 165,
    ApiType = "指令"
  },
  BEDispelState = {
    ID = "BEDispelState",
    CnID = "驱散状态",
    BaseSortID = 166,
    ApiType = "指令"
  },
  ["BETimelineLoop.TimelineLoop"] = {
    ID = "BETimelineLoop.TimelineLoop",
    CnID = "循环表演开始",
    BaseSortID = 167,
    ApiType = "指令"
  },
  BEChangeDiePerform = {
    ID = "BEChangeDiePerform",
    CnID = "改变死亡表演",
    BaseSortID = 168,
    ApiType = "指令"
  },
  SkillLevel = {
    ID = "SkillLevel",
    CnID = "技能等级",
    BaseSortID = 169,
    ApiType = "指令变量"
  },
  GetCardLevelByID = {
    ID = "GetCardLevelByID",
    CnID = "获取指定技能等级",
    BaseSortID = 170,
    ApiType = "函数"
  },
  DynamicDmg = {
    ID = "DynamicDmg",
    CnID = "动态参数计算伤害值",
    BaseSortID = 171,
    ApiType = "指令变量"
  },
  CardDmg = {
    ID = "CardDmg",
    CnID = "卡面伤害值",
    BaseSortID = 172,
    ApiType = "指令变量"
  },
  IsCrit = {
    ID = "IsCrit",
    CnID = "是否暴击",
    BaseSortID = 173,
    ApiType = "指令变量"
  },
  GrowArgValue = {
    ID = "GrowArgValue",
    CnID = "成长系数",
    BaseSortID = 174,
    ApiType = "指令变量"
  },
  BattleFomula1 = {
    ID = "BattleFomula1",
    CnID = "乘法成长",
    BaseSortID = 175,
    ApiType = "公式",
    Data = "(( SkillLevel-1 )*20+100)/100*GrowArgValue"
  },
  BattleFomula005 = {
    ID = "BattleFomula005",
    CnID = "加法成长005",
    BaseSortID = 176,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*0.05"
  },
  BattleFomula01 = {
    ID = "BattleFomula01",
    CnID = "加法成长01",
    BaseSortID = 177,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*0.1"
  },
  BattleFomula2 = {
    ID = "BattleFomula2",
    CnID = "加法成长1",
    BaseSortID = 178,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)"
  },
  BattleFomula3 = {
    ID = "BattleFomula3",
    CnID = "加法成长2",
    BaseSortID = 179,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*2"
  },
  BattleFomula4 = {
    ID = "BattleFomula4",
    CnID = "加法成长3",
    BaseSortID = 180,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*3"
  },
  BattleFomula5 = {
    ID = "BattleFomula5",
    CnID = "加法成长4",
    BaseSortID = 181,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*4"
  },
  BattleFomula6 = {
    ID = "BattleFomula6",
    CnID = "加法成长5",
    BaseSortID = 182,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*5"
  },
  BattleFomula7 = {
    ID = "BattleFomula7",
    CnID = "加法成长6",
    BaseSortID = 183,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*6"
  },
  BattleFomula8 = {
    ID = "BattleFomula8",
    CnID = "加法成长7",
    BaseSortID = 184,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*7"
  },
  BattleFomula9 = {
    ID = "BattleFomula9",
    CnID = "加法成长8",
    BaseSortID = 185,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*8"
  },
  BattleFomula10 = {
    ID = "BattleFomula10",
    CnID = "加法成长9",
    BaseSortID = 186,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*9"
  },
  BattleFomula11 = {
    ID = "BattleFomula11",
    CnID = "加法成长10",
    BaseSortID = 187,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*10"
  },
  BattleFomula12 = {
    ID = "BattleFomula12",
    CnID = "加法成长11",
    BaseSortID = 188,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*11"
  },
  BattleFomula13 = {
    ID = "BattleFomula13",
    CnID = "加法成长12",
    BaseSortID = 189,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*12"
  },
  BattleFomula14 = {
    ID = "BattleFomula14",
    CnID = "加法成长13",
    BaseSortID = 190,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*13"
  },
  BattleFomula15 = {
    ID = "BattleFomula15",
    CnID = "加法成长14",
    BaseSortID = 191,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*14"
  },
  BattleFomula16 = {
    ID = "BattleFomula16",
    CnID = "加法成长15",
    BaseSortID = 192,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*15"
  },
  BattleFomula17 = {
    ID = "BattleFomula17",
    CnID = "加法成长16",
    BaseSortID = 193,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*16"
  },
  BattleFomula18 = {
    ID = "BattleFomula18",
    CnID = "加法成长17",
    BaseSortID = 194,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*17"
  },
  BattleFomula19 = {
    ID = "BattleFomula19",
    CnID = "加法成长18",
    BaseSortID = 195,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*18"
  },
  BattleFomula20 = {
    ID = "BattleFomula20",
    CnID = "加法成长19",
    BaseSortID = 196,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*19"
  },
  BattleFomula21 = {
    ID = "BattleFomula21",
    CnID = "加法成长20",
    BaseSortID = 197,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*20"
  },
  BattleFomula22 = {
    ID = "BattleFomula22",
    CnID = "加法成长21",
    BaseSortID = 198,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*21"
  },
  BattleFomula23 = {
    ID = "BattleFomula23",
    CnID = "加法成长22",
    BaseSortID = 199,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*22"
  },
  BattleFomula24 = {
    ID = "BattleFomula24",
    CnID = "加法成长23",
    BaseSortID = 200,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*23"
  },
  BattleFomula25 = {
    ID = "BattleFomula25",
    CnID = "加法成长24",
    BaseSortID = 201,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*24"
  },
  BattleFomula26 = {
    ID = "BattleFomula26",
    CnID = "加法成长25",
    BaseSortID = 202,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*25"
  },
  BattleFomula27 = {
    ID = "BattleFomula27",
    CnID = "加法成长26",
    BaseSortID = 203,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*26"
  },
  BattleFomula28 = {
    ID = "BattleFomula28",
    CnID = "加法成长27",
    BaseSortID = 204,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*27"
  },
  BattleFomula29 = {
    ID = "BattleFomula29",
    CnID = "加法成长28",
    BaseSortID = 205,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*28"
  },
  BattleFomula30 = {
    ID = "BattleFomula30",
    CnID = "加法成长29",
    BaseSortID = 206,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*29"
  },
  BattleFomula31 = {
    ID = "BattleFomula31",
    CnID = "加法成长30",
    BaseSortID = 207,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*30"
  },
  BattleFomula32 = {
    ID = "BattleFomula32",
    CnID = "加法成长31",
    BaseSortID = 208,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*31"
  },
  BattleFomula33 = {
    ID = "BattleFomula33",
    CnID = "加法成长32",
    BaseSortID = 209,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*32"
  },
  BattleFomula34 = {
    ID = "BattleFomula34",
    CnID = "加法成长33",
    BaseSortID = 210,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*33"
  },
  BattleFomula35 = {
    ID = "BattleFomula35",
    CnID = "加法成长34",
    BaseSortID = 211,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*34"
  },
  BattleFomula36 = {
    ID = "BattleFomula36",
    CnID = "加法成长35",
    BaseSortID = 212,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*35"
  },
  BattleFomula37 = {
    ID = "BattleFomula37",
    CnID = "加法成长36",
    BaseSortID = 213,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*36"
  },
  BattleFomula38 = {
    ID = "BattleFomula38",
    CnID = "加法成长37",
    BaseSortID = 214,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*37"
  },
  BattleFomula39 = {
    ID = "BattleFomula39",
    CnID = "加法成长38",
    BaseSortID = 215,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*38"
  },
  BattleFomula40 = {
    ID = "BattleFomula40",
    CnID = "加法成长39",
    BaseSortID = 216,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*39"
  },
  BattleFomula41 = {
    ID = "BattleFomula41",
    CnID = "加法成长40",
    BaseSortID = 217,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*40"
  },
  BattleFomula42 = {
    ID = "BattleFomula42",
    CnID = "加法成长41",
    BaseSortID = 218,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*41"
  },
  BattleFomula43 = {
    ID = "BattleFomula43",
    CnID = "加法成长42",
    BaseSortID = 219,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*42"
  },
  BattleFomula44 = {
    ID = "BattleFomula44",
    CnID = "加法成长43",
    BaseSortID = 220,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*43"
  },
  BattleFomula45 = {
    ID = "BattleFomula45",
    CnID = "加法成长44",
    BaseSortID = 221,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*44"
  },
  BattleFomula46 = {
    ID = "BattleFomula46",
    CnID = "加法成长45",
    BaseSortID = 222,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*45"
  },
  BattleFomula47 = {
    ID = "BattleFomula47",
    CnID = "加法成长46",
    BaseSortID = 223,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*46"
  },
  BattleFomula48 = {
    ID = "BattleFomula48",
    CnID = "加法成长47",
    BaseSortID = 224,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*47"
  },
  BattleFomula49 = {
    ID = "BattleFomula49",
    CnID = "加法成长48",
    BaseSortID = 225,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*48"
  },
  BattleFomula50 = {
    ID = "BattleFomula50",
    CnID = "加法成长49",
    BaseSortID = 226,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*49"
  },
  BattleFomula51 = {
    ID = "BattleFomula51",
    CnID = "加法成长50",
    BaseSortID = 227,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*50"
  },
  BattleFomula52 = {
    ID = "BattleFomula52",
    CnID = "加法成长51",
    BaseSortID = 228,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*51"
  },
  BattleFomula53 = {
    ID = "BattleFomula53",
    CnID = "加法成长52",
    BaseSortID = 229,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*52"
  },
  BattleFomula54 = {
    ID = "BattleFomula54",
    CnID = "加法成长53",
    BaseSortID = 230,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*53"
  },
  BattleFomula55 = {
    ID = "BattleFomula55",
    CnID = "加法成长54",
    BaseSortID = 231,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*54"
  },
  BattleFomula56 = {
    ID = "BattleFomula56",
    CnID = "加法成长55",
    BaseSortID = 232,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*55"
  },
  BattleFomula57 = {
    ID = "BattleFomula57",
    CnID = "加法成长56",
    BaseSortID = 233,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*56"
  },
  BattleFomula58 = {
    ID = "BattleFomula58",
    CnID = "加法成长57",
    BaseSortID = 234,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*57"
  },
  BattleFomula59 = {
    ID = "BattleFomula59",
    CnID = "加法成长58",
    BaseSortID = 235,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*58"
  },
  BattleFomula60 = {
    ID = "BattleFomula60",
    CnID = "加法成长59",
    BaseSortID = 236,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*59"
  },
  BattleFomula61 = {
    ID = "BattleFomula61",
    CnID = "加法成长60",
    BaseSortID = 237,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*60"
  },
  BattleFomula62 = {
    ID = "BattleFomula62",
    CnID = "加法成长61",
    BaseSortID = 238,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*61"
  },
  BattleFomula63 = {
    ID = "BattleFomula63",
    CnID = "加法成长62",
    BaseSortID = 239,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*62"
  },
  BattleFomula64 = {
    ID = "BattleFomula64",
    CnID = "加法成长63",
    BaseSortID = 240,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*63"
  },
  BattleFomula65 = {
    ID = "BattleFomula65",
    CnID = "加法成长64",
    BaseSortID = 241,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*64"
  },
  BattleFomula66 = {
    ID = "BattleFomula66",
    CnID = "加法成长65",
    BaseSortID = 242,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*65"
  },
  BattleFomula67 = {
    ID = "BattleFomula67",
    CnID = "加法成长66",
    BaseSortID = 243,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*66"
  },
  BattleFomula68 = {
    ID = "BattleFomula68",
    CnID = "加法成长67",
    BaseSortID = 244,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*67"
  },
  BattleFomula69 = {
    ID = "BattleFomula69",
    CnID = "加法成长68",
    BaseSortID = 245,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*68"
  },
  BattleFomula70 = {
    ID = "BattleFomula70",
    CnID = "加法成长69",
    BaseSortID = 246,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*69"
  },
  BattleFomula71 = {
    ID = "BattleFomula71",
    CnID = "加法成长70",
    BaseSortID = 247,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*70"
  },
  BattleFomula72 = {
    ID = "BattleFomula72",
    CnID = "加法成长71",
    BaseSortID = 248,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*71"
  },
  BattleFomula73 = {
    ID = "BattleFomula73",
    CnID = "加法成长72",
    BaseSortID = 249,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*72"
  },
  BattleFomula74 = {
    ID = "BattleFomula74",
    CnID = "加法成长73",
    BaseSortID = 250,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*73"
  },
  BattleFomula75 = {
    ID = "BattleFomula75",
    CnID = "加法成长74",
    BaseSortID = 251,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*74"
  },
  BattleFomula76 = {
    ID = "BattleFomula76",
    CnID = "加法成长75",
    BaseSortID = 252,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*75"
  },
  BattleFomula77 = {
    ID = "BattleFomula77",
    CnID = "加法成长76",
    BaseSortID = 253,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*76"
  },
  BattleFomula78 = {
    ID = "BattleFomula78",
    CnID = "加法成长77",
    BaseSortID = 254,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*77"
  },
  BattleFomula79 = {
    ID = "BattleFomula79",
    CnID = "加法成长78",
    BaseSortID = 255,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*78"
  },
  BattleFomula80 = {
    ID = "BattleFomula80",
    CnID = "加法成长79",
    BaseSortID = 256,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*79"
  },
  BattleFomula81 = {
    ID = "BattleFomula81",
    CnID = "加法成长80",
    BaseSortID = 257,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*80"
  },
  BattleFomula82 = {
    ID = "BattleFomula82",
    CnID = "加法成长81",
    BaseSortID = 258,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*81"
  },
  BattleFomula83 = {
    ID = "BattleFomula83",
    CnID = "加法成长82",
    BaseSortID = 259,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*82"
  },
  BattleFomula84 = {
    ID = "BattleFomula84",
    CnID = "加法成长83",
    BaseSortID = 260,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*83"
  },
  BattleFomula85 = {
    ID = "BattleFomula85",
    CnID = "加法成长84",
    BaseSortID = 261,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*84"
  },
  BattleFomula86 = {
    ID = "BattleFomula86",
    CnID = "加法成长85",
    BaseSortID = 262,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*85"
  },
  BattleFomula87 = {
    ID = "BattleFomula87",
    CnID = "加法成长86",
    BaseSortID = 263,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*86"
  },
  BattleFomula88 = {
    ID = "BattleFomula88",
    CnID = "加法成长87",
    BaseSortID = 264,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*87"
  },
  BattleFomula89 = {
    ID = "BattleFomula89",
    CnID = "加法成长88",
    BaseSortID = 265,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*88"
  },
  BattleFomula90 = {
    ID = "BattleFomula90",
    CnID = "加法成长89",
    BaseSortID = 266,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*89"
  },
  BattleFomula91 = {
    ID = "BattleFomula91",
    CnID = "加法成长90",
    BaseSortID = 267,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*90"
  },
  BattleFomula92 = {
    ID = "BattleFomula92",
    CnID = "加法成长91",
    BaseSortID = 268,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*91"
  },
  BattleFomula93 = {
    ID = "BattleFomula93",
    CnID = "加法成长92",
    BaseSortID = 269,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*92"
  },
  BattleFomula94 = {
    ID = "BattleFomula94",
    CnID = "加法成长93",
    BaseSortID = 270,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*93"
  },
  BattleFomula95 = {
    ID = "BattleFomula95",
    CnID = "加法成长94",
    BaseSortID = 271,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*94"
  },
  BattleFomula96 = {
    ID = "BattleFomula96",
    CnID = "加法成长95",
    BaseSortID = 272,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*95"
  },
  BattleFomula97 = {
    ID = "BattleFomula97",
    CnID = "加法成长96",
    BaseSortID = 273,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*96"
  },
  BattleFomula98 = {
    ID = "BattleFomula98",
    CnID = "加法成长97",
    BaseSortID = 274,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*97"
  },
  BattleFomula99 = {
    ID = "BattleFomula99",
    CnID = "加法成长98",
    BaseSortID = 275,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*98"
  },
  BattleFomula100 = {
    ID = "BattleFomula100",
    CnID = "加法成长99",
    BaseSortID = 276,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*99"
  },
  BattleFomula101 = {
    ID = "BattleFomula101",
    CnID = "加法成长100",
    BaseSortID = 277,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*100"
  },
  BattleFomula102 = {
    ID = "BattleFomula102",
    CnID = "加法成长200",
    BaseSortID = 278,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*200"
  },
  BattleFomula = {
    ID = "BattleFomula",
    CnID = "无成长",
    BaseSortID = 279,
    ApiType = "公式",
    Data = "GrowArgValue"
  },
  BattleFomula05 = {
    ID = "BattleFomula05",
    CnID = "加法成长0.5",
    BaseSortID = 280,
    ApiType = "公式",
    Data = "GrowArgValue+(SkillLevel-1)*0.5"
  },
  SchoolIndex = {
    ID = "SchoolIndex",
    CnID = "职业中文索引",
    BaseSortID = 281,
    ApiType = "标记"
  },
  GrowArgValue1 = {
    ID = "GrowArgValue1",
    CnID = "成长系数1",
    BaseSortID = 282,
    ApiType = "指令变量"
  },
  GrowArgValue2 = {
    ID = "GrowArgValue2",
    CnID = "成长系数2",
    BaseSortID = 283,
    ApiType = "指令变量"
  },
  GrowArgValue3 = {
    ID = "GrowArgValue3",
    CnID = "成长系数3",
    BaseSortID = 284,
    ApiType = "指令变量"
  },
  GrowArgValue4 = {
    ID = "GrowArgValue4",
    CnID = "成长系数4",
    BaseSortID = 285,
    ApiType = "指令变量"
  },
  GrowArgValue5 = {
    ID = "GrowArgValue5",
    CnID = "成长系数5",
    BaseSortID = 286,
    ApiType = "指令变量"
  },
  GrowArgValue6 = {
    ID = "GrowArgValue6",
    CnID = "成长系数6",
    BaseSortID = 287,
    ApiType = "指令变量"
  },
  GrowArgValue7 = {
    ID = "GrowArgValue7",
    CnID = "成长系数7",
    BaseSortID = 288,
    ApiType = "指令变量"
  },
  GrowArgValue8 = {
    ID = "GrowArgValue8",
    CnID = "成长系数8",
    BaseSortID = 289,
    ApiType = "指令变量"
  },
  GrowArgValue9 = {
    ID = "GrowArgValue9",
    CnID = "成长系数9",
    BaseSortID = 290,
    ApiType = "指令变量"
  },
  GrowArgValue10 = {
    ID = "GrowArgValue10",
    CnID = "成长系数10",
    BaseSortID = 291,
    ApiType = "指令变量"
  },
  GrowArgValue11 = {
    ID = "GrowArgValue11",
    CnID = "成长系数11",
    BaseSortID = 292,
    ApiType = "指令变量"
  },
  BattleCardDmgFormula = {
    ID = "BattleCardDmgFormula",
    CnID = "卡面伤害公式",
    BaseSortID = 293,
    ApiType = "公式",
    Data = "math.ceil(math.max((DynamicDmg+CmdCaster.damage_plus)*(1+CmdCaster.damage_per/100)*(1-CmdCaster.weak_per/100),1))"
  },
  BattleRealDmgFormula = {
    ID = "BattleRealDmgFormula",
    CnID = "打出伤害公式",
    BaseSortID = 294,
    ApiType = "公式",
    Data = "(CardDmg*( 1 + (IsCrit and (CmdCaster.crit_damage/100 + CmdOwner.crit_damage/100) or 0))+HitTarget.be_damage_plus)*(1+HitTarget.be_damage_per/100) *(1+HitTarget.vulnerable_per/100)"
  },
  BattlePunctureDmgFormula = {
    ID = "BattlePunctureDmgFormula",
    CnID = "打出穿刺伤害公式",
    BaseSortID = 295,
    ApiType = "公式",
    Data = "(CardDmg*( 1 + (IsCrit and (CmdCaster.crit_damage/100 + CmdOwner.crit_damage/100) or 0))+math.max(0,HitTarget.be_damage_plus))*math.max(1,1+HitTarget.be_damage_per/100) *math.max(1,1+HitTarget.vulnerable_per/100)"
  },
  BattleAtkForce = {
    ID = "BattleAtkForce",
    CnID = "攻击强度",
    BaseSortID = 296,
    ApiType = "公式",
    Data = "math.ceil(TargetCmdOwner.atk*(1 + TargetCmdOwner.atk_per/100))"
  },
  BattleDefForce = {
    ID = "BattleDefForce",
    CnID = "防御强度",
    BaseSortID = 297,
    ApiType = "公式",
    Data = "math.ceil(TargetCmdOwner.def*(1 + TargetCmdOwner.def_per/100))"
  },
  BattlePhysiqueForce = {
    ID = "BattlePhysiqueForce",
    CnID = "体质强度",
    BaseSortID = 298,
    ApiType = "公式",
    Data = "math.ceil(TargetCmdOwner.physique*(1 + TargetCmdOwner.physique_per/100))"
  },
  DynamicBlock = {
    ID = "DynamicBlock",
    CnID = "传入护盾值",
    BaseSortID = 299,
    ApiType = "指令变量"
  },
  ProduceBlockFormula = {
    ID = "ProduceBlockFormula",
    CnID = "造成护盾公式",
    BaseSortID = 300,
    ApiType = "公式",
    Data = "math.ceil(math.max((DynamicBlock+CmdCaster.block_plus) * (1 + CmdCaster.block_per/100)*(1-CmdCaster.frail_per/100),1))"
  },
  ProduceBlock = {
    ID = "ProduceBlock",
    CnID = "造成护盾值",
    BaseSortID = 301,
    ApiType = "指令变量"
  },
  GainBlockFormula = {
    ID = "GainBlockFormula",
    CnID = "获得护盾公式",
    BaseSortID = 302,
    ApiType = "公式",
    Data = "(ProduceBlock+HitTarget.gain_block_plus) * (1 + HitTarget.gain_block_per/100)"
  },
  GainBlock = {
    ID = "GainBlock",
    CnID = "获得护盾值",
    BaseSortID = 303,
    ApiType = "指令变量"
  },
  CardUltiPer = {
    ID = "CardUltiPer",
    CnID = "卡牌获取狂气百分比修正",
    BaseSortID = 304,
    ApiType = "指令变量"
  },
  DynamicUltiEne = {
    ID = "DynamicUltiEne",
    CnID = "传入狂气值",
    BaseSortID = 305,
    ApiType = "指令变量"
  },
  ProduceUltiEneFormula = {
    ID = "ProduceUltiEneFormula",
    CnID = "造成狂气公式",
    BaseSortID = 306,
    ApiType = "公式",
    Data = "math.ceil((DynamicUltiEne+CmdCaster.ulti_energy_plus) * (1 + CmdCaster.ulti_energy_per/100)*(1+CmdCaster.ulti_energy_efficiency/100)*(1+CardUltiPer/100))"
  },
  ProduceUltiEneFormulaCompare = {
    ID = "ProduceUltiEneFormulaCompare",
    CnID = "造成狂气公式（卡面标色对比用）",
    BaseSortID = 307,
    ApiType = "公式",
    Data = "math.ceil((DynamicUltiEne+CmdCaster.ulti_energy_plus) * (1 + CmdCaster.ulti_energy_per/100)*(1+CardUltiPer/100))"
  },
  ProduceUltiEne = {
    ID = "ProduceUltiEne",
    CnID = "造成狂气值",
    BaseSortID = 308,
    ApiType = "指令变量"
  },
  GainUltiEneFormula = {
    ID = "GainUltiEneFormula",
    CnID = "获得狂气公式",
    BaseSortID = 309,
    ApiType = "公式",
    Data = "(ProduceUltiEne+HitTarget.gain_ulti_energy_plus) * (1 + HitTarget.gain_ulti_energy_per/100)"
  },
  GainUltiEne = {
    ID = "GainUltiEne",
    CnID = "获得狂气值",
    BaseSortID = 310,
    ApiType = "指令变量"
  },
  DynamicHeal = {
    ID = "DynamicHeal",
    CnID = "传入治疗值",
    BaseSortID = 311,
    ApiType = "指令变量"
  },
  ProduceHealFormula = {
    ID = "ProduceHealFormula",
    CnID = "造成治疗公式",
    BaseSortID = 312,
    ApiType = "公式",
    Data = "math.ceil(math.max((DynamicHeal+CmdCaster.heal_plus)*(1 + CmdCaster.heal_per/100),1))"
  },
  ProduceHeal = {
    ID = "ProduceHeal",
    CnID = "造成治疗值",
    BaseSortID = 313,
    ApiType = "指令变量"
  },
  GainHealFormula = {
    ID = "GainHealFormula",
    CnID = "获得治疗公式",
    BaseSortID = 314,
    ApiType = "公式",
    Data = "(ProduceHeal+HitTarget.be_heal_plus) * (1 + HitTarget.be_heal_per/100)"
  },
  GainHeal = {
    ID = "GainHeal",
    CnID = "获得治疗值",
    BaseSortID = 315,
    ApiType = "指令变量"
  },
  DynamicTentacleDmg = {
    ID = "DynamicTentacleDmg",
    CnID = "传入触腕伤害值",
    BaseSortID = 316,
    ApiType = "指令变量"
  },
  TentacleRealDmg = {
    ID = "TentacleRealDmg",
    CnID = "触腕打出伤害",
    BaseSortID = 317,
    ApiType = "公式",
    Data = "math.max(DynamicTentacleDmg*( 1 + (IsCrit and tentacle_crit_dmg/100 or 0))*(1+HitTarget.be_damage_per/100) *(1+HitTarget.vulnerable_per/100),1)"
  },
  ExtraMonsterDamage = {
    ID = "ExtraMonsterDamage",
    CnID = "额外敌方伤害",
    BaseSortID = 318,
    ApiType = "公式"
  },
  ExtraMonsterTotalStateDmg = {
    ID = "ExtraMonsterTotalStateDmg",
    CnID = "额外敌方状态伤害总和",
    BaseSortID = 319,
    ApiType = "公式",
    Data = "math.floor((HandDeck.GetCardByID(60285,999).GetCardCount()*FrontEnemy.atk*0.30)+(HandDeck.GetCardByID(24713,999).GetCardCount()*FrontEnemy.atk*0.25)+(PlayerRole.GetStateLayer(25418)*PlayerRole.GetStateLayer(35508))+(HandDeck.GetCardByID(4054,999).GetCardCount()*math.floor(GetStagePower()*0.02))+(HandDeck.GetCardByID(4248,999).GetCardCount()*PlayerRole.GetStateLayer(2958))+PlayerRole.GetStateLayer(36014)+PlayerRole.GetStateLayer(3068)+PlayerRole.GetStateLayer(2840)+math.min(PlayerRole.block,PlayerRole.GetStateLayer(78695)))"
  },
  ExtraMonsterTotalTentacleDmg = {
    ID = "ExtraMonsterTotalTentacleDmg",
    CnID = "额外敌方触腕伤害总和",
    BaseSortID = 320,
    ApiType = "公式",
    Data = "GetMonsterByPos(-15).tentacle_count*GetMonsterByPos(-15).tentacle_dmg +GetMonsterByPos(-14).tentacle_count*GetMonsterByPos(-14).tentacle_dmg +GetMonsterByPos(-13).tentacle_count*GetMonsterByPos(-13).tentacle_dmg +GetMonsterByPos(-12).tentacle_count*GetMonsterByPos(-12).tentacle_dmg +GetMonsterByPos(-11).tentacle_count*GetMonsterByPos(-11).tentacle_dmg +GetMonsterByPos(-10).tentacle_count*GetMonsterByPos(-10).tentacle_dmg +GetMonsterByPos(-9).tentacle_count*GetMonsterByPos(-9).tentacle_dmg +GetMonsterByPos(-8).tentacle_count*GetMonsterByPos(-8).tentacle_dmg +GetMonsterByPos(-7).tentacle_count*GetMonsterByPos(-7).tentacle_dmg +GetMonsterByPos(-6).tentacle_count*GetMonsterByPos(-6).tentacle_dmg +GetMonsterByPos(-5).tentacle_count*GetMonsterByPos(-5).tentacle_dmg +GetMonsterByPos(-4).tentacle_count*GetMonsterByPos(-4).tentacle_dmg +GetMonsterByPos(-3).tentacle_count*GetMonsterByPos(-3).tentacle_dmg +GetMonsterByPos(-2).tentacle_count*GetMonsterByPos(-2).tentacle_dmg +GetMonsterByPos(-1).tentacle_count*GetMonsterByPos(-1).tentacle_dmg +GetMonsterByPos(0).tentacle_count*GetMonsterByPos(0).tentacle_dmg +GetMonsterByPos(1).tentacle_count*GetMonsterByPos(1).tentacle_dmg +GetMonsterByPos(2).tentacle_count*GetMonsterByPos(2).tentacle_dmg +GetMonsterByPos(3).tentacle_count*GetMonsterByPos(3).tentacle_dmg +GetMonsterByPos(4).tentacle_count*GetMonsterByPos(4).tentacle_dmg +GetMonsterByPos(5).tentacle_count*GetMonsterByPos(5).tentacle_dmg +GetMonsterByPos(6).tentacle_count*GetMonsterByPos(6).tentacle_dmg +GetMonsterByPos(7).tentacle_count*GetMonsterByPos(7).tentacle_dmg +GetMonsterByPos(8).tentacle_count*GetMonsterByPos(8).tentacle_dmg +GetMonsterByPos(9).tentacle_count*GetMonsterByPos(9).tentacle_dmg +GetMonsterByPos(10).tentacle_count*GetMonsterByPos(10).tentacle_dmg +GetMonsterByPos(11).tentacle_count*GetMonsterByPos(11).tentacle_dmg +GetMonsterByPos(12).tentacle_count*GetMonsterByPos(12).tentacle_dmg +GetMonsterByPos(13).tentacle_count*GetMonsterByPos(13).tentacle_dmg +GetMonsterByPos(14).tentacle_count*GetMonsterByPos(14).tentacle_dmg +GetMonsterByPos(15).tentacle_count*GetMonsterByPos(15).tentacle_dmg"
  },
  DamagePosionFormula = {
    ID = "DamagePosionFormula",
    CnID = "等量伤害的中毒公式",
    BaseSortID = 321,
    ApiType = "公式",
    Data = "(1+CmdCaster.state_layer_per_posion/100)*(1+CmdCaster.posion_layer_rate_from_active_dmg/100)"
  },
  DamageCounterAttackFormula = {
    ID = "DamageCounterAttackFormula",
    CnID = "等量伤害的反击公式",
    BaseSortID = 322,
    ApiType = "公式",
    Data = "(1+CmdCaster.state_layer_per_counterattack/100)*(1+CmdCaster.counterattack_layer_rate_from_active_dmg/100)"
  },
  DamageBloodAttackFormula = {
    ID = "DamageBloodAttackFormula",
    CnID = "等量伤害的出血公式",
    BaseSortID = 323,
    ApiType = "公式",
    Data = "(1+CmdCaster.state_layer_per_bleeding/100)"
  },
  PosionFormula = {
    ID = "PosionFormula",
    CnID = "强效中毒公式",
    BaseSortID = 324,
    ApiType = "公式",
    Data = "(1+PlayerRole.basic_damage_per/100)*(1+CmdCaster.state_layer_per_posion/100)"
  },
  CounterAttackFormula = {
    ID = "CounterAttackFormula",
    CnID = "强效反击公式",
    BaseSortID = 325,
    ApiType = "公式",
    Data = "(1+PlayerRole.basic_damage_per/100)*(1+CmdCaster.state_layer_per_counterattack/100)"
  },
  TargetCardOwner = {
    ID = "TargetCardOwner",
    CnID = "卡牌归属者",
    BaseSortID = 326,
    ApiType = "目标"
  },
  ID = {
    ID = "ID",
    CnID = "中文索引",
    BaseSortID = 327,
    ApiType = "功能属性"
  },
  MonsterPos = {
    ID = "MonsterPos",
    CnID = "位置",
    BaseSortID = 328,
    ApiType = "功能属性"
  },
  UniqueID = {
    ID = "UniqueID",
    CnID = "唯一索引",
    BaseSortID = 329,
    ApiType = "功能属性"
  },
  CurDeathResist = {
    ID = "CurDeathResist",
    CnID = "当前死亡抵抗",
    BaseSortID = 330,
    ApiType = "功能属性"
  },
  GetOriginHistoryCard = {
    ID = "GetOriginHistoryCard",
    CnID = "检索打出过的卡牌",
    BaseSortID = 331,
    ApiType = "函数"
  },
  GetCopyHistoryCard = {
    ID = "GetCopyHistoryCard",
    CnID = "获取打出过卡牌的复制",
    BaseSortID = 332,
    ApiType = "函数"
  },
  BattleTarget19 = {
    ID = "BattleTarget19",
    CnID = "选择一个其他唤醒体",
    BaseSortID = 333,
    ApiType = "目标"
  },
  SelectCard = {
    ID = "SelectCard",
    CnID = "选择获取卡牌",
    BaseSortID = 334,
    ApiType = "函数"
  },
  GetAwakerListBySchool = {
    ID = "GetAwakerListBySchool",
    CnID = "按职业获取唤醒体",
    BaseSortID = 335,
    ApiType = "函数"
  },
  GetAwakerListByAim = {
    ID = "GetAwakerListByAim",
    CnID = "按定位获取唤醒体",
    BaseSortID = 336,
    ApiType = "函数"
  },
  GetCardBySelectDrop = {
    ID = "GetCardBySelectDrop",
    CnID = "选择卡包获取卡牌",
    BaseSortID = 337,
    ApiType = "函数"
  },
  GetKeeperSkillBySelectDrop = {
    ID = "GetKeeperSkillBySelectDrop",
    CnID = "选择卡包获取钥令",
    BaseSortID = 338,
    ApiType = "函数"
  },
  ChooseAwaker = {
    ID = "ChooseAwaker",
    CnID = "选择唤醒体",
    BaseSortID = 339,
    ApiType = "目标"
  },
  ChooseOtherAwaker = {
    ID = "ChooseOtherAwaker",
    CnID = "选择其他唤醒体",
    BaseSortID = 340,
    ApiType = "目标"
  },
  CondChooseAwaker = {
    ID = "CondChooseAwaker",
    CnID = "按条件选择唤醒体",
    BaseSortID = 341,
    ApiType = "函数"
  },
  EquipOwnerAwaker = {
    ID = "EquipOwnerAwaker",
    CnID = "穿戴该武器的唤醒体",
    BaseSortID = 342,
    ApiType = "目标"
  },
  TrinketOwnerAwaker = {
    ID = "TrinketOwnerAwaker",
    CnID = "穿戴该饰品的唤醒体",
    BaseSortID = 343,
    ApiType = "目标"
  },
  LastTarget = {
    ID = "LastTarget",
    CnID = "上条子指令目标",
    BaseSortID = 344,
    ApiType = "目标"
  },
  AllAwaker = {
    ID = "AllAwaker",
    CnID = "所有唤醒体",
    BaseSortID = 345,
    ApiType = "目标"
  },
  MinEngergyAwaker = {
    ID = "MinEngergyAwaker",
    CnID = "能量最低唤醒体",
    BaseSortID = 346,
    ApiType = "目标"
  },
  MaxEngergyAwaker = {
    ID = "MaxEngergyAwaker",
    CnID = "能量最高唤醒体",
    BaseSortID = 347,
    ApiType = "目标"
  },
  RandomAwaker = {
    ID = "RandomAwaker",
    CnID = "随机唤醒体",
    BaseSortID = 348,
    ApiType = "目标"
  },
  OtherAwaker = {
    ID = "OtherAwaker",
    CnID = "其他唤醒体",
    BaseSortID = 349,
    ApiType = "目标"
  },
  CmdCaster = {
    ID = "CmdCaster",
    CnID = "施法者",
    BaseSortID = 350,
    ApiType = "目标"
  },
  HitTarget = {
    ID = "HitTarget",
    CnID = "受击者",
    BaseSortID = 351,
    ApiType = "目标"
  },
  CmdOwner = {
    ID = "CmdOwner",
    CnID = "指令拥有者",
    BaseSortID = 352,
    ApiType = "目标"
  },
  PlayerRole = {
    ID = "PlayerRole",
    CnID = "玩家",
    BaseSortID = 353,
    ApiType = "目标"
  },
  AllEnemy = {
    ID = "AllEnemy",
    CnID = "全体敌方",
    BaseSortID = 354,
    ApiType = "目标"
  },
  BESetTempMainTarget = {
    ID = "BESetTempMainTarget",
    CnID = "设置全体敌方主目标",
    BaseSortID = 355,
    ApiType = "指令"
  },
  AllEnemyWithoutMainTarget = {
    ID = "AllEnemyWithoutMainTarget",
    CnID = "次要全体敌方",
    BaseSortID = 356,
    ApiType = "目标"
  },
  TempMainTarget = {
    ID = "TempMainTarget",
    CnID = "主目标",
    BaseSortID = 357,
    ApiType = "目标"
  },
  MinHpEnemy = {
    ID = "MinHpEnemy",
    CnID = "生命最低敌方",
    BaseSortID = 358,
    ApiType = "目标"
  },
  MaxHpEnemy = {
    ID = "MaxHpEnemy",
    CnID = "生命最高敌方",
    BaseSortID = 359,
    ApiType = "目标"
  },
  RandomEnemy = {
    ID = "RandomEnemy",
    CnID = "随机敌方",
    BaseSortID = 360,
    ApiType = "目标"
  },
  CurCaster = {
    ID = "CurCaster",
    CnID = "当前行动者",
    BaseSortID = 361,
    ApiType = "目标"
  },
  OriginalTargetCmdOwner = {
    ID = "OriginalTargetCmdOwner",
    CnID = "卡牌原始所属角色",
    BaseSortID = 362,
    ApiType = "目标"
  },
  TargetCmdOwner = {
    ID = "TargetCmdOwner",
    CnID = "所属角色",
    BaseSortID = 363,
    ApiType = "目标"
  },
  UpperTarget = {
    ID = "UpperTarget",
    CnID = "传入目标",
    BaseSortID = 364,
    ApiType = "目标"
  },
  FrontEnemy = {
    ID = "FrontEnemy",
    CnID = "前排敌方",
    BaseSortID = 365,
    ApiType = "目标"
  },
  BackEnemy = {
    ID = "BackEnemy",
    CnID = "后排敌方",
    BaseSortID = 366,
    ApiType = "目标"
  },
  TriggerAssociator = {
    ID = "TriggerAssociator",
    CnID = "状态触发关联者1",
    BaseSortID = 367,
    ApiType = "目标"
  },
  TriggerAssociator2 = {
    ID = "TriggerAssociator2",
    CnID = "状态触发关联者2",
    BaseSortID = 368,
    ApiType = "目标"
  },
  TriggerAssociator3 = {
    ID = "TriggerAssociator3",
    CnID = "状态触发关联者3",
    BaseSortID = 369,
    ApiType = "目标"
  },
  TriggerAssociator4 = {
    ID = "TriggerAssociator4",
    CnID = "状态触发关联者4",
    BaseSortID = 370,
    ApiType = "目标"
  },
  AllAlly = {
    ID = "AllAlly",
    CnID = "全体友方",
    BaseSortID = 371,
    ApiType = "目标"
  },
  RandomAlly = {
    ID = "RandomAlly",
    CnID = "随机友方",
    BaseSortID = 372,
    ApiType = "目标"
  },
  FrontAlly = {
    ID = "FrontAlly",
    CnID = "前排友方",
    BaseSortID = 373,
    ApiType = "目标"
  },
  BackAlly = {
    ID = "BackAlly",
    CnID = "后排友方",
    BaseSortID = 374,
    ApiType = "目标"
  },
  OtherAlly = {
    ID = "OtherAlly",
    CnID = "其他友方",
    BaseSortID = 375,
    ApiType = "目标"
  },
  MinHpAlly = {
    ID = "MinHpAlly",
    CnID = "生命最低友方",
    BaseSortID = 376,
    ApiType = "目标"
  },
  MaxHpAlly = {
    ID = "MaxHpAlly",
    CnID = "生命最高友方",
    BaseSortID = 377,
    ApiType = "目标"
  },
  StateCaster = {
    ID = "StateCaster",
    CnID = "状态施加者",
    BaseSortID = 378,
    ApiType = "目标"
  },
  MaxUEAwaker = {
    ID = "MaxUEAwaker",
    CnID = "狂气最高唤醒体",
    BaseSortID = 379,
    ApiType = "目标"
  },
  MinUEAwaker = {
    ID = "MinUEAwaker",
    CnID = "狂气最低唤醒体",
    BaseSortID = 380,
    ApiType = "目标"
  },
  OtherMaxUEAwaker = {
    ID = "OtherMaxUEAwaker",
    CnID = "狂气最高其他唤醒体",
    BaseSortID = 381,
    ApiType = "目标"
  },
  OtherMinUEAwaker = {
    ID = "OtherMinUEAwaker",
    CnID = "狂气最低其他唤醒体",
    BaseSortID = 382,
    ApiType = "目标"
  },
  MineFieldCenter = {
    ID = "MineFieldCenter",
    CnID = "我方场地中央",
    BaseSortID = 383,
    ApiType = "目标"
  },
  EnemyFieldCenter = {
    ID = "EnemyFieldCenter",
    CnID = "敌方场地中央",
    BaseSortID = 384,
    ApiType = "目标"
  },
  CmdTarget = {
    ID = "CmdTarget",
    CnID = "指令目标",
    BaseSortID = 385,
    ApiType = "目标"
  },
  GetMonsterByPos = {
    ID = "GetMonsterByPos",
    CnID = "按站位选定怪物",
    BaseSortID = 386,
    ApiType = "函数"
  },
  GetMonsterByID = {
    ID = "GetMonsterByID",
    CnID = "按中文索引选定怪物",
    BaseSortID = 387,
    ApiType = "函数"
  },
  GetHideMonster = {
    ID = "GetHideMonster",
    CnID = "获取隐匿怪物",
    BaseSortID = 388,
    ApiType = "函数"
  },
  CurCard = {
    ID = "CurCard",
    CnID = "当前行动卡牌",
    BaseSortID = 389,
    ApiType = "目标"
  },
  CurCardTarget = {
    ID = "CurCardTarget",
    CnID = "当前行动卡牌的目标",
    BaseSortID = 390,
    ApiType = "目标"
  },
  OwnerCard = {
    ID = "OwnerCard",
    CnID = "此卡牌",
    BaseSortID = 391,
    ApiType = "目标"
  },
  RANDOM = {
    ID = "RANDOM",
    CnID = "随机",
    BaseSortID = 392,
    ApiType = "标记"
  },
  TOP = {
    ID = "TOP",
    CnID = "顶部",
    BaseSortID = 393,
    ApiType = "标记"
  },
  BOTTOM = {
    ID = "BOTTOM",
    CnID = "底部",
    BaseSortID = 394,
    ApiType = "标记"
  },
  RANDOMNOENCHANT = {
    ID = "RANDOMNOENCHANT",
    CnID = "随机优先未刻印",
    BaseSortID = 395,
    ApiType = "标记"
  },
  RANDOMENCHANT = {
    ID = "RANDOMENCHANT",
    CnID = "随机优先已刻印",
    BaseSortID = 396,
    ApiType = "标记"
  },
  RANDOM_COSTNOT0 = {
    ID = "RANDOM_COSTNOT0",
    CnID = "随机费用不为0或x",
    BaseSortID = 397,
    ApiType = "标记"
  },
  RANDOM_NOT_ENCHANT = {
    ID = "RANDOM_NOT_ENCHANT",
    CnID = "随机排除已刻印",
    BaseSortID = 398,
    ApiType = "标记"
  },
  UseCastDmg = {
    ID = "UseCastDmg",
    CnID = "打出伤害",
    BaseSortID = 399,
    ApiType = "标记"
  },
  UseRealDmg = {
    ID = "UseRealDmg",
    CnID = "实际伤害",
    BaseSortID = 400,
    ApiType = "标记"
  },
  TempDeck1 = {
    ID = "TempDeck1",
    CnID = "通用临时牌堆",
    BaseSortID = 401,
    ApiType = "牌堆"
  },
  TempDeck2 = {
    ID = "TempDeck2",
    CnID = "二四活动牌堆",
    BaseSortID = 402,
    ApiType = "牌堆"
  },
  TempDeck3 = {
    ID = "TempDeck3",
    CnID = "终末共鸣牌堆",
    BaseSortID = 403,
    ApiType = "牌堆"
  },
  TempDeck4 = {
    ID = "TempDeck4",
    CnID = "虫族共鸣牌堆",
    BaseSortID = 404,
    ApiType = "牌堆"
  },
  TempDeck5 = {
    ID = "TempDeck5",
    CnID = "杜勒活动牌堆",
    BaseSortID = 405,
    ApiType = "牌堆"
  },
  TempDeck6 = {
    ID = "TempDeck6",
    CnID = "豪赌的智慧牌堆",
    BaseSortID = 406,
    ApiType = "牌堆"
  },
  TempDeck7 = {
    ID = "TempDeck7",
    CnID = "沙耶牌堆1",
    BaseSortID = 407,
    ApiType = "牌堆"
  },
  TempDeck8 = {
    ID = "TempDeck8",
    CnID = "沙耶牌堆2",
    BaseSortID = 408,
    ApiType = "牌堆"
  },
  TempDeck9 = {
    ID = "TempDeck9",
    CnID = "万化共鸣牌堆",
    BaseSortID = 409,
    ApiType = "牌堆"
  },
  TempDeck10 = {
    ID = "TempDeck10",
    CnID = "备用牌堆10",
    BaseSortID = 410,
    ApiType = "牌堆"
  },
  TempDeck11 = {
    ID = "TempDeck11",
    CnID = "备用牌堆11",
    BaseSortID = 411,
    ApiType = "牌堆"
  },
  TempDeck12 = {
    ID = "TempDeck12",
    CnID = "备用牌堆12",
    BaseSortID = 412,
    ApiType = "牌堆"
  },
  TempDeck13 = {
    ID = "TempDeck13",
    CnID = "备用牌堆13",
    BaseSortID = 413,
    ApiType = "牌堆"
  },
  TempDeck14 = {
    ID = "TempDeck14",
    CnID = "备用牌堆14",
    BaseSortID = 414,
    ApiType = "牌堆"
  },
  TempDeck15 = {
    ID = "TempDeck15",
    CnID = "备用牌堆15",
    BaseSortID = 415,
    ApiType = "牌堆"
  },
  TempDeck16 = {
    ID = "TempDeck16",
    CnID = "备用牌堆16",
    BaseSortID = 416,
    ApiType = "牌堆"
  },
  TempDeck17 = {
    ID = "TempDeck17",
    CnID = "备用牌堆17",
    BaseSortID = 417,
    ApiType = "牌堆"
  },
  TempDeck18 = {
    ID = "TempDeck18",
    CnID = "备用牌堆18",
    BaseSortID = 418,
    ApiType = "牌堆"
  },
  TempDeck19 = {
    ID = "TempDeck19",
    CnID = "PVP等待重置牌堆顶部",
    BaseSortID = 419,
    ApiType = "牌堆"
  },
  TempDeck20 = {
    ID = "TempDeck20",
    CnID = "PVP等待重置牌堆",
    BaseSortID = 420,
    ApiType = "牌堆"
  },
  BrainDeck = {
    ID = "BrainDeck",
    CnID = "脑缸共鸣牌堆",
    BaseSortID = 421,
    ApiType = "牌堆"
  },
  DrawDeckAndGraveyardDeck = {
    ID = "DrawDeckAndGraveyardDeck",
    CnID = "抽牌堆和弃牌堆",
    BaseSortID = 422,
    ApiType = "牌堆"
  },
  HandDeck = {
    ID = "HandDeck",
    CnID = "手牌堆",
    BaseSortID = 423,
    ApiType = "牌堆"
  },
  GraveyardDeck = {
    ID = "GraveyardDeck",
    CnID = "弃牌堆",
    BaseSortID = 424,
    ApiType = "牌堆"
  },
  DrawDeck = {
    ID = "DrawDeck",
    CnID = "抽牌堆",
    BaseSortID = 425,
    ApiType = "牌堆"
  },
  ConsumedDeck = {
    ID = "ConsumedDeck",
    CnID = "消耗堆",
    BaseSortID = 426,
    ApiType = "牌堆"
  },
  DimensionDeck = {
    ID = "DimensionDeck",
    CnID = "超维牌堆",
    BaseSortID = 427,
    ApiType = "牌堆"
  },
  BuildDeck = {
    ID = "BuildDeck",
    CnID = "构筑牌堆",
    BaseSortID = 428,
    ApiType = "牌堆"
  },
  SwallowDeck = {
    ID = "SwallowDeck",
    CnID = "吞噬堆",
    BaseSortID = 429,
    ApiType = "牌堆"
  },
  DrawAndGraveyardDeckList = {
    ID = "DrawAndGraveyardDeckList",
    CnID = "抽牌堆和弃牌堆卡牌列表",
    BaseSortID = 430,
    ApiType = "牌堆"
  },
  HandDeckList = {
    ID = "HandDeckList",
    CnID = "手牌堆卡牌列表",
    BaseSortID = 431,
    ApiType = "牌堆"
  },
  GraveyardDeckList = {
    ID = "GraveyardDeckList",
    CnID = "弃牌堆卡牌列表",
    BaseSortID = 432,
    ApiType = "牌堆"
  },
  DrawDeckList = {
    ID = "DrawDeckList",
    CnID = "抽牌堆卡牌列表",
    BaseSortID = 433,
    ApiType = "牌堆"
  },
  ConsumedDeckList = {
    ID = "ConsumedDeckList",
    CnID = "消耗堆卡牌列表",
    BaseSortID = 434,
    ApiType = "牌堆"
  },
  BuildDeckList = {
    ID = "BuildDeckList",
    CnID = "构筑牌堆卡牌列表",
    BaseSortID = 435,
    ApiType = "牌堆"
  },
  DimensionDeckList = {
    ID = "DimensionDeckList",
    CnID = "超维牌堆卡牌列表",
    BaseSortID = 436,
    ApiType = "牌堆"
  },
  SwallowDeckList = {
    ID = "SwallowDeckList",
    CnID = "吞噬堆卡牌列表",
    BaseSortID = 437,
    ApiType = "牌堆"
  },
  MonsterDimensionDeck = {
    ID = "MonsterDimensionDeck",
    CnID = "怪物超维牌堆",
    BaseSortID = 438,
    ApiType = "牌堆"
  },
  MonsterDimensionDeckList = {
    ID = "MonsterDimensionDeckList",
    CnID = "怪物超维牌堆卡牌列表",
    BaseSortID = 439,
    ApiType = "牌堆"
  },
  Activity24Deck = {
    ID = "Activity24Deck",
    CnID = "关卡活动牌堆",
    BaseSortID = 440,
    ApiType = "牌堆"
  },
  Unity8Deck = {
    ID = "Unity8Deck",
    CnID = "第8章专用牌堆",
    BaseSortID = 441,
    ApiType = "牌堆"
  },
  relic_drop = {
    ID = "relic_drop",
    CnID = "专属造物出现率提高",
    BaseSortID = 442,
    ApiType = "唤醒体属性"
  },
  relic_drop1 = {
    ID = "relic_drop1",
    CnID = "专属造物固定刷新概率",
    BaseSortID = 443,
    ApiType = "唤醒体属性"
  },
  ulti_energy_efficiency = {
    ID = "ulti_energy_efficiency",
    CnID = "狂气充能效率",
    BaseSortID = 444,
    ApiType = "唤醒体属性"
  },
  physique = {
    ID = "physique",
    CnID = "体质",
    BaseSortID = 445,
    ApiType = "唤醒体属性"
  },
  physique_per = {
    ID = "physique_per",
    CnID = "体质百分比加成",
    BaseSortID = 446,
    ApiType = "唤醒体属性"
  },
  block = {
    ID = "block",
    CnID = "护盾",
    BaseSortID = 447,
    ApiType = "角色属性"
  },
  hp = {
    ID = "hp",
    CnID = "当前生命",
    BaseSortID = 448,
    ApiType = "角色属性"
  },
  ulti_energy = {
    ID = "ulti_energy",
    CnID = "当前狂气",
    BaseSortID = 449,
    ApiType = "唤醒体属性"
  },
  ulti_energy_max = {
    ID = "ulti_energy_max",
    CnID = "最大狂气",
    BaseSortID = 450,
    ApiType = "唤醒体属性"
  },
  death_resist = {
    ID = "death_resist",
    CnID = "死亡抵抗",
    BaseSortID = 451,
    ApiType = "角色属性"
  },
  max_hp = {
    ID = "max_hp",
    CnID = "最大生命",
    BaseSortID = 452,
    ApiType = "角色属性"
  },
  atk = {
    ID = "atk",
    CnID = "攻击力",
    BaseSortID = 453,
    ApiType = "唤醒体属性"
  },
  atk_per = {
    ID = "atk_per",
    CnID = "攻击力百分比加成",
    BaseSortID = 454,
    ApiType = "唤醒体属性"
  },
  def = {
    ID = "def",
    CnID = "防御力",
    BaseSortID = 455,
    ApiType = "唤醒体属性"
  },
  def_per = {
    ID = "def_per",
    CnID = "防御力百分比加成",
    BaseSortID = 456,
    ApiType = "唤醒体属性"
  },
  crit = {
    ID = "crit",
    CnID = "暴击率",
    BaseSortID = 457,
    ApiType = "唤醒体属性"
  },
  i_crit = {
    ID = "i_crit",
    CnID = "局内暴击率",
    BaseSortID = 458,
    ApiType = "唤醒体属性"
  },
  crit_damage = {
    ID = "crit_damage",
    CnID = "暴击伤害",
    BaseSortID = 459,
    ApiType = "唤醒体属性"
  },
  block_heal_per = {
    ID = "block_heal_per",
    CnID = "护盾和治疗强效",
    BaseSortID = 460,
    ApiType = "唤醒体属性"
  },
  ulti_energy_init = {
    ID = "ulti_energy_init",
    CnID = "初始狂气",
    BaseSortID = 461,
    ApiType = "唤醒体属性"
  },
  ulti_energy_passive = {
    ID = "ulti_energy_passive",
    CnID = "狂气自动回复",
    BaseSortID = 462,
    ApiType = "唤醒体属性"
  },
  awaked = {
    ID = "awaked",
    CnID = "觉醒状态",
    BaseSortID = 463,
    ApiType = "唤醒体属性"
  },
  ulti_energy_return = {
    ID = "ulti_energy_return",
    CnID = "狂气消耗降低",
    BaseSortID = 464,
    ApiType = "唤醒体属性"
  },
  damage_plus = {
    ID = "damage_plus",
    CnID = "造成伤害固定值修正",
    BaseSortID = 465,
    ApiType = "唤醒体属性",
    Alias = "PVP力量造成伤害增加"
  },
  only_damage_plus = {
    ID = "only_damage_plus",
    CnID = "独立造成伤害固定值修正",
    BaseSortID = 466,
    ApiType = "唤醒体属性"
  },
  damagetimes_plus = {
    ID = "damagetimes_plus",
    CnID = "伤害次数固定值修正",
    BaseSortID = 467,
    ApiType = "唤醒体属性"
  },
  damagetimes_per = {
    ID = "damagetimes_per",
    CnID = "伤害次数百分比修正",
    BaseSortID = 468,
    ApiType = "唤醒体属性"
  },
  heal_plus = {
    ID = "heal_plus",
    CnID = "造成治疗固定值修正",
    BaseSortID = 469,
    ApiType = "唤醒体属性"
  },
  block_plus = {
    ID = "block_plus",
    CnID = "造成护盾固定值修正",
    BaseSortID = 470,
    ApiType = "唤醒体属性",
    Alias = "PVP戒备造成护盾增加"
  },
  ulti_energy_plus = {
    ID = "ulti_energy_plus",
    CnID = "造成狂气固定值修正",
    BaseSortID = 471,
    ApiType = "唤醒体属性"
  },
  ulti_energy_per = {
    ID = "ulti_energy_per",
    CnID = "造成狂气百分比修正",
    BaseSortID = 472,
    ApiType = "唤醒体属性"
  },
  i_ulti_energy_per = {
    ID = "i_ulti_energy_per",
    CnID = "局内造成狂气百分比修正",
    BaseSortID = 473,
    ApiType = "唤醒体属性"
  },
  o_ulti_energy_per = {
    ID = "o_ulti_energy_per",
    CnID = "局外唤醒体指令卡造成狂气百分比修正",
    BaseSortID = 474,
    ApiType = "唤醒体属性"
  },
  i_bloodchange_per = {
    ID = "i_bloodchange_per",
    CnID = "局内造成胚胎融合度百分比修正",
    BaseSortID = 475,
    ApiType = "唤醒体属性"
  },
  o_bloodchange_per = {
    ID = "o_bloodchange_per",
    CnID = "局外造成胚胎融合度百分比修正",
    BaseSortID = 476,
    ApiType = "唤醒体属性"
  },
  instructcard_basic_state_layer_per_blood = {
    ID = "instructcard_basic_state_layer_per_blood",
    CnID = "指令卡造成胚胎融合度基础效果百分比修正",
    BaseSortID = 477,
    ApiType = "唤醒体属性"
  },
  ulti_energy_plus_2 = {
    ID = "ulti_energy_plus_2",
    CnID = "狂气回充",
    BaseSortID = 478,
    ApiType = "唤醒体属性"
  },
  Formula_ulti_energy_plus_2 = {
    ID = "Formula_ulti_energy_plus_2",
    CnID = "狂气回充计算公式",
    BaseSortID = 479,
    ApiType = "公式",
    Data = "math.ceil(CmdCaster.ulti_energy_plus_3*(1-(CmdCaster.ulti_energy_plus_3/0.2)/(CmdCaster.ulti_energy_plus_3/0.2+360)))"
  },
  ulti_energy_plus_3 = {
    ID = "ulti_energy_plus_3",
    CnID = "狂气回充等级",
    BaseSortID = 480,
    ApiType = "唤醒体属性"
  },
  MaxUltiEnergy = {
    ID = "MaxUltiEnergy",
    CnID = "狂气上限",
    BaseSortID = 481,
    ApiType = "功能属性"
  },
  enhance_per = {
    ID = "enhance_per",
    CnID = "强化百分比修正",
    BaseSortID = 482,
    ApiType = "角色属性",
    Alias = "PVP强化伤害提高"
  },
  weak_per = {
    ID = "weak_per",
    CnID = "虚弱百分比修正",
    BaseSortID = 483,
    ApiType = "角色属性",
    Alias = "PVP虚弱伤害降低"
  },
  frail_per = {
    ID = "frail_per",
    CnID = "脆弱百分比修正",
    BaseSortID = 484,
    ApiType = "角色属性"
  },
  dying_per = {
    ID = "dying_per",
    CnID = "重创百分比修正",
    BaseSortID = 485,
    ApiType = "角色属性"
  },
  dying_per2 = {
    ID = "dying_per2",
    CnID = "无底创痕百分比修正",
    BaseSortID = 486,
    ApiType = "角色属性"
  },
  be_tentacle_damage_per = {
    ID = "be_tentacle_damage_per",
    CnID = "承受触腕伤害百分比修正",
    BaseSortID = 487,
    ApiType = "角色属性"
  },
  be_damage_plus = {
    ID = "be_damage_plus",
    CnID = "承受伤害固定值修正",
    BaseSortID = 488,
    ApiType = "角色属性"
  },
  be_damage_per = {
    ID = "be_damage_per",
    CnID = "承受主动和触腕伤害百分比修正",
    BaseSortID = 489,
    ApiType = "角色属性",
    Alias = "PVP加固伤害降低"
  },
  be_damage_per2 = {
    ID = "be_damage_per2",
    CnID = "承受主动和触腕伤害百分比修正2",
    BaseSortID = 490,
    ApiType = "角色属性",
    Alias = "PVP伤害转移主动伤害降低"
  },
  be_damage_per3 = {
    ID = "be_damage_per3",
    CnID = "承受主动和触腕伤害百分比修正3",
    BaseSortID = 491,
    ApiType = "角色属性"
  },
  be_damage_per4 = {
    ID = "be_damage_per4",
    CnID = "承受狂气爆发伤害百分比修正",
    BaseSortID = 492,
    ApiType = "角色属性"
  },
  be_damage_per5 = {
    ID = "be_damage_per5",
    CnID = "承受指令卡伤害百分比修正",
    BaseSortID = 493,
    ApiType = "角色属性"
  },
  be_passive_damage_per = {
    ID = "be_passive_damage_per",
    CnID = "承受纯粹伤害百分比修正",
    BaseSortID = 494,
    ApiType = "角色属性",
    Alias = "PVP伤害转移纯粹伤害降低"
  },
  be_passive_damage_per2 = {
    ID = "be_passive_damage_per2",
    CnID = "承受纯粹伤害百分比修正2",
    BaseSortID = 495,
    ApiType = "角色属性"
  },
  be_passive_damage_per3 = {
    ID = "be_passive_damage_per3",
    CnID = "承受纯粹伤害百分比修正3",
    BaseSortID = 496,
    ApiType = "角色属性"
  },
  be_passive_damage_per4 = {
    ID = "be_passive_damage_per4",
    CnID = "承受纯粹伤害百分比修正4",
    BaseSortID = 497,
    ApiType = "角色属性"
  },
  be_passive_damage_per5 = {
    ID = "be_passive_damage_per5",
    CnID = "承受纯粹伤害百分比修正5",
    BaseSortID = 498,
    ApiType = "角色属性"
  },
  be_fixed_damage_per1 = {
    ID = "be_fixed_damage_per1",
    CnID = "承受固定伤害百分比修正",
    BaseSortID = 499,
    ApiType = "角色属性"
  },
  be_fixed_damage_per2 = {
    ID = "be_fixed_damage_per2",
    CnID = "承受固定伤害百分比修正2",
    BaseSortID = 500,
    ApiType = "角色属性"
  },
  be_fixed_damage_per3 = {
    ID = "be_fixed_damage_per3",
    CnID = "承受固定伤害百分比修正3",
    BaseSortID = 501,
    ApiType = "角色属性"
  },
  be_fixed_damage_per4 = {
    ID = "be_fixed_damage_per4",
    CnID = "承受固定伤害百分比修正4",
    BaseSortID = 502,
    ApiType = "角色属性"
  },
  be_fixed_damage_per5 = {
    ID = "be_fixed_damage_per5",
    CnID = "承受固定伤害百分比修正5",
    BaseSortID = 503,
    ApiType = "角色属性"
  },
  be_heal_plus = {
    ID = "be_heal_plus",
    CnID = "承受治疗固定值修正",
    BaseSortID = 504,
    ApiType = "角色属性"
  },
  be_heal_per = {
    ID = "be_heal_per",
    CnID = "承受治疗百分比修正",
    BaseSortID = 505,
    ApiType = "角色属性",
    Alias = "PVP重创承受治疗降低"
  },
  gain_block_plus = {
    ID = "gain_block_plus",
    CnID = "承受护盾固定值修正",
    BaseSortID = 506,
    ApiType = "角色属性"
  },
  gain_block_per = {
    ID = "gain_block_per",
    CnID = "承受护盾百分比修正",
    BaseSortID = 507,
    ApiType = "角色属性",
    Alias = "PVP重创承受护盾降低"
  },
  gain_ulti_energy_plus = {
    ID = "gain_ulti_energy_plus",
    CnID = "承受狂气固定值修正",
    BaseSortID = 508,
    ApiType = "唤醒体属性"
  },
  gain_ulti_energy_per = {
    ID = "gain_ulti_energy_per",
    CnID = "承受狂气百分比修正",
    BaseSortID = 509,
    ApiType = "唤醒体属性",
    Alias = "PVP空虚承受狂气降低"
  },
  vulnerable_per = {
    ID = "vulnerable_per",
    CnID = "易伤百分比修正",
    BaseSortID = 510,
    ApiType = "角色属性",
    Alias = "PVP易伤承受伤害提高"
  },
  block_reserve = {
    ID = "block_reserve",
    CnID = "护盾保留",
    BaseSortID = 511,
    ApiType = "角色属性"
  },
  seal_ulti = {
    ID = "seal_ulti",
    CnID = "封印",
    BaseSortID = 512,
    ApiType = "唤醒体属性"
  },
  seal_attachpost = {
    ID = "seal_attachpost",
    CnID = "追击封印",
    BaseSortID = 513,
    ApiType = "唤醒体属性"
  },
  immue_seal_ulti = {
    ID = "immue_seal_ulti",
    CnID = "免疫封印",
    BaseSortID = 514,
    ApiType = "唤醒体属性"
  },
  reserve = {
    ID = "reserve",
    CnID = "卡牌保留",
    BaseSortID = 515,
    ApiType = "卡牌属性"
  },
  nothingness = {
    ID = "nothingness",
    CnID = "卡牌虚无",
    BaseSortID = 516,
    ApiType = "卡牌属性"
  },
  card_enchant_tid = {
    ID = "card_enchant_tid",
    CnID = "卡牌刻印中文索引",
    BaseSortID = 517,
    ApiType = "卡牌属性"
  },
  inherent = {
    ID = "inherent",
    CnID = "卡牌固有",
    BaseSortID = 518,
    ApiType = "卡牌属性"
  },
  ErosionColorInk = {
    ID = "ErosionColorInk",
    CnID = "卡牌认知错乱",
    BaseSortID = 519,
    ApiType = "卡牌属性"
  },
  useless = {
    ID = "useless",
    CnID = "卡牌不可使用",
    BaseSortID = 520,
    ApiType = "卡牌属性"
  },
  anti_crit = {
    ID = "anti_crit",
    CnID = "暴击抵抗",
    BaseSortID = 521,
    ApiType = "角色属性"
  },
  card_use_times = {
    ID = "card_use_times",
    CnID = "卡牌可打出次数",
    BaseSortID = 522,
    ApiType = "卡牌属性"
  },
  shiye = {
    ID = "shiye",
    CnID = "视野修正",
    BaseSortID = 523,
    ApiType = "角色属性"
  },
  yingdizhiliao = {
    ID = "yingdizhiliao",
    CnID = "营地治疗百分比修正",
    BaseSortID = 524,
    ApiType = "角色属性"
  },
  xingdongyali = {
    ID = "xingdongyali",
    CnID = "行动压力值固定值修正",
    BaseSortID = 525,
    ApiType = "角色属性"
  },
  immue_damage = {
    ID = "immue_damage",
    CnID = "免疫穿刺以外的所有伤害",
    BaseSortID = 526,
    ApiType = "角色属性"
  },
  consume = {
    ID = "consume",
    CnID = "卡牌消耗",
    BaseSortID = 527,
    ApiType = "卡牌属性"
  },
  immue_debuff = {
    ID = "immue_debuff",
    CnID = "免疫负面状态",
    BaseSortID = 528,
    ApiType = "角色属性"
  },
  immue_buff = {
    ID = "immue_buff",
    CnID = "免疫正面状态",
    BaseSortID = 529,
    ApiType = "角色属性"
  },
  immue_both_buff = {
    ID = "immue_both_buff",
    CnID = "免疫正负面状态",
    BaseSortID = 530,
    ApiType = "角色属性"
  },
  ulti_per_strikecard = {
    ID = "ulti_per_strikecard",
    CnID = "打击卡获取狂气百分比修正",
    BaseSortID = 531,
    ApiType = "唤醒体属性"
  },
  ulti_per_skillcard = {
    ID = "ulti_per_skillcard",
    CnID = "技能卡获取狂气百分比修正",
    BaseSortID = 532,
    ApiType = "唤醒体属性"
  },
  ulti_per_defendcard = {
    ID = "ulti_per_defendcard",
    CnID = "防御卡获取狂气百分比修正",
    BaseSortID = 533,
    ApiType = "唤醒体属性"
  },
  ulti_per_ultiskill = {
    ID = "ulti_per_ultiskill",
    CnID = "狂气爆发获取狂气百分比修正",
    BaseSortID = 534,
    ApiType = "唤醒体属性"
  },
  occupation_master = {
    ID = "occupation_master",
    CnID = "界域精通",
    BaseSortID = 535,
    ApiType = "角色属性"
  },
  occupation_master_final = {
    ID = "occupation_master_final",
    CnID = "界域精通最终值",
    BaseSortID = 536,
    ApiType = "角色属性"
  },
  occupation_master_final_per = {
    ID = "occupation_master_final_per",
    CnID = "界域精通最终百分比修正",
    BaseSortID = 537,
    ApiType = "角色属性"
  },
  do_weak_per = {
    ID = "do_weak_per",
    CnID = "造成虚弱百分比修正",
    BaseSortID = 538,
    ApiType = "角色属性"
  },
  do_vulnerable_per = {
    ID = "do_vulnerable_per",
    CnID = "造成易伤百分比修正",
    BaseSortID = 539,
    ApiType = "角色属性"
  },
  do_frail_per = {
    ID = "do_frail_per",
    CnID = "造成脆弱百分比修正",
    BaseSortID = 540,
    ApiType = "角色属性"
  },
  enchant_upgrade_per = {
    ID = "enchant_upgrade_per",
    CnID = "幸运刻印率",
    BaseSortID = 541,
    ApiType = "角色属性"
  },
  forbit_use_card = {
    ID = "forbit_use_card",
    CnID = "无法打出卡牌",
    BaseSortID = 542,
    ApiType = "角色属性"
  },
  keeper_energy_eff = {
    ID = "keeper_energy_eff",
    CnID = "银钥充能效率",
    BaseSortID = 543,
    ApiType = "角色属性"
  },
  Formula_keeper_energy_eff = {
    ID = "Formula_keeper_energy_eff",
    CnID = "银钥充能效率计算公式",
    BaseSortID = 544,
    ApiType = "公式",
    Data = "math.ceil(15+(CmdCaster.keeper_energy_eff_2-15)*(1-((CmdCaster.keeper_energy_eff_2-15)/0.4)/((CmdCaster.keeper_energy_eff_2-15)/0.4+360)))"
  },
  keeper_energy_eff_2 = {
    ID = "keeper_energy_eff_2",
    CnID = "银钥充能等级",
    BaseSortID = 545,
    ApiType = "角色属性"
  },
  blackcoin_upgrade_per = {
    ID = "blackcoin_upgrade_per",
    CnID = "额外黑印掉落",
    BaseSortID = 546,
    ApiType = "角色属性"
  },
  extra_sale_curse_relic = {
    ID = "extra_sale_curse_relic",
    CnID = "额外一个诅咒造物销售栏",
    BaseSortID = 547,
    ApiType = "角色属性"
  },
  battle_end_giveup_enchant = {
    ID = "battle_end_giveup_enchant",
    CnID = "战斗结束提供放弃刻印选项",
    BaseSortID = 548,
    ApiType = "角色属性"
  },
  battle_end_upgrade_enchant_per = {
    ID = "battle_end_upgrade_enchant_per",
    CnID = "战斗结束刻印升级概率",
    BaseSortID = 549,
    ApiType = "角色属性"
  },
  battle_end_extra_drop_enchant = {
    ID = "battle_end_extra_drop_enchant",
    CnID = "额外一个战斗掉落刻印选项",
    BaseSortID = 550,
    ApiType = "角色属性"
  },
  monster_hide = {
    ID = "monster_hide",
    CnID = "怪物隐匿",
    BaseSortID = 551,
    ApiType = "角色属性"
  },
  BSTBeforeAction = {
    ID = "BSTBeforeAction",
    CnID = "行动前",
    BaseSortID = 552,
    ApiType = "触发器"
  },
  BSTAfterAction = {
    ID = "BSTAfterAction",
    CnID = "行动后",
    BaseSortID = 553,
    ApiType = "触发器"
  },
  BSTBeforeUseCard = {
    ID = "BSTBeforeUseCard",
    CnID = "使用卡牌前",
    BaseSortID = 554,
    ApiType = "触发器"
  },
  BSTAfterUseCard = {
    ID = "BSTAfterUseCard",
    CnID = "使用卡牌后",
    BaseSortID = 555,
    ApiType = "触发器"
  },
  ["BSTBeforeUseCard.Card_Strike"] = {
    ID = "BSTBeforeUseCard.Card_Strike",
    CnID = "使用打击牌前",
    BaseSortID = 556,
    ApiType = "触发器"
  },
  ["BSTAfterUseCard.Card_Strike"] = {
    ID = "BSTAfterUseCard.Card_Strike",
    CnID = "使用打击牌后",
    BaseSortID = 557,
    ApiType = "触发器"
  },
  ["BSTBeforeUseCard.Card_Defend"] = {
    ID = "BSTBeforeUseCard.Card_Defend",
    CnID = "使用防御牌前",
    BaseSortID = 558,
    ApiType = "触发器"
  },
  ["BSTAfterUseCard.Card_Defend"] = {
    ID = "BSTAfterUseCard.Card_Defend",
    CnID = "使用防御牌后",
    BaseSortID = 559,
    ApiType = "触发器"
  },
  ["BSTBeforeUseCard.Card_Skill"] = {
    ID = "BSTBeforeUseCard.Card_Skill",
    CnID = "使用技能牌前",
    BaseSortID = 560,
    ApiType = "触发器"
  },
  ["BSTAfterUseCard.Card_Skill"] = {
    ID = "BSTAfterUseCard.Card_Skill",
    CnID = "使用技能牌后",
    BaseSortID = 561,
    ApiType = "触发器"
  },
  ["BSTBeforeUseCard.Card_Awake"] = {
    ID = "BSTBeforeUseCard.Card_Awake",
    CnID = "使用灵知觉醒牌前",
    BaseSortID = 562,
    ApiType = "触发器"
  },
  ["BSTAfterUseCard.Card_Awake"] = {
    ID = "BSTAfterUseCard.Card_Awake",
    CnID = "使用灵知觉醒牌后",
    BaseSortID = 563,
    ApiType = "触发器"
  },
  BSTAfterSilverKeyAwake = {
    ID = "BSTAfterSilverKeyAwake",
    CnID = "使用银钥觉醒后",
    BaseSortID = 564,
    ApiType = "触发器"
  },
  BSTBeforeUltiSkill = {
    ID = "BSTBeforeUltiSkill",
    CnID = "使用狂气爆发前",
    BaseSortID = 565,
    ApiType = "触发器"
  },
  BSTAfterUltiSkill = {
    ID = "BSTAfterUltiSkill",
    CnID = "使用狂气爆发后",
    BaseSortID = 566,
    ApiType = "触发器"
  },
  BSTRoleBeforeDeathResist = {
    ID = "BSTRoleBeforeDeathResist",
    CnID = "自身死亡抵抗触发前",
    BaseSortID = 567,
    ApiType = "触发器"
  },
  BSTRoleAfterDeathResist = {
    ID = "BSTRoleAfterDeathResist",
    CnID = "自身死亡抵抗触发后",
    BaseSortID = 568,
    ApiType = "触发器"
  },
  BSTRoleBeforeDeath = {
    ID = "BSTRoleBeforeDeath",
    CnID = "自身死亡前",
    BaseSortID = 569,
    ApiType = "触发器"
  },
  BSTRoleAfterDeath = {
    ID = "BSTRoleAfterDeath",
    CnID = "自身死亡后",
    BaseSortID = 570,
    ApiType = "触发器"
  },
  BSTAfterTentacleAttack = {
    ID = "BSTAfterTentacleAttack",
    CnID = "造成触腕伤害后",
    BaseSortID = 571,
    ApiType = "触发器"
  },
  BSTAfterDoActiveDamage = {
    ID = "BSTAfterDoActiveDamage",
    CnID = "造成主动伤害后",
    BaseSortID = 572,
    ApiType = "触发器"
  },
  ["BSTAfterDoActiveDamage.Unblocked"] = {
    ID = "BSTAfterDoActiveDamage.Unblocked",
    CnID = "造成未被完全格挡的主动伤害后",
    BaseSortID = 573,
    ApiType = "触发器"
  },
  BSTAfterAttachPostAction = {
    ID = "BSTAfterAttachPostAction",
    CnID = "释放追击后",
    BaseSortID = 574,
    ApiType = "触发器"
  },
  ["BSTAfterDoActiveDamage.AttachPostAction"] = {
    ID = "BSTAfterDoActiveDamage.AttachPostAction",
    CnID = "造成追击伤害后",
    BaseSortID = 575,
    ApiType = "触发器"
  },
  ["BSTAfterDoActiveDamage.CritDamage"] = {
    ID = "BSTAfterDoActiveDamage.CritDamage",
    CnID = "造成暴击伤害后",
    BaseSortID = 576,
    ApiType = "触发器"
  },
  BSTGainDeathResist = {
    ID = "BSTGainDeathResist",
    CnID = "获得死亡抵抗后",
    BaseSortID = 577,
    ApiType = "触发器"
  },
  BSTAfterDoHeal = {
    ID = "BSTAfterDoHeal",
    CnID = "造成治疗后",
    BaseSortID = 578,
    ApiType = "触发器"
  },
  BSTAfterDoBlock = {
    ID = "BSTAfterDoBlock",
    CnID = "造成护盾后",
    BaseSortID = 579,
    ApiType = "触发器"
  },
  BSTAfterDoUltiEnergy = {
    ID = "BSTAfterDoUltiEnergy",
    CnID = "造成狂气后",
    BaseSortID = 580,
    ApiType = "触发器"
  },
  ["BSTStateOnAdd.ZhongDu"] = {
    ID = "BSTStateOnAdd.ZhongDu",
    CnID = "施加中毒后",
    BaseSortID = 581,
    ApiType = "触发器",
    Data = 3068
  },
  ["BSTStateOnAdd.FangJi"] = {
    ID = "BSTStateOnAdd.FangJi",
    CnID = "施加反击后",
    BaseSortID = 582,
    ApiType = "触发器",
    Data = "3905,3023"
  },
  ["BSTStateOnAdd.FangJiforever"] = {
    ID = "BSTStateOnAdd.FangJiforever",
    CnID = "施加永久反击后",
    BaseSortID = 583,
    ApiType = "触发器",
    Data = 3905
  },
  ["BSTStateOnAdd.YiShang"] = {
    ID = "BSTStateOnAdd.YiShang",
    CnID = "施加易伤后",
    BaseSortID = 584,
    ApiType = "触发器",
    Data = 2934
  },
  ["BSTStateOnAdd.XuRuo"] = {
    ID = "BSTStateOnAdd.XuRuo",
    CnID = "施加虚弱后",
    BaseSortID = 585,
    ApiType = "触发器",
    Data = 3469
  },
  BSTActiveDamageKill = {
    ID = "BSTActiveDamageKill",
    CnID = "主动伤害造成击杀后",
    BaseSortID = 586,
    ApiType = "触发器"
  },
  BSTFixedDamageKill = {
    ID = "BSTFixedDamageKill",
    CnID = "固定伤害造成击杀后",
    BaseSortID = 587,
    ApiType = "触发器"
  },
  BSTAfterAttackedByTentacle = {
    ID = "BSTAfterAttackedByTentacle",
    CnID = "受到触腕伤害后",
    BaseSortID = 588,
    ApiType = "触发器"
  },
  BSTAfterBeActiveDamage = {
    ID = "BSTAfterBeActiveDamage",
    CnID = "受到主动伤害后",
    BaseSortID = 589,
    ApiType = "触发器"
  },
  BSTAfterPassiveDamage = {
    ID = "BSTAfterPassiveDamage",
    CnID = "受到纯粹伤害后",
    BaseSortID = 590,
    ApiType = "触发器"
  },
  BSTAfterFixedDamage = {
    ID = "BSTAfterFixedDamage",
    CnID = "受到固定伤害后",
    BaseSortID = 591,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterFixedDamage"] = {
    ID = "[Enemy]BSTAfterFixedDamage",
    CnID = "敌方阵营受到固定伤害后",
    BaseSortID = 592,
    ApiType = "触发器"
  },
  ["BSTAfterBeActiveDamage.Unblocked"] = {
    ID = "BSTAfterBeActiveDamage.Unblocked",
    CnID = "受到未被完全格挡的主动伤害后",
    BaseSortID = 593,
    ApiType = "触发器"
  },
  ["BSTAfterBeActiveDamage.CritDamage"] = {
    ID = "BSTAfterBeActiveDamage.CritDamage",
    CnID = "受到暴击伤害后",
    BaseSortID = 594,
    ApiType = "触发器"
  },
  ["BattleTrigger236.nil"] = {
    ID = "BattleTrigger236.nil",
    CnID = "受到伤害未被格挡后",
    BaseSortID = 595,
    ApiType = "触发器"
  },
  BSTAfterBeDamage = {
    ID = "BSTAfterBeDamage",
    CnID = "受到伤害后",
    BaseSortID = 596,
    ApiType = "触发器"
  },
  BSTAfterHpDown = {
    ID = "BSTAfterHpDown",
    CnID = "生命降低后",
    BaseSortID = 597,
    ApiType = "触发器"
  },
  BSTAfterBeHeal = {
    ID = "BSTAfterBeHeal",
    CnID = "受到治疗后",
    BaseSortID = 598,
    ApiType = "触发器"
  },
  BSTAfterBeBlock = {
    ID = "BSTAfterBeBlock",
    CnID = "受到护盾后",
    BaseSortID = 599,
    ApiType = "触发器"
  },
  BSTAfterBeUltiEnergy = {
    ID = "BSTAfterBeUltiEnergy",
    CnID = "受到狂气后",
    BaseSortID = 600,
    ApiType = "触发器"
  },
  BSTRoleDrawCard = {
    ID = "BSTRoleDrawCard",
    CnID = "抽一张卡牌后",
    BaseSortID = 601,
    ApiType = "触发器"
  },
  BSTRoleDropCard = {
    ID = "BSTRoleDropCard",
    CnID = "弃一张卡牌后",
    BaseSortID = 602,
    ApiType = "触发器"
  },
  BSTDrawDeckReset = {
    ID = "BSTDrawDeckReset",
    CnID = "抽牌堆重置后",
    BaseSortID = 603,
    ApiType = "触发器"
  },
  BSTAfterTentacleIsFull = {
    ID = "BSTAfterTentacleIsFull",
    CnID = "触腕满溢后",
    BaseSortID = 604,
    ApiType = "触发器"
  },
  BSTAfterGainScarlletBlood = {
    ID = "BSTAfterGainScarlletBlood",
    CnID = "获得胚胎融合度后",
    BaseSortID = 605,
    ApiType = "触发器"
  },
  BSTAfterScarlletBloodFull = {
    ID = "BSTAfterScarlletBloodFull",
    CnID = "达到胚胎融合度上限后",
    BaseSortID = 606,
    ApiType = "触发器"
  },
  BSTCardEnterDimension = {
    ID = "BSTCardEnterDimension",
    CnID = "超维牌堆增加后",
    BaseSortID = 607,
    ApiType = "触发器"
  },
  BSTCardRemoveDimension = {
    ID = "BSTCardRemoveDimension",
    CnID = "超维牌堆减少后",
    BaseSortID = 608,
    ApiType = "触发器"
  },
  BSTStateOnAdd = {
    ID = "BSTStateOnAdd",
    CnID = "当前状态施加后",
    BaseSortID = 609,
    ApiType = "触发器"
  },
  BSTAfterLaunchSwallow = {
    ID = "BSTAfterLaunchSwallow",
    CnID = "吞噬效果发动后",
    BaseSortID = 610,
    ApiType = "触发器"
  },
  BSTAfterLaunchJump = {
    ID = "BSTAfterLaunchJump",
    CnID = "跃迁效果发动后",
    BaseSortID = 611,
    ApiType = "触发器"
  },
  BSTHpChanged = {
    ID = "BSTHpChanged",
    CnID = "生命变化后",
    BaseSortID = 612,
    ApiType = "触发器"
  },
  BSTHpperChanged = {
    ID = "BSTHpperChanged",
    CnID = "生命百分比变化后",
    BaseSortID = 613,
    ApiType = "触发器"
  },
  BSTAfterStateRemoved = {
    ID = "BSTAfterStateRemoved",
    CnID = "当前状态移除后",
    BaseSortID = 614,
    ApiType = "触发器"
  },
  BSTCardChange = {
    ID = "BSTCardChange",
    CnID = "卡牌变化后",
    BaseSortID = 615,
    ApiType = "触发器"
  },
  BSTLeaveHandDeck = {
    ID = "BSTLeaveHandDeck",
    CnID = "从手牌堆消失后",
    BaseSortID = 616,
    ApiType = "触发器"
  },
  BSTEnterHandDeck = {
    ID = "BSTEnterHandDeck",
    CnID = "进入手牌堆后",
    BaseSortID = 617,
    ApiType = "触发器"
  },
  BSTCardOnDraw = {
    ID = "BSTCardOnDraw",
    CnID = "此卡牌被抽到后",
    BaseSortID = 618,
    ApiType = "触发器"
  },
  BSTCardOnUse = {
    ID = "BSTCardOnUse",
    CnID = "此卡牌被打出后",
    BaseSortID = 619,
    ApiType = "触发器"
  },
  BSTCardOnDrop = {
    ID = "BSTCardOnDrop",
    CnID = "此卡牌被弃掉后",
    BaseSortID = 620,
    ApiType = "触发器"
  },
  BSTCardOnConsume = {
    ID = "BSTCardOnConsume",
    CnID = "此卡牌被消耗后",
    BaseSortID = 621,
    ApiType = "触发器"
  },
  BSTCardJoinDeck = {
    ID = "BSTCardJoinDeck",
    CnID = "加入卡组后",
    BaseSortID = 622,
    ApiType = "触发器"
  },
  StageState = {
    ID = "StageState",
    CnID = "关卡开始后",
    BaseSortID = 623,
    ApiType = "触发器"
  },
  LisStageEndAfter = {
    ID = "LisStageEndAfter",
    CnID = "关卡结束前",
    BaseSortID = 624,
    ApiType = "触发器"
  },
  LisBattleStartFront = {
    ID = "LisBattleStartFront",
    CnID = "战斗开始前",
    BaseSortID = 625,
    ApiType = "触发器"
  },
  BSTBattleBegin = {
    ID = "BSTBattleBegin",
    CnID = "战斗开始后",
    BaseSortID = 626,
    ApiType = "触发器"
  },
  BSTBeforeBattleEnd = {
    ID = "BSTBeforeBattleEnd",
    CnID = "战斗结束前",
    BaseSortID = 627,
    ApiType = "触发器"
  },
  LisBattleEndAfter = {
    ID = "LisBattleEndAfter",
    CnID = "战斗结束后",
    BaseSortID = 628,
    ApiType = "触发器"
  },
  BSTBeforeBoutBegin = {
    ID = "BSTBeforeBoutBegin",
    CnID = "回合开始前",
    BaseSortID = 629,
    ApiType = "触发器"
  },
  BSTAfterBoutBegin = {
    ID = "BSTAfterBoutBegin",
    CnID = "回合开始后",
    BaseSortID = 630,
    ApiType = "触发器"
  },
  BSTBeforeBoutEnd = {
    ID = "BSTBeforeBoutEnd",
    CnID = "回合结束前",
    BaseSortID = 631,
    ApiType = "触发器"
  },
  BSTAfterBoutEnd = {
    ID = "BSTAfterBoutEnd",
    CnID = "回合结束后",
    BaseSortID = 632,
    ApiType = "触发器"
  },
  BSTBeforeDimensionBoutBegin = {
    ID = "BSTBeforeDimensionBoutBegin",
    CnID = "超维回合开始前",
    BaseSortID = 633,
    ApiType = "触发器"
  },
  BSTAfterDimensionBoutBegin = {
    ID = "BSTAfterDimensionBoutBegin",
    CnID = "超维回合开始后",
    BaseSortID = 634,
    ApiType = "触发器"
  },
  BSTBeforeDimensionBoutEnd = {
    ID = "BSTBeforeDimensionBoutEnd",
    CnID = "超维回合结束前",
    BaseSortID = 635,
    ApiType = "触发器"
  },
  BSTAfterDimensionBoutEnd = {
    ID = "BSTAfterDimensionBoutEnd",
    CnID = "超维回合结束后",
    BaseSortID = 636,
    ApiType = "触发器"
  },
  BSTBeforeDrawCards = {
    ID = "BSTBeforeDrawCards",
    CnID = "抽牌阶段前",
    BaseSortID = 637,
    ApiType = "触发器"
  },
  BSTAfterDrawCards = {
    ID = "BSTAfterDrawCards",
    CnID = "抽牌阶段后",
    BaseSortID = 638,
    ApiType = "触发器"
  },
  BSTBeforeDiscardCards = {
    ID = "BSTBeforeDiscardCards",
    CnID = "弃牌阶段前",
    BaseSortID = 639,
    ApiType = "触发器"
  },
  BSTAfterDiscardCards = {
    ID = "BSTAfterDiscardCards",
    CnID = "弃牌阶段后",
    BaseSortID = 640,
    ApiType = "触发器"
  },
  BSTAfterStateTrigger = {
    ID = "BSTAfterStateTrigger",
    CnID = "当前状态触发后",
    BaseSortID = 641,
    ApiType = "触发器"
  },
  WSTEnterNewPostionAfter = {
    ID = "WSTEnterNewPostionAfter",
    CnID = "进入新格子后",
    BaseSortID = 642,
    ApiType = "触发器"
  },
  WSTBuyCurseRelicAfter = {
    ID = "WSTBuyCurseRelicAfter",
    CnID = "购买诅咒造物后",
    BaseSortID = 643,
    ApiType = "触发器"
  },
  WSTMapFullView = {
    ID = "WSTMapFullView",
    CnID = "地图视野全开后",
    BaseSortID = 644,
    ApiType = "触发器"
  },
  BSTAfterUseKeeperSkill = {
    ID = "BSTAfterUseKeeperSkill",
    CnID = "释放钥令后",
    BaseSortID = 645,
    ApiType = "触发器"
  },
  AfterEnterStage = {
    ID = "AfterEnterStage",
    CnID = "关卡完全加载完毕后",
    BaseSortID = 646,
    ApiType = "触发器"
  },
  BSTAfterMoneyChange = {
    ID = "BSTAfterMoneyChange",
    CnID = "黑印变化后",
    BaseSortID = 647,
    ApiType = "触发器"
  },
  RefreshShopBefore = {
    ID = "RefreshShopBefore",
    CnID = "融痕刷新前",
    BaseSortID = 648,
    ApiType = "触发器"
  },
  RefreshShopAfter = {
    ID = "RefreshShopAfter",
    CnID = "融痕刷新后",
    BaseSortID = 649,
    ApiType = "触发器"
  },
  BuyEnchantAfter = {
    ID = "BuyEnchantAfter",
    CnID = "购买刻印后",
    BaseSortID = 650,
    ApiType = "触发器"
  },
  ShopDiscountGoods = {
    ID = "ShopDiscountGoods",
    CnID = "购买折扣商品后",
    BaseSortID = 651,
    ApiType = "触发器"
  },
  GetAwakerPotencyPower = {
    ID = "GetAwakerPotencyPower",
    CnID = "获取唤醒体启灵强度",
    BaseSortID = 652,
    ApiType = "函数"
  },
  AwakerLevel = {
    ID = "AwakerLevel",
    CnID = "获取唤醒体等级",
    BaseSortID = 653,
    ApiType = "函数"
  },
  TeamLevel = {
    ID = "TeamLevel",
    CnID = "队伍等级",
    BaseSortID = 654,
    ApiType = "参数"
  },
  StateOwner = {
    ID = "StateOwner",
    CnID = "状态拥有者",
    BaseSortID = 655,
    ApiType = "目标"
  },
  CurDeck = {
    ID = "CurDeck",
    CnID = "当前牌堆",
    BaseSortID = 656,
    ApiType = "牌堆"
  },
  StageStar = {
    ID = "StageStar",
    CnID = "关卡星数",
    BaseSortID = 657,
    ApiType = "参数"
  },
  BattleStats = {
    ID = "BattleStats",
    CnID = "当前战斗统计",
    BaseSortID = 658,
    ApiType = "战斗统计"
  },
  CurBoutStats = {
    ID = "CurBoutStats",
    CnID = "当前回合统计",
    BaseSortID = 659,
    ApiType = "战斗统计"
  },
  LastBoutStats = {
    ID = "LastBoutStats",
    CnID = "上个回合统计",
    BaseSortID = 660,
    ApiType = "战斗统计"
  },
  LastActionStats = {
    ID = "LastActionStats",
    CnID = "上个行动统计",
    BaseSortID = 661,
    ApiType = "战斗统计"
  },
  CurActionStats = {
    ID = "CurActionStats",
    CnID = "当前行动统计",
    BaseSortID = 662,
    ApiType = "战斗统计"
  },
  LastCmdStats = {
    ID = "LastCmdStats",
    CnID = "上个指令统计",
    BaseSortID = 663,
    ApiType = "战斗统计"
  },
  CurCmdStats = {
    ID = "CurCmdStats",
    CnID = "本指令统计",
    BaseSortID = 664,
    ApiType = "战斗统计"
  },
  GlobalStats = {
    ID = "GlobalStats",
    CnID = "全局统计",
    BaseSortID = 665,
    ApiType = "战斗统计"
  },
  tentacle_base_dmg = {
    ID = "tentacle_base_dmg",
    CnID = "基础触腕伤害",
    BaseSortID = 666,
    ApiType = "角色属性"
  },
  tentacle_dmg = {
    ID = "tentacle_dmg",
    CnID = "触腕伤害",
    BaseSortID = 667,
    ApiType = "角色属性"
  },
  tentacle_dmg_show = {
    ID = "tentacle_dmg_show",
    CnID = "实际触腕伤害",
    BaseSortID = 668,
    ApiType = "角色属性"
  },
  CardTypeMatch = {
    ID = "CardTypeMatch",
    CnID = "类型判断",
    BaseSortID = 669,
    ApiType = "函数"
  },
  GetStateLayer = {
    ID = "GetStateLayer",
    CnID = "状态层数",
    BaseSortID = 670,
    ApiType = "函数"
  },
  GetStateParam = {
    ID = "GetStateParam",
    CnID = "获取状态参数",
    BaseSortID = 671,
    ApiType = "函数"
  },
  CardCount = {
    ID = "CardCount",
    CnID = "卡牌数量",
    BaseSortID = 672,
    ApiType = "统计属性"
  },
  GetCardByEnchant = {
    ID = "GetCardByEnchant",
    CnID = "按刻印筛选卡牌",
    BaseSortID = 673,
    ApiType = "函数"
  },
  GetCardCountByID = {
    ID = "GetCardCountByID",
    CnID = "按中文索引获取卡牌数量",
    BaseSortID = 674,
    ApiType = "函数"
  },
  GetAwakerByID = {
    ID = "GetAwakerByID",
    CnID = "按中文索引获取唤醒体",
    BaseSortID = 675,
    ApiType = "函数"
  },
  GetAwakerByPos = {
    ID = "GetAwakerByPos",
    CnID = "按站位获取唤醒体",
    BaseSortID = 676,
    ApiType = "函数"
  },
  IsHaveAwaker = {
    ID = "IsHaveAwaker",
    CnID = "判定出战唤醒体",
    BaseSortID = 677,
    ApiType = "函数"
  },
  GetCardCountByType = {
    ID = "GetCardCountByType",
    CnID = "按类型获取卡牌数量",
    BaseSortID = 678,
    ApiType = "函数"
  },
  GetRelicCountByID = {
    ID = "GetRelicCountByID",
    CnID = "按中文索引判断是否拥有造物",
    BaseSortID = 679,
    ApiType = "函数"
  },
  GetCardListMultiExp = {
    ID = "GetCardListMultiExp",
    CnID = "自定义获取卡牌列表",
    BaseSortID = 680,
    ApiType = "函数"
  },
  GetSilverKey = {
    ID = "GetSilverKey",
    CnID = "持有钥令数",
    BaseSortID = 681,
    ApiType = "函数"
  },
  PlayerDoRealDamage = {
    ID = "PlayerDoRealDamage",
    CnID = "玩家造成实际伤害",
    BaseSortID = 682,
    ApiType = "统计属性"
  },
  PlayerDoBlockDamage = {
    ID = "PlayerDoBlockDamage",
    CnID = "玩家造成护盾伤害",
    BaseSortID = 683,
    ApiType = "统计属性"
  },
  PlayerGotRealDamage = {
    ID = "PlayerGotRealDamage",
    CnID = "玩家承受实际伤害",
    BaseSortID = 684,
    ApiType = "统计属性"
  },
  PlayerGotBlockDamage = {
    ID = "PlayerGotBlockDamage",
    CnID = "玩家承受护盾伤害",
    BaseSortID = 685,
    ApiType = "统计属性"
  },
  PlayerDoHeal = {
    ID = "PlayerDoHeal",
    CnID = "玩家造成治疗",
    BaseSortID = 686,
    ApiType = "统计属性"
  },
  PlayerDoBlock = {
    ID = "PlayerDoBlock",
    CnID = "玩家造成护盾",
    BaseSortID = 687,
    ApiType = "统计属性"
  },
  DeathResistCount = {
    ID = "DeathResistCount",
    CnID = "死亡抵抗触发次数",
    BaseSortID = 688,
    ApiType = "统计属性"
  },
  SwallowedCardCount = {
    ID = "SwallowedCardCount",
    CnID = "吞噬次数",
    BaseSortID = 689,
    ApiType = "统计属性"
  },
  KillCount = {
    ID = "KillCount",
    CnID = "击杀次数",
    BaseSortID = 690,
    ApiType = "统计属性"
  },
  BoutCount = {
    ID = "BoutCount",
    CnID = "回合数",
    BaseSortID = 691,
    ApiType = "统计属性"
  },
  PlayerActionCount = {
    ID = "PlayerActionCount",
    CnID = "行动次数",
    BaseSortID = 692,
    ApiType = "统计属性"
  },
  UsedCardCount = {
    ID = "UsedCardCount",
    CnID = "卡牌使用次数",
    BaseSortID = 693,
    ApiType = "统计属性"
  },
  StrikeCardUsedCount = {
    ID = "StrikeCardUsedCount",
    CnID = "打击卡使用次数",
    BaseSortID = 694,
    ApiType = "统计属性"
  },
  DefenceCardUsedCount = {
    ID = "DefenceCardUsedCount",
    CnID = "防御卡使用次数",
    BaseSortID = 695,
    ApiType = "统计属性"
  },
  SkillCardUsedCount = {
    ID = "SkillCardUsedCount",
    CnID = "技能卡使用次数",
    BaseSortID = 696,
    ApiType = "统计属性"
  },
  AwakeCardUsedCount = {
    ID = "AwakeCardUsedCount",
    CnID = "灵知觉醒使用次数",
    BaseSortID = 697,
    ApiType = "统计属性"
  },
  OtherCardUsedCount = {
    ID = "OtherCardUsedCount",
    CnID = "其他卡牌使用次数",
    BaseSortID = 698,
    ApiType = "统计属性"
  },
  GetUsedCountOfCardByConfigId = {
    ID = "GetUsedCountOfCardByConfigId",
    CnID = "按中文索引获取卡牌使用次数",
    BaseSortID = 699,
    ApiType = "函数"
  },
  GetCardByAwaker = {
    ID = "GetCardByAwaker",
    CnID = "按唤醒体获取卡牌",
    BaseSortID = 700,
    ApiType = "函数"
  },
  GetCardByAwakerExp = {
    ID = "GetCardByAwakerExp",
    CnID = "按唤醒体目标获取卡牌",
    BaseSortID = 701,
    ApiType = "函数"
  },
  GetCardCount = {
    ID = "GetCardCount",
    CnID = "获取卡牌数量",
    BaseSortID = 702,
    ApiType = "函数"
  },
  DiscardedCardCount = {
    ID = "DiscardedCardCount",
    CnID = "弃牌张数",
    BaseSortID = 703,
    ApiType = "统计属性"
  },
  DrawCardCount = {
    ID = "DrawCardCount",
    CnID = "抽牌张数",
    BaseSortID = 704,
    ApiType = "统计属性"
  },
  UltiSkillCount = {
    ID = "UltiSkillCount",
    CnID = "狂气爆发使用次数",
    BaseSortID = 705,
    ApiType = "统计属性"
  },
  EndBoutDiscardCount = {
    ID = "EndBoutDiscardCount",
    CnID = "回合结束时弃牌数",
    BaseSortID = 706,
    ApiType = "统计属性"
  },
  DimensionBoutCount = {
    ID = "DimensionBoutCount",
    CnID = "超维回合数",
    BaseSortID = 707,
    ApiType = "统计属性"
  },
  DrawDeckResetCount = {
    ID = "DrawDeckResetCount",
    CnID = "牌库重置次数",
    BaseSortID = 708,
    ApiType = "统计属性"
  },
  PlayerDeathCount = {
    ID = "PlayerDeathCount",
    CnID = "玩家死亡次数",
    BaseSortID = 709,
    ApiType = "统计属性"
  },
  EvaluateCount = {
    ID = "EvaluateCount",
    CnID = "当前评价数",
    BaseSortID = 710,
    ApiType = "参数"
  },
  StageNodeCount = {
    ID = "StageNodeCount",
    CnID = "当前关卡节点数",
    BaseSortID = 711,
    ApiType = "参数"
  },
  CurBoutNum = {
    ID = "CurBoutNum",
    CnID = "当前回合数",
    BaseSortID = 712,
    ApiType = "参数"
  },
  tentacle_dmg_per = {
    ID = "tentacle_dmg_per",
    CnID = "触腕伤害百分比修正",
    BaseSortID = 713,
    ApiType = "角色属性"
  },
  bout_tentacle_dmg = {
    ID = "bout_tentacle_dmg",
    CnID = "临时触腕伤害",
    BaseSortID = 714,
    ApiType = "角色属性"
  },
  battle_tentacle_dmg = {
    ID = "battle_tentacle_dmg",
    CnID = "战斗触腕伤害",
    BaseSortID = 715,
    ApiType = "角色属性"
  },
  max_tentacle_count = {
    ID = "max_tentacle_count",
    CnID = "触腕上限",
    BaseSortID = 716,
    ApiType = "角色属性"
  },
  bout_max_tentacle_count = {
    ID = "bout_max_tentacle_count",
    CnID = "临时触腕上限",
    BaseSortID = 717,
    ApiType = "角色属性"
  },
  battle_max_tentacle_count = {
    ID = "battle_max_tentacle_count",
    CnID = "战斗触腕上限",
    BaseSortID = 718,
    ApiType = "角色属性"
  },
  tentacle_count = {
    ID = "tentacle_count",
    CnID = "触腕数量",
    BaseSortID = 719,
    ApiType = "角色属性"
  },
  bout_tentacle_count = {
    ID = "bout_tentacle_count",
    CnID = "临时触腕数量",
    BaseSortID = 720,
    ApiType = "角色属性"
  },
  battle_tentacle_count = {
    ID = "battle_tentacle_count",
    CnID = "战斗触腕数量",
    BaseSortID = 721,
    ApiType = "角色属性"
  },
  permanent_tentacle_count = {
    ID = "permanent_tentacle_count",
    CnID = "永久触腕数量",
    BaseSortID = 722,
    ApiType = "角色属性"
  },
  scarlet_blood_count = {
    ID = "scarlet_blood_count",
    CnID = "胚胎融合度数量",
    BaseSortID = 723,
    ApiType = "角色属性"
  },
  max_scarlet_blood_count = {
    ID = "max_scarlet_blood_count",
    CnID = "胚胎融合度上限",
    BaseSortID = 724,
    ApiType = "角色属性"
  },
  MonsterNum = {
    ID = "MonsterNum",
    CnID = "怪物数量",
    BaseSortID = 725,
    ApiType = "参数"
  },
  GetMonsterCountByID = {
    ID = "GetMonsterCountByID",
    CnID = "按中文索引获取怪物数量",
    BaseSortID = 726,
    ApiType = "函数"
  },
  GetAwakerCountBySchool = {
    ID = "GetAwakerCountBySchool",
    CnID = "按职业获取唤醒体数量",
    BaseSortID = 727,
    ApiType = "函数"
  },
  IsDimensionBout = {
    ID = "IsDimensionBout",
    CnID = "是否为超维回合",
    BaseSortID = 728,
    ApiType = "参数"
  },
  LastConditionRet = {
    ID = "LastConditionRet",
    CnID = "指令上次判断结果",
    BaseSortID = 729,
    ApiType = "参数"
  },
  StageChapter = {
    ID = "StageChapter",
    CnID = "当前关卡篇章",
    BaseSortID = 730,
    ApiType = "参数"
  },
  PlayerDoDamage = {
    ID = "PlayerDoDamage",
    CnID = "玩家打出伤害",
    BaseSortID = 731,
    ApiType = "统计属性"
  },
  MonsterAttackTimes = {
    ID = "MonsterAttackTimes",
    CnID = "本回合攻击次数",
    BaseSortID = 732,
    ApiType = "功能属性"
  },
  dimension_slot = {
    ID = "dimension_slot",
    CnID = "超维卡槽数量",
    BaseSortID = 733,
    ApiType = "参数"
  },
  monster_dimension_slot = {
    ID = "monster_dimension_slot",
    CnID = "怪物超维卡槽数量",
    BaseSortID = 734,
    ApiType = "角色属性"
  },
  TeamAtk = {
    ID = "TeamAtk",
    CnID = "队伍攻击力",
    BaseSortID = 735,
    ApiType = "参数"
  },
  Random = {
    ID = "Random",
    CnID = "随机数",
    BaseSortID = 736,
    ApiType = "函数"
  },
  tentacle_crit = {
    ID = "tentacle_crit",
    CnID = "触腕暴击率",
    BaseSortID = 737,
    ApiType = "角色属性"
  },
  tentacle_crit_dmg = {
    ID = "tentacle_crit_dmg",
    CnID = "触腕暴击伤害",
    BaseSortID = 738,
    ApiType = "角色属性"
  },
  IsHaveMonster = {
    ID = "IsHaveMonster",
    CnID = "是否存在怪物",
    BaseSortID = 739,
    ApiType = "函数"
  },
  CastSkillLevel = {
    ID = "CastSkillLevel",
    CnID = "施法技能等级",
    BaseSortID = 740,
    ApiType = "参数"
  },
  SlotCardLevel = {
    ID = "SlotCardLevel",
    CnID = "原始技能等级",
    BaseSortID = 741,
    ApiType = "参数"
  },
  GetCardByID = {
    ID = "GetCardByID",
    CnID = "按中文索引获取卡牌",
    BaseSortID = 742,
    ApiType = "函数"
  },
  GetCardByType = {
    ID = "GetCardByType",
    CnID = "按类型获取卡牌",
    BaseSortID = 743,
    ApiType = "函数"
  },
  GetCardBySlot = {
    ID = "GetCardBySlot",
    CnID = "按槽位获取卡牌",
    BaseSortID = 744,
    ApiType = "函数"
  },
  GetCardByAwakerListAndSlot = {
    ID = "GetCardByAwakerListAndSlot",
    CnID = "按唤醒体列表和槽位获取卡牌",
    BaseSortID = 745,
    ApiType = "函数"
  },
  AllEnemy2 = {
    ID = "AllEnemy2",
    CnID = "所有敌方",
    BaseSortID = 746,
    ApiType = "目标"
  },
  TriggerValue = {
    ID = "TriggerValue",
    CnID = "触发值",
    BaseSortID = 747,
    ApiType = "参数"
  },
  ConsumedScaletBloodCount = {
    ID = "ConsumedScaletBloodCount",
    CnID = "吞噬胚胎融合度个数",
    BaseSortID = 748,
    ApiType = "统计属性"
  },
  School = {
    ID = "School",
    CnID = "职业",
    BaseSortID = 749,
    ApiType = "功能属性"
  },
  Layer = {
    ID = "Layer",
    CnID = "层数",
    BaseSortID = 750,
    ApiType = "参数"
  },
  ChangedLayer = {
    ID = "ChangedLayer",
    CnID = "变化层数",
    BaseSortID = 751,
    ApiType = "参数"
  },
  All = {
    ID = "All",
    CnID = "所有",
    BaseSortID = 752,
    ApiType = "参数"
  },
  Normal = {
    ID = "Normal",
    CnID = "正常",
    BaseSortID = 753,
    ApiType = "状态显示方式"
  },
  Hide = {
    ID = "Hide",
    CnID = "隐藏",
    BaseSortID = 754,
    ApiType = "状态显示方式"
  },
  AwakerAffix = {
    ID = "AwakerAffix",
    CnID = "仅个人词缀",
    BaseSortID = 755,
    ApiType = "状态显示方式"
  },
  Affix = {
    ID = "Affix",
    CnID = "仅词缀说明",
    BaseSortID = 756,
    ApiType = "状态显示方式"
  },
  Describe = {
    ID = "Describe",
    CnID = "仅追加描述",
    BaseSortID = 757,
    ApiType = "状态显示方式"
  },
  WeaponIconAndDesc = {
    ID = "WeaponIconAndDesc",
    CnID = "命轮图标与说明",
    BaseSortID = 758,
    ApiType = "状态显示方式"
  },
  HideFloatText = {
    ID = "HideFloatText",
    CnID = "正常但不显示瓢字",
    BaseSortID = 759,
    ApiType = "状态显示方式"
  },
  BattleType = {
    ID = "BattleType",
    CnID = "当前战斗类型",
    BaseSortID = 760,
    ApiType = "参数"
  },
  AwakerType = {
    ID = "AwakerType",
    CnID = "定位",
    BaseSortID = 761,
    ApiType = "功能属性"
  },
  IntentionType = {
    ID = "IntentionType",
    CnID = "当前意图类型",
    BaseSortID = 762,
    ApiType = "功能属性"
  },
  CycleListIndex = {
    ID = "CycleListIndex",
    CnID = "循环指令列表",
    BaseSortID = 763,
    ApiType = "功能属性"
  },
  Type = {
    ID = "Type",
    CnID = "类型",
    BaseSortID = 764,
    ApiType = "功能属性"
  },
  Intention = {
    ID = "Intention",
    CnID = "当前意图",
    BaseSortID = 765,
    ApiType = "功能属性"
  },
  money = {
    ID = "money",
    CnID = "贤石",
    BaseSortID = 766,
    ApiType = "参数"
  },
  RestorePerHeal = {
    ID = "RestorePerHeal",
    CnID = "回复最大生命百分比",
    BaseSortID = 767,
    ApiType = "指令"
  },
  GetAllAwakenCardList = {
    ID = "GetAllAwakenCardList",
    CnID = "选择灵知觉醒卡",
    BaseSortID = 768,
    ApiType = "目标"
  },
  IsInDeck = {
    ID = "IsInDeck",
    CnID = "位置判断",
    BaseSortID = 769,
    ApiType = "函数"
  },
  ShopRelicPricePer = {
    ID = "ShopRelicPricePer",
    CnID = "造物售价百分比修正",
    BaseSortID = 770,
    ApiType = "关卡属性"
  },
  ShopRelicPrice = {
    ID = "ShopRelicPrice",
    CnID = "造物售价固定值修正",
    BaseSortID = 771,
    ApiType = "关卡属性"
  },
  ShopRunePricePer = {
    ID = "ShopRunePricePer",
    CnID = "刻印售价百分比修正",
    BaseSortID = 772,
    ApiType = "关卡属性"
  },
  ShopRunePrice = {
    ID = "ShopRunePrice",
    CnID = "刻印售价固定值修正",
    BaseSortID = 773,
    ApiType = "关卡属性"
  },
  ShopUnlockCardPricePer = {
    ID = "ShopUnlockCardPricePer",
    CnID = "解锁灵知觉醒售价百分比修正",
    BaseSortID = 774,
    ApiType = "关卡属性"
  },
  ShopUnlockCardPrice = {
    ID = "ShopUnlockCardPrice",
    CnID = "解锁灵知觉醒售价固定值修正",
    BaseSortID = 775,
    ApiType = "关卡属性"
  },
  ShopSellCardPricePer = {
    ID = "ShopSellCardPricePer",
    CnID = "卡牌售价百分比修正",
    BaseSortID = 776,
    ApiType = "关卡属性"
  },
  ShopSellCardPrice = {
    ID = "ShopSellCardPrice",
    CnID = "卡牌售价固定值修正",
    BaseSortID = 777,
    ApiType = "关卡属性"
  },
  ShopTalentMaterialPricePer = {
    ID = "ShopTalentMaterialPricePer",
    CnID = "共鸣材料售价百分比修正",
    BaseSortID = 778,
    ApiType = "关卡属性"
  },
  ShopTalentMaterialPrice = {
    ID = "ShopTalentMaterialPrice",
    CnID = "共鸣材料售价固定值修正",
    BaseSortID = 779,
    ApiType = "关卡属性"
  },
  View = {
    ID = "View",
    CnID = "视野固定值修正",
    BaseSortID = 780,
    ApiType = "关卡属性"
  },
  MoveStress = {
    ID = "MoveStress",
    CnID = "移动压力固定值修正",
    BaseSortID = 781,
    ApiType = "关卡属性"
  },
  CampTreatEffectPer = {
    ID = "CampTreatEffectPer",
    CnID = "营地治疗效果百分比修正",
    BaseSortID = 782,
    ApiType = "关卡属性"
  },
  CampTreatEffect = {
    ID = "CampTreatEffect",
    CnID = "营地治疗效果固定值修正",
    BaseSortID = 783,
    ApiType = "关卡属性"
  },
  ShopRefreshNum = {
    ID = "ShopRefreshNum",
    CnID = "商店刷新机会次数修正",
    BaseSortID = 784,
    ApiType = "关卡属性"
  },
  CmdChangeView = {
    ID = "CmdChangeView",
    CnID = "改变视野",
    BaseSortID = 785,
    ApiType = "指令"
  },
  CmdUpgradeEnchant = {
    ID = "CmdUpgradeEnchant",
    CnID = "升级刻印",
    BaseSortID = 786,
    ApiType = "指令"
  },
  CmdRandomEnchant = {
    ID = "CmdRandomEnchant",
    CnID = "随机刻印",
    BaseSortID = 787,
    ApiType = "指令"
  },
  CmdConfirmRandomEnchant = {
    ID = "CmdConfirmRandomEnchant",
    CnID = "确认刻印",
    BaseSortID = 788,
    ApiType = "指令"
  },
  BEConfirmEnchant = {
    ID = "BEConfirmEnchant",
    CnID = "确认随机刻印",
    BaseSortID = 789,
    ApiType = "指令"
  },
  BEChangeStress = {
    ID = "BEChangeStress",
    CnID = "改变压力",
    BaseSortID = 790,
    ApiType = "指令"
  },
  CmdChangeTalentMaterial = {
    ID = "CmdChangeTalentMaterial",
    CnID = "改变共鸣材料",
    BaseSortID = 791,
    ApiType = "指令"
  },
  CmdChangeShopPrice = {
    ID = "CmdChangeShopPrice",
    CnID = "改变商店售价",
    BaseSortID = 792,
    ApiType = "指令"
  },
  CmdUPgradeSkillLevel = {
    ID = "CmdUPgradeSkillLevel",
    CnID = "按类型提升唤醒体技能等级",
    BaseSortID = 793,
    ApiType = "指令"
  },
  CmdShowView = {
    ID = "CmdShowView",
    CnID = "点亮当前视野",
    BaseSortID = 794,
    ApiType = "指令"
  },
  CreateMapNode = {
    ID = "CreateMapNode",
    CnID = "生成地图节点",
    BaseSortID = 795,
    ApiType = "指令"
  },
  BECreateRandomCard = {
    ID = "BECreateRandomCard",
    CnID = "创造随机卡牌",
    BaseSortID = 796,
    ApiType = "指令"
  },
  ChangeRandomResult = {
    ID = "ChangeRandomResult",
    CnID = "改变随机结果",
    BaseSortID = 797,
    ApiType = "指令"
  },
  FuncGetRelicList = {
    ID = "FuncGetRelicList",
    CnID = "获得造物列表",
    BaseSortID = 798,
    ApiType = "函数"
  },
  FuncChooseRelic = {
    ID = "FuncChooseRelic",
    CnID = "选择造物",
    BaseSortID = 799,
    ApiType = "函数"
  },
  FuncRandomRelic = {
    ID = "FuncRandomRelic",
    CnID = "随机造物",
    BaseSortID = 800,
    ApiType = "函数"
  },
  FuncGetRelicListFromDrop = {
    ID = "FuncGetRelicListFromDrop",
    CnID = "按掉落包获取造物列表",
    BaseSortID = 801,
    ApiType = "函数"
  },
  GetDrop = {
    ID = "GetDrop",
    CnID = "获取掉落",
    BaseSortID = 802,
    ApiType = "函数"
  },
  GetAccountPower = {
    ID = "GetAccountPower",
    CnID = "获取玩家等级强度",
    BaseSortID = 803,
    ApiType = "函数"
  },
  GetAccountSkillMultiplier = {
    ID = "GetAccountSkillMultiplier",
    CnID = "获取玩家技能倍率",
    BaseSortID = 804,
    ApiType = "函数"
  },
  GetAwakerLevelArgByStageLevel = {
    ID = "GetAwakerLevelArgByStageLevel",
    CnID = "根据关卡等级读唤醒体升级表配置",
    BaseSortID = 805,
    ApiType = "函数"
  },
  GetAwakerLevelArgByAwakerAvgLevel = {
    ID = "GetAwakerLevelArgByAwakerAvgLevel",
    CnID = "根据唤醒体平均等级读唤醒体升级表配置",
    BaseSortID = 806,
    ApiType = "函数"
  },
  GetAccountLevelArgByAccoutLevel = {
    ID = "GetAccountLevelArgByAccoutLevel",
    CnID = "根据玩家等级读玩家等级表配置",
    BaseSortID = 807,
    ApiType = "函数"
  },
  OceanDamageMultiplier = {
    ID = "OceanDamageMultiplier",
    CnID = "触腕伤害倍率",
    BaseSortID = 808,
    ApiType = "标记"
  },
  GetAccountDamagePower = {
    ID = "GetAccountDamagePower",
    CnID = "获取玩家输出补偿",
    BaseSortID = 809,
    ApiType = "函数"
  },
  GetAccountMethysisPower = {
    ID = "GetAccountMethysisPower",
    CnID = "获取玩家暴击补偿",
    BaseSortID = 810,
    ApiType = "函数"
  },
  GetRefiningLevel = {
    ID = "GetRefiningLevel",
    CnID = "获取精炼等级",
    BaseSortID = 811,
    ApiType = "函数"
  },
  GetAwakenCard = {
    ID = "GetAwakenCard",
    CnID = "选择灵知觉醒",
    BaseSortID = 812,
    ApiType = "函数"
  },
  ChooseCardEnchantList = {
    ID = "ChooseCardEnchantList",
    CnID = "选择卡牌刻印列表",
    BaseSortID = 813,
    ApiType = "函数"
  },
  ChooseCardDesignateEnchantList = {
    ID = "ChooseCardDesignateEnchantList",
    CnID = "选择卡牌指定刻印列表",
    BaseSortID = 814,
    ApiType = "函数"
  },
  GetAllCard = {
    ID = "GetAllCard",
    CnID = "获取所有卡牌",
    BaseSortID = 815,
    ApiType = "函数"
  },
  RandomAwakenCard = {
    ID = "RandomAwakenCard",
    CnID = "随机灵知觉醒",
    BaseSortID = 816,
    ApiType = "函数"
  },
  GetParamBySkillType = {
    ID = "GetParamBySkillType",
    CnID = "获取技能类型列表",
    BaseSortID = 817,
    ApiType = "函数"
  },
  GetShopItemTypeList = {
    ID = "GetShopItemTypeList",
    CnID = "获取商品种类列表",
    BaseSortID = 818,
    ApiType = "函数"
  },
  GetEnchantCardList = {
    ID = "GetEnchantCardList",
    CnID = "获取已刻印的卡牌",
    BaseSortID = 819,
    ApiType = "函数"
  },
  UnlockAwakenCardCount = {
    ID = "UnlockAwakenCardCount",
    CnID = "解锁灵知觉醒数",
    BaseSortID = 820,
    ApiType = "参数"
  },
  LockAwakenCardCount = {
    ID = "LockAwakenCardCount",
    CnID = "未解锁灵知觉醒数",
    BaseSortID = 821,
    ApiType = "参数"
  },
  GetRelicCount = {
    ID = "GetRelicCount",
    CnID = "造物数量",
    BaseSortID = 822,
    ApiType = "函数"
  },
  Stress = {
    ID = "Stress",
    CnID = "压力",
    BaseSortID = 823,
    ApiType = "参数"
  },
  LisShopBuyAfter = {
    ID = "LisShopBuyAfter",
    CnID = "商店购买后",
    BaseSortID = 824,
    ApiType = "触发器"
  },
  LisShopSaleCardAfter = {
    ID = "LisShopSaleCardAfter",
    CnID = "商店删卡后",
    BaseSortID = 825,
    ApiType = "触发器"
  },
  LisCampRestAfter = {
    ID = "LisCampRestAfter",
    CnID = "营地休息后",
    BaseSortID = 826,
    ApiType = "触发器"
  },
  LisMoveAfter = {
    ID = "LisMoveAfter",
    CnID = "移动后",
    BaseSortID = 827,
    ApiType = "触发器"
  },
  LisShopTriggerAfter = {
    ID = "LisShopTriggerAfter",
    CnID = "触发商店后",
    BaseSortID = 828,
    ApiType = "触发器"
  },
  LisCampTriggerAfter = {
    ID = "LisCampTriggerAfter",
    CnID = "触发营地后",
    BaseSortID = 829,
    ApiType = "触发器"
  },
  isAwaken = {
    ID = "isAwaken",
    CnID = "灵知觉醒状态",
    BaseSortID = 830,
    ApiType = "唤醒体属性"
  },
  isSeal = {
    ID = "isSeal",
    CnID = "是否解放",
    BaseSortID = 831,
    ApiType = "卡牌属性"
  },
  FuncGetEnchantCardList = {
    ID = "FuncGetEnchantCardList",
    CnID = "获取已刻印卡牌列表",
    BaseSortID = 832,
    ApiType = "函数"
  },
  FuncGetEnchantCardNum = {
    ID = "FuncGetEnchantCardNum",
    CnID = "获取已刻印卡牌数量",
    BaseSortID = 833,
    ApiType = "函数"
  },
  GainItem = {
    ID = "GainItem",
    CnID = "获取道具",
    BaseSortID = 834,
    ApiType = "指令"
  },
  StageLevel = {
    ID = "StageLevel",
    CnID = "关卡等级",
    BaseSortID = 835,
    ApiType = "参数"
  },
  BEGainRelicById = {
    ID = "BEGainRelicById",
    CnID = "获得指定ID的造物",
    BaseSortID = 836,
    ApiType = "指令"
  },
  DeleteRelicById = {
    ID = "DeleteRelicById",
    CnID = "移除指定ID的造物",
    BaseSortID = 837,
    ApiType = "指令"
  },
  BETentacleShow = {
    ID = "BETentacleShow",
    CnID = "触腕表演",
    BaseSortID = 838,
    ApiType = "指令"
  },
  Level = {
    ID = "Level",
    CnID = "等级",
    BaseSortID = 839,
    ApiType = "功能属性"
  },
  StageExpItemLevel = {
    ID = "StageExpItemLevel",
    CnID = "唤醒体经验道具系数",
    BaseSortID = 840,
    ApiType = "参数"
  },
  GetStagePower = {
    ID = "GetStagePower",
    CnID = "获取关卡强度",
    BaseSortID = 841,
    ApiType = "函数"
  },
  GetStageHpPower = {
    ID = "GetStageHpPower",
    CnID = "获取关卡生命强度",
    BaseSortID = 842,
    ApiType = "函数"
  },
  GetStageAtkPower = {
    ID = "GetStageAtkPower",
    CnID = "获取关卡暴击补偿",
    BaseSortID = 843,
    ApiType = "函数"
  },
  GetStageDefPower = {
    ID = "GetStageDefPower",
    CnID = "获取关卡防御强度",
    BaseSortID = 844,
    ApiType = "函数"
  },
  GetResonanceLevel = {
    ID = "GetResonanceLevel",
    CnID = "获取共鸣等级",
    BaseSortID = 845,
    ApiType = "函数"
  },
  GetResonancePara = {
    ID = "GetResonancePara",
    CnID = "获取共鸣参数",
    BaseSortID = 846,
    ApiType = "函数"
  },
  GetUpperTarget = {
    ID = "GetUpperTarget",
    CnID = "获取传入目标",
    BaseSortID = 847,
    ApiType = "函数"
  },
  GetPotencyLevel = {
    ID = "GetPotencyLevel",
    CnID = "获取启灵等级",
    BaseSortID = 848,
    ApiType = "函数"
  },
  GetBreakLevel = {
    ID = "GetBreakLevel",
    CnID = "获取突破等级",
    BaseSortID = 849,
    ApiType = "函数"
  },
  SkillLevelUp = {
    ID = "SkillLevelUp",
    CnID = "技能等级提升",
    BaseSortID = 850,
    ApiType = "函数"
  },
  GetTeamSkillMultiplier = {
    ID = "GetTeamSkillMultiplier",
    CnID = "获取队伍平均技能倍率",
    BaseSortID = 851,
    ApiType = "函数"
  },
  GetAwakerSkillMultiplier = {
    ID = "GetAwakerSkillMultiplier",
    CnID = "获取唤醒体技能倍率",
    BaseSortID = 852,
    ApiType = "函数"
  },
  GetAwakerLevelPower = {
    ID = "GetAwakerLevelPower",
    CnID = "获取唤醒体等级强度",
    BaseSortID = 853,
    ApiType = "函数"
  },
  damage_per2block_enemy = {
    ID = "damage_per2block_enemy",
    CnID = "对拥有护盾敌人伤害百分比修正",
    BaseSortID = 854,
    ApiType = "唤醒体属性"
  },
  damage_per2buff_enemy = {
    ID = "damage_per2buff_enemy",
    CnID = "对拥有正面状态敌人伤害百分比修正",
    BaseSortID = 855,
    ApiType = "唤醒体属性"
  },
  damage_per2debuff_enemy = {
    ID = "damage_per2debuff_enemy",
    CnID = "对拥有负面状态敌人伤害百分比修正",
    BaseSortID = 856,
    ApiType = "唤醒体属性"
  },
  damage_per2enemy_has_weak = {
    ID = "damage_per2enemy_has_weak",
    CnID = "对拥有虚弱状态敌人伤害百分比修正",
    BaseSortID = 857,
    ApiType = "唤醒体属性",
    Data = 3469
  },
  damage_per2enemy_has_vulnerable = {
    ID = "damage_per2enemy_has_vulnerable",
    CnID = "对拥有易伤状态敌人伤害百分比修正",
    BaseSortID = 858,
    ApiType = "唤醒体属性",
    Data = 2934
  },
  damage_per2enemy_has_posion = {
    ID = "damage_per2enemy_has_posion",
    CnID = "对拥有中毒状态敌人伤害百分比修正",
    BaseSortID = 859,
    ApiType = "唤醒体属性",
    Data = 3068
  },
  damage_per2petrify_resist = {
    ID = "damage_per2petrify_resist",
    CnID = "对拥有石化抗性状态敌人伤害百分比修正",
    BaseSortID = 860,
    ApiType = "唤醒体属性",
    Data = 3792
  },
  damage_per2enemy_has_frail = {
    ID = "damage_per2enemy_has_frail",
    CnID = "对拥有脆弱状态敌人伤害百分比修正",
    BaseSortID = 861,
    ApiType = "唤醒体属性",
    Data = 2564
  },
  damage_per2enemy_has_sculptor = {
    ID = "damage_per2enemy_has_sculptor",
    CnID = "对雕塑家协会敌人伤害百分比修正",
    BaseSortID = 862,
    ApiType = "唤醒体属性",
    Data = 80445
  },
  damage_per2enemy_has_snow = {
    ID = "damage_per2enemy_has_snow",
    CnID = "对雪原敌人伤害百分比修正",
    BaseSortID = 863,
    ApiType = "唤醒体属性",
    Data = 90659
  },
  damage_per2enemy_has_mutated = {
    ID = "damage_per2enemy_has_mutated",
    CnID = "对异变体敌人伤害百分比修正",
    BaseSortID = 864,
    ApiType = "唤醒体属性",
    Data = 89575
  },
  tentacle_damage_per2enemy_has_sea = {
    ID = "tentacle_damage_per2enemy_has_sea",
    CnID = "对深海敌人触腕伤害百分比修正",
    BaseSortID = 865,
    ApiType = "角色属性",
    Data = 83816
  },
  damage_per2enemy_has_servant = {
    ID = "damage_per2enemy_has_servant",
    CnID = "对从者敌人伤害百分比修正",
    BaseSortID = 866,
    ApiType = "唤醒体属性",
    Data = 90655
  },
  damage_per2enemy_has_blood = {
    ID = "damage_per2enemy_has_blood",
    CnID = "对血肉敌人伤害百分比修正",
    BaseSortID = 867,
    ApiType = "唤醒体属性",
    Data = 90650
  },
  damage_per2enemy_has_special1 = {
    ID = "damage_per2enemy_has_special1",
    CnID = "对特定标识1敌人伤害百分比修正",
    BaseSortID = 868,
    ApiType = "唤醒体属性",
    Data = 126417
  },
  damage_per2enemy_has_special2 = {
    ID = "damage_per2enemy_has_special2",
    CnID = "对特定标识2敌人伤害百分比修正",
    BaseSortID = 869,
    ApiType = "唤醒体属性",
    Data = 126421
  },
  damage_per2enemy_has_special3 = {
    ID = "damage_per2enemy_has_special3",
    CnID = "对特定标识3敌人伤害百分比修正",
    BaseSortID = 870,
    ApiType = "唤醒体属性",
    Data = 126423
  },
  damage_per2enemy_has_special4 = {
    ID = "damage_per2enemy_has_special4",
    CnID = "对特定标识4敌人伤害百分比修正",
    BaseSortID = 871,
    ApiType = "唤醒体属性",
    Data = 126422
  },
  damage_per2enemy_has_special5 = {
    ID = "damage_per2enemy_has_special5",
    CnID = "对特定标识5敌人伤害百分比修正",
    BaseSortID = 872,
    ApiType = "唤醒体属性",
    Data = 126420
  },
  damage_per2monster_boss = {
    ID = "damage_per2monster_boss",
    CnID = "对首领敌人额外伤害百分比修正",
    BaseSortID = 873,
    ApiType = "唤醒体属性",
    Data = "Boss"
  },
  damage_per2monster_elite = {
    ID = "damage_per2monster_elite",
    CnID = "对精英敌人额外伤害百分比修正",
    BaseSortID = 874,
    ApiType = "唤醒体属性",
    Data = "Elite"
  },
  damage_per2monster_grade1 = {
    ID = "damage_per2monster_grade1",
    CnID = "对一档小怪额外伤害百分比修正",
    BaseSortID = 875,
    ApiType = "唤醒体属性",
    Data = "MonsterGrade1"
  },
  damage_per2monster_grade2 = {
    ID = "damage_per2monster_grade2",
    CnID = "对二档小怪额外伤害百分比修正",
    BaseSortID = 876,
    ApiType = "唤醒体属性",
    Data = "MonsterGrade2"
  },
  damage_per2monster_normal = {
    ID = "damage_per2monster_normal",
    CnID = "对小怪额外伤害百分比修正",
    BaseSortID = 877,
    ApiType = "唤醒体属性",
    Data = "MonsterGrade1, MonsterGrade2"
  },
  state_layer_per_posion = {
    ID = "state_layer_per_posion",
    CnID = "施加中毒状态层数百分比加成",
    BaseSortID = 878,
    ApiType = "唤醒体属性",
    Data = 3068
  },
  i_state_layer_per_posion = {
    ID = "i_state_layer_per_posion",
    CnID = "局内施加中毒百分比加成",
    BaseSortID = 879,
    ApiType = "唤醒体属性",
    Data = 3068
  },
  fix_state_layer_per_posion = {
    ID = "fix_state_layer_per_posion",
    CnID = "施加固定中毒百分比修正",
    BaseSortID = 880,
    ApiType = "唤醒体属性",
    Data = 3068
  },
  be_fix_state_layer_per_posion = {
    ID = "be_fix_state_layer_per_posion",
    CnID = "承受固定中毒百分比修正",
    BaseSortID = 881,
    ApiType = "角色属性",
    Data = 3068
  },
  state_layer_per_counterattack = {
    ID = "state_layer_per_counterattack",
    CnID = "施加反击状态层数百分比加成",
    BaseSortID = 882,
    ApiType = "唤醒体属性",
    Data = "3905,3023"
  },
  i_state_layer_per_counterattack = {
    ID = "i_state_layer_per_counterattack",
    CnID = "局内施加反击百分比加成",
    BaseSortID = 883,
    ApiType = "唤醒体属性",
    Data = "3905,3023"
  },
  state_layer_per_bleeding = {
    ID = "state_layer_per_bleeding",
    CnID = "施加出血状态层数百分比加成",
    BaseSortID = 884,
    ApiType = "唤醒体属性",
    Data = 2840
  },
  i_state_layer_per_bleeding = {
    ID = "i_state_layer_per_bleeding",
    CnID = "局内施加出血百分比加成",
    BaseSortID = 885,
    ApiType = "唤醒体属性",
    Data = 2840
  },
  i_state_layer_per_exhaustion = {
    ID = "i_state_layer_per_exhaustion",
    CnID = "局内施加衰竭状态层数百分比加成",
    BaseSortID = 886,
    ApiType = "唤醒体属性",
    Data = "3902,2619"
  },
  i_state_layer_per_power = {
    ID = "i_state_layer_per_power",
    CnID = "局内施加力量百分比修正",
    BaseSortID = 887,
    ApiType = "唤醒体属性",
    Data = "2900,3130"
  },
  o_state_layer_per_power = {
    ID = "o_state_layer_per_power",
    CnID = "局外施加力量百分比修正",
    BaseSortID = 888,
    ApiType = "唤醒体属性",
    Data = "2900,3130"
  },
  o_state_layer_per_power_bycmd = {
    ID = "o_state_layer_per_power_bycmd",
    CnID = "局外唤醒体指令卡施加力量百分比修正",
    BaseSortID = 889,
    ApiType = "唤醒体属性",
    Data = "2900,3130"
  },
  immue_state_weak = {
    ID = "immue_state_weak",
    CnID = "免疫虚弱",
    BaseSortID = 890,
    ApiType = "角色属性",
    Data = 3469
  },
  immue_state_vulnerable = {
    ID = "immue_state_vulnerable",
    CnID = "免疫易伤",
    BaseSortID = 891,
    ApiType = "角色属性",
    Data = "2934,3149"
  },
  immue_state_posion = {
    ID = "immue_state_posion",
    CnID = "免疫中毒",
    BaseSortID = 892,
    ApiType = "角色属性",
    Data = 3068
  },
  immue_state_frail = {
    ID = "immue_state_frail",
    CnID = "免疫脆弱",
    BaseSortID = 893,
    ApiType = "角色属性",
    Data = 2564
  },
  crit2gt_hp_per = {
    ID = "crit2gt_hp_per",
    CnID = "对生命大于属性的敌人伤害必定暴击",
    BaseSortID = 894,
    ApiType = "唤醒体属性"
  },
  damage_per_skillcard = {
    ID = "damage_per_skillcard",
    CnID = "技能卡伤害百分比修正",
    BaseSortID = 895,
    ApiType = "唤醒体属性",
    Alias = "PVP通用技能造成伤害提高"
  },
  block_per_defendcard = {
    ID = "block_per_defendcard",
    CnID = "防御卡护盾百分比修正",
    BaseSortID = 896,
    ApiType = "唤醒体属性"
  },
  heal_per_skillcard = {
    ID = "heal_per_skillcard",
    CnID = "技能卡治疗百分比修正",
    BaseSortID = 897,
    ApiType = "唤醒体属性",
    Alias = "PVP通用技能造成治疗提高"
  },
  block_per_skillcard = {
    ID = "block_per_skillcard",
    CnID = "技能卡护盾百分比修正",
    BaseSortID = 898,
    ApiType = "唤醒体属性",
    Alias = "PVP通用技能造成护盾提高"
  },
  instructcard_final_block_per = {
    ID = "instructcard_final_block_per",
    CnID = "指令卡护盾最终效果百分比修正",
    BaseSortID = 899,
    ApiType = "唤醒体属性"
  },
  crit_per_from_ulti = {
    ID = "crit_per_from_ulti",
    CnID = "狂气爆发暴击率修正",
    BaseSortID = 900,
    ApiType = "唤醒体属性"
  },
  crit_damage_from_ulti = {
    ID = "crit_damage_from_ulti",
    CnID = "狂气爆发暴击伤害修正",
    BaseSortID = 901,
    ApiType = "唤醒体属性"
  },
  SurplusBlock = {
    ID = "SurplusBlock",
    CnID = "玩家剩余护盾",
    BaseSortID = 902,
    ApiType = "统计属性"
  },
  reverse_state_count = {
    ID = "reverse_state_count",
    CnID = "负面状态数量",
    BaseSortID = 903,
    ApiType = "功能属性"
  },
  positive_state_count = {
    ID = "positive_state_count",
    CnID = "正面状态数量",
    BaseSortID = 904,
    ApiType = "功能属性"
  },
  crit2lt_hp_per = {
    ID = "crit2lt_hp_per",
    CnID = "对生命小于属性的敌人伤害必定暴击",
    BaseSortID = 905,
    ApiType = "唤醒体属性"
  },
  unlimit_swallow = {
    ID = "unlimit_swallow",
    CnID = "无限吞噬",
    BaseSortID = 906,
    ApiType = "唤醒体属性"
  },
  crit_heal = {
    ID = "crit_heal",
    CnID = "暴击治疗",
    BaseSortID = 907,
    ApiType = "唤醒体属性"
  },
  bout_ulti_times = {
    ID = "bout_ulti_times",
    CnID = "每回合狂气爆发释放次数",
    BaseSortID = 908,
    ApiType = "角色属性"
  },
  PVPSneakState = {
    ID = "PVPSneakState",
    CnID = "PVP潜行状态",
    BaseSortID = 909,
    ApiType = "唤醒体属性",
    Data = 97251
  },
  PVPTauntState = {
    ID = "PVPTauntState",
    CnID = "PVP嘲讽状态",
    BaseSortID = 910,
    ApiType = "唤醒体属性",
    Data = 19535
  },
  PreventActiveDamage = {
    ID = "PreventActiveDamage",
    CnID = "阻止造成主动伤害生命损失",
    BaseSortID = 911,
    ApiType = "唤醒体属性"
  },
  PreventBeActiveDamage = {
    ID = "PreventBeActiveDamage",
    CnID = "阻止受到主动伤害生命损失",
    BaseSortID = 912,
    ApiType = "唤醒体属性"
  },
  BSTPreventActiveDamage = {
    ID = "BSTPreventActiveDamage",
    CnID = "阻止主动伤害的生命和护盾损失后",
    BaseSortID = 913,
    ApiType = "触发器"
  },
  PreventBeActiveDamageRetainHP = {
    ID = "PreventBeActiveDamageRetainHP",
    CnID = "阻止受到主动伤害生命损失时保持的血量",
    BaseSortID = 914,
    ApiType = "唤醒体属性"
  },
  BSTMaxHpChanged = {
    ID = "BSTMaxHpChanged",
    CnID = "最大生命变化后",
    BaseSortID = 915,
    ApiType = "触发器"
  },
  EventTriggerBattle = {
    ID = "EventTriggerBattle",
    CnID = "事件触发战斗",
    BaseSortID = 916,
    ApiType = "指令"
  },
  JumpEvent = {
    ID = "JumpEvent",
    CnID = "跳转事件",
    BaseSortID = 917,
    ApiType = "指令"
  },
  AddStageEventTask = {
    ID = "AddStageEventTask",
    CnID = "添加关卡事件任务",
    BaseSortID = 918,
    ApiType = "指令"
  },
  BSTAfterSkillCmdFinish = {
    ID = "BSTAfterSkillCmdFinish",
    CnID = "此卡牌指令生效后",
    BaseSortID = 919,
    ApiType = "触发器"
  },
  BSTAfterBlockChange = {
    ID = "BSTAfterBlockChange",
    CnID = "护盾变化后",
    BaseSortID = 920,
    ApiType = "触发器"
  },
  ["BSTAfterGainCards.Card_Curse"] = {
    ID = "BSTAfterGainCards.Card_Curse",
    CnID = "卡组加入症状卡后",
    BaseSortID = 921,
    ApiType = "触发器"
  },
  BSTStateOnDel = {
    ID = "BSTStateOnDel",
    CnID = "状态移除后",
    BaseSortID = 922,
    ApiType = "触发器"
  },
  TriggerValue2 = {
    ID = "TriggerValue2",
    CnID = "触发值2",
    BaseSortID = 923,
    ApiType = "参数"
  },
  TriggerValue3 = {
    ID = "TriggerValue3",
    CnID = "触发值3",
    BaseSortID = 924,
    ApiType = "参数"
  },
  TriggerValue4 = {
    ID = "TriggerValue4",
    CnID = "触发值4",
    BaseSortID = 925,
    ApiType = "参数"
  },
  damage_per = {
    ID = "damage_per",
    CnID = "造成伤害百分比修正",
    BaseSortID = 926,
    ApiType = "唤醒体属性"
  },
  i_damage_per = {
    ID = "i_damage_per",
    CnID = "局内造成伤害百分比修正",
    BaseSortID = 927,
    ApiType = "唤醒体属性",
    Alias = "PVP星兽余威造成伤害降低"
  },
  o_damage_per = {
    ID = "o_damage_per",
    CnID = "局外造成伤害百分比修正",
    BaseSortID = 928,
    ApiType = "唤醒体属性"
  },
  i_damage_per1 = {
    ID = "i_damage_per1",
    CnID = "墨菲专属局内造成伤害百分比修正",
    BaseSortID = 929,
    ApiType = "唤醒体属性"
  },
  i_damage_per2 = {
    ID = "i_damage_per2",
    CnID = "旺达专属局内造成伤害百分比修正",
    BaseSortID = 930,
    ApiType = "唤醒体属性"
  },
  i_damage_per3 = {
    ID = "i_damage_per3",
    CnID = "克莱门汀专属局内造成伤害百分比修正",
    BaseSortID = 931,
    ApiType = "唤醒体属性"
  },
  i_damage_per4 = {
    ID = "i_damage_per4",
    CnID = "汀克特灵塑专属局内造成伤害百分比修正",
    BaseSortID = 932,
    ApiType = "唤醒体属性"
  },
  i_damage_per5 = {
    ID = "i_damage_per5",
    CnID = "徐专属局内造成伤害百分比修正",
    BaseSortID = 933,
    ApiType = "唤醒体属性"
  },
  i_damage_per6 = {
    ID = "i_damage_per6",
    CnID = "本源萝坦专属局内造成伤害百分比修正",
    BaseSortID = 934,
    ApiType = "唤醒体属性"
  },
  i_damage_per7 = {
    ID = "i_damage_per7",
    CnID = "本源奥吉尔专属局内造成伤害百分比修正",
    BaseSortID = 935,
    ApiType = "唤醒体属性"
  },
  i_damage_per8 = {
    ID = "i_damage_per8",
    CnID = "造成伤害百分比修正8",
    BaseSortID = 936,
    ApiType = "唤醒体属性"
  },
  heal_per = {
    ID = "heal_per",
    CnID = "造成治疗百分比修正",
    BaseSortID = 937,
    ApiType = "唤醒体属性"
  },
  i_heal_per = {
    ID = "i_heal_per",
    CnID = "局内造成治疗百分比修正",
    BaseSortID = 938,
    ApiType = "唤醒体属性",
    Alias = "PVP死斗造成治疗降低"
  },
  o_heal_per = {
    ID = "o_heal_per",
    CnID = "局外造成治疗百分比修正",
    BaseSortID = 939,
    ApiType = "唤醒体属性",
    Alias = "PVP通用治疗提高"
  },
  all_deal_heal_per = {
    ID = "all_deal_heal_per",
    CnID = "所有造成治疗效果百分比修正",
    BaseSortID = 940,
    ApiType = "角色属性"
  },
  block_per = {
    ID = "block_per",
    CnID = "造成护盾百分比修正",
    BaseSortID = 941,
    ApiType = "唤醒体属性"
  },
  i_block_per = {
    ID = "i_block_per",
    CnID = "局内造成护盾百分比修正",
    BaseSortID = 942,
    ApiType = "唤醒体属性",
    Alias = "PVP死斗造成护盾降低"
  },
  o_block_per = {
    ID = "o_block_per",
    CnID = "局外造成护盾百分比修正",
    BaseSortID = 943,
    ApiType = "唤醒体属性",
    Alias = "PVP通用护盾提高"
  },
  damage_per_strikecard = {
    ID = "damage_per_strikecard",
    CnID = "打击卡伤害百分比修正",
    BaseSortID = 944,
    ApiType = "唤醒体属性",
    Alias = "PVP通用打击造成伤害提高"
  },
  i_damage_per_strikecard = {
    ID = "i_damage_per_strikecard",
    CnID = "局内打击卡伤害百分比修正",
    BaseSortID = 945,
    ApiType = "唤醒体属性"
  },
  o_damage_per_strikecard = {
    ID = "o_damage_per_strikecard",
    CnID = "局外打击卡伤害百分比修正",
    BaseSortID = 946,
    ApiType = "唤醒体属性",
    Alias = "PVP蓄力打击造成伤害提高"
  },
  o_damage_per_strikecard_limit = {
    ID = "o_damage_per_strikecard_limit",
    CnID = "局外打击卡伤害百分比修正属性限制",
    BaseSortID = 947,
    ApiType = "卡牌属性"
  },
  damage_per_card = {
    ID = "damage_per_card",
    CnID = "唤醒体卡牌伤害百分比修正",
    BaseSortID = 948,
    ApiType = "唤醒体属性"
  },
  block_per_card = {
    ID = "block_per_card",
    CnID = "唤醒体卡牌护盾百分比修正",
    BaseSortID = 949,
    ApiType = "唤醒体属性",
    Alias = "PVP强效卡牌护盾提高"
  },
  o_heal_per_card = {
    ID = "o_heal_per_card",
    CnID = "局外唤醒体卡牌治疗百分比修正",
    BaseSortID = 950,
    ApiType = "唤醒体属性"
  },
  o_damage_per_card = {
    ID = "o_damage_per_card",
    CnID = "局外唤醒体卡牌伤害百分比修正",
    BaseSortID = 951,
    ApiType = "唤醒体属性"
  },
  i_damage_per_attachpost = {
    ID = "i_damage_per_attachpost",
    CnID = "局内唤醒体造成追击伤害百分比修正",
    BaseSortID = 952,
    ApiType = "唤醒体属性"
  },
  o_damage_per_attachpost = {
    ID = "o_damage_per_attachpost",
    CnID = "局外唤醒体造成追击伤害百分比修正",
    BaseSortID = 953,
    ApiType = "唤醒体属性"
  },
  damage_per_attachpost = {
    ID = "damage_per_attachpost",
    CnID = "唤醒体追击伤害百分比修正",
    BaseSortID = 954,
    ApiType = "唤醒体属性"
  },
  i_damage_per_ulti = {
    ID = "i_damage_per_ulti",
    CnID = "局内狂气爆发伤害百分比修正",
    BaseSortID = 955,
    ApiType = "唤醒体属性",
    Alias = "PVP强效狂气爆发伤害提高"
  },
  o_damage_per_ulti = {
    ID = "o_damage_per_ulti",
    CnID = "局外狂气爆发伤害百分比修正",
    BaseSortID = 956,
    ApiType = "唤醒体属性"
  },
  damage_per_ulti = {
    ID = "damage_per_ulti",
    CnID = "狂气爆发伤害百分比修正",
    BaseSortID = 957,
    ApiType = "唤醒体属性",
    Alias = "PVP通用狂气爆发造成伤害提高"
  },
  heal_per_ulti = {
    ID = "heal_per_ulti",
    CnID = "狂气爆发治疗百分比修正",
    BaseSortID = 958,
    ApiType = "唤醒体属性",
    Alias = "PVP通用狂气爆发造成治疗提高"
  },
  i_heal_per_ulti = {
    ID = "i_heal_per_ulti",
    CnID = "局内狂气爆发治疗百分比修正",
    BaseSortID = 959,
    ApiType = "唤醒体属性",
    Alias = "PVP强效狂气爆发治疗提高"
  },
  o_heal_per_ulti = {
    ID = "o_heal_per_ulti",
    CnID = "局外狂气爆发治疗百分比修正",
    BaseSortID = 960,
    ApiType = "唤醒体属性"
  },
  block_per_ulti = {
    ID = "block_per_ulti",
    CnID = "狂气爆发护盾百分比修正",
    BaseSortID = 961,
    ApiType = "唤醒体属性",
    Alias = "PVP通用狂气爆发造成护盾提高"
  },
  i_block_per_ulti = {
    ID = "i_block_per_ulti",
    CnID = "局内狂气爆发护盾百分比修正",
    BaseSortID = 962,
    ApiType = "唤醒体属性",
    Alias = "PVP强效狂气爆发护盾提高"
  },
  o_block_per_ulti = {
    ID = "o_block_per_ulti",
    CnID = "局外狂气爆发护盾百分比修正",
    BaseSortID = 963,
    ApiType = "唤醒体属性"
  },
  hand_deck_limit_up = {
    ID = "hand_deck_limit_up",
    CnID = "手牌额外上限",
    BaseSortID = 964,
    ApiType = "角色属性"
  },
  crit_from_strikecard = {
    ID = "crit_from_strikecard",
    CnID = "打击卡必爆",
    BaseSortID = 965,
    ApiType = "唤醒体属性"
  },
  crit_damage_from_strikecard = {
    ID = "crit_damage_from_strikecard",
    CnID = "打击卡暴击伤害修正",
    BaseSortID = 966,
    ApiType = "唤醒体属性"
  },
  crit_per_from_strikecard = {
    ID = "crit_per_from_strikecard",
    CnID = "打击卡暴击率修正",
    BaseSortID = 967,
    ApiType = "唤醒体属性"
  },
  enchant_upgrade_curse = {
    ID = "enchant_upgrade_curse",
    CnID = "战斗后获得刻印升级为诅咒",
    BaseSortID = 968,
    ApiType = "角色属性"
  },
  no_discard_card = {
    ID = "no_discard_card",
    CnID = "回合结束不再丢弃手牌",
    BaseSortID = 969,
    ApiType = "角色属性"
  },
  immue_active_damage = {
    ID = "immue_active_damage",
    CnID = "免疫主动伤害",
    BaseSortID = 970,
    ApiType = "角色属性"
  },
  immue_passive_damage = {
    ID = "immue_passive_damage",
    CnID = "免疫纯粹伤害",
    BaseSortID = 971,
    ApiType = "角色属性"
  },
  immue_tentacle_damage = {
    ID = "immue_tentacle_damage",
    CnID = "免疫触腕伤害",
    BaseSortID = 972,
    ApiType = "角色属性"
  },
  immue_fixed_damage = {
    ID = "immue_fixed_damage",
    CnID = "免疫固定伤害",
    BaseSortID = 973,
    ApiType = "角色属性"
  },
  immue_pure_damage = {
    ID = "immue_pure_damage",
    CnID = "免疫PVP纯粹伤害",
    BaseSortID = 974,
    ApiType = "角色属性"
  },
  draw_card_num = {
    ID = "draw_card_num",
    CnID = "每回合抽牌数",
    BaseSortID = 975,
    ApiType = "角色属性"
  },
  awaker_strength_multiple = {
    ID = "awaker_strength_multiple",
    CnID = "主动伤害力量额外享受百分比",
    BaseSortID = 976,
    ApiType = "唤醒体属性"
  },
  crit2block = {
    ID = "crit2block",
    CnID = "对拥有护盾敌方必定暴击",
    BaseSortID = 977,
    ApiType = "唤醒体属性"
  },
  certain_crit = {
    ID = "certain_crit",
    CnID = "伤害必爆",
    BaseSortID = 978,
    ApiType = "角色属性"
  },
  ulti_strength_multiple = {
    ID = "ulti_strength_multiple",
    CnID = "狂气爆发主动伤害力量额外享受百分比",
    BaseSortID = 979,
    ApiType = "唤醒体属性"
  },
  tentacle_puncture_dmg = {
    ID = "tentacle_puncture_dmg",
    CnID = "穿刺触腕伤害",
    BaseSortID = 980,
    ApiType = "唤醒体属性"
  },
  awaker_ulti_BaseDmg_flat = {
    ID = "awaker_ulti_BaseDmg_flat",
    CnID = "本唤醒体狂气爆发伤害强效固定值修正",
    BaseSortID = 981,
    ApiType = "唤醒体属性"
  },
  awaker_PostAct_BaseDmg_flat = {
    ID = "awaker_PostAct_BaseDmg_flat",
    CnID = "本唤醒体追击伤害强效固定值修正",
    BaseSortID = 982,
    ApiType = "唤醒体属性"
  },
  awaker_dmg_power_per_scale = {
    ID = "awaker_dmg_power_per_scale",
    CnID = "本唤醒体伤害享受力量倍率额外缩放",
    BaseSortID = 983,
    ApiType = "唤醒体属性"
  },
  eternal_card_created_cant_choose = {
    ID = "eternal_card_created_cant_choose",
    CnID = "永久创造卡牌不可被按卡牌类型选中标识",
    BaseSortID = 984,
    ApiType = "卡牌属性"
  },
  card_damage_per2block_barrier = {
    ID = "card_damage_per2block_barrier",
    CnID = "卡牌对护盾或拥有屏障状态的敌人伤害百分比修正暂无",
    BaseSortID = 985,
    ApiType = "卡牌属性",
    Data = 3638
  },
  card_damage_per2block_enemy = {
    ID = "card_damage_per2block_enemy",
    CnID = "卡牌对拥有护盾敌人伤害百分比修正暂无",
    BaseSortID = 986,
    ApiType = "卡牌属性"
  },
  card_damage_per2buff_enemy = {
    ID = "card_damage_per2buff_enemy",
    CnID = "卡牌对拥有正面状态敌人伤害百分比修正暂无",
    BaseSortID = 987,
    ApiType = "卡牌属性"
  },
  card_damage_per2debuff_enemy = {
    ID = "card_damage_per2debuff_enemy",
    CnID = "卡牌对拥有负面状态敌人伤害百分比修正暂无",
    BaseSortID = 988,
    ApiType = "卡牌属性"
  },
  card_strength_multiple = {
    ID = "card_strength_multiple",
    CnID = "卡牌主动伤害力量额外享受百分比",
    BaseSortID = 989,
    ApiType = "卡牌属性"
  },
  card_crit2block = {
    ID = "card_crit2block",
    CnID = "卡牌对拥有护盾敌方必定暴击",
    BaseSortID = 990,
    ApiType = "卡牌属性"
  },
  card_certain_crit = {
    ID = "card_certain_crit",
    CnID = "卡牌伤害必爆",
    BaseSortID = 991,
    ApiType = "卡牌属性"
  },
  card_type_strike = {
    ID = "card_type_strike",
    CnID = "卡牌类型修正为打击卡",
    BaseSortID = 992,
    ApiType = "卡牌属性"
  },
  card_damage_plus = {
    ID = "card_damage_plus",
    CnID = "卡牌伤害固定值修正",
    BaseSortID = 993,
    ApiType = "卡牌属性"
  },
  card_damage_per = {
    ID = "card_damage_per",
    CnID = "卡牌伤害百分比修正",
    BaseSortID = 994,
    ApiType = "卡牌属性",
    Alias = "PVP通用卡牌伤害提高"
  },
  card_damage_per2 = {
    ID = "card_damage_per2",
    CnID = "卡牌最终伤害百分比修正",
    BaseSortID = 995,
    ApiType = "卡牌属性"
  },
  card_damage_per3 = {
    ID = "card_damage_per3",
    CnID = "本卡牌造成伤害最终百分比修正1",
    BaseSortID = 996,
    ApiType = "卡牌属性"
  },
  card_block_plus = {
    ID = "card_block_plus",
    CnID = "卡牌护盾固定值修正",
    BaseSortID = 997,
    ApiType = "卡牌属性"
  },
  card_block_per = {
    ID = "card_block_per",
    CnID = "卡牌护盾百分比修正",
    BaseSortID = 998,
    ApiType = "卡牌属性",
    Alias = "PVP通用卡牌护盾提高"
  },
  card_block_per2 = {
    ID = "card_block_per2",
    CnID = "本卡牌造成护盾最终百分比修正1",
    BaseSortID = 999,
    ApiType = "卡牌属性"
  },
  card_heal_plus = {
    ID = "card_heal_plus",
    CnID = "卡牌治疗固定值加成",
    BaseSortID = 1000,
    ApiType = "卡牌属性"
  },
  card_heal_per = {
    ID = "card_heal_per",
    CnID = "卡牌治疗百分比加成",
    BaseSortID = 1001,
    ApiType = "卡牌属性",
    Alias = "PVP通用卡牌指令提高"
  },
  card_heal_per2 = {
    ID = "card_heal_per2",
    CnID = "本卡牌造成治疗最终百分比修正1",
    BaseSortID = 1002,
    ApiType = "卡牌属性"
  },
  card_ulti_plus = {
    ID = "card_ulti_plus",
    CnID = "卡牌狂气固定值修正",
    BaseSortID = 1003,
    ApiType = "卡牌属性"
  },
  card_ulti_per = {
    ID = "card_ulti_per",
    CnID = "卡牌狂气百分比修正",
    BaseSortID = 1004,
    ApiType = "卡牌属性"
  },
  damage_per2block_barrier = {
    ID = "damage_per2block_barrier",
    CnID = "对护盾或拥有屏障状态的敌人伤害百分比修正",
    BaseSortID = 1005,
    ApiType = "唤醒体属性",
    Data = 3638
  },
  FuncGetAwakerCardNum = {
    ID = "FuncGetAwakerCardNum",
    CnID = "按唤醒体目标获取卡牌数量",
    BaseSortID = 1006,
    ApiType = "函数"
  },
  extra_jump_time = {
    ID = "extra_jump_time",
    CnID = "跃迁效果额外触发一次",
    BaseSortID = 1007,
    ApiType = "唤醒体属性"
  },
  noCond_extraBout = {
    ID = "noCond_extraBout",
    CnID = "无条件触发跃迁效果",
    BaseSortID = 1008,
    ApiType = "唤醒体属性"
  },
  card_state_layer_per_TentaclePower = {
    ID = "card_state_layer_per_TentaclePower",
    CnID = "本卡牌施加触腕伤害最终百分比修正1",
    BaseSortID = 1009,
    ApiType = "卡牌属性",
    Data = "3897,2924"
  },
  card_state_layer_per_poison = {
    ID = "card_state_layer_per_poison",
    CnID = "本卡牌施加中毒最终百分比修正",
    BaseSortID = 1010,
    ApiType = "卡牌属性",
    Data = 3068
  },
  card_state_layer_per_counterattack = {
    ID = "card_state_layer_per_counterattack",
    CnID = "本卡牌施加反击最终百分比修正",
    BaseSortID = 1011,
    ApiType = "卡牌属性",
    Data = "3905,3023"
  },
  card_fixed_state_layer_per_poison = {
    ID = "card_fixed_state_layer_per_poison",
    CnID = "本卡牌施加固定中毒最终百分比修正1",
    BaseSortID = 1012,
    ApiType = "卡牌属性",
    Data = 3068
  },
  card_fixed_state_layer_per_counterattack = {
    ID = "card_fixed_state_layer_per_counterattack",
    CnID = "本卡牌施加固定反击最终百分比修正1",
    BaseSortID = 1013,
    ApiType = "卡牌属性",
    Data = "3905,3023"
  },
  card_fixed_state_layer_per_fatecut = {
    ID = "card_fixed_state_layer_per_fatecut",
    CnID = "本卡牌施加固定命运裁断最终百分比修正1",
    BaseSortID = 1014,
    ApiType = "卡牌属性",
    Data = 134285
  },
  awaker_ulti_dmg_per = {
    ID = "awaker_ulti_dmg_per",
    CnID = "探索内本唤醒体狂气爆发造成伤害最终百分比修正",
    BaseSortID = 1015,
    ApiType = "唤醒体属性"
  },
  awaker_ulti_block_per = {
    ID = "awaker_ulti_block_per",
    CnID = "探索内本唤醒体狂气爆发造成护盾最终百分比修正",
    BaseSortID = 1016,
    ApiType = "唤醒体属性"
  },
  awaker_ulti_heal_per = {
    ID = "awaker_ulti_heal_per",
    CnID = "探索内本唤醒体狂气爆发造成治疗最终百分比修正",
    BaseSortID = 1017,
    ApiType = "唤醒体属性"
  },
  awaker_ulti_state_layer_per_exhaustion = {
    ID = "awaker_ulti_state_layer_per_exhaustion",
    CnID = "探索内本唤醒体狂气爆发施加衰竭最终百分比修正",
    BaseSortID = 1018,
    ApiType = "唤醒体属性",
    Data = "3902,2619"
  },
  awaker_ulti_state_layer_per_power = {
    ID = "awaker_ulti_state_layer_per_power",
    CnID = "探索内本唤醒体狂气爆发施加力量最终百分比修正",
    BaseSortID = 1019,
    ApiType = "唤醒体属性",
    Data = "2900,3130"
  },
  awaker_ulti_state_layer_per_TentaclePower = {
    ID = "awaker_ulti_state_layer_per_TentaclePower",
    CnID = "探索内本唤醒体狂气爆发施加触腕伤害最终百分比修正",
    BaseSortID = 1020,
    ApiType = "唤醒体属性",
    Data = "3897,2924"
  },
  awaker_ulti_state_layer_per_poison = {
    ID = "awaker_ulti_state_layer_per_poison",
    CnID = "探索内本唤醒体狂气爆发施加中毒最终百分比修正",
    BaseSortID = 1021,
    ApiType = "唤醒体属性",
    Data = 3068
  },
  awaker_ulti_state_layer_per_counterattack = {
    ID = "awaker_ulti_state_layer_per_counterattack",
    CnID = "探索内本唤醒体狂气爆发施加反击最终百分比修正",
    BaseSortID = 1022,
    ApiType = "唤醒体属性",
    Data = "3905,3023"
  },
  awaker_ulti_fixed_state_layer_per_poison = {
    ID = "awaker_ulti_fixed_state_layer_per_poison",
    CnID = "探索内本唤醒体狂气爆发施加固定中毒最终百分比修正",
    BaseSortID = 1023,
    ApiType = "唤醒体属性",
    Data = 3068
  },
  awaker_ulti_fixed_state_layer_per_counterattack = {
    ID = "awaker_ulti_fixed_state_layer_per_counterattack",
    CnID = "探索内本唤醒体狂气爆发施加固定反击最终百分比修正",
    BaseSortID = 1024,
    ApiType = "唤醒体属性",
    Data = "3905,3023"
  },
  awaker_ulti_fixed_state_layer_per_fatecut = {
    ID = "awaker_ulti_fixed_state_layer_per_fatecut",
    CnID = "探索内本唤醒体狂气爆发施加固定命运裁断最终百分比修正",
    BaseSortID = 1025,
    ApiType = "唤醒体属性",
    Data = 134285
  },
  awaker_CmdCard_dmg_per = {
    ID = "awaker_CmdCard_dmg_per",
    CnID = "探索内本唤醒体指令卡造成伤害最终百分比修正",
    BaseSortID = 1026,
    ApiType = "唤醒体属性",
    Alias = "PVP强效卡牌伤害提高"
  },
  awaker_CmdCard_block_per = {
    ID = "awaker_CmdCard_block_per",
    CnID = "探索内本唤醒体指令卡造成护盾最终百分比修正",
    BaseSortID = 1027,
    ApiType = "唤醒体属性"
  },
  awaker_CmdCard_heal_per = {
    ID = "awaker_CmdCard_heal_per",
    CnID = "探索内本唤醒体指令卡造成治疗最终百分比修正",
    BaseSortID = 1028,
    ApiType = "唤醒体属性",
    Alias = "PVP强效卡牌治疗提高"
  },
  awaker_CmdCard_state_layer_per_exhaustion = {
    ID = "awaker_CmdCard_state_layer_per_exhaustion",
    CnID = "探索内本唤醒体指令卡施加衰竭最终百分比修正",
    BaseSortID = 1029,
    ApiType = "唤醒体属性",
    Data = "3902,2619"
  },
  awaker_CmdCard_state_layer_per_power = {
    ID = "awaker_CmdCard_state_layer_per_power",
    CnID = "探索内本唤醒体指令卡施加力量最终百分比修正",
    BaseSortID = 1030,
    ApiType = "唤醒体属性",
    Data = "2900,3130"
  },
  awaker_CmdCard_state_layer_per_TentaclePower = {
    ID = "awaker_CmdCard_state_layer_per_TentaclePower",
    CnID = "探索内本唤醒体指令卡施加触腕伤害最终百分比修正",
    BaseSortID = 1031,
    ApiType = "唤醒体属性",
    Data = "3897,2924"
  },
  awaker_CmdCard_state_layer_per_poison = {
    ID = "awaker_CmdCard_state_layer_per_poison",
    CnID = "探索内本唤醒体指令卡施加中毒最终百分比修正",
    BaseSortID = 1032,
    ApiType = "唤醒体属性",
    Data = 3068
  },
  awaker_CmdCard_state_layer_per_counterattack = {
    ID = "awaker_CmdCard_state_layer_per_counterattack",
    CnID = "探索内本唤醒体指令卡施加反击最终百分比修正",
    BaseSortID = 1033,
    ApiType = "唤醒体属性",
    Data = "3905,3023"
  },
  awaker_CmdCard_fixed_state_layer_per_poison = {
    ID = "awaker_CmdCard_fixed_state_layer_per_poison",
    CnID = "探索内本唤醒体指令卡施加固定中毒最终百分比修正",
    BaseSortID = 1034,
    ApiType = "唤醒体属性",
    Data = 3068
  },
  awaker_CmdCard_fixed_state_layer_per_counterattack = {
    ID = "awaker_CmdCard_fixed_state_layer_per_counterattack",
    CnID = "探索内本唤醒体指令卡施加固定反击最终百分比修正",
    BaseSortID = 1035,
    ApiType = "唤醒体属性",
    Data = "3905,3023"
  },
  awaker_CmdCard_fixed_state_layer_per_fatecut = {
    ID = "awaker_CmdCard_fixed_state_layer_per_fatecut",
    CnID = "探索内本唤醒体指令卡施加固定命运裁断最终百分比修正",
    BaseSortID = 1036,
    ApiType = "唤醒体属性",
    Data = 134285
  },
  strikecard_damage_plus = {
    ID = "strikecard_damage_plus",
    CnID = "打击卡伤害固定值修正",
    BaseSortID = 1037,
    ApiType = "唤醒体属性"
  },
  ulti_damage_plus = {
    ID = "ulti_damage_plus",
    CnID = "狂气爆发伤害固定值修正",
    BaseSortID = 1038,
    ApiType = "唤醒体属性"
  },
  GetSkillType = {
    ID = "GetSkillType",
    CnID = "获取技能类型",
    BaseSortID = 1039,
    ApiType = "函数"
  },
  GetIsCard = {
    ID = "GetIsCard",
    CnID = "获取是否卡牌",
    BaseSortID = 1040,
    ApiType = "函数"
  },
  HasBuff = {
    ID = "HasBuff",
    CnID = "拥有正面状态",
    BaseSortID = 1041,
    ApiType = "函数"
  },
  HasDebuff = {
    ID = "HasDebuff",
    CnID = "拥有负面状态",
    BaseSortID = 1042,
    ApiType = "函数"
  },
  HasStateIDList = {
    ID = "HasStateIDList",
    CnID = "拥有状态",
    BaseSortID = 1043,
    ApiType = "函数"
  },
  GetCurCmdShowDamage = {
    ID = "GetCurCmdShowDamage",
    CnID = "本指令主动伤害公式结果",
    BaseSortID = 1044,
    ApiType = "函数"
  },
  GetCurCmdShowHeal = {
    ID = "GetCurCmdShowHeal",
    CnID = "本指令治疗公式结果",
    BaseSortID = 1045,
    ApiType = "函数"
  },
  GetCurCmdShowBlock = {
    ID = "GetCurCmdShowBlock",
    CnID = "本指令护盾公式结果",
    BaseSortID = 1046,
    ApiType = "函数"
  },
  GetCurCmdShowUltiEnergy = {
    ID = "GetCurCmdShowUltiEnergy",
    CnID = "本指令狂气公式结果",
    BaseSortID = 1047,
    ApiType = "函数"
  },
  GetCurCmdShowBlood = {
    ID = "GetCurCmdShowBlood",
    CnID = "本指令胚胎融合公式结果",
    BaseSortID = 1048,
    ApiType = "函数"
  },
  BEPassiveBlock = {
    ID = "BEPassiveBlock",
    CnID = "造成被动护盾",
    BaseSortID = 1049,
    ApiType = "指令"
  },
  BEPassiveHeal = {
    ID = "BEPassiveHeal",
    CnID = "造成被动治疗",
    BaseSortID = 1050,
    ApiType = "指令"
  },
  BEGainKeeperEnergy = {
    ID = "BEGainKeeperEnergy",
    CnID = "造成钥能",
    BaseSortID = 1051,
    ApiType = "指令"
  },
  BEChangeKeeperEnergy = {
    ID = "BEChangeKeeperEnergy",
    CnID = "改变钥能",
    BaseSortID = 1052,
    ApiType = "指令"
  },
  bout_skill_times = {
    ID = "bout_skill_times",
    CnID = "每回合技能释放次数",
    BaseSortID = 1053,
    ApiType = "角色属性"
  },
  keeper_energy = {
    ID = "keeper_energy",
    CnID = "当前钥能",
    BaseSortID = 1054,
    ApiType = "角色属性"
  },
  max_keeper_energy = {
    ID = "max_keeper_energy",
    CnID = "最大钥能",
    BaseSortID = 1055,
    ApiType = "角色属性"
  },
  basic_damage_per = {
    ID = "basic_damage_per",
    CnID = "队伍基础伤害",
    BaseSortID = 1056,
    ApiType = "角色属性"
  },
  basic_poison_per = {
    ID = "basic_poison_per",
    CnID = "中毒强效",
    BaseSortID = 1057,
    ApiType = "角色属性"
  },
  basic_counterattack_per = {
    ID = "basic_counterattack_per",
    CnID = "反击强效",
    BaseSortID = 1058,
    ApiType = "角色属性"
  },
  basic_cardper_per = {
    ID = "basic_cardper_per",
    CnID = "指令卡强效强效",
    BaseSortID = 1059,
    ApiType = "角色属性"
  },
  i_basic_damage_per = {
    ID = "i_basic_damage_per",
    CnID = "局内造成基础伤害百分比修正",
    BaseSortID = 1060,
    ApiType = "唤醒体属性"
  },
  BEPassiveUltiEnergy = {
    ID = "BEPassiveUltiEnergy",
    CnID = "造成被动狂气",
    BaseSortID = 1061,
    ApiType = "指令"
  },
  BSTAfterGainCards = {
    ID = "BSTAfterGainCards",
    CnID = "永久获得卡牌后",
    BaseSortID = 1062,
    ApiType = "触发器"
  },
  SelectCmdCaster = {
    ID = "SelectCmdCaster",
    CnID = "选择施法者",
    BaseSortID = 1063,
    ApiType = "目标"
  },
  SelectFrontEnemy = {
    ID = "SelectFrontEnemy",
    CnID = "选择前排敌方",
    BaseSortID = 1064,
    ApiType = "函数"
  },
  SelectMaxHpEnemy = {
    ID = "SelectMaxHpEnemy",
    CnID = "选择生命最高敌方",
    BaseSortID = 1065,
    ApiType = "函数"
  },
  SelectMinHpEnemy = {
    ID = "SelectMinHpEnemy",
    CnID = "选择生命最低敌方",
    BaseSortID = 1066,
    ApiType = "函数"
  },
  SelectAlly = {
    ID = "SelectAlly",
    CnID = "选择友方",
    BaseSortID = 1067,
    ApiType = "函数"
  },
  SelectEnemy = {
    ID = "SelectEnemy",
    CnID = "选择敌方",
    BaseSortID = 1068,
    ApiType = "函数"
  },
  SelectAwaker = {
    ID = "SelectAwaker",
    CnID = "选择任意唤醒体",
    BaseSortID = 1069,
    ApiType = "函数"
  },
  SelectRandomEnemy = {
    ID = "SelectRandomEnemy",
    CnID = "选择随机敌方",
    BaseSortID = 1070,
    ApiType = "目标"
  },
  SelectRandomAlly = {
    ID = "SelectRandomAlly",
    CnID = "选择随机友方",
    BaseSortID = 1071,
    ApiType = "目标"
  },
  SelectAllAlly = {
    ID = "SelectAllAlly",
    CnID = "选择全体友方",
    BaseSortID = 1072,
    ApiType = "函数"
  },
  SelectAllEnemy = {
    ID = "SelectAllEnemy",
    CnID = "选择全体敌方",
    BaseSortID = 1073,
    ApiType = "函数"
  },
  SelectAllOtherAwaker = {
    ID = "SelectAllOtherAwaker",
    CnID = "选择其他任意唤醒体",
    BaseSortID = 1074,
    ApiType = "函数"
  },
  SelectTarget = {
    ID = "SelectTarget",
    CnID = "选择目标",
    BaseSortID = 1075,
    ApiType = "函数"
  },
  MinHpAndBlockEnemy = {
    ID = "MinHpAndBlockEnemy",
    CnID = "生命和护盾最低敌方",
    BaseSortID = 1076,
    ApiType = "目标"
  },
  MaxHpAndBlockEnemy = {
    ID = "MaxHpAndBlockEnemy",
    CnID = "生命和护盾最高敌方",
    BaseSortID = 1077,
    ApiType = "目标"
  },
  MinHpAndBlockAlly = {
    ID = "MinHpAndBlockAlly",
    CnID = "生命和护盾最低友方",
    BaseSortID = 1078,
    ApiType = "目标"
  },
  MaxHpAndBlockAlly = {
    ID = "MaxHpAndBlockAlly",
    CnID = "生命和护盾最高友方",
    BaseSortID = 1079,
    ApiType = "目标"
  },
  DeadOrAlive = {
    ID = "DeadOrAlive",
    CnID = "全部",
    BaseSortID = 1080,
    ApiType = "标记"
  },
  DeathOnly = {
    ID = "DeathOnly",
    CnID = "仅死亡",
    BaseSortID = 1081,
    ApiType = "标记"
  },
  AliveOnly = {
    ID = "AliveOnly",
    CnID = "仅存活",
    BaseSortID = 1082,
    ApiType = "标记"
  },
  IncludeBlock = {
    ID = "IncludeBlock",
    CnID = "包含护盾",
    BaseSortID = 1083,
    ApiType = "标记"
  },
  NotIncludeBlock = {
    ID = "NotIncludeBlock",
    CnID = "不包含护盾",
    BaseSortID = 1084,
    ApiType = "标记"
  },
  PVPTeam1 = {
    ID = "PVPTeam1",
    CnID = "先手队伍",
    BaseSortID = 1085,
    ApiType = "参数"
  },
  PVPTeam2 = {
    ID = "PVPTeam2",
    CnID = "后手队伍",
    BaseSortID = 1086,
    ApiType = "参数"
  },
  forbit_strike_card = {
    ID = "forbit_strike_card",
    CnID = "无法打出打击卡",
    BaseSortID = 1087,
    ApiType = "角色属性"
  },
  taunt = {
    ID = "taunt",
    CnID = "嘲讽",
    BaseSortID = 1088,
    ApiType = "角色属性"
  },
  sneak = {
    ID = "sneak",
    CnID = "潜行",
    BaseSortID = 1089,
    ApiType = "角色属性"
  },
  Camp = {
    ID = "Camp",
    CnID = "队伍",
    BaseSortID = 1090,
    ApiType = "角色属性"
  },
  BEPVPRebirth = {
    ID = "BEPVPRebirth",
    CnID = "复活",
    BaseSortID = 1091,
    ApiType = "指令"
  },
  PVPGenCardListByType = {
    ID = "PVPGenCardListByType",
    CnID = "按类型获取卡牌列表",
    BaseSortID = 1092,
    ApiType = "函数"
  },
  EnemyDrawDeck = {
    ID = "EnemyDrawDeck",
    CnID = "敌方抽牌堆",
    BaseSortID = 1093,
    ApiType = "牌堆"
  },
  EnemyHandDeck = {
    ID = "EnemyHandDeck",
    CnID = "敌方手牌堆",
    BaseSortID = 1094,
    ApiType = "牌堆"
  },
  EnemyGraveyardDeck = {
    ID = "EnemyGraveyardDeck",
    CnID = "敌方弃牌堆",
    BaseSortID = 1095,
    ApiType = "牌堆"
  },
  EnemyConsumedDeck = {
    ID = "EnemyConsumedDeck",
    CnID = "敌方消耗堆",
    BaseSortID = 1096,
    ApiType = "牌堆"
  },
  EnemyDimensionDeck = {
    ID = "EnemyDimensionDeck",
    CnID = "敌方超维牌堆",
    BaseSortID = 1097,
    ApiType = "牌堆"
  },
  EnemyDrawDeckAndGraveyardDeck = {
    ID = "EnemyDrawDeckAndGraveyardDeck",
    CnID = "敌方抽牌堆和弃牌堆",
    BaseSortID = 1098,
    ApiType = "牌堆"
  },
  PVPLastUseCard = {
    ID = "PVPLastUseCard",
    CnID = "检索最后打出卡牌",
    BaseSortID = 1099,
    ApiType = "函数"
  },
  PVPEnemyLastUseCard = {
    ID = "PVPEnemyLastUseCard",
    CnID = "检索敌方最后打出卡牌",
    BaseSortID = 1100,
    ApiType = "函数"
  },
  PVPComa = {
    ID = "PVPComa",
    CnID = "昏迷",
    BaseSortID = 1101,
    ApiType = "角色属性"
  },
  PVPImmue_Coma = {
    ID = "PVPImmue_Coma",
    CnID = "免疫昏迷",
    BaseSortID = 1102,
    ApiType = "角色属性"
  },
  BSTRoleBeforeRebirth = {
    ID = "BSTRoleBeforeRebirth",
    CnID = "自身复活前",
    BaseSortID = 1103,
    ApiType = "触发器"
  },
  BSTRoleAfterRebirth = {
    ID = "BSTRoleAfterRebirth",
    CnID = "自身复活后",
    BaseSortID = 1104,
    ApiType = "触发器"
  },
  CurCamp = {
    ID = "CurCamp",
    CnID = "当前队伍",
    BaseSortID = 1105,
    ApiType = "参数"
  },
  CurCasterTeam = {
    ID = "CurCasterTeam",
    CnID = "获取当前行动队伍",
    BaseSortID = 1106,
    ApiType = "函数"
  },
  IsAwakerRound = {
    ID = "IsAwakerRound",
    CnID = "当前为玩家回合",
    BaseSortID = 1107,
    ApiType = "公式",
    Data = "CurCamp==1"
  },
  IsMonsterRound = {
    ID = "IsMonsterRound",
    CnID = "当前为怪物回合",
    BaseSortID = 1108,
    ApiType = "公式",
    Data = "CurCamp==2"
  },
  MineUseCard = {
    ID = "MineUseCard",
    CnID = "我方在使用卡牌",
    BaseSortID = 1109,
    ApiType = "公式",
    Data = "CurCard.TargetCmdOwner.UniqueID==StateOwner.UniqueID"
  },
  EnemyUseCard = {
    ID = "EnemyUseCard",
    CnID = "敌方在使用卡牌",
    BaseSortID = 1110,
    ApiType = "公式",
    Data = "CurCard.TargetCmdOwner.UniqueID~=StateOwner.UniqueID"
  },
  MineInRound = {
    ID = "MineInRound",
    CnID = "处于我方回合",
    BaseSortID = 1111,
    ApiType = "公式",
    Data = "CurCasterTeam==StateOwner.Camp"
  },
  EnemyInRound = {
    ID = "EnemyInRound",
    CnID = "处于敌方回合",
    BaseSortID = 1112,
    ApiType = "公式",
    Data = "CurCasterTeam~=StateOwner.Camp"
  },
  MyUseCard = {
    ID = "MyUseCard",
    CnID = "牌是我打的",
    BaseSortID = 1113,
    ApiType = "公式",
    Data = "CurCard.TargetCmdOwner==StateOwner"
  },
  NotMyUseCard = {
    ID = "NotMyUseCard",
    CnID = "牌不是我打的",
    BaseSortID = 1114,
    ApiType = "公式",
    Data = "CurCard.TargetCmdOwner~=StateOwner"
  },
  UseCardTypeStrike = {
    ID = "UseCardTypeStrike",
    CnID = "打的牌类型是打击",
    BaseSortID = 1115,
    ApiType = "公式",
    Data = "CurCard.Type==Card_Strike"
  },
  UseCardTypeSkill = {
    ID = "UseCardTypeSkill",
    CnID = "打的牌类型是技能",
    BaseSortID = 1116,
    ApiType = "公式",
    Data = "CurCard.Type==Card_Skill"
  },
  ["[Enemy]BSTBeforeAction"] = {
    ID = "[Enemy]BSTBeforeAction",
    CnID = "敌方行动前",
    BaseSortID = 1117,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterAction"] = {
    ID = "[Enemy]BSTAfterAction",
    CnID = "敌方行动后",
    BaseSortID = 1118,
    ApiType = "触发器"
  },
  ["[Enemy]BSTBeforeUseCard"] = {
    ID = "[Enemy]BSTBeforeUseCard",
    CnID = "敌方使用卡牌前",
    BaseSortID = 1119,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterUseCard"] = {
    ID = "[Enemy]BSTAfterUseCard",
    CnID = "敌方使用卡牌后",
    BaseSortID = 1120,
    ApiType = "触发器"
  },
  ["[Enemy]BSTBeforeUseCard.Card_Strike"] = {
    ID = "[Enemy]BSTBeforeUseCard.Card_Strike",
    CnID = "敌方使用打击牌前",
    BaseSortID = 1121,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterUseCard.Card_Strike"] = {
    ID = "[Enemy]BSTAfterUseCard.Card_Strike",
    CnID = "敌方使用打击牌后",
    BaseSortID = 1122,
    ApiType = "触发器"
  },
  ["[Enemy]BSTBeforeUseCard.Card_Defend"] = {
    ID = "[Enemy]BSTBeforeUseCard.Card_Defend",
    CnID = "敌方使用防御牌前",
    BaseSortID = 1123,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterUseCard.Card_Defend"] = {
    ID = "[Enemy]BSTAfterUseCard.Card_Defend",
    CnID = "敌方使用防御牌后",
    BaseSortID = 1124,
    ApiType = "触发器"
  },
  ["[Enemy]BSTBeforeUseCard.Card_Skill"] = {
    ID = "[Enemy]BSTBeforeUseCard.Card_Skill",
    CnID = "敌方使用技能牌前",
    BaseSortID = 1125,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterUseCard.Card_Skill"] = {
    ID = "[Enemy]BSTAfterUseCard.Card_Skill",
    CnID = "敌方使用技能牌后",
    BaseSortID = 1126,
    ApiType = "触发器"
  },
  ["[Enemy]BSTBeforeUltiSkill"] = {
    ID = "[Enemy]BSTBeforeUltiSkill",
    CnID = "敌方使用狂气爆发前",
    BaseSortID = 1127,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterUltiSkill"] = {
    ID = "[Enemy]BSTAfterUltiSkill",
    CnID = "敌方使用狂气爆发后",
    BaseSortID = 1128,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterDoActiveDamage"] = {
    ID = "[Enemy]BSTAfterDoActiveDamage",
    CnID = "敌方造成主动伤害后",
    BaseSortID = 1129,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterDoActiveDamage.Unblocked"] = {
    ID = "[Enemy]BSTAfterDoActiveDamage.Unblocked",
    CnID = "敌方造成未被完全格挡的主动伤害后",
    BaseSortID = 1130,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterDoHeal"] = {
    ID = "[Enemy]BSTAfterDoHeal",
    CnID = "敌方造成治疗后",
    BaseSortID = 1131,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterDoBlock"] = {
    ID = "[Enemy]BSTAfterDoBlock",
    CnID = "敌方造成护盾后",
    BaseSortID = 1132,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterDoUltiEnergy"] = {
    ID = "[Enemy]BSTAfterDoUltiEnergy",
    CnID = "敌方造成狂气后",
    BaseSortID = 1133,
    ApiType = "触发器"
  },
  ["[Enemy]BSTActiveDamageKill"] = {
    ID = "[Enemy]BSTActiveDamageKill",
    CnID = "敌方主动造成击杀后",
    BaseSortID = 1134,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterBeDamage"] = {
    ID = "[Enemy]BSTAfterBeDamage",
    CnID = "敌方受到伤害后",
    BaseSortID = 1135,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterBeActiveDamage"] = {
    ID = "[Enemy]BSTAfterBeActiveDamage",
    CnID = "敌方受到主动伤害后",
    BaseSortID = 1136,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterBeActiveDamage.Unblocked"] = {
    ID = "[Enemy]BSTAfterBeActiveDamage.Unblocked",
    CnID = "敌方受到未被完全格挡的主动伤害后",
    BaseSortID = 1137,
    ApiType = "触发器"
  },
  ["[Enemy]BSTHpChanged"] = {
    ID = "[Enemy]BSTHpChanged",
    CnID = "敌方生命变化后",
    BaseSortID = 1138,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterBeHeal"] = {
    ID = "[Enemy]BSTAfterBeHeal",
    CnID = "敌方受到治疗后",
    BaseSortID = 1139,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterBeBlock"] = {
    ID = "[Enemy]BSTAfterBeBlock",
    CnID = "敌方受到护盾后",
    BaseSortID = 1140,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterBeUltiEnergy"] = {
    ID = "[Enemy]BSTAfterBeUltiEnergy",
    CnID = "敌方受到狂气后",
    BaseSortID = 1141,
    ApiType = "触发器"
  },
  ["[Enemy]BSTRoleDrawCard"] = {
    ID = "[Enemy]BSTRoleDrawCard",
    CnID = "敌方抽一张卡牌后",
    BaseSortID = 1142,
    ApiType = "触发器"
  },
  ["[Enemy]BSTRoleDropCard"] = {
    ID = "[Enemy]BSTRoleDropCard",
    CnID = "敌方弃一张卡牌后",
    BaseSortID = 1143,
    ApiType = "触发器"
  },
  ["[Enemy]BSTDrawDeckReset"] = {
    ID = "[Enemy]BSTDrawDeckReset",
    CnID = "敌方抽牌堆重置后",
    BaseSortID = 1144,
    ApiType = "触发器"
  },
  ["[Enemy]BSTLeaveHandDeck"] = {
    ID = "[Enemy]BSTLeaveHandDeck",
    CnID = "敌方从手牌堆消失后",
    BaseSortID = 1145,
    ApiType = "触发器"
  },
  ["[Enemy]BSTEnterHandDeck"] = {
    ID = "[Enemy]BSTEnterHandDeck",
    CnID = "敌方进入手牌堆后",
    BaseSortID = 1146,
    ApiType = "触发器"
  },
  ["[Enemy]BSTBeforeBoutBegin"] = {
    ID = "[Enemy]BSTBeforeBoutBegin",
    CnID = "敌方回合开始前",
    BaseSortID = 1147,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterBoutBegin"] = {
    ID = "[Enemy]BSTAfterBoutBegin",
    CnID = "敌方回合开始后",
    BaseSortID = 1148,
    ApiType = "触发器"
  },
  ["[Enemy]BSTBeforeBoutEnd"] = {
    ID = "[Enemy]BSTBeforeBoutEnd",
    CnID = "敌方回合结束前",
    BaseSortID = 1149,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterBoutEnd"] = {
    ID = "[Enemy]BSTAfterBoutEnd",
    CnID = "敌方回合结束后",
    BaseSortID = 1150,
    ApiType = "触发器"
  },
  ["[Enemy]BSTBeforeDrawCards"] = {
    ID = "[Enemy]BSTBeforeDrawCards",
    CnID = "敌方抽牌阶段前",
    BaseSortID = 1151,
    ApiType = "触发器"
  },
  ["[Enemy]BSTAfterDrawCards"] = {
    ID = "[Enemy]BSTAfterDrawCards",
    CnID = "敌方抽牌阶段后",
    BaseSortID = 1152,
    ApiType = "触发器"
  },
  BSTAfterSelectInitCard = {
    ID = "BSTAfterSelectInitCard",
    CnID = "选牌结束后",
    BaseSortID = 1153,
    ApiType = "触发器"
  },
  WeaponState = {
    ID = "WeaponState",
    CnID = "命轮",
    BaseSortID = 1154,
    ApiType = "标记"
  },
  BERemoveAllTypeState = {
    ID = "BERemoveAllTypeState",
    CnID = "移除所有指定类型状态",
    BaseSortID = 1155,
    ApiType = "指令"
  },
  PotencySkillParam = {
    ID = "PotencySkillParam",
    CnID = "启灵表获取技能参数",
    BaseSortID = 1156,
    ApiType = "函数"
  },
  CurrentCmdTargetCount = {
    ID = "CurrentCmdTargetCount",
    CnID = "当前指令目标数量",
    BaseSortID = 1157,
    ApiType = "参数"
  },
  BEResetDrawDeckPVP = {
    ID = "BEResetDrawDeckPVP",
    CnID = "重置PVP牌库",
    BaseSortID = 1158,
    ApiType = "指令"
  },
  AvgCrit = {
    ID = "AvgCrit",
    CnID = "平均暴击率",
    BaseSortID = 1159,
    ApiType = "功能属性"
  },
  AvgCritDamage = {
    ID = "AvgCritDamage",
    CnID = "平均暴击伤害",
    BaseSortID = 1160,
    ApiType = "功能属性"
  },
  AvgPhysique = {
    ID = "AvgPhysique",
    CnID = "平均体质",
    BaseSortID = 1161,
    ApiType = "功能属性"
  },
  AvgDefence = {
    ID = "AvgDefence",
    CnID = "平均防御力",
    BaseSortID = 1162,
    ApiType = "功能属性"
  },
  GetAccountStageGrow = {
    ID = "GetAccountStageGrow",
    CnID = "获取玩家局内成长强度",
    BaseSortID = 1163,
    ApiType = "函数"
  },
  strike_card_target2select_enemy_alive_only = {
    ID = "strike_card_target2select_enemy_alive_only",
    CnID = "修改打击卡的目标类型为选择敌方",
    BaseSortID = 1164,
    ApiType = "唤醒体属性",
    Data = "SelectEnemy(AliveOnly)"
  },
  strike_card_target2select_random_enemy = {
    ID = "strike_card_target2select_random_enemy",
    CnID = "修改打击卡的目标类型为选择随机敌方",
    BaseSortID = 1165,
    ApiType = "唤醒体属性",
    Data = "RandomEnemy"
  },
  strike_card_target2select_all_enemy_alive_only = {
    ID = "strike_card_target2select_all_enemy_alive_only",
    CnID = "修改打击卡的目标类型为选择全体敌方",
    BaseSortID = 1166,
    ApiType = "唤醒体属性",
    Data = "SelectAllEnemy(AliveOnly)"
  },
  strike_card_target2max_hp_enemy = {
    ID = "strike_card_target2max_hp_enemy",
    CnID = "修改打击卡的目标类型为生命最高敌方",
    BaseSortID = 1167,
    ApiType = "唤醒体属性",
    Data = "MaxHpAndBlockEnemy"
  },
  strike_card_target2min_hp_enemy = {
    ID = "strike_card_target2min_hp_enemy",
    CnID = "修改打击卡的目标类型为生命最低敌方",
    BaseSortID = 1168,
    ApiType = "唤醒体属性",
    Data = "MinHpAndBlockEnemy"
  },
  strike_card_target2rear_enemy = {
    ID = "strike_card_target2rear_enemy",
    CnID = "修改打击卡的目标类型为后排敌方",
    BaseSortID = 1169,
    ApiType = "唤醒体属性",
    Data = "BackEnemy"
  },
  card_ban_target_change = {
    ID = "card_ban_target_change",
    CnID = "卡牌禁用修改打击卡的目标类型",
    BaseSortID = 1170,
    ApiType = "唤醒体属性",
    Data = "strike_card_target2select_enemy_alive_only,strike_card_target2select_random_enemy,strike_card_target2select_all_enemy_alive_only,strike_card_target2max_hp_enemy,strike_card_target2min_hp_enemy"
  },
  RemoveCardByID = {
    ID = "RemoveCardByID",
    CnID = "按中文索引从牌堆中排除卡牌",
    BaseSortID = 1171,
    ApiType = "函数"
  },
  RemoveCardByType = {
    ID = "RemoveCardByType",
    CnID = "从牌堆中按类型排除卡牌",
    BaseSortID = 1172,
    ApiType = "函数"
  },
  GetEquipWeapon = {
    ID = "GetEquipWeapon",
    CnID = "获取目标装备的命轮",
    BaseSortID = 1173,
    ApiType = "函数"
  },
  BEDisplayFloatingText = {
    ID = "BEDisplayFloatingText",
    CnID = "显示漂浮文字",
    BaseSortID = 1174,
    ApiType = "指令"
  },
  GetAllyTargetByPos = {
    ID = "GetAllyTargetByPos",
    CnID = "按位置获取友方唤醒体",
    BaseSortID = 1175,
    ApiType = "函数"
  },
  GetEnemyTargetByPos = {
    ID = "GetEnemyTargetByPos",
    CnID = "按位置获取敌方唤醒体",
    BaseSortID = 1176,
    ApiType = "函数"
  },
  TypePlayer = {
    ID = "TypePlayer",
    CnID = "玩家类型",
    BaseSortID = 1177,
    ApiType = "标记"
  },
  TypeCard = {
    ID = "TypeCard",
    CnID = "卡牌",
    BaseSortID = 1178,
    ApiType = "标记"
  },
  TypeAwaker = {
    ID = "TypeAwaker",
    CnID = "唤醒体",
    BaseSortID = 1179,
    ApiType = "标记"
  },
  TypeMonster = {
    ID = "TypeMonster",
    CnID = "怪物",
    BaseSortID = 1180,
    ApiType = "标记"
  },
  TargetType = {
    ID = "TargetType",
    CnID = "目标类型",
    BaseSortID = 1181,
    ApiType = "功能属性"
  },
  CardType = {
    ID = "CardType",
    CnID = "卡牌类型",
    BaseSortID = 1182,
    ApiType = "功能属性"
  },
  MonsterType = {
    ID = "MonsterType",
    CnID = "怪物类型",
    BaseSortID = 1183,
    ApiType = "功能属性"
  },
  MonsterCategory = {
    ID = "MonsterCategory",
    CnID = "怪物种类",
    BaseSortID = 1184,
    ApiType = "功能属性"
  },
  Wipe = {
    ID = "Wipe",
    CnID = "清除",
    BaseSortID = 1185,
    ApiType = "标记"
  },
  NonWipe_ProhibitTrigger = {
    ID = "NonWipe_ProhibitTrigger",
    CnID = "不清除不监听",
    BaseSortID = 1186,
    ApiType = "标记"
  },
  NonWipe_AllowTrigger = {
    ID = "NonWipe_AllowTrigger",
    CnID = "不清除会监听",
    BaseSortID = 1187,
    ApiType = "标记"
  },
  BEChangeMotion = {
    ID = "BEChangeMotion",
    CnID = "切换角色动作",
    BaseSortID = 1188,
    ApiType = "指令"
  },
  BERevertMotion = {
    ID = "BERevertMotion",
    CnID = "还原角色动作",
    BaseSortID = 1189,
    ApiType = "指令"
  },
  Forward = {
    ID = "Forward",
    CnID = "向前",
    BaseSortID = 1190,
    ApiType = "标记"
  },
  Backward = {
    ID = "Backward",
    CnID = "向后",
    BaseSortID = 1191,
    ApiType = "标记"
  },
  Motionless = {
    ID = "Motionless",
    CnID = "不动",
    BaseSortID = 1192,
    ApiType = "标记"
  },
  BECustomizedExecuteCmd = {
    ID = "BECustomizedExecuteCmd",
    CnID = "自定义执行指令",
    BaseSortID = 1193,
    ApiType = "指令"
  },
  BECustomizedSeparateExecuteCmd = {
    ID = "BECustomizedSeparateExecuteCmd",
    CnID = "自定义拆分执行指令",
    BaseSortID = 1194,
    ApiType = "指令"
  },
  EnemyCondition = {
    ID = "EnemyCondition",
    CnID = "敌方条件",
    BaseSortID = 1195,
    ApiType = "标记"
  },
  AllyCondition = {
    ID = "AllyCondition",
    CnID = "友方条件",
    BaseSortID = 1196,
    ApiType = "标记"
  },
  RandomCondition = {
    ID = "RandomCondition",
    CnID = "随机条件",
    BaseSortID = 1197,
    ApiType = "标记"
  },
  MinHpIncludingShieldsCondition = {
    ID = "MinHpIncludingShieldsCondition",
    CnID = "包含护盾生命最低条件",
    BaseSortID = 1198,
    ApiType = "标记"
  },
  MaxHpIncludingShieldsCondition = {
    ID = "MaxHpIncludingShieldsCondition",
    CnID = "包含护盾生命最高条件",
    BaseSortID = 1199,
    ApiType = "标记"
  },
  MinHpCondition = {
    ID = "MinHpCondition",
    CnID = "生命最低条件",
    BaseSortID = 1200,
    ApiType = "标记"
  },
  MaxHpCondition = {
    ID = "MaxHpCondition",
    CnID = "生命最高条件",
    BaseSortID = 1201,
    ApiType = "标记"
  },
  FrontCondition = {
    ID = "FrontCondition",
    CnID = "前排条件",
    BaseSortID = 1202,
    ApiType = "标记"
  },
  MaxUECondition = {
    ID = "MaxUECondition",
    CnID = "狂气最高条件",
    BaseSortID = 1203,
    ApiType = "标记"
  },
  MinUECondition = {
    ID = "MinUECondition",
    CnID = "狂气最低条件",
    BaseSortID = 1204,
    ApiType = "标记"
  },
  StateOwnerCondition = {
    ID = "StateOwnerCondition",
    CnID = "拥有状态目标条件",
    BaseSortID = 1205,
    ApiType = "标记"
  },
  BuffStateOwnerCondition = {
    ID = "BuffStateOwnerCondition",
    CnID = "正面状态条件",
    BaseSortID = 1206,
    ApiType = "标记"
  },
  DBuffStateOwnerCondition = {
    ID = "DBuffStateOwnerCondition",
    CnID = "负面状态条件",
    BaseSortID = 1207,
    ApiType = "标记"
  },
  pvp_death_resist = {
    ID = "pvp_death_resist",
    CnID = "免疫死亡",
    BaseSortID = 1208,
    ApiType = "唤醒体属性"
  },
  BSTAfterPVPDeathResist = {
    ID = "BSTAfterPVPDeathResist",
    CnID = "免疫死亡后",
    BaseSortID = 1209,
    ApiType = "触发器"
  },
  BEChangeKeeperSkill = {
    ID = "BEChangeKeeperSkill",
    CnID = "改变钥令",
    BaseSortID = 1210,
    ApiType = "指令"
  },
  SelectKeeperSkill = {
    ID = "SelectKeeperSkill",
    CnID = "选择钥令",
    BaseSortID = 1211,
    ApiType = "函数"
  },
  death_resist_coefficient_plus = {
    ID = "death_resist_coefficient_plus",
    CnID = "死亡抵抗衰减比例修正",
    BaseSortID = 1212,
    ApiType = "角色属性"
  },
  GetAwakerNormalUltiCost = {
    ID = "GetAwakerNormalUltiCost",
    CnID = "获取唤醒体基础狂气",
    BaseSortID = 1213,
    ApiType = "函数"
  },
  ulti_energy_cost_flat = {
    ID = "ulti_energy_cost_flat",
    CnID = "狂气爆发消耗固定值修正",
    BaseSortID = 1214,
    ApiType = "唤醒体属性"
  },
  ulti_energy_cost_per = {
    ID = "ulti_energy_cost_per",
    CnID = "狂气爆发消耗百分比修正",
    BaseSortID = 1215,
    ApiType = "唤醒体属性"
  },
  ulti_energy_max_per = {
    ID = "ulti_energy_max_per",
    CnID = "狂气存储上限百分比修正",
    BaseSortID = 1216,
    ApiType = "唤醒体属性"
  },
  keeper_energy_cost_per = {
    ID = "keeper_energy_cost_per",
    CnID = "钥令使用消耗百分比修正",
    BaseSortID = 1217,
    ApiType = "角色属性"
  },
  max_keeper_energy_per = {
    ID = "max_keeper_energy_per",
    CnID = "钥能存储上限百分比修正",
    BaseSortID = 1218,
    ApiType = "角色属性"
  },
  block_max_per = {
    ID = "block_max_per",
    CnID = "护盾上限百分比修正",
    BaseSortID = 1219,
    ApiType = "角色属性"
  },
  black_upgrade_plus = {
    ID = "black_upgrade_plus",
    CnID = "黑印掉落固定值修正",
    BaseSortID = 1220,
    ApiType = "角色属性"
  },
  GetCurDeathResistCoff = {
    ID = "GetCurDeathResistCoff",
    CnID = "获取玩家当前死亡抵抗系数",
    BaseSortID = 1221,
    ApiType = "函数"
  },
  be_damage_limit = {
    ID = "be_damage_limit",
    CnID = "最大承受伤害限制",
    BaseSortID = 1222,
    ApiType = "角色属性"
  },
  be_damage_statics = {
    ID = "be_damage_statics",
    CnID = "承受伤害统计",
    BaseSortID = 1223,
    ApiType = "角色属性"
  },
  be_state_layer_limit_posion = {
    ID = "be_state_layer_limit_posion",
    CnID = "最大承受中毒层数限制",
    BaseSortID = 1224,
    ApiType = "角色属性",
    Data = 3068
  },
  be_state_layer_limit_retaliate = {
    ID = "be_state_layer_limit_retaliate",
    CnID = "最大承受反击层数限制",
    BaseSortID = 1225,
    ApiType = "角色属性",
    Data = 3905
  },
  be_state_layer_statics_posion = {
    ID = "be_state_layer_statics_posion",
    CnID = "承受中毒层数统计",
    BaseSortID = 1226,
    ApiType = "角色属性"
  },
  be_state_layer_limit_posion_max = {
    ID = "be_state_layer_limit_posion_max",
    CnID = "承受中毒总层数限制",
    BaseSortID = 1227,
    ApiType = "角色属性",
    Data = 3068
  },
  be_state_layer_limit_retaliate_max = {
    ID = "be_state_layer_limit_retaliate_max",
    CnID = "承受反击总层数限制",
    BaseSortID = 1228,
    ApiType = "角色属性",
    Data = 3905
  },
  DeckSort = {
    ID = "DeckSort",
    CnID = "牌堆排序",
    BaseSortID = 1229,
    ApiType = "函数"
  },
  CreatetimeSort = {
    ID = "CreatetimeSort",
    CnID = "创建时间排序",
    BaseSortID = 1230,
    ApiType = "标记"
  },
  HandDeckSort = {
    ID = "HandDeckSort",
    CnID = "手牌堆排序",
    BaseSortID = 1231,
    ApiType = "标记"
  },
  UnorderedSort = {
    ID = "UnorderedSort",
    CnID = "乱序排序",
    BaseSortID = 1232,
    ApiType = "标记"
  },
  PositiveSort = {
    ID = "PositiveSort",
    CnID = "正序",
    BaseSortID = 1233,
    ApiType = "标记"
  },
  ReverseSort = {
    ID = "ReverseSort",
    CnID = "逆序",
    BaseSortID = 1234,
    ApiType = "标记"
  },
  CmdID = {
    ID = "CmdID",
    CnID = "指令ID",
    BaseSortID = 1235,
    ApiType = "功能属性"
  },
  BERunKeeperSkillCmd = {
    ID = "BERunKeeperSkillCmd",
    CnID = "释放钥令技能",
    BaseSortID = 1236,
    ApiType = "指令"
  },
  BSTAfterRunKeeperSkillCmd = {
    ID = "BSTAfterRunKeeperSkillCmd",
    CnID = "释放钥令指令后",
    BaseSortID = 1237,
    ApiType = "触发器"
  },
  BEChangeMonsterAnim = {
    ID = "BEChangeMonsterAnim",
    CnID = "切换怪物动画",
    BaseSortID = 1238,
    ApiType = "指令"
  },
  BERunTimeline = {
    ID = "BERunTimeline",
    CnID = "执行表演",
    BaseSortID = 1239,
    ApiType = "指令"
  },
  BETargetRunTimeline = {
    ID = "BETargetRunTimeline",
    CnID = "目标执行表演",
    BaseSortID = 1240,
    ApiType = "指令"
  },
  immue_puncture_damage = {
    ID = "immue_puncture_damage",
    CnID = "免疫穿刺伤害",
    BaseSortID = 1241,
    ApiType = "角色属性"
  },
  be_state_layer_per_exhaustion = {
    ID = "be_state_layer_per_exhaustion",
    CnID = "被施加衰竭层数百分比修正",
    BaseSortID = 1242,
    ApiType = "角色属性",
    Data = "2619,3902"
  },
  be_state_layer_per_bloodHp = {
    ID = "be_state_layer_per_bloodHp",
    CnID = "被施加熔炉回复百分比修正",
    BaseSortID = 1243,
    ApiType = "角色属性",
    Data = 35501
  },
  be_state_layer_per_posion = {
    ID = "be_state_layer_per_posion",
    CnID = "被施加中毒层数百分比修正",
    BaseSortID = 1244,
    ApiType = "角色属性",
    Data = 3068
  },
  be_state_layer_per_power = {
    ID = "be_state_layer_per_power",
    CnID = "被施加力量层数百分比修正",
    BaseSortID = 1245,
    ApiType = "角色属性",
    Data = 2900
  },
  BEResetDrawDeck = {
    ID = "BEResetDrawDeck",
    CnID = "重置抽牌堆",
    BaseSortID = 1246,
    ApiType = "指令"
  },
  BESetGlobalVariable = {
    ID = "BESetGlobalVariable",
    CnID = "设置全局变量",
    BaseSortID = 1247,
    ApiType = "指令"
  },
  BERemoveGlobalVariable = {
    ID = "BERemoveGlobalVariable",
    CnID = "清除全局变量",
    BaseSortID = 1248,
    ApiType = "指令"
  },
  GetGlobalVariable = {
    ID = "GetGlobalVariable",
    CnID = "获取全局变量",
    BaseSortID = 1249,
    ApiType = "函数"
  },
  relic_num_limit = {
    ID = "relic_num_limit",
    CnID = "造物数量上限",
    BaseSortID = 1250,
    ApiType = "角色属性"
  },
  ChineseMark1 = {
    ID = "ChineseMark1",
    CnID = "仲夏之梦中断判定",
    BaseSortID = 1251,
    ApiType = "标记"
  },
  ChineseMark2 = {
    ID = "ChineseMark2",
    CnID = "PVP奥尔拉SR命轮计数器",
    BaseSortID = 1252,
    ApiType = "标记"
  },
  ChineseMark3 = {
    ID = "ChineseMark3",
    CnID = "阿方索之器中断判定",
    BaseSortID = 1253,
    ApiType = "标记"
  },
  ChineseMark4 = {
    ID = "ChineseMark4",
    CnID = "活焰传导中断判定",
    BaseSortID = 1254,
    ApiType = "标记"
  },
  BSTAfterIntentionChanged = {
    ID = "BSTAfterIntentionChanged",
    CnID = "意图变化后",
    BaseSortID = 1255,
    ApiType = "触发器"
  },
  BSTAfterSwitchOceanModel = {
    ID = "BSTAfterSwitchOceanModel",
    CnID = "深海切换姿态后",
    BaseSortID = 1256,
    ApiType = "触发器"
  },
  BEPVERebirth = {
    ID = "BEPVERebirth",
    CnID = "PVE复活",
    BaseSortID = 1257,
    ApiType = "指令"
  },
  BECreateCardWithOwner = {
    ID = "BECreateCardWithOwner",
    CnID = "创造卡牌并改变归属",
    BaseSortID = 1258,
    ApiType = "指令"
  },
  BESetTempTargets = {
    ID = "BESetTempTargets",
    CnID = "设置临时目标",
    BaseSortID = 1259,
    ApiType = "指令"
  },
  TempTarget1 = {
    ID = "TempTarget1",
    CnID = "临时目标1",
    BaseSortID = 1260,
    ApiType = "目标"
  },
  TempTarget2 = {
    ID = "TempTarget2",
    CnID = "临时目标2",
    BaseSortID = 1261,
    ApiType = "目标"
  },
  TempTarget3 = {
    ID = "TempTarget3",
    CnID = "临时目标3",
    BaseSortID = 1262,
    ApiType = "目标"
  },
  TempTarget4 = {
    ID = "TempTarget4",
    CnID = "临时目标4",
    BaseSortID = 1263,
    ApiType = "目标"
  },
  TempTarget5 = {
    ID = "TempTarget5",
    CnID = "临时目标5",
    BaseSortID = 1264,
    ApiType = "目标"
  },
  BECopyTargetStates = {
    ID = "BECopyTargetStates",
    CnID = "复制状态",
    BaseSortID = 1265,
    ApiType = "指令"
  },
  AllAlly_IncludeDeath = {
    ID = "AllAlly_IncludeDeath",
    CnID = "全体友方包括死亡",
    BaseSortID = 1266,
    ApiType = "目标"
  },
  AllEnemy_IncludeDeath = {
    ID = "AllEnemy_IncludeDeath",
    CnID = "全体敌方包括死亡",
    BaseSortID = 1267,
    ApiType = "目标"
  },
  RandomEnemy_IncludeDeath = {
    ID = "RandomEnemy_IncludeDeath",
    CnID = "随机敌方包括死亡",
    BaseSortID = 1268,
    ApiType = "目标"
  },
  RandomAlly_IncludeDeath = {
    ID = "RandomAlly_IncludeDeath",
    CnID = "随机友方包括死亡",
    BaseSortID = 1269,
    ApiType = "目标"
  },
  OtherAlly_IncludeDeath = {
    ID = "OtherAlly_IncludeDeath",
    CnID = "其他友方包括死亡",
    BaseSortID = 1270,
    ApiType = "目标"
  },
  DefaultTarget = {
    ID = "DefaultTarget",
    CnID = "默认目标",
    BaseSortID = 1271,
    ApiType = "目标"
  },
  BEEnemyDrawCards = {
    ID = "BEEnemyDrawCards",
    CnID = "敌方抽牌",
    BaseSortID = 1272,
    ApiType = "指令"
  },
  GetAwakerByProperty = {
    ID = "GetAwakerByProperty",
    CnID = "按属性获取唤醒体",
    BaseSortID = 1273,
    ApiType = "函数"
  },
  BSTAfterRoleDie = {
    ID = "BSTAfterRoleDie",
    CnID = "角色死亡后",
    BaseSortID = 1274,
    ApiType = "触发器"
  },
  BSTAfterRoleRespawn = {
    ID = "BSTAfterRoleRespawn",
    CnID = "角色复活后",
    BaseSortID = 1275,
    ApiType = "触发器"
  },
  BSTBeforeRoleDie = {
    ID = "BSTBeforeRoleDie",
    CnID = "角色死亡前",
    BaseSortID = 1276,
    ApiType = "触发器"
  },
  BSTBeforeRoleRespawn = {
    ID = "BSTBeforeRoleRespawn",
    CnID = "角色复活前",
    BaseSortID = 1277,
    ApiType = "触发器"
  },
  slot = {
    ID = "slot",
    CnID = "技能槽位",
    BaseSortID = 1278,
    ApiType = "卡牌属性"
  },
  ban_pvp_weapon = {
    ID = "ban_pvp_weapon",
    CnID = "缠绕",
    BaseSortID = 1279,
    ApiType = "角色属性"
  },
  BSTAfterBanWeapon = {
    ID = "BSTAfterBanWeapon",
    CnID = "自身受到缠绕后",
    BaseSortID = 1280,
    ApiType = "触发器"
  },
  BSTAfterLoseBanWeapon = {
    ID = "BSTAfterLoseBanWeapon",
    CnID = "自身失去缠绕后",
    BaseSortID = 1281,
    ApiType = "触发器"
  },
  BSTStateOnRemove = {
    ID = "BSTStateOnRemove",
    CnID = "任意方式失去当前状态后",
    BaseSortID = 1282,
    ApiType = "触发器"
  },
  ["BSTStateOnRemove.CantBan"] = {
    ID = "BSTStateOnRemove.CantBan",
    CnID = "任意方式失去当前状态后无视缠绕版",
    BaseSortID = 1283,
    ApiType = "触发器"
  },
  ["BSTAfterRoleDie.CantBan"] = {
    ID = "BSTAfterRoleDie.CantBan",
    CnID = "角色死亡后无视缠绕版",
    BaseSortID = 1284,
    ApiType = "触发器"
  },
  BanPVPWeaponTrigger = {
    ID = "BanPVPWeaponTrigger",
    CnID = "缠绕时可触发的监听条件",
    BaseSortID = 1285,
    ApiType = "标记",
    Data = "BSTAfterBanWeapon,BSTAfterLoseBanWeapon,BSTStateOnRemove.CantBan,BSTAfterRoleDie.CantBan"
  },
  PlayerRoleEnemy = {
    ID = "PlayerRoleEnemy",
    CnID = "敌方玩家",
    BaseSortID = 1286,
    ApiType = "目标"
  },
  BERunCardCmdWithTarget = {
    ID = "BERunCardCmdWithTarget",
    CnID = "对目标释放卡牌技能",
    BaseSortID = 1287,
    ApiType = "指令"
  },
  BEHpRemove = {
    ID = "BEHpRemove",
    CnID = "造成生命移除",
    BaseSortID = 1288,
    ApiType = "指令"
  },
  BEChangeCardWithOwner = {
    ID = "BEChangeCardWithOwner",
    CnID = "变化卡牌并改变归属",
    BaseSortID = 1289,
    ApiType = "指令"
  },
  BEChangeCardOwner = {
    ID = "BEChangeCardOwner",
    CnID = "改变卡牌归属",
    BaseSortID = 1290,
    ApiType = "指令"
  },
  BEChangeCardAnimation = {
    ID = "BEChangeCardAnimation",
    CnID = "改变卡牌表演",
    BaseSortID = 1291,
    ApiType = "指令"
  },
  AllyAwaker = {
    ID = "AllyAwaker",
    CnID = "友方",
    BaseSortID = 1292,
    ApiType = "标记"
  },
  EnemyAwaker = {
    ID = "EnemyAwaker",
    CnID = "敌方",
    BaseSortID = 1293,
    ApiType = "标记"
  },
  MaxProperty = {
    ID = "MaxProperty",
    CnID = "最高",
    BaseSortID = 1294,
    ApiType = "标记"
  },
  MinProperty = {
    ID = "MinProperty",
    CnID = "最低",
    BaseSortID = 1295,
    ApiType = "标记"
  },
  Addition = {
    ID = "Addition",
    CnID = "加法",
    BaseSortID = 1296,
    ApiType = "标记"
  },
  Subtraction = {
    ID = "Subtraction",
    CnID = "减法",
    BaseSortID = 1297,
    ApiType = "标记"
  },
  UseDmgFormula = {
    ID = "UseDmgFormula",
    CnID = "使用伤害公式",
    BaseSortID = 1298,
    ApiType = "标记"
  },
  UseHealFormula = {
    ID = "UseHealFormula",
    CnID = "使用治疗公式",
    BaseSortID = 1299,
    ApiType = "标记"
  },
  UseBlockFormula = {
    ID = "UseBlockFormula",
    CnID = "使用护盾公式",
    BaseSortID = 1300,
    ApiType = "标记"
  },
  UseUltiEneFormula = {
    ID = "UseUltiEneFormula",
    CnID = "使用狂气公式",
    BaseSortID = 1301,
    ApiType = "标记"
  },
  UsePoisonFormula = {
    ID = "UsePoisonFormula",
    CnID = "使用中毒公式",
    BaseSortID = 1302,
    ApiType = "标记"
  },
  UsePowerFormula = {
    ID = "UsePowerFormula",
    CnID = "使用力量公式",
    BaseSortID = 1303,
    ApiType = "标记"
  },
  UseTentacleFormula = {
    ID = "UseTentacleFormula",
    CnID = "使用触伤公式",
    BaseSortID = 1304,
    ApiType = "标记"
  },
  UseCounterattackFormula = {
    ID = "UseCounterattackFormula",
    CnID = "使用反击公式",
    BaseSortID = 1305,
    ApiType = "标记"
  },
  UseFateCutFormula = {
    ID = "UseFateCutFormula",
    CnID = "使用裁断公式",
    BaseSortID = 1306,
    ApiType = "标记"
  },
  UseExhaustionFormula = {
    ID = "UseExhaustionFormula",
    CnID = "使用衰竭公式",
    BaseSortID = 1307,
    ApiType = "标记"
  },
  UseCorrosionFormula = {
    ID = "UseCorrosionFormula",
    CnID = "使用侵蚀公式",
    BaseSortID = 1308,
    ApiType = "标记"
  },
  BEAddStateByFormula = {
    ID = "BEAddStateByFormula",
    CnID = "按公式添加状态",
    BaseSortID = 1309,
    ApiType = "指令"
  },
  GetAwakerList = {
    ID = "GetAwakerList",
    CnID = "获取唤醒体列表",
    BaseSortID = 1310,
    ApiType = "函数"
  },
  TargetCount = {
    ID = "TargetCount",
    CnID = "目标数量",
    BaseSortID = 1311,
    ApiType = "功能属性"
  },
  BSTAfterAwakerCardJoinHandDeck = {
    ID = "BSTAfterAwakerCardJoinHandDeck",
    CnID = "角色卡牌进入手牌堆后",
    BaseSortID = 1312,
    ApiType = "触发器"
  },
  BEResetKeeperSkillCD = {
    ID = "BEResetKeeperSkillCD",
    CnID = "重置钥令CD",
    BaseSortID = 1313,
    ApiType = "指令"
  },
  UnlockedKeeperSkillNum = {
    ID = "UnlockedKeeperSkillNum",
    CnID = "玩家已拥有钥令种类数量",
    BaseSortID = 1314,
    ApiType = "参数"
  },
  GetKeeperSkillByID = {
    ID = "GetKeeperSkillByID",
    CnID = "按中文索引获取钥令",
    BaseSortID = 1315,
    ApiType = "函数"
  },
  GetKeeperSkillBycarry = {
    ID = "GetKeeperSkillBycarry",
    CnID = "获取携带的钥令",
    BaseSortID = 1316,
    ApiType = "目标"
  },
  RemoveByUniqueID = {
    ID = "RemoveByUniqueID",
    CnID = "目标排除",
    BaseSortID = 1317,
    ApiType = "函数"
  },
  C0501Position1 = {
    ID = "C0501Position1",
    CnID = "海中之物位置标记1",
    BaseSortID = 1318,
    ApiType = "角色属性"
  },
  C0501Position2 = {
    ID = "C0501Position2",
    CnID = "海中之物位置标记2",
    BaseSortID = 1319,
    ApiType = "角色属性"
  },
  C0501Position = {
    ID = "C0501Position",
    CnID = "海中之物位置标记",
    BaseSortID = 1320,
    ApiType = "角色属性"
  },
  GetLikeLevel = {
    ID = "GetLikeLevel",
    CnID = "获取同调率等级",
    BaseSortID = 1321,
    ApiType = "函数"
  },
  gain_like_level_fix_per = {
    ID = "gain_like_level_fix_per",
    CnID = "获取同调率百分比修正",
    BaseSortID = 1322,
    ApiType = "唤醒体属性"
  },
  EmbryoCard = {
    ID = "EmbryoCard",
    CnID = "吞噬胚胎",
    BaseSortID = 1323,
    ApiType = "标记",
    Data = 4052
  },
  EmbryoCardDouble = {
    ID = "EmbryoCardDouble",
    CnID = "吞噬圣洁之子",
    BaseSortID = 1324,
    ApiType = "标记",
    Data = 48812
  },
  AfterUnlockAwaker = {
    ID = "AfterUnlockAwaker",
    CnID = "解锁灵知觉醒后",
    BaseSortID = 1325,
    ApiType = "触发器"
  },
  crit_per = {
    ID = "crit_per",
    CnID = "暴击率百分比修正",
    BaseSortID = 1326,
    ApiType = "唤醒体属性"
  },
  crit_damage_per = {
    ID = "crit_damage_per",
    CnID = "暴击伤害百分比修正",
    BaseSortID = 1327,
    ApiType = "唤醒体属性"
  },
  i_crit_per = {
    ID = "i_crit_per",
    CnID = "局内施加暴击率百分比修正",
    BaseSortID = 1328,
    ApiType = "角色属性"
  },
  i_crit_damage_per = {
    ID = "i_crit_damage_per",
    CnID = "局内施加暴击伤害百分比修正",
    BaseSortID = 1329,
    ApiType = "角色属性"
  },
  posion_layer_rate_from_active_dmg = {
    ID = "posion_layer_rate_from_active_dmg",
    CnID = "根据伤害施加中毒百分比修正",
    BaseSortID = 1330,
    ApiType = "唤醒体属性",
    Data = 3068
  },
  counterattack_layer_rate_from_active_dmg = {
    ID = "counterattack_layer_rate_from_active_dmg",
    CnID = "根据伤害施加反击百分比修正",
    BaseSortID = 1331,
    ApiType = "唤醒体属性"
  },
  IsOutofStage = {
    ID = "IsOutofStage",
    CnID = "关卡外",
    BaseSortID = 1332,
    ApiType = "参数"
  },
  IsInStage = {
    ID = "IsInStage",
    CnID = "关卡内",
    BaseSortID = 1333,
    ApiType = "参数"
  },
  IsInBattle = {
    ID = "IsInBattle",
    CnID = "战斗中",
    BaseSortID = 1334,
    ApiType = "参数"
  },
  IsSuperUtlSkill = {
    ID = "IsSuperUtlSkill",
    CnID = "当前行动是超限爆发",
    BaseSortID = 1335,
    ApiType = "函数"
  },
  thisSkillIgnoreCost = {
    ID = "thisSkillIgnoreCost",
    CnID = "此技能忽略消耗",
    BaseSortID = 1336,
    ApiType = "函数"
  },
  GetShowPoison = {
    ID = "GetShowPoison",
    CnID = "本指令中毒公式结果",
    BaseSortID = 1337,
    ApiType = "函数"
  },
  GetShowCounterattack = {
    ID = "GetShowCounterattack",
    CnID = "本指令反击公式结果",
    BaseSortID = 1338,
    ApiType = "函数"
  },
  Select_intention = {
    ID = "Select_intention",
    CnID = "选择意象卡",
    BaseSortID = 1339,
    ApiType = "函数"
  },
  Intention_merge = {
    ID = "Intention_merge",
    CnID = "奥尔拉活动专用合成卡牌",
    BaseSortID = 1340,
    ApiType = "指令"
  },
  card_crit = {
    ID = "card_crit",
    CnID = "唤醒体卡牌暴击率",
    BaseSortID = 1341,
    ApiType = "唤醒体属性"
  },
  card_crit_damage = {
    ID = "card_crit_damage",
    CnID = "唤醒体卡牌暴击伤害",
    BaseSortID = 1342,
    ApiType = "唤醒体属性"
  },
  bout_dskill_use_times = {
    ID = "bout_dskill_use_times",
    CnID = "超维量表黑洞使用次数",
    BaseSortID = 1343,
    ApiType = "角色属性"
  },
  BELaikeRelic = {
    ID = "BELaikeRelic",
    CnID = "莱克专属局内选择升级造物",
    BaseSortID = 1344,
    ApiType = "指令"
  },
  LaikeRelic = {
    ID = "LaikeRelic",
    CnID = "莱克专属结束选择造物",
    BaseSortID = 1345,
    ApiType = "目标"
  },
  allowIgnoreCost = {
    ID = "allowIgnoreCost",
    CnID = "是否忽略消耗",
    BaseSortID = 1346,
    ApiType = "功能属性"
  },
  EnchantCard = {
    ID = "EnchantCard",
    CnID = "刻印卡牌",
    BaseSortID = 1347,
    ApiType = "函数"
  },
  MultipleHit = {
    ID = "MultipleHit",
    CnID = "多重打击",
    BaseSortID = 1348,
    ApiType = "唤醒体属性"
  },
  GetCardListByProperty = {
    ID = "GetCardListByProperty",
    CnID = "按属性获取卡牌列表",
    BaseSortID = 1349,
    ApiType = "函数"
  },
  GetCardListByState = {
    ID = "GetCardListByState",
    CnID = "按状态获取卡牌列表",
    BaseSortID = 1350,
    ApiType = "函数"
  },
  GetAwakerNumByState = {
    ID = "GetAwakerNumByState",
    CnID = "按状态获取唤醒体数量",
    BaseSortID = 1351,
    ApiType = "函数"
  },
  BEChangeMonsterName = {
    ID = "BEChangeMonsterName",
    CnID = "改变怪物名称",
    BaseSortID = 1352,
    ApiType = "指令"
  },
  AtkForce = {
    ID = "AtkForce",
    CnID = "获取攻击强度",
    BaseSortID = 1353,
    ApiType = "功能属性"
  },
  DefForce = {
    ID = "DefForce",
    CnID = "获取防御强度",
    BaseSortID = 1354,
    ApiType = "功能属性"
  },
  GetCardByDrop = {
    ID = "GetCardByDrop",
    CnID = "按掉落包获取卡牌",
    BaseSortID = 1355,
    ApiType = "函数"
  },
  BEBattleWin = {
    ID = "BEBattleWin",
    CnID = "战斗胜利",
    BaseSortID = 1356,
    ApiType = "指令"
  },
  BECopyWorldFinish = {
    ID = "BECopyWorldFinish",
    CnID = "副本胜利通关",
    BaseSortID = 1357,
    ApiType = "指令"
  },
  BEChangeMonsterHpNum = {
    ID = "BEChangeMonsterHpNum",
    CnID = "改变怪物复活次数",
    BaseSortID = 1358,
    ApiType = "指令"
  },
  dimension_fix_per = {
    ID = "dimension_fix_per",
    CnID = "超维混编效果修正",
    BaseSortID = 1359,
    ApiType = "角色属性"
  },
  BloodAbilityCond = {
    ID = "BloodAbilityCond",
    CnID = "血肉熔炉条件",
    BaseSortID = 1360,
    ApiType = "公式",
    Data = "PlayerRole.GetStateLayer(80399)==0"
  },
  DimensionAbilityCond = {
    ID = "DimensionAbilityCond",
    CnID = "超维黑洞条件",
    BaseSortID = 1361,
    ApiType = "公式",
    Data = "PlayerRole.GetStateLayer(80398)==0"
  },
  dimensionSpace = {
    ID = "dimensionSpace",
    CnID = "超维空间判断",
    BaseSortID = 1362,
    ApiType = "公式",
    Data = "PlayerRole.GetStateLayer(80426)==0"
  },
  dimensionSpaceState = {
    ID = "dimensionSpaceState",
    CnID = "超维空间状态",
    BaseSortID = 1363,
    ApiType = "公式",
    Data = "PlayerRole.GetStateLayer(80644)>0"
  },
  BEImplementDimensionSpace = {
    ID = "BEImplementDimensionSpace",
    CnID = "发动超维空间",
    BaseSortID = 1364,
    ApiType = "指令"
  },
  BloodAbilityCD = {
    ID = "BloodAbilityCD",
    CnID = "血肉熔炉冷却回合数",
    BaseSortID = 1365,
    ApiType = "公式",
    Data = "PlayerRole.GetStateLayer(80399)"
  },
  DimensionAbilityCD = {
    ID = "DimensionAbilityCD",
    CnID = "超维黑洞冷却回合数",
    BaseSortID = 1366,
    ApiType = "公式",
    Data = "PlayerRole.GetStateLayer(80398)"
  },
  card_state_layer_per_exhaustion = {
    ID = "card_state_layer_per_exhaustion",
    CnID = "本卡牌施加衰竭最终百分比修正1",
    BaseSortID = 1367,
    ApiType = "卡牌属性",
    Data = "3902,2619"
  },
  card_state_layer_per_power = {
    ID = "card_state_layer_per_power",
    CnID = "本卡牌施加力量最终百分比修正1",
    BaseSortID = 1368,
    ApiType = "卡牌属性",
    Data = "2900,3130"
  },
  BSTAfterUseDimensionSkill = {
    ID = "BSTAfterUseDimensionSkill",
    CnID = "使用湮灭后",
    BaseSortID = 1369,
    ApiType = "触发器"
  },
  BSTAfterUseBloodRecoverSkill = {
    ID = "BSTAfterUseBloodRecoverSkill",
    CnID = "使用猩红熔炉后",
    BaseSortID = 1370,
    ApiType = "触发器"
  },
  BSTBeforeUseSpecialDimension = {
    ID = "BSTBeforeUseSpecialDimension",
    CnID = "发动超维空间前",
    BaseSortID = 1371,
    ApiType = "触发器"
  },
  BSTAfterUseSpecialDimension = {
    ID = "BSTAfterUseSpecialDimension",
    CnID = "发动超维空间后",
    BaseSortID = 1372,
    ApiType = "触发器"
  },
  outside_crit = {
    ID = "outside_crit",
    CnID = "局外队伍平均暴击率",
    BaseSortID = 1373,
    ApiType = "功能属性"
  },
  outside_crit_damage = {
    ID = "outside_crit_damage",
    CnID = "局外队伍平均暴击伤害",
    BaseSortID = 1374,
    ApiType = "功能属性"
  },
  rivive_popup = {
    ID = "rivive_popup",
    CnID = "是否复活飘字",
    BaseSortID = 1375,
    ApiType = "角色属性"
  },
  o_state_layer_per_tentacle_dmg = {
    ID = "o_state_layer_per_tentacle_dmg",
    CnID = "施加触腕伤害基础效果百分比修正",
    BaseSortID = 1376,
    ApiType = "唤醒体属性",
    Data = "3897,2924,134310"
  },
  StarLevel = {
    ID = "StarLevel",
    CnID = "星级",
    BaseSortID = 1377,
    ApiType = "唤醒体属性"
  },
  UpgradeStarLevel = {
    ID = "UpgradeStarLevel",
    CnID = "提升星级",
    BaseSortID = 1378,
    ApiType = "指令"
  },
  GetAwakerListByStarLevelNotMaxed = {
    ID = "GetAwakerListByStarLevelNotMaxed",
    CnID = "获取未升满星级的唤醒体",
    BaseSortID = 1379,
    ApiType = "全局函数"
  },
  GetAwakerListByStarLevel = {
    ID = "GetAwakerListByStarLevel",
    CnID = "按星级获取唤醒体",
    BaseSortID = 1380,
    ApiType = "全局函数"
  },
  GetSumOfStarLevel = {
    ID = "GetSumOfStarLevel",
    CnID = "获取星级总和",
    BaseSortID = 1381,
    ApiType = "全局函数"
  },
  GetAwakerIDListByRandomOpenedAwaker = {
    ID = "GetAwakerIDListByRandomOpenedAwaker",
    CnID = "随机获取已开放唤醒体",
    BaseSortID = 1382,
    ApiType = "全局函数"
  },
  ChangeAwaker = {
    ID = "ChangeAwaker",
    CnID = "替换唤醒体",
    BaseSortID = 1383,
    ApiType = "指令"
  },
  BSTAChangeAwaker = {
    ID = "BSTAChangeAwaker",
    CnID = "替换唤醒体后",
    BaseSortID = 1384,
    ApiType = "角色监听"
  },
  SwitchSpireMap = {
    ID = "SwitchSpireMap",
    CnID = "切换尖塔地图",
    BaseSortID = 1385,
    ApiType = "指令"
  },
  GetSpireModeVictoryCount = {
    ID = "GetSpireModeVictoryCount",
    CnID = "获取尖塔模式胜利次数",
    BaseSortID = 1386,
    ApiType = "全局函数"
  },
  FinaleMod = {
    ID = "FinaleMod",
    CnID = "终幕模式",
    BaseSortID = 1387,
    ApiType = "关卡属性"
  },
  EnableFinaleMod = {
    ID = "EnableFinaleMod",
    CnID = "启用终幕模式",
    BaseSortID = 1388,
    ApiType = "指令"
  },
  GetCurrentRow = {
    ID = "GetCurrentRow",
    CnID = "获取当前行",
    BaseSortID = 1389,
    ApiType = "全局函数"
  },
  OnTheMap = {
    ID = "OnTheMap",
    CnID = "当前处于地图",
    BaseSortID = 1390,
    ApiType = "全局函数"
  },
  CallEvent = {
    ID = "CallEvent",
    CnID = "弹出事件",
    BaseSortID = 1391,
    ApiType = "指令"
  },
  SavesAccountData = {
    ID = "SavesAccountData",
    CnID = "保存账号数据",
    BaseSortID = 1392,
    ApiType = "指令"
  },
  LoadAccountData = {
    ID = "LoadAccountData",
    CnID = "读取账号数据",
    BaseSortID = 1393,
    ApiType = "指令"
  },
  GetAllMonsterDamageCount = {
    ID = "GetAllMonsterDamageCount",
    CnID = "全体怪物攻击次数",
    BaseSortID = 1394,
    ApiType = "函数"
  },
  GetAllMonsterDamageValue = {
    ID = "GetAllMonsterDamageValue",
    CnID = "全体怪物攻击伤害",
    BaseSortID = 1395,
    ApiType = "函数"
  },
  BSTAfterAnyCardJoinHandDeck = {
    ID = "BSTAfterAnyCardJoinHandDeck",
    CnID = "任意卡牌进入手牌堆后",
    BaseSortID = 1396,
    ApiType = "触发器"
  },
  BEAttachPostAction = {
    ID = "BEAttachPostAction",
    CnID = "追加后置行动",
    BaseSortID = 1397,
    ApiType = "指令"
  },
  RandomTarget = {
    ID = "RandomTarget",
    CnID = "随机获取目标",
    BaseSortID = 1398,
    ApiType = "函数"
  },
  max_monster_hp_num = {
    ID = "max_monster_hp_num",
    CnID = "怪物最大复活次数",
    BaseSortID = 1399,
    ApiType = "角色属性"
  },
  monster_hp_num = {
    ID = "monster_hp_num",
    CnID = "怪物当前复活次数",
    BaseSortID = 1400,
    ApiType = "角色属性"
  },
  InstanceTriggerSpecificResonance = {
    ID = "InstanceTriggerSpecificResonance",
    CnID = "此副本激活指定共鸣组",
    BaseSortID = 1401,
    ApiType = "指令"
  },
  InstanceSuppressSpecificResonance = {
    ID = "InstanceSuppressSpecificResonance",
    CnID = "此副本屏蔽指定共鸣组",
    BaseSortID = 1402,
    ApiType = "指令"
  },
  UseExtendedCreationBar = {
    ID = "UseExtendedCreationBar",
    CnID = "使用更大的造物栏",
    BaseSortID = 1403,
    ApiType = "指令"
  },
  ExtendedCreationLimit = {
    ID = "ExtendedCreationLimit",
    CnID = "更高的造物上限",
    BaseSortID = 1404,
    ApiType = "角色属性"
  },
  RestoreDeathResist = {
    ID = "RestoreDeathResist",
    CnID = "恢复衰减的死亡抵抗",
    BaseSortID = 1405,
    ApiType = "指令"
  },
  ModifyGrowthStrength = {
    ID = "ModifyGrowthStrength",
    CnID = "成长强度",
    BaseSortID = 1406,
    ApiType = "角色属性"
  },
  PlayerGrowth = {
    ID = "PlayerGrowth",
    CnID = "玩家成长强度",
    BaseSortID = 1407,
    ApiType = "公式",
    Data = "GetAccountStageGrow()*(1+Archivenotch()*0.01)"
  },
  InsightResearchDepth = {
    ID = "InsightResearchDepth",
    CnID = "灵识研究深度",
    BaseSortID = 1408,
    ApiType = "公式",
    Data = "GetAccountStageGrow()*SpiritResearchDepthMultiplier"
  },
  SpiritResearchDepthMultiplier = {
    ID = "SpiritResearchDepthMultiplier",
    CnID = "灵识研究深度倍率",
    BaseSortID = 1409,
    ApiType = "公式",
    Data = "(1+PlayerRole.GetStateLayer(129876)*0.01)*(GetAccountDamagePower()/100)*(1+Archivenotch()*0.01)"
  },
  Archivenotch = {
    ID = "Archivenotch",
    CnID = "归档刻痕",
    BaseSortID = 1410,
    ApiType = "函数"
  },
  InsightDepthGain = {
    ID = "InsightDepthGain",
    CnID = "灵识研究深度效果",
    BaseSortID = 1411,
    ApiType = "角色属性"
  },
  be_change_hp_limit = {
    ID = "be_change_hp_limit",
    CnID = "最大失去生命限制",
    BaseSortID = 1412,
    ApiType = "角色属性"
  },
  immue_change_hp = {
    ID = "immue_change_hp",
    CnID = "免疫失去生命",
    BaseSortID = 1413,
    ApiType = "角色属性"
  },
  GetMonsterIntention = {
    ID = "GetMonsterIntention",
    CnID = "获取怪物意图",
    BaseSortID = 1414,
    ApiType = "函数"
  },
  GetSpecialSchoolAwakerNum = {
    ID = "GetSpecialSchoolAwakerNum",
    CnID = "判断当前新职业唤醒体数量",
    BaseSortID = 1415,
    ApiType = "函数"
  },
  SetOps = {
    ID = "SetOps",
    CnID = "集合运算",
    BaseSortID = 1416,
    ApiType = "函数"
  },
  SetOpsArg1 = {
    ID = "SetOpsArg1",
    CnID = "并集",
    BaseSortID = 1417,
    ApiType = "公式",
    Data = 1
  },
  SetOpsArg2 = {
    ID = "SetOpsArg2",
    CnID = "交集",
    BaseSortID = 1418,
    ApiType = "公式",
    Data = 2
  },
  SetOpsArg3 = {
    ID = "SetOpsArg3",
    CnID = "差集",
    BaseSortID = 1419,
    ApiType = "公式",
    Data = 3
  },
  SetOpsArg4 = {
    ID = "SetOpsArg4",
    CnID = "对称差",
    BaseSortID = 1420,
    ApiType = "公式",
    Data = 4
  },
  statistic_state_concept_list = {
    ID = "statistic_state_concept_list",
    CnID = "统计_概念大类_状态",
    BaseSortID = 1421,
    ApiType = "标记",
    Data = "statistic_state_concept_power,statistic_state_concept_counterattack,statistic_state_concept_poison,statistic_state_concept_bleed,statistic_state_concept_sacrifice,statistic_state_concept_system,statistic_state_concept_corrosion,statistic_state_concept_FinalVerdict"
  },
  statistic_state_concept_power = {
    ID = "statistic_state_concept_power",
    CnID = "统计_概念小类_力量",
    BaseSortID = 1422,
    ApiType = "标记",
    Data = "{2900, 3130}"
  },
  statistic_state_concept_counterattack = {
    ID = "statistic_state_concept_counterattack",
    CnID = "统计_概念小类_反击",
    BaseSortID = 1423,
    ApiType = "标记",
    Data = "{3905, 3023}"
  },
  statistic_state_concept_poison = {
    ID = "statistic_state_concept_poison",
    CnID = "统计_概念小类_中毒",
    BaseSortID = 1424,
    ApiType = "标记",
    Data = "{3068}"
  },
  statistic_state_concept_bleed = {
    ID = "statistic_state_concept_bleed",
    CnID = "统计_概念小类_出血",
    BaseSortID = 1425,
    ApiType = "标记",
    Data = "{2840}"
  },
  statistic_state_concept_sacrifice = {
    ID = "statistic_state_concept_sacrifice",
    CnID = "统计_概念小类_献祭",
    BaseSortID = 1426,
    ApiType = "标记",
    Data = "{36014}"
  },
  statistic_state_concept_corrosion = {
    ID = "statistic_state_concept_corrosion",
    CnID = "统计_概念小类_侵蚀",
    BaseSortID = 1427,
    ApiType = "标记",
    Data = "{90059}"
  },
  statistic_state_concept_FinalVerdict = {
    ID = "statistic_state_concept_FinalVerdict",
    CnID = "统计_概念小类_命运裁断",
    BaseSortID = 1428,
    ApiType = "标记",
    Data = "{134285}"
  },
  statistic_state_concept_system = {
    ID = "statistic_state_concept_system",
    CnID = "统计_概念小类_规则容器",
    BaseSortID = 1429,
    ApiType = "标记",
    Data = "{81028,126780,126779,78098,81349,81489,83805}"
  },
  BEForceExecSkill = {
    ID = "BEForceExecSkill",
    CnID = "强制行动",
    BaseSortID = 1430,
    ApiType = "指令"
  },
  BEForceExec_Arg2_Enum1 = {
    ID = "BEForceExec_Arg2_Enum1",
    CnID = "无视费用",
    BaseSortID = 1431,
    ApiType = "公式",
    Data = 1
  },
  BEForceExec_Arg2_Enum2 = {
    ID = "BEForceExec_Arg2_Enum2",
    CnID = "尽量支付",
    BaseSortID = 1432,
    ApiType = "公式",
    Data = 2
  },
  BEForceExec_Arg2_Enum3 = {
    ID = "BEForceExec_Arg2_Enum3",
    CnID = "全额支付",
    BaseSortID = 1433,
    ApiType = "公式",
    Data = 3
  },
  BEForceExecSkill_Arg3_Enum1 = {
    ID = "BEForceExecSkill_Arg3_Enum1",
    CnID = "无视限次",
    BaseSortID = 1434,
    ApiType = "公式",
    Data = 0
  },
  BEForceExecSkill_Arg3_Enum2 = {
    ID = "BEForceExecSkill_Arg3_Enum2",
    CnID = "正常限次",
    BaseSortID = 1435,
    ApiType = "公式",
    Data = 1
  },
  BEForceExecSkill_Arg4_Enum1 = {
    ID = "BEForceExecSkill_Arg4_Enum1",
    CnID = "跳过计次",
    BaseSortID = 1436,
    ApiType = "公式",
    Data = 0
  },
  BEForceExecSkill_Arg4_Enum2 = {
    ID = "BEForceExecSkill_Arg4_Enum2",
    CnID = "正常计次",
    BaseSortID = 1437,
    ApiType = "公式",
    Data = 1
  },
  BEForceExecCard = {
    ID = "BEForceExecCard",
    CnID = "强制打出卡牌",
    BaseSortID = 1438,
    ApiType = "指令"
  },
  Const_FateCut_Counter = {
    ID = "Const_FateCut_Counter",
    CnID = "命运裁断计数状态",
    BaseSortID = 1439,
    ApiType = "公式",
    Data = 134285
  },
  Const_FateCut_Formula = {
    ID = "Const_FateCut_Formula",
    CnID = "命运裁断显示公式",
    BaseSortID = 1440,
    ApiType = "公式",
    Data = "StateOwner.GetStateLayer(134285)/StateOwner.max_hp"
  },
  card_damage_per3_n2 = {
    ID = "card_damage_per3_n2",
    CnID = "本卡牌造成伤害最终百分比修正2",
    BaseSortID = 1441,
    ApiType = "唤醒体属性"
  },
  card_block_per2_n2 = {
    ID = "card_block_per2_n2",
    CnID = "本卡牌造成护盾最终百分比修正2",
    BaseSortID = 1442,
    ApiType = "唤醒体属性"
  },
  card_heal_per2_n2 = {
    ID = "card_heal_per2_n2",
    CnID = "本卡牌造成治疗最终百分比修正2",
    BaseSortID = 1443,
    ApiType = "唤醒体属性"
  },
  card_state_layer_per_TentaclePower_n2 = {
    ID = "card_state_layer_per_TentaclePower_n2",
    CnID = "本卡牌施加触腕伤害最终百分比修正2",
    BaseSortID = 1444,
    ApiType = "唤醒体属性",
    Data = "3897,2924"
  },
  card_fixed_state_layer_per_poison_n2 = {
    ID = "card_fixed_state_layer_per_poison_n2",
    CnID = "本卡牌施加固定中毒最终百分比修正2",
    BaseSortID = 1445,
    ApiType = "唤醒体属性",
    Data = 3068
  },
  card_fixed_state_layer_per_counterattack_n2 = {
    ID = "card_fixed_state_layer_per_counterattack_n2",
    CnID = "本卡牌施加固定反击最终百分比修正2",
    BaseSortID = 1446,
    ApiType = "唤醒体属性",
    Data = "3905,3023"
  },
  card_fixed_state_layer_per_fatecut_n2 = {
    ID = "card_fixed_state_layer_per_fatecut_n2",
    CnID = "本卡牌施加固定命运裁断最终百分比修正2",
    BaseSortID = 1447,
    ApiType = "唤醒体属性",
    Data = 134285
  },
  card_state_layer_per_exhaustion_n2 = {
    ID = "card_state_layer_per_exhaustion_n2",
    CnID = "本卡牌施加衰竭最终百分比修正2",
    BaseSortID = 1448,
    ApiType = "唤醒体属性",
    Data = "3902,2619"
  },
  card_state_layer_per_power_n2 = {
    ID = "card_state_layer_per_power_n2",
    CnID = "本卡牌施加力量最终百分比修正2",
    BaseSortID = 1449,
    ApiType = "唤醒体属性",
    Data = "2900,3130"
  },
  instructcard_basic_state_layer_per_corrosion = {
    ID = "instructcard_basic_state_layer_per_corrosion",
    CnID = "指令卡造成侵蚀基础效果百分比修正",
    BaseSortID = 1450,
    ApiType = "唤醒体属性",
    Data = 90059
  },
  basic_state_layer_per_corrosion = {
    ID = "basic_state_layer_per_corrosion",
    CnID = "造成侵蚀基础效果百分比修正",
    BaseSortID = 1451,
    ApiType = "唤醒体属性",
    Data = 90059
  },
  PVPCustAttr1 = {
    ID = "PVPCustAttr1",
    CnID = "模拟演绎原归属者",
    BaseSortID = 1452,
    ApiType = "卡牌属性"
  },
  ["BESetAttr.PVPCustAttr1"] = {
    ID = "BESetAttr.PVPCustAttr1",
    CnID = "设定模拟演绎原归属者",
    BaseSortID = 1453,
    ApiType = "指令"
  },
  GetByUniqueID = {
    ID = "GetByUniqueID",
    CnID = "按唯一索引获取目标",
    BaseSortID = 1454,
    ApiType = "函数"
  },
  spellbound_block_per = {
    ID = "spellbound_block_per",
    CnID = "PVP痴醉造成护盾百分比修正",
    BaseSortID = 1455,
    ApiType = "唤醒体属性",
    Alias = "PVP痴醉造成护盾降低"
  },
  spellbound_block_per2 = {
    ID = "spellbound_block_per2",
    CnID = "PVP造成护盾百分比降低2",
    BaseSortID = 1456,
    ApiType = "唤醒体属性"
  },
  spellbound_block_per3 = {
    ID = "spellbound_block_per3",
    CnID = "PVP造成护盾百分比降低3",
    BaseSortID = 1457,
    ApiType = "唤醒体属性"
  },
  spellbound_block_per4 = {
    ID = "spellbound_block_per4",
    CnID = "PVP造成护盾百分比降低4",
    BaseSortID = 1458,
    ApiType = "唤醒体属性"
  },
  spellbound_block_per5 = {
    ID = "spellbound_block_per5",
    CnID = "PVP造成护盾百分比降低5",
    BaseSortID = 1459,
    ApiType = "唤醒体属性"
  },
  spellbound_dmg_per = {
    ID = "spellbound_dmg_per",
    CnID = "PVP痴醉造成伤害百分比修正",
    BaseSortID = 1460,
    ApiType = "唤醒体属性",
    Alias = "PVP痴醉造成伤害降低"
  },
  spellbound_dmg_per2 = {
    ID = "spellbound_dmg_per2",
    CnID = "PVP造成伤害百分比降低2",
    BaseSortID = 1461,
    ApiType = "唤醒体属性"
  },
  spellbound_dmg_per3 = {
    ID = "spellbound_dmg_per3",
    CnID = "PVP造成伤害百分比降低3",
    BaseSortID = 1462,
    ApiType = "唤醒体属性"
  },
  spellbound_dmg_per4 = {
    ID = "spellbound_dmg_per4",
    CnID = "PVP造成伤害百分比降低4",
    BaseSortID = 1463,
    ApiType = "唤醒体属性"
  },
  spellbound_dmg_per5 = {
    ID = "spellbound_dmg_per5",
    CnID = "PVP造成伤害百分比降低5",
    BaseSortID = 1464,
    ApiType = "唤醒体属性"
  },
  spellbound_heal_per = {
    ID = "spellbound_heal_per",
    CnID = "PVP痴醉造成治疗百分比修正",
    BaseSortID = 1465,
    ApiType = "唤醒体属性",
    Alias = "PVP痴醉造成治疗降低"
  },
  spellbound_heal_per2 = {
    ID = "spellbound_heal_per2",
    CnID = "PVP造成治疗百分比降低2",
    BaseSortID = 1466,
    ApiType = "唤醒体属性"
  },
  spellbound_heal_per3 = {
    ID = "spellbound_heal_per3",
    CnID = "PVP造成治疗百分比降低3",
    BaseSortID = 1467,
    ApiType = "唤醒体属性"
  },
  spellbound_heal_per4 = {
    ID = "spellbound_heal_per4",
    CnID = "PVP造成治疗百分比降低4",
    BaseSortID = 1468,
    ApiType = "唤醒体属性"
  },
  spellbound_heal_per5 = {
    ID = "spellbound_heal_per5",
    CnID = "PVP造成治疗百分比降低5",
    BaseSortID = 1469,
    ApiType = "唤醒体属性"
  },
  PVPGenCardListBySlot = {
    ID = "PVPGenCardListBySlot",
    CnID = "随机获取已开放使用的唤醒体的技能",
    BaseSortID = 1470,
    ApiType = "函数"
  },
  PVPGenCardListBySlotArg1 = {
    ID = "PVPGenCardListBySlotArg1",
    CnID = "去重",
    BaseSortID = 1471,
    ApiType = "公式",
    Data = 0
  },
  PVPGenCardListBySlotArg2 = {
    ID = "PVPGenCardListBySlotArg2",
    CnID = "不去重",
    BaseSortID = 1472,
    ApiType = "公式",
    Data = 1
  },
  BESetLockedEnemy = {
    ID = "BESetLockedEnemy",
    CnID = "设置唤醒体锁定的敌方",
    BaseSortID = 1473,
    ApiType = "指令"
  },
  BEClearLockedEnemy = {
    ID = "BEClearLockedEnemy",
    CnID = "清除唤醒体锁定的敌方",
    BaseSortID = 1474,
    ApiType = "指令"
  },
  GetLockedEnemy = {
    ID = "GetLockedEnemy",
    CnID = "获取唤醒体锁定的敌方",
    BaseSortID = 1475,
    ApiType = "函数"
  },
  GetLockingAwakers = {
    ID = "GetLockingAwakers",
    CnID = "获取锁定该唤醒体的唤醒体列表",
    BaseSortID = 1476,
    ApiType = "函数"
  },
  PVPSacrifice = {
    ID = "PVPSacrifice",
    CnID = "PVP献祭",
    BaseSortID = 1477,
    ApiType = "唤醒体属性"
  },
  PVPImmuneSpDown = {
    ID = "PVPImmuneSpDown",
    CnID = "PVP免疫算力降低",
    BaseSortID = 1478,
    ApiType = "唤醒体属性"
  },
  PVPPlayerImmuneSpReduce = {
    ID = "PVPPlayerImmuneSpReduce",
    CnID = "PVP玩家免疫算力降低",
    BaseSortID = 1479,
    ApiType = "公式",
    Data = "GetAllyTargetByPos(1,DeadOrAlive,Motionless).PVPImmuneSpDown+GetAllyTargetByPos(2,DeadOrAlive,Motionless).PVPImmuneSpDown+GetAllyTargetByPos(3,DeadOrAlive,Motionless).PVPImmuneSpDown+GetAllyTargetByPos(4,DeadOrAlive,Motionless).PVPImmuneSpDown"
  },
  PVPHandToNightmare = {
    ID = "PVPHandToNightmare",
    CnID = "PVP手牌转换为囚魇",
    BaseSortID = 1480,
    ApiType = "唤醒体属性"
  },
  PVPPlayerHandToNightmare = {
    ID = "PVPPlayerHandToNightmare",
    CnID = "PVP玩家手牌转换为囚魇",
    BaseSortID = 1481,
    ApiType = "公式",
    Data = "GetAllyTargetByPos(1,DeadOrAlive,Motionless).PVPHandToNightmare+GetAllyTargetByPos(2,DeadOrAlive,Motionless).PVPHandToNightmare+GetAllyTargetByPos(3,DeadOrAlive,Motionless).PVPHandToNightmare+GetAllyTargetByPos(4,DeadOrAlive,Motionless).PVPHandToNightmare"
  },
  PVPFusion = {
    ID = "PVPFusion",
    CnID = "PVP融合",
    BaseSortID = 1482,
    ApiType = "唤醒体属性"
  },
  PVPPuncture = {
    ID = "PVPPuncture",
    CnID = "PVP穿刺",
    BaseSortID = 1483,
    ApiType = "唤醒体属性"
  },
  PvPFairyBlessDamage = {
    ID = "PvPFairyBlessDamage",
    CnID = "PVP赐福伤害",
    BaseSortID = 1484,
    ApiType = "公式",
    Data = 15
  },
  energy = {
    ID = "energy",
    CnID = "当前算力",
    BaseSortID = 1485,
    ApiType = "角色属性"
  },
  max_energy = {
    ID = "max_energy",
    CnID = "最大算力",
    BaseSortID = 1486,
    ApiType = "角色属性"
  },
  BEChangeEnergy = {
    ID = "BEChangeEnergy",
    CnID = "改变当前算力",
    BaseSortID = 1487,
    ApiType = "指令"
  },
  BEChangeMaxEnergy = {
    ID = "BEChangeMaxEnergy",
    CnID = "改变最大算力",
    BaseSortID = 1488,
    ApiType = "指令"
  },
  ConsumeEnergy = {
    ID = "ConsumeEnergy",
    CnID = "实际消耗算力",
    BaseSortID = 1489,
    ApiType = "统计属性"
  },
  OverFlowEnergy = {
    ID = "OverFlowEnergy",
    CnID = "回合结束剩余算力",
    BaseSortID = 1490,
    ApiType = "统计属性"
  },
  GetMaxCostCard = {
    ID = "GetMaxCostCard",
    CnID = "获取算力最高卡牌",
    BaseSortID = 1491,
    ApiType = "函数"
  },
  GetMinCostCard = {
    ID = "GetMinCostCard",
    CnID = "获取算力最低卡牌",
    BaseSortID = 1492,
    ApiType = "函数"
  },
  card_cost = {
    ID = "card_cost",
    CnID = "卡牌算力消耗",
    BaseSortID = 1493,
    ApiType = "卡牌属性"
  },
  card_origin_cost = {
    ID = "card_origin_cost",
    CnID = "卡牌原始算力消耗",
    BaseSortID = 1494,
    ApiType = "卡牌属性"
  },
  card_fixed_cost0 = {
    ID = "card_fixed_cost0",
    CnID = "卡牌恒定算力消耗0",
    BaseSortID = 1495,
    ApiType = "卡牌属性"
  },
  card_fixed_cost1 = {
    ID = "card_fixed_cost1",
    CnID = "卡牌恒定算力消耗1",
    BaseSortID = 1496,
    ApiType = "卡牌属性"
  },
  card_fixed_cost2 = {
    ID = "card_fixed_cost2",
    CnID = "卡牌恒定算力消耗2",
    BaseSortID = 1497,
    ApiType = "卡牌属性"
  },
  card_fixed_cost3 = {
    ID = "card_fixed_cost3",
    CnID = "卡牌恒定算力消耗3",
    BaseSortID = 1498,
    ApiType = "卡牌属性"
  },
  card_fixed_cost4 = {
    ID = "card_fixed_cost4",
    CnID = "卡牌恒定算力消耗4",
    BaseSortID = 1499,
    ApiType = "卡牌属性"
  },
  card_fixed_cost5 = {
    ID = "card_fixed_cost5",
    CnID = "卡牌恒定算力消耗5",
    BaseSortID = 1500,
    ApiType = "卡牌属性"
  },
  cost_fix_strikecard = {
    ID = "cost_fix_strikecard",
    CnID = "打击牌算力消耗修正",
    BaseSortID = 1501,
    ApiType = "唤醒体属性"
  },
  cost_fix_defendcard = {
    ID = "cost_fix_defendcard",
    CnID = "防御牌算力消耗修正",
    BaseSortID = 1502,
    ApiType = "唤醒体属性"
  },
  cost_fix_skillcard = {
    ID = "cost_fix_skillcard",
    CnID = "技能牌算力消耗修正",
    BaseSortID = 1503,
    ApiType = "唤醒体属性"
  },
  awaker_cmdcard_notextend_cost_fix = {
    ID = "awaker_cmdcard_notextend_cost_fix",
    CnID = "唤醒体非衍生指令卡牌算力消耗修正",
    BaseSortID = 1504,
    ApiType = "唤醒体属性"
  },
  awaker_card_cost_fix = {
    ID = "awaker_card_cost_fix",
    CnID = "指令牌算力消耗修正",
    BaseSortID = 1505,
    ApiType = "唤醒体属性"
  },
  cost_fix_awakecard = {
    ID = "cost_fix_awakecard",
    CnID = "灵知觉醒算力消耗修正",
    BaseSortID = 1506,
    ApiType = "唤醒体属性"
  },
  Awaker_slow_cmd_card_cost_fix = {
    ID = "Awaker_slow_cmd_card_cost_fix",
    CnID = "唤醒体指令卡迟缓算力消耗修正",
    BaseSortID = 1507,
    ApiType = "唤醒体属性"
  },
  Awaker_slow_card_cost_fix = {
    ID = "Awaker_slow_card_cost_fix",
    CnID = "唤醒体迟缓算力消耗修正",
    BaseSortID = 1508,
    ApiType = "唤醒体属性"
  },
  BSTEnergyGain = {
    ID = "BSTEnergyGain",
    CnID = "获得算力后",
    BaseSortID = 1509,
    ApiType = "触发器"
  },
  BSTEnergyConsume = {
    ID = "BSTEnergyConsume",
    CnID = "消耗算力后",
    BaseSortID = 1510,
    ApiType = "触发器"
  },
  ["[Enemy]BSTEnergyGain"] = {
    ID = "[Enemy]BSTEnergyGain",
    CnID = "敌方获得算力后",
    BaseSortID = 1511,
    ApiType = "触发器"
  },
  ["[Enemy]BSTEnergyConsume"] = {
    ID = "[Enemy]BSTEnergyConsume",
    CnID = "敌方消耗算力后",
    BaseSortID = 1512,
    ApiType = "触发器"
  },
  BSTAfterEnergyChanged = {
    ID = "BSTAfterEnergyChanged",
    CnID = "当前算力变化后",
    BaseSortID = 1513,
    ApiType = "触发器"
  },
  BSTCardCostChanged = {
    ID = "BSTCardCostChanged",
    CnID = "此卡牌算力变化后",
    BaseSortID = 1514,
    ApiType = "触发器"
  },
  role_card_cost_fix = {
    ID = "role_card_cost_fix",
    CnID = "玩家卡牌算力消耗修正",
    BaseSortID = 1515,
    ApiType = "角色属性"
  },
  XCardCurrentConsumableComputingPower = {
    ID = "XCardCurrentConsumableComputingPower",
    CnID = "X卡牌当前可消耗的算力",
    BaseSortID = 1516,
    ApiType = "公式",
    Data = "(PlayerRole.energy>9999 and 9999 or PlayerRole.energy)"
  },
  ulti_skill_level_up = {
    ID = "ulti_skill_level_up",
    CnID = "狂气爆发晋升效果",
    BaseSortID = 1517,
    ApiType = "角色属性"
  },
  BEPureDamage = {
    ID = "BEPureDamage",
    CnID = "造成PVP纯粹伤害",
    BaseSortID = 1518,
    ApiType = "指令"
  },
  Formula_initial_max_keeper_energy = {
    ID = "Formula_initial_max_keeper_energy",
    CnID = "初始银钥能量上限公式",
    BaseSortID = 1519,
    ApiType = "公式",
    Data = 1000
  },
  is_chaos_type2 = {
    ID = "is_chaos_type2",
    CnID = "新混沌编队标识",
    BaseSortID = 1520,
    ApiType = "角色属性"
  },
  keeperskill_atk_per = {
    ID = "keeperskill_atk_per",
    CnID = "钥令攻效",
    BaseSortID = 1521,
    ApiType = "角色属性"
  },
  keeperskill_def_per = {
    ID = "keeperskill_def_per",
    CnID = "钥令防效",
    BaseSortID = 1522,
    ApiType = "角色属性"
  },
  keeperskill_atk_per_inspect = {
    ID = "keeperskill_atk_per_inspect",
    CnID = "钥令攻效截距",
    BaseSortID = 1523,
    ApiType = "标记",
    Data = 0
  },
  keeperskill_def_per_inspect = {
    ID = "keeperskill_def_per_inspect",
    CnID = "钥令防效截距",
    BaseSortID = 1524,
    ApiType = "标记",
    Data = 0
  },
  keeperskill_atk_per_slope = {
    ID = "keeperskill_atk_per_slope",
    CnID = "钥令攻效斜率",
    BaseSortID = 1525,
    ApiType = "标记",
    Data = "100/1000"
  },
  keeperskill_def_per_slope = {
    ID = "keeperskill_def_per_slope",
    CnID = "钥令防效斜率",
    BaseSortID = 1526,
    ApiType = "标记",
    Data = "50/1000"
  },
  GetTeamKeeperSkill = {
    ID = "GetTeamKeeperSkill",
    CnID = "获取编队钥令",
    BaseSortID = 1527,
    ApiType = "函数"
  },
  RandUnlockKeeperSkill = {
    ID = "RandUnlockKeeperSkill",
    CnID = "获取随机已解锁钥令",
    BaseSortID = 1528,
    ApiType = "函数"
  },
  KeeperSkillBlankMemory = {
    ID = "KeeperSkillBlankMemory",
    CnID = "空白记忆列表",
    BaseSortID = 1529,
    ApiType = "标记",
    Data = "146484,145995,145989,145993,145992,145991,145988,145990"
  },
  BERunCardAgain = {
    ID = "BERunCardAgain",
    CnID = "打出卡牌",
    BaseSortID = 1530,
    ApiType = "指令"
  },
  keeper_skill_card_add_times_on_use = {
    ID = "keeper_skill_card_add_times_on_use",
    CnID = "钥令卡共享限额",
    BaseSortID = 1531,
    ApiType = "卡牌属性"
  },
  BECreateKeeperSkillCard = {
    ID = "BECreateKeeperSkillCard",
    CnID = "按钥令创建卡牌",
    BaseSortID = 1532,
    ApiType = "指令"
  },
  chaostype2_ks_atk_per = {
    ID = "chaostype2_ks_atk_per",
    CnID = "新混沌钥令攻效",
    BaseSortID = 1533,
    ApiType = "公式",
    Data = "(1+(0+PlayerRole.occupation_master_final*100/1000)/100*PlayerRole.is_chaos_type2)"
  },
  chaostype2_ks_def_per = {
    ID = "chaostype2_ks_def_per",
    CnID = "新混沌钥令防效",
    BaseSortID = 1534,
    ApiType = "公式",
    Data = "(1+(0+PlayerRole.occupation_master_final*50/1000)/100*PlayerRole.is_chaos_type2)"
  },
  BasicKeeperEnergy = {
    ID = "BasicKeeperEnergy",
    CnID = "基础钥能上限",
    BaseSortID = 1535,
    ApiType = "功能属性"
  },
  MaxKeeperEnergy = {
    ID = "MaxKeeperEnergy",
    CnID = "最大积攒钥能",
    BaseSortID = 1536,
    ApiType = "功能属性"
  },
  MaxRetroHp = {
    ID = "MaxRetroHp",
    CnID = "回溯后较多剩余生命",
    BaseSortID = 1537,
    ApiType = "公式",
    Data = 70
  },
  MinRetroHp = {
    ID = "MinRetroHp",
    CnID = "回溯后较少剩余生命",
    BaseSortID = 1538,
    ApiType = "公式",
    Data = 35
  },
  RetroGateLifeRatio = {
    ID = "RetroGateLifeRatio",
    CnID = "回溯之扉生命比例",
    BaseSortID = 1539,
    ApiType = "公式",
    Data = "(PlayerRole.GetStateLayer(22706)==0 and MaxRetroHp or MinRetroHp)/100"
  },
  GetMonsterDamage = {
    ID = "GetMonsterDamage",
    CnID = "获取目标当前伤害",
    BaseSortID = 1540,
    ApiType = "函数"
  },
  BEEndBout = {
    ID = "BEEndBout",
    CnID = "结束回合",
    BaseSortID = 1541,
    ApiType = "指令"
  },
  MaxDamageEnemy = {
    ID = "MaxDamageEnemy",
    CnID = "获取当前伤害最高的目标",
    BaseSortID = 1542,
    ApiType = "目标"
  },
  Forcedretention = {
    ID = "Forcedretention",
    CnID = "强制保留",
    BaseSortID = 1543,
    ApiType = "卡牌属性"
  },
  BECardDisplayChange = {
    ID = "BECardDisplayChange",
    CnID = "打出卡牌显示变化",
    BaseSortID = 1544,
    ApiType = "指令"
  }
})
return BattleApi
