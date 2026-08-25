local System = require("System.System")
local readonly = System.readonly
local CardType = readonly({
  [18628] = {
    ID = 18628,
    CnID = "Card_Strike",
    BaseSortID = 1,
    TypeName = "CardType_18628_TypeName|指令",
    CardNameColor = "#c9d7db",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#ffffff",
      "#b9ffe7",
      "#f4e2f9"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Attack.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Silver.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Gold.png"
  },
  [18629] = {
    ID = 18629,
    CnID = "Card_Defend",
    BaseSortID = 2,
    TypeName = "CardType_18629_TypeName|指令",
    CardNameColor = "#c9d7db",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#ffffff",
      "#b9ffe7",
      "#f4e2f9"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Defence.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Silver.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Gold.png"
  },
  [18627] = {
    ID = 18627,
    CnID = "Card_Awake",
    BaseSortID = 3,
    TypeName = "CardType_18627_TypeName|灵知觉醒",
    CardNameColor = "#3f3b2f",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#000000",
      "#2e9d6a",
      "#ab57b2"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Ability.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Exclusive_Skill_Gold.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Exclusive_Skill_Gold.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Exclusive_Skill_Gold.png"
  },
  [18634] = {
    ID = 18634,
    CnID = "Card_Skill",
    BaseSortID = 4,
    TypeName = "CardType_18634_TypeName|指令",
    CardNameColor = "#c9d7db",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#ffffff",
      "#b9ffe7",
      "#f4e2f9"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Skill.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Silver.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Gold.png"
  },
  [18631] = {
    ID = 18631,
    CnID = "Card_Curse",
    BaseSortID = 5,
    TypeName = "CardType_18631_TypeName|症状",
    CardNameColor = "#c9d7db",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#ffffff",
      "#b9ffe7",
      "#f4e2f9"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Curse.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png"
  },
  [18632] = {
    ID = 18632,
    CnID = "Card_State",
    BaseSortID = 6,
    TypeName = "CardType_18632_TypeName|状态",
    CardNameColor = "#c9d7db",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#ffffff",
      "#b9ffe7",
      "#f4e2f9"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Condition.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png"
  },
  [18630] = {
    ID = 18630,
    CnID = "Card_Potion",
    BaseSortID = 7,
    TypeName = "CardType_18630_TypeName|增益",
    CardNameColor = "#c9d7db",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#ffffff",
      "#b9ffe7",
      "#f4e2f9"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Skill.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Silver.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Gold.png"
  },
  [18635] = {
    ID = 18635,
    CnID = "Card_Weapon",
    BaseSortID = 8,
    TypeName = "CardType_18635_TypeName|命轮",
    CardNameColor = "#c9d7db",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#ffffff",
      "#b9ffe7",
      "#f4e2f9"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Condition.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png"
  },
  [18633] = {
    ID = 18633,
    CnID = "Card_KeeperSkill",
    BaseSortID = 9,
    TypeName = "CardType_18633_TypeName|钥令",
    CardNameColor = "#c9d7db",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#ffffff",
      "#b9ffe7",
      "#f4e2f9"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Skill.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Silver.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Gold.png"
  },
  [21763] = {
    ID = 21763,
    CnID = "Card_Developing",
    BaseSortID = 10,
    TypeName = "CardType_21763_TypeName|开发中",
    CardNameColor = "#c9d7db",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#ffffff",
      "#b9ffe7",
      "#f4e2f9"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Skill.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Silver.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Gold.png"
  },
  [25169] = {
    ID = 25169,
    CnID = "Card_Extend",
    BaseSortID = 11,
    TypeName = "CardType_25169_TypeName|衍生指令",
    CardNameColor = "#c9d7db",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#ffffff",
      "#b9ffe7",
      "#f4e2f9"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Skill.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Silver.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Gold.png"
  },
  [48143] = {
    ID = 48143,
    CnID = "Ulti_Skill",
    BaseSortID = 12,
    TypeName = "CardType_48143_TypeName|狂气爆发",
    CardNameColor = "#3f3b2f",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#000000",
      "#2e9d6a",
      "#ab57b2"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Attack.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Exclusive_Skill_Gold.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Silver.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Gold.png"
  },
  [56100] = {
    ID = 56100,
    CnID = "Card_Imagery",
    BaseSortID = 13,
    TypeName = "CardType_56100_TypeName|意象",
    CardNameColor = "#c9d7db",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#ffffff",
      "#b9ffe7",
      "#f4e2f9"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Attack.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Silver.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Gold.png"
  },
  [56098] = {
    ID = 56098,
    CnID = "Card_AdvancedImagery",
    BaseSortID = 14,
    TypeName = "CardType_56098_TypeName|高级意象",
    CardNameColor = "#c9d7db",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#ffffff",
      "#b9ffe7",
      "#f4e2f9"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Attack.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Silver.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Gold.png"
  },
  [146032] = {
    ID = 146032,
    CnID = "Card_Fraud",
    BaseSortID = 15,
    TypeName = "CardType_146032_TypeName|欺诈",
    CardNameColor = "#c9d7db",
    CardDescColor = "#def3f9",
    CostColorList = {
      "#ffffff",
      "#b9ffe7",
      "#f4e2f9"
    },
    Icon = "UIResources/AtlasSource/2_Icon/CardType/UC_CardType_Curse.png",
    QualityFrame1 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame3 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png",
    QualityFrame5 = "UIResources/AtlasSource/2_Icon/CardQuality/UI_Card_Frame_Skill_Cu.png"
  }
})
return CardType
