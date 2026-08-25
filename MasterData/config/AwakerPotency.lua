local System = require("System.System")
local readonly = System.readonly
local AwakerPotency = readonly({
  [13276] = {
    ID = 13276,
    CnID = "启灵@知者懵懂的启程",
    BaseSortID = 1,
    PotencyName = "AwakerPotency_13276_PotencyName|懵懂的启程",
    PotencyDesc = "AwakerPotency_13276_PotencyDesc|「女王之剑」伤害次数+1，每次造成伤害时，获得等同于攻击力 [Arg1]% 的临时力量。（效果随「女王之剑」的等级提升）「女王之剑」弃掉后，获得 300% 等同于拉蒙娜银钥充能的银钥能量。",
    AwakerID = 15595,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4138,1,2,1)"
    },
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13233] = {
    ID = 13233,
    CnID = "启灵@知者未知的期待",
    BaseSortID = 2,
    PotencyName = "AwakerPotency_13233_PotencyName|未知的期待",
    PotencyDesc = "AwakerPotency_13233_PotencyDesc|「攻势推演」所抽的牌每有 1 点算力消耗，额外获得 35 点银钥充能",
    AwakerID = 15595,
    PotencyType = "PassiveSkill",
    FrontPotency = 13276,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_return.png",
    IfMaxPotency = false
  },
  [13334] = {
    ID = 13334,
    CnID = "启灵@知者珍贵的羁绊",
    BaseSortID = 3,
    PotencyName = "AwakerPotency_13334_PotencyName|珍贵的羁绊",
    PotencyDesc = "AwakerPotency_13334_PotencyDesc|释放钥令后，拉蒙娜临时暴击率提高 50％。「世界演绎法」将 1 张「灵感」洗入抽牌堆。",
    AwakerID = 15595,
    PotencyType = "PassiveSkill",
    FrontPotency = 13233,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13492] = {
    ID = 13492,
    CnID = "启灵@知者人格深化1",
    BaseSortID = 4,
    PotencyName = "AwakerPotency_13492_PotencyName|人格深化",
    AwakerID = 15595,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13334,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13494] = {
    ID = 13494,
    CnID = "启灵@知者人格深化2",
    BaseSortID = 5,
    PotencyName = "AwakerPotency_13494_PotencyName|人格深化",
    AwakerID = 15595,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13492,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13493] = {
    ID = 13493,
    CnID = "启灵@知者人格深化3",
    BaseSortID = 6,
    PotencyName = "AwakerPotency_13493_PotencyName|人格深化",
    AwakerID = 15595,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13494,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13489] = {
    ID = 13489,
    CnID = "启灵@知者人格深化4",
    BaseSortID = 7,
    PotencyName = "AwakerPotency_13489_PotencyName|无限思维迷宫",
    PotencyDesc = "AwakerPotency_13489_PotencyDesc|<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>所有敌人 1 回合，下个释放的钥令生效 2 次。",
    AwakerID = 15595,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13493,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13488] = {
    ID = 13488,
    CnID = "启灵@知者人格深化5",
    BaseSortID = 8,
    PotencyName = "AwakerPotency_13488_PotencyName|人格深化",
    AwakerID = 15595,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13489,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13491] = {
    ID = 13491,
    CnID = "启灵@知者人格深化6",
    BaseSortID = 9,
    PotencyName = "AwakerPotency_13491_PotencyName|人格深化",
    AwakerID = 15595,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13488,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13490] = {
    ID = 13490,
    CnID = "启灵@知者人格深化7",
    BaseSortID = 10,
    PotencyName = "AwakerPotency_13490_PotencyName|人格深化",
    AwakerID = 15595,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13491,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13487] = {
    ID = 13487,
    CnID = "启灵@知者人格深化8",
    BaseSortID = 11,
    PotencyName = "AwakerPotency_13487_PotencyName|人格深化",
    AwakerID = 15595,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13490,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13486] = {
    ID = 13486,
    CnID = "启灵@知者人格深化9",
    BaseSortID = 12,
    PotencyName = "AwakerPotency_13486_PotencyName|人格深化",
    AwakerID = 15595,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13487,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13515] = {
    ID = 13515,
    CnID = "启灵@知者人格深化10",
    BaseSortID = 13,
    PotencyName = "AwakerPotency_13515_PotencyName|人格深化",
    AwakerID = 15595,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13486,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13514] = {
    ID = 13514,
    CnID = "启灵@知者人格深化11",
    BaseSortID = 14,
    PotencyName = "AwakerPotency_13514_PotencyName|人格深化",
    AwakerID = 15595,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13515,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13516] = {
    ID = 13516,
    CnID = "启灵@知者人格深化12",
    BaseSortID = 15,
    PotencyName = "AwakerPotency_13516_PotencyName|至臻的淬炼",
    PotencyDesc = "AwakerPotency_13516_PotencyDesc|灵知觉醒「第一哲学」获得强化，每次生效时额外使拉蒙娜造成的基础伤害提高 10%。",
    AwakerID = 15595,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13514,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13656] = {
    ID = 13656,
    CnID = "启灵@原初信徒崎岖海岸",
    BaseSortID = 16,
    PotencyName = "AwakerPotency_13656_PotencyName|崎岖海岸",
    PotencyDesc = "AwakerPotency_13656_PotencyDesc|「狂热之海」享受触腕伤害加成提高为 100%。",
    AwakerID = 15575,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4644,1,2,1)"
    },
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13362] = {
    ID = 13362,
    CnID = "启灵@原初信徒凝固鲸油",
    BaseSortID = 17,
    PotencyName = "AwakerPotency_13362_PotencyName|凝固鲸油",
    PotencyDesc = "AwakerPotency_13362_PotencyDesc|「基础打击」和「基础防御」使 1 条触腕攻击 2 次，但只造成 50％ 伤害。",
    AwakerID = 15575,
    PotencyType = "PassiveSkill",
    FrontPotency = 13656,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13177] = {
    ID = 13177,
    CnID = "启灵@原初信徒微弱烛光",
    BaseSortID = 18,
    PotencyName = "AwakerPotency_13177_PotencyName|微弱烛光",
    PotencyDesc = "AwakerPotency_13177_PotencyDesc|回合结束时，每有 1 张手牌，触发所有敌人 3% 的中毒，并获得 3 点狂气。",
    AwakerID = 15575,
    PotencyType = "PassiveSkill",
    FrontPotency = 13362,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13252] = {
    ID = 13252,
    CnID = "启灵@原初信徒人格深化1",
    BaseSortID = 19,
    PotencyName = "AwakerPotency_13252_PotencyName|人格深化",
    AwakerID = 15575,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18142,
      1.6
    },
    FrontPotency = 13177,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13250] = {
    ID = 13250,
    CnID = "启灵@原初信徒人格深化2",
    BaseSortID = 20,
    PotencyName = "AwakerPotency_13250_PotencyName|人格深化",
    AwakerID = 15575,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18142,
      1.6
    },
    FrontPotency = 13252,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13251] = {
    ID = 13251,
    CnID = "启灵@原初信徒人格深化3",
    BaseSortID = 21,
    PotencyName = "AwakerPotency_13251_PotencyName|人格深化",
    AwakerID = 15575,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18142,
      1.6
    },
    FrontPotency = 13250,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13255] = {
    ID = 13255,
    CnID = "启灵@原初信徒人格深化4",
    BaseSortID = 22,
    PotencyName = "AwakerPotency_13255_PotencyName|迷航之光",
    PotencyDesc = "AwakerPotency_13255_PotencyDesc|手牌上限+2，回合结束时选择 1 张手牌获得保留并使其算力消耗 -1，持续 3 回合。",
    AwakerID = 15575,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18142,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13251,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13256] = {
    ID = 13256,
    CnID = "启灵@原初信徒人格深化5",
    BaseSortID = 23,
    PotencyName = "AwakerPotency_13256_PotencyName|人格深化",
    AwakerID = 15575,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18142,
      1.6
    },
    FrontPotency = 13255,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13253] = {
    ID = 13253,
    CnID = "启灵@原初信徒人格深化6",
    BaseSortID = 24,
    PotencyName = "AwakerPotency_13253_PotencyName|人格深化",
    AwakerID = 15575,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18142,
      1.6
    },
    FrontPotency = 13256,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13254] = {
    ID = 13254,
    CnID = "启灵@原初信徒人格深化7",
    BaseSortID = 25,
    PotencyName = "AwakerPotency_13254_PotencyName|人格深化",
    AwakerID = 15575,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18142,
      1.6
    },
    FrontPotency = 13253,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13248] = {
    ID = 13248,
    CnID = "启灵@原初信徒人格深化8",
    BaseSortID = 26,
    PotencyName = "AwakerPotency_13248_PotencyName|人格深化",
    AwakerID = 15575,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18142,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13254,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13249] = {
    ID = 13249,
    CnID = "启灵@原初信徒人格深化9",
    BaseSortID = 27,
    PotencyName = "AwakerPotency_13249_PotencyName|人格深化",
    AwakerID = 15575,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18142,
      1.6
    },
    FrontPotency = 13248,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13359] = {
    ID = 13359,
    CnID = "启灵@原初信徒人格深化10",
    BaseSortID = 28,
    PotencyName = "AwakerPotency_13359_PotencyName|人格深化",
    AwakerID = 15575,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18142,
      1.6
    },
    FrontPotency = 13249,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13360] = {
    ID = 13360,
    CnID = "启灵@原初信徒人格深化11",
    BaseSortID = 29,
    PotencyName = "AwakerPotency_13360_PotencyName|人格深化",
    AwakerID = 15575,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18142,
      1.6
    },
    FrontPotency = 13359,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13361] = {
    ID = 13361,
    CnID = "启灵@原初信徒人格深化12",
    BaseSortID = 30,
    PotencyName = "AwakerPotency_13361_PotencyName|终至光辉彼岸",
    PotencyDesc = "AwakerPotency_13361_PotencyDesc|灵知觉醒「湮塞的执念」获得强化，法洛思打出卡牌后使本回合触腕造成等同于伤害 5% 的中毒，最多生效 3 次。",
    AwakerID = 15575,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18142,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13360,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13181] = {
    ID = 13181,
    CnID = "启灵@淤泥之花黑色灌溉",
    BaseSortID = 31,
    PotencyName = "AwakerPotency_13181_PotencyName|黑色灌溉",
    PotencyDesc = "AwakerPotency_13181_PotencyDesc|当前生命低于 50% 时，「黑沼禁域」额外获得 1 次护盾，造成的中毒翻倍。",
    AwakerID = 15581,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13689] = {
    ID = 13689,
    CnID = "启灵@淤泥之花粘稠吞噬",
    BaseSortID = 32,
    PotencyName = "AwakerPotency_13689_PotencyName|粘稠吞噬",
    PotencyDesc = "AwakerPotency_13689_PotencyDesc|「报偿打击」预备 1 升级为预备 2，基础伤害和暴击率提高 20%。",
    AwakerID = 15581,
    PotencyType = "PassiveSkill",
    FrontPotency = 13181,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_return.png",
    IfMaxPotency = false
  },
  [13221] = {
    ID = 13221,
    CnID = "启灵@淤泥之花永不遗忘",
    BaseSortID = 33,
    PotencyName = "AwakerPotency_13221_PotencyName|永不遗忘",
    PotencyDesc = "AwakerPotency_13221_PotencyDesc|回合开始时获得 10% 最大生命的忍耐。「淤泥上的不灭之花」和「报偿打击」仅移除一半忍耐。",
    AwakerID = 15581,
    PotencyType = "PassiveSkill",
    FrontPotency = 13689,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13346] = {
    ID = 13346,
    CnID = "启灵@淤泥之花人格深化1",
    BaseSortID = 34,
    PotencyName = "AwakerPotency_13346_PotencyName|人格深化",
    AwakerID = 15581,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18142,
      1.6
    },
    FrontPotency = 13221,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13344] = {
    ID = 13344,
    CnID = "启灵@淤泥之花人格深化2",
    BaseSortID = 35,
    PotencyName = "AwakerPotency_13344_PotencyName|人格深化",
    AwakerID = 15581,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18142,
      1.6
    },
    FrontPotency = 13346,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13345] = {
    ID = 13345,
    CnID = "启灵@淤泥之花人格深化3",
    BaseSortID = 36,
    PotencyName = "AwakerPotency_13345_PotencyName|人格深化",
    AwakerID = 15581,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18142,
      1.6
    },
    FrontPotency = 13344,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13349] = {
    ID = 13349,
    CnID = "启灵@淤泥之花人格深化4",
    BaseSortID = 37,
    PotencyName = "AwakerPotency_13349_PotencyName|听从所愿",
    PotencyDesc = "AwakerPotency_13349_PotencyDesc|本场战斗内忍耐上限提高 100%，获得等同于最大生命的忍耐。将 2 张附加消耗的「报偿打击」置入手中。",
    AwakerID = 15581,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18142,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13345,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13350] = {
    ID = 13350,
    CnID = "启灵@淤泥之花人格深化5",
    BaseSortID = 38,
    PotencyName = "AwakerPotency_13350_PotencyName|人格深化",
    AwakerID = 15581,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18142,
      1.6
    },
    FrontPotency = 13349,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13347] = {
    ID = 13347,
    CnID = "启灵@淤泥之花人格深化6",
    BaseSortID = 39,
    PotencyName = "AwakerPotency_13347_PotencyName|人格深化",
    AwakerID = 15581,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18142,
      1.6
    },
    FrontPotency = 13350,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13348] = {
    ID = 13348,
    CnID = "启灵@淤泥之花人格深化7",
    BaseSortID = 40,
    PotencyName = "AwakerPotency_13348_PotencyName|人格深化",
    AwakerID = 15581,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18142,
      1.6
    },
    FrontPotency = 13347,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13342] = {
    ID = 13342,
    CnID = "启灵@淤泥之花人格深化8",
    BaseSortID = 41,
    PotencyName = "AwakerPotency_13342_PotencyName|人格深化",
    AwakerID = 15581,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18142,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13348,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13444] = {
    ID = 13444,
    CnID = "启灵@淤泥之花人格深化9",
    BaseSortID = 42,
    PotencyName = "AwakerPotency_13444_PotencyName|人格深化",
    AwakerID = 15581,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18142,
      1.6
    },
    FrontPotency = 13342,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13719] = {
    ID = 13719,
    CnID = "启灵@淤泥之花人格深化10",
    BaseSortID = 43,
    PotencyName = "AwakerPotency_13719_PotencyName|人格深化",
    AwakerID = 15581,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18142,
      1.6
    },
    FrontPotency = 13444,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13442] = {
    ID = 13442,
    CnID = "启灵@淤泥之花人格深化11",
    BaseSortID = 44,
    PotencyName = "AwakerPotency_13442_PotencyName|人格深化",
    AwakerID = 15581,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18142,
      1.6
    },
    FrontPotency = 13719,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13579] = {
    ID = 13579,
    CnID = "启灵@淤泥之花人格深化12",
    BaseSortID = 45,
    PotencyName = "AwakerPotency_13579_PotencyName|无欲的百合",
    PotencyDesc = "AwakerPotency_13579_PotencyDesc|灵知觉醒「黏液汇集」获得强化，狂气爆发使本回合每受到 1 次攻击就使下次「报偿打击」消耗忍耐的效果提高 40%，最多叠加 5 层。",
    AwakerID = 15581,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18142,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13442,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13182] = {
    ID = 13182,
    CnID = "启灵@鹦鹉螺空白的过去",
    BaseSortID = 46,
    PotencyName = "AwakerPotency_13182_PotencyName|空白的过去",
    PotencyDesc = "AwakerPotency_13182_PotencyDesc|「基础打击」获得等同于 [Arg1]% 攻击力的反击。",
    AwakerID = 15565,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4234,1,3,1)"
    },
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13711] = {
    ID = 13711,
    CnID = "启灵@鹦鹉螺缺失的螺母",
    BaseSortID = 47,
    PotencyName = "AwakerPotency_13711_PotencyName|缺失的螺母",
    PotencyDesc = "AwakerPotency_13711_PotencyDesc|「高热区禁入」获得预备1。",
    AwakerID = 15565,
    PotencyType = "PassiveSkill",
    FrontPotency = 13182,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_return.png",
    IfMaxPotency = false
  },
  [13058] = {
    ID = 13058,
    CnID = "启灵@鹦鹉螺模糊的梦想",
    BaseSortID = 48,
    PotencyName = "AwakerPotency_13058_PotencyName|模糊的梦想",
    PotencyDesc = "AwakerPotency_13058_PotencyDesc|「整装待发」触发反击倍率 +50%，释放后自身免疫脆弱、虚弱、易伤 1 回合。",
    AwakerID = 15565,
    PotencyType = "PassiveSkill",
    FrontPotency = 13711,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13474] = {
    ID = 13474,
    CnID = "启灵@鹦鹉螺人格深化1",
    BaseSortID = 49,
    PotencyName = "AwakerPotency_13474_PotencyName|人格深化",
    AwakerID = 15565,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18126,
      4
    },
    FrontPotency = 13058,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13473] = {
    ID = 13473,
    CnID = "启灵@鹦鹉螺人格深化2",
    BaseSortID = 50,
    PotencyName = "AwakerPotency_13473_PotencyName|人格深化",
    AwakerID = 15565,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18126,
      4
    },
    FrontPotency = 13474,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13472] = {
    ID = 13472,
    CnID = "启灵@鹦鹉螺人格深化3",
    BaseSortID = 51,
    PotencyName = "AwakerPotency_13472_PotencyName|人格深化",
    AwakerID = 15565,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18126,
      4
    },
    FrontPotency = 13473,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13471] = {
    ID = 13471,
    CnID = "启灵@鹦鹉螺人格深化4",
    BaseSortID = 52,
    PotencyName = "AwakerPotency_13471_PotencyName|引擎启动！",
    PotencyDesc = "AwakerPotency_13471_PotencyDesc|提高当前护盾 50% 的效果变为无视护盾上限，触发反击倍率提高为 500％。",
    AwakerID = 15565,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18126,
      4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13472,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13470] = {
    ID = 13470,
    CnID = "启灵@鹦鹉螺人格深化5",
    BaseSortID = 53,
    PotencyName = "AwakerPotency_13470_PotencyName|人格深化",
    AwakerID = 15565,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18126,
      4
    },
    FrontPotency = 13471,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13469] = {
    ID = 13469,
    CnID = "启灵@鹦鹉螺人格深化6",
    BaseSortID = 54,
    PotencyName = "AwakerPotency_13469_PotencyName|人格深化",
    AwakerID = 15565,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18126,
      4
    },
    FrontPotency = 13470,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13468] = {
    ID = 13468,
    CnID = "启灵@鹦鹉螺人格深化7",
    BaseSortID = 55,
    PotencyName = "AwakerPotency_13468_PotencyName|人格深化",
    AwakerID = 15565,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18126,
      4
    },
    FrontPotency = 13469,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13467] = {
    ID = 13467,
    CnID = "启灵@鹦鹉螺人格深化8",
    BaseSortID = 56,
    PotencyName = "AwakerPotency_13467_PotencyName|人格深化",
    AwakerID = 15565,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18126,
      4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13468,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13466] = {
    ID = 13466,
    CnID = "启灵@鹦鹉螺人格深化9",
    BaseSortID = 57,
    PotencyName = "AwakerPotency_13466_PotencyName|人格深化",
    AwakerID = 15565,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18126,
      4
    },
    FrontPotency = 13467,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13529] = {
    ID = 13529,
    CnID = "启灵@鹦鹉螺人格深化10",
    BaseSortID = 58,
    PotencyName = "AwakerPotency_13529_PotencyName|人格深化",
    AwakerID = 15565,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18126,
      4
    },
    FrontPotency = 13466,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13528] = {
    ID = 13528,
    CnID = "启灵@鹦鹉螺人格深化11",
    BaseSortID = 59,
    PotencyName = "AwakerPotency_13528_PotencyName|人格深化",
    AwakerID = 15565,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18126,
      4
    },
    FrontPotency = 13529,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13587] = {
    ID = 13587,
    CnID = "启灵@鹦鹉螺人格深化12",
    BaseSortID = 60,
    PotencyName = "AwakerPotency_13587_PotencyName|王牌机械师",
    PotencyDesc = "AwakerPotency_13587_PotencyDesc|灵知觉醒「维修大师」获得强化，所有唤醒体固定反击提高 30%。",
    AwakerID = 15565,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18126,
      4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13528,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13601] = {
    ID = 13601,
    CnID = "启灵@幸运侦探强运加倍",
    BaseSortID = 61,
    PotencyName = "AwakerPotency_13601_PotencyName|强运加倍",
    PotencyDesc = "AwakerPotency_13601_PotencyDesc|「意外收获」若暴击还会使选择的卡牌算力消耗额外降低 1。「摊牌时刻」每次暴击莱克都会额外获得 3 点狂气。",
    AwakerID = 15604,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13152] = {
    ID = 13152,
    CnID = "启灵@幸运侦探拾金不昧",
    BaseSortID = 62,
    PotencyName = "AwakerPotency_13152_PotencyName|拾金不昧",
    PotencyDesc = "AwakerPotency_13152_PotencyDesc|探索开始时获得 15 黑印，莱克每有 1% 黑印掉落就使获得量提高 1%，且会增加「赢家通吃」进度。",
    AwakerID = 15604,
    PotencyType = "PassiveSkill",
    FrontPotency = 13601,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_return.png",
    IfMaxPotency = false
  },
  [13584] = {
    ID = 13584,
    CnID = "启灵@幸运侦探庄家通吃",
    BaseSortID = 63,
    PotencyName = "AwakerPotency_13584_PotencyName|稳赚不赔",
    PotencyDesc = "AwakerPotency_13584_PotencyDesc|每消耗 1 点黑印，就使「肆意豪赌」的基础伤害在本次探索中提高 0.5%。莱克的「基础打击」和「基础防御」若算力不足时可消耗 3 黑印打出并生效 2 次。",
    AwakerID = 15604,
    PotencyType = "PassiveSkill",
    FrontPotency = 13152,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13609] = {
    ID = 13609,
    CnID = "启灵@幸运侦探人格深化1",
    BaseSortID = 64,
    PotencyName = "AwakerPotency_13609_PotencyName|人格深化",
    AwakerID = 15604,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18155,
      1.2
    },
    FrontPotency = 13584,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13611] = {
    ID = 13611,
    CnID = "启灵@幸运侦探人格深化2",
    BaseSortID = 65,
    PotencyName = "AwakerPotency_13611_PotencyName|人格深化",
    AwakerID = 15604,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18155,
      1.2
    },
    FrontPotency = 13609,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13610] = {
    ID = 13610,
    CnID = "启灵@幸运侦探人格深化3",
    BaseSortID = 66,
    PotencyName = "AwakerPotency_13610_PotencyName|人格深化",
    AwakerID = 15604,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18155,
      1.2
    },
    FrontPotency = 13611,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13606] = {
    ID = 13606,
    CnID = "启灵@幸运侦探人格深化4",
    BaseSortID = 67,
    PotencyName = "AwakerPotency_13606_PotencyName|Jackpot！",
    PotencyDesc = "AwakerPotency_13606_PotencyDesc|「肆意豪赌」造成 3 次伤害，使抽到的卡牌算力消耗降低 1。",
    AwakerID = 15604,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18155,
      1.2
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13610,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13605] = {
    ID = 13605,
    CnID = "启灵@幸运侦探人格深化5",
    BaseSortID = 68,
    PotencyName = "AwakerPotency_13605_PotencyName|人格深化",
    AwakerID = 15604,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18155,
      1.2
    },
    FrontPotency = 13606,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13608] = {
    ID = 13608,
    CnID = "启灵@幸运侦探人格深化6",
    BaseSortID = 69,
    PotencyName = "AwakerPotency_13608_PotencyName|人格深化",
    AwakerID = 15604,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18155,
      1.2
    },
    FrontPotency = 13605,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13687] = {
    ID = 13687,
    CnID = "启灵@幸运侦探人格深化7",
    BaseSortID = 70,
    PotencyName = "AwakerPotency_13687_PotencyName|人格深化",
    AwakerID = 15604,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18155,
      1.2
    },
    FrontPotency = 13608,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13613] = {
    ID = 13613,
    CnID = "启灵@幸运侦探人格深化8",
    BaseSortID = 71,
    PotencyName = "AwakerPotency_13613_PotencyName|人格深化",
    AwakerID = 15604,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18155,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13687,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13612] = {
    ID = 13612,
    CnID = "启灵@幸运侦探人格深化9",
    BaseSortID = 72,
    PotencyName = "AwakerPotency_13612_PotencyName|人格深化",
    AwakerID = 15604,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18155,
      1.2
    },
    FrontPotency = 13613,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13224] = {
    ID = 13224,
    CnID = "启灵@幸运侦探人格深化10",
    BaseSortID = 73,
    PotencyName = "AwakerPotency_13224_PotencyName|人格深化",
    AwakerID = 15604,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18155,
      1.2
    },
    FrontPotency = 13612,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13223] = {
    ID = 13223,
    CnID = "启灵@幸运侦探人格深化11",
    BaseSortID = 74,
    PotencyName = "AwakerPotency_13223_PotencyName|人格深化",
    AwakerID = 15604,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18155,
      1.2
    },
    FrontPotency = 13224,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13225] = {
    ID = 13225,
    CnID = "启灵@幸运侦探人格深化12",
    BaseSortID = 75,
    PotencyName = "AwakerPotency_13225_PotencyName|大满贯",
    PotencyDesc = "AwakerPotency_13225_PotencyDesc|灵知觉醒「绝佳运气」获得强化，立即额外获得或升级 1 次「混沌的遗赠」，并使莱克的所有六面骰变化为八面骰。",
    AwakerID = 15604,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18155,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13223,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13370] = {
    ID = 13370,
    CnID = "启灵@猩红角斗士",
    BaseSortID = 76,
    PotencyName = "AwakerPotency_13370_PotencyName|角斗士",
    PotencyDesc = "AwakerPotency_13370_PotencyDesc|「尖啸吧，血！」基础伤害和力量提高 30%。",
    AwakerID = 15598,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13142] = {
    ID = 13142,
    CnID = "启灵@猩红罗马悲歌",
    BaseSortID = 77,
    PotencyName = "AwakerPotency_13142_PotencyName|罗马悲歌",
    PotencyDesc = "AwakerPotency_13142_PotencyDesc|「沸腾吧，血！」基础伤害提高 33%，生命低于 25% 时，额外造成 2 次伤害。",
    AwakerID = 15598,
    PotencyType = "PassiveSkill",
    FrontPotency = 13370,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13558] = {
    ID = 13558,
    CnID = "启灵@猩红巫师的末路",
    BaseSortID = 78,
    PotencyName = "AwakerPotency_13558_PotencyName|巫师的末路",
    PotencyDesc = "AwakerPotency_13558_PotencyDesc|「血与沙的赞歌」每次吞噬力量加成额外提高 1 倍。",
    AwakerID = 15598,
    PotencyType = "PassiveSkill",
    FrontPotency = 13142,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13133] = {
    ID = 13133,
    CnID = "启灵@猩红人格深化1",
    BaseSortID = 79,
    PotencyName = "AwakerPotency_13133_PotencyName|人格深化",
    AwakerID = 15598,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18105,
      2.4
    },
    FrontPotency = 13558,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13134] = {
    ID = 13134,
    CnID = "启灵@猩红人格深化2",
    BaseSortID = 80,
    PotencyName = "AwakerPotency_13134_PotencyName|人格深化",
    AwakerID = 15598,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18105,
      2.4
    },
    FrontPotency = 13133,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13135] = {
    ID = 13135,
    CnID = "启灵@猩红人格深化3",
    BaseSortID = 81,
    PotencyName = "AwakerPotency_13135_PotencyName|人格深化",
    AwakerID = 15598,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18105,
      2.4
    },
    FrontPotency = 13134,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13129] = {
    ID = 13129,
    CnID = "启灵@猩红人格深化4",
    BaseSortID = 82,
    PotencyName = "AwakerPotency_13129_PotencyName|血涌的馈赠",
    PotencyDesc = "AwakerPotency_13129_PotencyDesc|将附加虚无和消耗的「尖啸吧，血！」填满手牌，本回合尤乌哈希伤害次数提高 1。",
    AwakerID = 15598,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18105,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13135,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13130] = {
    ID = 13130,
    CnID = "启灵@猩红人格深化5",
    BaseSortID = 83,
    PotencyName = "AwakerPotency_13130_PotencyName|人格深化",
    AwakerID = 15598,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18105,
      2.4
    },
    FrontPotency = 13129,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13131] = {
    ID = 13131,
    CnID = "启灵@猩红人格深化6",
    BaseSortID = 84,
    PotencyName = "AwakerPotency_13131_PotencyName|人格深化",
    AwakerID = 15598,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18105,
      2.4
    },
    FrontPotency = 13130,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13132] = {
    ID = 13132,
    CnID = "启灵@猩红人格深化7",
    BaseSortID = 85,
    PotencyName = "AwakerPotency_13132_PotencyName|人格深化",
    AwakerID = 15598,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18105,
      2.4
    },
    FrontPotency = 13131,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13139] = {
    ID = 13139,
    CnID = "启灵@猩红人格深化8",
    BaseSortID = 86,
    PotencyName = "AwakerPotency_13139_PotencyName|人格深化",
    AwakerID = 15598,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18105,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13132,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13140] = {
    ID = 13140,
    CnID = "启灵@猩红人格深化9",
    BaseSortID = 87,
    PotencyName = "AwakerPotency_13140_PotencyName|人格深化",
    AwakerID = 15598,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18105,
      2.4
    },
    FrontPotency = 13139,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13100] = {
    ID = 13100,
    CnID = "启灵@猩红人格深化10",
    BaseSortID = 88,
    PotencyName = "AwakerPotency_13100_PotencyName|人格深化",
    AwakerID = 15598,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18105,
      2.4
    },
    FrontPotency = 13140,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13321] = {
    ID = 13321,
    CnID = "启灵@猩红人格深化11",
    BaseSortID = 89,
    PotencyName = "AwakerPotency_13321_PotencyName|人格深化",
    AwakerID = 15598,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18105,
      2.4
    },
    FrontPotency = 13100,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13098] = {
    ID = 13098,
    CnID = "启灵@猩红人格深化12",
    BaseSortID = 90,
    PotencyName = "AwakerPotency_13098_PotencyName|戾狂的赞歌",
    PotencyDesc = "AwakerPotency_13098_PotencyDesc|灵知觉醒「红祭礼」获得强化，尤乌哈希狂气爆发最终伤害提高 35%，生命低于 25% 时效果翻倍。",
    AwakerID = 15598,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18105,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13321,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13566] = {
    ID = 13566,
    CnID = "启灵@星之芽枯萎之歌",
    BaseSortID = 91,
    PotencyName = "AwakerPotency_13566_PotencyName|双生之星",
    PotencyDesc = "AwakerPotency_13566_PotencyDesc|「基础打击」造成 2 次伤害，获得 50% 伤害的临时反击。",
    AwakerID = 15577,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13219] = {
    ID = 13219,
    CnID = "启灵@星之芽双生之星",
    BaseSortID = 92,
    PotencyName = "AwakerPotency_13219_PotencyName|枯萎之歌",
    PotencyDesc = "AwakerPotency_13219_PotencyDesc|「基础防御」获得的护盾提高 25%，获得与护盾等量的反击。",
    AwakerID = 15577,
    PotencyType = "PassiveSkill",
    FrontPotency = 13566,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13545] = {
    ID = 13545,
    CnID = "启灵@星之芽爱之摇篮",
    BaseSortID = 93,
    PotencyName = "AwakerPotency_13545_PotencyName|爱之摇篮",
    PotencyDesc = "AwakerPotency_13545_PotencyDesc|每次触发死亡抵抗时，对前排敌人触发 100％ 反击，本场战斗中每次触发死亡抵抗，就使触发反击倍率 +25%。",
    AwakerID = 15577,
    PotencyType = "PassiveSkill",
    EffectType = "BEAddState",
    Effect = {57417},
    FrontPotency = 13219,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13402] = {
    ID = 13402,
    CnID = "启灵@星之芽人格深化1",
    BaseSortID = 94,
    PotencyName = "AwakerPotency_13402_PotencyName|人格深化",
    AwakerID = 15577,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13545,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13401] = {
    ID = 13401,
    CnID = "启灵@星之芽人格深化2",
    BaseSortID = 95,
    PotencyName = "AwakerPotency_13401_PotencyName|人格深化",
    AwakerID = 15577,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13402,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13400] = {
    ID = 13400,
    CnID = "启灵@星之芽人格深化3",
    BaseSortID = 96,
    PotencyName = "AwakerPotency_13400_PotencyName|人格深化",
    AwakerID = 15577,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13401,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13406] = {
    ID = 13406,
    CnID = "启灵@星之芽人格深化4",
    BaseSortID = 97,
    PotencyName = "AwakerPotency_13406_PotencyName|破茧而生的新芽",
    PotencyDesc = "AwakerPotency_13406_PotencyDesc|使所有敌人临时降低等同于防御力 [Arg1]% 的力量（随星之摇篮等级提升而提升）。",
    AwakerID = 15577,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    EffectType1 = "UtlSkill_Promote",
    EffectPara = {
      "PotencySkillParam(4361,7,4,1)"
    },
    FrontPotency = 13400,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13405] = {
    ID = 13405,
    CnID = "启灵@星之芽人格深化5",
    BaseSortID = 98,
    PotencyName = "AwakerPotency_13405_PotencyName|人格深化",
    AwakerID = 15577,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13406,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13404] = {
    ID = 13404,
    CnID = "启灵@星之芽人格深化6",
    BaseSortID = 99,
    PotencyName = "AwakerPotency_13404_PotencyName|人格深化",
    AwakerID = 15577,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13405,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13403] = {
    ID = 13403,
    CnID = "启灵@星之芽人格深化7",
    BaseSortID = 100,
    PotencyName = "AwakerPotency_13403_PotencyName|人格深化",
    AwakerID = 15577,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13404,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13399] = {
    ID = 13399,
    CnID = "启灵@星之芽人格深化8",
    BaseSortID = 101,
    PotencyName = "AwakerPotency_13399_PotencyName|人格深化",
    AwakerID = 15577,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13403,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13398] = {
    ID = 13398,
    CnID = "启灵@星之芽人格深化9",
    BaseSortID = 102,
    PotencyName = "AwakerPotency_13398_PotencyName|人格深化",
    AwakerID = 15577,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13399,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13615] = {
    ID = 13615,
    CnID = "启灵@星之芽人格深化10",
    BaseSortID = 103,
    PotencyName = "AwakerPotency_13615_PotencyName|人格深化",
    AwakerID = 15577,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13398,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13614] = {
    ID = 13614,
    CnID = "启灵@星之芽人格深化11",
    BaseSortID = 104,
    PotencyName = "AwakerPotency_13614_PotencyName|人格深化",
    AwakerID = 15577,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13615,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13713] = {
    ID = 13713,
    CnID = "启灵@星之芽人格深化12",
    BaseSortID = 105,
    PotencyName = "AwakerPotency_13713_PotencyName|永芜的枯萎虹彩",
    PotencyDesc = "AwakerPotency_13713_PotencyDesc|灵知觉醒「无边星彩」获得强化，打出时立即永久偷取所有敌人等同于攻击力 25% 的力量。",
    AwakerID = 15577,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13614,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13231] = {
    ID = 13231,
    CnID = "启灵@无名诗篇蜷于烈火",
    BaseSortID = 106,
    PotencyName = "AwakerPotency_13231_PotencyName|蜷于烈火",
    PotencyDesc = "AwakerPotency_13231_PotencyDesc|「狂想诗篇」<VulnerabilityIconKeywords:易伤>全体敌方 1 回合，「哀恸诗篇」<WeaknessIconKeywords:虚弱>全体敌方 1 回合。",
    AwakerID = 15583,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13730] = {
    ID = 13730,
    CnID = "启灵@无名诗篇囚于暗室",
    BaseSortID = 107,
    PotencyName = "AwakerPotency_13730_PotencyName|囚于暗室",
    PotencyDesc = "AwakerPotency_13730_PotencyDesc|奥尔拉的所有诗篇均获得保留。",
    AwakerID = 15583,
    PotencyType = "PassiveSkill",
    FrontPotency = 13231,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13303] = {
    ID = 13303,
    CnID = "启灵@无名诗篇无奈何之笔墨",
    BaseSortID = 108,
    PotencyName = "AwakerPotency_13303_PotencyName|花与诗的重逢",
    PotencyDesc = "AwakerPotency_13303_PotencyDesc|每回合打出第一张诗篇时，奥尔拉获得 10 点狂气。「纷华篇章」对应情绪的效果提高由 150% 提高为 250%。",
    AwakerID = 15583,
    PotencyType = "PassiveSkill",
    EffectType = "BEAddState",
    Effect = {55113},
    FrontPotency = 13730,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13382] = {
    ID = 13382,
    CnID = "启灵@无名诗篇人格深化1",
    BaseSortID = 109,
    PotencyName = "AwakerPotency_13382_PotencyName|人格深化",
    AwakerID = 15583,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18151,
      5.6
    },
    FrontPotency = 13303,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13383] = {
    ID = 13383,
    CnID = "启灵@无名诗篇人格深化2",
    BaseSortID = 110,
    PotencyName = "AwakerPotency_13383_PotencyName|人格深化",
    AwakerID = 15583,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18151,
      5.6
    },
    FrontPotency = 13382,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13384] = {
    ID = 13384,
    CnID = "启灵@无名诗篇人格深化3",
    BaseSortID = 111,
    PotencyName = "AwakerPotency_13384_PotencyName|人格深化",
    AwakerID = 15583,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18151,
      5.6
    },
    FrontPotency = 13383,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13377] = {
    ID = 13377,
    CnID = "启灵@无名诗篇人格深化4",
    BaseSortID = 112,
    PotencyName = "AwakerPotency_13377_PotencyName|墨染成诗",
    PotencyDesc = "AwakerPotency_13377_PotencyDesc|对应情绪的效果加成提高为 600%。获得 3 层万能「隐喻」：会在下次诗篇跃迁时被视为任意情绪的「隐喻」使用并消耗。",
    AwakerID = 15583,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18151,
      5.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13384,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13378] = {
    ID = 13378,
    CnID = "启灵@无名诗篇人格深化5",
    BaseSortID = 113,
    PotencyName = "AwakerPotency_13378_PotencyName|人格深化",
    AwakerID = 15583,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18151,
      5.6
    },
    FrontPotency = 13377,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13379] = {
    ID = 13379,
    CnID = "启灵@无名诗篇人格深化6",
    BaseSortID = 114,
    PotencyName = "AwakerPotency_13379_PotencyName|人格深化",
    AwakerID = 15583,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18151,
      5.6
    },
    FrontPotency = 13378,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13380] = {
    ID = 13380,
    CnID = "启灵@无名诗篇人格深化7",
    BaseSortID = 115,
    PotencyName = "AwakerPotency_13380_PotencyName|人格深化",
    AwakerID = 15583,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18151,
      5.6
    },
    FrontPotency = 13379,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13389] = {
    ID = 13389,
    CnID = "启灵@无名诗篇人格深化8",
    BaseSortID = 116,
    PotencyName = "AwakerPotency_13389_PotencyName|人格深化",
    AwakerID = 15583,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18151,
      5.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13380,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13390] = {
    ID = 13390,
    CnID = "启灵@无名诗篇人格深化9",
    BaseSortID = 117,
    PotencyName = "AwakerPotency_13390_PotencyName|人格深化",
    AwakerID = 15583,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18151,
      5.6
    },
    FrontPotency = 13389,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13396] = {
    ID = 13396,
    CnID = "启灵@无名诗篇人格深化10",
    BaseSortID = 118,
    PotencyName = "AwakerPotency_13396_PotencyName|人格深化",
    AwakerID = 15583,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18151,
      5.6
    },
    FrontPotency = 13390,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13397] = {
    ID = 13397,
    CnID = "启灵@无名诗篇人格深化11",
    BaseSortID = 119,
    PotencyName = "AwakerPotency_13397_PotencyName|人格深化",
    AwakerID = 15583,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18151,
      5.6
    },
    FrontPotency = 13396,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13395] = {
    ID = 13395,
    CnID = "启灵@无名诗篇人格深化12",
    BaseSortID = 120,
    PotencyName = "AwakerPotency_13395_PotencyName|余烬里的春天",
    PotencyDesc = "AwakerPotency_13395_PotencyDesc|灵知觉醒「诗册序言」获得强化，发动湮灭后奥尔拉本回合下一张指令卡触发跃迁效果。每当奥尔拉消耗 3 层或以上隐喻，使当前情绪光环效果临时提高 35%，无法叠加。",
    AwakerID = 15583,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18151,
      5.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13397,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13336] = {
    ID = 13336,
    CnID = "启灵@凸月侍女女仆守则",
    BaseSortID = 121,
    PotencyName = "AwakerPotency_13336_PotencyName|女仆守则",
    PotencyDesc = "AwakerPotency_13336_PotencyDesc|「静默守望」最大可叠加次数提高至 3。",
    AwakerID = 15571,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13280] = {
    ID = 13280,
    CnID = "启灵@凸月侍女启明_智",
    BaseSortID = 122,
    PotencyName = "AwakerPotency_13280_PotencyName|在糖霜里",
    PotencyDesc = "AwakerPotency_13280_PotencyDesc|「蟾蜍炖菜」的中毒与回复生命效果提高 50%。",
    AwakerID = 15571,
    PotencyType = "PassiveSkill",
    FrontPotency = 13336,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_return.png",
    IfMaxPotency = false
  },
  [13343] = {
    ID = 13343,
    CnID = "启灵@凸月侍女发酵料理书",
    BaseSortID = 123,
    PotencyName = "AwakerPotency_13343_PotencyName|发酵料理书",
    PotencyDesc = "AwakerPotency_13343_PotencyDesc|「奇妙料理」有 50% 概率能够随机触发一个奇妙效果，这些效果包括自身获得 10 点狂气，其他友方获得 5 点狂气、易伤所有敌人 1 回合，虚弱所有敌人 1 回合、 抽 1 张牌、获得 200  点银钥能量。",
    AwakerID = 15571,
    PotencyType = "PassiveSkill",
    FrontPotency = 13280,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13290] = {
    ID = 13290,
    CnID = "启灵@凸月侍女人格深化1",
    BaseSortID = 124,
    PotencyName = "AwakerPotency_13290_PotencyName|人格深化",
    AwakerID = 15571,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      22207,
      0.8
    },
    FrontPotency = 13343,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13293] = {
    ID = 13293,
    CnID = "启灵@凸月侍女人格深化2",
    BaseSortID = 125,
    PotencyName = "AwakerPotency_13293_PotencyName|人格深化",
    AwakerID = 15571,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      22207,
      0.8
    },
    FrontPotency = 13290,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13292] = {
    ID = 13292,
    CnID = "启灵@凸月侍女人格深化3",
    BaseSortID = 126,
    PotencyName = "AwakerPotency_13292_PotencyName|人格深化",
    AwakerID = 15571,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      22207,
      0.8
    },
    FrontPotency = 13293,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13295] = {
    ID = 13295,
    CnID = "启灵@凸月侍女人格深化4",
    BaseSortID = 127,
    PotencyName = "AwakerPotency_13295_PotencyName|丰盛餐点",
    PotencyDesc = "AwakerPotency_13295_PotencyDesc|将<DerivativeCardKeywords_43:「奇妙料理」>洗入抽牌堆和弃牌堆各 1 张。",
    AwakerID = 15571,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      22207,
      0.8
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13292,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13294] = {
    ID = 13294,
    CnID = "启灵@凸月侍女人格深化5",
    BaseSortID = 128,
    PotencyName = "AwakerPotency_13294_PotencyName|人格深化",
    AwakerID = 15571,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      22207,
      0.8
    },
    FrontPotency = 13295,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13297] = {
    ID = 13297,
    CnID = "启灵@凸月侍女人格深化6",
    BaseSortID = 129,
    PotencyName = "AwakerPotency_13297_PotencyName|人格深化",
    AwakerID = 15571,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      22207,
      0.8
    },
    FrontPotency = 13294,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13296] = {
    ID = 13296,
    CnID = "启灵@凸月侍女人格深化7",
    BaseSortID = 130,
    PotencyName = "AwakerPotency_13296_PotencyName|人格深化",
    AwakerID = 15571,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      22207,
      0.8
    },
    FrontPotency = 13297,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13299] = {
    ID = 13299,
    CnID = "启灵@凸月侍女人格深化8",
    BaseSortID = 131,
    PotencyName = "AwakerPotency_13299_PotencyName|人格深化",
    AwakerID = 15571,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      22207,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13296,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13298] = {
    ID = 13298,
    CnID = "启灵@凸月侍女人格深化9",
    BaseSortID = 132,
    PotencyName = "AwakerPotency_13298_PotencyName|人格深化",
    AwakerID = 15571,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      22207,
      0.8
    },
    FrontPotency = 13299,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13386] = {
    ID = 13386,
    CnID = "启灵@凸月侍女人格深化10",
    BaseSortID = 133,
    PotencyName = "AwakerPotency_13386_PotencyName|人格深化",
    AwakerID = 15571,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      22207,
      0.8
    },
    FrontPotency = 13298,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13385] = {
    ID = 13385,
    CnID = "启灵@凸月侍女人格深化11",
    BaseSortID = 134,
    PotencyName = "AwakerPotency_13385_PotencyName|人格深化",
    AwakerID = 15571,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      22207,
      0.8
    },
    FrontPotency = 13386,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13388] = {
    ID = 13388,
    CnID = "启灵@凸月侍女人格深化12",
    BaseSortID = 135,
    PotencyName = "AwakerPotency_13388_PotencyName|雾月晚宴",
    PotencyDesc = "AwakerPotency_13388_PotencyDesc|灵知觉醒「凸月之舞」获得强化，回合结束时若保留了珈伦的指令卡，也会触发 2 次回复生命和狂气效果。",
    AwakerID = 15571,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      22207,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13385,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13107] = {
    ID = 13107,
    CnID = "启灵@甜蜜恶鬼享受疼痛",
    BaseSortID = 136,
    PotencyName = "AwakerPotency_13107_PotencyName|享受疼痛",
    PotencyDesc = "AwakerPotency_13107_PotencyDesc|「基础打击」获得 50% 伤害的临时反击。「基础防御」获得等同于攻击力 [Arg1]% 的反击。",
    AwakerID = 15560,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4360,1,3,1)"
    },
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13115] = {
    ID = 13115,
    CnID = "启灵@甜蜜恶鬼欲火焚身",
    BaseSortID = 137,
    PotencyName = "AwakerPotency_13115_PotencyName|欲火焚身",
    PotencyDesc = "AwakerPotency_13115_PotencyDesc|「灼燃蜡滴之欲」获得 20 点狂气。",
    AwakerID = 15560,
    PotencyType = "PassiveSkill",
    FrontPotency = 13107,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_return.png",
    IfMaxPotency = false
  },
  [13443] = {
    ID = 13443,
    CnID = "启灵@甜蜜恶鬼你不乖",
    BaseSortID = 138,
    PotencyName = "AwakerPotency_13443_PotencyName|你不乖",
    PotencyDesc = "AwakerPotency_13443_PotencyDesc|「蜜糖色悲惨幻象」基础伤害翻倍，并获得等同于攻击力 [Arg1]% 的反击。",
    AwakerID = 15560,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4384,3,3,1)"
    },
    FrontPotency = 13115,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13110] = {
    ID = 13110,
    CnID = "启灵@甜蜜恶鬼人格深化1",
    BaseSortID = 139,
    PotencyName = "AwakerPotency_13110_PotencyName|人格深化",
    AwakerID = 15560,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13443,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13622] = {
    ID = 13622,
    CnID = "启灵@甜蜜恶鬼人格深化2",
    BaseSortID = 140,
    PotencyName = "AwakerPotency_13622_PotencyName|人格深化",
    AwakerID = 15560,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13110,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13621] = {
    ID = 13621,
    CnID = "启灵@甜蜜恶鬼人格深化3",
    BaseSortID = 141,
    PotencyName = "AwakerPotency_13621_PotencyName|人格深化",
    AwakerID = 15560,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13622,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13620] = {
    ID = 13620,
    CnID = "启灵@甜蜜恶鬼人格深化4",
    BaseSortID = 142,
    PotencyName = "AwakerPotency_13620_PotencyName|甘之如饴",
    PotencyDesc = "AwakerPotency_13620_PotencyDesc|造成伤害前对全体敌方施加 1 层「易伤」，获得等同于攻击力 [Arg1]% 的反击。",
    AwakerID = 15560,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    EffectPara = {
      "PotencySkillParam(4384,7,4,1)"
    },
    FrontPotency = 13621,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13619] = {
    ID = 13619,
    CnID = "启灵@甜蜜恶鬼人格深化5",
    BaseSortID = 143,
    PotencyName = "AwakerPotency_13619_PotencyName|人格深化",
    AwakerID = 15560,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13620,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13618] = {
    ID = 13618,
    CnID = "启灵@甜蜜恶鬼人格深化6",
    BaseSortID = 144,
    PotencyName = "AwakerPotency_13618_PotencyName|人格深化",
    AwakerID = 15560,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13619,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13617] = {
    ID = 13617,
    CnID = "启灵@甜蜜恶鬼人格深化7",
    BaseSortID = 145,
    PotencyName = "AwakerPotency_13617_PotencyName|人格深化",
    AwakerID = 15560,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13618,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13632] = {
    ID = 13632,
    CnID = "启灵@甜蜜恶鬼人格深化8",
    BaseSortID = 146,
    PotencyName = "AwakerPotency_13632_PotencyName|人格深化",
    AwakerID = 15560,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13617,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13121] = {
    ID = 13121,
    CnID = "启灵@甜蜜恶鬼人格深化9",
    BaseSortID = 147,
    PotencyName = "AwakerPotency_13121_PotencyName|人格深化",
    AwakerID = 15560,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13632,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13171] = {
    ID = 13171,
    CnID = "启灵@甜蜜恶鬼人格深化10",
    BaseSortID = 148,
    PotencyName = "AwakerPotency_13171_PotencyName|人格深化",
    AwakerID = 15560,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13121,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13170] = {
    ID = 13170,
    CnID = "启灵@甜蜜恶鬼人格深化11",
    BaseSortID = 149,
    PotencyName = "AwakerPotency_13170_PotencyName|人格深化",
    AwakerID = 15560,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13171,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13291] = {
    ID = 13291,
    CnID = "启灵@甜蜜恶鬼人格深化12",
    BaseSortID = 150,
    PotencyName = "AwakerPotency_13291_PotencyName|疼爱惩戒宣言",
    PotencyDesc = "AwakerPotency_13291_PotencyDesc|灵知觉醒「施与受」获得强化，潘狄娅获得永久反击时获得 3% 等量的力量。",
    AwakerID = 15560,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13170,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13699] = {
    ID = 13699,
    CnID = "启灵@睡莲海之躯体",
    BaseSortID = 151,
    PotencyName = "AwakerPotency_13699_PotencyName|海之躯体",
    PotencyDesc = "AwakerPotency_13699_PotencyDesc|「丧钟遥鸣」施加的中毒提高 100%，获得等同于防御力 [Arg1]% 的护盾（效果随「丧钟遥鸣」的等级提高）。",
    AwakerID = 15580,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4154,1,2,1)"
    },
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13355] = {
    ID = 13355,
    CnID = "启灵@睡莲无声浸润",
    BaseSortID = 152,
    PotencyName = "AwakerPotency_13355_PotencyName|无声浸润",
    PotencyDesc = "AwakerPotency_13355_PotencyDesc|「夜潮汹涌」造成的伤害提高 50%，每回合打出的前 3 张症状卡，使「夜潮汹涌」在本场战斗中的伤害提高等同于攻击力的 20％。",
    AwakerID = 15580,
    PotencyType = "PassiveSkill",
    FrontPotency = 13699,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_return.png",
    IfMaxPotency = false
  },
  [13627] = {
    ID = 13627,
    CnID = "启灵@睡莲雪浪浮花",
    BaseSortID = 153,
    PotencyName = "AwakerPotency_13627_PotencyName|雪浪浮花",
    PotencyDesc = "AwakerPotency_13627_PotencyDesc|释放「自我的葬仪」后，在本场战斗中使「自我的葬仪」施加的中毒层数提高等同于攻击力 [Arg1]%（效果随「自我的葬仪」的等级提高）。",
    AwakerID = 15580,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4075,3,3,1)"
    },
    FrontPotency = 13355,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13068] = {
    ID = 13068,
    CnID = "启灵@睡莲人格深化1",
    BaseSortID = 154,
    PotencyName = "AwakerPotency_13068_PotencyName|人格深化",
    AwakerID = 15580,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      18142,
      1.6
    },
    FrontPotency = 13627,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13069] = {
    ID = 13069,
    CnID = "启灵@睡莲人格深化2",
    BaseSortID = 155,
    PotencyName = "AwakerPotency_13069_PotencyName|人格深化",
    AwakerID = 15580,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      18142,
      1.6
    },
    FrontPotency = 13068,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13070] = {
    ID = 13070,
    CnID = "启灵@睡莲人格深化3",
    BaseSortID = 156,
    PotencyName = "AwakerPotency_13070_PotencyName|人格深化",
    AwakerID = 15580,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      18142,
      1.6
    },
    FrontPotency = 13069,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13064] = {
    ID = 13064,
    CnID = "启灵@睡莲人格深化4",
    BaseSortID = 157,
    PotencyName = "AwakerPotency_13064_PotencyName|永沦深海的葬仪",
    PotencyDesc = "AwakerPotency_13064_PotencyDesc|使宁菲亚造成的中毒提高 50%，持续 3 回合。",
    AwakerID = 15580,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      18142,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13070,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13065] = {
    ID = 13065,
    CnID = "启灵@睡莲人格深化5",
    BaseSortID = 158,
    PotencyName = "AwakerPotency_13065_PotencyName|人格深化",
    AwakerID = 15580,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      18142,
      1.6
    },
    FrontPotency = 13064,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13066] = {
    ID = 13066,
    CnID = "启灵@睡莲人格深化6",
    BaseSortID = 159,
    PotencyName = "AwakerPotency_13066_PotencyName|人格深化",
    AwakerID = 15580,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      18142,
      1.6
    },
    FrontPotency = 13065,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13067] = {
    ID = 13067,
    CnID = "启灵@睡莲人格深化7",
    BaseSortID = 160,
    PotencyName = "AwakerPotency_13067_PotencyName|人格深化",
    AwakerID = 15580,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      18142,
      1.6
    },
    FrontPotency = 13066,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13061] = {
    ID = 13061,
    CnID = "启灵@睡莲人格深化8",
    BaseSortID = 161,
    PotencyName = "AwakerPotency_13061_PotencyName|人格深化",
    AwakerID = 15580,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      18142,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13067,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13062] = {
    ID = 13062,
    CnID = "启灵@睡莲人格深化9",
    BaseSortID = 162,
    PotencyName = "AwakerPotency_13062_PotencyName|人格深化",
    AwakerID = 15580,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      18142,
      1.6
    },
    FrontPotency = 13061,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13230] = {
    ID = 13230,
    CnID = "启灵@睡莲人格深化10",
    BaseSortID = 163,
    PotencyName = "AwakerPotency_13230_PotencyName|人格深化",
    AwakerID = 15580,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      18142,
      1.6
    },
    FrontPotency = 13062,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13232] = {
    ID = 13232,
    CnID = "启灵@睡莲人格深化11",
    BaseSortID = 164,
    PotencyName = "AwakerPotency_13232_PotencyName|人格深化",
    AwakerID = 15580,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      18142,
      1.6
    },
    FrontPotency = 13230,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13427] = {
    ID = 13427,
    CnID = "启灵@睡莲人格深化12",
    BaseSortID = 165,
    PotencyName = "AwakerPotency_13427_PotencyName|神思归流",
    PotencyDesc = "AwakerPotency_13427_PotencyDesc|灵知觉醒「沉逝苦海」获得强化，回合结束时宁菲亚造成的中毒额外提高 20%。",
    AwakerID = 15580,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      18142,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13232,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13307] = {
    ID = 13307,
    CnID = "启灵@守梦人孤独桅杆",
    BaseSortID = 166,
    PotencyName = "AwakerPotency_13307_PotencyName|孤独桅杆",
    PotencyDesc = "AwakerPotency_13307_PotencyDesc|「永存的幻影」获得保留，回复效果提高 25%。",
    AwakerID = 15566,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13725] = {
    ID = 13725,
    CnID = "启灵@守梦人先祖的指引",
    BaseSortID = 167,
    PotencyName = "AwakerPotency_13725_PotencyName|先祖的指引",
    PotencyDesc = "AwakerPotency_13725_PotencyDesc|「纯白梦境」每保留 1 回合，下次打出时回复生命就额外提高等同于体质的 [Arg1]%（效果随「纯白梦境」的等级提升）。",
    AwakerID = 15566,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4109,2,2,1)"
    },
    FrontPotency = 13307,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13724] = {
    ID = 13724,
    CnID = "启灵@守梦人无喜无悲",
    BaseSortID = 168,
    PotencyName = "AwakerPotency_13724_PotencyName|无喜无悲",
    PotencyDesc = "AwakerPotency_13724_PotencyDesc|「不死的极乐鸟」触发复活后，所有唤醒体获得 25 点狂气，并间隔 6 回合后可再次施加复活效果。",
    AwakerID = 15566,
    PotencyType = "PassiveSkill",
    FrontPotency = 13725,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13117] = {
    ID = 13117,
    CnID = "启灵@守梦人人格深化1",
    BaseSortID = 169,
    PotencyName = "AwakerPotency_13117_PotencyName|人格深化",
    AwakerID = 15566,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13724,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13281] = {
    ID = 13281,
    CnID = "启灵@守梦人人格深化2",
    BaseSortID = 170,
    PotencyName = "AwakerPotency_13281_PotencyName|人格深化",
    AwakerID = 15566,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13117,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13282] = {
    ID = 13282,
    CnID = "启灵@守梦人人格深化3",
    BaseSortID = 171,
    PotencyName = "AwakerPotency_13282_PotencyName|人格深化",
    AwakerID = 15566,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13281,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13287] = {
    ID = 13287,
    CnID = "启灵@守梦人人格深化4",
    BaseSortID = 172,
    PotencyName = "AwakerPotency_13287_PotencyName|神女的守望",
    PotencyDesc = "AwakerPotency_13287_PotencyDesc|将 3 张回复提高 50% 的「纯白梦境」置入手中并附加消耗。",
    AwakerID = 15566,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13282,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13122] = {
    ID = 13122,
    CnID = "启灵@守梦人人格深化5",
    BaseSortID = 173,
    PotencyName = "AwakerPotency_13122_PotencyName|人格深化",
    AwakerID = 15566,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13287,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13285] = {
    ID = 13285,
    CnID = "启灵@守梦人人格深化6",
    BaseSortID = 174,
    PotencyName = "AwakerPotency_13285_PotencyName|人格深化",
    AwakerID = 15566,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13122,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13119] = {
    ID = 13119,
    CnID = "启灵@守梦人人格深化7",
    BaseSortID = 175,
    PotencyName = "AwakerPotency_13119_PotencyName|人格深化",
    AwakerID = 15566,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13285,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13277] = {
    ID = 13277,
    CnID = "启灵@守梦人人格深化8",
    BaseSortID = 176,
    PotencyName = "AwakerPotency_13277_PotencyName|人格深化",
    AwakerID = 15566,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13119,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13278] = {
    ID = 13278,
    CnID = "启灵@守梦人人格深化9",
    BaseSortID = 177,
    PotencyName = "AwakerPotency_13278_PotencyName|人格深化",
    AwakerID = 15566,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13277,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13091] = {
    ID = 13091,
    CnID = "启灵@守梦人人格深化10",
    BaseSortID = 178,
    PotencyName = "AwakerPotency_13091_PotencyName|人格深化",
    AwakerID = 15566,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13278,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13092] = {
    ID = 13092,
    CnID = "启灵@守梦人人格深化11",
    BaseSortID = 179,
    PotencyName = "AwakerPotency_13092_PotencyName|人格深化",
    AwakerID = 15566,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13091,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13093] = {
    ID = 13093,
    CnID = "启灵@守梦人人格深化12",
    BaseSortID = 180,
    PotencyName = "AwakerPotency_13093_PotencyName|空想的卡修利亚",
    PotencyDesc = "AwakerPotency_13093_PotencyDesc|灵知觉醒「庇佑之力」获得强化，触发「不死的极乐鸟」复活时立即获得希莱斯特攻击力 150% 的临时触腕伤害，首领战效果翻倍。",
    AwakerID = 15566,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13092,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13086] = {
    ID = 13086,
    CnID = "启灵@石之眼目击证人",
    BaseSortID = 181,
    PotencyName = "AwakerPotency_13086_PotencyName|目击证人",
    PotencyDesc = "AwakerPotency_13086_PotencyDesc|「基础打击」的目标每有 1 层易伤状态，胚胎融合+5，最多 30。",
    AwakerID = 15591,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13580] = {
    ID = 13580,
    CnID = "启灵@石之眼糖果甜香",
    BaseSortID = 182,
    PotencyName = "AwakerPotency_13580_PotencyName|糖果甜香",
    PotencyDesc = "AwakerPotency_13580_PotencyDesc|目标每有 1 层易伤状态，就额外使「石质分解」最终伤害提高 5%，至多提高500%。",
    AwakerID = 15591,
    PotencyType = "PassiveSkill",
    FrontPotency = 13086,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13120] = {
    ID = 13120,
    CnID = "启灵@石之眼夜空飞鸟",
    BaseSortID = 183,
    PotencyName = "AwakerPotency_13120_PotencyName|夜空飞鸟",
    PotencyDesc = "AwakerPotency_13120_PotencyDesc|每当进行吞噬时，将「小小愿望」从弃牌堆置入手牌，并使其算力消耗变为 0 点。",
    AwakerID = 15591,
    PotencyType = "PassiveSkill",
    FrontPotency = 13580,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13483] = {
    ID = 13483,
    CnID = "启灵@石之眼人格深化1",
    BaseSortID = 184,
    PotencyName = "AwakerPotency_13483_PotencyName|人格深化",
    AwakerID = 15591,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18139,
      2.4
    },
    FrontPotency = 13120,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13484] = {
    ID = 13484,
    CnID = "启灵@石之眼人格深化2",
    BaseSortID = 185,
    PotencyName = "AwakerPotency_13484_PotencyName|人格深化",
    AwakerID = 15591,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18139,
      2.4
    },
    FrontPotency = 13483,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13485] = {
    ID = 13485,
    CnID = "启灵@石之眼人格深化3",
    BaseSortID = 186,
    PotencyName = "AwakerPotency_13485_PotencyName|人格深化",
    AwakerID = 15591,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18139,
      2.4
    },
    FrontPotency = 13484,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13479] = {
    ID = 13479,
    CnID = "启灵@石之眼人格深化4",
    BaseSortID = 187,
    PotencyName = "AwakerPotency_13479_PotencyName|超越万古的凝视",
    PotencyDesc = "AwakerPotency_13479_PotencyDesc|本回合所有唤醒体造成的最终伤害提高 25%。",
    AwakerID = 15591,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13485,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13480] = {
    ID = 13480,
    CnID = "启灵@石之眼人格深化5",
    BaseSortID = 188,
    PotencyName = "AwakerPotency_13480_PotencyName|人格深化",
    AwakerID = 15591,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18139,
      2.4
    },
    FrontPotency = 13479,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13481] = {
    ID = 13481,
    CnID = "启灵@石之眼人格深化6",
    BaseSortID = 189,
    PotencyName = "AwakerPotency_13481_PotencyName|人格深化",
    AwakerID = 15591,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18139,
      2.4
    },
    FrontPotency = 13480,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13482] = {
    ID = 13482,
    CnID = "启灵@石之眼人格深化7",
    BaseSortID = 190,
    PotencyName = "AwakerPotency_13482_PotencyName|人格深化",
    AwakerID = 15591,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18139,
      2.4
    },
    FrontPotency = 13481,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13477] = {
    ID = 13477,
    CnID = "启灵@石之眼人格深化8",
    BaseSortID = 191,
    PotencyName = "AwakerPotency_13477_PotencyName|人格深化",
    AwakerID = 15591,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13482,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13478] = {
    ID = 13478,
    CnID = "启灵@石之眼人格深化9",
    BaseSortID = 192,
    PotencyName = "AwakerPotency_13478_PotencyName|人格深化",
    AwakerID = 15591,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18139,
      2.4
    },
    FrontPotency = 13477,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13147] = {
    ID = 13147,
    CnID = "启灵@石之眼人格深化10",
    BaseSortID = 193,
    PotencyName = "AwakerPotency_13147_PotencyName|人格深化",
    AwakerID = 15591,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18139,
      2.4
    },
    FrontPotency = 13478,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13148] = {
    ID = 13148,
    CnID = "启灵@石之眼人格深化11",
    BaseSortID = 194,
    PotencyName = "AwakerPotency_13148_PotencyName|人格深化",
    AwakerID = 15591,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18139,
      2.4
    },
    FrontPotency = 13147,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13145] = {
    ID = 13145,
    CnID = "启灵@石之眼人格深化12",
    BaseSortID = 195,
    PotencyName = "AwakerPotency_13145_PotencyName|凝刻的眼泪",
    PotencyDesc = "AwakerPotency_13145_PotencyDesc|灵知觉醒「凝滞诅咒」获得强化，艾继丝释放狂气爆发后使自身下一张「防御」生效 3 次，额外使狂气爆发基础伤害提高 50%。",
    AwakerID = 15591,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13148,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13358] = {
    ID = 13358,
    CnID = "启灵@深海淑女隐忍的叛逆",
    BaseSortID = 196,
    PotencyName = "AwakerPotency_13358_PotencyName|隐忍的叛逆",
    PotencyDesc = "AwakerPotency_13358_PotencyDesc|「螺湮逆流」获得保留。每有 2 条触腕额外造成 1 次伤害。",
    AwakerID = 15576,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13082] = {
    ID = 13082,
    CnID = "启灵@深海淑女解放与自由之触",
    BaseSortID = 197,
    PotencyName = "AwakerPotency_13082_PotencyName|无法剥离之血",
    PotencyDesc = "AwakerPotency_13082_PotencyDesc|「基础打击」获得等同于墨菲攻击力 [Arg1]% 的触腕伤害，「基础防御」获得等同于墨菲攻击力 [Arg2]% 的触腕伤害。（效果随「打击」和「防御」的等级提升）",
    AwakerID = 15576,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4666,2,3,1)",
      "PotencySkillParam(4169,2,3,1)"
    },
    FrontPotency = 13358,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13339] = {
    ID = 13339,
    CnID = "启灵@深海淑女红茶与蛋糕",
    BaseSortID = 198,
    PotencyName = "AwakerPotency_13339_PotencyName|解放与自由之触",
    PotencyDesc = "AwakerPotency_13339_PotencyDesc|回合结束时墨菲获得 5 点狂气。释放钥令后，移除 2% 最大生命的「献祭」。",
    AwakerID = 15576,
    PotencyType = "PassiveSkill",
    EffectType = "BEAddState",
    Effect = {35858},
    FrontPotency = 13082,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13257] = {
    ID = 13257,
    CnID = "启灵@深海淑女人格深化1",
    BaseSortID = 199,
    PotencyName = "AwakerPotency_13257_PotencyName|人格深化",
    AwakerID = 15576,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13339,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13259] = {
    ID = 13259,
    CnID = "启灵@深海淑女人格深化2",
    BaseSortID = 200,
    PotencyName = "AwakerPotency_13259_PotencyName|人格深化",
    AwakerID = 15576,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13257,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13258] = {
    ID = 13258,
    CnID = "启灵@深海淑女人格深化3",
    BaseSortID = 201,
    PotencyName = "AwakerPotency_13258_PotencyName|人格深化",
    AwakerID = 15576,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13259,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13261] = {
    ID = 13261,
    CnID = "启灵@深海淑女人格深化4",
    BaseSortID = 202,
    PotencyName = "AwakerPotency_13261_PotencyName|自由誓愿",
    PotencyDesc = "AwakerPotency_13261_PotencyDesc|回合开始时获得防御力 60% 的护盾和 15% 攻击力的触腕伤害，生成 2 条临时触腕，持续 3 回合。",
    AwakerID = 15576,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13258,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13260] = {
    ID = 13260,
    CnID = "启灵@深海淑女人格深化5",
    BaseSortID = 203,
    PotencyName = "AwakerPotency_13260_PotencyName|人格深化",
    AwakerID = 15576,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13261,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13263] = {
    ID = 13263,
    CnID = "启灵@深海淑女人格深化6",
    BaseSortID = 204,
    PotencyName = "AwakerPotency_13263_PotencyName|人格深化",
    AwakerID = 15576,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13260,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13262] = {
    ID = 13262,
    CnID = "启灵@深海淑女人格深化7",
    BaseSortID = 205,
    PotencyName = "AwakerPotency_13262_PotencyName|人格深化",
    AwakerID = 15576,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13263,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13265] = {
    ID = 13265,
    CnID = "启灵@深海淑女人格深化8",
    BaseSortID = 206,
    PotencyName = "AwakerPotency_13265_PotencyName|人格深化",
    AwakerID = 15576,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13262,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13264] = {
    ID = 13264,
    CnID = "启灵@深海淑女人格深化9",
    BaseSortID = 207,
    PotencyName = "AwakerPotency_13264_PotencyName|人格深化",
    AwakerID = 15576,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13265,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13326] = {
    ID = 13326,
    CnID = "启灵@深海淑女人格深化10",
    BaseSortID = 208,
    PotencyName = "AwakerPotency_13326_PotencyName|人格深化",
    AwakerID = 15576,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13264,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13325] = {
    ID = 13325,
    CnID = "启灵@深海淑女人格深化11",
    BaseSortID = 209,
    PotencyName = "AwakerPotency_13325_PotencyName|人格深化",
    AwakerID = 15576,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13326,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13328] = {
    ID = 13328,
    CnID = "启灵@深海淑女人格深化12",
    BaseSortID = 210,
    PotencyName = "AwakerPotency_13328_PotencyName|逆命天性",
    PotencyDesc = "AwakerPotency_13328_PotencyDesc|灵知觉醒「受造之物」获得强化，墨菲每回合首次打出的「螺湮逆流」伤害次数和每回合首次打出的「圣女作成」获得算力翻倍。",
    AwakerID = 15576,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13325,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13365] = {
    ID = 13365,
    CnID = "启灵@仁爱主祭代受苦难",
    BaseSortID = 211,
    PotencyName = "AwakerPotency_13365_PotencyName|代行神意",
    PotencyDesc = "AwakerPotency_13365_PotencyDesc|「基础防御」积攒等同于体质 [Arg1]% 的猩红熔炉回复量（随「防御」等级提高而提高）。本场战斗每积攒 2 点猩红熔炉回复量，就使「基础打击」伤害提高 1。",
    AwakerID = 15599,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4134,1,3,1)"
    },
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13227] = {
    ID = 13227,
    CnID = "启灵@仁爱主祭予以救赎",
    BaseSortID = 212,
    PotencyName = "AwakerPotency_13227_PotencyName|创生之语",
    PotencyDesc = "AwakerPotency_13227_PotencyDesc|「受祝骨血」胚胎融合 +15，积攒的猩红熔炉回复量随回合数提高，每回合提高等同于体质 [Arg1]%（随「受祝骨血」等级提高而提高）;「应消之苦」暴击率提高 25%，获得「预备1」。",
    AwakerID = 15599,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4460,2,3,1)"
    },
    FrontPotency = 13365,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13677] = {
    ID = 13677,
    CnID = "启灵@仁爱主祭回归本源",
    BaseSortID = 213,
    PotencyName = "AwakerPotency_13677_PotencyName|予以救赎",
    PotencyDesc = "AwakerPotency_13677_PotencyDesc|回合开始时积攒等同于体质 6% 的猩红熔炉回复量。狂气爆发「造主的庇佑」使萨尔瓦多获得 35% 临时暴击伤害。",
    AwakerID = 15599,
    PotencyType = "PassiveSkill",
    FrontPotency = 13227,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13539] = {
    ID = 13539,
    CnID = "启灵@仁爱主祭人格深化1",
    BaseSortID = 214,
    PotencyName = "AwakerPotency_13539_PotencyName|人格深化",
    AwakerID = 15599,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13677,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13551] = {
    ID = 13551,
    CnID = "启灵@仁爱主祭人格深化2",
    BaseSortID = 215,
    PotencyName = "AwakerPotency_13551_PotencyName|人格深化",
    AwakerID = 15599,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13539,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13537] = {
    ID = 13537,
    CnID = "启灵@仁爱主祭人格深化3",
    BaseSortID = 216,
    PotencyName = "AwakerPotency_13537_PotencyName|人格深化",
    AwakerID = 15599,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13551,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13544] = {
    ID = 13544,
    CnID = "启灵@仁爱主祭人格深化4",
    BaseSortID = 217,
    PotencyName = "AwakerPotency_13544_PotencyName|创生之祭",
    PotencyDesc = "AwakerPotency_13544_PotencyDesc|受到伤害转化猩红熔炉回复量的效果提高 250%，「基础打击」与「应消之苦」额外享受 100% 力量加成。本次探索内猩红熔炉上限提高最大生命的 2％，至多提高 10％。",
    AwakerID = 15599,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13537,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13543] = {
    ID = 13543,
    CnID = "启灵@仁爱主祭人格深化5",
    BaseSortID = 218,
    PotencyName = "AwakerPotency_13543_PotencyName|人格深化",
    AwakerID = 15599,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13544,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13542] = {
    ID = 13542,
    CnID = "启灵@仁爱主祭人格深化6",
    BaseSortID = 219,
    PotencyName = "AwakerPotency_13542_PotencyName|人格深化",
    AwakerID = 15599,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13543,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13541] = {
    ID = 13541,
    CnID = "启灵@仁爱主祭人格深化7",
    BaseSortID = 220,
    PotencyName = "AwakerPotency_13541_PotencyName|人格深化",
    AwakerID = 15599,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13542,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13535] = {
    ID = 13535,
    CnID = "启灵@仁爱主祭人格深化8",
    BaseSortID = 221,
    PotencyName = "AwakerPotency_13535_PotencyName|人格深化",
    AwakerID = 15599,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13541,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13534] = {
    ID = 13534,
    CnID = "启灵@仁爱主祭人格深化9",
    BaseSortID = 222,
    PotencyName = "AwakerPotency_13534_PotencyName|人格深化",
    AwakerID = 15599,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13535,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13599] = {
    ID = 13599,
    CnID = "启灵@仁爱主祭人格深化10",
    BaseSortID = 223,
    PotencyName = "AwakerPotency_13599_PotencyName|人格深化",
    AwakerID = 15599,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13534,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13598] = {
    ID = 13598,
    CnID = "启灵@仁爱主祭人格深化11",
    BaseSortID = 224,
    PotencyName = "AwakerPotency_13598_PotencyName|人格深化",
    AwakerID = 15599,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13599,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13560] = {
    ID = 13560,
    CnID = "启灵@仁爱主祭人格深化12",
    BaseSortID = 225,
    PotencyName = "AwakerPotency_13560_PotencyName|饲世的苦慈",
    PotencyDesc = "AwakerPotency_13560_PotencyDesc|灵知觉醒「赐福」获得强化，「造主的庇佑」和「受祝骨血」积攒的猩红熔炉提高 25%。「应消之苦」选择「超度」时每消耗 1% 最大生命的猩红熔炉所提高的最终伤害效果从 2% 提高为 5%。",
    AwakerID = 15599,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13598,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13449] = {
    ID = 13449,
    CnID = "启灵@青炎舞者翠色火种",
    BaseSortID = 226,
    PotencyName = "AwakerPotency_13449_PotencyName|翠色火种",
    PotencyDesc = "AwakerPotency_13449_PotencyDesc|「腐化绿炎」回合结束时若在手牌或超维空间，将会升级为「死灭绿炎」。",
    AwakerID = 15562,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13289] = {
    ID = 13289,
    CnID = "启灵@青炎舞者不朽绿炎",
    BaseSortID = 227,
    PotencyName = "AwakerPotency_13289_PotencyName|不朽绿炎",
    PotencyDesc = "AwakerPotency_13289_PotencyDesc|「基础打击」获得：施加 50% 伤害的中毒。「基础防御」获得：触发所有敌人 25% 的中毒。",
    AwakerID = 15562,
    PotencyType = "PassiveSkill",
    FrontPotency = 13449,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13127] = {
    ID = 13127,
    CnID = "启灵@青炎舞者最终黎明",
    BaseSortID = 228,
    PotencyName = "AwakerPotency_13127_PotencyName|最终黎明",
    PotencyDesc = "AwakerPotency_13127_PotencyDesc|「告死之舞」每弃掉 2 张牌就抽 1 张牌。",
    AwakerID = 15562,
    PotencyType = "PassiveSkill",
    FrontPotency = 13289,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13499] = {
    ID = 13499,
    CnID = "启灵@青炎舞者人格深化1",
    BaseSortID = 229,
    PotencyName = "AwakerPotency_13499_PotencyName|人格深化",
    AwakerID = 15562,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13127,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13500] = {
    ID = 13500,
    CnID = "启灵@青炎舞者人格深化2",
    BaseSortID = 230,
    PotencyName = "AwakerPotency_13500_PotencyName|人格深化",
    AwakerID = 15562,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13499,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13501] = {
    ID = 13501,
    CnID = "启灵@青炎舞者人格深化3",
    BaseSortID = 231,
    PotencyName = "AwakerPotency_13501_PotencyName|人格深化",
    AwakerID = 15562,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13500,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13495] = {
    ID = 13495,
    CnID = "启灵@青炎舞者人格深化4",
    BaseSortID = 232,
    PotencyName = "AwakerPotency_13495_PotencyName|死兆降临",
    PotencyDesc = "AwakerPotency_13495_PotencyDesc|将手牌中所有的「绿炎」与「腐化绿炎」升级为「死灭绿炎」，之后 3 个回合，每回合开始时重复 1 次该效果。",
    AwakerID = 15562,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13501,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13496] = {
    ID = 13496,
    CnID = "启灵@青炎舞者人格深化5",
    BaseSortID = 233,
    PotencyName = "AwakerPotency_13496_PotencyName|人格深化",
    AwakerID = 15562,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13495,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13497] = {
    ID = 13497,
    CnID = "启灵@青炎舞者人格深化6",
    BaseSortID = 234,
    PotencyName = "AwakerPotency_13497_PotencyName|人格深化",
    AwakerID = 15562,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13496,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13498] = {
    ID = 13498,
    CnID = "启灵@青炎舞者人格深化7",
    BaseSortID = 235,
    PotencyName = "AwakerPotency_13498_PotencyName|人格深化",
    AwakerID = 15562,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13497,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13503] = {
    ID = 13503,
    CnID = "启灵@青炎舞者人格深化8",
    BaseSortID = 236,
    PotencyName = "AwakerPotency_13503_PotencyName|人格深化",
    AwakerID = 15562,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13498,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13504] = {
    ID = 13504,
    CnID = "启灵@青炎舞者人格深化9",
    BaseSortID = 237,
    PotencyName = "AwakerPotency_13504_PotencyName|人格深化",
    AwakerID = 15562,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13503,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13088] = {
    ID = 13088,
    CnID = "启灵@青炎舞者人格深化10",
    BaseSortID = 238,
    PotencyName = "AwakerPotency_13088_PotencyName|人格深化",
    AwakerID = 15562,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13504,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13089] = {
    ID = 13089,
    CnID = "启灵@青炎舞者人格深化11",
    BaseSortID = 239,
    PotencyName = "AwakerPotency_13089_PotencyName|人格深化",
    AwakerID = 15562,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13088,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13087] = {
    ID = 13087,
    CnID = "启灵@青炎舞者人格深化12",
    BaseSortID = 240,
    PotencyName = "AwakerPotency_13087_PotencyName|燃烧的致礼",
    PotencyDesc = "AwakerPotency_13087_PotencyDesc|灵知觉醒「翡翠映像」获得强化，莉兹每造成 3 次伤害还会使莉兹本场战斗造成的伤害提高攻击力的 15%。",
    AwakerID = 15562,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13089,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13144] = {
    ID = 13144,
    CnID = "启灵@迁移者黑暗恐惧",
    BaseSortID = 241,
    PotencyName = "AwakerPotency_13144_PotencyName|黑暗恐惧",
    PotencyDesc = "AwakerPotency_13144_PotencyDesc|「基础打击」与「能量射线」造成的伤害享受 50% 反击加成。",
    AwakerID = 15579,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13322] = {
    ID = 13322,
    CnID = "启灵@迁移者遗失故土",
    BaseSortID = 242,
    PotencyName = "AwakerPotency_13322_PotencyName|遗失故土",
    PotencyDesc = "AwakerPotency_13322_PotencyDesc|「精神重建」每弃掉 1 张牌，下回合获得等同于防御力 [Arg1]% 的护盾（效果随「精神重建」的等级提升）。若触发跃迁立即抽 1 张牌。",
    AwakerID = 15579,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4329,2,2,1)"
    },
    FrontPotency = 13144,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13505] = {
    ID = 13505,
    CnID = "启灵@迁移者死而后生",
    BaseSortID = 243,
    PotencyName = "AwakerPotency_13505_PotencyName|死而后生",
    PotencyDesc = "AwakerPotency_13505_PotencyDesc|「无形迁移」造成的护盾和反击提高 25%。使选择的唤醒体本回合释放 2 次狂气爆发后才会进入冷却。",
    AwakerID = 15579,
    PotencyType = "PassiveSkill",
    FrontPotency = 13322,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13570] = {
    ID = 13570,
    CnID = "启灵@迁移者人格深化1",
    BaseSortID = 244,
    PotencyName = "AwakerPotency_13570_PotencyName|人格深化",
    AwakerID = 15579,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      22207,
      0.8
    },
    FrontPotency = 13505,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13572] = {
    ID = 13572,
    CnID = "启灵@迁移者人格深化2",
    BaseSortID = 245,
    PotencyName = "AwakerPotency_13572_PotencyName|人格深化",
    AwakerID = 15579,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      22207,
      0.8
    },
    FrontPotency = 13570,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13571] = {
    ID = 13571,
    CnID = "启灵@迁移者人格深化3",
    BaseSortID = 246,
    PotencyName = "AwakerPotency_13571_PotencyName|人格深化",
    AwakerID = 15579,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      22207,
      0.8
    },
    FrontPotency = 13572,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13574] = {
    ID = 13574,
    CnID = "启灵@迁移者人格深化4",
    BaseSortID = 247,
    PotencyName = "AwakerPotency_13574_PotencyName|时空折跃",
    PotencyDesc = "AwakerPotency_13574_PotencyDesc|使选择的唤醒体回合开始时获得 35 点狂气，持续 3 回合。",
    AwakerID = 15579,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      22207,
      0.8
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13571,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13573] = {
    ID = 13573,
    CnID = "启灵@迁移者人格深化5",
    BaseSortID = 248,
    PotencyName = "AwakerPotency_13573_PotencyName|人格深化",
    AwakerID = 15579,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      22207,
      0.8
    },
    FrontPotency = 13574,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13576] = {
    ID = 13576,
    CnID = "启灵@迁移者人格深化6",
    BaseSortID = 249,
    PotencyName = "AwakerPotency_13576_PotencyName|人格深化",
    AwakerID = 15579,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      22207,
      0.8
    },
    FrontPotency = 13573,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13575] = {
    ID = 13575,
    CnID = "启灵@迁移者人格深化7",
    BaseSortID = 250,
    PotencyName = "AwakerPotency_13575_PotencyName|人格深化",
    AwakerID = 15579,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      22207,
      0.8
    },
    FrontPotency = 13576,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13578] = {
    ID = 13578,
    CnID = "启灵@迁移者人格深化8",
    BaseSortID = 251,
    PotencyName = "AwakerPotency_13578_PotencyName|人格深化",
    AwakerID = 15579,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      22207,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13575,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13577] = {
    ID = 13577,
    CnID = "启灵@迁移者人格深化9",
    BaseSortID = 252,
    PotencyName = "AwakerPotency_13577_PotencyName|人格深化",
    AwakerID = 15579,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      22207,
      0.8
    },
    FrontPotency = 13578,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13659] = {
    ID = 13659,
    CnID = "启灵@迁移者人格深化10",
    BaseSortID = 253,
    PotencyName = "AwakerPotency_13659_PotencyName|人格深化",
    AwakerID = 15579,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      22207,
      0.8
    },
    FrontPotency = 13577,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13309] = {
    ID = 13309,
    CnID = "启灵@迁移者人格深化11",
    BaseSortID = 254,
    PotencyName = "AwakerPotency_13309_PotencyName|人格深化",
    AwakerID = 15579,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      22207,
      0.8
    },
    FrontPotency = 13659,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13057] = {
    ID = 13057,
    CnID = "启灵@迁移者人格深化12",
    BaseSortID = 255,
    PotencyName = "AwakerPotency_13057_PotencyName|离群者说",
    PotencyDesc = "AwakerPotency_13057_PotencyDesc|灵知觉醒「自我封锁」获得强化，打出时立即使狂气最低其他唤醒体获得 80 点狂气。",
    AwakerID = 15579,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      22207,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13309,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13083] = {
    ID = 13083,
    CnID = "启灵@奇术师读心术",
    BaseSortID = 256,
    PotencyName = "AwakerPotency_13083_PotencyName|读心术",
    PotencyDesc = "AwakerPotency_13083_PotencyDesc|「统统消失！」每洗入 1 张牌，奇术师获得 3 点狂气。",
    AwakerID = 15572,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13165] = {
    ID = 13165,
    CnID = "启灵@奇术师障眼法",
    BaseSortID = 257,
    PotencyName = "AwakerPotency_13165_PotencyName|障眼法",
    PotencyDesc = "AwakerPotency_13165_PotencyDesc|「魔术嘉年华」额外抽 1 张牌，抽到症状或状态卡也会对随机敌人造成 1 次伤害。",
    AwakerID = 15572,
    PotencyType = "PassiveSkill",
    FrontPotency = 13083,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13085] = {
    ID = 13085,
    CnID = "启灵@奇术师模仿犯",
    BaseSortID = 258,
    PotencyName = "AwakerPotency_13085_PotencyName|模仿犯",
    PotencyDesc = "AwakerPotency_13085_PotencyDesc|「隔空取物」获得「余波」：将 1 张「灵感」洗入抽牌堆。",
    AwakerID = 15572,
    PotencyType = "PassiveSkill",
    FrontPotency = 13165,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13197] = {
    ID = 13197,
    CnID = "启灵@奇术师人格深化1",
    BaseSortID = 259,
    PotencyName = "AwakerPotency_13197_PotencyName|人格深化",
    AwakerID = 15572,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18126,
      4
    },
    FrontPotency = 13085,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13198] = {
    ID = 13198,
    CnID = "启灵@奇术师人格深化2",
    BaseSortID = 260,
    PotencyName = "AwakerPotency_13198_PotencyName|人格深化",
    AwakerID = 15572,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18126,
      4
    },
    FrontPotency = 13197,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13199] = {
    ID = 13199,
    CnID = "启灵@奇术师人格深化3",
    BaseSortID = 261,
    PotencyName = "AwakerPotency_13199_PotencyName|人格深化",
    AwakerID = 15572,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18126,
      4
    },
    FrontPotency = 13198,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13200] = {
    ID = 13200,
    CnID = "启灵@奇术师人格深化4",
    BaseSortID = 262,
    PotencyName = "AwakerPotency_13200_PotencyName|纵情欢笑",
    PotencyDesc = "AwakerPotency_13200_PotencyDesc|本次狂气爆发伤害次数变为三倍。之后 5 次打出卡茜亚的指令卡后，获得攻击力 10% 的力量。",
    AwakerID = 15572,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18126,
      4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13199,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13201] = {
    ID = 13201,
    CnID = "启灵@奇术师人格深化5",
    BaseSortID = 263,
    PotencyName = "AwakerPotency_13201_PotencyName|人格深化",
    AwakerID = 15572,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18126,
      4
    },
    FrontPotency = 13200,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13202] = {
    ID = 13202,
    CnID = "启灵@奇术师人格深化6",
    BaseSortID = 264,
    PotencyName = "AwakerPotency_13202_PotencyName|人格深化",
    AwakerID = 15572,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18126,
      4
    },
    FrontPotency = 13201,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13203] = {
    ID = 13203,
    CnID = "启灵@奇术师人格深化7",
    BaseSortID = 265,
    PotencyName = "AwakerPotency_13203_PotencyName|人格深化",
    AwakerID = 15572,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18126,
      4
    },
    FrontPotency = 13202,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13204] = {
    ID = 13204,
    CnID = "启灵@奇术师人格深化8",
    BaseSortID = 266,
    PotencyName = "AwakerPotency_13204_PotencyName|人格深化",
    AwakerID = 15572,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18126,
      4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13203,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13240] = {
    ID = 13240,
    CnID = "启灵@奇术师人格深化9",
    BaseSortID = 267,
    PotencyName = "AwakerPotency_13240_PotencyName|人格深化",
    AwakerID = 15572,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18126,
      4
    },
    FrontPotency = 13204,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13701] = {
    ID = 13701,
    CnID = "启灵@奇术师人格深化10",
    BaseSortID = 268,
    PotencyName = "AwakerPotency_13701_PotencyName|人格深化",
    AwakerID = 15572,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18126,
      4
    },
    FrontPotency = 13240,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13702] = {
    ID = 13702,
    CnID = "启灵@奇术师人格深化11",
    BaseSortID = 269,
    PotencyName = "AwakerPotency_13702_PotencyName|人格深化",
    AwakerID = 15572,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18126,
      4
    },
    FrontPotency = 13701,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13700] = {
    ID = 13700,
    CnID = "启灵@奇术师人格深化12",
    BaseSortID = 270,
    PotencyName = "AwakerPotency_13700_PotencyName|一千零一场奇迹",
    PotencyDesc = "AwakerPotency_13700_PotencyDesc|灵知觉醒「演出序幕」获得强化，所有唤醒体打出「打击」时都能触发该效果获得临时力量。",
    AwakerID = 15572,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18126,
      4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13702,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13538] = {
    ID = 13538,
    CnID = "启灵@破链者掌政官之女",
    BaseSortID = 271,
    PotencyName = "AwakerPotency_13538_PotencyName|掌政官之女",
    PotencyDesc = "AwakerPotency_13538_PotencyDesc|战斗开始时，将 1 张「不规则形态」置入手牌。",
    AwakerID = 15587,
    PotencyType = "PassiveSkill",
    EffectType = "BEAddState",
    Effect = {3819},
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13081] = {
    ID = 13081,
    CnID = "启灵@破链者圣子半身",
    BaseSortID = 272,
    PotencyName = "AwakerPotency_13081_PotencyName|圣子半身",
    PotencyDesc = "AwakerPotency_13081_PotencyDesc|「基础防御」使希洛获得 25% 临时暴击率。",
    AwakerID = 15587,
    PotencyType = "PassiveSkill",
    FrontPotency = 13538,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13464] = {
    ID = 13464,
    CnID = "启灵@破链者斩断锁链之人",
    BaseSortID = 273,
    PotencyName = "AwakerPotency_13464_PotencyName|斩断锁链之人",
    PotencyDesc = "AwakerPotency_13464_PotencyDesc|「基础打击」使希洛获得 10% 暴击伤害。",
    AwakerID = 15587,
    PotencyType = "PassiveSkill",
    FrontPotency = 13081,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13512] = {
    ID = 13512,
    CnID = "启灵@破链者人格深化1",
    BaseSortID = 274,
    PotencyName = "AwakerPotency_13512_PotencyName|人格深化",
    AwakerID = 15587,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13464,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13511] = {
    ID = 13511,
    CnID = "启灵@破链者人格深化2",
    BaseSortID = 275,
    PotencyName = "AwakerPotency_13511_PotencyName|人格深化",
    AwakerID = 15587,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13512,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13510] = {
    ID = 13510,
    CnID = "启灵@破链者人格深化3",
    BaseSortID = 276,
    PotencyName = "AwakerPotency_13510_PotencyName|人格深化",
    AwakerID = 15587,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13511,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13509] = {
    ID = 13509,
    CnID = "启灵@破链者人格深化4",
    BaseSortID = 277,
    PotencyName = "AwakerPotency_13509_PotencyName|以血还血",
    PotencyDesc = "AwakerPotency_13509_PotencyDesc|临时手牌上限+2，并将 2 张 「不规则形态」置入手中，希洛获得 25% 暴击伤害。",
    AwakerID = 15587,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13510,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13508] = {
    ID = 13508,
    CnID = "启灵@破链者人格深化5",
    BaseSortID = 278,
    PotencyName = "AwakerPotency_13508_PotencyName|人格深化",
    AwakerID = 15587,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13509,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13507] = {
    ID = 13507,
    CnID = "启灵@破链者人格深化6",
    BaseSortID = 279,
    PotencyName = "AwakerPotency_13507_PotencyName|人格深化",
    AwakerID = 15587,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13508,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13506] = {
    ID = 13506,
    CnID = "启灵@破链者人格深化7",
    BaseSortID = 280,
    PotencyName = "AwakerPotency_13506_PotencyName|人格深化",
    AwakerID = 15587,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13507,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13519] = {
    ID = 13519,
    CnID = "启灵@破链者人格深化8",
    BaseSortID = 281,
    PotencyName = "AwakerPotency_13519_PotencyName|人格深化",
    AwakerID = 15587,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13506,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13518] = {
    ID = 13518,
    CnID = "启灵@破链者人格深化9",
    BaseSortID = 282,
    PotencyName = "AwakerPotency_13518_PotencyName|人格深化",
    AwakerID = 15587,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13519,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13548] = {
    ID = 13548,
    CnID = "启灵@破链者人格深化10",
    BaseSortID = 283,
    PotencyName = "AwakerPotency_13548_PotencyName|人格深化",
    AwakerID = 15587,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13518,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13547] = {
    ID = 13547,
    CnID = "启灵@破链者人格深化11",
    BaseSortID = 284,
    PotencyName = "AwakerPotency_13547_PotencyName|人格深化",
    AwakerID = 15587,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13548,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13546] = {
    ID = 13546,
    CnID = "启灵@破链者人格深化12",
    BaseSortID = 285,
    PotencyName = "AwakerPotency_13546_PotencyName|最后的审判者",
    PotencyDesc = "AwakerPotency_13546_PotencyDesc|灵知觉醒「复仇宣言」获得强化，打出时立即使「破链一击」的打击加成和「绵长恨怨」的基础伤害提高 50%。",
    AwakerID = 15587,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13547,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13229] = {
    ID = 13229,
    CnID = "启灵@迷宫蛛僭越者",
    BaseSortID = 286,
    PotencyName = "AwakerPotency_13229_PotencyName|僭越者",
    PotencyDesc = "AwakerPotency_13229_PotencyDesc|「不耐的施舍」使手中算力消耗最高的 1 张卡牌在本回合中算力消耗 -1。",
    AwakerID = 15600,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13393] = {
    ID = 13393,
    CnID = "启灵@迷宫蛛灰烬与头颅",
    BaseSortID = 287,
    PotencyName = "AwakerPotency_13393_PotencyName|灰烬与头颅",
    PotencyDesc = "AwakerPotency_13393_PotencyDesc|「基础防御」和「基础打击」触发全体敌方 20％ 中毒。",
    AwakerID = 15600,
    PotencyType = "PassiveSkill",
    FrontPotency = 13229,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13562] = {
    ID = 13562,
    CnID = "启灵@迷宫蛛蜘蛛女之吻",
    BaseSortID = 288,
    PotencyName = "AwakerPotency_13562_PotencyName|蜘蛛女之吻",
    PotencyDesc = "AwakerPotency_13562_PotencyDesc|「苍白回旋」基础伤害提高 50%，打出后使胚胎融合 +20。",
    AwakerID = 15600,
    PotencyType = "PassiveSkill",
    FrontPotency = 13393,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13364] = {
    ID = 13364,
    CnID = "启灵@迷宫蛛人格深化1",
    BaseSortID = 289,
    PotencyName = "AwakerPotency_13364_PotencyName|人格深化",
    AwakerID = 15600,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18159,
      1.6
    },
    FrontPotency = 13562,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13369] = {
    ID = 13369,
    CnID = "启灵@迷宫蛛人格深化2",
    BaseSortID = 290,
    PotencyName = "AwakerPotency_13369_PotencyName|人格深化",
    AwakerID = 15600,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18159,
      1.6
    },
    FrontPotency = 13364,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13228] = {
    ID = 13228,
    CnID = "启灵@迷宫蛛人格深化3",
    BaseSortID = 291,
    PotencyName = "AwakerPotency_13228_PotencyName|人格深化",
    AwakerID = 15600,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18159,
      1.6
    },
    FrontPotency = 13369,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13673] = {
    ID = 13673,
    CnID = "启灵@迷宫蛛人格深化4",
    BaseSortID = 292,
    PotencyName = "AwakerPotency_13673_PotencyName|迷宫之主",
    PotencyDesc = "AwakerPotency_13673_PotencyDesc|抽 2 张阿格里帕的非打击防御指令卡，使 2 张手中阿格里帕的非打击防御指令卡本回合算力消耗 -1。",
    AwakerID = 15600,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18159,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13228,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13672] = {
    ID = 13672,
    CnID = "启灵@迷宫蛛人格深化5",
    BaseSortID = 293,
    PotencyName = "AwakerPotency_13672_PotencyName|人格深化",
    AwakerID = 15600,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18159,
      1.6
    },
    FrontPotency = 13673,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13675] = {
    ID = 13675,
    CnID = "启灵@迷宫蛛人格深化6",
    BaseSortID = 294,
    PotencyName = "AwakerPotency_13675_PotencyName|人格深化",
    AwakerID = 15600,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18159,
      1.6
    },
    FrontPotency = 13672,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13674] = {
    ID = 13674,
    CnID = "启灵@迷宫蛛人格深化7",
    BaseSortID = 295,
    PotencyName = "AwakerPotency_13674_PotencyName|人格深化",
    AwakerID = 15600,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18159,
      1.6
    },
    FrontPotency = 13675,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13357] = {
    ID = 13357,
    CnID = "启灵@迷宫蛛人格深化8",
    BaseSortID = 296,
    PotencyName = "AwakerPotency_13357_PotencyName|人格深化",
    AwakerID = 15600,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13674,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13670] = {
    ID = 13670,
    CnID = "启灵@迷宫蛛人格深化9",
    BaseSortID = 297,
    PotencyName = "AwakerPotency_13670_PotencyName|人格深化",
    AwakerID = 15600,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18159,
      1.6
    },
    FrontPotency = 13357,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13717] = {
    ID = 13717,
    CnID = "启灵@迷宫蛛人格深化10",
    BaseSortID = 298,
    PotencyName = "AwakerPotency_13717_PotencyName|人格深化",
    AwakerID = 15600,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18159,
      1.6
    },
    FrontPotency = 13670,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13220] = {
    ID = 13220,
    CnID = "启灵@迷宫蛛人格深化11",
    BaseSortID = 299,
    PotencyName = "AwakerPotency_13220_PotencyName|人格深化",
    AwakerID = 15600,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18159,
      1.6
    },
    FrontPotency = 13717,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13540] = {
    ID = 13540,
    CnID = "启灵@迷宫蛛人格深化12",
    BaseSortID = 300,
    PotencyName = "AwakerPotency_13540_PotencyName|永不复还契约",
    PotencyDesc = "AwakerPotency_13540_PotencyDesc|灵知觉醒「迷途之旅」获得强化，每回合中阿格里帕每造成或触发 1 次中毒，回合结束获得的护盾就提高 50%，最大 5 层，阿格里帕施加的中毒效果额外提高 50%。",
    AwakerID = 15600,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13220,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [21728] = {
    ID = 21728,
    CnID = "启灵@美德骑士诚实以忠自我",
    BaseSortID = 301,
    PotencyName = "AwakerPotency_21728_PotencyName|诚实，以忠自我",
    PotencyDesc = "AwakerPotency_21728_PotencyDesc|「穿刺之枪」易伤回合数 +1，基础伤害 +100%，力量加成倍数提高 1。",
    AwakerID = 15585,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [21727] = {
    ID = 21727,
    CnID = "启灵@美德骑士怜悯以助弱小",
    BaseSortID = 302,
    PotencyName = "AwakerPotency_21727_PotencyName|怜悯，以助弱小",
    PotencyDesc = "AwakerPotency_21727_PotencyDesc|「七艺，传承美德」获得的护盾和临时力量提高 20%， 若自身处于脆弱状态，「七艺，传承美德」额外获得 33% 的护盾。",
    AwakerID = 15585,
    PotencyType = "PassiveSkill",
    FrontPotency = 21728,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_return.png",
    IfMaxPotency = false
  },
  [21738] = {
    ID = 21738,
    CnID = "启灵@美德骑士牺牲以全大义",
    BaseSortID = 303,
    PotencyName = "AwakerPotency_21738_PotencyName|牺牲，以全大义",
    PotencyDesc = "AwakerPotency_21738_PotencyDesc|「不定壁垒」获得的护盾提高 43%，获得等同于攻击力 [Arg1]% 的力量（效果随「不定壁垒」的等级提高）。",
    AwakerID = 15585,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4195,3,2,1)"
    },
    FrontPotency = 21727,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13589] = {
    ID = 13589,
    CnID = "启灵@美德骑士人格深化1",
    BaseSortID = 304,
    PotencyName = "AwakerPotency_13589_PotencyName|人格深化",
    AwakerID = 15585,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 21738,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13524] = {
    ID = 13524,
    CnID = "启灵@美德骑士人格深化2",
    BaseSortID = 305,
    PotencyName = "AwakerPotency_13524_PotencyName|人格深化",
    AwakerID = 15585,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13589,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13525] = {
    ID = 13525,
    CnID = "启灵@美德骑士人格深化3",
    BaseSortID = 306,
    PotencyName = "AwakerPotency_13525_PotencyName|人格深化",
    AwakerID = 15585,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13524,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13536] = {
    ID = 13536,
    CnID = "启灵@美德骑士人格深化4",
    BaseSortID = 307,
    PotencyName = "AwakerPotency_13536_PotencyName|奉献决心",
    PotencyDesc = "AwakerPotency_13536_PotencyDesc|获得的护盾提高 200%，奥吉尔造成的伤害次数 +1，持续 3 回合。",
    AwakerID = 15585,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13525,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13604] = {
    ID = 13604,
    CnID = "启灵@美德骑士人格深化5",
    BaseSortID = 308,
    PotencyName = "AwakerPotency_13604_PotencyName|人格深化",
    AwakerID = 15585,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13536,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13531] = {
    ID = 13531,
    CnID = "启灵@美德骑士人格深化6",
    BaseSortID = 309,
    PotencyName = "AwakerPotency_13531_PotencyName|人格深化",
    AwakerID = 15585,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13604,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13591] = {
    ID = 13591,
    CnID = "启灵@美德骑士人格深化7",
    BaseSortID = 310,
    PotencyName = "AwakerPotency_13591_PotencyName|人格深化",
    AwakerID = 15585,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13531,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13549] = {
    ID = 13549,
    CnID = "启灵@美德骑士人格深化8",
    BaseSortID = 311,
    PotencyName = "AwakerPotency_13549_PotencyName|人格深化",
    AwakerID = 15585,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13591,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13595] = {
    ID = 13595,
    CnID = "启灵@美德骑士人格深化9",
    BaseSortID = 312,
    PotencyName = "AwakerPotency_13595_PotencyName|人格深化",
    AwakerID = 15585,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13549,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13438] = {
    ID = 13438,
    CnID = "启灵@美德骑士人格深化10",
    BaseSortID = 313,
    PotencyName = "AwakerPotency_13438_PotencyName|人格深化",
    AwakerID = 15585,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13595,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13439] = {
    ID = 13439,
    CnID = "启灵@美德骑士人格深化11",
    BaseSortID = 314,
    PotencyName = "AwakerPotency_13439_PotencyName|人格深化",
    AwakerID = 15585,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13438,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13440] = {
    ID = 13440,
    CnID = "启灵@美德骑士人格深化12",
    BaseSortID = 315,
    PotencyName = "AwakerPotency_13440_PotencyName|忠诚，誓死不渝",
    PotencyDesc = "AwakerPotency_13440_PotencyDesc|灵知觉醒「骑士热诚」获得强化，奥吉尔通过「骑士热诚」获得的力量额外提高 50%。在本场战斗触发死亡抵抗后，奥吉尔的狂气爆发获得的临时力量提高为 3 倍。",
    AwakerID = 15585,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13439,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13063] = {
    ID = 13063,
    CnID = "启灵@猎颅魔女无限通道",
    BaseSortID = 316,
    PotencyName = "AwakerPotency_13063_PotencyName|无限通道",
    PotencyDesc = "AwakerPotency_13063_PotencyDesc|「基础打击」享受 2 倍力量加成，获得跃迁：获得 1 点算力。「基础防御」获得等同于攻击力 [Arg1]% 的力量，获得跃迁：获得 1 点算力。",
    AwakerID = 15590,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(3972,1,3,1)"
    },
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13109] = {
    ID = 13109,
    CnID = "启灵@猎颅魔女贪婪灰雾",
    BaseSortID = 317,
    PotencyName = "AwakerPotency_13109_PotencyName|贪婪灰雾",
    PotencyDesc = "AwakerPotency_13109_PotencyDesc|达芙黛尔以任意方式击杀敌人后，使队伍在本次关卡中暴击率永久提高 5%。",
    AwakerID = 15590,
    PotencyType = "PassiveSkill",
    FrontPotency = 13063,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13305] = {
    ID = 13305,
    CnID = "启灵@猎颅魔女原质沉淀",
    BaseSortID = 318,
    PotencyName = "AwakerPotency_13305_PotencyName|原质沉淀",
    PotencyDesc = "AwakerPotency_13305_PotencyDesc|每打出 1 张「灵感」就使达芙黛尔获得 2 点狂气，获得等同于 1% 攻击力的力量，每回合最多触发 5 次。",
    AwakerID = 15590,
    PotencyType = "PassiveSkill",
    FrontPotency = 13109,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13590] = {
    ID = 13590,
    CnID = "启灵@猎颅魔女人格深化1",
    BaseSortID = 319,
    PotencyName = "AwakerPotency_13590_PotencyName|人格深化",
    AwakerID = 15590,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13305,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13593] = {
    ID = 13593,
    CnID = "启灵@猎颅魔女人格深化2",
    BaseSortID = 320,
    PotencyName = "AwakerPotency_13593_PotencyName|人格深化",
    AwakerID = 15590,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13590,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13592] = {
    ID = 13592,
    CnID = "启灵@猎颅魔女人格深化3",
    BaseSortID = 321,
    PotencyName = "AwakerPotency_13592_PotencyName|人格深化",
    AwakerID = 15590,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13593,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13600] = {
    ID = 13600,
    CnID = "启灵@猎颅魔女人格深化4",
    BaseSortID = 322,
    PotencyName = "AwakerPotency_13600_PotencyName|幻雾迷烟",
    PotencyDesc = "AwakerPotency_13600_PotencyDesc|额外将「千面幻象」的 2 张复制置入手中，「断颈一击」本场战斗中基础伤害提高 50%。",
    AwakerID = 15590,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13592,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13586] = {
    ID = 13586,
    CnID = "启灵@猎颅魔女人格深化5",
    BaseSortID = 323,
    PotencyName = "AwakerPotency_13586_PotencyName|人格深化",
    AwakerID = 15590,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13600,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13607] = {
    ID = 13607,
    CnID = "启灵@猎颅魔女人格深化6",
    BaseSortID = 324,
    PotencyName = "AwakerPotency_13607_PotencyName|人格深化",
    AwakerID = 15590,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13586,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13588] = {
    ID = 13588,
    CnID = "启灵@猎颅魔女人格深化7",
    BaseSortID = 325,
    PotencyName = "AwakerPotency_13588_PotencyName|人格深化",
    AwakerID = 15590,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13607,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13597] = {
    ID = 13597,
    CnID = "启灵@猎颅魔女人格深化8",
    BaseSortID = 326,
    PotencyName = "AwakerPotency_13597_PotencyName|人格深化",
    AwakerID = 15590,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13588,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13596] = {
    ID = 13596,
    CnID = "启灵@猎颅魔女人格深化9",
    BaseSortID = 327,
    PotencyName = "AwakerPotency_13596_PotencyName|人格深化",
    AwakerID = 15590,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13597,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13451] = {
    ID = 13451,
    CnID = "启灵@猎颅魔女人格深化10",
    BaseSortID = 328,
    PotencyName = "AwakerPotency_13451_PotencyName|人格深化",
    AwakerID = 15590,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13596,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13450] = {
    ID = 13450,
    CnID = "启灵@猎颅魔女人格深化11",
    BaseSortID = 329,
    PotencyName = "AwakerPotency_13450_PotencyName|人格深化",
    AwakerID = 15590,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 13451,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13452] = {
    ID = 13452,
    CnID = "启灵@猎颅魔女人格深化12",
    BaseSortID = 330,
    PotencyName = "AwakerPotency_13452_PotencyName|死魂灵",
    PotencyDesc = "AwakerPotency_13452_PotencyDesc|灵知觉醒「维度投射」获得强化，打出时立即生成 1 张算力消耗为 0 的临时「断颈一击」置入超维空间。",
    AwakerID = 15590,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13450,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13207] = {
    ID = 13207,
    CnID = "启灵@空想利刃固守阵地",
    BaseSortID = 331,
    PotencyName = "AwakerPotency_13207_PotencyName|固守阵地",
    PotencyDesc = "AwakerPotency_13207_PotencyDesc|「临战体势」视为「防御」。",
    AwakerID = 15588,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13373] = {
    ID = 13373,
    CnID = "启灵@空想利刃永战不怠",
    BaseSortID = 332,
    PotencyName = "AwakerPotency_13373_PotencyName|永战不怠",
    PotencyDesc = "AwakerPotency_13373_PotencyDesc|「无止境的正义」抽牌数量 +1。",
    AwakerID = 15588,
    PotencyType = "PassiveSkill",
    FrontPotency = 13207,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_return.png",
    IfMaxPotency = false
  },
  [13319] = {
    ID = 13319,
    CnID = "启灵@空想利刃一切为了公正",
    BaseSortID = 333,
    PotencyName = "AwakerPotency_13319_PotencyName|一切为了公正",
    PotencyDesc = "AwakerPotency_13319_PotencyDesc|「无止境的正义」使艾尔瓦获得 50％ 临时暴击率和暴击伤害。",
    AwakerID = 15588,
    PotencyType = "PassiveSkill",
    FrontPotency = 13373,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13097] = {
    ID = 13097,
    CnID = "启灵@空想利刃人格深化1",
    BaseSortID = 334,
    PotencyName = "AwakerPotency_13097_PotencyName|人格深化",
    AwakerID = 15588,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13319,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13095] = {
    ID = 13095,
    CnID = "启灵@空想利刃人格深化2",
    BaseSortID = 335,
    PotencyName = "AwakerPotency_13095_PotencyName|人格深化",
    AwakerID = 15588,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13097,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13096] = {
    ID = 13096,
    CnID = "启灵@空想利刃人格深化3",
    BaseSortID = 336,
    PotencyName = "AwakerPotency_13096_PotencyName|人格深化",
    AwakerID = 15588,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13095,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13320] = {
    ID = 13320,
    CnID = "启灵@空想利刃人格深化4",
    BaseSortID = 337,
    PotencyName = "AwakerPotency_13320_PotencyName|公义与真理同在",
    PotencyDesc = "AwakerPotency_13320_PotencyDesc|将 1 张附加消耗的「临战体势」与「心眼利刃」置入手中。艾尔瓦本场战斗的暴击伤害 +25%。",
    AwakerID = 15588,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13096,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13101] = {
    ID = 13101,
    CnID = "启灵@空想利刃人格深化5",
    BaseSortID = 338,
    PotencyName = "AwakerPotency_13101_PotencyName|人格深化",
    AwakerID = 15588,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13320,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13333] = {
    ID = 13333,
    CnID = "启灵@空想利刃人格深化6",
    BaseSortID = 339,
    PotencyName = "AwakerPotency_13333_PotencyName|人格深化",
    AwakerID = 15588,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13101,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13099] = {
    ID = 13099,
    CnID = "启灵@空想利刃人格深化7",
    BaseSortID = 340,
    PotencyName = "AwakerPotency_13099_PotencyName|人格深化",
    AwakerID = 15588,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13333,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13102] = {
    ID = 13102,
    CnID = "启灵@空想利刃人格深化8",
    BaseSortID = 341,
    PotencyName = "AwakerPotency_13102_PotencyName|人格深化",
    AwakerID = 15588,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13099,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13103] = {
    ID = 13103,
    CnID = "启灵@空想利刃人格深化9",
    BaseSortID = 342,
    PotencyName = "AwakerPotency_13103_PotencyName|人格深化",
    AwakerID = 15588,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13102,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13335] = {
    ID = 13335,
    CnID = "启灵@空想利刃人格深化10",
    BaseSortID = 343,
    PotencyName = "AwakerPotency_13335_PotencyName|人格深化",
    AwakerID = 15588,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13103,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13372] = {
    ID = 13372,
    CnID = "启灵@空想利刃人格深化11",
    BaseSortID = 344,
    PotencyName = "AwakerPotency_13372_PotencyName|人格深化",
    AwakerID = 15588,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13335,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13337] = {
    ID = 13337,
    CnID = "启灵@空想利刃人格深化12",
    BaseSortID = 345,
    PotencyName = "AwakerPotency_13337_PotencyName|向乌托邦的征伐",
    PotencyDesc = "AwakerPotency_13337_PotencyDesc|灵知觉醒「战地卓识」获得强化，艾尔瓦的指令卡每回合首次造成伤害后获得防御力 80% 的护盾。",
    AwakerID = 15588,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13372,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13205] = {
    ID = 13205,
    CnID = "启灵@渴血患者初生",
    BaseSortID = 346,
    PotencyName = "AwakerPotency_13205_PotencyName|初生",
    PotencyDesc = "AwakerPotency_13205_PotencyDesc|「苦痛于欢愉」基础伤害提高 100% 且造成穿刺伤害，获得保留。",
    AwakerID = 15597,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13312] = {
    ID = 13312,
    CnID = "启灵@渴血患者到阳光下",
    BaseSortID = 347,
    PotencyName = "AwakerPotency_13312_PotencyName|到阳光下",
    PotencyDesc = "AwakerPotency_13312_PotencyDesc|「未被满足之痛」获得 10 点狂气。",
    AwakerID = 15597,
    PotencyType = "PassiveSkill",
    FrontPotency = 13205,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13215] = {
    ID = 13215,
    CnID = "启灵@渴血患者地下室手记",
    BaseSortID = 348,
    PotencyName = "AwakerPotency_13215_PotencyName|地下室手记",
    PotencyDesc = "AwakerPotency_13215_PotencyDesc|「献媚者之拥」触发吞噬时，获得的力量翻倍。",
    AwakerID = 15597,
    PotencyType = "PassiveSkill",
    FrontPotency = 13312,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13190] = {
    ID = 13190,
    CnID = "启灵@渴血患者人格深化1",
    BaseSortID = 349,
    PotencyName = "AwakerPotency_13190_PotencyName|人格深化",
    AwakerID = 15597,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13215,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13192] = {
    ID = 13192,
    CnID = "启灵@渴血患者人格深化2",
    BaseSortID = 350,
    PotencyName = "AwakerPotency_13192_PotencyName|人格深化",
    AwakerID = 15597,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13190,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13191] = {
    ID = 13191,
    CnID = "启灵@渴血患者人格深化3",
    BaseSortID = 351,
    PotencyName = "AwakerPotency_13191_PotencyName|人格深化",
    AwakerID = 15597,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13192,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13187] = {
    ID = 13187,
    CnID = "启灵@渴血患者人格深化4",
    BaseSortID = 352,
    PotencyName = "AwakerPotency_13187_PotencyName|苍白的血吻",
    PotencyDesc = "AwakerPotency_13187_PotencyDesc|获得的力量提高 100%，所有唤醒体的暴击率与暴击伤害提高 10%。",
    AwakerID = 15597,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13191,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13186] = {
    ID = 13186,
    CnID = "启灵@渴血患者人格深化5",
    BaseSortID = 353,
    PotencyName = "AwakerPotency_13186_PotencyName|人格深化",
    AwakerID = 15597,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13187,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13189] = {
    ID = 13189,
    CnID = "启灵@渴血患者人格深化6",
    BaseSortID = 354,
    PotencyName = "AwakerPotency_13189_PotencyName|人格深化",
    AwakerID = 15597,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13186,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13188] = {
    ID = 13188,
    CnID = "启灵@渴血患者人格深化7",
    BaseSortID = 355,
    PotencyName = "AwakerPotency_13188_PotencyName|人格深化",
    AwakerID = 15597,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13189,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13184] = {
    ID = 13184,
    CnID = "启灵@渴血患者人格深化8",
    BaseSortID = 356,
    PotencyName = "AwakerPotency_13184_PotencyName|人格深化",
    AwakerID = 15597,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13188,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13183] = {
    ID = 13183,
    CnID = "启灵@渴血患者人格深化9",
    BaseSortID = 357,
    PotencyName = "AwakerPotency_13183_PotencyName|人格深化",
    AwakerID = 15597,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13184,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13105] = {
    ID = 13105,
    CnID = "启灵@渴血患者人格深化10",
    BaseSortID = 358,
    PotencyName = "AwakerPotency_13105_PotencyName|人格深化",
    AwakerID = 15597,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13183,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13104] = {
    ID = 13104,
    CnID = "启灵@渴血患者人格深化11",
    BaseSortID = 359,
    PotencyName = "AwakerPotency_13104_PotencyName|人格深化",
    AwakerID = 15597,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    FrontPotency = 13105,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13106] = {
    ID = 13106,
    CnID = "启灵@渴血患者人格深化12",
    BaseSortID = 360,
    PotencyName = "AwakerPotency_13106_PotencyName|不愈的渴求",
    PotencyDesc = "AwakerPotency_13106_PotencyDesc|灵知觉醒「渴血者」获得强化，打出雷娅的卡牌后，使下次狂气爆发得到强化：获得等同于当前永久力量 10% 的临时力量，最多堆叠 5 次。",
    AwakerID = 15597,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18126,
      4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13104,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13244] = {
    ID = 13244,
    CnID = "启灵@鲸跃不羁的剑风",
    BaseSortID = 361,
    PotencyName = "AwakerPotency_13244_PotencyName|不羁的剑风",
    PotencyDesc = "AwakerPotency_13244_PotencyDesc|「桀骜之刃」视为「打击」。萝坦的「打击」基础伤害提高 30%。",
    AwakerID = 15569,
    PotencyType = "PassiveSkill",
    EffectType = "BEAddState",
    Effect = {36196},
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13185] = {
    ID = 13185,
    CnID = "启灵@鲸跃昂扬的战意",
    BaseSortID = 362,
    PotencyName = "AwakerPotency_13185_PotencyName|昂扬的战意",
    PotencyDesc = "AwakerPotency_13185_PotencyDesc|「恣睢之浪」视为「打击」，获得的力量翻倍。",
    AwakerID = 15569,
    PotencyType = "PassiveSkill",
    FrontPotency = 13244,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_return.png",
    IfMaxPotency = false
  },
  [13728] = {
    ID = 13728,
    CnID = "启灵@鲸跃久远的孤寂",
    BaseSortID = 363,
    PotencyName = "AwakerPotency_13728_PotencyName|久远的孤寂",
    PotencyDesc = "AwakerPotency_13728_PotencyDesc|「混沌之兽」造成的伤害次数+1 ，额外将 2 张附加消耗与虚无的「基础打击」置入手中。",
    AwakerID = 15569,
    PotencyType = "PassiveSkill",
    FrontPotency = 13185,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13167] = {
    ID = 13167,
    CnID = "启灵@鲸跃人格深化1",
    BaseSortID = 364,
    PotencyName = "AwakerPotency_13167_PotencyName|人格深化",
    AwakerID = 15569,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13728,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13641] = {
    ID = 13641,
    CnID = "启灵@鲸跃人格深化2",
    BaseSortID = 365,
    PotencyName = "AwakerPotency_13641_PotencyName|人格深化",
    AwakerID = 15569,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13167,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13642] = {
    ID = 13642,
    CnID = "启灵@鲸跃人格深化3",
    BaseSortID = 366,
    PotencyName = "AwakerPotency_13642_PotencyName|人格深化",
    AwakerID = 15569,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13641,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13146] = {
    ID = 13146,
    CnID = "启灵@鲸跃人格深化4",
    BaseSortID = 367,
    PotencyName = "AwakerPotency_13146_PotencyName|直至星球终结",
    PotencyDesc = "AwakerPotency_13146_PotencyDesc|对所有敌人额外追加 1 次 15% 目标最大生命的纯粹伤害。本场战斗中「混沌之兽」的基础伤害提高 100%。",
    AwakerID = 15569,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13642,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13151] = {
    ID = 13151,
    CnID = "启灵@鲸跃人格深化5",
    BaseSortID = 368,
    PotencyName = "AwakerPotency_13151_PotencyName|人格深化",
    AwakerID = 15569,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13146,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13141] = {
    ID = 13141,
    CnID = "启灵@鲸跃人格深化6",
    BaseSortID = 369,
    PotencyName = "AwakerPotency_13141_PotencyName|人格深化",
    AwakerID = 15569,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13151,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13143] = {
    ID = 13143,
    CnID = "启灵@鲸跃人格深化7",
    BaseSortID = 370,
    PotencyName = "AwakerPotency_13143_PotencyName|人格深化",
    AwakerID = 15569,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13141,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13635] = {
    ID = 13635,
    CnID = "启灵@鲸跃人格深化8",
    BaseSortID = 371,
    PotencyName = "AwakerPotency_13635_PotencyName|人格深化",
    AwakerID = 15569,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13143,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13636] = {
    ID = 13636,
    CnID = "启灵@鲸跃人格深化9",
    BaseSortID = 372,
    PotencyName = "AwakerPotency_13636_PotencyName|人格深化",
    AwakerID = 15569,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13635,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13351] = {
    ID = 13351,
    CnID = "启灵@鲸跃人格深化10",
    BaseSortID = 373,
    PotencyName = "AwakerPotency_13351_PotencyName|人格深化",
    AwakerID = 15569,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13636,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13352] = {
    ID = 13352,
    CnID = "启灵@鲸跃人格深化11",
    BaseSortID = 374,
    PotencyName = "AwakerPotency_13352_PotencyName|人格深化",
    AwakerID = 15569,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13351,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13353] = {
    ID = 13353,
    CnID = "启灵@鲸跃人格深化12",
    BaseSortID = 375,
    PotencyName = "AwakerPotency_13353_PotencyName|亘古的鲸鸣",
    PotencyDesc = "AwakerPotency_13353_PotencyDesc|灵知觉醒「战欲难平」获得强化，萝坦打出「防御」后本回合下一张「桀骜之刃」生效 2 次。",
    AwakerID = 15569,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13352,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13434] = {
    ID = 13434,
    CnID = "启灵@荆棘女王绿色腐败",
    BaseSortID = 376,
    PotencyName = "AwakerPotency_13434_PotencyName|启示录",
    PotencyDesc = "AwakerPotency_13434_PotencyDesc|「脊刺锁链」暴击率提高 25%。「迷途之守」获得的所有反击提高 20%。",
    AwakerID = 15586,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13679] = {
    ID = 13679,
    CnID = "启灵@荆棘女王湖中栖物",
    BaseSortID = 377,
    PotencyName = "AwakerPotency_13679_PotencyName|湖中栖物",
    PotencyDesc = "AwakerPotency_13679_PotencyDesc|升级所有消耗<DreamGuide:梦引>时的效果：「死梦之都」消耗 5 层时额外获得 15 点狂气，消耗 10 层时额外造成 5% 伤害降低；「脊刺锁链」降低力量效果翻倍；「迷途之守」额外获得的反击量提高 50% 。",
    AwakerID = 15586,
    PotencyType = "PassiveSkill",
    FrontPotency = 13434,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13686] = {
    ID = 13686,
    CnID = "启灵@荆棘女王裘皮与维纳斯",
    BaseSortID = 378,
    PotencyName = "AwakerPotency_13686_PotencyName|裘皮与维纳斯",
    PotencyDesc = "AwakerPotency_13686_PotencyDesc|战斗结束后额外获得 5 黑印，该效果受黑印掉落加成。旺达打出卡牌后，获得 1 层<DreamGuide:梦引>，该效果每回合至多生效 2 次。",
    AwakerID = 15586,
    PotencyType = "PassiveSkill",
    EffectType = "BEAddState",
    Effect = {38739},
    FrontPotency = 13679,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13646] = {
    ID = 13646,
    CnID = "启灵@荆棘女王人格深化1",
    BaseSortID = 379,
    PotencyName = "AwakerPotency_13646_PotencyName|人格深化",
    AwakerID = 15586,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18142,
      1.6
    },
    FrontPotency = 13686,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13155] = {
    ID = 13155,
    CnID = "启灵@荆棘女王人格深化2",
    BaseSortID = 380,
    PotencyName = "AwakerPotency_13155_PotencyName|人格深化",
    AwakerID = 15586,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18142,
      1.6
    },
    FrontPotency = 13646,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13154] = {
    ID = 13154,
    CnID = "启灵@荆棘女王人格深化3",
    BaseSortID = 381,
    PotencyName = "AwakerPotency_13154_PotencyName|人格深化",
    AwakerID = 15586,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18142,
      1.6
    },
    FrontPotency = 13155,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13157] = {
    ID = 13157,
    CnID = "启灵@荆棘女王人格深化4",
    BaseSortID = 382,
    PotencyName = "AwakerPotency_13157_PotencyName|迷途梦引",
    PotencyDesc = "AwakerPotency_13157_PotencyDesc|无需消耗梦引，同时触发「催眠脉络」、「深眠反击」和「呓语回音」。",
    AwakerID = 15586,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18142,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13154,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13156] = {
    ID = 13156,
    CnID = "启灵@荆棘女王人格深化5",
    BaseSortID = 383,
    PotencyName = "AwakerPotency_13156_PotencyName|人格深化",
    AwakerID = 15586,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18142,
      1.6
    },
    FrontPotency = 13157,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13159] = {
    ID = 13159,
    CnID = "启灵@荆棘女王人格深化6",
    BaseSortID = 384,
    PotencyName = "AwakerPotency_13159_PotencyName|人格深化",
    AwakerID = 15586,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18142,
      1.6
    },
    FrontPotency = 13156,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13158] = {
    ID = 13158,
    CnID = "启灵@荆棘女王人格深化7",
    BaseSortID = 385,
    PotencyName = "AwakerPotency_13158_PotencyName|人格深化",
    AwakerID = 15586,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18142,
      1.6
    },
    FrontPotency = 13159,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13150] = {
    ID = 13150,
    CnID = "启灵@荆棘女王人格深化8",
    BaseSortID = 386,
    PotencyName = "AwakerPotency_13150_PotencyName|人格深化",
    AwakerID = 15586,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18142,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13158,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13149] = {
    ID = 13149,
    CnID = "启灵@荆棘女王人格深化9",
    BaseSortID = 387,
    PotencyName = "AwakerPotency_13149_PotencyName|人格深化",
    AwakerID = 15586,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18142,
      1.6
    },
    FrontPotency = 13150,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13371] = {
    ID = 13371,
    CnID = "启灵@荆棘女王人格深化10",
    BaseSortID = 388,
    PotencyName = "AwakerPotency_13371_PotencyName|人格深化",
    AwakerID = 15586,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18142,
      1.6
    },
    FrontPotency = 13149,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13417] = {
    ID = 13417,
    CnID = "启灵@荆棘女王人格深化11",
    BaseSortID = 389,
    PotencyName = "AwakerPotency_13417_PotencyName|人格深化",
    AwakerID = 15586,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18142,
      1.6
    },
    FrontPotency = 13371,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13222] = {
    ID = 13222,
    CnID = "启灵@荆棘女王人格深化12",
    BaseSortID = 390,
    PotencyName = "AwakerPotency_13222_PotencyName|黑石律令",
    PotencyDesc = "AwakerPotency_13222_PotencyDesc|灵知觉醒「活尸梦呓」获得强化，旺达释放狂气爆发后自身下 2 张指令卡额外生效 1 次。",
    AwakerID = 15586,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18142,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13417,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13585] = {
    ID = 13585,
    CnID = "启灵@红夫人溪流",
    BaseSortID = 391,
    PotencyName = "AwakerPotency_13585_PotencyName|溪流",
    PotencyDesc = "AwakerPotency_13585_PotencyDesc|若当前生命低于 50%，「基础打击」造成 2 次伤害，胚胎融合 +10。「基础防御」获得 2 次护盾，胚胎融合 +10。",
    AwakerID = 15584,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13465] = {
    ID = 13465,
    CnID = "启灵@红夫人佳酿",
    BaseSortID = 392,
    PotencyName = "AwakerPotency_13465_PotencyName|佳酿",
    PotencyDesc = "AwakerPotency_13465_PotencyDesc|「蔷薇之美」基础伤害提高 25%，每造成 1 次伤害，临时暴击率 +5%。",
    AwakerID = 15584,
    PotencyType = "PassiveSkill",
    FrontPotency = 13585,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13715] = {
    ID = 13715,
    CnID = "启灵@红夫人明珠",
    BaseSortID = 393,
    PotencyName = "AwakerPotency_13715_PotencyName|明珠",
    PotencyDesc = "AwakerPotency_13715_PotencyDesc|战斗开始后，胚胎融合 +25，每次触发死亡抵抗，胚胎融合 +25。索蕾尔每次造成伤害，使本回合内自身造成伤害提高等同于攻击力 4%。",
    AwakerID = 15584,
    PotencyType = "PassiveSkill",
    EffectType = "BEAddState",
    Effect = {24640},
    FrontPotency = 13465,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13266] = {
    ID = 13266,
    CnID = "启灵@红夫人人格深化1",
    BaseSortID = 394,
    PotencyName = "AwakerPotency_13266_PotencyName|人格深化",
    AwakerID = 15584,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13715,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13269] = {
    ID = 13269,
    CnID = "启灵@红夫人人格深化2",
    BaseSortID = 395,
    PotencyName = "AwakerPotency_13269_PotencyName|人格深化",
    AwakerID = 15584,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13266,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13268] = {
    ID = 13268,
    CnID = "启灵@红夫人人格深化3",
    BaseSortID = 396,
    PotencyName = "AwakerPotency_13268_PotencyName|人格深化",
    AwakerID = 15584,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13269,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13271] = {
    ID = 13271,
    CnID = "启灵@红夫人人格深化4",
    BaseSortID = 397,
    PotencyName = "AwakerPotency_13271_PotencyName|无尽蔷薇之欲",
    PotencyDesc = "AwakerPotency_13271_PotencyDesc|使索蕾尔接下来 3 张指令卡生效 2 次。本次狂气爆发每造成 1 次伤害，回合结束时回复等同于体质 [Arg1]% 点生命。",
    AwakerID = 15584,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    EffectPara = {
      "PotencySkillParam(4770,7,3,1)"
    },
    FrontPotency = 13268,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13270] = {
    ID = 13270,
    CnID = "启灵@红夫人人格深化5",
    BaseSortID = 398,
    PotencyName = "AwakerPotency_13270_PotencyName|人格深化",
    AwakerID = 15584,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13271,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13273] = {
    ID = 13273,
    CnID = "启灵@红夫人人格深化6",
    BaseSortID = 399,
    PotencyName = "AwakerPotency_13273_PotencyName|人格深化",
    AwakerID = 15584,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13270,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13272] = {
    ID = 13272,
    CnID = "启灵@红夫人人格深化7",
    BaseSortID = 400,
    PotencyName = "AwakerPotency_13272_PotencyName|人格深化",
    AwakerID = 15584,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13273,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13275] = {
    ID = 13275,
    CnID = "启灵@红夫人人格深化8",
    BaseSortID = 401,
    PotencyName = "AwakerPotency_13275_PotencyName|人格深化",
    AwakerID = 15584,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13272,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13274] = {
    ID = 13274,
    CnID = "启灵@红夫人人格深化9",
    BaseSortID = 402,
    PotencyName = "AwakerPotency_13274_PotencyName|人格深化",
    AwakerID = 15584,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13275,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13446] = {
    ID = 13446,
    CnID = "启灵@红夫人人格深化10",
    BaseSortID = 403,
    PotencyName = "AwakerPotency_13446_PotencyName|人格深化",
    AwakerID = 15584,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13274,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13445] = {
    ID = 13445,
    CnID = "启灵@红夫人人格深化11",
    BaseSortID = 404,
    PotencyName = "AwakerPotency_13445_PotencyName|人格深化",
    AwakerID = 15584,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13446,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13447] = {
    ID = 13447,
    CnID = "启灵@红夫人人格深化12",
    BaseSortID = 405,
    PotencyName = "AwakerPotency_13447_PotencyName|绯红盛绽",
    PotencyDesc = "AwakerPotency_13447_PotencyDesc|灵知觉醒「迎客特权」获得强化，索蕾尔每造成 1 次伤害使索蕾尔临时最终伤害 +2%，其他唤醒体 +1%，每回合最多生效 15 次。",
    AwakerID = 15584,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13445,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13430] = {
    ID = 13430,
    CnID = "启灵@海之使徒踽踽苦行",
    BaseSortID = 406,
    PotencyName = "AwakerPotency_13430_PotencyName|踽踽苦行",
    PotencyDesc = "AwakerPotency_13430_PotencyDesc|「无上生祭」使临时暴击伤害提高，数值等同于弥利亚姆原始暴击伤害的 15%。",
    AwakerID = 15582,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13153] = {
    ID = 13153,
    CnID = "启灵@海之使徒最终降临",
    BaseSortID = 407,
    PotencyName = "AwakerPotency_13153_PotencyName|最终降临",
    PotencyDesc = "AwakerPotency_13153_PotencyDesc|「应选之人」使界域精通提高 20 点，获得预备 1 和保留。",
    AwakerID = 15582,
    PotencyType = "PassiveSkill",
    FrontPotency = 13430,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13645] = {
    ID = 13645,
    CnID = "启灵@海之使徒泡影幻灭",
    BaseSortID = 408,
    PotencyName = "AwakerPotency_13645_PotencyName|泡影幻灭",
    PotencyDesc = "AwakerPotency_13645_PotencyDesc|「祭仪」效果提高 30%。每将 1 张「圣礼」转化为「执妄」，本场战斗中弥利亚姆造成的基础伤害和「向深渊祝祷」造成的基础中毒提高 15%。",
    AwakerID = 15582,
    PotencyType = "PassiveSkill",
    FrontPotency = 13153,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13423] = {
    ID = 13423,
    CnID = "启灵@海之使徒人格深化1",
    BaseSortID = 409,
    PotencyName = "AwakerPotency_13423_PotencyName|人格深化",
    AwakerID = 15582,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18105,
      2.4
    },
    FrontPotency = 13645,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13421] = {
    ID = 13421,
    CnID = "启灵@海之使徒人格深化2",
    BaseSortID = 410,
    PotencyName = "AwakerPotency_13421_PotencyName|人格深化",
    AwakerID = 15582,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18105,
      2.4
    },
    FrontPotency = 13423,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13422] = {
    ID = 13422,
    CnID = "启灵@海之使徒人格深化3",
    BaseSortID = 411,
    PotencyName = "AwakerPotency_13422_PotencyName|人格深化",
    AwakerID = 15582,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18105,
      2.4
    },
    FrontPotency = 13421,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13419] = {
    ID = 13419,
    CnID = "启灵@海之使徒人格深化4",
    BaseSortID = 412,
    PotencyName = "AwakerPotency_13419_PotencyName|未经他人之苦",
    PotencyDesc = "AwakerPotency_13419_PotencyDesc|额外将 2 张「圣礼」置入手中，触腕上限和触腕数量 +1。",
    AwakerID = 15582,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18105,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13422,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13420] = {
    ID = 13420,
    CnID = "启灵@海之使徒人格深化5",
    BaseSortID = 413,
    PotencyName = "AwakerPotency_13420_PotencyName|人格深化",
    AwakerID = 15582,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18105,
      2.4
    },
    FrontPotency = 13419,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13526] = {
    ID = 13526,
    CnID = "启灵@海之使徒人格深化6",
    BaseSortID = 414,
    PotencyName = "AwakerPotency_13526_PotencyName|人格深化",
    AwakerID = 15582,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18105,
      2.4
    },
    FrontPotency = 13420,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13418] = {
    ID = 13418,
    CnID = "启灵@海之使徒人格深化7",
    BaseSortID = 415,
    PotencyName = "AwakerPotency_13418_PotencyName|人格深化",
    AwakerID = 15582,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18105,
      2.4
    },
    FrontPotency = 13526,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13428] = {
    ID = 13428,
    CnID = "启灵@海之使徒人格深化8",
    BaseSortID = 416,
    PotencyName = "AwakerPotency_13428_PotencyName|人格深化",
    AwakerID = 15582,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18105,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13418,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13429] = {
    ID = 13429,
    CnID = "启灵@海之使徒人格深化9",
    BaseSortID = 417,
    PotencyName = "AwakerPotency_13429_PotencyName|人格深化",
    AwakerID = 15582,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18105,
      2.4
    },
    FrontPotency = 13428,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13354] = {
    ID = 13354,
    CnID = "启灵@海之使徒人格深化10",
    BaseSortID = 418,
    PotencyName = "AwakerPotency_13354_PotencyName|人格深化",
    AwakerID = 15582,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18105,
      2.4
    },
    FrontPotency = 13429,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13356] = {
    ID = 13356,
    CnID = "启灵@海之使徒人格深化11",
    BaseSortID = 419,
    PotencyName = "AwakerPotency_13356_PotencyName|人格深化",
    AwakerID = 15582,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18105,
      2.4
    },
    FrontPotency = 13354,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13218] = {
    ID = 13218,
    CnID = "启灵@海之使徒人格深化12",
    BaseSortID = 420,
    PotencyName = "AwakerPotency_13218_PotencyName|故国苏生",
    PotencyDesc = "AwakerPotency_13218_PotencyDesc|灵知觉醒「信仰的见证」获得强化，每翻转 2 张「圣礼」将一张「神国幻影」置入手中。",
    AwakerID = 15582,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18105,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13356,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13603] = {
    ID = 13603,
    CnID = "启灵@海月噗噜噜旅行",
    BaseSortID = 421,
    PotencyName = "AwakerPotency_13603_PotencyName|噗噜噜旅行",
    PotencyDesc = "AwakerPotency_13603_PotencyDesc|「同伴的力量」额外抽 1 张牌。",
    AwakerID = 15573,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13476] = {
    ID = 13476,
    CnID = "启灵@海月滑溜溜冒险",
    BaseSortID = 422,
    PotencyName = "AwakerPotency_13476_PotencyName|滑溜溜冒险",
    PotencyDesc = "AwakerPotency_13476_PotencyDesc|「腺体分裂」和「喧嚣海洋」基础伤害提高 100%，造成穿刺伤害。",
    AwakerID = 15573,
    PotencyType = "PassiveSkill",
    FrontPotency = 13603,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13059] = {
    ID = 13059,
    CnID = "启灵@海月笑呵呵玩乐",
    BaseSortID = 423,
    PotencyName = "AwakerPotency_13059_PotencyName|笑呵呵玩乐",
    PotencyDesc = "AwakerPotency_13059_PotencyDesc|「基础防御」抽 1 张牌。每 3 回合，将 1 张附加虚无和消耗的「腺体分裂」加入手中。",
    AwakerID = 15573,
    PotencyType = "PassiveSkill",
    EffectType = "BEAddState",
    Effect = {3705},
    FrontPotency = 13476,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13407] = {
    ID = 13407,
    CnID = "启灵@海月人格深化1",
    BaseSortID = 424,
    PotencyName = "AwakerPotency_13407_PotencyName|人格深化",
    AwakerID = 15573,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13059,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13408] = {
    ID = 13408,
    CnID = "启灵@海月人格深化2",
    BaseSortID = 425,
    PotencyName = "AwakerPotency_13408_PotencyName|人格深化",
    AwakerID = 15573,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13407,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13409] = {
    ID = 13409,
    CnID = "启灵@海月人格深化3",
    BaseSortID = 426,
    PotencyName = "AwakerPotency_13409_PotencyName|人格深化",
    AwakerID = 15573,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13408,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13410] = {
    ID = 13410,
    CnID = "启灵@海月人格深化4",
    BaseSortID = 427,
    PotencyName = "AwakerPotency_13410_PotencyName|水母集合",
    PotencyDesc = "AwakerPotency_13410_PotencyDesc|额外获得 24% 攻击力的力量和触腕伤害。之后 5 次打出「腺体分裂」时，都会抽 1 张牌。",
    AwakerID = 15573,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13409,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13411] = {
    ID = 13411,
    CnID = "启灵@海月人格深化5",
    BaseSortID = 428,
    PotencyName = "AwakerPotency_13411_PotencyName|人格深化",
    AwakerID = 15573,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13410,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13412] = {
    ID = 13412,
    CnID = "启灵@海月人格深化6",
    BaseSortID = 429,
    PotencyName = "AwakerPotency_13412_PotencyName|人格深化",
    AwakerID = 15573,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13411,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13413] = {
    ID = 13413,
    CnID = "启灵@海月人格深化7",
    BaseSortID = 430,
    PotencyName = "AwakerPotency_13413_PotencyName|人格深化",
    AwakerID = 15573,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13412,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13414] = {
    ID = 13414,
    CnID = "启灵@海月人格深化8",
    BaseSortID = 431,
    PotencyName = "AwakerPotency_13414_PotencyName|人格深化",
    AwakerID = 15573,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13413,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13415] = {
    ID = 13415,
    CnID = "启灵@海月人格深化9",
    BaseSortID = 432,
    PotencyName = "AwakerPotency_13415_PotencyName|人格深化",
    AwakerID = 15573,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13414,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13532] = {
    ID = 13532,
    CnID = "启灵@海月人格深化10",
    BaseSortID = 433,
    PotencyName = "AwakerPotency_13532_PotencyName|人格深化",
    AwakerID = 15573,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13415,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13193] = {
    ID = 13193,
    CnID = "启灵@海月人格深化11",
    BaseSortID = 434,
    PotencyName = "AwakerPotency_13193_PotencyName|人格深化",
    AwakerID = 15573,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13532,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13530] = {
    ID = 13530,
    CnID = "启灵@海月人格深化12",
    BaseSortID = 435,
    PotencyName = "AwakerPotency_13530_PotencyName|亮闪闪挚友",
    PotencyDesc = "AwakerPotency_13530_PotencyDesc|灵知觉醒「自我增殖」获得强化，奥瑞塔的「打击」变为穿刺伤害，并且额外造成 3 次伤害。",
    AwakerID = 15573,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13193,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13680] = {
    ID = 13680,
    CnID = "启灵@歌者响彻星穹",
    BaseSortID = 436,
    PotencyName = "AwakerPotency_13680_PotencyName|响彻星穹",
    PotencyDesc = "AwakerPotency_13680_PotencyDesc|「基础打击」造成 2 次伤害，并获得跃迁：额外造成 1 次伤害。",
    AwakerID = 15574,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13523] = {
    ID = 13523,
    CnID = "启灵@歌者午夜哀歌",
    BaseSortID = 437,
    PotencyName = "AwakerPotency_13523_PotencyName|午夜哀歌",
    PotencyDesc = "AwakerPotency_13523_PotencyDesc|「基础防御」获得 2 次护盾，并获得跃迁：额外获得 1 次狂气。",
    AwakerID = 15574,
    PotencyType = "PassiveSkill",
    FrontPotency = 13680,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13341] = {
    ID = 13341,
    CnID = "启灵@歌者坠入高空",
    BaseSortID = 438,
    PotencyName = "AwakerPotency_13341_PotencyName|坠入高空",
    PotencyDesc = "AwakerPotency_13341_PotencyDesc|「绵音渐响」和「星彩极光」获得暴击率的同时，也会获得等量的暴击伤害。",
    AwakerID = 15574,
    PotencyType = "PassiveSkill",
    FrontPotency = 13523,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13705] = {
    ID = 13705,
    CnID = "启灵@歌者人格深化1",
    BaseSortID = 439,
    PotencyName = "AwakerPotency_13705_PotencyName|人格深化",
    AwakerID = 15574,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 13341,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13643] = {
    ID = 13643,
    CnID = "启灵@歌者人格深化2",
    BaseSortID = 440,
    PotencyName = "AwakerPotency_13643_PotencyName|人格深化",
    AwakerID = 15574,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 13705,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13644] = {
    ID = 13644,
    CnID = "启灵@歌者人格深化3",
    BaseSortID = 441,
    PotencyName = "AwakerPotency_13644_PotencyName|人格深化",
    AwakerID = 15574,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 13643,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13637] = {
    ID = 13637,
    CnID = "启灵@歌者人格深化4",
    BaseSortID = 442,
    PotencyName = "AwakerPotency_13637_PotencyName|纵贯寰宇的音律",
    PotencyDesc = "AwakerPotency_13637_PotencyDesc|使随机 5 张手牌直到回合结束时算力消耗变为 0。",
    AwakerID = 15574,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13644,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13638] = {
    ID = 13638,
    CnID = "启灵@歌者人格深化5",
    BaseSortID = 443,
    PotencyName = "AwakerPotency_13638_PotencyName|人格深化",
    AwakerID = 15574,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 13637,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13639] = {
    ID = 13639,
    CnID = "启灵@歌者人格深化6",
    BaseSortID = 444,
    PotencyName = "AwakerPotency_13639_PotencyName|人格深化",
    AwakerID = 15574,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 13638,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13640] = {
    ID = 13640,
    CnID = "启灵@歌者人格深化7",
    BaseSortID = 445,
    PotencyName = "AwakerPotency_13640_PotencyName|人格深化",
    AwakerID = 15574,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 13639,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13633] = {
    ID = 13633,
    CnID = "启灵@歌者人格深化8",
    BaseSortID = 446,
    PotencyName = "AwakerPotency_13633_PotencyName|人格深化",
    AwakerID = 15574,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13640,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13634] = {
    ID = 13634,
    CnID = "启灵@歌者人格深化9",
    BaseSortID = 447,
    PotencyName = "AwakerPotency_13634_PotencyName|人格深化",
    AwakerID = 15574,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 13633,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13304] = {
    ID = 13304,
    CnID = "启灵@歌者人格深化10",
    BaseSortID = 448,
    PotencyName = "AwakerPotency_13304_PotencyName|人格深化",
    AwakerID = 15574,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 13634,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13094] = {
    ID = 13094,
    CnID = "启灵@歌者人格深化11",
    BaseSortID = 449,
    PotencyName = "AwakerPotency_13094_PotencyName|人格深化",
    AwakerID = 15574,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 13304,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13448] = {
    ID = 13448,
    CnID = "启灵@歌者人格深化12",
    BaseSortID = 450,
    PotencyName = "AwakerPotency_13448_PotencyName|当殷红浸透荆棘",
    PotencyDesc = "AwakerPotency_13448_PotencyDesc|灵知觉醒「界外之音」获得强化，汀克特每回合首次打出「技能」时生成 1 张算力消耗为 0 的临时「打击」，该「打击」的随机效果变为 2 倍。",
    AwakerID = 15574,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13094,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13533] = {
    ID = 13533,
    CnID = "启灵@缸中之脑纯粹理性",
    BaseSortID = 451,
    PotencyName = "AwakerPotency_13533_PotencyName|纯粹理性",
    PotencyDesc = "AwakerPotency_13533_PotencyDesc|「外域手术」虚弱回合数提高 1，治疗量提高 33%。",
    AwakerID = 15570,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13060] = {
    ID = 13060,
    CnID = "启灵@缸中之脑逃离死亡",
    BaseSortID = 452,
    PotencyName = "AwakerPotency_13060_PotencyName|逃离死亡",
    PotencyDesc = "AwakerPotency_13060_PotencyDesc|「等价交换」基础回复生命和弃牌回复生命效果提高 20%，每弃掉 1 张牌，额外回复生命同时并获得等量的护盾。",
    AwakerID = 15570,
    PotencyType = "PassiveSkill",
    FrontPotency = 13533,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_return.png",
    IfMaxPotency = false
  },
  [13581] = {
    ID = 13581,
    CnID = "启灵@缸中之脑超越躯壳",
    BaseSortID = 453,
    PotencyName = "AwakerPotency_13581_PotencyName|超越躯壳",
    PotencyDesc = "AwakerPotency_13581_PotencyDesc|「理性，真理与现实」回复生命 +25%，造成的狂气对朵尔也生效。",
    AwakerID = 15570,
    PotencyType = "PassiveSkill",
    FrontPotency = 13060,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13594] = {
    ID = 13594,
    CnID = "启灵@缸中之脑人格深化1",
    BaseSortID = 454,
    PotencyName = "AwakerPotency_13594_PotencyName|人格深化",
    AwakerID = 15570,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13581,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13238] = {
    ID = 13238,
    CnID = "启灵@缸中之脑人格深化2",
    BaseSortID = 455,
    PotencyName = "AwakerPotency_13238_PotencyName|人格深化",
    AwakerID = 15570,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13594,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13239] = {
    ID = 13239,
    CnID = "启灵@缸中之脑人格深化3",
    BaseSortID = 456,
    PotencyName = "AwakerPotency_13239_PotencyName|人格深化",
    AwakerID = 15570,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13238,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13236] = {
    ID = 13236,
    CnID = "启灵@缸中之脑人格深化4",
    BaseSortID = 457,
    PotencyName = "AwakerPotency_13236_PotencyName|心智分析",
    PotencyDesc = "AwakerPotency_13236_PotencyDesc|回合开始时回复等同于朵尔 [Arg1]% 体质的生命，持续 3 回合。（效果随「理性，真理与现实」的等级提升）",
    AwakerID = 15570,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    EffectType1 = "UtlSkill_Promote",
    EffectPara = {
      "PotencySkillParam(21620,7,3,1)"
    },
    FrontPotency = 13239,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13237] = {
    ID = 13237,
    CnID = "启灵@缸中之脑人格深化5",
    BaseSortID = 458,
    PotencyName = "AwakerPotency_13237_PotencyName|人格深化",
    AwakerID = 15570,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13236,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13234] = {
    ID = 13234,
    CnID = "启灵@缸中之脑人格深化6",
    BaseSortID = 459,
    PotencyName = "AwakerPotency_13234_PotencyName|人格深化",
    AwakerID = 15570,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13237,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13235] = {
    ID = 13235,
    CnID = "启灵@缸中之脑人格深化7",
    BaseSortID = 460,
    PotencyName = "AwakerPotency_13235_PotencyName|人格深化",
    AwakerID = 15570,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13234,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13241] = {
    ID = 13241,
    CnID = "启灵@缸中之脑人格深化8",
    BaseSortID = 461,
    PotencyName = "AwakerPotency_13241_PotencyName|人格深化",
    AwakerID = 15570,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13235,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13242] = {
    ID = 13242,
    CnID = "启灵@缸中之脑人格深化9",
    BaseSortID = 462,
    PotencyName = "AwakerPotency_13242_PotencyName|人格深化",
    AwakerID = 15570,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13241,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13374] = {
    ID = 13374,
    CnID = "启灵@缸中之脑人格深化10",
    BaseSortID = 463,
    PotencyName = "AwakerPotency_13374_PotencyName|人格深化",
    AwakerID = 15570,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13242,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13375] = {
    ID = 13375,
    CnID = "启灵@缸中之脑人格深化11",
    BaseSortID = 464,
    PotencyName = "AwakerPotency_13375_PotencyName|人格深化",
    AwakerID = 15570,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13374,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13376] = {
    ID = 13376,
    CnID = "启灵@缸中之脑人格深化12",
    BaseSortID = 465,
    PotencyName = "AwakerPotency_13376_PotencyName|重构自我",
    PotencyDesc = "AwakerPotency_13376_PotencyDesc|灵知觉醒「灵肉两分」获得强化，造成的护盾效果提高 50%。朵尔的「打击」和「防御」也能触发获得护盾效果。",
    AwakerID = 15570,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13375,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13175] = {
    ID = 13175,
    CnID = "启灵@复仇巨刃死亦新生",
    BaseSortID = 466,
    PotencyName = "AwakerPotency_13175_PotencyName|死亦新生",
    PotencyDesc = "AwakerPotency_13175_PotencyDesc|「斩首重创」每有 1 条触腕，就使「斩首重创」的力量加成提高 1 倍。",
    AwakerID = 15564,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13453] = {
    ID = 13453,
    CnID = "启灵@复仇巨刃一山二虎",
    BaseSortID = 467,
    PotencyName = "AwakerPotency_13453_PotencyName|一山二虎",
    PotencyDesc = "AwakerPotency_13453_PotencyDesc|「强者为尊」在移除所有敌人力量的同时，额外获得等同于移除量的临时力量。",
    AwakerID = 15564,
    PotencyType = "PassiveSkill",
    FrontPotency = 13175,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13502] = {
    ID = 13502,
    CnID = "启灵@复仇巨刃无尽野望",
    BaseSortID = 468,
    PotencyName = "AwakerPotency_13502_PotencyName|无尽野望",
    PotencyDesc = "AwakerPotency_13502_PotencyDesc|「海渊之力」选择「篡夺」时，戈利亚获得 25% 临时暴击率；选择 「蛰伏」时，戈利亚获得 25 点狂气。",
    AwakerID = 15564,
    PotencyType = "PassiveSkill",
    FrontPotency = 13453,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13338] = {
    ID = 13338,
    CnID = "启灵@复仇巨刃人格深化1",
    BaseSortID = 469,
    PotencyName = "AwakerPotency_13338_PotencyName|人格深化",
    AwakerID = 15564,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13502,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13327] = {
    ID = 13327,
    CnID = "启灵@复仇巨刃人格深化2",
    BaseSortID = 470,
    PotencyName = "AwakerPotency_13327_PotencyName|人格深化",
    AwakerID = 15564,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13338,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13340] = {
    ID = 13340,
    CnID = "启灵@复仇巨刃人格深化3",
    BaseSortID = 471,
    PotencyName = "AwakerPotency_13340_PotencyName|人格深化",
    AwakerID = 15564,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13327,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13329] = {
    ID = 13329,
    CnID = "启灵@复仇巨刃人格深化4",
    BaseSortID = 472,
    PotencyName = "AwakerPotency_13329_PotencyName|巨人的腕力",
    PotencyDesc = "AwakerPotency_13329_PotencyDesc|选择「篡夺」时，置入手中的「巨刃之威」基础伤害提高 400%，算力消耗变为 0 。选择「蛰伏」时，不再置入「巨刃之威」，改为将 2 张「斩首重创」置入手中，并使其获得「消耗」「预备 1」和「保留」。",
    AwakerID = 15564,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13340,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13330] = {
    ID = 13330,
    CnID = "启灵@复仇巨刃人格深化5",
    BaseSortID = 473,
    PotencyName = "AwakerPotency_13330_PotencyName|人格深化",
    AwakerID = 15564,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13329,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13331] = {
    ID = 13331,
    CnID = "启灵@复仇巨刃人格深化6",
    BaseSortID = 474,
    PotencyName = "AwakerPotency_13331_PotencyName|人格深化",
    AwakerID = 15564,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13330,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13332] = {
    ID = 13332,
    CnID = "启灵@复仇巨刃人格深化7",
    BaseSortID = 475,
    PotencyName = "AwakerPotency_13332_PotencyName|人格深化",
    AwakerID = 15564,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13331,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13323] = {
    ID = 13323,
    CnID = "启灵@复仇巨刃人格深化8",
    BaseSortID = 476,
    PotencyName = "AwakerPotency_13323_PotencyName|人格深化",
    AwakerID = 15564,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13332,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13324] = {
    ID = 13324,
    CnID = "启灵@复仇巨刃人格深化9",
    BaseSortID = 477,
    PotencyName = "AwakerPotency_13324_PotencyName|人格深化",
    AwakerID = 15564,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13323,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13125] = {
    ID = 13125,
    CnID = "启灵@复仇巨刃人格深化10",
    BaseSortID = 478,
    PotencyName = "AwakerPotency_13125_PotencyName|人格深化",
    AwakerID = 15564,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13324,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13126] = {
    ID = 13126,
    CnID = "启灵@复仇巨刃人格深化11",
    BaseSortID = 479,
    PotencyName = "AwakerPotency_13126_PotencyName|人格深化",
    AwakerID = 15564,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 13125,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13124] = {
    ID = 13124,
    CnID = "启灵@复仇巨刃人格深化12",
    BaseSortID = 480,
    PotencyName = "AwakerPotency_13124_PotencyName|暴君的登临",
    PotencyDesc = "AwakerPotency_13124_PotencyDesc|灵知觉醒「复仇预行」获得强化，戈利亚在怒涛姿态下额外享受 300% 力量加成。",
    AwakerID = 15564,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13126,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13080] = {
    ID = 13080,
    CnID = "启灵@丰穰之息隐入林中",
    BaseSortID = 481,
    PotencyName = "AwakerPotency_13080_PotencyName|隐入林中",
    PotencyDesc = "AwakerPotency_13080_PotencyDesc|「古老的爱抚」获得的力量提高 50%，「圣血的本能」选择效果翻倍。",
    AwakerID = 15596,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13226] = {
    ID = 13226,
    CnID = "启灵@丰穰之息生生不息",
    BaseSortID = 482,
    PotencyName = "AwakerPotency_13226_PotencyName|混沌之种",
    PotencyDesc = "AwakerPotency_13226_PotencyDesc|「丰穰之仪」还会使本次置入手中的原始复制算力消耗 -1。",
    AwakerID = 15596,
    PotencyType = "PassiveSkill",
    FrontPotency = 13080,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13363] = {
    ID = 13363,
    CnID = "启灵@丰穰之息奇异永世",
    BaseSortID = 483,
    PotencyName = "AwakerPotency_13363_PotencyName|生生不息",
    PotencyDesc = "AwakerPotency_13363_PotencyDesc|血肉界域每回合自动获得的胚胎融合提高 50%。「基础打击」和 「基础防御」获得等同于攻击力 3% 的力量。",
    AwakerID = 15596,
    PotencyType = "PassiveSkill",
    FrontPotency = 13226,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13631] = {
    ID = 13631,
    CnID = "启灵@丰穰之息人格深化1",
    BaseSortID = 484,
    PotencyName = "AwakerPotency_13631_PotencyName|人格深化",
    AwakerID = 15596,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13363,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13630] = {
    ID = 13630,
    CnID = "启灵@丰穰之息人格深化2",
    BaseSortID = 485,
    PotencyName = "AwakerPotency_13630_PotencyName|人格深化",
    AwakerID = 15596,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13631,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13629] = {
    ID = 13629,
    CnID = "启灵@丰穰之息人格深化3",
    BaseSortID = 486,
    PotencyName = "AwakerPotency_13629_PotencyName|人格深化",
    AwakerID = 15596,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13630,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13628] = {
    ID = 13628,
    CnID = "启灵@丰穰之息人格深化4",
    BaseSortID = 487,
    PotencyName = "AwakerPotency_13628_PotencyName|永续圣骸的传承",
    PotencyDesc = "AwakerPotency_13628_PotencyDesc|接下来 3 回合内，每回合开始时尝试将 1 张「胚胎」转化为「圣洁之子」，如果没有「胚胎」则<EmbryoFusionIconKeywords:胚胎融合> +100，不受胚胎融合提高效果影响。",
    AwakerID = 15596,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13629,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13116] = {
    ID = 13116,
    CnID = "启灵@丰穰之息人格深化5",
    BaseSortID = 488,
    PotencyName = "AwakerPotency_13116_PotencyName|人格深化",
    AwakerID = 15596,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13628,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13626] = {
    ID = 13626,
    CnID = "启灵@丰穰之息人格深化6",
    BaseSortID = 489,
    PotencyName = "AwakerPotency_13626_PotencyName|人格深化",
    AwakerID = 15596,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13116,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13625] = {
    ID = 13625,
    CnID = "启灵@丰穰之息人格深化7",
    BaseSortID = 490,
    PotencyName = "AwakerPotency_13625_PotencyName|人格深化",
    AwakerID = 15596,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13626,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13624] = {
    ID = 13624,
    CnID = "启灵@丰穰之息人格深化8",
    BaseSortID = 491,
    PotencyName = "AwakerPotency_13624_PotencyName|人格深化",
    AwakerID = 15596,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13625,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13623] = {
    ID = 13623,
    CnID = "启灵@丰穰之息人格深化9",
    BaseSortID = 492,
    PotencyName = "AwakerPotency_13623_PotencyName|人格深化",
    AwakerID = 15596,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13624,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13138] = {
    ID = 13138,
    CnID = "启灵@丰穰之息人格深化10",
    BaseSortID = 493,
    PotencyName = "AwakerPotency_13138_PotencyName|人格深化",
    AwakerID = 15596,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13623,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13137] = {
    ID = 13137,
    CnID = "启灵@丰穰之息人格深化11",
    BaseSortID = 494,
    PotencyName = "AwakerPotency_13137_PotencyName|人格深化",
    AwakerID = 15596,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13138,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13136] = {
    ID = 13136,
    CnID = "启灵@丰穰之息人格深化12",
    BaseSortID = 495,
    PotencyName = "AwakerPotency_13136_PotencyName|源生万物的胎海",
    PotencyDesc = "AwakerPotency_13136_PotencyDesc|灵知觉醒「目见母亲」获得强化，泰旖丝的狂气爆发额外复制 1 张所选卡牌。",
    AwakerID = 15596,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13137,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13517] = {
    ID = 13517,
    CnID = "启灵@雕砌者如歌的雕琢",
    BaseSortID = 496,
    PotencyName = "AwakerPotency_13517_PotencyName|如歌的雕琢",
    PotencyDesc = "AwakerPotency_13517_PotencyDesc|「封闭创作」立即获得等同于防御力 [Arg1]% 的护盾。（效果随「封闭创作」的等级提升）",
    AwakerID = 15592,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4160,1,2,1)"
    },
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13206] = {
    ID = 13206,
    CnID = "启灵@雕砌者匍匐于美",
    BaseSortID = 497,
    PotencyName = "AwakerPotency_13206_PotencyName|匍匐于美",
    PotencyDesc = "AwakerPotency_13206_PotencyDesc|「美的怜悯」每有 1 条触腕，额外获得等同于防御力 [Arg1]% 的护盾。（效果随「美的怜悯」的等级提升）",
    AwakerID = 15592,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4643,2,2,1)"
    },
    FrontPotency = 13517,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13084] = {
    ID = 13084,
    CnID = "启灵@雕砌者艺术狂欢",
    BaseSortID = 498,
    PotencyName = "AwakerPotency_13084_PotencyName|艺术狂欢",
    PotencyDesc = "AwakerPotency_13084_PotencyDesc|「失落的艺术」基础伤害与护盾提高25% ，额外享受 25% 暴击率与暴击伤害加成。",
    AwakerID = 15592,
    PotencyType = "PassiveSkill",
    FrontPotency = 13206,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13318] = {
    ID = 13318,
    CnID = "启灵@雕砌者人格深化1",
    BaseSortID = 499,
    PotencyName = "AwakerPotency_13318_PotencyName|人格深化",
    AwakerID = 15592,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13084,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13316] = {
    ID = 13316,
    CnID = "启灵@雕砌者人格深化2",
    BaseSortID = 500,
    PotencyName = "AwakerPotency_13316_PotencyName|人格深化",
    AwakerID = 15592,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13318,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13317] = {
    ID = 13317,
    CnID = "启灵@雕砌者人格深化3",
    BaseSortID = 501,
    PotencyName = "AwakerPotency_13317_PotencyName|人格深化",
    AwakerID = 15592,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13316,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13314] = {
    ID = 13314,
    CnID = "启灵@雕砌者人格深化4",
    BaseSortID = 502,
    PotencyName = "AwakerPotency_13314_PotencyName|珊瑚海之约",
    PotencyDesc = "AwakerPotency_13314_PotencyDesc|获得的护盾提高 200%，使本场战斗中「失落的艺术」和「基础打击」造成的伤害额外享受 100% 护盾加成。",
    AwakerID = 15592,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13317,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13315] = {
    ID = 13315,
    CnID = "启灵@雕砌者人格深化5",
    BaseSortID = 503,
    PotencyName = "AwakerPotency_13315_PotencyName|人格深化",
    AwakerID = 15592,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13314,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13247] = {
    ID = 13247,
    CnID = "启灵@雕砌者人格深化6",
    BaseSortID = 504,
    PotencyName = "AwakerPotency_13247_PotencyName|人格深化",
    AwakerID = 15592,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13315,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13313] = {
    ID = 13313,
    CnID = "启灵@雕砌者人格深化7",
    BaseSortID = 505,
    PotencyName = "AwakerPotency_13313_PotencyName|人格深化",
    AwakerID = 15592,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13247,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13310] = {
    ID = 13310,
    CnID = "启灵@雕砌者人格深化8",
    BaseSortID = 506,
    PotencyName = "AwakerPotency_13310_PotencyName|人格深化",
    AwakerID = 15592,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13313,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13311] = {
    ID = 13311,
    CnID = "启灵@雕砌者人格深化9",
    BaseSortID = 507,
    PotencyName = "AwakerPotency_13311_PotencyName|人格深化",
    AwakerID = 15592,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13310,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13563] = {
    ID = 13563,
    CnID = "启灵@雕砌者人格深化10",
    BaseSortID = 508,
    PotencyName = "AwakerPotency_13563_PotencyName|人格深化",
    AwakerID = 15592,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13311,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13564] = {
    ID = 13564,
    CnID = "启灵@雕砌者人格深化11",
    BaseSortID = 509,
    PotencyName = "AwakerPotency_13564_PotencyName|人格深化",
    AwakerID = 15592,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    FrontPotency = 13563,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13565] = {
    ID = 13565,
    CnID = "启灵@雕砌者人格深化12",
    BaseSortID = 510,
    PotencyName = "AwakerPotency_13565_PotencyName|物我两忘",
    PotencyDesc = "AwakerPotency_13565_PotencyDesc|灵知觉醒「忘我之境」获得强化，珊造成的最终伤害提高 15%，且每有 1 条永久触腕都会使珊造成的护盾和最终伤害提高 3%。",
    AwakerID = 15592,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      0.6,
      18151,
      5.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13564,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13582] = {
    ID = 13582,
    CnID = "启灵@嘀嗒人自我修正",
    BaseSortID = 511,
    PotencyName = "AwakerPotency_13582_PotencyName|自我修正",
    PotencyDesc = "AwakerPotency_13582_PotencyDesc|「机械武装-放」将 1 张拥有消耗的「基础打击」置入手中，「机械武装-敛」将 1 张拥有消耗的 「基础防御」置入手中。",
    AwakerID = 15603,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13583] = {
    ID = 13583,
    CnID = "启灵@嘀嗒人强制回路",
    BaseSortID = 512,
    PotencyName = "AwakerPotency_13583_PotencyName|强制回路",
    PotencyDesc = "AwakerPotency_13583_PotencyDesc|「电磁爆破」享受额外 1 倍力量和戒备加成。",
    AwakerID = 15603,
    PotencyType = "PassiveSkill",
    FrontPotency = 13582,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13441] = {
    ID = 13441,
    CnID = "启灵@嘀嗒人再启动",
    BaseSortID = 513,
    PotencyName = "AwakerPotency_13441_PotencyName|再启动",
    PotencyDesc = "AwakerPotency_13441_PotencyDesc|「机能过载」获得跃迁：同时具有伤害和护盾 2 个效果。",
    AwakerID = 15603,
    PotencyType = "PassiveSkill",
    FrontPotency = 13583,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13288] = {
    ID = 13288,
    CnID = "启灵@嘀嗒人人格深化1",
    BaseSortID = 514,
    PotencyName = "AwakerPotency_13288_PotencyName|人格深化",
    AwakerID = 15603,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13441,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13118] = {
    ID = 13118,
    CnID = "启灵@嘀嗒人人格深化2",
    BaseSortID = 515,
    PotencyName = "AwakerPotency_13118_PotencyName|人格深化",
    AwakerID = 15603,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13288,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13286] = {
    ID = 13286,
    CnID = "启灵@嘀嗒人人格深化3",
    BaseSortID = 516,
    PotencyName = "AwakerPotency_13286_PotencyName|人格深化",
    AwakerID = 15603,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13118,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13283] = {
    ID = 13283,
    CnID = "启灵@嘀嗒人人格深化4",
    BaseSortID = 517,
    PotencyName = "AwakerPotency_13283_PotencyName|多重计算",
    PotencyDesc = "AwakerPotency_13283_PotencyDesc|「电磁爆破」基础伤害和护盾提高 100%。艾瑞卡的「基础打击」额外造成 1 次伤害，「基础防御」额外获得 1 次护盾，持续 3 回合。",
    AwakerID = 15603,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13286,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13284] = {
    ID = 13284,
    CnID = "启灵@嘀嗒人人格深化5",
    BaseSortID = 518,
    PotencyName = "AwakerPotency_13284_PotencyName|人格深化",
    AwakerID = 15603,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13283,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13112] = {
    ID = 13112,
    CnID = "启灵@嘀嗒人人格深化6",
    BaseSortID = 519,
    PotencyName = "AwakerPotency_13112_PotencyName|人格深化",
    AwakerID = 15603,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13284,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13114] = {
    ID = 13114,
    CnID = "启灵@嘀嗒人人格深化7",
    BaseSortID = 520,
    PotencyName = "AwakerPotency_13114_PotencyName|人格深化",
    AwakerID = 15603,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13112,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13279] = {
    ID = 13279,
    CnID = "启灵@嘀嗒人人格深化8",
    BaseSortID = 521,
    PotencyName = "AwakerPotency_13279_PotencyName|人格深化",
    AwakerID = 15603,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13114,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13111] = {
    ID = 13111,
    CnID = "启灵@嘀嗒人人格深化9",
    BaseSortID = 522,
    PotencyName = "AwakerPotency_13111_PotencyName|人格深化",
    AwakerID = 15603,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13279,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13172] = {
    ID = 13172,
    CnID = "启灵@嘀嗒人人格深化10",
    BaseSortID = 523,
    PotencyName = "AwakerPotency_13172_PotencyName|人格深化",
    AwakerID = 15603,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13111,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13173] = {
    ID = 13173,
    CnID = "启灵@嘀嗒人人格深化11",
    BaseSortID = 524,
    PotencyName = "AwakerPotency_13173_PotencyName|人格深化",
    AwakerID = 15603,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13172,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13174] = {
    ID = 13174,
    CnID = "启灵@嘀嗒人人格深化12",
    BaseSortID = 525,
    PotencyName = "AwakerPotency_13174_PotencyName|终结协议",
    PotencyDesc = "AwakerPotency_13174_PotencyDesc|灵知觉醒「参数拟合」获得强化，艾瑞卡每次释放狂气爆发后使狂气爆发享受的力量与戒备加成额外提高 1 倍。",
    AwakerID = 15603,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13173,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13723] = {
    ID = 13723,
    CnID = "启灵@窜行者特殊红色缎带",
    BaseSortID = 526,
    PotencyName = "AwakerPotency_13723_PotencyName|红色缎带",
    AwakerID = 15578,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13435] = {
    ID = 13435,
    CnID = "启灵@窜行者特殊金蝴蝶回忆",
    BaseSortID = 527,
    PotencyName = "AwakerPotency_13435_PotencyName|金蝴蝶回忆",
    AwakerID = 15578,
    PotencyType = "PassiveSkill",
    FrontPotency = 13723,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13394] = {
    ID = 13394,
    CnID = "启灵@窜行者特殊黑色溶解",
    BaseSortID = 528,
    PotencyName = "AwakerPotency_13394_PotencyName|黑色溶解",
    AwakerID = 15578,
    PotencyType = "PassiveSkill",
    FrontPotency = 13435,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13667] = {
    ID = 13667,
    CnID = "启灵@窜行者特殊人格深化1",
    BaseSortID = 529,
    PotencyName = "AwakerPotency_13667_PotencyName|人格深化",
    AwakerID = 15578,
    PotencyType = "Attr_Promote",
    FrontPotency = 13394,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13668] = {
    ID = 13668,
    CnID = "启灵@窜行者特殊人格深化2",
    BaseSortID = 530,
    PotencyName = "AwakerPotency_13668_PotencyName|人格深化",
    AwakerID = 15578,
    PotencyType = "Attr_Promote",
    FrontPotency = 13667,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13669] = {
    ID = 13669,
    CnID = "启灵@窜行者特殊人格深化3",
    BaseSortID = 531,
    PotencyName = "AwakerPotency_13669_PotencyName|人格深化",
    AwakerID = 15578,
    PotencyType = "Attr_Promote",
    FrontPotency = 13668,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13663] = {
    ID = 13663,
    CnID = "启灵@窜行者特殊人格深化4",
    BaseSortID = 532,
    PotencyName = "AwakerPotency_13663_PotencyName|超限爆发",
    AwakerID = 15578,
    PotencyType = "Attr_Promote",
    EffectType1 = "ComingSoon",
    FrontPotency = 13669,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13664] = {
    ID = 13664,
    CnID = "启灵@窜行者特殊人格深化5",
    BaseSortID = 533,
    PotencyName = "AwakerPotency_13664_PotencyName|人格深化",
    AwakerID = 15578,
    PotencyType = "Attr_Promote",
    FrontPotency = 13663,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13665] = {
    ID = 13665,
    CnID = "启灵@窜行者特殊人格深化6",
    BaseSortID = 534,
    PotencyName = "AwakerPotency_13665_PotencyName|人格深化",
    AwakerID = 15578,
    PotencyType = "Attr_Promote",
    FrontPotency = 13664,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13666] = {
    ID = 13666,
    CnID = "启灵@窜行者特殊人格深化7",
    BaseSortID = 535,
    PotencyName = "AwakerPotency_13666_PotencyName|人格深化",
    AwakerID = 15578,
    PotencyType = "Attr_Promote",
    FrontPotency = 13665,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13661] = {
    ID = 13661,
    CnID = "启灵@窜行者特殊人格深化8",
    BaseSortID = 536,
    PotencyName = "AwakerPotency_13661_PotencyName|人格深化",
    AwakerID = 15578,
    PotencyType = "Attr_Promote",
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13666,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13662] = {
    ID = 13662,
    CnID = "启灵@窜行者特殊人格深化9",
    BaseSortID = 537,
    PotencyName = "AwakerPotency_13662_PotencyName|人格深化",
    AwakerID = 15578,
    PotencyType = "Attr_Promote",
    FrontPotency = 13661,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13195] = {
    ID = 13195,
    CnID = "启灵@窜行者特殊人格深化10",
    BaseSortID = 538,
    PotencyName = "AwakerPotency_13195_PotencyName|人格深化",
    AwakerID = 15578,
    PotencyType = "Attr_Promote",
    FrontPotency = 13662,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13196] = {
    ID = 13196,
    CnID = "启灵@窜行者特殊人格深化11",
    BaseSortID = 539,
    PotencyName = "AwakerPotency_13196_PotencyName|人格深化",
    AwakerID = 15578,
    PotencyType = "Attr_Promote",
    FrontPotency = 13195,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13194] = {
    ID = 13194,
    CnID = "启灵@窜行者特殊人格深化12",
    BaseSortID = 540,
    PotencyName = "AwakerPotency_13194_PotencyName|人格深化",
    AwakerID = 15578,
    PotencyType = "Attr_Promote",
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13196,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13392] = {
    ID = 13392,
    CnID = "启灵@窜行者红色缎带",
    BaseSortID = 541,
    PotencyName = "AwakerPotency_13392_PotencyName|红色缎带",
    PotencyDesc = "AwakerPotency_13392_PotencyDesc|本场战斗每释放 1 次「布朗出动！」，「鼠群冲击」的基础伤害就提高等同于攻击力 [Arg1]% 的伤害。（效果随「布朗出动！」的等级提升）",
    AwakerID = 15593,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4533,1,3,1)"
    },
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13561] = {
    ID = 13561,
    CnID = "启灵@窜行者金蝴蝶回忆",
    BaseSortID = 542,
    PotencyName = "AwakerPotency_13561_PotencyName|金蝴蝶回忆",
    PotencyDesc = "AwakerPotency_13561_PotencyDesc|「基础防御」抽 2 张牌，若不是詹金的卡牌则将其丢弃。",
    AwakerID = 15593,
    PotencyType = "PassiveSkill",
    FrontPotency = 13392,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13475] = {
    ID = 13475,
    CnID = "启灵@窜行者黑色溶解",
    BaseSortID = 543,
    PotencyName = "AwakerPotency_13475_PotencyName|黑色溶解",
    PotencyDesc = "AwakerPotency_13475_PotencyDesc|「雾都街童」额外获得 1 张「布朗出动！」。",
    AwakerID = 15593,
    PotencyType = "PassiveSkill",
    FrontPotency = 13561,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13690] = {
    ID = 13690,
    CnID = "启灵@窜行者人格深化1",
    BaseSortID = 544,
    PotencyName = "AwakerPotency_13690_PotencyName|人格深化",
    AwakerID = 15593,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18159,
      1.6
    },
    FrontPotency = 13475,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13692] = {
    ID = 13692,
    CnID = "启灵@窜行者人格深化2",
    BaseSortID = 545,
    PotencyName = "AwakerPotency_13692_PotencyName|人格深化",
    AwakerID = 15593,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18159,
      1.6
    },
    FrontPotency = 13690,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13691] = {
    ID = 13691,
    CnID = "启灵@窜行者人格深化3",
    BaseSortID = 546,
    PotencyName = "AwakerPotency_13691_PotencyName|人格深化",
    AwakerID = 15593,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18159,
      1.6
    },
    FrontPotency = 13692,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13694] = {
    ID = 13694,
    CnID = "启灵@窜行者人格深化4",
    BaseSortID = 547,
    PotencyName = "AwakerPotency_13694_PotencyName|偷袭！",
    PotencyDesc = "AwakerPotency_13694_PotencyDesc|将 1 张附加<DepleteIconKeywords:消耗>的「超级大集结！」置入手牌。",
    AwakerID = 15593,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18159,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13691,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13693] = {
    ID = 13693,
    CnID = "启灵@窜行者人格深化5",
    BaseSortID = 548,
    PotencyName = "AwakerPotency_13693_PotencyName|人格深化",
    AwakerID = 15593,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18159,
      1.6
    },
    FrontPotency = 13694,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13696] = {
    ID = 13696,
    CnID = "启灵@窜行者人格深化6",
    BaseSortID = 549,
    PotencyName = "AwakerPotency_13696_PotencyName|人格深化",
    AwakerID = 15593,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18159,
      1.6
    },
    FrontPotency = 13693,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13695] = {
    ID = 13695,
    CnID = "启灵@窜行者人格深化7",
    BaseSortID = 550,
    PotencyName = "AwakerPotency_13695_PotencyName|人格深化",
    AwakerID = 15593,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18159,
      1.6
    },
    FrontPotency = 13696,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13698] = {
    ID = 13698,
    CnID = "启灵@窜行者人格深化8",
    BaseSortID = 551,
    PotencyName = "AwakerPotency_13698_PotencyName|人格深化",
    AwakerID = 15593,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13695,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13697] = {
    ID = 13697,
    CnID = "启灵@窜行者人格深化9",
    BaseSortID = 552,
    PotencyName = "AwakerPotency_13697_PotencyName|人格深化",
    AwakerID = 15593,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18159,
      1.6
    },
    FrontPotency = 13698,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13681] = {
    ID = 13681,
    CnID = "启灵@窜行者人格深化10",
    BaseSortID = 553,
    PotencyName = "AwakerPotency_13681_PotencyName|人格深化",
    AwakerID = 15593,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18159,
      1.6
    },
    FrontPotency = 13697,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13727] = {
    ID = 13727,
    CnID = "启灵@窜行者人格深化11",
    BaseSortID = 554,
    PotencyName = "AwakerPotency_13727_PotencyName|人格深化",
    AwakerID = 15593,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18159,
      1.6
    },
    FrontPotency = 13681,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13682] = {
    ID = 13682,
    CnID = "启灵@窜行者人格深化12",
    BaseSortID = 555,
    PotencyName = "AwakerPotency_13682_PotencyName|自雾中归来",
    PotencyDesc = "AwakerPotency_13682_PotencyDesc|灵知觉醒「空间折叠」获得强化，詹金自身从「空间折叠」和「雾都街童」中获得 2 倍暴击伤害效果。",
    AwakerID = 15593,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13727,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13306] = {
    ID = 13306,
    CnID = "启灵@沉渊者鳞刺聚合",
    BaseSortID = 556,
    PotencyName = "AwakerPotency_13306_PotencyName|血脉觉醒",
    PotencyDesc = "AwakerPotency_13306_PotencyDesc|「破碎沉戟」获得 [Arg1] 狂气。（效果随「破碎沉戟」的等级提升）",
    AwakerID = 15594,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4728,1,2,0)"
    },
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13123] = {
    ID = 13123,
    CnID = "启灵@沉渊者血脉觉醒",
    BaseSortID = 557,
    PotencyName = "AwakerPotency_13123_PotencyName|鳞刺聚合",
    PotencyDesc = "AwakerPotency_13123_PotencyDesc|「逆鳞之护」护盾提高 20%，并获得保留。",
    AwakerID = 15594,
    PotencyType = "PassiveSkill",
    FrontPotency = 13306,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13454] = {
    ID = 13454,
    CnID = "启灵@沉渊者不被接纳之痛",
    BaseSortID = 558,
    PotencyName = "AwakerPotency_13454_PotencyName|不被接纳之痛",
    PotencyDesc = "AwakerPotency_13454_PotencyDesc|回合结束时回复等同于体质 7.5% 的生命。",
    AwakerID = 15594,
    PotencyType = "PassiveSkill",
    FrontPotency = 13123,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13071] = {
    ID = 13071,
    CnID = "启灵@沉渊者人格深化1",
    BaseSortID = 559,
    PotencyName = "AwakerPotency_13071_PotencyName|人格深化",
    AwakerID = 15594,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13454,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13072] = {
    ID = 13072,
    CnID = "启灵@沉渊者人格深化2",
    BaseSortID = 560,
    PotencyName = "AwakerPotency_13072_PotencyName|人格深化",
    AwakerID = 15594,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13071,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13073] = {
    ID = 13073,
    CnID = "启灵@沉渊者人格深化3",
    BaseSortID = 561,
    PotencyName = "AwakerPotency_13073_PotencyName|人格深化",
    AwakerID = 15594,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13072,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13074] = {
    ID = 13074,
    CnID = "启灵@沉渊者人格深化4",
    BaseSortID = 562,
    PotencyName = "AwakerPotency_13074_PotencyName|倔强意志",
    PotencyDesc = "AwakerPotency_13074_PotencyDesc|使 1 条触腕攻击 5 次，获得 25% 造成伤害的反击。",
    AwakerID = 15594,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13073,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13075] = {
    ID = 13075,
    CnID = "启灵@沉渊者人格深化5",
    BaseSortID = 563,
    PotencyName = "AwakerPotency_13075_PotencyName|人格深化",
    AwakerID = 15594,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13074,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13076] = {
    ID = 13076,
    CnID = "启灵@沉渊者人格深化6",
    BaseSortID = 564,
    PotencyName = "AwakerPotency_13076_PotencyName|人格深化",
    AwakerID = 15594,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13075,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13077] = {
    ID = 13077,
    CnID = "启灵@沉渊者人格深化7",
    BaseSortID = 565,
    PotencyName = "AwakerPotency_13077_PotencyName|人格深化",
    AwakerID = 15594,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13076,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13078] = {
    ID = 13078,
    CnID = "启灵@沉渊者人格深化8",
    BaseSortID = 566,
    PotencyName = "AwakerPotency_13078_PotencyName|人格深化",
    AwakerID = 15594,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13077,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13079] = {
    ID = 13079,
    CnID = "启灵@沉渊者人格深化9",
    BaseSortID = 567,
    PotencyName = "AwakerPotency_13079_PotencyName|人格深化",
    AwakerID = 15594,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13078,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13684] = {
    ID = 13684,
    CnID = "启灵@沉渊者人格深化10",
    BaseSortID = 568,
    PotencyName = "AwakerPotency_13684_PotencyName|人格深化",
    AwakerID = 15594,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13079,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13685] = {
    ID = 13685,
    CnID = "启灵@沉渊者人格深化11",
    BaseSortID = 569,
    PotencyName = "AwakerPotency_13685_PotencyName|人格深化",
    AwakerID = 15594,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    FrontPotency = 13684,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13683] = {
    ID = 13683,
    CnID = "启灵@沉渊者人格深化12",
    BaseSortID = 570,
    PotencyName = "AwakerPotency_13683_PotencyName|不全者怒潮",
    PotencyDesc = "AwakerPotency_13683_PotencyDesc|灵知觉醒「蜕变之躯」获得强化，凯刻斯打出卡牌后使 1 条触腕进行攻击并获得 50% 造成伤害的反击。",
    AwakerID = 15594,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18155,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13685,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13660] = {
    ID = 13660,
    CnID = "启灵@沉睡之主暗夜呢喃",
    BaseSortID = 571,
    PotencyName = "AwakerPotency_13660_PotencyName|暗夜呢喃",
    PotencyDesc = "AwakerPotency_13660_PotencyDesc|「深渊号令」使触腕攻击所有敌人，若当前姿态为「静海」，算力消耗降低 2 。",
    AwakerID = 15563,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13436] = {
    ID = 13436,
    CnID = "启灵@沉睡之主复苏之触",
    BaseSortID = 572,
    PotencyName = "AwakerPotency_13436_PotencyName|复苏之触",
    PotencyDesc = "AwakerPotency_13436_PotencyDesc|「基础打击」获得图鲁攻击力的 [Arg1]% 的临时力量和临时触腕伤害，「基础防御」获得图鲁攻击力的 [Arg2]%的临时力量和临时触腕伤害（效果随「打击」、「防御」的等级提升）。",
    AwakerID = 15563,
    PotencyType = "PassiveSkill",
    EffectPara = {
      "PotencySkillParam(4714,2,3,1)",
      "PotencySkillParam(4238,2,3,1)"
    },
    FrontPotency = 13660,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13527] = {
    ID = 13527,
    CnID = "启灵@沉睡之主群星归位",
    BaseSortID = 573,
    PotencyName = "AwakerPotency_13527_PotencyName|群星归位",
    PotencyDesc = "AwakerPotency_13527_PotencyDesc|回合结束时图鲁获得 5 点狂气。「螺湮重临」提高 15% 临时暴击率。",
    AwakerID = 15563,
    PotencyType = "PassiveSkill",
    FrontPotency = 13436,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13550] = {
    ID = 13550,
    CnID = "启灵@沉睡之主人格深化1",
    BaseSortID = 574,
    PotencyName = "AwakerPotency_13550_PotencyName|人格深化",
    AwakerID = 15563,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13527,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13553] = {
    ID = 13553,
    CnID = "启灵@沉睡之主人格深化2",
    BaseSortID = 575,
    PotencyName = "AwakerPotency_13553_PotencyName|人格深化",
    AwakerID = 15563,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13550,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13552] = {
    ID = 13552,
    CnID = "启灵@沉睡之主人格深化3",
    BaseSortID = 576,
    PotencyName = "AwakerPotency_13552_PotencyName|人格深化",
    AwakerID = 15563,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13553,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13555] = {
    ID = 13555,
    CnID = "启灵@沉睡之主人格深化4",
    BaseSortID = 577,
    PotencyName = "AwakerPotency_13555_PotencyName|应许之日",
    PotencyDesc = "AwakerPotency_13555_PotencyDesc|回合结束时，号令所有触腕攻击所有敌人 2 次。",
    AwakerID = 15563,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13552,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13554] = {
    ID = 13554,
    CnID = "启灵@沉睡之主人格深化5",
    BaseSortID = 578,
    PotencyName = "AwakerPotency_13554_PotencyName|人格深化",
    AwakerID = 15563,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13555,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13557] = {
    ID = 13557,
    CnID = "启灵@沉睡之主人格深化6",
    BaseSortID = 579,
    PotencyName = "AwakerPotency_13557_PotencyName|人格深化",
    AwakerID = 15563,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13554,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13556] = {
    ID = 13556,
    CnID = "启灵@沉睡之主人格深化7",
    BaseSortID = 580,
    PotencyName = "AwakerPotency_13556_PotencyName|人格深化",
    AwakerID = 15563,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13557,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13559] = {
    ID = 13559,
    CnID = "启灵@沉睡之主人格深化8",
    BaseSortID = 581,
    PotencyName = "AwakerPotency_13559_PotencyName|人格深化",
    AwakerID = 15563,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13556,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13267] = {
    ID = 13267,
    CnID = "启灵@沉睡之主人格深化9",
    BaseSortID = 582,
    PotencyName = "AwakerPotency_13267_PotencyName|人格深化",
    AwakerID = 15563,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13559,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13425] = {
    ID = 13425,
    CnID = "启灵@沉睡之主人格深化10",
    BaseSortID = 583,
    PotencyName = "AwakerPotency_13425_PotencyName|人格深化",
    AwakerID = 15563,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13267,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13424] = {
    ID = 13424,
    CnID = "启灵@沉睡之主人格深化11",
    BaseSortID = 584,
    PotencyName = "AwakerPotency_13424_PotencyName|人格深化",
    AwakerID = 15563,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    FrontPotency = 13425,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13426] = {
    ID = 13426,
    CnID = "启灵@沉睡之主人格深化12",
    BaseSortID = 585,
    PotencyName = "AwakerPotency_13426_PotencyName|孤王",
    PotencyDesc = "AwakerPotency_13426_PotencyDesc|灵知觉醒「不朽威仪」获得强化，图鲁释放狂气爆发后，所有敌人受到的触腕伤害提高 10%，最多叠加 5 次。",
    AwakerID = 15563,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13424,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13569] = {
    ID = 13569,
    CnID = "启灵@本源知者1",
    BaseSortID = 586,
    PotencyName = "AwakerPotency_13569_PotencyName|彭罗斯行者",
    PotencyDesc = "AwakerPotency_13569_PotencyDesc|回合结束后获得 1 层负熵。",
    AwakerID = 15568,
    PotencyType = "PassiveSkill",
    EffectType = "BEAddState",
    Effect = {2476},
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13567] = {
    ID = 13567,
    CnID = "启灵@本源知者2",
    BaseSortID = 587,
    PotencyName = "AwakerPotency_13567_PotencyName|克莱因旅人",
    PotencyDesc = "AwakerPotency_13567_PotencyDesc|每当使用钥令时，环行拉蒙娜临时暴击率和临时暴击伤害 +25%。",
    AwakerID = 15568,
    PotencyType = "PassiveSkill",
    EffectType = "BEAddState",
    Effect = {24559},
    FrontPotency = 13569,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13568] = {
    ID = 13568,
    CnID = "启灵@本源知者3",
    BaseSortID = 588,
    PotencyName = "AwakerPotency_13568_PotencyName|莫比乌斯囚徒",
    PotencyDesc = "AwakerPotency_13568_PotencyDesc|狂气爆发「悖论收束」选择一个任意已解锁的钥令替换当前的钥令，使用钥令后或战斗结束后恢复。",
    AwakerID = 15568,
    PotencyType = "PassiveSkill",
    FrontPotency = 13567,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13391] = {
    ID = 13391,
    CnID = "启灵@本源知者人格深化1",
    BaseSortID = 589,
    PotencyName = "AwakerPotency_13391_PotencyName|人格深化",
    AwakerID = 15568,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13568,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13731] = {
    ID = 13731,
    CnID = "启灵@本源知者人格深化2",
    BaseSortID = 590,
    PotencyName = "AwakerPotency_13731_PotencyName|人格深化",
    AwakerID = 15568,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13391,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13128] = {
    ID = 13128,
    CnID = "启灵@本源知者人格深化3",
    BaseSortID = 591,
    PotencyName = "AwakerPotency_13128_PotencyName|人格深化",
    AwakerID = 15568,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13731,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13726] = {
    ID = 13726,
    CnID = "启灵@本源知者人格深化4",
    BaseSortID = 592,
    PotencyName = "AwakerPotency_13726_PotencyName|伸向旧日的指尖",
    PotencyDesc = "AwakerPotency_13726_PotencyDesc|获得 3 层无视上限的负熵，使获得的复制卡算力消耗变为 0 。",
    AwakerID = 15568,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13128,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13387] = {
    ID = 13387,
    CnID = "启灵@本源知者人格深化5",
    BaseSortID = 593,
    PotencyName = "AwakerPotency_13387_PotencyName|人格深化",
    AwakerID = 15568,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13726,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13658] = {
    ID = 13658,
    CnID = "启灵@本源知者人格深化6",
    BaseSortID = 594,
    PotencyName = "AwakerPotency_13658_PotencyName|人格深化",
    AwakerID = 15568,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13387,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13113] = {
    ID = 13113,
    CnID = "启灵@本源知者人格深化7",
    BaseSortID = 595,
    PotencyName = "AwakerPotency_13113_PotencyName|人格深化",
    AwakerID = 15568,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13658,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13108] = {
    ID = 13108,
    CnID = "启灵@本源知者人格深化8",
    BaseSortID = 596,
    PotencyName = "AwakerPotency_13108_PotencyName|人格深化",
    AwakerID = 15568,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13113,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13090] = {
    ID = 13090,
    CnID = "启灵@本源知者人格深化9",
    BaseSortID = 597,
    PotencyName = "AwakerPotency_13090_PotencyName|人格深化",
    AwakerID = 15568,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13108,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13433] = {
    ID = 13433,
    CnID = "启灵@本源知者人格深化10",
    BaseSortID = 598,
    PotencyName = "AwakerPotency_13433_PotencyName|人格深化",
    AwakerID = 15568,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13090,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13432] = {
    ID = 13432,
    CnID = "启灵@本源知者人格深化11",
    BaseSortID = 599,
    PotencyName = "AwakerPotency_13432_PotencyName|人格深化",
    AwakerID = 15568,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 13433,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13431] = {
    ID = 13431,
    CnID = "启灵@本源知者人格深化12",
    BaseSortID = 600,
    PotencyName = "AwakerPotency_13431_PotencyName|无限归一奇点",
    PotencyDesc = "AwakerPotency_13431_PotencyDesc|灵知觉醒「熵增逆转」获得强化，不再限制每回合生效次数。环行·拉蒙娜打出触发「回环」的卡牌后，获得 50 点银钥能量。",
    AwakerID = 15568,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13432,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13180] = {
    ID = 13180,
    CnID = "启灵@本源破链者无尽杀戮",
    BaseSortID = 601,
    PotencyName = "AwakerPotency_13180_PotencyName|无尽杀戮",
    PotencyDesc = "AwakerPotency_13180_PotencyDesc|「基础打击」使「血链·希洛」获得 15% 临时暴击率和暴击伤害。「基础防御」触发所有敌人 15% 的出血。",
    AwakerID = 15567,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13688] = {
    ID = 13688,
    CnID = "启灵@本源破链者纵情复仇",
    BaseSortID = 602,
    PotencyName = "AwakerPotency_13688_PotencyName|纵情复仇",
    PotencyDesc = "AwakerPotency_13688_PotencyDesc|「恨意宣泄」若生命低于 50%，获得的力量翻倍。「嗜血链球」的预备效果变更为预备 2。",
    AwakerID = 15567,
    PotencyType = "PassiveSkill",
    FrontPotency = 13180,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13616] = {
    ID = 13616,
    CnID = "启灵@本源破链者与我陪葬",
    BaseSortID = 603,
    PotencyName = "AwakerPotency_13616_PotencyName|余孽送葬",
    PotencyDesc = "AwakerPotency_13616_PotencyDesc|战斗开始时，将 1 张「不规则形态 · 血链」置入手牌。「缚身锁链」破除目标护盾并使目标无法获得护盾，持续 1 回合。",
    AwakerID = 15567,
    PotencyType = "PassiveSkill",
    FrontPotency = 13688,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13164] = {
    ID = 13164,
    CnID = "启灵@本源破链者人格深化1",
    BaseSortID = 604,
    PotencyName = "AwakerPotency_13164_PotencyName|人格深化",
    AwakerID = 15567,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13616,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13166] = {
    ID = 13166,
    CnID = "启灵@本源破链者人格深化2",
    BaseSortID = 605,
    PotencyName = "AwakerPotency_13166_PotencyName|人格深化",
    AwakerID = 15567,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13164,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13671] = {
    ID = 13671,
    CnID = "启灵@本源破链者人格深化3",
    BaseSortID = 606,
    PotencyName = "AwakerPotency_13671_PotencyName|人格深化",
    AwakerID = 15567,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13166,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13161] = {
    ID = 13161,
    CnID = "启灵@本源破链者人格深化4",
    BaseSortID = 607,
    PotencyName = "AwakerPotency_13161_PotencyName|桎梏仇怨",
    PotencyDesc = "AwakerPotency_13161_PotencyDesc|「血链·希洛」暴击伤害 +35%。临时手牌上限+2。将 1 张「恨意宣泄」和「鲜血链条」置入手中，并使它们算力消耗-1。",
    AwakerID = 15567,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13671,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13160] = {
    ID = 13160,
    CnID = "启灵@本源破链者人格深化5",
    BaseSortID = 608,
    PotencyName = "AwakerPotency_13160_PotencyName|人格深化",
    AwakerID = 15567,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13161,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13163] = {
    ID = 13163,
    CnID = "启灵@本源破链者人格深化6",
    BaseSortID = 609,
    PotencyName = "AwakerPotency_13163_PotencyName|人格深化",
    AwakerID = 15567,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13160,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13162] = {
    ID = 13162,
    CnID = "启灵@本源破链者人格深化7",
    BaseSortID = 610,
    PotencyName = "AwakerPotency_13162_PotencyName|人格深化",
    AwakerID = 15567,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13163,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13169] = {
    ID = 13169,
    CnID = "启灵@本源破链者人格深化8",
    BaseSortID = 611,
    PotencyName = "AwakerPotency_13169_PotencyName|人格深化",
    AwakerID = 15567,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13162,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13168] = {
    ID = 13168,
    CnID = "启灵@本源破链者人格深化9",
    BaseSortID = 612,
    PotencyName = "AwakerPotency_13168_PotencyName|人格深化",
    AwakerID = 15567,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13169,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13367] = {
    ID = 13367,
    CnID = "启灵@本源破链者人格深化10",
    BaseSortID = 613,
    PotencyName = "AwakerPotency_13367_PotencyName|人格深化",
    AwakerID = 15567,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13168,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13366] = {
    ID = 13366,
    CnID = "启灵@本源破链者人格深化11",
    BaseSortID = 614,
    PotencyName = "AwakerPotency_13366_PotencyName|人格深化",
    AwakerID = 15567,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    FrontPotency = 13367,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13368] = {
    ID = 13368,
    CnID = "启灵@本源破链者人格深化12",
    BaseSortID = 615,
    PotencyName = "AwakerPotency_13368_PotencyName|死律宣告",
    PotencyDesc = "AwakerPotency_13368_PotencyDesc|灵知觉醒「索魂者宣言」获得强化，血链希洛释放狂气爆发后，赋予手中每张不同的自身指令卡 50 层<TempPowerKeywords:临时强化>，回合结束或打出后移除。",
    AwakerID = 15567,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18142,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13366,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13243] = {
    ID = 13243,
    CnID = "启灵@本源缸中之脑1",
    BaseSortID = 616,
    PotencyName = "AwakerPotency_13243_PotencyName|北天来客",
    PotencyDesc = "AwakerPotency_13243_PotencyDesc|「自毁改造」选择「兴奋」时对所有敌人施加 1 回合易伤，选择「诅咒」时对所有敌人施加 1 回合虚弱。",
    AwakerID = 15602,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13246] = {
    ID = 13246,
    CnID = "启灵@本源缸中之脑2",
    BaseSortID = 617,
    PotencyName = "AwakerPotency_13246_PotencyName|共振菌丝",
    PotencyDesc = "AwakerPotency_13246_PotencyDesc|「终点，真理与深渊之门」和「宿命坍缩」造成的基础中毒量提高 50%，每拥有 1 层「终末」额外提高 15%，终末层数不再拥有堆叠上限。",
    AwakerID = 15602,
    PotencyType = "PassiveSkill",
    FrontPotency = 13243,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13245] = {
    ID = 13245,
    CnID = "启灵@本源缸中之脑3",
    BaseSortID = 618,
    PotencyName = "AwakerPotency_13245_PotencyName|绝灭使臣",
    PotencyDesc = "AwakerPotency_13245_PotencyDesc|「基础打击」和「基础防御」额外获得 5％ 基础狂气的狂气。「虚无终结」的纯粹伤害由 25％ 提高为 30％，额外回复 30％ 已损生命。",
    AwakerID = 15602,
    PotencyType = "PassiveSkill",
    FrontPotency = 13246,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13710] = {
    ID = 13710,
    CnID = "启灵@本源缸中之脑人格深化1",
    BaseSortID = 619,
    PotencyName = "AwakerPotency_13710_PotencyName|人格深化",
    AwakerID = 15602,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13245,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13712] = {
    ID = 13712,
    CnID = "启灵@本源缸中之脑人格深化2",
    BaseSortID = 620,
    PotencyName = "AwakerPotency_13712_PotencyName|人格深化",
    AwakerID = 15602,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13710,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13714] = {
    ID = 13714,
    CnID = "启灵@本源缸中之脑人格深化3",
    BaseSortID = 621,
    PotencyName = "AwakerPotency_13714_PotencyName|人格深化",
    AwakerID = 15602,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13712,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13381] = {
    ID = 13381,
    CnID = "启灵@本源缸中之脑人格深化4",
    BaseSortID = 622,
    PotencyName = "AwakerPotency_13381_PotencyName|癫狂感染",
    PotencyDesc = "AwakerPotency_13381_PotencyDesc|本次狂气爆发造成的狂气翻倍，所有唤醒体造成的中毒、反击、基础伤害提高 10％。若当前为首领战，额外获得 1 层「终末」。「终末形态」：每消耗 10 点狂气，额外触发所有敌人 3％ 的中毒。",
    AwakerID = 15602,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13714,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13716] = {
    ID = 13716,
    CnID = "启灵@本源缸中之脑人格深化5",
    BaseSortID = 623,
    PotencyName = "AwakerPotency_13716_PotencyName|人格深化",
    AwakerID = 15602,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13381,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13718] = {
    ID = 13718,
    CnID = "启灵@本源缸中之脑人格深化6",
    BaseSortID = 624,
    PotencyName = "AwakerPotency_13718_PotencyName|人格深化",
    AwakerID = 15602,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13716,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13720] = {
    ID = 13720,
    CnID = "启灵@本源缸中之脑人格深化7",
    BaseSortID = 625,
    PotencyName = "AwakerPotency_13720_PotencyName|人格深化",
    AwakerID = 15602,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13718,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13721] = {
    ID = 13721,
    CnID = "启灵@本源缸中之脑人格深化8",
    BaseSortID = 626,
    PotencyName = "AwakerPotency_13721_PotencyName|人格深化",
    AwakerID = 15602,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13720,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13722] = {
    ID = 13722,
    CnID = "启灵@本源缸中之脑人格深化9",
    BaseSortID = 627,
    PotencyName = "AwakerPotency_13722_PotencyName|人格深化",
    AwakerID = 15602,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13721,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13178] = {
    ID = 13178,
    CnID = "启灵@本源缸中之脑人格深化10",
    BaseSortID = 628,
    PotencyName = "AwakerPotency_13178_PotencyName|人格深化",
    AwakerID = 15602,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13722,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13179] = {
    ID = 13179,
    CnID = "启灵@本源缸中之脑人格深化11",
    BaseSortID = 629,
    PotencyName = "AwakerPotency_13179_PotencyName|人格深化",
    AwakerID = 15602,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    FrontPotency = 13178,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13176] = {
    ID = 13176,
    CnID = "启灵@本源缸中之脑人格深化12",
    BaseSortID = 630,
    PotencyName = "AwakerPotency_13176_PotencyName|诸世皆沉",
    PotencyDesc = "AwakerPotency_13176_PotencyDesc|灵知觉醒「灵魂瘟疫」获得强化，每层「终末」提高 8% 队伍伤害强效，「虚无终结」使所有唤醒体获得 30% 基础狂气。",
    AwakerID = 15602,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      1.2,
      22207,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13179,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13729] = {
    ID = 13729,
    CnID = "启灵@24拘束带",
    BaseSortID = 631,
    PotencyName = "AwakerPotency_13729_PotencyName|歇斯底里",
    PotencyDesc = "AwakerPotency_13729_PotencyDesc|「纷乱切割」基础伤害提高 33%。处于抑郁人格时使对应卡牌算力消耗额外降低 1，处于躁狂人格时伤害次数额外提高 1。",
    AwakerID = 15601,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13657] = {
    ID = 13657,
    CnID = "启灵@24灵知上行",
    BaseSortID = 632,
    PotencyName = "AwakerPotency_13657_PotencyName|拘束带",
    PotencyDesc = "AwakerPotency_13657_PotencyDesc|「异种共生」获得的狂气提高 2 点。处于抑郁人格时虚弱所有敌人 1 回合，处于躁狂人格时易伤所有敌人 1 回合。",
    AwakerID = 15601,
    PotencyType = "PassiveSkill",
    FrontPotency = 13729,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_return.png",
    IfMaxPotency = false
  },
  [13678] = {
    ID = 13678,
    CnID = "启灵@24巴甫洛夫行为研究",
    BaseSortID = 633,
    PotencyName = "AwakerPotency_13678_PotencyName|巴甫洛夫行为研究",
    PotencyDesc = "AwakerPotency_13678_PotencyDesc|回合结束时 「24」 获得 10 点狂气。 「24」 每次释放狂气爆发后，本场战斗内这个效果获得的狂气提高 1 点。",
    AwakerID = 15601,
    PotencyType = "PassiveSkill",
    FrontPotency = 13657,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13212] = {
    ID = 13212,
    CnID = "启灵@24人格深化1",
    BaseSortID = 634,
    PotencyName = "AwakerPotency_13212_PotencyName|人格深化",
    AwakerID = 15601,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13678,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13214] = {
    ID = 13214,
    CnID = "启灵@24人格深化2",
    BaseSortID = 635,
    PotencyName = "AwakerPotency_13214_PotencyName|人格深化",
    AwakerID = 15601,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13212,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13213] = {
    ID = 13213,
    CnID = "启灵@24人格深化3",
    BaseSortID = 636,
    PotencyName = "AwakerPotency_13213_PotencyName|人格深化",
    AwakerID = 15601,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13214,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13209] = {
    ID = 13209,
    CnID = "启灵@24人格深化4",
    BaseSortID = 637,
    PotencyName = "AwakerPotency_13209_PotencyName|畸变的解剖",
    PotencyDesc = "AwakerPotency_13209_PotencyDesc|获得 24 点界域精通，「24」的下一张指令卡生效 3 次。",
    AwakerID = 15601,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13213,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13208] = {
    ID = 13208,
    CnID = "启灵@24人格深化5",
    BaseSortID = 638,
    PotencyName = "AwakerPotency_13208_PotencyName|人格深化",
    AwakerID = 15601,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13209,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13211] = {
    ID = 13211,
    CnID = "启灵@24人格深化6",
    BaseSortID = 639,
    PotencyName = "AwakerPotency_13211_PotencyName|人格深化",
    AwakerID = 15601,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13208,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13210] = {
    ID = 13210,
    CnID = "启灵@24人格深化7",
    BaseSortID = 640,
    PotencyName = "AwakerPotency_13210_PotencyName|人格深化",
    AwakerID = 15601,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13211,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13217] = {
    ID = 13217,
    CnID = "启灵@24人格深化8",
    BaseSortID = 641,
    PotencyName = "AwakerPotency_13217_PotencyName|人格深化",
    AwakerID = 15601,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13210,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13216] = {
    ID = 13216,
    CnID = "启灵@24人格深化9",
    BaseSortID = 642,
    PotencyName = "AwakerPotency_13216_PotencyName|人格深化",
    AwakerID = 15601,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13217,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13521] = {
    ID = 13521,
    CnID = "启灵@24人格深化10",
    BaseSortID = 643,
    PotencyName = "AwakerPotency_13521_PotencyName|人格深化",
    AwakerID = 15601,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13216,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13520] = {
    ID = 13520,
    CnID = "启灵@24人格深化11",
    BaseSortID = 644,
    PotencyName = "AwakerPotency_13520_PotencyName|人格深化",
    AwakerID = 15601,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    FrontPotency = 13521,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13522] = {
    ID = 13522,
    CnID = "启灵@24人格深化12",
    BaseSortID = 645,
    PotencyName = "AwakerPotency_13522_PotencyName|阿尼姆斯投射",
    PotencyDesc = "AwakerPotency_13522_PotencyDesc|灵知觉醒「调停人格」获得强化， 「24」的指令卡人格效果加成翻倍。「24」释放狂气爆发后人格加成翻倍效果本回合失效。",
    AwakerID = 15601,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13520,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [54162] = {
    ID = 54162,
    CnID = "启灵@哈姆林1",
    BaseSortID = 646,
    PotencyName = "AwakerPotency_54162_PotencyName|心灵协奏",
    PotencyDesc = "AwakerPotency_54162_PotencyDesc|「基础打击」和 「基础防御」获得等同于攻击力 15% 的临时力量。若其触发「乐音」效果，获得的临时力量翻倍。",
    AwakerID = 54117,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [54163] = {
    ID = 54163,
    CnID = "启灵@哈姆林2",
    BaseSortID = 647,
    PotencyName = "AwakerPotency_54163_PotencyName|梦中圆舞",
    PotencyDesc = "AwakerPotency_54163_PotencyDesc|「回环乐音」使赋予的卡牌算力消耗 -2。",
    AwakerID = 54117,
    PotencyType = "PassiveSkill",
    FrontPotency = 54162,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [54164] = {
    ID = 54164,
    CnID = "启灵@哈姆林3",
    BaseSortID = 648,
    PotencyName = "AwakerPotency_54164_PotencyName|月下狂想",
    PotencyDesc = "AwakerPotency_54164_PotencyDesc|触发「乐音」效果或打出 「协乐的交响」后，哈姆林获得 1% 暴击率和暴击伤害。每触发 10 次，本场战斗「灵魂序曲」和「原初的乐音」伤害次数提高 1，最多提高 3 次。",
    AwakerID = 54117,
    PotencyType = "PassiveSkill",
    FrontPotency = 54163,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [54165] = {
    ID = 54165,
    CnID = "启灵@哈姆林人格深化1",
    BaseSortID = 649,
    PotencyName = "AwakerPotency_54165_PotencyName|人格深化",
    AwakerID = 54117,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18159,
      0.8
    },
    FrontPotency = 54164,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54167] = {
    ID = 54167,
    CnID = "启灵@哈姆林人格深化2",
    BaseSortID = 650,
    PotencyName = "AwakerPotency_54167_PotencyName|人格深化",
    AwakerID = 54117,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18159,
      0.8
    },
    FrontPotency = 54165,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54166] = {
    ID = 54166,
    CnID = "启灵@哈姆林人格深化3",
    BaseSortID = 651,
    PotencyName = "AwakerPotency_54166_PotencyName|人格深化",
    AwakerID = 54117,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18159,
      0.8
    },
    FrontPotency = 54167,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54169] = {
    ID = 54169,
    CnID = "启灵@哈姆林人格深化4",
    BaseSortID = 652,
    PotencyName = "AwakerPotency_54169_PotencyName|终末的奏鸣",
    PotencyDesc = "AwakerPotency_54169_PotencyDesc|每次造成伤害会对目标随机施加 1 种奇妙负面效果，额外选择 1 张不具有「乐音」的非消耗且非衍生的指令卡添加「回环乐音」。",
    AwakerID = 54117,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18159,
      0.8
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 54166,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54168] = {
    ID = 54168,
    CnID = "启灵@哈姆林人格深化5",
    BaseSortID = 653,
    PotencyName = "AwakerPotency_54168_PotencyName|人格深化",
    AwakerID = 54117,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18159,
      0.8
    },
    FrontPotency = 54169,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54171] = {
    ID = 54171,
    CnID = "启灵@哈姆林人格深化6",
    BaseSortID = 654,
    PotencyName = "AwakerPotency_54171_PotencyName|人格深化",
    AwakerID = 54117,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18159,
      0.8
    },
    FrontPotency = 54168,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54170] = {
    ID = 54170,
    CnID = "启灵@哈姆林人格深化7",
    BaseSortID = 655,
    PotencyName = "AwakerPotency_54170_PotencyName|人格深化",
    AwakerID = 54117,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18159,
      0.8
    },
    FrontPotency = 54171,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54173] = {
    ID = 54173,
    CnID = "启灵@哈姆林人格深化8",
    BaseSortID = 656,
    PotencyName = "AwakerPotency_54173_PotencyName|人格深化",
    AwakerID = 54117,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18159,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 54170,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54172] = {
    ID = 54172,
    CnID = "启灵@哈姆林人格深化9",
    BaseSortID = 657,
    PotencyName = "AwakerPotency_54172_PotencyName|人格深化",
    AwakerID = 54117,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18159,
      0.8
    },
    FrontPotency = 54173,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54178] = {
    ID = 54178,
    CnID = "启灵@哈姆林人格深化10",
    BaseSortID = 658,
    PotencyName = "AwakerPotency_54178_PotencyName|人格深化",
    AwakerID = 54117,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18159,
      0.8
    },
    FrontPotency = 54172,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54177] = {
    ID = 54177,
    CnID = "启灵@哈姆林人格深化11",
    BaseSortID = 659,
    PotencyName = "AwakerPotency_54177_PotencyName|人格深化",
    AwakerID = 54117,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18159,
      0.8
    },
    FrontPotency = 54178,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54179] = {
    ID = 54179,
    CnID = "启灵@哈姆林人格深化12",
    BaseSortID = 660,
    PotencyName = "AwakerPotency_54179_PotencyName|万界于此鸣响",
    PotencyDesc = "AwakerPotency_54179_PotencyDesc|灵知觉醒「此曲应得称颂」获得强化，回合开始时每有 1 张指令卡拥有乐音，哈姆林获得 5 点狂气。哈姆林释放狂气爆发时每存在 2 张指令卡拥有乐音，伤害次数+1。",
    AwakerID = 54117,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18159,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 54177,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [54176] = {
    ID = 54176,
    CnID = "启灵@塔薇1",
    BaseSortID = 661,
    PotencyName = "AwakerPotency_54176_PotencyName|无穷智慧",
    PotencyDesc = "AwakerPotency_54176_PotencyDesc|「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。",
    AwakerID = 54116,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [54175] = {
    ID = 54175,
    CnID = "启灵@塔薇2",
    BaseSortID = 662,
    PotencyName = "AwakerPotency_54175_PotencyName|全知全能",
    PotencyDesc = "AwakerPotency_54175_PotencyDesc|「万物归一」发现的卡牌获得预备 1。",
    AwakerID = 54116,
    PotencyType = "PassiveSkill",
    FrontPotency = 54176,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [54174] = {
    ID = 54174,
    CnID = "启灵@塔薇3",
    BaseSortID = 663,
    PotencyName = "AwakerPotency_54174_PotencyName|不存在的存在",
    PotencyDesc = "AwakerPotency_54174_PotencyDesc|「基础打击」和「基础防御」使塔薇获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。",
    AwakerID = 54116,
    PotencyType = "PassiveSkill",
    FrontPotency = 54175,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [54188] = {
    ID = 54188,
    CnID = "启灵@塔薇人格深化1",
    BaseSortID = 664,
    PotencyName = "AwakerPotency_54188_PotencyName|人格深化",
    AwakerID = 54116,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 54174,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54186] = {
    ID = 54186,
    CnID = "启灵@塔薇人格深化2",
    BaseSortID = 665,
    PotencyName = "AwakerPotency_54186_PotencyName|人格深化",
    AwakerID = 54116,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 54188,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54187] = {
    ID = 54187,
    CnID = "启灵@塔薇人格深化3",
    BaseSortID = 666,
    PotencyName = "AwakerPotency_54187_PotencyName|人格深化",
    AwakerID = 54116,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 54186,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54184] = {
    ID = 54184,
    CnID = "启灵@塔薇人格深化4",
    BaseSortID = 667,
    PotencyName = "AwakerPotency_54184_PotencyName|无限亿万光辉",
    PotencyDesc = "AwakerPotency_54184_PotencyDesc|塔薇造成的伤害、护盾、生命回复临时提高 35%，发现的技能卡数量由 5 张改为 10 张并立即获得 3 算力。",
    AwakerID = 54116,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 54187,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54185] = {
    ID = 54185,
    CnID = "启灵@塔薇人格深化5",
    BaseSortID = 668,
    PotencyName = "AwakerPotency_54185_PotencyName|人格深化",
    AwakerID = 54116,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 54184,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54182] = {
    ID = 54182,
    CnID = "启灵@塔薇人格深化6",
    BaseSortID = 669,
    PotencyName = "AwakerPotency_54182_PotencyName|人格深化",
    AwakerID = 54116,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 54185,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54183] = {
    ID = 54183,
    CnID = "启灵@塔薇人格深化7",
    BaseSortID = 670,
    PotencyName = "AwakerPotency_54183_PotencyName|人格深化",
    AwakerID = 54116,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 54182,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54180] = {
    ID = 54180,
    CnID = "启灵@塔薇人格深化8",
    BaseSortID = 671,
    PotencyName = "AwakerPotency_54180_PotencyName|人格深化",
    AwakerID = 54116,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 54183,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54181] = {
    ID = 54181,
    CnID = "启灵@塔薇人格深化9",
    BaseSortID = 672,
    PotencyName = "AwakerPotency_54181_PotencyName|人格深化",
    AwakerID = 54116,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 54180,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54159] = {
    ID = 54159,
    CnID = "启灵@塔薇人格深化10",
    BaseSortID = 673,
    PotencyName = "AwakerPotency_54159_PotencyName|人格深化",
    AwakerID = 54116,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 54181,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54160] = {
    ID = 54160,
    CnID = "启灵@塔薇人格深化11",
    BaseSortID = 674,
    PotencyName = "AwakerPotency_54160_PotencyName|人格深化",
    AwakerID = 54116,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 54159,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [54161] = {
    ID = 54161,
    CnID = "启灵@塔薇人格深化12",
    BaseSortID = 675,
    PotencyName = "AwakerPotency_54161_PotencyName|创生真理",
    PotencyDesc = "AwakerPotency_54161_PotencyDesc|灵知觉醒「穿越银钥之门」获得强化，塔薇释放狂气爆发后其他唤醒体本回合指令卡最终伤害 +15%，还会使下 1 张其他唤醒体指令卡额外生效 1 次。",
    AwakerID = 54116,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 54160,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [79013] = {
    ID = 79013,
    CnID = "启灵@克莱门汀1",
    BaseSortID = 676,
    PotencyName = "AwakerPotency_79013_PotencyName|叩响心智门扉",
    PotencyDesc = "AwakerPotency_79013_PotencyDesc|战斗开始时获得 5 层「共感」。「生命重构治疗」基础伤害提高 20%。",
    AwakerID = 77925,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [79132] = {
    ID = 79132,
    CnID = "启灵@克莱门汀2",
    BaseSortID = 677,
    PotencyName = "AwakerPotency_79132_PotencyName|灵魂治愈之旅",
    PotencyDesc = "AwakerPotency_79132_PotencyDesc|「生命重构治疗」额外获得 200％ 克莱门汀银钥充能的银钥能量。每移除 1 层「共感」，使克莱门汀造成的基础伤害提高 3%。每场战斗结束后，使克莱门汀造成的基础伤害提高 25％。",
    AwakerID = 77925,
    PotencyType = "PassiveSkill",
    FrontPotency = 79013,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79133] = {
    ID = 79133,
    CnID = "启灵@克莱门汀3",
    BaseSortID = 678,
    PotencyName = "AwakerPotency_79133_PotencyName|你终将痊愈",
    PotencyDesc = "AwakerPotency_79133_PotencyDesc|回合结束时获得 2 层「共感」。「共感」、「精神创伤」、「恐惧固着」的堆叠层数上限提高为 15。",
    AwakerID = 77925,
    PotencyType = "PassiveSkill",
    FrontPotency = 79132,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [79003] = {
    ID = 79003,
    CnID = "启灵@克莱门汀人格深化1",
    BaseSortID = 679,
    PotencyName = "AwakerPotency_79003_PotencyName|人格深化",
    AwakerID = 77925,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 79133,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79006] = {
    ID = 79006,
    CnID = "启灵@克莱门汀人格深化2",
    BaseSortID = 680,
    PotencyName = "AwakerPotency_79006_PotencyName|人格深化",
    AwakerID = 77925,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 79003,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79005] = {
    ID = 79005,
    CnID = "启灵@克莱门汀人格深化3",
    BaseSortID = 681,
    PotencyName = "AwakerPotency_79005_PotencyName|人格深化",
    AwakerID = 77925,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 79006,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79000] = {
    ID = 79000,
    CnID = "启灵@克莱门汀人格深化4",
    BaseSortID = 682,
    PotencyName = "AwakerPotency_79000_PotencyName|潜意识侵蚀",
    PotencyDesc = "AwakerPotency_79000_PotencyDesc|获得克莱门汀攻击力 50％ 的力量和 300％ 克莱门汀银钥充能的银钥能量。移除「共感」时，同时触发「精神创伤」与「恐惧固着」效果。",
    AwakerID = 77925,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18142,
      0.8
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 79005,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78999] = {
    ID = 78999,
    CnID = "启灵@克莱门汀人格深化5",
    BaseSortID = 683,
    PotencyName = "AwakerPotency_78999_PotencyName|人格深化",
    AwakerID = 77925,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 79000,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78994] = {
    ID = 78994,
    CnID = "启灵@克莱门汀人格深化6",
    BaseSortID = 684,
    PotencyName = "AwakerPotency_78994_PotencyName|人格深化",
    AwakerID = 77925,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 78999,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79001] = {
    ID = 79001,
    CnID = "启灵@克莱门汀人格深化7",
    BaseSortID = 685,
    PotencyName = "AwakerPotency_79001_PotencyName|人格深化",
    AwakerID = 77925,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 78994,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79019] = {
    ID = 79019,
    CnID = "启灵@克莱门汀人格深化8",
    BaseSortID = 686,
    PotencyName = "AwakerPotency_79019_PotencyName|人格深化",
    AwakerID = 77925,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18142,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79001,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79017] = {
    ID = 79017,
    CnID = "启灵@克莱门汀人格深化9",
    BaseSortID = 687,
    PotencyName = "AwakerPotency_79017_PotencyName|人格深化",
    AwakerID = 77925,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 79019,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79087] = {
    ID = 79087,
    CnID = "启灵@克莱门汀人格深化10",
    BaseSortID = 688,
    PotencyName = "AwakerPotency_79087_PotencyName|人格深化",
    AwakerID = 77925,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 79017,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79076] = {
    ID = 79076,
    CnID = "启灵@克莱门汀人格深化11",
    BaseSortID = 689,
    PotencyName = "AwakerPotency_79076_PotencyName|人格深化",
    AwakerID = 77925,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 79087,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78961] = {
    ID = 78961,
    CnID = "启灵@克莱门汀人格深化12",
    BaseSortID = 690,
    PotencyName = "AwakerPotency_78961_PotencyName|集体无意识空间",
    PotencyDesc = "AwakerPotency_78961_PotencyDesc|灵知觉醒「妖虫的呼唤」获得强化，克莱门汀造成的伤害次数 +1，「共感」上限提高为 20。",
    AwakerID = 77925,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18142,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79076,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [78948] = {
    ID = 78948,
    CnID = "启灵@克珀珊特1",
    BaseSortID = 691,
    PotencyName = "AwakerPotency_78948_PotencyName|北极星的密语",
    PotencyDesc = "AwakerPotency_78948_PotencyDesc|「基础打击」和「基础防御」获得狂气提高 5 点，获得「余波」：下次打出获得的狂气提高 5，最多叠加 2 次。",
    AwakerID = 77922,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [78946] = {
    ID = 78946,
    CnID = "启灵@克珀珊特2",
    BaseSortID = 692,
    PotencyName = "AwakerPotency_78946_PotencyName|六分仪的测算",
    PotencyDesc = "AwakerPotency_78946_PotencyDesc|「混沌旗语」虚弱所有敌人 1 回合。每有 1 条触腕，「领航」护盾、力量、触腕伤害提高 5%，至多提高 50%。",
    AwakerID = 77922,
    PotencyType = "PassiveSkill",
    FrontPotency = 78948,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [78947] = {
    ID = 78947,
    CnID = "启灵@克珀珊特3",
    BaseSortID = 693,
    PotencyName = "AwakerPotency_78947_PotencyName|无悔的牺牲",
    PotencyDesc = "AwakerPotency_78947_PotencyDesc|「照彻渊海的引航」易伤所有敌人 1 回合，临时暴击伤害提高 30％，本场战斗每触发过 1 次死亡抵抗额外提高 15％。",
    AwakerID = 77922,
    PotencyType = "PassiveSkill",
    FrontPotency = 78946,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [79060] = {
    ID = 79060,
    CnID = "启灵@克珀珊特人格深化1",
    BaseSortID = 694,
    PotencyName = "AwakerPotency_79060_PotencyName|人格深化",
    AwakerID = 77922,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      18159,
      0.8
    },
    FrontPotency = 78947,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79059] = {
    ID = 79059,
    CnID = "启灵@克珀珊特人格深化2",
    BaseSortID = 695,
    PotencyName = "AwakerPotency_79059_PotencyName|人格深化",
    AwakerID = 77922,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      18159,
      0.8
    },
    FrontPotency = 79060,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79058] = {
    ID = 79058,
    CnID = "启灵@克珀珊特人格深化3",
    BaseSortID = 696,
    PotencyName = "AwakerPotency_79058_PotencyName|人格深化",
    AwakerID = 77922,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      18159,
      0.8
    },
    FrontPotency = 79059,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79065] = {
    ID = 79065,
    CnID = "启灵@克珀珊特人格深化4",
    BaseSortID = 697,
    PotencyName = "AwakerPotency_79065_PotencyName|赴死如归的天火",
    PotencyDesc = "AwakerPotency_79065_PotencyDesc|获得 3 条触腕，弃置的手牌「余波」效果额外生效 1 次。",
    AwakerID = 77922,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      18159,
      0.8
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 79058,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79064] = {
    ID = 79064,
    CnID = "启灵@克珀珊特人格深化5",
    BaseSortID = 698,
    PotencyName = "AwakerPotency_79064_PotencyName|人格深化",
    AwakerID = 77922,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      18159,
      0.8
    },
    FrontPotency = 79065,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79156] = {
    ID = 79156,
    CnID = "启灵@克珀珊特人格深化6",
    BaseSortID = 699,
    PotencyName = "AwakerPotency_79156_PotencyName|人格深化",
    AwakerID = 77922,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      18159,
      0.8
    },
    FrontPotency = 79064,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79062] = {
    ID = 79062,
    CnID = "启灵@克珀珊特人格深化7",
    BaseSortID = 700,
    PotencyName = "AwakerPotency_79062_PotencyName|人格深化",
    AwakerID = 77922,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      18159,
      0.8
    },
    FrontPotency = 79156,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79192] = {
    ID = 79192,
    CnID = "启灵@克珀珊特人格深化8",
    BaseSortID = 701,
    PotencyName = "AwakerPotency_79192_PotencyName|人格深化",
    AwakerID = 77922,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      18159,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79062,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79067] = {
    ID = 79067,
    CnID = "启灵@克珀珊特人格深化9",
    BaseSortID = 702,
    PotencyName = "AwakerPotency_79067_PotencyName|人格深化",
    AwakerID = 77922,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      18159,
      0.8
    },
    FrontPotency = 79192,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78984] = {
    ID = 78984,
    CnID = "启灵@克珀珊特人格深化10",
    BaseSortID = 703,
    PotencyName = "AwakerPotency_78984_PotencyName|人格深化",
    AwakerID = 77922,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      18159,
      0.8
    },
    FrontPotency = 79067,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78983] = {
    ID = 78983,
    CnID = "启灵@克珀珊特人格深化11",
    BaseSortID = 704,
    PotencyName = "AwakerPotency_78983_PotencyName|人格深化",
    AwakerID = 77922,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      18159,
      0.8
    },
    FrontPotency = 78984,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78982] = {
    ID = 78982,
    CnID = "启灵@克珀珊特人格深化12",
    BaseSortID = 705,
    PotencyName = "AwakerPotency_78982_PotencyName|不熄、不灭、不烬",
    PotencyDesc = "AwakerPotency_78982_PotencyDesc|灵知觉醒「沉没于远海」获得强化，克珀珊特每回合首张「惩戒雷霆」和「混沌旗语」额外置入 1 张「领航」到手中，「领航」效果提高 50%。",
    AwakerID = 77922,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      18159,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 78983,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [79123] = {
    ID = 79123,
    CnID = "启灵@卡斯托尔1",
    BaseSortID = 706,
    PotencyName = "AwakerPotency_79123_PotencyName|囚于地底之鸟",
    PotencyDesc = "AwakerPotency_79123_PotencyDesc|战斗开始时，将 1 张「黑羽」置入手中。",
    AwakerID = 77923,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [78990] = {
    ID = 78990,
    CnID = "启灵@卡斯托尔2",
    BaseSortID = 707,
    PotencyName = "AwakerPotency_78990_PotencyName|不灭不移之志",
    PotencyDesc = "AwakerPotency_78990_PotencyDesc|手中每有 1 张「黑羽」，「蔽日之羽」打出后获得 5 点狂气。\n每打出 1 张「黑羽」，「穿行永夜」本回合算力消耗降低 1 点。",
    AwakerID = 77923,
    PotencyType = "PassiveSkill",
    FrontPotency = 79123,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79055] = {
    ID = 79055,
    CnID = "启灵@卡斯托尔3",
    BaseSortID = 708,
    PotencyName = "AwakerPotency_79055_PotencyName|遮盖天幕之翼",
    PotencyDesc = "AwakerPotency_79055_PotencyDesc|每打出 3 张「黑羽」，获得 1 点算力并使卡斯托尔本场战斗造成的最终伤害提高 10%。",
    AwakerID = 77923,
    PotencyType = "PassiveSkill",
    FrontPotency = 78990,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [78975] = {
    ID = 78975,
    CnID = "启灵@卡斯托尔人格深化1",
    BaseSortID = 709,
    PotencyName = "AwakerPotency_78975_PotencyName|人格深化",
    AwakerID = 77923,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18105,
      1.2
    },
    FrontPotency = 79055,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78977] = {
    ID = 78977,
    CnID = "启灵@卡斯托尔人格深化2",
    BaseSortID = 710,
    PotencyName = "AwakerPotency_78977_PotencyName|人格深化",
    AwakerID = 77923,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18105,
      1.2
    },
    FrontPotency = 78975,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78976] = {
    ID = 78976,
    CnID = "启灵@卡斯托尔人格深化3",
    BaseSortID = 711,
    PotencyName = "AwakerPotency_78976_PotencyName|人格深化",
    AwakerID = 77923,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18105,
      1.2
    },
    FrontPotency = 78977,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78972] = {
    ID = 78972,
    CnID = "启灵@卡斯托尔人格深化4",
    BaseSortID = 712,
    PotencyName = "AwakerPotency_78972_PotencyName|飞跃荆棘海",
    PotencyDesc = "AwakerPotency_78972_PotencyDesc|额外将 3 张「黑羽」置入手中。本回合黑羽保留的护盾提高卡斯托尔防御力的 10％，每次打出「黑羽」额外对目标施加卡斯托尔攻击力 160％ 的「侵蚀」。",
    AwakerID = 77923,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18105,
      1.2
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 78976,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78971] = {
    ID = 78971,
    CnID = "启灵@卡斯托尔人格深化5",
    BaseSortID = 713,
    PotencyName = "AwakerPotency_78971_PotencyName|人格深化",
    AwakerID = 77923,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18105,
      1.2
    },
    FrontPotency = 78972,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79012] = {
    ID = 79012,
    CnID = "启灵@卡斯托尔人格深化6",
    BaseSortID = 714,
    PotencyName = "AwakerPotency_79012_PotencyName|人格深化",
    AwakerID = 77923,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18105,
      1.2
    },
    FrontPotency = 78971,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79120] = {
    ID = 79120,
    CnID = "启灵@卡斯托尔人格深化7",
    BaseSortID = 715,
    PotencyName = "AwakerPotency_79120_PotencyName|人格深化",
    AwakerID = 77923,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18105,
      1.2
    },
    FrontPotency = 79012,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78968] = {
    ID = 78968,
    CnID = "启灵@卡斯托尔人格深化8",
    BaseSortID = 716,
    PotencyName = "AwakerPotency_78968_PotencyName|人格深化",
    AwakerID = 77923,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18105,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79120,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79101] = {
    ID = 79101,
    CnID = "启灵@卡斯托尔人格深化9",
    BaseSortID = 717,
    PotencyName = "AwakerPotency_79101_PotencyName|人格深化",
    AwakerID = 77923,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18105,
      1.2
    },
    FrontPotency = 78968,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79031] = {
    ID = 79031,
    CnID = "启灵@卡斯托尔人格深化10",
    BaseSortID = 718,
    PotencyName = "AwakerPotency_79031_PotencyName|人格深化",
    AwakerID = 77923,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18105,
      1.2
    },
    FrontPotency = 79101,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79030] = {
    ID = 79030,
    CnID = "启灵@卡斯托尔人格深化11",
    BaseSortID = 719,
    PotencyName = "AwakerPotency_79030_PotencyName|人格深化",
    AwakerID = 77923,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18105,
      1.2
    },
    FrontPotency = 79031,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78949] = {
    ID = 78949,
    CnID = "启灵@卡斯托尔人格深化12",
    BaseSortID = 720,
    PotencyName = "AwakerPotency_78949_PotencyName|涤罪永夜",
    PotencyDesc = "AwakerPotency_78949_PotencyDesc|灵知觉醒「翱翔夙愿」获得强化，卡斯托尔每回合首次打出黑羽时对前排敌人造成等同于天赋「圣羽洗罪」的侵蚀，侵蚀移除时失去的生命由 300% 提高为 500%。",
    AwakerID = 77923,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18105,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79030,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [95800] = {
    ID = 95800,
    CnID = "启灵@杜勒赛因1",
    BaseSortID = 721,
    PotencyName = "AwakerPotency_95800_PotencyName|餐前礼仪",
    PotencyDesc = "AwakerPotency_95800_PotencyDesc|杜勒赛因自身、装备的命轮与密契每提供 1% 暴击伤害，获得 0.1% 暴击率。",
    AwakerID = 95786,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [95788] = {
    ID = 95788,
    CnID = "启灵@杜勒赛因2",
    BaseSortID = 722,
    PotencyName = "AwakerPotency_95788_PotencyName|幽魂絮语",
    PotencyDesc = "AwakerPotency_95788_PotencyDesc|自身每损失 1％ 生命，杜勒赛因指令卡造成的基础伤害、护盾、狂气提高 1％。",
    AwakerID = 95786,
    PotencyType = "PassiveSkill",
    FrontPotency = 95800,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [95792] = {
    ID = 95792,
    CnID = "启灵@杜勒赛因3",
    BaseSortID = 723,
    PotencyName = "AwakerPotency_95792_PotencyName|永夜欢宴",
    PotencyDesc = "AwakerPotency_95792_PotencyDesc|「永夜欢宴」基础伤害提高 300%，打出后会使本回合后续打出的「永夜欢宴」额外享受 100% 力量加成。",
    AwakerID = 95786,
    PotencyType = "PassiveSkill",
    FrontPotency = 95788,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [95797] = {
    ID = 95797,
    CnID = "启灵@杜勒赛因人格深化1",
    BaseSortID = 724,
    PotencyName = "AwakerPotency_95797_PotencyName|人格深化",
    AwakerID = 95786,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 95792,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [95787] = {
    ID = 95787,
    CnID = "启灵@杜勒赛因人格深化2",
    BaseSortID = 725,
    PotencyName = "AwakerPotency_95787_PotencyName|人格深化",
    AwakerID = 95786,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 95797,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [95789] = {
    ID = 95789,
    CnID = "启灵@杜勒赛因人格深化3",
    BaseSortID = 726,
    PotencyName = "AwakerPotency_95789_PotencyName|人格深化",
    AwakerID = 95786,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 95787,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [95791] = {
    ID = 95791,
    CnID = "启灵@杜勒赛因人格深化4",
    BaseSortID = 727,
    PotencyName = "AwakerPotency_95791_PotencyName|万灵的餍飨",
    PotencyDesc = "AwakerPotency_95791_PotencyDesc|本次狂气爆发暴击率+25％，基础伤害提高 50%，最终伤害提高 100％。",
    AwakerID = 95786,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 95789,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [95798] = {
    ID = 95798,
    CnID = "启灵@杜勒赛因人格深化5",
    BaseSortID = 728,
    PotencyName = "AwakerPotency_95798_PotencyName|人格深化",
    AwakerID = 95786,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 95791,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [95801] = {
    ID = 95801,
    CnID = "启灵@杜勒赛因人格深化6",
    BaseSortID = 729,
    PotencyName = "AwakerPotency_95801_PotencyName|人格深化",
    AwakerID = 95786,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 95798,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [95799] = {
    ID = 95799,
    CnID = "启灵@杜勒赛因人格深化7",
    BaseSortID = 730,
    PotencyName = "AwakerPotency_95799_PotencyName|人格深化",
    AwakerID = 95786,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 95801,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [95793] = {
    ID = 95793,
    CnID = "启灵@杜勒赛因人格深化8",
    BaseSortID = 731,
    PotencyName = "AwakerPotency_95793_PotencyName|人格深化",
    AwakerID = 95786,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 95799,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [95794] = {
    ID = 95794,
    CnID = "启灵@杜勒赛因人格深化9",
    BaseSortID = 732,
    PotencyName = "AwakerPotency_95794_PotencyName|人格深化",
    AwakerID = 95786,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 95793,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [95790] = {
    ID = 95790,
    CnID = "启灵@杜勒赛因人格深化10",
    BaseSortID = 733,
    PotencyName = "AwakerPotency_95790_PotencyName|人格深化",
    AwakerID = 95786,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 95794,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [95795] = {
    ID = 95795,
    CnID = "启灵@杜勒赛因人格深化11",
    BaseSortID = 734,
    PotencyName = "AwakerPotency_95795_PotencyName|人格深化",
    AwakerID = 95786,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 95790,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [95796] = {
    ID = 95796,
    CnID = "启灵@杜勒赛因人格深化12",
    BaseSortID = 735,
    PotencyName = "AwakerPotency_95796_PotencyName|冥河无渡",
    PotencyDesc = "AwakerPotency_95796_PotencyDesc|灵知觉醒「王邸的请柬」获得强化，打出时立即对所有敌人造成当前生命 20% 的纯粹伤害。杜勒赛因每回合首次造成击杀后，对其他敌人造成的纯粹伤害提高为 100% 溢出伤害。",
    AwakerID = 95786,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18105,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 95795,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [78970] = {
    ID = 78970,
    CnID = "启灵@凯蒂古拉1",
    BaseSortID = 736,
    PotencyName = "AwakerPotency_78970_PotencyName|不熄之焰",
    PotencyDesc = "AwakerPotency_78970_PotencyDesc|「打击」和「防御」造成的基础伤害、护盾、狂气提高 50%。",
    AwakerID = 77913,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [79157] = {
    ID = 79157,
    CnID = "启灵@凯蒂古拉2",
    BaseSortID = 737,
    PotencyName = "AwakerPotency_79157_PotencyName|千星熔解",
    PotencyDesc = "AwakerPotency_79157_PotencyDesc|「千兆耀斑」具有 3 层「活焰」时，基础伤害提高 50%。「末路枪声」具有 3 层「活焰」时，获得的力量提高凯蒂古拉攻击力的 3％。",
    AwakerID = 77913,
    PotencyType = "PassiveSkill",
    FrontPotency = 78970,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79089] = {
    ID = 79089,
    CnID = "启灵@凯蒂古拉3",
    BaseSortID = 738,
    PotencyName = "AwakerPotency_79089_PotencyName|无尽炼狱",
    PotencyDesc = "AwakerPotency_79089_PotencyDesc|战斗开始时赋予凯蒂古拉所有原始指令卡 1 层「活焰」。每获得 1 层「爆炎」凯蒂古拉本场战斗基础伤害提高 5%。",
    AwakerID = 77913,
    PotencyType = "PassiveSkill",
    FrontPotency = 79157,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [79185] = {
    ID = 79185,
    CnID = "启灵@凯蒂古拉人格深化1",
    BaseSortID = 739,
    PotencyName = "AwakerPotency_79185_PotencyName|人格深化",
    AwakerID = 77913,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 79089,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79184] = {
    ID = 79184,
    CnID = "启灵@凯蒂古拉人格深化2",
    BaseSortID = 740,
    PotencyName = "AwakerPotency_79184_PotencyName|人格深化",
    AwakerID = 77913,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 79185,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79183] = {
    ID = 79183,
    CnID = "启灵@凯蒂古拉人格深化3",
    BaseSortID = 741,
    PotencyName = "AwakerPotency_79183_PotencyName|人格深化",
    AwakerID = 77913,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 79184,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79189] = {
    ID = 79189,
    CnID = "启灵@凯蒂古拉人格深化4",
    BaseSortID = 742,
    PotencyName = "AwakerPotency_79189_PotencyName|融于万物的真理",
    PotencyDesc = "AwakerPotency_79189_PotencyDesc|额外造成 2 次伤害，改为随机为手中凯蒂古拉的指令卡分配 5 层「活焰」。",
    AwakerID = 77913,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 79183,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79188] = {
    ID = 79188,
    CnID = "启灵@凯蒂古拉人格深化5",
    BaseSortID = 743,
    PotencyName = "AwakerPotency_79188_PotencyName|人格深化",
    AwakerID = 77913,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 79189,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79187] = {
    ID = 79187,
    CnID = "启灵@凯蒂古拉人格深化6",
    BaseSortID = 744,
    PotencyName = "AwakerPotency_79187_PotencyName|人格深化",
    AwakerID = 77913,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 79188,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79186] = {
    ID = 79186,
    CnID = "启灵@凯蒂古拉人格深化7",
    BaseSortID = 745,
    PotencyName = "AwakerPotency_79186_PotencyName|人格深化",
    AwakerID = 77913,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 79187,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79191] = {
    ID = 79191,
    CnID = "启灵@凯蒂古拉人格深化8",
    BaseSortID = 746,
    PotencyName = "AwakerPotency_79191_PotencyName|人格深化",
    AwakerID = 77913,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79186,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79190] = {
    ID = 79190,
    CnID = "启灵@凯蒂古拉人格深化9",
    BaseSortID = 747,
    PotencyName = "AwakerPotency_79190_PotencyName|人格深化",
    AwakerID = 77913,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 79191,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79119] = {
    ID = 79119,
    CnID = "启灵@凯蒂古拉人格深化10",
    BaseSortID = 748,
    PotencyName = "AwakerPotency_79119_PotencyName|人格深化",
    AwakerID = 77913,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 79190,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79091] = {
    ID = 79091,
    CnID = "启灵@凯蒂古拉人格深化11",
    BaseSortID = 749,
    PotencyName = "AwakerPotency_79091_PotencyName|人格深化",
    AwakerID = 77913,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    FrontPotency = 79119,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79090] = {
    ID = 79090,
    CnID = "启灵@凯蒂古拉人格深化12",
    BaseSortID = 750,
    PotencyName = "AwakerPotency_79090_PotencyName|烬灭终局",
    PotencyDesc = "AwakerPotency_79090_PotencyDesc|灵知觉醒「业火重燃」获得强化，凯蒂古拉每层「活焰」的最终伤害和力量效果 +30%。",
    AwakerID = 77913,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18159,
      0.8,
      18105,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79091,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [79150] = {
    ID = 79150,
    CnID = "启灵@皮克曼1",
    BaseSortID = 751,
    PotencyName = "AwakerPotency_79150_PotencyName|交叉画法",
    PotencyDesc = "AwakerPotency_79150_PotencyDesc|「打击」或「防御」抽 1 张出战唤醒体的「技能」，每回合最多生效 1 次。",
    AwakerID = 77926,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [79147] = {
    ID = 79147,
    CnID = "启灵@皮克曼2",
    BaseSortID = 752,
    PotencyName = "AwakerPotency_79147_PotencyName|中心刻绘",
    PotencyDesc = "AwakerPotency_79147_PotencyDesc|创构的「刻印」升级为「高级刻印」，创构的「白银造物」升级为「黄金造物」。",
    AwakerID = 77926,
    PotencyType = "PassiveSkill",
    FrontPotency = 79150,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79148] = {
    ID = 79148,
    CnID = "启灵@皮克曼3",
    BaseSortID = 753,
    PotencyName = "AwakerPotency_79148_PotencyName|缪斯的呼唤",
    PotencyDesc = "AwakerPotency_79148_PotencyDesc|皮克曼消耗「创意」后自身额外获得 50 点狂气，本回合皮克曼能够释放 2 次狂气爆发。",
    AwakerID = 77926,
    PotencyType = "PassiveSkill",
    FrontPotency = 79147,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [79034] = {
    ID = 79034,
    CnID = "启灵@皮克曼人格深化1",
    BaseSortID = 754,
    PotencyName = "AwakerPotency_79034_PotencyName|人格深化",
    AwakerID = 77926,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      22207,
      0.8
    },
    FrontPotency = 79148,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79176] = {
    ID = 79176,
    CnID = "启灵@皮克曼人格深化2",
    BaseSortID = 755,
    PotencyName = "AwakerPotency_79176_PotencyName|人格深化",
    AwakerID = 77926,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      22207,
      0.8
    },
    FrontPotency = 79034,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79175] = {
    ID = 79175,
    CnID = "启灵@皮克曼人格深化3",
    BaseSortID = 756,
    PotencyName = "AwakerPotency_79175_PotencyName|人格深化",
    AwakerID = 77926,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      22207,
      0.8
    },
    FrontPotency = 79176,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79182] = {
    ID = 79182,
    CnID = "启灵@皮克曼人格深化4",
    BaseSortID = 757,
    PotencyName = "AwakerPotency_79182_PotencyName|艺术，即为疯狂",
    PotencyDesc = "AwakerPotency_79182_PotencyDesc|获得 1 层「狂想」并额外「发现」1 次。",
    AwakerID = 77926,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      22207,
      0.8
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 79175,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79181] = {
    ID = 79181,
    CnID = "启灵@皮克曼人格深化5",
    BaseSortID = 758,
    PotencyName = "AwakerPotency_79181_PotencyName|人格深化",
    AwakerID = 77926,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      22207,
      0.8
    },
    FrontPotency = 79182,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79180] = {
    ID = 79180,
    CnID = "启灵@皮克曼人格深化6",
    BaseSortID = 759,
    PotencyName = "AwakerPotency_79180_PotencyName|人格深化",
    AwakerID = 77926,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      22207,
      0.8
    },
    FrontPotency = 79181,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79179] = {
    ID = 79179,
    CnID = "启灵@皮克曼人格深化7",
    BaseSortID = 760,
    PotencyName = "AwakerPotency_79179_PotencyName|人格深化",
    AwakerID = 77926,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      22207,
      0.8
    },
    FrontPotency = 79180,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79020] = {
    ID = 79020,
    CnID = "启灵@皮克曼人格深化8",
    BaseSortID = 761,
    PotencyName = "AwakerPotency_79020_PotencyName|人格深化",
    AwakerID = 77926,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      22207,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79179,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79169] = {
    ID = 79169,
    CnID = "启灵@皮克曼人格深化9",
    BaseSortID = 762,
    PotencyName = "AwakerPotency_79169_PotencyName|人格深化",
    AwakerID = 77926,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      22207,
      0.8
    },
    FrontPotency = 79020,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79166] = {
    ID = 79166,
    CnID = "启灵@皮克曼人格深化10",
    BaseSortID = 763,
    PotencyName = "AwakerPotency_79166_PotencyName|人格深化",
    AwakerID = 77926,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      22207,
      0.8
    },
    FrontPotency = 79169,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79165] = {
    ID = 79165,
    CnID = "启灵@皮克曼人格深化11",
    BaseSortID = 764,
    PotencyName = "AwakerPotency_79165_PotencyName|人格深化",
    AwakerID = 77926,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      22207,
      0.8
    },
    FrontPotency = 79166,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79164] = {
    ID = 79164,
    CnID = "启灵@皮克曼人格深化12",
    BaseSortID = 765,
    PotencyName = "AwakerPotency_79164_PotencyName|画中世界",
    PotencyDesc = "AwakerPotency_79164_PotencyDesc|灵知觉醒「墓园画室」获得强化，「绘影摹形」创构的黄金造物持续回合数由 1 回合提高为 2 回合。",
    AwakerID = 77926,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      22207,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79165,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [79153] = {
    ID = 79153,
    CnID = "启灵@波吕克斯1",
    BaseSortID = 766,
    PotencyName = "AwakerPotency_79153_PotencyName|持灯神使",
    PotencyDesc = "AwakerPotency_79153_PotencyDesc|战斗开始时，将 1 张「圣心」置入手中。",
    AwakerID = 77917,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [79152] = {
    ID = 79152,
    CnID = "启灵@波吕克斯2",
    BaseSortID = 767,
    PotencyName = "AwakerPotency_79152_PotencyName|救世光焰",
    PotencyDesc = "AwakerPotency_79152_PotencyDesc|每有 1 张手牌，「打击」与「防御」额外获得 1 点狂气。\n每打出 1 张「圣心」，下次打出的「离垢的审判」算力消耗降低 1 点。",
    AwakerID = 77917,
    PotencyType = "PassiveSkill",
    FrontPotency = 79153,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79151] = {
    ID = 79151,
    CnID = "启灵@波吕克斯3",
    BaseSortID = 768,
    PotencyName = "AwakerPotency_79151_PotencyName|神启新约",
    PotencyDesc = "AwakerPotency_79151_PotencyDesc|「圣心」因第 3 次打出消耗时，使自身下一张指令卡额外生效 1 次。",
    AwakerID = 77917,
    PotencyType = "PassiveSkill",
    FrontPotency = 79152,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [79170] = {
    ID = 79170,
    CnID = "启灵@波吕克斯人格深化1",
    BaseSortID = 769,
    PotencyName = "AwakerPotency_79170_PotencyName|人格深化",
    AwakerID = 77917,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18159,
      1.6
    },
    FrontPotency = 79151,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79167] = {
    ID = 79167,
    CnID = "启灵@波吕克斯人格深化2",
    BaseSortID = 770,
    PotencyName = "AwakerPotency_79167_PotencyName|人格深化",
    AwakerID = 77917,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18159,
      1.6
    },
    FrontPotency = 79170,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79168] = {
    ID = 79168,
    CnID = "启灵@波吕克斯人格深化3",
    BaseSortID = 771,
    PotencyName = "AwakerPotency_79168_PotencyName|人格深化",
    AwakerID = 77917,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18159,
      1.6
    },
    FrontPotency = 79167,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79173] = {
    ID = 79173,
    CnID = "启灵@波吕克斯人格深化4",
    BaseSortID = 772,
    PotencyName = "AwakerPotency_79173_PotencyName|照彻白夜之光",
    PotencyDesc = "AwakerPotency_79173_PotencyDesc|本回合内波吕克斯每张指令卡额外享受 50% 「苦痛救赎」效果，额外将 1 张「圣心」置入手中。自身下一张指令卡额外生效 1 次。",
    AwakerID = 77917,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18159,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 79168,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79174] = {
    ID = 79174,
    CnID = "启灵@波吕克斯人格深化5",
    BaseSortID = 773,
    PotencyName = "AwakerPotency_79174_PotencyName|人格深化",
    AwakerID = 77917,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18159,
      1.6
    },
    FrontPotency = 79173,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79171] = {
    ID = 79171,
    CnID = "启灵@波吕克斯人格深化6",
    BaseSortID = 774,
    PotencyName = "AwakerPotency_79171_PotencyName|人格深化",
    AwakerID = 77917,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18159,
      1.6
    },
    FrontPotency = 79174,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79172] = {
    ID = 79172,
    CnID = "启灵@波吕克斯人格深化7",
    BaseSortID = 775,
    PotencyName = "AwakerPotency_79172_PotencyName|人格深化",
    AwakerID = 77917,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18159,
      1.6
    },
    FrontPotency = 79171,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79177] = {
    ID = 79177,
    CnID = "启灵@波吕克斯人格深化8",
    BaseSortID = 776,
    PotencyName = "AwakerPotency_79177_PotencyName|人格深化",
    AwakerID = 77917,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79172,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79178] = {
    ID = 79178,
    CnID = "启灵@波吕克斯人格深化9",
    BaseSortID = 777,
    PotencyName = "AwakerPotency_79178_PotencyName|人格深化",
    AwakerID = 77917,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18159,
      1.6
    },
    FrontPotency = 79177,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79084] = {
    ID = 79084,
    CnID = "启灵@波吕克斯人格深化10",
    BaseSortID = 778,
    PotencyName = "AwakerPotency_79084_PotencyName|人格深化",
    AwakerID = 77917,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18159,
      1.6
    },
    FrontPotency = 79178,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79085] = {
    ID = 79085,
    CnID = "启灵@波吕克斯人格深化11",
    BaseSortID = 779,
    PotencyName = "AwakerPotency_79085_PotencyName|人格深化",
    AwakerID = 77917,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18159,
      1.6
    },
    FrontPotency = 79084,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79086] = {
    ID = 79086,
    CnID = "启灵@波吕克斯人格深化12",
    BaseSortID = 780,
    PotencyName = "AwakerPotency_79086_PotencyName|圣心长明",
    PotencyDesc = "AwakerPotency_79086_PotencyDesc|灵知觉醒「净世之路」获得强化，「圣心」因打出而洗入抽牌堆后，该「圣心」本回合算力消耗变为 0 且额外造成 100％ 伤害的出血。",
    AwakerID = 77917,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      0.8,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79085,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [13706] = {
    ID = 13706,
    CnID = "启灵@本源深海淑女1",
    BaseSortID = 781,
    PotencyName = "AwakerPotency_13706_PotencyName|屈膝者的哀祷",
    PotencyDesc = "AwakerPotency_13706_PotencyDesc|「螺湮圆舞」触腕伤害、护盾、最终伤害提高 10%，每拥有 1 点银钥充能等级额外提高 0.2%。",
    AwakerID = 15589,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [13703] = {
    ID = 13703,
    CnID = "启灵@本源深海淑女2",
    BaseSortID = 782,
    PotencyName = "AwakerPotency_13703_PotencyName|倒悬之孕",
    PotencyDesc = "AwakerPotency_13703_PotencyDesc|每拥有 1 条触腕「诞妄·墨菲」暴击率 +3%，每拥有 1% 最大生命的「献祭」或「延迟献祭」，「诞妄·墨菲」暴击伤害 +3%。",
    AwakerID = 15589,
    PotencyType = "PassiveSkill",
    FrontPotency = 13706,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [13704] = {
    ID = 13704,
    CnID = "启灵@本源深海淑女3",
    BaseSortID = 783,
    PotencyName = "AwakerPotency_13704_PotencyName|渎神终末",
    PotencyDesc = "AwakerPotency_13704_PotencyDesc|「打击」或「防御」抽 1 张「深海圣咏」，每回合最多生效 1 次。",
    AwakerID = 15589,
    PotencyType = "PassiveSkill",
    FrontPotency = 13703,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [13463] = {
    ID = 13463,
    CnID = "启灵@本源深海淑女人格深化1",
    BaseSortID = 784,
    PotencyName = "AwakerPotency_13463_PotencyName|人格深化",
    AwakerID = 15589,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18105,
      1.2
    },
    FrontPotency = 13704,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13462] = {
    ID = 13462,
    CnID = "启灵@本源深海淑女人格深化2",
    BaseSortID = 785,
    PotencyName = "AwakerPotency_13462_PotencyName|人格深化",
    AwakerID = 15589,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18105,
      1.2
    },
    FrontPotency = 13463,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13461] = {
    ID = 13461,
    CnID = "启灵@本源深海淑女人格深化3",
    BaseSortID = 786,
    PotencyName = "AwakerPotency_13461_PotencyName|人格深化",
    AwakerID = 15589,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18105,
      1.2
    },
    FrontPotency = 13462,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13460] = {
    ID = 13460,
    CnID = "启灵@本源深海淑女人格深化4",
    BaseSortID = 787,
    PotencyName = "AwakerPotency_13460_PotencyName|万劫轮回的天幕",
    PotencyDesc = "AwakerPotency_13460_PotencyDesc|施加的「降生仪式」提高 5 层。生成 3 张算力消耗为 2 且附加「预备」和「消耗」的「螺湮圆舞」。",
    AwakerID = 15589,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18105,
      1.2
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 13461,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13459] = {
    ID = 13459,
    CnID = "启灵@本源深海淑女人格深化5",
    BaseSortID = 788,
    PotencyName = "AwakerPotency_13459_PotencyName|人格深化",
    AwakerID = 15589,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18105,
      1.2
    },
    FrontPotency = 13460,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13458] = {
    ID = 13458,
    CnID = "启灵@本源深海淑女人格深化6",
    BaseSortID = 789,
    PotencyName = "AwakerPotency_13458_PotencyName|人格深化",
    AwakerID = 15589,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18105,
      1.2
    },
    FrontPotency = 13459,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13457] = {
    ID = 13457,
    CnID = "启灵@本源深海淑女人格深化7",
    BaseSortID = 790,
    PotencyName = "AwakerPotency_13457_PotencyName|人格深化",
    AwakerID = 15589,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18105,
      1.2
    },
    FrontPotency = 13458,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13456] = {
    ID = 13456,
    CnID = "启灵@本源深海淑女人格深化8",
    BaseSortID = 791,
    PotencyName = "AwakerPotency_13456_PotencyName|人格深化",
    AwakerID = 15589,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18105,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13457,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13455] = {
    ID = 13455,
    CnID = "启灵@本源深海淑女人格深化9",
    BaseSortID = 792,
    PotencyName = "AwakerPotency_13455_PotencyName|人格深化",
    AwakerID = 15589,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18105,
      1.2
    },
    FrontPotency = 13456,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13302] = {
    ID = 13302,
    CnID = "启灵@本源深海淑女人格深化10",
    BaseSortID = 793,
    PotencyName = "AwakerPotency_13302_PotencyName|人格深化",
    AwakerID = 15589,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18105,
      1.2
    },
    FrontPotency = 13455,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13301] = {
    ID = 13301,
    CnID = "启灵@本源深海淑女人格深化11",
    BaseSortID = 794,
    PotencyName = "AwakerPotency_13301_PotencyName|人格深化",
    AwakerID = 15589,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18105,
      1.2
    },
    FrontPotency = 13302,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [13300] = {
    ID = 13300,
    CnID = "启灵@本源深海淑女人格深化12",
    BaseSortID = 795,
    PotencyName = "AwakerPotency_13300_PotencyName|天人感应",
    PotencyDesc = "AwakerPotency_13300_PotencyDesc|灵知觉醒「海祭典仪」获得强化，打出时立即获得 2 层「命契」。若回合结束时处于「潮涌」姿态，额外获得 1 层「命契」。",
    AwakerID = 15589,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18139,
      2.4,
      18105,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 13301,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [122466] = {
    ID = 122466,
    CnID = "启灵@茉夏1",
    BaseSortID = 796,
    PotencyName = "AwakerPotency_122466_PotencyName|雾境旅人",
    PotencyDesc = "AwakerPotency_122466_PotencyDesc|茉夏自身、命轮、密契每拥有 1％ 死亡抵抗就提高 0.15% 暴击率与暴击伤害，每次触发死亡抵抗「雾境旅人」提供的暴击伤害本场战斗提高一倍。",
    AwakerID = 94450,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [122471] = {
    ID = 122471,
    CnID = "启灵@茉夏2",
    BaseSortID = 797,
    PotencyName = "AwakerPotency_122471_PotencyName|回不去的往昔",
    PotencyDesc = "AwakerPotency_122471_PotencyDesc|「人间爆破」生成 1 张上一次打出的其他「打击」的临时复制并使其算力消耗 -1。",
    AwakerID = 94450,
    PotencyType = "PassiveSkill",
    FrontPotency = 122466,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [122474] = {
    ID = 122474,
    CnID = "启灵@茉夏3",
    BaseSortID = 798,
    PotencyName = "AwakerPotency_122474_PotencyName|劈出一个未来",
    PotencyDesc = "AwakerPotency_122474_PotencyDesc|「闪耀☆龙卷风」使本回合茉夏伤害次数 +1。",
    AwakerID = 94450,
    PotencyType = "PassiveSkill",
    FrontPotency = 122471,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [122478] = {
    ID = 122478,
    CnID = "启灵@茉夏人格深化1",
    BaseSortID = 799,
    PotencyName = "AwakerPotency_122478_PotencyName|人格深化",
    AwakerID = 94450,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      22207,
      0.4
    },
    FrontPotency = 122474,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [122465] = {
    ID = 122465,
    CnID = "启灵@茉夏人格深化2",
    BaseSortID = 800,
    PotencyName = "AwakerPotency_122465_PotencyName|人格深化",
    AwakerID = 94450,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      22207,
      0.4
    },
    FrontPotency = 122478,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [122472] = {
    ID = 122472,
    CnID = "启灵@茉夏人格深化3",
    BaseSortID = 801,
    PotencyName = "AwakerPotency_122472_PotencyName|人格深化",
    AwakerID = 94450,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      22207,
      0.4
    },
    FrontPotency = 122465,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [122475] = {
    ID = 122475,
    CnID = "启灵@茉夏人格深化4",
    BaseSortID = 802,
    PotencyName = "AwakerPotency_122475_PotencyName|龙卷风世界大崩毁☆！",
    PotencyDesc = "AwakerPotency_122475_PotencyDesc|伤害次数 +1，本场战斗每触发 1 次「死亡抵抗」额外 +1。使打出的下一张「风暴冲击」基础算力消耗变为 0。若为本场战斗首次释放，额外「昏迷」全体敌方。",
    AwakerID = 94450,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      22207,
      0.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 122472,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [122477] = {
    ID = 122477,
    CnID = "启灵@茉夏人格深化5",
    BaseSortID = 803,
    PotencyName = "AwakerPotency_122477_PotencyName|人格深化",
    AwakerID = 94450,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      22207,
      0.4
    },
    FrontPotency = 122475,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [122468] = {
    ID = 122468,
    CnID = "启灵@茉夏人格深化6",
    BaseSortID = 804,
    PotencyName = "AwakerPotency_122468_PotencyName|人格深化",
    AwakerID = 94450,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      22207,
      0.4
    },
    FrontPotency = 122477,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [122469] = {
    ID = 122469,
    CnID = "启灵@茉夏人格深化7",
    BaseSortID = 805,
    PotencyName = "AwakerPotency_122469_PotencyName|人格深化",
    AwakerID = 94450,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      22207,
      0.4
    },
    FrontPotency = 122468,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [122467] = {
    ID = 122467,
    CnID = "启灵@茉夏人格深化8",
    BaseSortID = 806,
    PotencyName = "AwakerPotency_122467_PotencyName|人格深化",
    AwakerID = 94450,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      22207,
      0.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 122469,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [122473] = {
    ID = 122473,
    CnID = "启灵@茉夏人格深化9",
    BaseSortID = 807,
    PotencyName = "AwakerPotency_122473_PotencyName|人格深化",
    AwakerID = 94450,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      22207,
      0.4
    },
    FrontPotency = 122467,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [122470] = {
    ID = 122470,
    CnID = "启灵@茉夏人格深化10",
    BaseSortID = 808,
    PotencyName = "AwakerPotency_122470_PotencyName|人格深化",
    AwakerID = 94450,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      22207,
      0.4
    },
    FrontPotency = 122473,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [122476] = {
    ID = 122476,
    CnID = "启灵@茉夏人格深化11",
    BaseSortID = 809,
    PotencyName = "AwakerPotency_122476_PotencyName|人格深化",
    AwakerID = 94450,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      22207,
      0.4
    },
    FrontPotency = 122470,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [122479] = {
    ID = 122479,
    CnID = "启灵@茉夏人格深化12",
    BaseSortID = 810,
    PotencyName = "AwakerPotency_122479_PotencyName|穿透迷雾的自我",
    PotencyDesc = "AwakerPotency_122479_PotencyDesc|灵知觉醒「雾境遗脉」获得强化，打出时额外生成 1 张临时「人间爆破」并使这 2 张「人间爆破」的算力消耗变为 0。茉夏的天赋「戏剧性邂逅」每回合触发次数上限提高为 5。",
    AwakerID = 94450,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      5.6,
      22207,
      0.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 122476,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [125356] = {
    ID = 125356,
    CnID = "启灵@徐1",
    BaseSortID = 811,
    PotencyName = "AwakerPotency_125356_PotencyName|情冤",
    PotencyDesc = "AwakerPotency_125356_PotencyDesc|「入骨相思」胚胎融合 +15。徐自身、命轮、密契每拥有 1% 伤害强效，「入骨相思」获得的胚胎融合 +0.2。",
    AwakerID = 125346,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [125361] = {
    ID = 125361,
    CnID = "启灵@徐2",
    BaseSortID = 812,
    PotencyName = "AwakerPotency_125361_PotencyName|扇与镰刀",
    PotencyDesc = "AwakerPotency_125361_PotencyDesc|「打击」和「防御」获得共振 3：额外获得 15 点狂气。",
    AwakerID = 125346,
    PotencyType = "PassiveSkill",
    FrontPotency = 125356,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [125359] = {
    ID = 125359,
    CnID = "启灵@徐3",
    BaseSortID = 813,
    PotencyName = "AwakerPotency_125359_PotencyName|极乐之吻",
    PotencyDesc = "AwakerPotency_125359_PotencyDesc|「痴醉」上限由 5 提高为 10。「夜雾下的情誓」使自身下次触发的「共振」效果翻倍。",
    AwakerID = 125346,
    PotencyType = "PassiveSkill",
    FrontPotency = 125361,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [125358] = {
    ID = 125358,
    CnID = "启灵@徐人格深化1",
    BaseSortID = 814,
    PotencyName = "AwakerPotency_125358_PotencyName|人格深化",
    AwakerID = 125346,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18151,
      2.8
    },
    FrontPotency = 125359,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [125351] = {
    ID = 125351,
    CnID = "启灵@徐人格深化2",
    BaseSortID = 815,
    PotencyName = "AwakerPotency_125351_PotencyName|人格深化",
    AwakerID = 125346,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18151,
      2.8
    },
    FrontPotency = 125358,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [125347] = {
    ID = 125347,
    CnID = "启灵@徐人格深化3",
    BaseSortID = 816,
    PotencyName = "AwakerPotency_125347_PotencyName|人格深化",
    AwakerID = 125346,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18151,
      2.8
    },
    FrontPotency = 125351,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [125360] = {
    ID = 125360,
    CnID = "启灵@徐人格深化4",
    BaseSortID = 817,
    PotencyName = "AwakerPotency_125360_PotencyName|孽海葬情",
    PotencyDesc = "AwakerPotency_125360_PotencyDesc|胚胎融合 +100。选择「相许」时施加的「中毒」和「痴醉」变为 3 倍，选择「夺魄」时每移除 1 层积攒 20％ 体质的猩红熔炉。",
    AwakerID = 125346,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18151,
      2.8
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 125347,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [125352] = {
    ID = 125352,
    CnID = "启灵@徐人格深化5",
    BaseSortID = 818,
    PotencyName = "AwakerPotency_125352_PotencyName|人格深化",
    AwakerID = 125346,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18151,
      2.8
    },
    FrontPotency = 125360,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [125348] = {
    ID = 125348,
    CnID = "启灵@徐人格深化6",
    BaseSortID = 819,
    PotencyName = "AwakerPotency_125348_PotencyName|人格深化",
    AwakerID = 125346,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18151,
      2.8
    },
    FrontPotency = 125352,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [125354] = {
    ID = 125354,
    CnID = "启灵@徐人格深化7",
    BaseSortID = 820,
    PotencyName = "AwakerPotency_125354_PotencyName|人格深化",
    AwakerID = 125346,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18151,
      2.8
    },
    FrontPotency = 125348,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [125357] = {
    ID = 125357,
    CnID = "启灵@徐人格深化8",
    BaseSortID = 821,
    PotencyName = "AwakerPotency_125357_PotencyName|人格深化",
    AwakerID = 125346,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18151,
      2.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 125354,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [125355] = {
    ID = 125355,
    CnID = "启灵@徐人格深化9",
    BaseSortID = 822,
    PotencyName = "AwakerPotency_125355_PotencyName|人格深化",
    AwakerID = 125346,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18151,
      2.8
    },
    FrontPotency = 125357,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [125350] = {
    ID = 125350,
    CnID = "启灵@徐人格深化10",
    BaseSortID = 823,
    PotencyName = "AwakerPotency_125350_PotencyName|人格深化",
    AwakerID = 125346,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18151,
      2.8
    },
    FrontPotency = 125355,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [125353] = {
    ID = 125353,
    CnID = "启灵@徐人格深化11",
    BaseSortID = 824,
    PotencyName = "AwakerPotency_125353_PotencyName|人格深化",
    AwakerID = 125346,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18151,
      2.8
    },
    FrontPotency = 125350,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [125349] = {
    ID = 125349,
    CnID = "启灵@徐人格深化12",
    BaseSortID = 825,
    PotencyName = "AwakerPotency_125349_PotencyName|姑妄言",
    PotencyDesc = "AwakerPotency_125349_PotencyDesc|灵知觉醒「不梦乡之主」获得强化，「痴醉」上限提高为 15，徐每回合首次打出的指令卡额外生效 1 次。",
    AwakerID = 125346,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18142,
      1.6,
      18151,
      2.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 125353,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [131875] = {
    ID = 131875,
    CnID = "启灵@沙耶1",
    BaseSortID = 826,
    PotencyName = "AwakerPotency_131875_PotencyName|为你变成怪物就好",
    PotencyDesc = "AwakerPotency_131875_PotencyDesc|沙耶狂气爆发基础护盾提高 5% ，「肉脂烂漫」造成的基础侵蚀提高 10%。沙耶自身、装备的命轮与密契每提供 1% 黑印掉落属性，沙耶狂气爆发基础护盾提高 0.25%，「肉脂烂漫」造成的基础侵蚀额外提高 0.5%。",
    AwakerID = 130226,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [131868] = {
    ID = 131868,
    CnID = "启灵@沙耶2",
    BaseSortID = 827,
    PotencyName = "AwakerPotency_131868_PotencyName|你会一直陪着我吗",
    PotencyDesc = "AwakerPotency_131868_PotencyDesc|沙耶的「基础打击」、「基础防御」额外使胚胎融合 +15，当前生命越低则效果越高，至多提高 100%。",
    AwakerID = 130226,
    PotencyType = "PassiveSkill",
    FrontPotency = 131875,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [131870] = {
    ID = 131870,
    CnID = "启灵@沙耶3",
    BaseSortID = 828,
    PotencyName = "AwakerPotency_131870_PotencyName|这就是所谓的爱吧",
    PotencyDesc = "AwakerPotency_131870_PotencyDesc|「肉脂烂漫」额外造成目标最大生命值 0.5% 的侵蚀。「沙耶之歌」每消耗 1 层「羽种」，下一次打出「肉脂烂漫」就额外抽 1 张牌。",
    AwakerID = 130226,
    PotencyType = "PassiveSkill",
    FrontPotency = 131868,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [131865] = {
    ID = 131865,
    CnID = "启灵@沙耶人格深化1",
    BaseSortID = 829,
    PotencyName = "AwakerPotency_131865_PotencyName|人格深化",
    AwakerID = 130226,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      1.2,
      18126,
      2
    },
    FrontPotency = 131870,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [131867] = {
    ID = 131867,
    CnID = "启灵@沙耶人格深化2",
    BaseSortID = 830,
    PotencyName = "AwakerPotency_131867_PotencyName|人格深化",
    AwakerID = 130226,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      1.2,
      18126,
      2
    },
    FrontPotency = 131865,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [131871] = {
    ID = 131871,
    CnID = "启灵@沙耶人格深化3",
    BaseSortID = 831,
    PotencyName = "AwakerPotency_131871_PotencyName|人格深化",
    AwakerID = 130226,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      1.2,
      18126,
      2
    },
    FrontPotency = 131867,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [131866] = {
    ID = 131866,
    CnID = "启灵@沙耶人格深化4",
    BaseSortID = 832,
    PotencyName = "AwakerPotency_131866_PotencyName|独属于你的乐园",
    PotencyDesc = "AwakerPotency_131866_PotencyDesc|使复制的所有「技能」额外生效 1 次。",
    AwakerID = 130226,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      1.2,
      18126,
      2
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 131871,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [131861] = {
    ID = 131861,
    CnID = "启灵@沙耶人格深化5",
    BaseSortID = 833,
    PotencyName = "AwakerPotency_131861_PotencyName|人格深化",
    AwakerID = 130226,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      1.2,
      18126,
      2
    },
    FrontPotency = 131866,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [131869] = {
    ID = 131869,
    CnID = "启灵@沙耶人格深化6",
    BaseSortID = 834,
    PotencyName = "AwakerPotency_131869_PotencyName|人格深化",
    AwakerID = 130226,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      1.2,
      18126,
      2
    },
    FrontPotency = 131861,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [131874] = {
    ID = 131874,
    CnID = "启灵@沙耶人格深化7",
    BaseSortID = 835,
    PotencyName = "AwakerPotency_131874_PotencyName|人格深化",
    AwakerID = 130226,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      1.2,
      18126,
      2
    },
    FrontPotency = 131869,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [131862] = {
    ID = 131862,
    CnID = "启灵@沙耶人格深化8",
    BaseSortID = 836,
    PotencyName = "AwakerPotency_131862_PotencyName|人格深化",
    AwakerID = 130226,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      1.2,
      18126,
      2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 131874,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [131873] = {
    ID = 131873,
    CnID = "启灵@沙耶人格深化9",
    BaseSortID = 837,
    PotencyName = "AwakerPotency_131873_PotencyName|人格深化",
    AwakerID = 130226,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      1.2,
      18126,
      2
    },
    FrontPotency = 131862,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [131864] = {
    ID = 131864,
    CnID = "启灵@沙耶人格深化10",
    BaseSortID = 838,
    PotencyName = "AwakerPotency_131864_PotencyName|人格深化",
    AwakerID = 130226,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      1.2,
      18126,
      2
    },
    FrontPotency = 131873,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [131863] = {
    ID = 131863,
    CnID = "启灵@沙耶人格深化11",
    BaseSortID = 839,
    PotencyName = "AwakerPotency_131863_PotencyName|人格深化",
    AwakerID = 130226,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      1.2,
      18126,
      2
    },
    FrontPotency = 131864,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [131872] = {
    ID = 131872,
    CnID = "启灵@沙耶人格深化12",
    BaseSortID = 840,
    PotencyName = "AwakerPotency_131872_PotencyName|最后送给你的礼物",
    PotencyDesc = "AwakerPotency_131872_PotencyDesc|灵知觉醒「认知改造」获得强化，使用「猩红熔炉」后沙耶获得 50 狂气和 1 层「羽种」。",
    AwakerID = 130226,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18155,
      1.2,
      18126,
      2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 131863,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [130904] = {
    ID = 130904,
    CnID = "启灵@莫丝1",
    BaseSortID = 841,
    PotencyName = "AwakerPotency_130904_PotencyName|不息的潮涌",
    PotencyDesc = "AwakerPotency_130904_PotencyDesc|「涡！流！弹！」还会造成目标最大生命 0.5% 纯粹伤害，释放「深渊！漩涡！炮！」后界域精通 +50。莫丝自身、命轮、密契每拥有 1 点界域精通，「涡！流！弹！」额外造成目标最大生命 0.005% 的纯粹伤害，释放「深渊！漩涡！炮！」后界域精通 +0.5。",
    AwakerID = 130901,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [130914] = {
    ID = 130914,
    CnID = "启灵@莫丝2",
    BaseSortID = 842,
    PotencyName = "AwakerPotency_130914_PotencyName|轰鸣的深渊",
    PotencyDesc = "AwakerPotency_130914_PotencyDesc|莫丝的「打击」和「防御」使下次莫丝狂气爆发暴击率 +10%，下次「装填！」基础算力消耗降低 1。",
    AwakerID = 130901,
    PotencyType = "PassiveSkill",
    FrontPotency = 130904,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [130903] = {
    ID = 130903,
    CnID = "启灵@莫丝3",
    BaseSortID = 843,
    PotencyName = "AwakerPotency_130903_PotencyName|受缚的冲动",
    PotencyDesc = "AwakerPotency_130903_PotencyDesc|「深渊！漩涡！炮！」对生命最高敌人造成的伤害由双倍提高为三倍，每消耗 20 点狂气就使其他唤醒体获得 1 点狂气。",
    AwakerID = 130901,
    PotencyType = "PassiveSkill",
    FrontPotency = 130914,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [130905] = {
    ID = 130905,
    CnID = "启灵@莫丝人格深化1",
    BaseSortID = 844,
    PotencyName = "AwakerPotency_130905_PotencyName|人格深化",
    AwakerID = 130901,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18139,
      1.2
    },
    FrontPotency = 130903,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [130902] = {
    ID = 130902,
    CnID = "启灵@莫丝人格深化2",
    BaseSortID = 845,
    PotencyName = "AwakerPotency_130902_PotencyName|人格深化",
    AwakerID = 130901,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18139,
      1.2
    },
    FrontPotency = 130905,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [130909] = {
    ID = 130909,
    CnID = "启灵@莫丝人格深化3",
    BaseSortID = 846,
    PotencyName = "AwakerPotency_130909_PotencyName|人格深化",
    AwakerID = 130901,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18139,
      1.2
    },
    FrontPotency = 130902,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [130916] = {
    ID = 130916,
    CnID = "启灵@莫丝人格深化4",
    BaseSortID = 847,
    PotencyName = "AwakerPotency_130916_PotencyName|默斯克斯！大！轰！炸！",
    PotencyDesc = "AwakerPotency_130916_PotencyDesc|每牺牲 1 条触腕提升的暴击伤害翻倍。接下来释放的 5 次「涡！流！弹！」生效 2 次。",
    AwakerID = 130901,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18139,
      1.2
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 130909,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [130907] = {
    ID = 130907,
    CnID = "启灵@莫丝人格深化5",
    BaseSortID = 848,
    PotencyName = "AwakerPotency_130907_PotencyName|人格深化",
    AwakerID = 130901,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18139,
      1.2
    },
    FrontPotency = 130916,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [130911] = {
    ID = 130911,
    CnID = "启灵@莫丝人格深化6",
    BaseSortID = 849,
    PotencyName = "AwakerPotency_130911_PotencyName|人格深化",
    AwakerID = 130901,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18139,
      1.2
    },
    FrontPotency = 130907,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [130915] = {
    ID = 130915,
    CnID = "启灵@莫丝人格深化7",
    BaseSortID = 850,
    PotencyName = "AwakerPotency_130915_PotencyName|人格深化",
    AwakerID = 130901,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18139,
      1.2
    },
    FrontPotency = 130911,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [130906] = {
    ID = 130906,
    CnID = "启灵@莫丝人格深化8",
    BaseSortID = 851,
    PotencyName = "AwakerPotency_130906_PotencyName|人格深化",
    AwakerID = 130901,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18139,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 130915,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [130913] = {
    ID = 130913,
    CnID = "启灵@莫丝人格深化9",
    BaseSortID = 852,
    PotencyName = "AwakerPotency_130913_PotencyName|人格深化",
    AwakerID = 130901,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18139,
      1.2
    },
    FrontPotency = 130906,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [130912] = {
    ID = 130912,
    CnID = "启灵@莫丝人格深化10",
    BaseSortID = 853,
    PotencyName = "AwakerPotency_130912_PotencyName|人格深化",
    AwakerID = 130901,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18139,
      1.2
    },
    FrontPotency = 130913,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [130908] = {
    ID = 130908,
    CnID = "启灵@莫丝人格深化11",
    BaseSortID = 854,
    PotencyName = "AwakerPotency_130908_PotencyName|人格深化",
    AwakerID = 130901,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18139,
      1.2
    },
    FrontPotency = 130912,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [130910] = {
    ID = 130910,
    CnID = "启灵@莫丝人格深化12",
    BaseSortID = 855,
    PotencyName = "AwakerPotency_130910_PotencyName|砰——！嘣——！轰——！",
    PotencyDesc = "AwakerPotency_130910_PotencyDesc|灵知觉醒「漩涡来了！」获得强化，莫丝释放追击后下次莫丝狂气爆发触腕伤害加成额外提高 50%，并使下次狂气爆发对生命最高敌人造成 1% 最大生命的纯粹伤害，最多叠加 5 次。",
    AwakerID = 130901,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18139,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 130908,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [79196] = {
    ID = 79196,
    CnID = "启灵@阿拉克涅1",
    BaseSortID = 856,
    PotencyName = "AwakerPotency_79196_PotencyName|未来如我所见",
    PotencyDesc = "AwakerPotency_79196_PotencyDesc|阿拉克涅狂气爆发造成的临时伤害强效提高 25%。阿拉克涅唤醒体自身、命轮、密契每拥有 1 点界域精通，造成的临时伤害强效效果额外提高 0.25%。",
    AwakerID = 77918,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [79197] = {
    ID = 79197,
    CnID = "启灵@阿拉克涅2",
    BaseSortID = 857,
    PotencyName = "AwakerPotency_79197_PotencyName|万物如我所思",
    PotencyDesc = "AwakerPotency_79197_PotencyDesc|「永恒织造」造成的「命运裁断」提高 50%。「缚命罗网」获得「预备」和「保留」。",
    AwakerID = 77918,
    PotencyType = "PassiveSkill",
    FrontPotency = 79196,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79198] = {
    ID = 79198,
    CnID = "启灵@阿拉克涅3",
    BaseSortID = 858,
    PotencyName = "AwakerPotency_79198_PotencyName|宿命如我所织",
    PotencyDesc = "AwakerPotency_79198_PotencyDesc|「织命」上限由 3 提高为 5，「无尽线缕」获取的「奇点棱镜」翻倍。",
    AwakerID = 77918,
    PotencyType = "PassiveSkill",
    FrontPotency = 79197,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [78989] = {
    ID = 78989,
    CnID = "启灵@阿拉克涅人格深化1",
    BaseSortID = 859,
    PotencyName = "AwakerPotency_78989_PotencyName|人格深化",
    AwakerID = 77918,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18151,
      2.8
    },
    FrontPotency = 79198,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78992] = {
    ID = 78992,
    CnID = "启灵@阿拉克涅人格深化2",
    BaseSortID = 860,
    PotencyName = "AwakerPotency_78992_PotencyName|人格深化",
    AwakerID = 77918,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18151,
      2.8
    },
    FrontPotency = 78989,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78991] = {
    ID = 78991,
    CnID = "启灵@阿拉克涅人格深化3",
    BaseSortID = 861,
    PotencyName = "AwakerPotency_78991_PotencyName|人格深化",
    AwakerID = 77918,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18151,
      2.8
    },
    FrontPotency = 78992,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78986] = {
    ID = 78986,
    CnID = "启灵@阿拉克涅人格深化4",
    BaseSortID = 862,
    PotencyName = "AwakerPotency_78986_PotencyName|凌驾命运的悲歌",
    PotencyDesc = "AwakerPotency_78986_PotencyDesc|生成手中和超维空间最多 5 张具有「奇点信标」卡牌的临时原始复制，将其随机置入抽牌堆和弃牌堆并使其算力消耗变为 0。",
    AwakerID = 77918,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18151,
      2.8
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 78991,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78985] = {
    ID = 78985,
    CnID = "启灵@阿拉克涅人格深化5",
    BaseSortID = 863,
    PotencyName = "AwakerPotency_78985_PotencyName|人格深化",
    AwakerID = 77918,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18151,
      2.8
    },
    FrontPotency = 78986,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78988] = {
    ID = 78988,
    CnID = "启灵@阿拉克涅人格深化6",
    BaseSortID = 864,
    PotencyName = "AwakerPotency_78988_PotencyName|人格深化",
    AwakerID = 77918,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18151,
      2.8
    },
    FrontPotency = 78985,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78987] = {
    ID = 78987,
    CnID = "启灵@阿拉克涅人格深化7",
    BaseSortID = 865,
    PotencyName = "AwakerPotency_78987_PotencyName|人格深化",
    AwakerID = 77918,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18151,
      2.8
    },
    FrontPotency = 78988,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79155] = {
    ID = 79155,
    CnID = "启灵@阿拉克涅人格深化8",
    BaseSortID = 866,
    PotencyName = "AwakerPotency_79155_PotencyName|人格深化",
    AwakerID = 77918,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18151,
      2.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 78987,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78981] = {
    ID = 78981,
    CnID = "启灵@阿拉克涅人格深化9",
    BaseSortID = 867,
    PotencyName = "AwakerPotency_78981_PotencyName|人格深化",
    AwakerID = 77918,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18151,
      2.8
    },
    FrontPotency = 79155,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79070] = {
    ID = 79070,
    CnID = "启灵@阿拉克涅人格深化10",
    BaseSortID = 868,
    PotencyName = "AwakerPotency_79070_PotencyName|人格深化",
    AwakerID = 77918,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18151,
      2.8
    },
    FrontPotency = 78981,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79069] = {
    ID = 79069,
    CnID = "启灵@阿拉克涅人格深化11",
    BaseSortID = 869,
    PotencyName = "AwakerPotency_79069_PotencyName|人格深化",
    AwakerID = 77918,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18151,
      2.8
    },
    FrontPotency = 79070,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79071] = {
    ID = 79071,
    CnID = "启灵@阿拉克涅人格深化12",
    BaseSortID = 870,
    PotencyName = "AwakerPotency_79071_PotencyName|摩伊赖的终章",
    PotencyDesc = "AwakerPotency_79071_PotencyDesc|灵知觉醒「木偶戏场揭幕」获得强化，释放「湮灭」后立刻对所有敌人造成等同于 50％「命运裁断」的纯粹伤害伤害，下次狂气爆发造成的伤害强效和护盾提高 50％。",
    AwakerID = 77918,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      18151,
      2.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79069,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [142829] = {
    ID = 142829,
    CnID = "启灵@庞托斯1",
    BaseSortID = 871,
    PotencyName = "AwakerPotency_142829_PotencyName|向光之饵",
    PotencyDesc = "AwakerPotency_142829_PotencyDesc|「猎杀之魇」固定伤害提高 10%，「无休猎宴」基础力量降低效果提高 5%。庞托斯唤醒体自身、命轮、密契每拥有 1% 暴击伤害就使「猎杀之魇」固定伤害额外提高 0.2%，「无休猎宴」基础力量降低效果额外提高 0.1%。",
    AwakerID = 141302,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [142836] = {
    ID = 142836,
    CnID = "启灵@庞托斯2",
    BaseSortID = 872,
    PotencyName = "AwakerPotency_142836_PotencyName|空躯壳",
    PotencyDesc = "AwakerPotency_142836_PotencyDesc|「纵魇掠袭」基础伤害提高 25％，伤害和狂气效果生效 X+1 次。",
    AwakerID = 141302,
    PotencyType = "PassiveSkill",
    FrontPotency = 142829,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [142824] = {
    ID = 142824,
    CnID = "启灵@庞托斯3",
    BaseSortID = 873,
    PotencyName = "AwakerPotency_142824_PotencyName|缺位狂欢",
    PotencyDesc = "AwakerPotency_142824_PotencyDesc|每回合首次「打击」和首次「防御」抽 1 张「囚魇」。「囚魇」获得「余波：算力消耗-1」。",
    AwakerID = 141302,
    PotencyType = "PassiveSkill",
    FrontPotency = 142836,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [142827] = {
    ID = 142827,
    CnID = "启灵@庞托斯人格深化1",
    BaseSortID = 874,
    PotencyName = "AwakerPotency_142827_PotencyName|人格深化",
    AwakerID = 141302,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 142824,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [142828] = {
    ID = 142828,
    CnID = "启灵@庞托斯人格深化2",
    BaseSortID = 875,
    PotencyName = "AwakerPotency_142828_PotencyName|人格深化",
    AwakerID = 141302,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 142827,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [142832] = {
    ID = 142832,
    CnID = "启灵@庞托斯人格深化3",
    BaseSortID = 876,
    PotencyName = "AwakerPotency_142832_PotencyName|人格深化",
    AwakerID = 141302,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 142828,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [142833] = {
    ID = 142833,
    CnID = "启灵@庞托斯人格深化4",
    BaseSortID = 877,
    PotencyName = "AwakerPotency_142833_PotencyName|另一个厄波扬斯",
    PotencyDesc = "AwakerPotency_142833_PotencyDesc|造成固定伤害变为 3 倍。若造成击杀额外生成 1 张「囚魇」。使各处「囚魇」算力消耗 -1。",
    AwakerID = 141302,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      2.4,
      18142,
      0.8
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 142832,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [142823] = {
    ID = 142823,
    CnID = "启灵@庞托斯人格深化5",
    BaseSortID = 878,
    PotencyName = "AwakerPotency_142823_PotencyName|人格深化",
    AwakerID = 141302,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 142833,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [142835] = {
    ID = 142835,
    CnID = "启灵@庞托斯人格深化6",
    BaseSortID = 879,
    PotencyName = "AwakerPotency_142835_PotencyName|人格深化",
    AwakerID = 141302,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 142823,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [142834] = {
    ID = 142834,
    CnID = "启灵@庞托斯人格深化7",
    BaseSortID = 880,
    PotencyName = "AwakerPotency_142834_PotencyName|人格深化",
    AwakerID = 141302,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 142835,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [142837] = {
    ID = 142837,
    CnID = "启灵@庞托斯人格深化8",
    BaseSortID = 881,
    PotencyName = "AwakerPotency_142837_PotencyName|人格深化",
    AwakerID = 141302,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      2.4,
      18142,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 142834,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [142825] = {
    ID = 142825,
    CnID = "启灵@庞托斯人格深化9",
    BaseSortID = 882,
    PotencyName = "AwakerPotency_142825_PotencyName|人格深化",
    AwakerID = 141302,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 142837,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [142830] = {
    ID = 142830,
    CnID = "启灵@庞托斯人格深化10",
    BaseSortID = 883,
    PotencyName = "AwakerPotency_142830_PotencyName|人格深化",
    AwakerID = 141302,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 142825,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [142826] = {
    ID = 142826,
    CnID = "启灵@庞托斯人格深化11",
    BaseSortID = 884,
    PotencyName = "AwakerPotency_142826_PotencyName|人格深化",
    AwakerID = 141302,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      2.4,
      18142,
      0.8
    },
    FrontPotency = 142830,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [142831] = {
    ID = 142831,
    CnID = "启灵@庞托斯人格深化12",
    BaseSortID = 885,
    PotencyName = "AwakerPotency_142831_PotencyName|至深至静的侵吞",
    PotencyDesc = "AwakerPotency_142831_PotencyDesc|灵知觉醒「囚渊的怒仇」获得强化，每回合首次「打击」和首次「防御」额外获得 15 点狂气。获得「围猎」所需的「囚魇」数由 3 降低为 2。",
    AwakerID = 141302,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      2.4,
      18142,
      0.8
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 142826,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [145378] = {
    ID = 145378,
    CnID = "启灵@蚀灭·萝坦1",
    BaseSortID = 886,
    PotencyName = "AwakerPotency_145378_PotencyName|腐朽遗骸",
    PotencyDesc = "AwakerPotency_145378_PotencyDesc|蚀灭·萝坦「打击」暴击率 +10％，基础伤害 +20％。蚀灭·萝坦唤醒体自身、命轮、密契每有 1％ 黑印掉落，「打击」暴击率 +0.5％，基础伤害 +1％。",
    AwakerID = 145363,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [145364] = {
    ID = 145364,
    CnID = "启灵@蚀灭·萝坦2",
    BaseSortID = 887,
    PotencyName = "AwakerPotency_145364_PotencyName|不灭战意",
    PotencyDesc = "AwakerPotency_145364_PotencyDesc|「基础打击」抽取 1 张「短刃·噬」，「基础防御」抽取 1 张「长刃·陨」，每回合最多各生效 1 次。",
    AwakerID = 145363,
    PotencyType = "PassiveSkill",
    FrontPotency = 145378,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [145374] = {
    ID = 145374,
    CnID = "启灵@蚀灭·萝坦3",
    BaseSortID = 888,
    PotencyName = "AwakerPotency_145374_PotencyName|无冕风暴",
    PotencyDesc = "AwakerPotency_145374_PotencyDesc|「断界之剑」从「巨剑·鲸落」获得的伤害加成翻倍。每回合首次「蚀灭」不再消耗算力。",
    AwakerID = 145363,
    PotencyType = "PassiveSkill",
    FrontPotency = 145364,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [145367] = {
    ID = 145367,
    CnID = "启灵@蚀灭·萝坦人格深化1",
    BaseSortID = 889,
    PotencyName = "AwakerPotency_145367_PotencyName|人格深化",
    AwakerID = 145363,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18155,
      1.2
    },
    FrontPotency = 145374,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [145370] = {
    ID = 145370,
    CnID = "启灵@蚀灭·萝坦人格深化2",
    BaseSortID = 890,
    PotencyName = "AwakerPotency_145370_PotencyName|人格深化",
    AwakerID = 145363,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18155,
      1.2
    },
    FrontPotency = 145367,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [145365] = {
    ID = 145365,
    CnID = "启灵@蚀灭·萝坦人格深化3",
    BaseSortID = 891,
    PotencyName = "AwakerPotency_145365_PotencyName|人格深化",
    AwakerID = 145363,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18155,
      1.2
    },
    FrontPotency = 145370,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [145368] = {
    ID = 145368,
    CnID = "启灵@蚀灭·萝坦人格深化4",
    BaseSortID = 892,
    PotencyName = "AwakerPotency_145368_PotencyName|斩落鲸天之夜",
    PotencyDesc = "AwakerPotency_145368_PotencyDesc|造成伤害前获得等同于「巨剑·鲸落」使目标提高伤害值的力量，本次狂气爆发力量加成翻倍。",
    AwakerID = 145363,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18155,
      1.2
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 145365,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [145371] = {
    ID = 145371,
    CnID = "启灵@蚀灭·萝坦人格深化5",
    BaseSortID = 893,
    PotencyName = "AwakerPotency_145371_PotencyName|人格深化",
    AwakerID = 145363,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18155,
      1.2
    },
    FrontPotency = 145368,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [145376] = {
    ID = 145376,
    CnID = "启灵@蚀灭·萝坦人格深化6",
    BaseSortID = 894,
    PotencyName = "AwakerPotency_145376_PotencyName|人格深化",
    AwakerID = 145363,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18155,
      1.2
    },
    FrontPotency = 145371,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [145366] = {
    ID = 145366,
    CnID = "启灵@蚀灭·萝坦人格深化7",
    BaseSortID = 895,
    PotencyName = "AwakerPotency_145366_PotencyName|人格深化",
    AwakerID = 145363,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18155,
      1.2
    },
    FrontPotency = 145376,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [145372] = {
    ID = 145372,
    CnID = "启灵@蚀灭·萝坦人格深化8",
    BaseSortID = 896,
    PotencyName = "AwakerPotency_145372_PotencyName|人格深化",
    AwakerID = 145363,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18155,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 145366,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [145369] = {
    ID = 145369,
    CnID = "启灵@蚀灭·萝坦人格深化9",
    BaseSortID = 897,
    PotencyName = "AwakerPotency_145369_PotencyName|人格深化",
    AwakerID = 145363,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18155,
      1.2
    },
    FrontPotency = 145372,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [145373] = {
    ID = 145373,
    CnID = "启灵@蚀灭·萝坦人格深化10",
    BaseSortID = 898,
    PotencyName = "AwakerPotency_145373_PotencyName|人格深化",
    AwakerID = 145363,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18155,
      1.2
    },
    FrontPotency = 145369,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [145377] = {
    ID = 145377,
    CnID = "启灵@蚀灭·萝坦人格深化11",
    BaseSortID = 899,
    PotencyName = "AwakerPotency_145377_PotencyName|人格深化",
    AwakerID = 145363,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18155,
      1.2
    },
    FrontPotency = 145373,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [145375] = {
    ID = 145375,
    CnID = "启灵@蚀灭·萝坦人格深化12",
    BaseSortID = 900,
    PotencyName = "AwakerPotency_145375_PotencyName|万古孤临",
    PotencyDesc = "AwakerPotency_145375_PotencyDesc|灵知觉醒「亘古归源」获得强化，「蚀灭」通过偷取获得的狂气、最终伤害加成、最终伤害加成叠加上限提高 50％。",
    AwakerID = 145363,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18151,
      2.8,
      18155,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 145377,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [147398] = {
    ID = 147398,
    CnID = "启灵@暮星·汀克特孤岛",
    BaseSortID = 901,
    PotencyName = "AwakerPotency_147398_PotencyName|孤岛",
    AwakerID = 147397,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [147406] = {
    ID = 147406,
    CnID = "启灵@暮星·汀克特等待等待",
    BaseSortID = 902,
    PotencyName = "AwakerPotency_147406_PotencyName|等待，等待",
    AwakerID = 147397,
    PotencyType = "PassiveSkill",
    FrontPotency = 147398,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [147405] = {
    ID = 147405,
    CnID = "启灵@暮星·汀克特她的摇篮曲",
    BaseSortID = 903,
    PotencyName = "AwakerPotency_147405_PotencyName|她的摇篮曲",
    AwakerID = 147397,
    PotencyType = "PassiveSkill",
    FrontPotency = 147406,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [147407] = {
    ID = 147407,
    CnID = "启灵@暮星·汀克特人格深化1",
    BaseSortID = 904,
    PotencyName = "AwakerPotency_147407_PotencyName|人格深化",
    AwakerID = 147397,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 147405,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [147411] = {
    ID = 147411,
    CnID = "启灵@暮星·汀克特人格深化2",
    BaseSortID = 905,
    PotencyName = "AwakerPotency_147411_PotencyName|人格深化",
    AwakerID = 147397,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 147407,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [147399] = {
    ID = 147399,
    CnID = "启灵@暮星·汀克特人格深化3",
    BaseSortID = 906,
    PotencyName = "AwakerPotency_147399_PotencyName|人格深化",
    AwakerID = 147397,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 147411,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [147403] = {
    ID = 147403,
    CnID = "启灵@暮星·汀克特人格深化4",
    BaseSortID = 907,
    PotencyName = "AwakerPotency_147403_PotencyName|超限爆发",
    AwakerID = 147397,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    EffectType1 = "ComingSoon",
    FrontPotency = 147399,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [147410] = {
    ID = 147410,
    CnID = "启灵@暮星·汀克特人格深化5",
    BaseSortID = 908,
    PotencyName = "AwakerPotency_147410_PotencyName|人格深化",
    AwakerID = 147397,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 147403,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [147408] = {
    ID = 147408,
    CnID = "启灵@暮星·汀克特人格深化6",
    BaseSortID = 909,
    PotencyName = "AwakerPotency_147408_PotencyName|人格深化",
    AwakerID = 147397,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 147410,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [147400] = {
    ID = 147400,
    CnID = "启灵@暮星·汀克特人格深化7",
    BaseSortID = 910,
    PotencyName = "AwakerPotency_147400_PotencyName|人格深化",
    AwakerID = 147397,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 147408,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [147402] = {
    ID = 147402,
    CnID = "启灵@暮星·汀克特人格深化8",
    BaseSortID = 911,
    PotencyName = "AwakerPotency_147402_PotencyName|人格深化",
    AwakerID = 147397,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 147400,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [147401] = {
    ID = 147401,
    CnID = "启灵@暮星·汀克特人格深化9",
    BaseSortID = 912,
    PotencyName = "AwakerPotency_147401_PotencyName|人格深化",
    AwakerID = 147397,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 147402,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [147409] = {
    ID = 147409,
    CnID = "启灵@暮星·汀克特人格深化10",
    BaseSortID = 913,
    PotencyName = "AwakerPotency_147409_PotencyName|人格深化",
    AwakerID = 147397,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 147401,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [147412] = {
    ID = 147412,
    CnID = "启灵@暮星·汀克特人格深化11",
    BaseSortID = 914,
    PotencyName = "AwakerPotency_147412_PotencyName|人格深化",
    AwakerID = 147397,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    FrontPotency = 147409,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [147404] = {
    ID = 147404,
    CnID = "启灵@暮星·汀克特人格深化12",
    BaseSortID = 915,
    PotencyName = "AwakerPotency_147404_PotencyName|人格深化",
    AwakerID = 147397,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      22207,
      0.4,
      18155,
      1.2
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 147412,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78997] = {
    ID = 78997,
    CnID = "启灵@卡拉布1",
    BaseSortID = 916,
    PotencyName = "AwakerPotency_78997_PotencyName|秘密修行",
    PotencyDesc = "AwakerPotency_78997_PotencyDesc|「粉雪魔咒」造成的固定伤害提高 30%，并获得 10 点狂气。卡拉布唤醒体自身、命轮、密契每拥有1 点界域精通，「粉雪魔咒」造成的固定伤害提高 0.15%，获得的狂气提高 0.05 点",
    AwakerID = 77921,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [79053] = {
    ID = 79053,
    CnID = "启灵@卡拉布2",
    BaseSortID = 917,
    PotencyName = "AwakerPotency_79053_PotencyName|七重礼拜",
    PotencyDesc = "AwakerPotency_79053_PotencyDesc|卡拉布每第 7 次打出「打击」或「防御」时，获得 1 层「供奉」并发现 2 张「代价」不同的「赐福」，选择 1 张置入手中。",
    AwakerID = 77921,
    PotencyType = "PassiveSkill",
    FrontPotency = 78997,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79029] = {
    ID = 79029,
    CnID = "启灵@卡拉布3",
    BaseSortID = 918,
    PotencyName = "AwakerPotency_79029_PotencyName|三重宣誓",
    PotencyDesc = "AwakerPotency_79029_PotencyDesc|卡拉布狂气爆发伤害次数 +2。「饱餐」每层提供的生命上限加成效果提高 50%，狂气爆发基础伤害与护盾加成效果提高 50%。",
    AwakerID = 77921,
    PotencyType = "PassiveSkill",
    FrontPotency = 79053,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [79122] = {
    ID = 79122,
    CnID = "启灵@卡拉布人格深化1",
    BaseSortID = 919,
    PotencyName = "AwakerPotency_79122_PotencyName|人格深化",
    AwakerID = 77921,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      22207,
      0.4
    },
    FrontPotency = 79029,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79028] = {
    ID = 79028,
    CnID = "启灵@卡拉布人格深化2",
    BaseSortID = 920,
    PotencyName = "AwakerPotency_79028_PotencyName|人格深化",
    AwakerID = 77921,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      22207,
      0.4
    },
    FrontPotency = 79122,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79154] = {
    ID = 79154,
    CnID = "启灵@卡拉布人格深化3",
    BaseSortID = 921,
    PotencyName = "AwakerPotency_79154_PotencyName|人格深化",
    AwakerID = 77921,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      22207,
      0.4
    },
    FrontPotency = 79028,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78998] = {
    ID = 78998,
    CnID = "启灵@卡拉布人格深化4",
    BaseSortID = 922,
    PotencyName = "AwakerPotency_78998_PotencyName|童话天衣无缝",
    PotencyDesc = "AwakerPotency_78998_PotencyDesc|发现 2 组「礼物」不同的「赐福」，每组包含 2 张，选择 1 组置入手中。 使所有敌人永久降低等同于防御力 9% 的力量。",
    AwakerID = 77921,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      22207,
      0.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 79154,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78996] = {
    ID = 78996,
    CnID = "启灵@卡拉布人格深化5",
    BaseSortID = 923,
    PotencyName = "AwakerPotency_78996_PotencyName|人格深化",
    AwakerID = 77921,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      22207,
      0.4
    },
    FrontPotency = 78998,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79007] = {
    ID = 79007,
    CnID = "启灵@卡拉布人格深化6",
    BaseSortID = 924,
    PotencyName = "AwakerPotency_79007_PotencyName|人格深化",
    AwakerID = 77921,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      22207,
      0.4
    },
    FrontPotency = 78996,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79004] = {
    ID = 79004,
    CnID = "启灵@卡拉布人格深化7",
    BaseSortID = 925,
    PotencyName = "AwakerPotency_79004_PotencyName|人格深化",
    AwakerID = 77921,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      22207,
      0.4
    },
    FrontPotency = 79007,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78962] = {
    ID = 78962,
    CnID = "启灵@卡拉布人格深化8",
    BaseSortID = 926,
    PotencyName = "AwakerPotency_78962_PotencyName|人格深化",
    AwakerID = 77921,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      22207,
      0.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79004,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78993] = {
    ID = 78993,
    CnID = "启灵@卡拉布人格深化9",
    BaseSortID = 927,
    PotencyName = "AwakerPotency_78993_PotencyName|人格深化",
    AwakerID = 77921,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      22207,
      0.4
    },
    FrontPotency = 78962,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79105] = {
    ID = 79105,
    CnID = "启灵@卡拉布人格深化10",
    BaseSortID = 928,
    PotencyName = "AwakerPotency_79105_PotencyName|人格深化",
    AwakerID = 77921,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      22207,
      0.4
    },
    FrontPotency = 78993,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79104] = {
    ID = 79104,
    CnID = "启灵@卡拉布人格深化11",
    BaseSortID = 929,
    PotencyName = "AwakerPotency_79104_PotencyName|人格深化",
    AwakerID = 77921,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      22207,
      0.4
    },
    FrontPotency = 79105,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79143] = {
    ID = 79143,
    CnID = "启灵@卡拉布人格深化12",
    BaseSortID = 930,
    PotencyName = "AwakerPotency_79143_PotencyName|新月高悬中天",
    PotencyDesc = "AwakerPotency_79143_PotencyDesc|灵知觉醒「诱人蜜果」获得强化，使用猩红熔炉后，使下一次「奇迹赐福」发现效果每组额外包含 1 张「赐福」。打出「赐福」后，胚胎融合 +10，当前生命越低则效果越高，至多提高 100%。",
    AwakerID = 77921,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      4,
      22207,
      0.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79104,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [148465] = {
    ID = 148465,
    CnID = "启灵@负誓·奥吉尔1",
    BaseSortID = 931,
    PotencyName = "AwakerPotency_148465_PotencyName|为扞卫伫立",
    PotencyDesc = "AwakerPotency_148465_PotencyDesc|「未陨的骑士心」造成的护盾和力量倍率提高 20%，每层「暗涌」使负誓·奥吉尔暴击伤害提高 10%。\n负誓·奥吉尔唤醒体自身、命轮、密契每有 1% 暴击率，「未陨的骑士心」造成的护盾和力量倍率额外提高 0.6%，每层「暗涌」使负誓·奥吉尔暴击伤害额外提高 0.3%。",
    AwakerID = 94451,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [148474] = {
    ID = 148474,
    CnID = "启灵@负誓·奥吉尔2",
    BaseSortID = 932,
    PotencyName = "AwakerPotency_148474_PotencyName|为微光铭记",
    PotencyDesc = "AwakerPotency_148474_PotencyDesc|「打击」额外生效 1 次。",
    AwakerID = 94451,
    PotencyType = "PassiveSkill",
    FrontPotency = 148465,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [148470] = {
    ID = 148470,
    CnID = "启灵@负誓·奥吉尔3",
    BaseSortID = 933,
    PotencyName = "AwakerPotency_148470_PotencyName|为大义殒身",
    PotencyDesc = "AwakerPotency_148470_PotencyDesc|每层「暗涌」使指令卡最终伤害提高效果变为 50%，「未陨的骑士心」每消耗 1 层「暗涌」造成的护盾和力量提高效果变为 50%。",
    AwakerID = 94451,
    PotencyType = "PassiveSkill",
    FrontPotency = 148474,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [148471] = {
    ID = 148471,
    CnID = "启灵@负誓·奥吉尔人格深化1",
    BaseSortID = 934,
    PotencyName = "AwakerPotency_148471_PotencyName|人格深化",
    AwakerID = 94451,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 148470,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [148467] = {
    ID = 148467,
    CnID = "启灵@负誓·奥吉尔人格深化2",
    BaseSortID = 935,
    PotencyName = "AwakerPotency_148467_PotencyName|人格深化",
    AwakerID = 94451,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 148471,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [148462] = {
    ID = 148462,
    CnID = "启灵@负誓·奥吉尔人格深化3",
    BaseSortID = 936,
    PotencyName = "AwakerPotency_148462_PotencyName|人格深化",
    AwakerID = 94451,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 148467,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [148469] = {
    ID = 148469,
    CnID = "启灵@负誓·奥吉尔人格深化4",
    BaseSortID = 937,
    PotencyName = "AwakerPotency_148469_PotencyName|以我为壁",
    PotencyDesc = "AwakerPotency_148469_PotencyDesc|获得的力量变为 3 倍。",
    AwakerID = 94451,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 148462,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [148461] = {
    ID = 148461,
    CnID = "启灵@负誓·奥吉尔人格深化5",
    BaseSortID = 938,
    PotencyName = "AwakerPotency_148461_PotencyName|人格深化",
    AwakerID = 94451,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 148469,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [148460] = {
    ID = 148460,
    CnID = "启灵@负誓·奥吉尔人格深化6",
    BaseSortID = 939,
    PotencyName = "AwakerPotency_148460_PotencyName|人格深化",
    AwakerID = 94451,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 148461,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [148472] = {
    ID = 148472,
    CnID = "启灵@负誓·奥吉尔人格深化7",
    BaseSortID = 940,
    PotencyName = "AwakerPotency_148472_PotencyName|人格深化",
    AwakerID = 94451,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 148460,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [148468] = {
    ID = 148468,
    CnID = "启灵@负誓·奥吉尔人格深化8",
    BaseSortID = 941,
    PotencyName = "AwakerPotency_148468_PotencyName|人格深化",
    AwakerID = 94451,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 148472,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [148473] = {
    ID = 148473,
    CnID = "启灵@负誓·奥吉尔人格深化9",
    BaseSortID = 942,
    PotencyName = "AwakerPotency_148473_PotencyName|人格深化",
    AwakerID = 94451,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 148468,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [148464] = {
    ID = 148464,
    CnID = "启灵@负誓·奥吉尔人格深化10",
    BaseSortID = 943,
    PotencyName = "AwakerPotency_148464_PotencyName|人格深化",
    AwakerID = 94451,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 148473,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [148463] = {
    ID = 148463,
    CnID = "启灵@负誓·奥吉尔人格深化11",
    BaseSortID = 944,
    PotencyName = "AwakerPotency_148463_PotencyName|人格深化",
    AwakerID = 94451,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    FrontPotency = 148464,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [148466] = {
    ID = 148466,
    CnID = "启灵@负誓·奥吉尔人格深化12",
    BaseSortID = 945,
    PotencyName = "AwakerPotency_148466_PotencyName|誓约，一如往初",
    PotencyDesc = "AwakerPotency_148466_PotencyDesc|灵知觉醒「与黑沼共生」获得强化，「染罪枪锋」基础伤害提高 100%，额外享受 200% 力量加成，「防御」的护盾提高效果变为 100%。",
    AwakerID = 94451,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18105,
      1.2,
      18159,
      1.6
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 148463,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = true
  },
  [79016] = {
    ID = 79016,
    CnID = "启灵@本源沉睡之主1",
    BaseSortID = 946,
    PotencyName = "AwakerPotency_79016_PotencyName|无穷智慧",
    PotencyDesc = "AwakerPotency_79016_PotencyDesc|「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。",
    AwakerID = 78754,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [79052] = {
    ID = 79052,
    CnID = "启灵@本源沉睡之主2",
    BaseSortID = 947,
    PotencyName = "AwakerPotency_79052_PotencyName|全知全能",
    PotencyDesc = "AwakerPotency_79052_PotencyDesc|「万物归一」发现的卡牌获得预备 1。",
    AwakerID = 78754,
    PotencyType = "PassiveSkill",
    FrontPotency = 79016,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79131] = {
    ID = 79131,
    CnID = "启灵@本源沉睡之主3",
    BaseSortID = 948,
    PotencyName = "AwakerPotency_79131_PotencyName|不存在的存在",
    PotencyDesc = "AwakerPotency_79131_PotencyDesc|「基础打击」和「基础防御」使本源沉睡之主获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。",
    AwakerID = 78754,
    PotencyType = "PassiveSkill",
    FrontPotency = 79052,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [79134] = {
    ID = 79134,
    CnID = "启灵@本源沉睡之主人格深化1",
    BaseSortID = 949,
    PotencyName = "AwakerPotency_79134_PotencyName|人格深化",
    AwakerID = 78754,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79131,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79099] = {
    ID = 79099,
    CnID = "启灵@本源沉睡之主人格深化2",
    BaseSortID = 950,
    PotencyName = "AwakerPotency_79099_PotencyName|人格深化",
    AwakerID = 78754,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79134,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79096] = {
    ID = 79096,
    CnID = "启灵@本源沉睡之主人格深化3",
    BaseSortID = 951,
    PotencyName = "AwakerPotency_79096_PotencyName|人格深化",
    AwakerID = 78754,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79099,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79002] = {
    ID = 79002,
    CnID = "启灵@本源沉睡之主人格深化4",
    BaseSortID = 952,
    PotencyName = "AwakerPotency_79002_PotencyName|无限亿万光辉",
    PotencyDesc = "AwakerPotency_79002_PotencyDesc|本源沉睡之主造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。",
    AwakerID = 78754,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 79096,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79121] = {
    ID = 79121,
    CnID = "启灵@本源沉睡之主人格深化5",
    BaseSortID = 953,
    PotencyName = "AwakerPotency_79121_PotencyName|人格深化",
    AwakerID = 78754,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79002,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79051] = {
    ID = 79051,
    CnID = "启灵@本源沉睡之主人格深化6",
    BaseSortID = 954,
    PotencyName = "AwakerPotency_79051_PotencyName|人格深化",
    AwakerID = 78754,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79121,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79033] = {
    ID = 79033,
    CnID = "启灵@本源沉睡之主人格深化7",
    BaseSortID = 955,
    PotencyName = "AwakerPotency_79033_PotencyName|人格深化",
    AwakerID = 78754,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79051,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79021] = {
    ID = 79021,
    CnID = "启灵@本源沉睡之主人格深化8",
    BaseSortID = 956,
    PotencyName = "AwakerPotency_79021_PotencyName|人格深化",
    AwakerID = 78754,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79033,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79010] = {
    ID = 79010,
    CnID = "启灵@本源沉睡之主人格深化9",
    BaseSortID = 957,
    PotencyName = "AwakerPotency_79010_PotencyName|人格深化",
    AwakerID = 78754,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79021,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79014] = {
    ID = 79014,
    CnID = "启灵@本源沉睡之主人格深化10",
    BaseSortID = 958,
    PotencyName = "AwakerPotency_79014_PotencyName|人格深化",
    AwakerID = 78754,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79010,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79078] = {
    ID = 79078,
    CnID = "启灵@本源沉睡之主人格深化11",
    BaseSortID = 959,
    PotencyName = "AwakerPotency_79078_PotencyName|人格深化",
    AwakerID = 78754,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79014,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79077] = {
    ID = 79077,
    CnID = "启灵@本源沉睡之主人格深化12",
    BaseSortID = 960,
    PotencyName = "AwakerPotency_79077_PotencyName|人格深化",
    AwakerID = 78754,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79078,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79048] = {
    ID = 79048,
    CnID = "启灵@黑法老1",
    BaseSortID = 961,
    PotencyName = "AwakerPotency_79048_PotencyName|无穷智慧",
    PotencyDesc = "AwakerPotency_79048_PotencyDesc|「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。",
    AwakerID = 77927,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [79045] = {
    ID = 79045,
    CnID = "启灵@黑法老2",
    BaseSortID = 962,
    PotencyName = "AwakerPotency_79045_PotencyName|全知全能",
    PotencyDesc = "AwakerPotency_79045_PotencyDesc|「万物归一」发现的卡牌获得预备 1。",
    AwakerID = 77927,
    PotencyType = "PassiveSkill",
    FrontPotency = 79048,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79046] = {
    ID = 79046,
    CnID = "启灵@黑法老3",
    BaseSortID = 963,
    PotencyName = "AwakerPotency_79046_PotencyName|不存在的存在",
    PotencyDesc = "AwakerPotency_79046_PotencyDesc|「基础打击」和「基础防御」使黑法老获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。",
    AwakerID = 77927,
    PotencyType = "PassiveSkill",
    FrontPotency = 79045,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [79128] = {
    ID = 79128,
    CnID = "启灵@黑法老人格深化1",
    BaseSortID = 964,
    PotencyName = "AwakerPotency_79128_PotencyName|人格深化",
    AwakerID = 77927,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79046,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79127] = {
    ID = 79127,
    CnID = "启灵@黑法老人格深化2",
    BaseSortID = 965,
    PotencyName = "AwakerPotency_79127_PotencyName|人格深化",
    AwakerID = 77927,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79128,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79126] = {
    ID = 79126,
    CnID = "启灵@黑法老人格深化3",
    BaseSortID = 966,
    PotencyName = "AwakerPotency_79126_PotencyName|人格深化",
    AwakerID = 77927,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79127,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79125] = {
    ID = 79125,
    CnID = "启灵@黑法老人格深化4",
    BaseSortID = 967,
    PotencyName = "AwakerPotency_79125_PotencyName|无限亿万光辉",
    PotencyDesc = "AwakerPotency_79125_PotencyDesc|黑法老造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。",
    AwakerID = 77927,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 79126,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79124] = {
    ID = 79124,
    CnID = "启灵@黑法老人格深化5",
    BaseSortID = 968,
    PotencyName = "AwakerPotency_79124_PotencyName|人格深化",
    AwakerID = 77927,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79125,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79083] = {
    ID = 79083,
    CnID = "启灵@黑法老人格深化6",
    BaseSortID = 969,
    PotencyName = "AwakerPotency_79083_PotencyName|人格深化",
    AwakerID = 77927,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79124,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79139] = {
    ID = 79139,
    CnID = "启灵@黑法老人格深化7",
    BaseSortID = 970,
    PotencyName = "AwakerPotency_79139_PotencyName|人格深化",
    AwakerID = 77927,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79083,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79136] = {
    ID = 79136,
    CnID = "启灵@黑法老人格深化8",
    BaseSortID = 971,
    PotencyName = "AwakerPotency_79136_PotencyName|人格深化",
    AwakerID = 77927,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79139,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79135] = {
    ID = 79135,
    CnID = "启灵@黑法老人格深化9",
    BaseSortID = 972,
    PotencyName = "AwakerPotency_79135_PotencyName|人格深化",
    AwakerID = 77927,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79136,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79163] = {
    ID = 79163,
    CnID = "启灵@黑法老人格深化10",
    BaseSortID = 973,
    PotencyName = "AwakerPotency_79163_PotencyName|人格深化",
    AwakerID = 77927,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79135,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79162] = {
    ID = 79162,
    CnID = "启灵@黑法老人格深化11",
    BaseSortID = 974,
    PotencyName = "AwakerPotency_79162_PotencyName|人格深化",
    AwakerID = 77927,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79163,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79161] = {
    ID = 79161,
    CnID = "启灵@黑法老人格深化12",
    BaseSortID = 975,
    PotencyName = "AwakerPotency_79161_PotencyName|人格深化",
    AwakerID = 77927,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79162,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79025] = {
    ID = 79025,
    CnID = "启灵@兰提戈斯1",
    BaseSortID = 976,
    PotencyName = "AwakerPotency_79025_PotencyName|无穷智慧",
    PotencyDesc = "AwakerPotency_79025_PotencyDesc|「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。",
    AwakerID = 77914,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [79027] = {
    ID = 79027,
    CnID = "启灵@兰提戈斯2",
    BaseSortID = 977,
    PotencyName = "AwakerPotency_79027_PotencyName|全知全能",
    PotencyDesc = "AwakerPotency_79027_PotencyDesc|「万物归一」发现的卡牌获得预备 1。",
    AwakerID = 77914,
    PotencyType = "PassiveSkill",
    FrontPotency = 79025,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79026] = {
    ID = 79026,
    CnID = "启灵@兰提戈斯3",
    BaseSortID = 978,
    PotencyName = "AwakerPotency_79026_PotencyName|不存在的存在",
    PotencyDesc = "AwakerPotency_79026_PotencyDesc|「基础打击」和「基础防御」使兰提戈斯获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。",
    AwakerID = 77914,
    PotencyType = "PassiveSkill",
    FrontPotency = 79027,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [78950] = {
    ID = 78950,
    CnID = "启灵@兰提戈斯人格深化1",
    BaseSortID = 979,
    PotencyName = "AwakerPotency_78950_PotencyName|人格深化",
    AwakerID = 77914,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79026,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79108] = {
    ID = 79108,
    CnID = "启灵@兰提戈斯人格深化2",
    BaseSortID = 980,
    PotencyName = "AwakerPotency_79108_PotencyName|人格深化",
    AwakerID = 77914,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 78950,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79079] = {
    ID = 79079,
    CnID = "启灵@兰提戈斯人格深化3",
    BaseSortID = 981,
    PotencyName = "AwakerPotency_79079_PotencyName|人格深化",
    AwakerID = 77914,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79108,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79072] = {
    ID = 79072,
    CnID = "启灵@兰提戈斯人格深化4",
    BaseSortID = 982,
    PotencyName = "AwakerPotency_79072_PotencyName|无限亿万光辉",
    PotencyDesc = "AwakerPotency_79072_PotencyDesc|兰提戈斯造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。",
    AwakerID = 77914,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 79079,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79073] = {
    ID = 79073,
    CnID = "启灵@兰提戈斯人格深化5",
    BaseSortID = 983,
    PotencyName = "AwakerPotency_79073_PotencyName|人格深化",
    AwakerID = 77914,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79072,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79074] = {
    ID = 79074,
    CnID = "启灵@兰提戈斯人格深化6",
    BaseSortID = 984,
    PotencyName = "AwakerPotency_79074_PotencyName|人格深化",
    AwakerID = 77914,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79073,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79075] = {
    ID = 79075,
    CnID = "启灵@兰提戈斯人格深化7",
    BaseSortID = 985,
    PotencyName = "AwakerPotency_79075_PotencyName|人格深化",
    AwakerID = 77914,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79074,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79081] = {
    ID = 79081,
    CnID = "启灵@兰提戈斯人格深化8",
    BaseSortID = 986,
    PotencyName = "AwakerPotency_79081_PotencyName|人格深化",
    AwakerID = 77914,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79075,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79082] = {
    ID = 79082,
    CnID = "启灵@兰提戈斯人格深化9",
    BaseSortID = 987,
    PotencyName = "AwakerPotency_79082_PotencyName|人格深化",
    AwakerID = 77914,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79081,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78965] = {
    ID = 78965,
    CnID = "启灵@兰提戈斯人格深化10",
    BaseSortID = 988,
    PotencyName = "AwakerPotency_78965_PotencyName|人格深化",
    AwakerID = 77914,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79082,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79129] = {
    ID = 79129,
    CnID = "启灵@兰提戈斯人格深化11",
    BaseSortID = 989,
    PotencyName = "AwakerPotency_79129_PotencyName|人格深化",
    AwakerID = 77914,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 78965,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79088] = {
    ID = 79088,
    CnID = "启灵@兰提戈斯人格深化12",
    BaseSortID = 990,
    PotencyName = "AwakerPotency_79088_PotencyName|人格深化",
    AwakerID = 77914,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79129,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79056] = {
    ID = 79056,
    CnID = "启灵@夏塔克鸟1",
    BaseSortID = 991,
    PotencyName = "AwakerPotency_79056_PotencyName|无穷智慧",
    PotencyDesc = "AwakerPotency_79056_PotencyDesc|「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。",
    AwakerID = 77924,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [79068] = {
    ID = 79068,
    CnID = "启灵@夏塔克鸟2",
    BaseSortID = 992,
    PotencyName = "AwakerPotency_79068_PotencyName|全知全能",
    PotencyDesc = "AwakerPotency_79068_PotencyDesc|「万物归一」发现的卡牌获得预备 1。",
    AwakerID = 77924,
    PotencyType = "PassiveSkill",
    FrontPotency = 79056,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79063] = {
    ID = 79063,
    CnID = "启灵@夏塔克鸟3",
    BaseSortID = 993,
    PotencyName = "AwakerPotency_79063_PotencyName|不存在的存在",
    PotencyDesc = "AwakerPotency_79063_PotencyDesc|「基础打击」和「基础防御」使夏塔克鸟获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。",
    AwakerID = 77924,
    PotencyType = "PassiveSkill",
    FrontPotency = 79068,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [79149] = {
    ID = 79149,
    CnID = "启灵@夏塔克鸟人格深化1",
    BaseSortID = 994,
    PotencyName = "AwakerPotency_79149_PotencyName|人格深化",
    AwakerID = 77924,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79063,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79106] = {
    ID = 79106,
    CnID = "启灵@夏塔克鸟人格深化2",
    BaseSortID = 995,
    PotencyName = "AwakerPotency_79106_PotencyName|人格深化",
    AwakerID = 77924,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79149,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79107] = {
    ID = 79107,
    CnID = "启灵@夏塔克鸟人格深化3",
    BaseSortID = 996,
    PotencyName = "AwakerPotency_79107_PotencyName|人格深化",
    AwakerID = 77924,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79106,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79100] = {
    ID = 79100,
    CnID = "启灵@夏塔克鸟人格深化4",
    BaseSortID = 997,
    PotencyName = "AwakerPotency_79100_PotencyName|无限亿万光辉",
    PotencyDesc = "AwakerPotency_79100_PotencyDesc|夏塔克鸟造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。",
    AwakerID = 77924,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 79107,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79093] = {
    ID = 79093,
    CnID = "启灵@夏塔克鸟人格深化5",
    BaseSortID = 998,
    PotencyName = "AwakerPotency_79093_PotencyName|人格深化",
    AwakerID = 77924,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79100,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79102] = {
    ID = 79102,
    CnID = "启灵@夏塔克鸟人格深化6",
    BaseSortID = 999,
    PotencyName = "AwakerPotency_79102_PotencyName|人格深化",
    AwakerID = 77924,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79093,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79199] = {
    ID = 79199,
    CnID = "启灵@夏塔克鸟人格深化7",
    BaseSortID = 1000,
    PotencyName = "AwakerPotency_79199_PotencyName|人格深化",
    AwakerID = 77924,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79102,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79097] = {
    ID = 79097,
    CnID = "启灵@夏塔克鸟人格深化8",
    BaseSortID = 1001,
    PotencyName = "AwakerPotency_79097_PotencyName|人格深化",
    AwakerID = 77924,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79199,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79098] = {
    ID = 79098,
    CnID = "启灵@夏塔克鸟人格深化9",
    BaseSortID = 1002,
    PotencyName = "AwakerPotency_79098_PotencyName|人格深化",
    AwakerID = 77924,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79097,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79194] = {
    ID = 79194,
    CnID = "启灵@夏塔克鸟人格深化10",
    BaseSortID = 1003,
    PotencyName = "AwakerPotency_79194_PotencyName|人格深化",
    AwakerID = 77924,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79098,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79195] = {
    ID = 79195,
    CnID = "启灵@夏塔克鸟人格深化11",
    BaseSortID = 1004,
    PotencyName = "AwakerPotency_79195_PotencyName|人格深化",
    AwakerID = 77924,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79194,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79193] = {
    ID = 79193,
    CnID = "启灵@夏塔克鸟人格深化12",
    BaseSortID = 1005,
    PotencyName = "AwakerPotency_79193_PotencyName|人格深化",
    AwakerID = 77924,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79195,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79118] = {
    ID = 79118,
    CnID = "启灵@秃鹫1",
    BaseSortID = 1006,
    PotencyName = "AwakerPotency_79118_PotencyName|无穷智慧",
    PotencyDesc = "AwakerPotency_79118_PotencyDesc|「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。",
    AwakerID = 77911,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [79024] = {
    ID = 79024,
    CnID = "启灵@秃鹫2",
    BaseSortID = 1007,
    PotencyName = "AwakerPotency_79024_PotencyName|全知全能",
    PotencyDesc = "AwakerPotency_79024_PotencyDesc|「万物归一」发现的卡牌获得预备 1。",
    AwakerID = 77911,
    PotencyType = "PassiveSkill",
    FrontPotency = 79118,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79103] = {
    ID = 79103,
    CnID = "启灵@秃鹫3",
    BaseSortID = 1008,
    PotencyName = "AwakerPotency_79103_PotencyName|不存在的存在",
    PotencyDesc = "AwakerPotency_79103_PotencyDesc|「基础打击」和「基础防御」使秃鹫获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。",
    AwakerID = 77911,
    PotencyType = "PassiveSkill",
    FrontPotency = 79024,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [79066] = {
    ID = 79066,
    CnID = "启灵@秃鹫人格深化1",
    BaseSortID = 1009,
    PotencyName = "AwakerPotency_79066_PotencyName|人格深化",
    AwakerID = 77911,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79103,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79080] = {
    ID = 79080,
    CnID = "启灵@秃鹫人格深化2",
    BaseSortID = 1010,
    PotencyName = "AwakerPotency_79080_PotencyName|人格深化",
    AwakerID = 77911,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79066,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79047] = {
    ID = 79047,
    CnID = "启灵@秃鹫人格深化3",
    BaseSortID = 1011,
    PotencyName = "AwakerPotency_79047_PotencyName|人格深化",
    AwakerID = 77911,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79080,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79042] = {
    ID = 79042,
    CnID = "启灵@秃鹫人格深化4",
    BaseSortID = 1012,
    PotencyName = "AwakerPotency_79042_PotencyName|无限亿万光辉",
    PotencyDesc = "AwakerPotency_79042_PotencyDesc|秃鹫造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。",
    AwakerID = 77911,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 79047,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79041] = {
    ID = 79041,
    CnID = "启灵@秃鹫人格深化5",
    BaseSortID = 1013,
    PotencyName = "AwakerPotency_79041_PotencyName|人格深化",
    AwakerID = 77911,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79042,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79061] = {
    ID = 79061,
    CnID = "启灵@秃鹫人格深化6",
    BaseSortID = 1014,
    PotencyName = "AwakerPotency_79061_PotencyName|人格深化",
    AwakerID = 77911,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79041,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79043] = {
    ID = 79043,
    CnID = "启灵@秃鹫人格深化7",
    BaseSortID = 1015,
    PotencyName = "AwakerPotency_79043_PotencyName|人格深化",
    AwakerID = 77911,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79061,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79050] = {
    ID = 79050,
    CnID = "启灵@秃鹫人格深化8",
    BaseSortID = 1016,
    PotencyName = "AwakerPotency_79050_PotencyName|人格深化",
    AwakerID = 77911,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79043,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79049] = {
    ID = 79049,
    CnID = "启灵@秃鹫人格深化9",
    BaseSortID = 1017,
    PotencyName = "AwakerPotency_79049_PotencyName|人格深化",
    AwakerID = 77911,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79050,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78952] = {
    ID = 78952,
    CnID = "启灵@秃鹫人格深化10",
    BaseSortID = 1018,
    PotencyName = "AwakerPotency_78952_PotencyName|人格深化",
    AwakerID = 77911,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79049,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78951] = {
    ID = 78951,
    CnID = "启灵@秃鹫人格深化11",
    BaseSortID = 1019,
    PotencyName = "AwakerPotency_78951_PotencyName|人格深化",
    AwakerID = 77911,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 78952,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [78954] = {
    ID = 78954,
    CnID = "启灵@秃鹫人格深化12",
    BaseSortID = 1020,
    PotencyName = "AwakerPotency_78954_PotencyName|人格深化",
    AwakerID = 77911,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 78951,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79039] = {
    ID = 79039,
    CnID = "启灵@亚弗戈蒙1",
    BaseSortID = 1021,
    PotencyName = "AwakerPotency_79039_PotencyName|无穷智慧",
    PotencyDesc = "AwakerPotency_79039_PotencyDesc|「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。",
    AwakerID = 77928,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [79040] = {
    ID = 79040,
    CnID = "启灵@亚弗戈蒙2",
    BaseSortID = 1022,
    PotencyName = "AwakerPotency_79040_PotencyName|全知全能",
    PotencyDesc = "AwakerPotency_79040_PotencyDesc|「万物归一」发现的卡牌获得预备 1。",
    AwakerID = 77928,
    PotencyType = "PassiveSkill",
    FrontPotency = 79039,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79137] = {
    ID = 79137,
    CnID = "启灵@亚弗戈蒙3",
    BaseSortID = 1023,
    PotencyName = "AwakerPotency_79137_PotencyName|不存在的存在",
    PotencyDesc = "AwakerPotency_79137_PotencyDesc|「基础打击」和「基础防御」使亚弗戈蒙获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。",
    AwakerID = 77928,
    PotencyType = "PassiveSkill",
    FrontPotency = 79040,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [79144] = {
    ID = 79144,
    CnID = "启灵@亚弗戈蒙人格深化1",
    BaseSortID = 1024,
    PotencyName = "AwakerPotency_79144_PotencyName|人格深化",
    AwakerID = 77928,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79137,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79146] = {
    ID = 79146,
    CnID = "启灵@亚弗戈蒙人格深化2",
    BaseSortID = 1025,
    PotencyName = "AwakerPotency_79146_PotencyName|人格深化",
    AwakerID = 77928,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79144,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79145] = {
    ID = 79145,
    CnID = "启灵@亚弗戈蒙人格深化3",
    BaseSortID = 1026,
    PotencyName = "AwakerPotency_79145_PotencyName|人格深化",
    AwakerID = 77928,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79146,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79141] = {
    ID = 79141,
    CnID = "启灵@亚弗戈蒙人格深化4",
    BaseSortID = 1027,
    PotencyName = "AwakerPotency_79141_PotencyName|无限亿万光辉",
    PotencyDesc = "AwakerPotency_79141_PotencyDesc|亚弗戈蒙造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。",
    AwakerID = 77928,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 79145,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79140] = {
    ID = 79140,
    CnID = "启灵@亚弗戈蒙人格深化5",
    BaseSortID = 1028,
    PotencyName = "AwakerPotency_79140_PotencyName|人格深化",
    AwakerID = 77928,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79141,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79054] = {
    ID = 79054,
    CnID = "启灵@亚弗戈蒙人格深化6",
    BaseSortID = 1029,
    PotencyName = "AwakerPotency_79054_PotencyName|人格深化",
    AwakerID = 77928,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79140,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79142] = {
    ID = 79142,
    CnID = "启灵@亚弗戈蒙人格深化7",
    BaseSortID = 1030,
    PotencyName = "AwakerPotency_79142_PotencyName|人格深化",
    AwakerID = 77928,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79054,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79035] = {
    ID = 79035,
    CnID = "启灵@亚弗戈蒙人格深化8",
    BaseSortID = 1031,
    PotencyName = "AwakerPotency_79035_PotencyName|人格深化",
    AwakerID = 77928,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79142,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79138] = {
    ID = 79138,
    CnID = "启灵@亚弗戈蒙人格深化9",
    BaseSortID = 1032,
    PotencyName = "AwakerPotency_79138_PotencyName|人格深化",
    AwakerID = 77928,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79035,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79009] = {
    ID = 79009,
    CnID = "启灵@亚弗戈蒙人格深化10",
    BaseSortID = 1033,
    PotencyName = "AwakerPotency_79009_PotencyName|人格深化",
    AwakerID = 77928,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79138,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79008] = {
    ID = 79008,
    CnID = "启灵@亚弗戈蒙人格深化11",
    BaseSortID = 1034,
    PotencyName = "AwakerPotency_79008_PotencyName|人格深化",
    AwakerID = 77928,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79009,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79011] = {
    ID = 79011,
    CnID = "启灵@亚弗戈蒙人格深化12",
    BaseSortID = 1035,
    PotencyName = "AwakerPotency_79011_PotencyName|人格深化",
    AwakerID = 77928,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79008,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79243] = {
    ID = 79243,
    CnID = "启灵@训练模式敌方校猫1",
    BaseSortID = 1036,
    PotencyName = "AwakerPotency_79243_PotencyName|无穷智慧",
    PotencyDesc = "AwakerPotency_79243_PotencyDesc|「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。",
    AwakerID = 78841,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [79242] = {
    ID = 79242,
    CnID = "启灵@训练模式敌方校猫2",
    BaseSortID = 1037,
    PotencyName = "AwakerPotency_79242_PotencyName|全知全能",
    PotencyDesc = "AwakerPotency_79242_PotencyDesc|「万物归一」发现的卡牌获得预备 1。",
    AwakerID = 78841,
    PotencyType = "PassiveSkill",
    FrontPotency = 79243,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79241] = {
    ID = 79241,
    CnID = "启灵@训练模式敌方校猫3",
    BaseSortID = 1038,
    PotencyName = "AwakerPotency_79241_PotencyName|不存在的存在",
    PotencyDesc = "AwakerPotency_79241_PotencyDesc|「基础打击」和「基础防御」使训练模式敌方校猫获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。",
    AwakerID = 78841,
    PotencyType = "PassiveSkill",
    FrontPotency = 79242,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [79232] = {
    ID = 79232,
    CnID = "启灵@训练模式敌方校猫人格深化1",
    BaseSortID = 1039,
    PotencyName = "AwakerPotency_79232_PotencyName|人格深化",
    AwakerID = 78841,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79241,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79230] = {
    ID = 79230,
    CnID = "启灵@训练模式敌方校猫人格深化2",
    BaseSortID = 1040,
    PotencyName = "AwakerPotency_79230_PotencyName|人格深化",
    AwakerID = 78841,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79232,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79231] = {
    ID = 79231,
    CnID = "启灵@训练模式敌方校猫人格深化3",
    BaseSortID = 1041,
    PotencyName = "AwakerPotency_79231_PotencyName|人格深化",
    AwakerID = 78841,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79230,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79228] = {
    ID = 79228,
    CnID = "启灵@训练模式敌方校猫人格深化4",
    BaseSortID = 1042,
    PotencyName = "AwakerPotency_79228_PotencyName|无限亿万光辉",
    PotencyDesc = "AwakerPotency_79228_PotencyDesc|训练模式敌方校猫造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。",
    AwakerID = 78841,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 79231,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79229] = {
    ID = 79229,
    CnID = "启灵@训练模式敌方校猫人格深化5",
    BaseSortID = 1043,
    PotencyName = "AwakerPotency_79229_PotencyName|人格深化",
    AwakerID = 78841,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79228,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79226] = {
    ID = 79226,
    CnID = "启灵@训练模式敌方校猫人格深化6",
    BaseSortID = 1044,
    PotencyName = "AwakerPotency_79226_PotencyName|人格深化",
    AwakerID = 78841,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79229,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79227] = {
    ID = 79227,
    CnID = "启灵@训练模式敌方校猫人格深化7",
    BaseSortID = 1045,
    PotencyName = "AwakerPotency_79227_PotencyName|人格深化",
    AwakerID = 78841,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79226,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79233] = {
    ID = 79233,
    CnID = "启灵@训练模式敌方校猫人格深化8",
    BaseSortID = 1046,
    PotencyName = "AwakerPotency_79233_PotencyName|人格深化",
    AwakerID = 78841,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79227,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79234] = {
    ID = 79234,
    CnID = "启灵@训练模式敌方校猫人格深化9",
    BaseSortID = 1047,
    PotencyName = "AwakerPotency_79234_PotencyName|人格深化",
    AwakerID = 78841,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79233,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79235] = {
    ID = 79235,
    CnID = "启灵@训练模式敌方校猫人格深化10",
    BaseSortID = 1048,
    PotencyName = "AwakerPotency_79235_PotencyName|人格深化",
    AwakerID = 78841,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79234,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79236] = {
    ID = 79236,
    CnID = "启灵@训练模式敌方校猫人格深化11",
    BaseSortID = 1049,
    PotencyName = "AwakerPotency_79236_PotencyName|人格深化",
    AwakerID = 78841,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79235,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79237] = {
    ID = 79237,
    CnID = "启灵@训练模式敌方校猫人格深化12",
    BaseSortID = 1050,
    PotencyName = "AwakerPotency_79237_PotencyName|人格深化",
    AwakerID = 78841,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79236,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79223] = {
    ID = 79223,
    CnID = "启灵@训练模式友方校猫1",
    BaseSortID = 1051,
    PotencyName = "AwakerPotency_79223_PotencyName|无穷智慧",
    PotencyDesc = "AwakerPotency_79223_PotencyDesc|「通晓万物之理」变化的指令卡算力消耗 -1。「纵贯时序之翼」额外将一张「灵感」置入手中。",
    AwakerID = 78840,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [79224] = {
    ID = 79224,
    CnID = "启灵@训练模式友方校猫2",
    BaseSortID = 1052,
    PotencyName = "AwakerPotency_79224_PotencyName|全知全能",
    PotencyDesc = "AwakerPotency_79224_PotencyDesc|「万物归一」发现的卡牌获得预备 1。",
    AwakerID = 78840,
    PotencyType = "PassiveSkill",
    FrontPotency = 79223,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [79225] = {
    ID = 79225,
    CnID = "启灵@训练模式友方校猫3",
    BaseSortID = 1053,
    PotencyName = "AwakerPotency_79225_PotencyName|不存在的存在",
    PotencyDesc = "AwakerPotency_79225_PotencyDesc|「基础打击」和「基础防御」使训练模式友方校猫获得 3％ 暴击率和暴击伤害，至多 30％。探索中首次触发死亡抵抗时，将一张「过往回声」置入手中。",
    AwakerID = 78840,
    PotencyType = "PassiveSkill",
    FrontPotency = 79224,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [79216] = {
    ID = 79216,
    CnID = "启灵@训练模式友方校猫人格深化1",
    BaseSortID = 1054,
    PotencyName = "AwakerPotency_79216_PotencyName|人格深化",
    AwakerID = 78840,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79225,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79218] = {
    ID = 79218,
    CnID = "启灵@训练模式友方校猫人格深化2",
    BaseSortID = 1055,
    PotencyName = "AwakerPotency_79218_PotencyName|人格深化",
    AwakerID = 78840,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79216,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79217] = {
    ID = 79217,
    CnID = "启灵@训练模式友方校猫人格深化3",
    BaseSortID = 1056,
    PotencyName = "AwakerPotency_79217_PotencyName|人格深化",
    AwakerID = 78840,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79218,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79220] = {
    ID = 79220,
    CnID = "启灵@训练模式友方校猫人格深化4",
    BaseSortID = 1057,
    PotencyName = "AwakerPotency_79220_PotencyName|无限亿万光辉",
    PotencyDesc = "AwakerPotency_79220_PotencyDesc|训练模式友方校猫造成的伤害、护盾、生命回复临时提高 35%。改为从 10 张当前界域的技能卡中发现 3 张，并立即获得 3 算力。",
    AwakerID = 78840,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 79217,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79219] = {
    ID = 79219,
    CnID = "启灵@训练模式友方校猫人格深化5",
    BaseSortID = 1058,
    PotencyName = "AwakerPotency_79219_PotencyName|人格深化",
    AwakerID = 78840,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79220,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79222] = {
    ID = 79222,
    CnID = "启灵@训练模式友方校猫人格深化6",
    BaseSortID = 1059,
    PotencyName = "AwakerPotency_79222_PotencyName|人格深化",
    AwakerID = 78840,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79219,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79221] = {
    ID = 79221,
    CnID = "启灵@训练模式友方校猫人格深化7",
    BaseSortID = 1060,
    PotencyName = "AwakerPotency_79221_PotencyName|人格深化",
    AwakerID = 78840,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79222,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79215] = {
    ID = 79215,
    CnID = "启灵@训练模式友方校猫人格深化8",
    BaseSortID = 1061,
    PotencyName = "AwakerPotency_79215_PotencyName|人格深化",
    AwakerID = 78840,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79221,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79214] = {
    ID = 79214,
    CnID = "启灵@训练模式友方校猫人格深化9",
    BaseSortID = 1062,
    PotencyName = "AwakerPotency_79214_PotencyName|人格深化",
    AwakerID = 78840,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79215,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79239] = {
    ID = 79239,
    CnID = "启灵@训练模式友方校猫人格深化10",
    BaseSortID = 1063,
    PotencyName = "AwakerPotency_79239_PotencyName|人格深化",
    AwakerID = 78840,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79214,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79238] = {
    ID = 79238,
    CnID = "启灵@训练模式友方校猫人格深化11",
    BaseSortID = 1064,
    PotencyName = "AwakerPotency_79238_PotencyName|人格深化",
    AwakerID = 78840,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    FrontPotency = 79239,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [79240] = {
    ID = 79240,
    CnID = "启灵@训练模式友方校猫人格深化12",
    BaseSortID = 1065,
    PotencyName = "AwakerPotency_79240_PotencyName|人格深化",
    AwakerID = 78840,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {
      18126,
      2,
      18139,
      2.4
    },
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 79238,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132349] = {
    ID = 132349,
    CnID = "启灵@测试@神秘人1@启灵1",
    BaseSortID = 1066,
    PotencyName = "AwakerPotency_132349_PotencyName|天元之启",
    PotencyDesc = "AwakerPotency_132349_PotencyDesc|「同伴的力量」额外抽 1 张牌。",
    AwakerID = 132340,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [132345] = {
    ID = 132345,
    CnID = "启灵@测试@神秘人1@启灵2",
    BaseSortID = 1067,
    PotencyName = "AwakerPotency_132345_PotencyName|两极之启",
    PotencyDesc = "AwakerPotency_132345_PotencyDesc|「腺体分裂」和「喧嚣海洋」基础伤害提高 100%，造成穿刺伤害。",
    AwakerID = 132340,
    PotencyType = "PassiveSkill",
    FrontPotency = 132349,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [132355] = {
    ID = 132355,
    CnID = "启灵@测试@神秘人1@启灵3",
    BaseSortID = 1068,
    PotencyName = "AwakerPotency_132355_PotencyName|三相之启",
    PotencyDesc = "AwakerPotency_132355_PotencyDesc|「基础防御」抽 1 张牌。每 3 回合，将 1 张附加虚无和消耗的「腺体分裂」加入手中。",
    AwakerID = 132340,
    PotencyType = "PassiveSkill",
    EffectType = "BEAddState",
    Effect = {3705},
    FrontPotency = 132345,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [132352] = {
    ID = 132352,
    CnID = "启灵@测试@神秘人1@特殊人格深化1",
    BaseSortID = 1069,
    PotencyName = "AwakerPotency_132352_PotencyName|人格深化",
    AwakerID = 132340,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132355,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132343] = {
    ID = 132343,
    CnID = "启灵@测试@神秘人1@特殊人格深化2",
    BaseSortID = 1070,
    PotencyName = "AwakerPotency_132343_PotencyName|人格深化",
    AwakerID = 132340,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132352,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132344] = {
    ID = 132344,
    CnID = "启灵@测试@神秘人1@特殊人格深化3",
    BaseSortID = 1071,
    PotencyName = "AwakerPotency_132344_PotencyName|人格深化",
    AwakerID = 132340,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132343,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132350] = {
    ID = 132350,
    CnID = "启灵@测试@神秘人1@特殊人格深化4",
    BaseSortID = 1072,
    PotencyName = "AwakerPotency_132350_PotencyName|超限爆发",
    AwakerID = 132340,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 132344,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132351] = {
    ID = 132351,
    CnID = "启灵@测试@神秘人1@特殊人格深化5",
    BaseSortID = 1073,
    PotencyName = "AwakerPotency_132351_PotencyName|人格深化",
    AwakerID = 132340,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132350,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132341] = {
    ID = 132341,
    CnID = "启灵@测试@神秘人1@特殊人格深化6",
    BaseSortID = 1074,
    PotencyName = "AwakerPotency_132341_PotencyName|人格深化",
    AwakerID = 132340,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132351,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132354] = {
    ID = 132354,
    CnID = "启灵@测试@神秘人1@特殊人格深化7",
    BaseSortID = 1075,
    PotencyName = "AwakerPotency_132354_PotencyName|人格深化",
    AwakerID = 132340,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132341,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132347] = {
    ID = 132347,
    CnID = "启灵@测试@神秘人1@特殊人格深化8",
    BaseSortID = 1076,
    PotencyName = "AwakerPotency_132347_PotencyName|人格深化",
    AwakerID = 132340,
    PotencyType = "Attr_Promote",
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 132354,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132346] = {
    ID = 132346,
    CnID = "启灵@测试@神秘人1@特殊人格深化9",
    BaseSortID = 1077,
    PotencyName = "AwakerPotency_132346_PotencyName|人格深化",
    AwakerID = 132340,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132347,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132348] = {
    ID = 132348,
    CnID = "启灵@测试@神秘人1@特殊人格深化10",
    BaseSortID = 1078,
    PotencyName = "AwakerPotency_132348_PotencyName|人格深化",
    AwakerID = 132340,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132346,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132342] = {
    ID = 132342,
    CnID = "启灵@测试@神秘人1@特殊人格深化11",
    BaseSortID = 1079,
    PotencyName = "AwakerPotency_132342_PotencyName|人格深化",
    AwakerID = 132340,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132348,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132353] = {
    ID = 132353,
    CnID = "启灵@测试@神秘人1@特殊人格深化12",
    BaseSortID = 1080,
    PotencyName = "AwakerPotency_132353_PotencyName|人格深化",
    AwakerID = 132340,
    PotencyType = "Attr_Promote",
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 132342,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132385] = {
    ID = 132385,
    CnID = "启灵@测试@神秘人2@启灵1",
    BaseSortID = 1081,
    PotencyName = "AwakerPotency_132385_PotencyName|天元之启",
    PotencyDesc = "AwakerPotency_132385_PotencyDesc|「同伴的力量」额外抽 1 张牌。",
    AwakerID = 132376,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [132383] = {
    ID = 132383,
    CnID = "启灵@测试@神秘人2@启灵2",
    BaseSortID = 1082,
    PotencyName = "AwakerPotency_132383_PotencyName|两极之启",
    PotencyDesc = "AwakerPotency_132383_PotencyDesc|「腺体分裂」和「喧嚣海洋」基础伤害提高 100%，造成穿刺伤害。",
    AwakerID = 132376,
    PotencyType = "PassiveSkill",
    FrontPotency = 132385,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [132417] = {
    ID = 132417,
    CnID = "启灵@测试@神秘人2@启灵3",
    BaseSortID = 1083,
    PotencyName = "AwakerPotency_132417_PotencyName|三相之启",
    PotencyDesc = "AwakerPotency_132417_PotencyDesc|「基础防御」抽 1 张牌。每 3 回合，将 1 张附加虚无和消耗的「腺体分裂」加入手中。",
    AwakerID = 132376,
    PotencyType = "PassiveSkill",
    EffectType = "BEAddState",
    Effect = {3705},
    FrontPotency = 132383,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [132390] = {
    ID = 132390,
    CnID = "启灵@测试@神秘人2@特殊人格深化1",
    BaseSortID = 1084,
    PotencyName = "AwakerPotency_132390_PotencyName|人格深化",
    AwakerID = 132376,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132417,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132421] = {
    ID = 132421,
    CnID = "启灵@测试@神秘人2@特殊人格深化2",
    BaseSortID = 1085,
    PotencyName = "AwakerPotency_132421_PotencyName|人格深化",
    AwakerID = 132376,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132390,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132407] = {
    ID = 132407,
    CnID = "启灵@测试@神秘人2@特殊人格深化3",
    BaseSortID = 1086,
    PotencyName = "AwakerPotency_132407_PotencyName|人格深化",
    AwakerID = 132376,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132421,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132393] = {
    ID = 132393,
    CnID = "启灵@测试@神秘人2@特殊人格深化4",
    BaseSortID = 1087,
    PotencyName = "AwakerPotency_132393_PotencyName|超限爆发",
    AwakerID = 132376,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 132407,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132416] = {
    ID = 132416,
    CnID = "启灵@测试@神秘人2@特殊人格深化5",
    BaseSortID = 1088,
    PotencyName = "AwakerPotency_132416_PotencyName|人格深化",
    AwakerID = 132376,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132393,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132401] = {
    ID = 132401,
    CnID = "启灵@测试@神秘人2@特殊人格深化6",
    BaseSortID = 1089,
    PotencyName = "AwakerPotency_132401_PotencyName|人格深化",
    AwakerID = 132376,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132416,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132391] = {
    ID = 132391,
    CnID = "启灵@测试@神秘人2@特殊人格深化7",
    BaseSortID = 1090,
    PotencyName = "AwakerPotency_132391_PotencyName|人格深化",
    AwakerID = 132376,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132401,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132388] = {
    ID = 132388,
    CnID = "启灵@测试@神秘人2@特殊人格深化8",
    BaseSortID = 1091,
    PotencyName = "AwakerPotency_132388_PotencyName|人格深化",
    AwakerID = 132376,
    PotencyType = "Attr_Promote",
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 132391,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132412] = {
    ID = 132412,
    CnID = "启灵@测试@神秘人2@特殊人格深化9",
    BaseSortID = 1092,
    PotencyName = "AwakerPotency_132412_PotencyName|人格深化",
    AwakerID = 132376,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132388,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132408] = {
    ID = 132408,
    CnID = "启灵@测试@神秘人2@特殊人格深化10",
    BaseSortID = 1093,
    PotencyName = "AwakerPotency_132408_PotencyName|人格深化",
    AwakerID = 132376,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132412,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132380] = {
    ID = 132380,
    CnID = "启灵@测试@神秘人2@特殊人格深化11",
    BaseSortID = 1094,
    PotencyName = "AwakerPotency_132380_PotencyName|人格深化",
    AwakerID = 132376,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132408,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132409] = {
    ID = 132409,
    CnID = "启灵@测试@神秘人2@特殊人格深化12",
    BaseSortID = 1095,
    PotencyName = "AwakerPotency_132409_PotencyName|人格深化",
    AwakerID = 132376,
    PotencyType = "Attr_Promote",
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 132380,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132389] = {
    ID = 132389,
    CnID = "启灵@测试@神秘人3@启灵1",
    BaseSortID = 1096,
    PotencyName = "AwakerPotency_132389_PotencyName|天元之启",
    PotencyDesc = "AwakerPotency_132389_PotencyDesc|「同伴的力量」额外抽 1 张牌。",
    AwakerID = 132374,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [132384] = {
    ID = 132384,
    CnID = "启灵@测试@神秘人3@启灵2",
    BaseSortID = 1097,
    PotencyName = "AwakerPotency_132384_PotencyName|两极之启",
    PotencyDesc = "AwakerPotency_132384_PotencyDesc|「腺体分裂」和「喧嚣海洋」基础伤害提高 100%，造成穿刺伤害。",
    AwakerID = 132374,
    PotencyType = "PassiveSkill",
    FrontPotency = 132389,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [132410] = {
    ID = 132410,
    CnID = "启灵@测试@神秘人3@启灵3",
    BaseSortID = 1098,
    PotencyName = "AwakerPotency_132410_PotencyName|三相之启",
    PotencyDesc = "AwakerPotency_132410_PotencyDesc|「基础防御」抽 1 张牌。每 3 回合，将 1 张附加虚无和消耗的「腺体分裂」加入手中。",
    AwakerID = 132374,
    PotencyType = "PassiveSkill",
    EffectType = "BEAddState",
    Effect = {3705},
    FrontPotency = 132384,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [132395] = {
    ID = 132395,
    CnID = "启灵@测试@神秘人3@特殊人格深化1",
    BaseSortID = 1099,
    PotencyName = "AwakerPotency_132395_PotencyName|人格深化",
    AwakerID = 132374,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132410,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132392] = {
    ID = 132392,
    CnID = "启灵@测试@神秘人3@特殊人格深化2",
    BaseSortID = 1100,
    PotencyName = "AwakerPotency_132392_PotencyName|人格深化",
    AwakerID = 132374,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132395,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132396] = {
    ID = 132396,
    CnID = "启灵@测试@神秘人3@特殊人格深化3",
    BaseSortID = 1101,
    PotencyName = "AwakerPotency_132396_PotencyName|人格深化",
    AwakerID = 132374,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132392,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132378] = {
    ID = 132378,
    CnID = "启灵@测试@神秘人3@特殊人格深化4",
    BaseSortID = 1102,
    PotencyName = "AwakerPotency_132378_PotencyName|超限爆发",
    AwakerID = 132374,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 132396,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132379] = {
    ID = 132379,
    CnID = "启灵@测试@神秘人3@特殊人格深化5",
    BaseSortID = 1103,
    PotencyName = "AwakerPotency_132379_PotencyName|人格深化",
    AwakerID = 132374,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132378,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132381] = {
    ID = 132381,
    CnID = "启灵@测试@神秘人3@特殊人格深化6",
    BaseSortID = 1104,
    PotencyName = "AwakerPotency_132381_PotencyName|人格深化",
    AwakerID = 132374,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132379,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132386] = {
    ID = 132386,
    CnID = "启灵@测试@神秘人3@特殊人格深化7",
    BaseSortID = 1105,
    PotencyName = "AwakerPotency_132386_PotencyName|人格深化",
    AwakerID = 132374,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132381,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132415] = {
    ID = 132415,
    CnID = "启灵@测试@神秘人3@特殊人格深化8",
    BaseSortID = 1106,
    PotencyName = "AwakerPotency_132415_PotencyName|人格深化",
    AwakerID = 132374,
    PotencyType = "Attr_Promote",
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 132386,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132399] = {
    ID = 132399,
    CnID = "启灵@测试@神秘人3@特殊人格深化9",
    BaseSortID = 1107,
    PotencyName = "AwakerPotency_132399_PotencyName|人格深化",
    AwakerID = 132374,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132415,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132402] = {
    ID = 132402,
    CnID = "启灵@测试@神秘人3@特殊人格深化10",
    BaseSortID = 1108,
    PotencyName = "AwakerPotency_132402_PotencyName|人格深化",
    AwakerID = 132374,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132399,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132418] = {
    ID = 132418,
    CnID = "启灵@测试@神秘人3@特殊人格深化11",
    BaseSortID = 1109,
    PotencyName = "AwakerPotency_132418_PotencyName|人格深化",
    AwakerID = 132374,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132402,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132405] = {
    ID = 132405,
    CnID = "启灵@测试@神秘人3@特殊人格深化12",
    BaseSortID = 1110,
    PotencyName = "AwakerPotency_132405_PotencyName|人格深化",
    AwakerID = 132374,
    PotencyType = "Attr_Promote",
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 132418,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132387] = {
    ID = 132387,
    CnID = "启灵@测试@神秘人4@启灵1",
    BaseSortID = 1111,
    PotencyName = "AwakerPotency_132387_PotencyName|天元之启",
    PotencyDesc = "AwakerPotency_132387_PotencyDesc|「同伴的力量」额外抽 1 张牌。",
    AwakerID = 132375,
    PotencyType = "PassiveSkill",
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit.png",
    IfMaxPotency = false
  },
  [132414] = {
    ID = 132414,
    CnID = "启灵@测试@神秘人4@启灵2",
    BaseSortID = 1112,
    PotencyName = "AwakerPotency_132414_PotencyName|两极之启",
    PotencyDesc = "AwakerPotency_132414_PotencyDesc|「腺体分裂」和「喧嚣海洋」基础伤害提高 100%，造成穿刺伤害。",
    AwakerID = 132375,
    PotencyType = "PassiveSkill",
    FrontPotency = 132387,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_atk_increase.png",
    IfMaxPotency = false
  },
  [132398] = {
    ID = 132398,
    CnID = "启灵@测试@神秘人4@启灵3",
    BaseSortID = 1113,
    PotencyName = "AwakerPotency_132398_PotencyName|三相之启",
    PotencyDesc = "AwakerPotency_132398_PotencyDesc|「基础防御」抽 1 张牌。每 3 回合，将 1 张附加虚无和消耗的「腺体分裂」加入手中。",
    AwakerID = 132375,
    PotencyType = "PassiveSkill",
    EffectType = "BEAddState",
    Effect = {3705},
    FrontPotency = 132414,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_ene_passive.png",
    IfMaxPotency = false
  },
  [132413] = {
    ID = 132413,
    CnID = "启灵@测试@神秘人4@特殊人格深化1",
    BaseSortID = 1114,
    PotencyName = "AwakerPotency_132413_PotencyName|人格深化",
    AwakerID = 132375,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132398,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132377] = {
    ID = 132377,
    CnID = "启灵@测试@神秘人4@特殊人格深化2",
    BaseSortID = 1115,
    PotencyName = "AwakerPotency_132377_PotencyName|人格深化",
    AwakerID = 132375,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132413,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132406] = {
    ID = 132406,
    CnID = "启灵@测试@神秘人4@特殊人格深化3",
    BaseSortID = 1116,
    PotencyName = "AwakerPotency_132406_PotencyName|人格深化",
    AwakerID = 132375,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132377,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132404] = {
    ID = 132404,
    CnID = "启灵@测试@神秘人4@特殊人格深化4",
    BaseSortID = 1117,
    PotencyName = "AwakerPotency_132404_PotencyName|超限爆发",
    AwakerID = 132375,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    EffectType1 = "UtlSkill_Promote",
    FrontPotency = 132406,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132419] = {
    ID = 132419,
    CnID = "启灵@测试@神秘人4@特殊人格深化5",
    BaseSortID = 1118,
    PotencyName = "AwakerPotency_132419_PotencyName|人格深化",
    AwakerID = 132375,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132404,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132400] = {
    ID = 132400,
    CnID = "启灵@测试@神秘人4@特殊人格深化6",
    BaseSortID = 1119,
    PotencyName = "AwakerPotency_132400_PotencyName|人格深化",
    AwakerID = 132375,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132419,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132382] = {
    ID = 132382,
    CnID = "启灵@测试@神秘人4@特殊人格深化7",
    BaseSortID = 1120,
    PotencyName = "AwakerPotency_132382_PotencyName|人格深化",
    AwakerID = 132375,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132400,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132420] = {
    ID = 132420,
    CnID = "启灵@测试@神秘人4@特殊人格深化8",
    BaseSortID = 1121,
    PotencyName = "AwakerPotency_132420_PotencyName|人格深化",
    AwakerID = 132375,
    PotencyType = "Attr_Promote",
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 132382,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132411] = {
    ID = 132411,
    CnID = "启灵@测试@神秘人4@特殊人格深化9",
    BaseSortID = 1122,
    PotencyName = "AwakerPotency_132411_PotencyName|人格深化",
    AwakerID = 132375,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132420,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132397] = {
    ID = 132397,
    CnID = "启灵@测试@神秘人4@特殊人格深化10",
    BaseSortID = 1123,
    PotencyName = "AwakerPotency_132397_PotencyName|人格深化",
    AwakerID = 132375,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132411,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132403] = {
    ID = 132403,
    CnID = "启灵@测试@神秘人4@特殊人格深化11",
    BaseSortID = 1124,
    PotencyName = "AwakerPotency_132403_PotencyName|人格深化",
    AwakerID = 132375,
    PotencyType = "Attr_Promote",
    EffectType = "Attr_Promote",
    Effect = {18105, 5},
    FrontPotency = 132397,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  },
  [132394] = {
    ID = 132394,
    CnID = "启灵@测试@神秘人4@特殊人格深化12",
    BaseSortID = 1125,
    PotencyName = "AwakerPotency_132394_PotencyName|人格深化",
    AwakerID = 132375,
    PotencyType = "Attr_Promote",
    EffectType1 = "LevelLimit_Promote",
    Effect1 = {5},
    FrontPotency = 132403,
    PotencyIcon = "UIResources/AtlasSource/2_Icon/Awaker_Potential/UI_Character_Potency_actor_crit_damage.png",
    IfMaxPotency = false
  }
})
return AwakerPotency
