local System = require("System.System")
local readonly = System.readonly
local WordsEffectConfig = readonly({
  color1 = {
    Text = "color1",
    Remark = "棕色变色",
    Color = "OldColor1,Light",
    Bold = 0,
    Italic = 0
  },
  color2 = {
    Text = "color2",
    Remark = "绿色变色",
    Color = "OldColor2,Light",
    Bold = 0,
    Italic = 0
  },
  effect1 = {
    Text = "effect1",
    Remark = "卡牌正常关键字：棕色变色+下划线",
    Color = "OldColor1,Light",
    Bold = 1,
    Italic = 1,
    Size = 23
  },
  effect3 = {
    Text = "effect3",
    Remark = "卡牌数值降低",
    Img = "1f60b"
  },
  CardTip = {
    Text = "CardTip",
    Remark = "卡牌关键词",
    Color = "A,Dark",
    Size = 32
  },
  CardDesc = {
    Text = "CardDesc",
    Remark = "卡牌描述_关键词",
    Color = "OldColor8,Light"
  },
  B = {
    Text = "B",
    Remark = "加粗",
    Bold = 1,
    Italic = 0
  },
  WordSize20 = {
    Text = "WordSize20",
    Remark = "20号字",
    Size = 20
  },
  BigItalicBold = {
    Text = "BigItalicBold",
    Remark = "放大斜体加粗",
    Bold = 1,
    Italic = 1,
    Size = 56
  },
  D05EX_Relic = {
    Text = "D05EX_Relic",
    Remark = "本源希洛造物故事文本",
    Color = "GrayState"
  },
  Color3 = {
    Text = "Color3",
    Remark = "蓝绿色-唤醒体技能",
    Color = "D,Light"
  },
  CardUpdate = {
    Text = "CardUpdate",
    Remark = "卡牌升级_变化量",
    Color = "D,Dark"
  },
  LevelNum0 = {
    Text = "LevelNum0",
    Remark = "角色等级数字",
    Img = "Number1_0",
    ImgPath = "Number1"
  },
  LevelNum1 = {
    Text = "LevelNum1",
    Remark = "角色等级数字",
    Img = "Number1_1",
    ImgPath = "Number1"
  },
  LevelNum2 = {
    Text = "LevelNum2",
    Remark = "角色等级数字",
    Img = "Number1_2",
    ImgPath = "Number1"
  },
  LevelNum3 = {
    Text = "LevelNum3",
    Remark = "角色等级数字",
    Img = "Number1_3",
    ImgPath = "Number1"
  },
  LevelNum4 = {
    Text = "LevelNum4",
    Remark = "角色等级数字",
    Img = "Number1_4",
    ImgPath = "Number1"
  },
  LevelNum5 = {
    Text = "LevelNum5",
    Remark = "角色等级数字",
    Img = "Number1_5",
    ImgPath = "Number1"
  },
  LevelNum6 = {
    Text = "LevelNum6",
    Remark = "角色等级数字",
    Img = "Number1_6",
    ImgPath = "Number1"
  },
  LevelNum7 = {
    Text = "LevelNum7",
    Remark = "角色等级数字",
    Img = "Number1_7",
    ImgPath = "Number1"
  },
  LevelNum8 = {
    Text = "LevelNum8",
    Remark = "角色等级数字",
    Img = "Number1_8",
    ImgPath = "Number1"
  },
  LevelNum9 = {
    Text = "LevelNum9",
    Remark = "角色等级数字",
    Img = "Number1_9",
    ImgPath = "Number1"
  },
  Color4 = {
    Text = "Color4",
    Remark = "道具不足",
    Color = "OldColor3,Light"
  },
  Color5 = {
    Text = "Color5",
    Remark = "荧光绿",
    Color = "OldColor4,Light"
  },
  Color6 = {
    Text = "Color6",
    Remark = "掉落道具数量",
    Color = "OldColor5,Light"
  },
  Color7 = {
    Text = "Color7",
    Remark = "小循环描述字色",
    Color = "OldColor6,Light"
  },
  Card1 = {
    Text = "Card1",
    Remark = "卡牌数值升高",
    Color = "D,Light"
  },
  Card2 = {
    Text = "Card2",
    Remark = "卡牌数值正常",
    Color = "OldColor8,Light"
  },
  Card3 = {
    Text = "Card3",
    Remark = "卡牌数值降低",
    Color = "E,Light"
  },
  Shop1 = {
    Text = "Shop1",
    Remark = "商店价格字色",
    Color = "B,Dark"
  },
  Shop2 = {
    Text = "Shop2",
    Remark = "商店价格打折后原价字色",
    Color = "OldColor4,Light"
  },
  Shop3 = {
    Text = "Shop3",
    Remark = "商店价格货币不足字色",
    Color = "E,Light"
  },
  CopyTask1 = {
    Text = "CopyTask1",
    Remark = "课题分未激活",
    Color = "C,Dark"
  },
  CopyTask2 = {
    Text = "CopyTask2",
    Remark = "课题分已激活",
    Color = "D,Dark"
  },
  Negative = {
    Text = "Negative",
    Remark = "负面效果字体",
    Color = "E,Light"
  },
  Positive = {
    Text = "Positive",
    Remark = "正面效果字体",
    Color = "D,Dark"
  },
  BuffTip = {
    Text = "BuffTip",
    Remark = "Buff描述-数值强调",
    Color = "OldColor8,Light"
  },
  BuffTipNe = {
    Text = "BuffTipNe",
    Remark = "Buff描述-负面",
    Color = "E,Light"
  },
  BuffTipPo = {
    Text = "BuffTipPo",
    Remark = "Buff描述-正面",
    Color = "D,Light"
  },
  BuffTipBlock = {
    Text = "BuffTipBlock",
    Remark = "Buff描述-护盾",
    Color = "D,Light"
  },
  BuffTipDamage = {
    Text = "BuffTipDamage",
    Remark = "Buff描述-伤害",
    Color = "E,Light"
  },
  UIUseable = {
    Text = "UIUseable",
    Remark = "UI可用状态-蓝色",
    Color = "D,Dark"
  },
  MoneyIcon1 = {
    Text = "MoneyIcon1",
    Remark = "脑石小图标",
    Img = "UI_Coin_Sprite_0",
    ImgPath = "UI_Coin_Sprite"
  },
  MoneyIcon2 = {
    Text = "MoneyIcon2",
    Remark = "铸币小图标",
    Img = "UI_Coin_Sprite_6",
    ImgPath = "UI_Coin_Sprite"
  },
  MoneyIcon3 = {
    Text = "MoneyIcon3",
    Remark = "黑晶小图标",
    Img = "UI_Coin_Sprite_2",
    ImgPath = "UI_Coin_Sprite"
  },
  MoneyIcon4 = {
    Text = "MoneyIcon4",
    Remark = "贤石小图标",
    Img = "UI_Coin_Sprite_3",
    ImgPath = "UI_Coin_Sprite"
  },
  MoneyIcon5 = {
    Text = "MoneyIcon5",
    Remark = "抽卡币币图标",
    Img = "UI_Coin_Sprite_4",
    ImgPath = "UI_Coin_Sprite"
  },
  MoneyIcon10 = {
    Text = "MoneyIcon10",
    Remark = "竞技场币小图标",
    Img = "UI_Coin_Sprite_7",
    ImgPath = "UI_Coin_Sprite"
  },
  MoneyIcon11 = {
    Text = "MoneyIcon11",
    Remark = "抽卡币币图标",
    Img = "UI_Coin_Sprite_8",
    ImgPath = "UI_Coin_Sprite"
  },
  PotencyUnlock = {
    Text = "PotencyUnlock",
    Remark = "唤醒体潜力激活颜色",
    Color = "A,Light"
  },
  PotencyLock = {
    Text = "PotencyLock",
    Remark = "唤醒体潜力未激活颜色",
    Color = "C,Dark"
  },
  ActorSkillNum = {
    Text = "ActorSkillNum",
    Remark = "唤醒体技能升级数字颜色",
    Color = "D,Dark"
  },
  Del = {
    Text = "Del",
    Remark = "删除线",
    DelLine = 1
  },
  OptionHighlight = {
    Text = "OptionHighlight",
    Remark = "副本选项文本高亮",
    Color = "OptionHighlight,Light"
  },
  OptionHighlight_Dadly = {
    Text = "OptionHighlight_Dadly",
    Remark = "幻梦深潜倍率高亮",
    Color = "OptionHighlight,Light",
    Size = 32
  },
  CardNameColor1 = {
    Text = "CardNameColor1",
    Remark = "职业卡卡牌名称",
    Color = "CardNameColor,Light",
    Bold = 1
  },
  CardDescColor1 = {
    Text = "CardDescColor1",
    Remark = "职业卡卡牌描述",
    Color = "CardDescColor,Light"
  },
  CardNameColor2 = {
    Text = "CardNameColor2",
    Remark = "专属卡卡牌名称",
    Color = "CardNameColor,Dark",
    Bold = 1
  },
  CardDescColor2 = {
    Text = "CardDescColor2",
    Remark = "专属卡卡牌描述",
    Color = "CardDescColor,Dark"
  },
  BuffLink = {
    Text = "BuffLink",
    Remark = "Buff超链",
    Link = "Buff"
  },
  ItemLink = {
    Text = "ItemLink",
    Remark = "道具超链接",
    Link = "ItemConfig"
  },
  SkillLink = {
    Text = "SkillLink",
    Remark = "技能超链接",
    Link = "ActorSkill"
  },
  WhiteQuality = {
    Text = "WhiteQuality",
    Remark = "白色品质",
    Color = "WhiteQuality,Dark"
  },
  GreenQuality = {
    Text = "GreenQuality",
    Remark = "绿色品质",
    Color = "GreenQuality,Dark"
  },
  BlueQuality = {
    Text = "BlueQuality",
    Remark = "蓝色品质",
    Color = "BlueQuality,Dark"
  },
  OrangeQuality = {
    Text = "OrangeQuality",
    Remark = "橙色品质",
    Color = "OrangeQuality,Dark"
  },
  SchoolQuialty = {
    Text = "SchoolQuialty",
    Remark = "职业品质",
    Color = "SchoolQuialty,Dark"
  },
  OldColor3 = {
    Text = "OldColor3",
    Remark = "卡牌关键字",
    Color = "OldColor3"
  },
  Yellow = {
    Text = "Yellow",
    Remark = "淡黄色",
    Color = "Yellow,Light"
  },
  RedQuality = {
    Text = "RedQuality",
    Remark = "红色品质",
    Color = "RedQuality,Dark"
  },
  AttrGreen = {
    Text = "AttrGreen",
    Remark = "属性增加绿色（养成用）",
    Color = "AttrGreen,Light"
  },
  ["36"] = {
    Text = "36",
    Remark = "字号",
    Size = 36
  },
  Blue = {
    Text = "Blue",
    Remark = "深蓝色",
    Color = "Blue,Light"
  },
  Monster1 = {Text = "Monster1", Size = 24},
  Monster2 = {Text = "Monster2", Size = 28},
  TrinketSuitOn = {
    Text = "TrinketSuitOn",
    Remark = "饰品套装效果激活",
    Color = "TrinketSuitOn,Light"
  },
  TrinketSuitOff = {
    Text = "TrinketSuitOff",
    Remark = "饰品套装效果未激活",
    Color = "TrinketSuitOff,Light"
  },
  Shake = {Text = "Shake", Shake = 1},
  Green = {Text = "Green", Color = "greenword"},
  Purple = {Text = "Purple", Color = "Purple"},
  Star = {
    Text = "Star",
    Remark = "星级",
    Img = "UI_Coin_Sprite_9",
    ImgPath = "UI_Coin_Sprite"
  },
  Rune_3 = {
    Text = "Rune_3",
    Remark = "妙手附魔词缀",
    Color = "whiteword"
  },
  Rune_4 = {
    Text = "Rune_4",
    Remark = "筹算附魔词缀",
    Color = "whiteword"
  },
  Rune_5 = {
    Text = "Rune_5",
    Remark = "狂化附魔词缀",
    Color = "yellowword"
  },
  Rune_1 = {
    Text = "Rune_1",
    Remark = "易伤附魔词缀",
    Color = "redword"
  },
  Rune_2 = {
    Text = "Rune_2",
    Remark = "虚弱附魔词缀",
    Color = "purpleword"
  },
  Rune_6 = {
    Text = "Rune_6",
    Remark = "铁壁附魔词缀",
    Color = "blueword"
  },
  Rune_7 = {
    Text = "Rune_7",
    Remark = "回声附魔词缀",
    Color = "whiteword"
  },
  Rune_8 = {
    Text = "Rune_8",
    Remark = "镜像附魔词缀",
    Color = "whiteword"
  },
  Rune_9 = {
    Text = "Rune_9",
    Remark = "尖刺附魔词缀",
    Color = "blueword"
  },
  Rune_10 = {
    Text = "Rune_10",
    Remark = "毒素附魔词缀",
    Color = "purpleword"
  },
  Rune_11 = {
    Text = "Rune_11",
    Remark = "统御附魔词缀",
    Color = "blueword"
  },
  Rune_12 = {
    Text = "Rune_12",
    Remark = "嗜血附魔词缀",
    Color = "redword"
  },
  Rune_13 = {
    Text = "Rune_13",
    Remark = "折跃附魔词缀",
    Color = "purpleword"
  },
  Rune_14 = {
    Text = "Rune_14",
    Remark = "蛮力附魔词缀",
    Color = "greenword"
  },
  Rune_15 = {
    Text = "Rune_15",
    Remark = "爆发附魔词缀",
    Color = "greenword"
  },
  Rune_16 = {
    Text = "Rune_16",
    Remark = "催化附魔词缀",
    Color = "yellowword"
  },
  Rune_17 = {
    Text = "Rune_17",
    Remark = "灵感附魔词缀",
    Color = "whiteword"
  },
  Rune_18 = {
    Text = "Rune_18",
    Remark = "衰竭附魔词缀",
    Color = "purpleword"
  },
  Rune_19 = {
    Text = "Rune_19",
    Remark = "合奏附魔词缀",
    Color = "orangeword"
  },
  Rune_20 = {
    Text = "Rune_20",
    Remark = "渊海回声附魔词缀",
    Color = "blueword"
  },
  Rune_3_High = {
    Text = "Rune_3_High",
    Remark = "高级妙手附魔词缀",
    Color = "whiteword"
  },
  Rune_4_High = {
    Text = "Rune_4_High",
    Remark = "高级筹算附魔词缀",
    Color = "whiteword"
  },
  Rune_5_High = {
    Text = "Rune_5_High",
    Remark = "高级狂化附魔词缀",
    Color = "yellowword"
  },
  Rune_1_High = {
    Text = "Rune_1_High",
    Remark = "高级易伤附魔词缀",
    Color = "redword"
  },
  Rune_2_High = {
    Text = "Rune_2_High",
    Remark = "高级虚弱附魔词缀",
    Color = "purpleword"
  },
  Rune_6_High = {
    Text = "Rune_6_High",
    Remark = "高级铁壁附魔词缀",
    Color = "blueword"
  },
  Rune_7_High = {
    Text = "Rune_7_High",
    Remark = "高级回声附魔词缀",
    Color = "whiteword"
  },
  Rune_8_High = {
    Text = "Rune_8_High",
    Remark = "高级镜像附魔词缀",
    Color = "whiteword"
  },
  Rune_9_High = {
    Text = "Rune_9_High",
    Remark = "高级尖刺附魔词缀",
    Color = "blueword"
  },
  Rune_10_High = {
    Text = "Rune_10_High",
    Remark = "高级毒素附魔词缀",
    Color = "purpleword"
  },
  Rune_11_High = {
    Text = "Rune_11_High",
    Remark = "高级统御附魔词缀",
    Color = "blueword"
  },
  Rune_12_High = {
    Text = "Rune_12_High",
    Remark = "高级嗜血附魔词缀",
    Color = "redword"
  },
  Rune_13_High = {
    Text = "Rune_13_High",
    Remark = "高级折跃附魔词缀",
    Color = "purpleword"
  },
  Rune_14_High = {
    Text = "Rune_14_High",
    Remark = "高级蛮力附魔词缀",
    Color = "greenword"
  },
  Rune_15_High = {
    Text = "Rune_15_High",
    Remark = "高级爆发附魔词缀",
    Color = "greenword"
  },
  Rune_16_High = {
    Text = "Rune_16_High",
    Remark = "高级催化附魔词缀",
    Color = "yellowword"
  },
  Rune_17_High = {
    Text = "Rune_17_High",
    Remark = "高级灵感附魔词缀",
    Color = "whiteword"
  },
  Rune_18_High = {
    Text = "Rune_18_High",
    Remark = "高级衰竭附魔词缀",
    Color = "purpleword"
  },
  Rune_19_High = {
    Text = "Rune_19_High",
    Remark = "高级合奏附魔词缀",
    Color = "orangeword"
  },
  Rune_20_High = {
    Text = "Rune_20_High",
    Remark = "高级孕育附魔词缀",
    Color = "orangeword"
  },
  School_1 = {
    Text = "School_1",
    Remark = "混沌界域字色词缀",
    Color = "yellowword"
  },
  School_2 = {
    Text = "School_2",
    Remark = "深海界域字色词缀",
    Color = "blueword"
  },
  School_3 = {
    Text = "School_3",
    Remark = "血肉界域字色词缀",
    Color = "redword"
  },
  School_4 = {
    Text = "School_4",
    Remark = "超维界域字色词缀",
    Color = "purpleword"
  },
  PowerColourKeywords = {
    Text = "PowerColourKeywords",
    Remark = "力量颜色词缀",
    Color = "greenword",
    StateLink = 3281
  },
  WeaknessColour = {
    Text = "WeaknessColour",
    Remark = "虚弱颜色词缀",
    Color = "purpleword",
    StateLink = 3212
  },
  MadnessColour = {
    Text = "MadnessColour",
    Remark = "疯狂颜色词缀",
    Color = "greenword",
    StateLink = 3135
  },
  VulnerabilityColour = {
    Text = "VulnerabilityColour",
    Remark = "易伤颜色词缀",
    Color = "redword",
    StateLink = 2432
  },
  ExhaustionColour = {
    Text = "ExhaustionColour",
    Remark = "衰竭颜色词缀",
    Color = "purpleword",
    StateLink = 2549
  },
  BaseDamageColour = {
    Text = "BaseDamageColour",
    Remark = "基础伤害颜色词缀",
    Color = "redword"
  },
  AlertColour = {
    Text = "AlertColour",
    Remark = "戒备颜色词缀",
    Color = "blueword",
    StateLink = 2712
  },
  FragileColour = {
    Text = "FragileColour",
    Remark = "脆弱颜色词缀",
    Color = "purpleword",
    StateLink = 2586
  },
  ParcloseColour = {
    Text = "ParcloseColour",
    Remark = "屏障颜色词缀",
    Color = "blueword",
    StateLink = 3450
  },
  RetaliateColour = {
    Text = "RetaliateColour",
    Remark = "反击颜色词缀",
    Color = "blueword",
    StateLink = 3825
  },
  CritChanceColour = {
    Text = "CritChanceColour",
    Remark = "暴击率颜色词缀",
    Color = "orangeword"
  },
  CriticalDamageColour = {
    Text = "CriticalDamageColour",
    Remark = "暴击伤害颜色词缀",
    Color = "orangeword"
  },
  PetrifactionColour = {
    Text = "PetrifactionColour",
    Remark = "石化颜色词缀",
    Color = "orangeword",
    StateLink = 2410
  },
  ExclamationPointColour = {
    Text = "ExclamationPointColour",
    Remark = "感叹号颜色词缀",
    Color = "orangeword"
  },
  EnergyColour = {
    Text = "EnergyColour",
    Remark = "狂气颜色词缀",
    Color = "yellowword"
  },
  VampirismColour = {
    Text = "VampirismColour",
    Remark = "吸血颜色词缀",
    Color = "greenword"
  },
  BlessingColour = {
    Text = "BlessingColour",
    Remark = "祝福颜色词缀",
    Color = "greenword"
  },
  DeathResistanceColour = {
    Text = "DeathResistanceColour",
    Remark = "死亡抵抗颜色词缀",
    Color = "greenword"
  },
  DelayedReplyColour = {
    Text = "DelayedReplyColour",
    Remark = "延迟回复颜色词缀",
    Color = "greenword"
  },
  LuckyEngravingRateColour = {
    Text = "LuckyEngravingRateColour",
    Remark = "幸运刻印率颜色词缀",
    Color = "greenword"
  },
  ProficientInRealmsColour = {
    Text = "ProficientInRealmsColour",
    Remark = "界域精通颜色词缀",
    Color = "greenword"
  },
  BleedingColour = {
    Text = "BleedingColour",
    Remark = "出血颜色词缀",
    Color = "redword"
  },
  IntoxicationColour = {
    Text = "IntoxicationColour",
    Remark = "中毒颜色词缀",
    Color = "purpleword"
  },
  SlowColour = {
    Text = "SlowColour",
    Remark = "迟缓颜色词缀",
    Color = "purpleword"
  },
  YinniColour = {
    Text = "YinniColour",
    Remark = "PVP隐匿词缀",
    Color = "whiteword"
  },
  AberrationColour = {
    Text = "AberrationColour",
    Remark = "畸变颜色词缀",
    Color = "orangeword"
  },
  TuiyanColour = {
    Text = "TuiyanColour",
    Remark = "推演颜色词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  SilverKeyColour = {
    Text = "SilverKeyColour",
    Remark = "银钥颜色词缀",
    Color = "whiteword"
  },
  SilverKeyEnergyColour = {
    Text = "SilverKeyEnergyColour",
    Remark = "银钥充能颜色词缀",
    Color = "silveryword"
  },
  ExaltColour = {
    Text = "ExaltColour",
    Remark = "灵知觉醒颜色词缀",
    Color = "orangeword",
    StateLink = 3607
  },
  PowerIconKeywords = {
    Text = "PowerIconKeywords",
    Remark = "力量词缀",
    Color = "greenword",
    Img = "Battle_Card_Buff_021",
    ImgPath = "Battle_Card",
    StateLink = 3281
  },
  WeaknessIconKeywords = {
    Text = "WeaknessIconKeywords",
    Remark = "虚弱词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_005",
    ImgPath = "Battle_Card",
    StateLink = 3212
  },
  MadnessIconKeywords = {
    Text = "MadnessIconKeywords",
    Remark = "疯狂词缀",
    Color = "greenword",
    Img = "Battle_Card_Buff_030",
    ImgPath = "Battle_Card",
    StateLink = 3135
  },
  VulnerabilityIconKeywords = {
    Text = "VulnerabilityIconKeywords",
    Remark = "易伤词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_003",
    ImgPath = "Battle_Card",
    StateLink = 2432
  },
  ExhaustionIconKeywords = {
    Text = "ExhaustionIconKeywords",
    Remark = "衰竭词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_037",
    ImgPath = "Battle_Card",
    StateLink = 2549
  },
  CurseKeywords = {
    Text = "CurseKeywords",
    Remark = "诅咒词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_001",
    ImgPath = "Battle_Card",
    StateLink = 3929
  },
  BaseDamageIconKeywords = {
    Text = "BaseDamageIconKeywords",
    Remark = "基础伤害词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_031",
    ImgPath = "Battle_Card"
  },
  AlertIconKeywords = {
    Text = "AlertIconKeywords",
    Remark = "戒备词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_009",
    ImgPath = "Battle_Card",
    StateLink = 2712
  },
  BaoyanKeywords = {
    Text = "BaoyanKeywords",
    Remark = "爆炎词缀",
    Color = "redword"
  },
  TouquKeywords = {
    Text = "TouquKeywords",
    Remark = "偷取词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_014",
    ImgPath = "Battle_Card",
    StateLink = 78781
  },
  TouquKeywords2 = {
    Text = "TouquKeywords2",
    Remark = "永久偷取词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_014",
    ImgPath = "Battle_Card",
    StateLink = 100644
  },
  HuoyanKeywords4 = {
    Text = "HuoyanKeywords4",
    Remark = "活焰词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_057",
    ImgPath = "Battle_Card"
  },
  HuoyanKeywords = {
    Text = "HuoyanKeywords",
    Remark = "活焰词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_057",
    ImgPath = "Battle_Card",
    StateLink = 98488
  },
  HuoyanKeywords1 = {
    Text = "HuoyanKeywords1",
    Remark = "活焰1词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_057",
    ImgPath = "Battle_Card",
    StateLink = 98487
  },
  HuoyanKeywords2 = {
    Text = "HuoyanKeywords2",
    Remark = "活焰2词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_057",
    ImgPath = "Battle_Card",
    StateLink = 98485
  },
  HuoyanKeywords3 = {
    Text = "HuoyanKeywords3",
    Remark = "活焰3词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_057",
    ImgPath = "Battle_Card",
    StateLink = 98486
  },
  CarcassKeywords = {
    Text = "CarcassKeywords",
    Remark = "残骸词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_076",
    ImgPath = "Battle_Card",
    StateLink = 141504
  },
  ZuiyinKeywords = {
    Text = "ZuiyinKeywords",
    Remark = "罪印词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_078",
    ImgPath = "Battle_Card",
    StateLink = 117358
  },
  HuihuanaKeywords = {
    Text = "HuihuanaKeywords",
    Remark = "回环乐音词缀",
    Color = "redword",
    ImgPath = "Battle_Card",
    StateLink = 60562
  },
  HuihuanbKeywords = {
    Text = "HuihuanbKeywords",
    Remark = "回环乐音2启版词缀",
    Color = "redword",
    ImgPath = "Battle_Card",
    StateLink = 61085
  },
  XushiAKeywords = {
    Text = "XushiAKeywords",
    Remark = "蓄势乐音基础版词缀",
    Color = "Color24CardLost",
    ImgPath = "Battle_Card",
    StateLink = 60567
  },
  XushiBKeywords = {
    Text = "XushiBKeywords",
    Remark = "蓄势乐音2启版词缀",
    Color = "Color24CardLost",
    ImgPath = "Battle_Card",
    StateLink = 60570
  },
  FragileIconKeywords = {
    Text = "FragileIconKeywords",
    Remark = "脆弱词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_015",
    ImgPath = "Battle_Card",
    StateLink = 2586
  },
  ParcloseIconKeywords = {
    Text = "ParcloseIconKeywords",
    Remark = "屏障词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_013",
    ImgPath = "Battle_Card",
    StateLink = 3450
  },
  RetaliateIconKeywords = {
    Text = "RetaliateIconKeywords",
    Remark = "反击词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_019",
    ImgPath = "Battle_Card",
    StateLink = 3825
  },
  TransitionIconKeywords = {
    Text = "TransitionIconKeywords",
    Remark = "跃迁词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 2735
  },
  WormholeKeywords = {
    Text = "WormholeKeywords",
    Remark = "衍射词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 80207
  },
  RippleKeywords = {
    Text = "RippleKeywords",
    Remark = "余波词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 83808
  },
  ResonanceKeywords = {
    Text = "ResonanceKeywords",
    Remark = "共振词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 126785
  },
  TentacleInjurieIconKeywords = {
    Text = "TentacleInjurieIconKeywords",
    Remark = "触腕伤害词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 3592
  },
  TongxiaoKeywords = {
    Text = "TongxiaoKeywords",
    Remark = "通晓万物之理词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  RetainIconKeywords = {
    Text = "RetainIconKeywords",
    Remark = "保留词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 20026
  },
  RetainIconKeywordsColour = {
    Text = "RetainIconKeywordsColour",
    Remark = "保留颜色词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  JingjinvwangKeywords1 = {
    Text = "JingjinvwangKeywords1",
    Remark = "深眠反击",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  JingjinvwangKeywords2 = {
    Text = "JingjinvwangKeywords2",
    Remark = "呓语回音",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  JingjinvwangKeywords3 = {
    Text = "JingjinvwangKeywords3",
    Remark = "催眠脉络",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  TempPowerKeywords = {
    Text = "TempPowerKeywords",
    Remark = "临时强化词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 133999
  },
  TempPowerKeywords1 = {
    Text = "TempPowerKeywords1",
    Remark = "临时强化图标",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  TempPowerKeywords2 = {
    Text = "TempPowerKeywords2",
    Remark = "下次打出前强化词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 149664
  },
  SingularityKeywords = {
    Text = "SingularityKeywords",
    Remark = "奇点折跃词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_067",
    ImgPath = "Battle_Card",
    StateLink = 133372
  },
  SingularityKeywords1 = {
    Text = "SingularityKeywords1",
    Remark = "奇点信标词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_067",
    ImgPath = "Battle_Card",
    StateLink = 133774
  },
  SingularityKeywords2 = {
    Text = "SingularityKeywords2",
    Remark = "奇点棱镜词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_067",
    ImgPath = "Battle_Card",
    StateLink = 133775
  },
  SingularityKeywords3 = {
    Text = "SingularityKeywords3",
    Remark = "维度穿梭词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_067",
    ImgPath = "Battle_Card",
    StateLink = 134391
  },
  BreedingKeywords1 = {
    Text = "BreedingKeywords1",
    Remark = "繁育庆典词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_088",
    ImgPath = "Battle_Card",
    StateLink = 140135
  },
  BreedingKeywords2 = {
    Text = "BreedingKeywords2",
    Remark = "繁育庆典战斗内状态栏词缀",
    Color = "redword",
    ImgPath = "Battle_Card",
    StateLink = 140135
  },
  DepleteIconKeywords = {
    Text = "DepleteIconKeywords",
    Remark = "消耗词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 3003
  },
  DestructionKeywords = {
    Text = "DestructionKeywords",
    Remark = "销毁词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 120462
  },
  GuyouKeywords = {
    Text = "GuyouKeywords",
    Remark = "固有词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 60511
  },
  NothingnessIconKeywords = {
    Text = "NothingnessIconKeywords",
    Remark = "虚无词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 20039
  },
  DimensionalSpaceIconKeywords = {
    Text = "DimensionalSpaceIconKeywords",
    Remark = "超维空间词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 3260
  },
  DevouredIconKeywords = {
    Text = "DevouredIconKeywords",
    Remark = "吞噬词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 2888
  },
  UnlimitedDevouredIconKeywords = {
    Text = "UnlimitedDevouredIconKeywords",
    Remark = "无限吞噬词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 2603
  },
  MysterybuffKeywords = {
    Text = "MysterybuffKeywords",
    Remark = "奇妙效果词缀",
    Color = "orangeword",
    ImgPath = "Battle_Card",
    StateLink = 50375
  },
  MysterydebuffKeywords = {
    Text = "MysterydebuffKeywords",
    Remark = "奇妙负面效果词缀",
    Color = "orangeword",
    ImgPath = "Battle_Card",
    StateLink = 60386
  },
  EmbryoFusionIconKeywords = {
    Text = "EmbryoFusionIconKeywords",
    Remark = "胚胎融合词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 3665
  },
  CritChanceIconKeywords = {
    Text = "CritChanceIconKeywords",
    Remark = "暴击率词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_017",
    ImgPath = "Battle_Card"
  },
  CriticalDamageIconKeywords = {
    Text = "CriticalDamageIconKeywords",
    Remark = "暴击伤害词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_007",
    ImgPath = "Battle_Card"
  },
  PetrifactionIconKeywords = {
    Text = "PetrifactionIconKeywords",
    Remark = "石化词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_023",
    ImgPath = "Battle_Card",
    StateLink = 2410
  },
  KillKeywords = {
    Text = "KillKeywords",
    Remark = "击破词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 94657
  },
  ExclamationPointIconKeywords = {
    Text = "ExclamationPointIconKeywords",
    Remark = "感叹号词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  EnergyIconKeywords = {
    Text = "EnergyIconKeywords",
    Remark = "狂气词缀",
    Color = "yellowword",
    Img = "Battle_Card_Buff_032",
    ImgPath = "Battle_Card"
  },
  VampirismIconKeywords = {
    Text = "VampirismIconKeywords",
    Remark = "吸血词缀",
    Color = "greenword",
    Img = "Battle_Card_Buff_020",
    ImgPath = "Battle_Card"
  },
  BlessingIconKeywords = {
    Text = "BlessingIconKeywords",
    Remark = "祝福词缀",
    Color = "greenword",
    Img = "Battle_Card_Buff_026",
    ImgPath = "Battle_Card"
  },
  ReinforcePVEKeywords = {
    Text = "ReinforcePVEKeywords",
    Remark = "PVE加固词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_046",
    ImgPath = "Battle_Card",
    StateLink = 60088
  },
  DeathResistanceIconKeywords = {
    Text = "DeathResistanceIconKeywords",
    Remark = "死亡抵抗词缀",
    Color = "greenword",
    Img = "Battle_Card_Buff_012",
    ImgPath = "Battle_Card",
    StateLink = 2639
  },
  DelayedReplyIconKeywords = {
    Text = "DelayedReplyIconKeywords",
    Remark = "延迟回复词缀",
    Color = "greenword",
    Img = "Battle_Card_Buff_011",
    ImgPath = "Battle_Card"
  },
  LuckyEngravingRateIconKeywords = {
    Text = "LuckyEngravingRateIconKeywords",
    Remark = "幸运刻印率词缀",
    Color = "greenword",
    Img = "Battle_Card_Buff_033",
    ImgPath = "Battle_Card"
  },
  ProficientInRealmsIconKeywords = {
    Text = "ProficientInRealmsIconKeywords",
    Remark = "界域精通词缀",
    Color = "greenword",
    Img = "Battle_Card_Buff_034",
    ImgPath = "Battle_Card"
  },
  BleedingIconKeywords = {
    Text = "BleedingIconKeywords",
    Remark = "出血词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_022",
    ImgPath = "Battle_Card",
    StateLink = 3514
  },
  IntoxicationIconKeywords = {
    Text = "IntoxicationIconKeywords",
    Remark = "中毒词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_006",
    ImgPath = "Battle_Card",
    StateLink = 3773
  },
  SlowIconKeywords = {
    Text = "SlowIconKeywords",
    Remark = "迟缓词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_024",
    ImgPath = "Battle_Card",
    StateLink = 3178
  },
  AberrationKeywords = {
    Text = "AberrationKeywords",
    Remark = "卡牌畸变词缀",
    Color = "orangeword"
  },
  BlindingKeywords = {
    Text = "BlindingKeywords",
    Remark = "致盲词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_074",
    ImgPath = "Battle_Card",
    StateLink = 49954
  },
  EmptinessKeywords = {
    Text = "EmptinessKeywords",
    Remark = "空虚词缀",
    Color = "yellowword",
    Img = "Battle_Card_Buff_027",
    ImgPath = "Battle_Card",
    StateLink = 50333
  },
  ResentChainsKeywords = {
    Text = "ResentChainsKeywords",
    Remark = "怨恨锁链词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_073",
    ImgPath = "Battle_Card",
    StateLink = 49957
  },
  ResentChainsKeywords1 = {
    Text = "ResentChainsKeywords1",
    Remark = "怨恨锁链颜色词缀",
    Color = "purpleword",
    ImgPath = "Battle_Card",
    StateLink = 49957
  },
  BoneHitKeywords = {
    Text = "BoneHitKeywords",
    Remark = "刺骨词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 149163
  },
  HeavyInjuryKeywords = {
    Text = "HeavyInjuryKeywords",
    Remark = "重创词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_031",
    ImgPath = "Battle_Card",
    StateLink = 50010
  },
  ConcealmentKeywords = {
    Text = "ConcealmentKeywords",
    Remark = "隐匿词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_043",
    ImgPath = "Battle_Card",
    StateLink = 50358
  },
  SilverKeyIconKeywords = {
    Text = "SilverKeyIconKeywords",
    Remark = "银钥词缀",
    Color = "whiteword",
    Img = "Battle_Card_Buff_035",
    ImgPath = "Battle_Card"
  },
  SilverKeyEnergyIconKeywords = {
    Text = "SilverKeyEnergyIconKeywords",
    Remark = "银钥充能词缀",
    Color = "silveryword",
    Img = "Battle_Card_Buff_035",
    ImgPath = "Battle_Card"
  },
  ExaltIconKeywords = {
    Text = "ExaltIconKeywords",
    Remark = "灵知觉醒词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 3607
  },
  FaxianKeywords = {
    Text = "FaxianKeywords",
    Remark = "发现词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 66359
  },
  PunctureDamagewords = {
    Text = "PunctureDamagewords",
    Remark = "穿刺伤害词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 2472
  },
  PunctureDamagewords2 = {
    Text = "PunctureDamagewords2",
    Remark = "穿刺伤害无图标词缀",
    Color = "redword",
    ImgPath = "Battle_Card",
    StateLink = 2472
  },
  TimeBeacon = {
    Text = "TimeBeacon",
    Remark = "回环词缀",
    Color = "whiteword",
    Img = "Battle_Card_Buff_038",
    ImgPath = "Battle_Card",
    StateLink = 25165
  },
  TimeBeacon2 = {
    Text = "TimeBeacon2",
    Remark = "负熵词缀",
    Color = "whiteword",
    Img = "Battle_Card_Buff_039",
    ImgPath = "Battle_Card",
    StateLink = 25166
  },
  PainWord = {
    Text = "PainWord",
    Remark = "疼痛词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_040",
    ImgPath = "Battle_Card",
    StateLink = 34689
  },
  AnalysisKeywords0 = {
    Text = "AnalysisKeywords0",
    Remark = "共感词缀0启",
    Color = "purpleword",
    Img = "Battle_Card_Buff_049",
    ImgPath = "Battle_Card",
    StateLink = 81059
  },
  AnalysisKeywords3 = {
    Text = "AnalysisKeywords3",
    Remark = "共感词缀3启",
    Color = "purpleword",
    Img = "Battle_Card_Buff_049",
    ImgPath = "Battle_Card",
    StateLink = 81058
  },
  WitherKeywords = {
    Text = "WitherKeywords",
    Remark = "痴醉词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_080",
    ImgPath = "Battle_Card",
    StateLink = 126776
  },
  WitherKeywords0 = {
    Text = "WitherKeywords0",
    Remark = "痴醉战斗外三启词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_080",
    ImgPath = "Battle_Card",
    StateLink = 127176
  },
  MingqiKeywords = {
    Text = "MingqiKeywords",
    Remark = "命契词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 121231
  },
  DwmofeiKeywords = {
    Text = "DwmofeiKeywords",
    Remark = "降生仪式词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_079",
    ImgPath = "Battle_Card",
    StateLink = 120321
  },
  Corrosion = {
    Text = "Corrosion",
    Remark = "侵蚀词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_070",
    ImgPath = "Battle_Card",
    StateLink = 90294
  },
  SilkKeywords = {
    Text = "SilkKeywords",
    Remark = "织命词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_084",
    ImgPath = "Battle_Card",
    StateLink = 134227
  },
  SilkKeywords1 = {
    Text = "SilkKeywords1",
    Remark = "织命词缀",
    Color = "purpleword",
    ImgPath = "Battle_Card",
    StateLink = 134227
  },
  CutKeywords = {
    Text = "CutKeywords",
    Remark = "裁断词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_055",
    ImgPath = "Battle_Card",
    StateLink = 133391
  },
  KaiHuajishu = {
    Text = "KaiHuajishu",
    Remark = "沙耶开花计数词缀",
    Color = "whiteword",
    Img = "Battle_Card_Buff_087",
    ImgPath = "Battle_Card",
    StateLink = 139687
  },
  KaiHuajishu1 = {
    Text = "KaiHuajishu1",
    Remark = "沙耶开花计数状态栏词缀",
    Color = "whiteword",
    ImgPath = "Battle_Card",
    StateLink = 139687
  },
  ColorInkKeywords = {
    Text = "ColorInkKeywords",
    Remark = "认知失调词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 140656
  },
  ErosionColorInkKeywords = {
    Text = "ErosionColorInkKeywords",
    Remark = "认知错乱词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 140655
  },
  BattueKeywords = {
    Text = "BattueKeywords",
    Remark = "围猎词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_090",
    ImgPath = "Battle_Card",
    StateLink = 143336
  },
  BattueKeywords1 = {
    Text = "BattueKeywords1",
    Remark = "围猎颜色词缀",
    Color = "blueword",
    ImgPath = "Battle_Card",
    StateLink = 143336
  },
  KuangNu = {
    Text = "KuangNu",
    Remark = "暗涌词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_080",
    ImgPath = "Battle_Card",
    StateLink = 149789
  },
  KuangNu1 = {
    Text = "KuangNu1",
    Remark = "暗涌颜色词缀",
    Color = "redword",
    ImgPath = "Battle_Card",
    StateLink = 149789
  },
  KuangNu2 = {
    Text = "KuangNu2",
    Remark = "暗涌启灵3词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_080",
    ImgPath = "Battle_Card",
    StateLink = 149930
  },
  ShuZui = {
    Text = "ShuZui",
    Remark = "自罪词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_090",
    ImgPath = "Battle_Card",
    StateLink = 149791
  },
  ShuZui1 = {
    Text = "ShuZui1",
    Remark = "自罪颜色词缀",
    Color = "blueword",
    ImgPath = "Battle_Card",
    StateLink = 149791
  },
  Kuangxiang = {
    Text = "Kuangxiang",
    Remark = "狂想词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 100542
  },
  Chuangyi = {
    Text = "Chuangyi",
    Remark = "创意词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_077",
    ImgPath = "Battle_Card",
    StateLink = 100541
  },
  Chuanggouzaowu = {
    Text = "Chuanggouzaowu",
    Remark = "创构造物词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 100559
  },
  Chuanggoukeyin = {
    Text = "Chuanggoukeyin",
    Remark = "创构刻印词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 100564
  },
  CardCheerKeywords = {
    Text = "CardCheerKeywords",
    Remark = "喝彩",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 25392
  },
  SacrificeKeyWord = {
    Text = "SacrificeKeyWord",
    Remark = "献祭词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_041",
    ImgPath = "Battle_Card",
    StateLink = 36152
  },
  AshesPastKeyWord = {
    Text = "AshesPastKeyWord",
    Remark = "旧日余烬词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_025",
    ImgPath = "Battle_Card",
    StateLink = 128692
  },
  harmonyKeyWord = {
    Text = "harmonyKeyWord",
    Remark = "调和词缀",
    Color = "whiteword",
    StateLink = 90696
  },
  BurningKeywords = {
    Text = "BurningKeywords",
    Remark = "燃烧词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_057",
    ImgPath = "Battle_Card",
    StateLink = 81356
  },
  BurningKeywords2 = {
    Text = "BurningKeywords2",
    Remark = "局外燃烧词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_057",
    ImgPath = "Battle_Card",
    StateLink = 98752
  },
  BlueKeyWord = {
    Text = "BlueKeyWord",
    Remark = "蓝色词缀",
    Color = "blueword"
  },
  DreamGuide = {
    Text = "DreamGuide",
    Remark = "梦引词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_043",
    ImgPath = "Battle_Card",
    StateLink = 40484
  },
  PurpleKeyWord = {
    Text = "PurpleKeyWord",
    Remark = "紫色词缀",
    Color = "purpleword"
  },
  PrepareKeypvewords = {
    Text = "PrepareKeypvewords",
    Remark = "预备词缀",
    Color = "orangeword",
    StateLink = 66884
  },
  PrepareKeypvewords1 = {
    Text = "PrepareKeypvewords1",
    Remark = "塔薇预备词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 66884
  },
  PrepareKeypvewordscolour = {
    Text = "PrepareKeypvewordscolour",
    Remark = "预备颜色词缀",
    Color = "orangeword"
  },
  B02AFKeyWord = {
    Text = "B02AFKeyWord",
    Remark = "父神守护词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    SkillLink = 44817
  },
  B02AFKeyWord2 = {
    Text = "B02AFKeyWord2",
    Remark = "奉献词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 44732
  },
  B02AFKeyWord3 = {
    Text = "B02AFKeyWord3",
    Remark = "超度词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 44731
  },
  B02AFKeyWord4 = {
    Text = "B02AFKeyWord4",
    Remark = "救赎词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 45206
  },
  B01AFKeyWord1 = {
    Text = "B01AFKeyWord1",
    Remark = "恐惧之血",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  B01AFKeyWord2 = {
    Text = "B01AFKeyWord2",
    Remark = "溃烂之血",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  B01AFKeyWord3 = {
    Text = "B01AFKeyWord3",
    Remark = "生殖之血",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  B01AFKeyWordQ1 = {
    Text = "B01AFKeyWordQ1",
    Remark = "恐惧之血",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  B01AFKeyWordQ2 = {
    Text = "B01AFKeyWordQ2",
    Remark = "溃烂之血",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  B01AFKeyWordQ3 = {
    Text = "B01AFKeyWordQ3",
    Remark = "生殖之血",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  D13AFKeyWord1 = {
    Text = "D13AFKeyWord1",
    Remark = "恐惧固着0启词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_049",
    ImgPath = "Battle_Card",
    StateLink = 81057
  },
  D13AFKeyWordQ1 = {
    Text = "D13AFKeyWordQ1",
    Remark = "恐惧固着3启词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_049",
    ImgPath = "Battle_Card",
    StateLink = 81054
  },
  D13AFKeyWord2 = {
    Text = "D13AFKeyWord2",
    Remark = "精神创伤0启词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_049",
    ImgPath = "Battle_Card",
    StateLink = 81055
  },
  D13AFKeyWordQ2 = {
    Text = "D13AFKeyWordQ2",
    Remark = "精神创伤3启词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_049",
    ImgPath = "Battle_Card",
    StateLink = 81056
  },
  D13Colour = {
    Text = "D13Colour",
    Remark = "颜色词缀",
    Color = "purpleword"
  },
  HunmiKeywords = {
    Text = "HunmiKeywords",
    Remark = "昏迷词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_023",
    ImgPath = "Battle_Card",
    StateLink = 123810
  },
  WitherKeywords1 = {
    Text = "WitherKeywords1",
    Remark = "相许词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_080",
    ImgPath = "Battle_Card",
    StateLink = 126789
  },
  WitherKeywords2 = {
    Text = "WitherKeywords2",
    Remark = "夺魄词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_080",
    ImgPath = "Battle_Card",
    StateLink = 126790
  },
  WitherKeywords3 = {
    Text = "WitherKeywords3",
    Remark = "超限相许词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_080",
    ImgPath = "Battle_Card",
    StateLink = 127108
  },
  WitherKeywords4 = {
    Text = "WitherKeywords4",
    Remark = "超限夺魄词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_080",
    ImgPath = "Battle_Card",
    StateLink = 127109
  },
  WhirlpoolKeywords = {
    Text = "WhirlpoolKeywords",
    Remark = "涡流词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_081",
    ImgPath = "Battle_Card",
    StateLink = 131657
  },
  AdaptKeywords = {
    Text = "AdaptKeywords",
    Remark = "适应词缀展示用",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 140873
  },
  HungerKeywords = {
    Text = "HungerKeywords",
    Remark = "饥饿词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 141468
  },
  AdaptKeywords1 = {
    Text = "AdaptKeywords1",
    Remark = "适应词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card"
  },
  EnsembleKeywords = {
    Text = "EnsembleKeywords",
    Remark = "合奏词缀",
    StateLink = 48012
  },
  SeniorEnsembleKeywords = {
    Text = "SeniorEnsembleKeywords",
    Remark = "高级合奏词缀",
    StateLink = 48013
  },
  OceanAttack = {
    Text = "OceanAttack",
    Remark = "触腕集结词缀",
    Color = "orangeword",
    StateLink = 49225
  },
  O07CardKeyWord = {
    Text = "O07CardKeyWord",
    Remark = "海之使徒词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 52068
  },
  O07CardKeyWord2 = {
    Text = "O07CardKeyWord2",
    Remark = "海之使徒词缀2",
    Color = "orangeword",
    SkillLink = 51902
  },
  O07CardKeyWord3 = {
    Text = "O07CardKeyWord3",
    Remark = "海之使徒词缀3",
    Color = "orangeword",
    SkillLink = 52055
  },
  O07CardKeyWord4 = {
    Text = "O07CardKeyWord4",
    Remark = "海之使徒词缀4",
    Color = "orangeword",
    SkillLink = 51733
  },
  O07CardKeyWord5 = {
    Text = "O07CardKeyWord5",
    Remark = "海之使徒词缀5",
    Color = "orangeword",
    SkillLink = 51734
  },
  C01EXCardKeyWord1 = {
    Text = "C01EXCardKeyWord1",
    Remark = "本源知者词缀1",
    Color = "orangeword",
    StateLink = 54045
  },
  C01EXCardKeyWord2 = {
    Text = "C01EXCardKeyWord2",
    Remark = "本源知者词缀2",
    Color = "orangeword",
    StateLink = 54044
  },
  C01CardKeyWord1 = {
    Text = "C01CardKeyWord1",
    Remark = "知者词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    SkillLink = 54566
  },
  D06CardKeyWord1 = {
    Text = "D06CardKeyWord1",
    Remark = "意象",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 56034
  },
  D06CardKeyWordxi = {
    Text = "D06CardKeyWordxi",
    Remark = "喜意象",
    Color = "D06yixiangxi"
  },
  D06CardKeyWordnu = {
    Text = "D06CardKeyWordnu",
    Remark = "怒意象",
    Color = "D06yixiangnu"
  },
  D06CardKeyWordai = {
    Text = "D06CardKeyWordai",
    Remark = "哀意象",
    Color = "D06yixiangai"
  },
  D06CardKeyWordju = {
    Text = "D06CardKeyWordju",
    Remark = "惧意象",
    Color = "D06yixiangju"
  },
  D06CardKeeperSkill = {
    Text = "D06CardKeeperSkill",
    Remark = "奥尔拉钥令词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 56208
  },
  DerivativeCardKeywords_1 = {
    Text = "DerivativeCardKeywords_1",
    Remark = "衍生卡词缀",
    SkillLink = 4433
  },
  DerivativeCardKeywords_2 = {
    Text = "DerivativeCardKeywords_2",
    Remark = "衍生卡词缀",
    SkillLink = 4052
  },
  DerivativeCardKeywords_3 = {
    Text = "DerivativeCardKeywords_3",
    Remark = "衍生卡词缀",
    SkillLink = 4826
  },
  DerivativeCardKeywords_4 = {
    Text = "DerivativeCardKeywords_4",
    Remark = "衍生卡词缀",
    SkillLink = 4677
  },
  DerivativeCardKeywords_5 = {
    Text = "DerivativeCardKeywords_5",
    Remark = "衍生卡词缀",
    SkillLink = 4467
  },
  DerivativeCardKeywords_6 = {
    Text = "DerivativeCardKeywords_6",
    Remark = "衍生卡词缀",
    SkillLink = 4554
  },
  DerivativeCardKeywords_7 = {
    Text = "DerivativeCardKeywords_7",
    Remark = "衍生卡词缀",
    SkillLink = 4328
  },
  DerivativeCardKeywords_8 = {
    Text = "DerivativeCardKeywords_8",
    Remark = "衍生卡词缀",
    SkillLink = 4359
  },
  DerivativeCardKeywords_9 = {
    Text = "DerivativeCardKeywords_9",
    Remark = "衍生卡词缀",
    SkillLink = 4006
  },
  DerivativeCardKeywords_10 = {
    Text = "DerivativeCardKeywords_10",
    Remark = "衍生卡词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    SkillLink = 48812
  },
  DerivativeCardKeywords_12 = {
    Text = "DerivativeCardKeywords_12",
    Remark = "衍生卡词缀",
    SkillLink = 4641
  },
  DerivativeCardKeywords_13 = {
    Text = "DerivativeCardKeywords_13",
    Remark = "衍生卡词缀",
    SkillLink = 4663
  },
  DerivativeCardKeywords_14 = {
    Text = "DerivativeCardKeywords_14",
    Remark = "衍生卡词缀",
    SkillLink = 4065
  },
  DerivativeCardKeywords_15 = {
    Text = "DerivativeCardKeywords_15",
    Remark = "衍生卡词缀",
    SkillLink = 70303
  },
  DerivativeCardKeywords_16 = {
    Text = "DerivativeCardKeywords_16",
    Remark = "衍生卡词缀",
    SkillLink = 4794
  },
  DerivativeCardKeywords_17 = {
    Text = "DerivativeCardKeywords_17",
    Remark = "衍生卡词缀",
    SkillLink = 4638
  },
  DerivativeCardKeywords_18 = {
    Text = "DerivativeCardKeywords_18",
    Remark = "衍生卡词缀",
    SkillLink = 4023
  },
  DerivativeCardKeywords_19 = {
    Text = "DerivativeCardKeywords_19",
    Remark = "衍生卡词缀",
    SkillLink = 4824
  },
  DerivativeCardKeywords_20 = {
    Text = "DerivativeCardKeywords_20",
    Remark = "衍生卡词缀",
    SkillLink = 4367
  },
  DerivativeCardKeywords_23 = {
    Text = "DerivativeCardKeywords_23",
    Remark = "衍生卡词缀",
    SkillLink = 4374
  },
  DerivativeCardKeywords_24 = {
    Text = "DerivativeCardKeywords_24",
    Remark = "衍生卡词缀",
    SkillLink = 4054
  },
  DerivativeCardKeywords_25 = {
    Text = "DerivativeCardKeywords_25",
    Remark = "衍生卡词缀",
    SkillLink = 4647
  },
  DerivativeCardKeywords_26 = {
    Text = "DerivativeCardKeywords_26",
    Remark = "衍生卡词缀",
    SkillLink = 4119
  },
  DerivativeCardKeywords_27 = {
    Text = "DerivativeCardKeywords_27",
    Remark = "衍生卡词缀",
    SkillLink = 4496
  },
  DerivativeCardKeywords_28 = {
    Text = "DerivativeCardKeywords_28",
    Remark = "衍生卡词缀",
    SkillLink = 4569
  },
  DerivativeCardKeywords_29 = {
    Text = "DerivativeCardKeywords_29",
    Remark = "衍生卡词缀",
    SkillLink = 4142
  },
  DerivativeCardKeywords_30 = {
    Text = "DerivativeCardKeywords_30",
    Remark = "衍生卡词缀",
    SkillLink = 4184
  },
  DerivativeCardKeywords_31 = {
    Text = "DerivativeCardKeywords_31",
    Remark = "衍生卡词缀",
    SkillLink = 4140
  },
  DerivativeCardKeywords_32 = {
    Text = "DerivativeCardKeywords_32",
    Remark = "衍生卡词缀",
    SkillLink = 4418
  },
  DerivativeCardKeywords_33 = {
    Text = "DerivativeCardKeywords_33",
    Remark = "衍生卡词缀",
    SkillLink = 4058
  },
  DerivativeCardKeywords_34 = {
    Text = "DerivativeCardKeywords_34",
    Remark = "衍生卡词缀",
    SkillLink = 4146
  },
  DerivativeCardKeywords_35 = {
    Text = "DerivativeCardKeywords_35",
    Remark = "衍生卡词缀",
    SkillLink = 4190
  },
  DerivativeCardKeywords_36 = {
    Text = "DerivativeCardKeywords_36",
    Remark = "衍生卡词缀",
    SkillLink = 4248
  },
  DerivativeCardKeywords_37 = {
    Text = "DerivativeCardKeywords_37",
    Remark = "衍生卡词缀",
    SkillLink = 4215
  },
  DerivativeCardKeywords_38 = {
    Text = "DerivativeCardKeywords_38",
    Remark = "衍生卡词缀",
    SkillLink = 4493
  },
  DerivativeCardKeywords_39 = {
    Text = "DerivativeCardKeywords_39",
    Remark = "衍生卡词缀",
    SkillLink = 4672
  },
  DerivativeCardKeywords_40 = {
    Text = "DerivativeCardKeywords_40",
    Remark = "衍生卡词缀",
    SkillLink = 4499
  },
  DerivativeCardKeywords_41 = {
    Text = "DerivativeCardKeywords_41",
    Remark = "衍生卡词缀",
    SkillLink = 4709
  },
  DerivativeCardKeywords_42 = {
    Text = "DerivativeCardKeywords_42",
    Remark = "衍生卡词缀",
    SkillLink = 49215
  },
  DerivativeCardKeywords_43 = {
    Text = "DerivativeCardKeywords_43",
    Remark = "衍生卡词缀",
    SkillLink = 49216
  },
  DerivativeCardKeywords_44 = {
    Text = "DerivativeCardKeywords_44",
    Remark = "衍生卡词缀",
    SkillLink = 49133
  },
  DerivativeCardKeywords_45 = {
    Text = "DerivativeCardKeywords_45",
    Remark = "衍生卡词缀",
    SkillLink = 3999
  },
  DerivativeCardKeywords_46 = {
    Text = "DerivativeCardKeywords_46",
    Remark = "衍生卡词缀",
    SkillLink = 50394
  },
  DerivativeCardKeywords_47 = {
    Text = "DerivativeCardKeywords_47",
    Remark = "衍生卡词缀",
    SkillLink = 50398
  },
  DerivativeCardKeywords_48 = {
    Text = "DerivativeCardKeywords_48",
    Remark = "衍生卡词缀",
    SkillLink = 50397
  },
  DerivativeCardKeywords_49 = {
    Text = "DerivativeCardKeywords_49",
    Remark = "衍生卡词缀",
    SkillLink = 50392
  },
  DerivativeCardKeywords_50 = {
    Text = "DerivativeCardKeywords_50",
    Remark = "衍生卡词缀",
    SkillLink = 50393
  },
  DerivativeCardKeywords_51 = {
    Text = "DerivativeCardKeywords_51",
    Remark = "衍生卡词缀",
    SkillLink = 50399
  },
  DerivativeCardKeywords_52 = {
    Text = "DerivativeCardKeywords_52",
    Remark = "衍生卡词缀",
    SkillLink = 50396
  },
  DerivativeCardKeywords_53 = {
    Text = "DerivativeCardKeywords_53",
    Remark = "衍生卡词缀",
    SkillLink = 50395
  },
  DerivativeCardKeywords_54 = {
    Text = "DerivativeCardKeywords_54",
    Remark = "衍生卡词缀",
    SkillLink = 50492
  },
  DerivativeCardKeywords_55 = {
    Text = "DerivativeCardKeywords_55",
    Remark = "衍生卡词缀",
    SkillLink = 50395
  },
  DerivativeCardKeywords_56 = {
    Text = "DerivativeCardKeywords_56",
    Remark = "衍生卡词缀",
    SkillLink = 50492
  },
  DerivativeCardKeywords_57 = {
    Text = "DerivativeCardKeywords_57",
    Remark = "衍生卡词缀",
    SkillLink = 52319
  },
  DerivativeCardKeywords_58 = {
    Text = "DerivativeCardKeywords_58",
    Remark = "衍生卡词缀",
    SkillLink = 52317
  },
  DerivativeCardKeywords_59 = {
    Text = "DerivativeCardKeywords_59",
    Remark = "衍生卡词缀",
    SkillLink = 52318
  },
  DerivativeCardKeywords_60 = {
    Text = "DerivativeCardKeywords_60",
    Remark = "衍生卡词缀",
    SkillLink = 36330
  },
  DerivativeCardKeywords_61 = {
    Text = "DerivativeCardKeywords_61",
    Remark = "衍生卡词缀",
    SkillLink = 59490
  },
  DerivativeCardKeywords_62 = {
    Text = "DerivativeCardKeywords_62",
    Remark = "衍生卡词缀",
    SkillLink = 59491
  },
  DerivativeCardKeywords_63 = {
    Text = "DerivativeCardKeywords_63",
    Remark = "衍生卡词缀",
    SkillLink = 60309
  },
  DerivativeCardKeywords_64 = {
    Text = "DerivativeCardKeywords_64",
    Remark = "衍生卡词缀",
    SkillLink = 60552
  },
  DerivativeCardKeywords_65 = {
    Text = "DerivativeCardKeywords_65",
    Remark = "衍生卡词缀",
    SkillLink = 61121
  },
  DerivativeCardKeywords_66 = {
    Text = "DerivativeCardKeywords_66",
    Remark = "衍生卡词缀",
    SkillLink = 61122
  },
  DerivativeCardKeywords_67 = {
    Text = "DerivativeCardKeywords_67",
    Remark = "衍生卡词缀",
    SkillLink = 49882
  },
  DerivativeCardKeywords_68 = {
    Text = "DerivativeCardKeywords_68",
    Remark = "衍生卡词缀",
    SkillLink = 65453
  },
  DerivativeCardKeywords_69 = {
    Text = "DerivativeCardKeywords_69",
    Remark = "衍生卡词缀",
    SkillLink = 65451
  },
  DerivativeCardKeywords_70 = {
    Text = "DerivativeCardKeywords_70",
    Remark = "衍生卡词缀",
    SkillLink = 65393
  },
  DerivativeCardKeywords_71 = {
    Text = "DerivativeCardKeywords_71",
    Remark = "衍生卡词缀",
    SkillLink = 65452
  },
  DerivativeCardKeywords_72 = {
    Text = "DerivativeCardKeywords_72",
    Remark = "衍生卡词缀",
    SkillLink = 65454
  },
  DerivativeCardKeywords_73 = {
    Text = "DerivativeCardKeywords_73",
    Remark = "衍生卡词缀",
    SkillLink = 65372
  },
  DerivativeCardKeywords_74 = {
    Text = "DerivativeCardKeywords_74",
    Remark = "衍生卡词缀",
    SkillLink = 59665
  },
  DerivativeCardKeywords_75 = {
    Text = "DerivativeCardKeywords_75",
    Remark = "衍生卡词缀",
    SkillLink = 66351
  },
  DerivativeCardKeywords_76 = {
    Text = "DerivativeCardKeywords_76",
    Remark = "衍生卡词缀",
    SkillLink = 66355
  },
  DerivativeCardKeywords_77 = {
    Text = "DerivativeCardKeywords_77",
    Remark = "衍生卡词缀",
    SkillLink = 66353
  },
  DerivativeCardKeywords_78 = {
    Text = "DerivativeCardKeywords_78",
    Remark = "衍生卡词缀",
    SkillLink = 36030
  },
  DerivativeCardKeywords_79 = {
    Text = "DerivativeCardKeywords_79",
    Remark = "衍生卡词缀",
    SkillLink = 4687
  },
  DerivativeCardKeywords_80 = {
    Text = "DerivativeCardKeywords_80",
    Remark = "衍生卡词缀",
    SkillLink = 3968
  },
  DerivativeCardKeywords_81 = {
    Text = "DerivativeCardKeywords_81",
    Remark = "衍生卡词缀",
    SkillLink = 4807
  },
  DerivativeCardKeywords_82 = {
    Text = "DerivativeCardKeywords_82",
    Remark = "衍生卡词缀",
    SkillLink = 4074
  },
  DerivativeCardKeywords_83 = {
    Text = "DerivativeCardKeywords_83",
    Remark = "衍生卡词缀",
    SkillLink = 68667
  },
  DerivativeCardKeywords_84 = {
    Text = "DerivativeCardKeywords_84",
    Remark = "衍生卡词缀",
    SkillLink = 68665
  },
  DerivativeCardKeywords_85 = {
    Text = "DerivativeCardKeywords_85",
    Remark = "衍生卡词缀",
    SkillLink = 68670
  },
  DerivativeCardKeywords_86 = {
    Text = "DerivativeCardKeywords_86",
    Remark = "衍生卡词缀",
    SkillLink = 68671
  },
  DerivativeCardKeywords_87 = {
    Text = "DerivativeCardKeywords_87",
    Remark = "衍生卡词缀",
    SkillLink = 68668
  },
  DerivativeCardKeywords_88 = {
    Text = "DerivativeCardKeywords_88",
    Remark = "衍生卡词缀",
    SkillLink = 68659
  },
  DerivativeCardKeywords_89 = {
    Text = "DerivativeCardKeywords_89",
    Remark = "衍生卡词缀",
    SkillLink = 68669
  },
  DerivativeCardKeywords_90 = {
    Text = "DerivativeCardKeywords_90",
    Remark = "衍生卡词缀",
    SkillLink = 68666
  },
  DerivativeCardKeywords_91 = {
    Text = "DerivativeCardKeywords_91",
    Remark = "衍生卡词缀",
    SkillLink = 68661
  },
  DerivativeCardKeywords_92 = {
    Text = "DerivativeCardKeywords_92",
    Remark = "衍生卡词缀",
    SkillLink = 68662
  },
  DerivativeCardKeywords_93 = {
    Text = "DerivativeCardKeywords_93",
    Remark = "衍生卡词缀",
    SkillLink = 68663
  },
  DerivativeCardKeywords_94 = {
    Text = "DerivativeCardKeywords_94",
    Remark = "衍生卡词缀",
    SkillLink = 68672
  },
  DerivativeCardKeywords_95 = {
    Text = "DerivativeCardKeywords_95",
    Remark = "衍生卡词缀",
    SkillLink = 68660
  },
  DerivativeCardKeywords_96 = {
    Text = "DerivativeCardKeywords_96",
    Remark = "衍生卡词缀",
    SkillLink = 68664
  },
  DerivativeCardKeywords_97 = {
    Text = "DerivativeCardKeywords_97",
    Remark = "衍生卡词缀",
    SkillLink = 68874
  },
  DerivativeCardKeywords_98 = {
    Text = "DerivativeCardKeywords_98",
    Remark = "衍生卡词缀",
    SkillLink = 68873
  },
  DerivativeCardKeywords_99 = {
    Text = "DerivativeCardKeywords_99",
    Remark = "衍生卡词缀",
    SkillLink = 70826
  },
  DerivativeCardKeywords_100 = {
    Text = "DerivativeCardKeywords_100",
    Remark = "衍生卡词缀",
    SkillLink = 70825
  },
  DerivativeCardKeywords_101 = {
    Text = "DerivativeCardKeywords_101",
    Remark = "衍生卡词缀",
    SkillLink = 70333
  },
  DerivativeCardKeywords_102 = {
    Text = "DerivativeCardKeywords_102",
    Remark = "衍生卡词缀",
    SkillLink = 70332
  },
  DerivativeCardKeywords_103 = {
    Text = "DerivativeCardKeywords_103",
    Remark = "衍生卡词缀",
    SkillLink = 71522
  },
  DerivativeCardKeywords_104 = {
    Text = "DerivativeCardKeywords_104",
    Remark = "衍生卡词缀",
    SkillLink = 71523
  },
  DerivativeCardKeywords_105 = {
    Text = "DerivativeCardKeywords_105",
    Remark = "衍生卡词缀",
    SkillLink = 71652
  },
  DerivativeCardKeywords_106 = {
    Text = "DerivativeCardKeywords_106",
    Remark = "衍生卡词缀",
    SkillLink = 84357
  },
  DerivativeCardKeywords_107 = {
    Text = "DerivativeCardKeywords_107",
    Remark = "衍生卡词缀",
    SkillLink = 89779
  },
  DerivativeCardKeywords_108 = {
    Text = "DerivativeCardKeywords_108",
    Remark = "衍生卡词缀",
    SkillLink = 91159
  },
  DerivativeCardKeywords_109 = {
    Text = "DerivativeCardKeywords_109",
    Remark = "衍生卡词缀",
    SkillLink = 91158
  },
  DerivativeCardKeywords_110 = {
    Text = "DerivativeCardKeywords_110",
    Remark = "衍生卡词缀",
    SkillLink = 97318
  },
  DerivativeCardKeywords_111 = {
    Text = "DerivativeCardKeywords_111",
    Remark = "衍生卡词缀",
    SkillLink = 95828
  },
  DerivativeCardKeywords_112 = {
    Text = "DerivativeCardKeywords_112",
    Remark = "衍生卡词缀",
    SkillLink = 95819
  },
  DerivativeCardKeywords_113 = {
    Text = "DerivativeCardKeywords_113",
    Remark = "衍生卡词缀",
    SkillLink = 97159
  },
  DerivativeCardKeywords_114 = {
    Text = "DerivativeCardKeywords_114",
    Remark = "衍生卡词缀",
    SkillLink = 97319
  },
  DerivativeCardKeywords_115 = {
    Text = "DerivativeCardKeywords_115",
    Remark = "衍生卡词缀",
    SkillLink = 47484
  },
  DerivativeCardKeywords_116 = {
    Text = "DerivativeCardKeywords_116",
    Remark = "衍生卡词缀",
    SkillLink = 98317
  },
  DerivativeCardKeywords_117 = {
    Text = "DerivativeCardKeywords_117",
    Remark = "衍生卡词缀",
    SkillLink = 97916
  },
  DerivativeCardKeywords_118 = {
    Text = "DerivativeCardKeywords_118",
    Remark = "衍生卡词缀",
    SkillLink = 117315
  },
  DerivativeCardKeywords_119 = {
    Text = "DerivativeCardKeywords_119",
    Remark = "衍生卡词缀",
    SkillLink = 119342
  },
  DerivativeCardKeywords_120 = {
    Text = "DerivativeCardKeywords_120",
    Remark = "衍生卡词缀",
    SkillLink = 119716
  },
  DerivativeCardKeywords_121 = {
    Text = "DerivativeCardKeywords_121",
    Remark = "衍生卡词缀",
    SkillLink = 119715
  },
  DerivativeCardKeywords_122 = {
    Text = "DerivativeCardKeywords_122",
    Remark = "衍生卡词缀",
    SkillLink = 119718
  },
  DerivativeCardKeywords_123 = {
    Text = "DerivativeCardKeywords_123",
    Remark = "衍生卡词缀",
    SkillLink = 122121
  },
  DerivativeCardKeywords_124 = {
    Text = "DerivativeCardKeywords_124",
    Remark = "衍生卡词缀",
    SkillLink = 122120
  },
  DerivativeCardKeywords_125 = {
    Text = "DerivativeCardKeywords_125",
    Remark = "衍生卡词缀",
    SkillLink = 122122
  },
  DerivativeCardKeywords_126 = {
    Text = "DerivativeCardKeywords_126",
    Remark = "衍生卡词缀",
    SkillLink = 122123
  },
  DerivativeCardKeywords_127 = {
    Text = "DerivativeCardKeywords_127",
    Remark = "衍生卡词缀",
    SkillLink = 122118
  },
  DerivativeCardKeywords_128 = {
    Text = "DerivativeCardKeywords_128",
    Remark = "衍生卡词缀",
    SkillLink = 122119
  },
  DerivativeCardKeywords_129 = {
    Text = "DerivativeCardKeywords_129",
    Remark = "衍生卡词缀",
    SkillLink = 73536
  },
  DerivativeCardKeywords_130 = {
    Text = "DerivativeCardKeywords_130",
    Remark = "衍生卡词缀",
    SkillLink = 125905
  },
  DerivativeCardKeywords_131 = {
    Text = "DerivativeCardKeywords_131",
    Remark = "衍生卡词缀",
    SkillLink = 126008
  },
  DerivativeCardKeywords_132 = {
    Text = "DerivativeCardKeywords_132",
    Remark = "衍生卡词缀",
    SkillLink = 130934
  },
  DerivativeCardKeywords_133 = {
    Text = "DerivativeCardKeywords_133",
    Remark = "衍生卡词缀",
    SkillLink = 130493
  },
  DerivativeCardKeywords_134 = {
    Text = "DerivativeCardKeywords_134",
    Remark = "衍生卡词缀",
    SkillLink = 131192
  },
  DerivativeCardKeywords_135 = {
    Text = "DerivativeCardKeywords_135",
    Remark = "衍生卡词缀",
    SkillLink = 130940
  },
  DerivativeCardKeywords_136 = {
    Text = "DerivativeCardKeywords_136",
    Remark = "衍生卡词缀",
    SkillLink = 130940
  },
  DerivativeCardKeywords_137 = {
    Text = "DerivativeCardKeywords_137",
    Remark = "衍生卡词缀",
    SkillLink = 133381
  },
  DerivativeCardKeywords_138 = {
    Text = "DerivativeCardKeywords_138",
    Remark = "衍生卡词缀",
    SkillLink = 126488
  },
  DerivativeCardKeywords_139 = {
    Text = "DerivativeCardKeywords_139",
    Remark = "衍生卡词缀",
    SkillLink = 133366
  },
  DerivativeCardKeywords_140 = {
    Text = "DerivativeCardKeywords_140",
    Remark = "衍生卡词缀",
    SkillLink = 133951
  },
  DerivativeCardKeywords_141 = {
    Text = "DerivativeCardKeywords_141",
    Remark = "衍生卡词缀",
    SkillLink = 133952
  },
  DerivativeCardKeywords_142 = {
    Text = "DerivativeCardKeywords_142",
    Remark = "衍生卡词缀",
    SkillLink = 133953
  },
  DerivativeCardKeywords_143 = {
    Text = "DerivativeCardKeywords_143",
    Remark = "衍生卡词缀",
    SkillLink = 133950
  },
  DerivativeCardKeywords_144 = {
    Text = "DerivativeCardKeywords_144",
    Remark = "衍生卡词缀",
    SkillLink = 140665
  },
  DerivativeCardKeywords_145 = {
    Text = "DerivativeCardKeywords_145",
    Remark = "衍生卡词缀",
    SkillLink = 143559
  },
  DerivativeCardKeywords_146 = {
    Text = "DerivativeCardKeywords_146",
    Remark = "衍生卡词缀",
    SkillLink = 143557
  },
  DerivativeCardKeywords_147 = {
    Text = "DerivativeCardKeywords_147",
    Remark = "衍生卡词缀",
    SkillLink = 143558
  },
  DerivativeCardKeywords_148 = {
    Text = "DerivativeCardKeywords_148",
    Remark = "衍生卡词缀",
    SkillLink = 140830
  },
  DerivativeCardKeywords_149 = {
    Text = "DerivativeCardKeywords_149",
    Remark = "衍生卡词缀",
    SkillLink = 48814
  },
  DerivativeCardKeywords_150 = {
    Text = "DerivativeCardKeywords_150",
    Remark = "衍生卡词缀",
    SkillLink = 48813
  },
  DerivativeCardKeywords_151 = {
    Text = "DerivativeCardKeywords_151",
    Remark = "衍生卡词缀",
    SkillLink = 48815
  },
  DerivativeCardKeywords_152 = {
    Text = "DerivativeCardKeywords_152",
    Remark = "衍生卡词缀",
    SkillLink = 145612
  },
  DerivativeCardKeywords_153 = {
    Text = "DerivativeCardKeywords_153",
    Remark = "衍生卡词缀",
    SkillLink = 146012
  },
  DerivativeCardKeywords_154 = {
    Text = "DerivativeCardKeywords_154",
    Remark = "衍生卡词缀",
    SkillLink = 146018
  },
  DerivativeCardKeywords_155 = {
    Text = "DerivativeCardKeywords_155",
    Remark = "衍生卡词缀",
    SkillLink = 146112
  },
  DerivativeCardKeywords_156 = {
    Text = "DerivativeCardKeywords_156",
    Remark = "衍生卡词缀",
    SkillLink = 146114
  },
  DerivativeCardKeywords_157 = {
    Text = "DerivativeCardKeywords_157",
    Remark = "衍生卡词缀",
    SkillLink = 146113
  },
  DerivativeCardKeywords_158 = {
    Text = "DerivativeCardKeywords_158",
    Remark = "衍生卡词缀",
    SkillLink = 147941
  },
  DerivativeCardKeywords_160 = {
    Text = "DerivativeCardKeywords_160",
    Remark = "衍生卡词缀",
    SkillLink = 144492
  },
  DerivativeCardKeywords_161 = {
    Text = "DerivativeCardKeywords_161",
    Remark = "衍生卡词缀",
    SkillLink = 149362
  },
  Rolling1 = {Text = "Rolling1", SkillLink = 130507},
  Rolling2 = {Text = "Rolling2", SkillLink = 130508},
  Rolling3 = {Text = "Rolling3", SkillLink = 130509},
  Rolling4 = {Text = "Rolling4", SkillLink = 130506},
  Black = {
    Text = "Black",
    Remark = "黑色",
    Color = "Black,Dark"
  },
  CardKeyWord = {
    Text = "CardKeyWord",
    Color = "orangeword"
  },
  UrlLink = {
    Text = "UrlLink",
    Remark = "Url超链接",
    Link = "Url"
  },
  SurveyLink = {
    Text = "SurveyLink",
    Remark = "问卷链接",
    Link = "Survey"
  },
  AwakerSkill = {
    Text = "AwakerSkill",
    Remark = "唤醒体技能等级+1",
    Color = "AwakerSkill,Light"
  },
  WhiteRelic = {
    Text = "WhiteRelic",
    Remark = "白银造物标签颜色",
    Color = "WhiteRelic,Light"
  },
  OrangeRelic = {
    Text = "OrangeRelic",
    Remark = "黄金造物标签颜色",
    Color = "OrangeRelic,Light"
  },
  RedRelic = {
    Text = "RedRelic",
    Remark = "诅咒造物标签颜色",
    Color = "RedRelic,Light"
  },
  PotencyChoose = {
    Text = "PotencyChoose",
    Remark = "启灵选中字色",
    Color = "PotencyChoose,Light"
  },
  PotencyActive = {
    Text = "PotencyActive",
    Remark = "启灵激活字色",
    Color = "PotencyActive,Light"
  },
  PotencyNotActive = {
    Text = "PotencyNotActive",
    Remark = "启灵未激活字色",
    Color = "PotencyNotActive,Light"
  },
  RedQuality1 = {
    Text = "RedQuality1",
    Remark = "红色品质加粗",
    Color = "RedQuality,Dark"
  },
  SummonTimesQuality = {
    Text = "SummonTimesQuality",
    Remark = "剩余几次必出SSR字色",
    Color = "RedQuality,Dark",
    Size = 44
  },
  Big = {Text = "Big", Size = 50},
  Small = {Text = "Small", Size = 35},
  Bold = {Text = "Bold", Bold = 1},
  Red = {
    Text = "Red",
    Remark = "红色",
    Color = "Red,Light"
  },
  LightGray = {
    Text = "LightGray",
    Remark = "灰蓝色",
    Color = "LightGray,Light",
    Size = 35
  },
  Gray = {
    Text = "Gray",
    Remark = "灰蓝色",
    Color = "LightGray,Light"
  },
  BigShake = {
    Text = "BigShake",
    Size = 50,
    Shake = 1
  },
  ShakeBig = {
    Text = "ShakeBig",
    Size = 50,
    Shake = 1
  },
  SmallShake = {
    Text = "SmallShake",
    Size = 35,
    Shake = 1
  },
  ShakeSmall = {
    Text = "ShakeSmall",
    Size = 35,
    Shake = 1
  },
  Italic = {Text = "Italic", Italic = 1},
  BigBold = {
    Text = "BigBold",
    Bold = 1,
    Size = 50
  },
  BoldBig = {
    Text = "BoldBig",
    Bold = 1,
    Size = 50
  },
  BigItalic = {
    Text = "BigItalic",
    Italic = 1,
    Size = 50
  },
  BigBoldRed = {
    Text = "BigBoldRed",
    Remark = "红色",
    Color = "Red,Light",
    Bold = 1,
    Size = 50
  },
  BoldRed = {
    Text = "BoldRed",
    Remark = "红色",
    Color = "Red,Light",
    Bold = 1
  },
  RedBold = {
    Text = "RedBold",
    Remark = "红色",
    Color = "Red,Light",
    Bold = 1
  },
  RedShake = {
    Text = "RedShake",
    Remark = "红色",
    Color = "Red,Light",
    Shake = 1
  },
  RedBig = {
    Text = "RedBig",
    Remark = "红色",
    Color = "Red,Light",
    Size = 50
  },
  EmailDetail_Title = {
    Text = "EmailDetail_Title",
    Remark = "邮箱说明标题字体",
    Color = "TalentNumWhite,Light",
    Size = 36
  },
  RedItalic = {
    Text = "RedItalic",
    Remark = "红色",
    Color = "Red,Light",
    Italic = 1
  },
  GrayItalic = {
    Text = "GrayItalic",
    Remark = "灰蓝色",
    Color = "LightGray,Light",
    Italic = 1
  },
  Title = {
    Text = "Title",
    Remark = "规则说明弹窗的小标题，代码实现非配置"
  },
  WeaponEffect_Num = {
    Text = "WeaponEffect_Num",
    Remark = "武器效果数值颜色",
    Color = "WeaponEffect_Num,Dark"
  },
  SummonOrange = {
    Text = "SummonOrange",
    Remark = "抽卡混沌字色",
    Color = "SummonOrange,Dark"
  },
  SummonBlue = {
    Text = "SummonBlue",
    Remark = "抽卡深海字色",
    Color = "SummonBlue,Dark"
  },
  SummonRed = {
    Text = "SummonRed",
    Remark = "抽卡血肉字色",
    Color = "SummonRed,Dark"
  },
  SummonPurple = {
    Text = "SummonPurple",
    Remark = "抽卡超维字色",
    Color = "SummonPurple,Dark"
  },
  DoubleOutputActivityTimes = {
    Text = "DoubleOutputActivityTimes",
    Remark = "双倍产出剩余次数",
    Color = "UXDouble,Light"
  },
  Claimed = {
    Text = "Claimed",
    Remark = "七日签到活动已领取",
    Color = "Claimed"
  },
  Receive = {
    Text = "Receive",
    Remark = "七日签到活动未领取",
    Color = "Receive"
  },
  TipsHighlightText = {
    Text = "TipsHighlightText",
    Remark = "提示语中的高亮蓝色",
    Color = "UXEmphasize,Dark"
  },
  TutorialHighlight = {
    Text = "TutorialHighlight",
    Remark = "教程高亮提示",
    Color = "TutorialHighlight,Light"
  },
  NetworkDelayGreen = {
    Text = "NetworkDelayGreen",
    Remark = "网络延迟优秀",
    Color = "NetworkDelayGreen,Light"
  },
  NetworkDelayYellow = {
    Text = "NetworkDelayYellow",
    Remark = "网络延迟中等",
    Color = "NetworkDelayYellow,Light"
  },
  NetworkDelayRed = {
    Text = "NetworkDelayRed",
    Remark = "网络延迟较差",
    Color = "NetworkDelayRed,Light"
  },
  Block = {Text = "Block", Color = "blueword"},
  Heal = {Text = "Heal", Color = "greenword"},
  Energy = {Text = "Energy", Color = "yellowword"},
  Damage = {Text = "Damage", Color = "redword"},
  Posse = {Text = "Posse", Color = "whiteword"},
  TipsHighlightText_1 = {
    Text = "TipsHighlightText_1",
    Remark = "提示语中的蓝色",
    Color = "UXEmphasize_1"
  },
  PVPSleepKeywords = {
    Text = "PVPSleepKeywords",
    Remark = "PVP沉眠词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_043",
    ImgPath = "Battle_Card",
    StateLink = 57817
  },
  PVPReciprocalKeywords = {
    Text = "PVPReciprocalKeywords",
    Remark = "PVP倒数时刻词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_042",
    ImgPath = "Battle_Card",
    StateLink = 122443
  },
  PVPOneMeetingKeywords = {
    Text = "PVPOneMeetingKeywords",
    Remark = "PVP一期一会词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 132892
  },
  PVPFierceFightingKeywords = {
    Text = "PVPFierceFightingKeywords",
    Remark = "PVP死斗词缀",
    Color = "whiteword",
    Img = "Battle_Card_Buff_039",
    ImgPath = "Battle_Card",
    StateLink = 19538
  },
  PVPWeaponKeywords = {
    Text = "PVPWeaponKeywords",
    Remark = "PVP命轮词缀",
    Color = "orangeword",
    StateLink = 21765
  },
  PVPFlowerKeywords = {
    Text = "PVPFlowerKeywords",
    Remark = "PVP花与诗词缀",
    Color = "orangeword",
    StateLink = 57317
  },
  PVPDeathResistanceIconKeywords = {
    Text = "PVPDeathResistanceIconKeywords",
    Remark = "PVP死亡抵抗词缀",
    Color = "greenword",
    Img = "Battle_Card_Buff_012",
    ImgPath = "Battle_Card",
    StateLink = 23726
  },
  PVPCriticalStrikeKeywords = {
    Text = "PVPCriticalStrikeKeywords",
    Remark = "PVP暴击词缀",
    Color = "orangeword",
    StateLink = 21492
  },
  PVPEntanglementKeywords = {
    Text = "PVPEntanglementKeywords",
    Remark = "PVP缠绕词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_055",
    ImgPath = "Battle_Card",
    StateLink = 47828
  },
  PVPPowerIconKeywords = {
    Text = "PVPPowerIconKeywords",
    Remark = "PVP力量词缀",
    Color = "greenword",
    Img = "Battle_Card_Buff_021",
    ImgPath = "Battle_Card",
    StateLink = 19521
  },
  PVPResurrectionKeywords = {
    Text = "PVPResurrectionKeywords",
    Remark = "PVP复活词缀",
    Color = "greenword",
    Img = "Battle_Card_Buff_026",
    ImgPath = "Battle_Card",
    StateLink = 47843
  },
  PVPExhaustionKeywords = {
    Text = "PVPExhaustionKeywords",
    Remark = "PVP力量降低词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_037",
    ImgPath = "Battle_Card",
    StateLink = 47827
  },
  DisarmKeywords = {
    Text = "DisarmKeywords",
    Remark = "PVP麻痹词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_054",
    ImgPath = "Battle_Card",
    StateLink = 47826
  },
  TauntKeywords = {
    Text = "TauntKeywords",
    Remark = "PVP嘲讽词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_056",
    ImgPath = "Battle_Card",
    StateLink = 19530
  },
  DelayKeywords = {
    Text = "DelayKeywords",
    Remark = "PVP延迟词缀",
    Color = "orangeword",
    StateLink = 47825
  },
  PVPHoldingKeywords = {
    Text = "PVPHoldingKeywords",
    Remark = "PVP持有词缀",
    Color = "orangeword",
    StateLink = 47845
  },
  SelectKeywords = {
    Text = "SelectKeywords",
    Remark = "PVP抉择词缀",
    Color = "orangeword",
    StateLink = 55811
  },
  PVPCapKeywords = {
    Text = "PVPCapKeywords",
    Remark = "PVP算力上限词缀",
    StateLink = 142954
  },
  PoetryKeywords = {
    Text = "PoetryKeywords",
    Remark = "PVP献诗词缀",
    Color = "orangeword",
    StateLink = 55824
  },
  PrepareKeywords = {
    Text = "PrepareKeywords",
    Remark = "PVP预备词缀",
    Color = "orangeword",
    StateLink = 123812
  },
  PhantomKeywords = {
    Text = "PhantomKeywords",
    Remark = "PVP幻影词缀",
    Color = "orangeword",
    StateLink = 19529
  },
  EnergyStorageKeywords = {
    Text = "EnergyStorageKeywords",
    Remark = "PVP蓄力词缀",
    Color = "greenword",
    Img = "Battle_Card_Buff_030",
    ImgPath = "Battle_Card",
    StateLink = 19544
  },
  ReinforceKeywords = {
    Text = "ReinforceKeywords",
    Remark = "PVP加固词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_046",
    ImgPath = "Battle_Card",
    StateLink = 19549
  },
  PVPSlowKeywords = {
    Text = "PVPSlowKeywords",
    Remark = "PVP迟缓词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_024",
    ImgPath = "Battle_Card",
    StateLink = 19527
  },
  PVPEmptinessKeywords = {
    Text = "PVPEmptinessKeywords",
    Remark = "PVP空虚词缀",
    Color = "yellowword",
    Img = "Battle_Card_Buff_027",
    ImgPath = "Battle_Card",
    StateLink = 47842
  },
  PVPfengsuoKeywords = {
    Text = "PVPfengsuoKeywords",
    Remark = "PVP爆发封锁词缀",
    Color = "whiteword",
    Img = "Battle_Card_Buff_027",
    ImgPath = "Battle_Card",
    StateLink = 66465
  },
  YinniKeywords = {
    Text = "YinniKeywords",
    Remark = "PVP隐匿词缀",
    Color = "whiteword",
    Img = "Battle_Card_Buff_038",
    ImgPath = "Battle_Card",
    StateLink = 66456
  },
  PVPWonderfulEffectKeywords = {
    Text = "PVPWonderfulEffectKeywords",
    Remark = "PVP奇妙效果词缀",
    Color = "yellowword",
    StateLink = 47844
  },
  ComaKeywords = {
    Text = "ComaKeywords",
    Remark = "PVP昏迷词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_023",
    ImgPath = "Battle_Card",
    StateLink = 19992
  },
  PVPPetrifactionKeywords = {
    Text = "PVPPetrifactionKeywords",
    Remark = "PVP石化词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_023",
    ImgPath = "Battle_Card",
    StateLink = 47831
  },
  StrongEffectKeywords = {
    Text = "StrongEffectKeywords",
    Remark = "PVP强效词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_001",
    ImgPath = "Battle_Card",
    StateLink = 59160
  },
  ReduceEffectKeywords = {
    Text = "ReduceEffectKeywords",
    Remark = "PVP强效降低词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_047",
    ImgPath = "Battle_Card",
    StateLink = 59208
  },
  StrengthenKeywords = {
    Text = "StrengthenKeywords",
    Remark = "PVP强化词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_071",
    ImgPath = "Battle_Card",
    StateLink = 19996
  },
  PVPWeaknessKeywords = {
    Text = "PVPWeaknessKeywords",
    Remark = "PVP虚弱词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_005",
    ImgPath = "Battle_Card",
    StateLink = 19533
  },
  PVPMethysisKeywords = {
    Text = "PVPMethysisKeywords",
    Remark = "PVP中毒词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_006",
    ImgPath = "Battle_Card",
    StateLink = 19995
  },
  PVPRetaliateIconKeywords = {
    Text = "PVPRetaliateIconKeywords",
    Remark = "PVP反击词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_019",
    ImgPath = "Battle_Card",
    StateLink = 19998
  },
  PVPBleedingKeywords = {
    Text = "PVPBleedingKeywords",
    Remark = "PVP流血词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_022",
    ImgPath = "Battle_Card",
    StateLink = 47873
  },
  PVPVulnerabilityIconKeywords = {
    Text = "PVPVulnerabilityIconKeywords",
    Remark = "PVP易伤词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_003",
    ImgPath = "Battle_Card",
    StateLink = 19507
  },
  PVPSeriousInjuryKeywords = {
    Text = "PVPSeriousInjuryKeywords",
    Remark = "PVP重创词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_031",
    ImgPath = "Battle_Card",
    StateLink = 47830
  },
  PVPRaidKeywords = {
    Text = "PVPRaidKeywords",
    Remark = "PVP突袭词缀",
    Color = "orangeword",
    StateLink = 22702
  },
  PVPPenetrateKeywords = {
    Text = "PVPPenetrateKeywords",
    Remark = "PVP贯穿词缀",
    Color = "orangeword",
    StateLink = 21720
  },
  PVPProtectiveKeywords = {
    Text = "PVPProtectiveKeywords",
    Remark = "PVP屏障词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_013",
    ImgPath = "Battle_Card",
    StateLink = 45050
  },
  PVPVoidKeywords = {
    Text = "PVPVoidKeywords",
    Remark = "PVP虚无词缀",
    Color = "redword",
    StateLink = 80809
  },
  PVPRetainCostKeywords = {
    Text = "PVPRetainCostKeywords",
    Remark = "PVP保留算力词缀",
    Color = "orangeword",
    StateLink = 91706
  },
  PVPAcheKeywords = {
    Text = "PVPAcheKeywords",
    Remark = "PVP隐没的痛楚词缀",
    Color = "redword",
    StateLink = 91797
  },
  PVPGrowthKeywords = {
    Text = "PVPGrowthKeywords",
    Remark = "PVP成长词缀",
    Color = "orangeword",
    StateLink = 91819
  },
  PVPRepelKeywords = {
    Text = "PVPRepelKeywords",
    Remark = "PVP击退词缀",
    Color = "orangeword",
    StateLink = 94540
  },
  PVPSneakKeywords = {
    Text = "PVPSneakKeywords",
    Remark = "PVP潜行词缀",
    Color = "whiteword",
    Img = "Battle_Card_Buff_038",
    ImgPath = "Battle_Card",
    StateLink = 97252
  },
  PVPCardLockKeywords = {
    Text = "PVPCardLockKeywords",
    Remark = "PVP卡牌封锁词缀",
    Color = "whiteword",
    Img = "Battle_Card_Buff_044",
    ImgPath = "Battle_Card",
    StateLink = 116958
  },
  PVPCorrosionKeywords = {
    Text = "PVPCorrosionKeywords",
    Remark = "PVP罪印词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_078",
    ImgPath = "Battle_Card",
    StateLink = 117745
  },
  PVPSacrificeKeyWords = {
    Text = "PVPSacrificeKeyWords",
    Remark = "PVP献祭词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_041",
    ImgPath = "Battle_Card",
    StateLink = 119051
  },
  PVPLostSoulKeyWords = {
    Text = "PVPLostSoulKeyWords",
    Remark = "PVP摄魂词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_080",
    ImgPath = "Battle_Card",
    StateLink = 121797
  },
  PVPWaterPowerKeyWords = {
    Text = "PVPWaterPowerKeyWords",
    Remark = "PVP水流词缀",
    Color = "blueword",
    Img = "Battle_Card_Buff_081",
    ImgPath = "Battle_Card",
    StateLink = 123246
  },
  PVPDestinedDeathKeyWords = {
    Text = "PVPDestinedDeathKeyWords",
    Remark = "PVP命定之死词缀",
    Color = "purpleword",
    StateLink = 124917
  },
  PVPEternalDimensionKeyWords = {
    Text = "PVPEternalDimensionKeyWords",
    Remark = "PVP永恒维度词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_084",
    ImgPath = "Battle_Card",
    StateLink = 124997
  },
  PVPCognitiveDissonanceKeyWords = {
    Text = "PVPCognitiveDissonanceKeyWords",
    Remark = "PVP认知错乱词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_008",
    ImgPath = "Battle_Card",
    StateLink = 140672
  },
  PVPFeatheredSeedsKeyWords = {
    Text = "PVPFeatheredSeedsKeyWords",
    Remark = "PVP羽种词缀",
    Color = "whiteword",
    Img = "Battle_Card_Buff_087",
    ImgPath = "Battle_Card",
    StateLink = 140489
  },
  PVPDiscoveryKeyWords = {
    Text = "PVPDiscoveryKeyWords",
    Remark = "PVP发现词缀",
    Color = "orangeword",
    StateLink = 141989
  },
  PVPCompassKeywords = {
    Text = "PVPCompassKeywords",
    Remark = "PVP指向歧路的罗盘词缀",
    Color = "orangeword",
    StateLink = 143409
  },
  PVPPunctureDamagewords = {
    Text = "PVPPunctureDamagewords",
    Remark = "PVP穿刺伤害词缀",
    Color = "orangeword",
    StateLink = 22134
  },
  PVPFusion = {
    Text = "PVPFusion",
    Remark = "PVP融合词缀",
    Color = "orangeword",
    StateLink = 145590
  },
  PVPLock = {
    Text = "PVPLock",
    Remark = "PVP锁定词缀",
    Color = "orangeword",
    StateLink = 145592
  },
  PVPBless = {
    Text = "PVPBless",
    Remark = "PVP赐福词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_025",
    ImgPath = "Battle_Card",
    StateLink = 146154
  },
  PVPBluff = {
    Text = "PVPBluff",
    Remark = "PVP忽悠词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_023",
    ImgPath = "Battle_Card",
    StateLink = 146202
  },
  PVPWeaknessesKeywords = {
    Text = "PVPWeaknessesKeywords",
    Remark = "PVP破绽词缀",
    Color = "orangeword",
    StateLink = 96740
  },
  PVPOverloadKeywords = {
    Text = "PVPOverloadKeywords",
    Remark = "PVP算力超载词缀",
    Color = "orangeword",
    StateLink = 96743
  },
  MaxHPKeywords = {
    Text = "MaxHPKeywords",
    Remark = "PVP最大生命词缀",
    Color = "greenword",
    Img = "Battle_Card_Buff_020",
    ImgPath = "Battle_Card",
    StateLink = 23871
  },
  PVPMouseKeywords = {
    Text = "PVPMouseKeywords",
    Remark = "PVP老鼠牌词缀",
    Color = "orangeword",
    StateLink = 47832
  },
  PVPAmazingMagicKeywords = {
    Text = "PVPAmazingMagicKeywords",
    Remark = "PVP惊人魔术词缀",
    Color = "orangeword",
    StateLink = 47833
  },
  PVPAlertKeywords = {
    Text = "PVPAlertKeywords",
    Remark = "PVP戒备词缀",
    Color = "blueword",
    StateLink = 22405
  },
  HPAndShieldMin = {
    Text = "HPAndShieldMin",
    Remark = "生命与护盾最低",
    StateLink = 145456
  },
  HPAndShieldMax = {
    Text = "HPAndShieldMax",
    Remark = "生命与护盾最高",
    StateLink = 145457
  },
  PVPDerivativeCardKeywords_1 = {
    Text = "PVPDerivativeCardKeywords_1",
    Remark = "衍生卡词缀",
    SkillLink = 45651
  },
  PVPDerivativeCardKeywords_2 = {
    Text = "PVPDerivativeCardKeywords_2",
    Remark = "衍生卡词缀",
    SkillLink = 19419
  },
  PVPDerivativeCardKeywords_3 = {
    Text = "PVPDerivativeCardKeywords_3",
    Remark = "衍生卡词缀",
    SkillLink = 45063
  },
  PVPDerivativeCardKeywords_4 = {
    Text = "PVPDerivativeCardKeywords_4",
    Remark = "衍生卡词缀",
    SkillLink = 45680
  },
  PVPDerivativeCardKeywords_5 = {
    Text = "PVPDerivativeCardKeywords_5",
    Remark = "衍生卡词缀",
    SkillLink = 45679
  },
  PVPDerivativeCardKeywords_6 = {
    Text = "PVPDerivativeCardKeywords_6",
    Remark = "衍生卡词缀",
    SkillLink = 45682
  },
  PVPDerivativeCardKeywords_7 = {
    Text = "PVPDerivativeCardKeywords_7",
    Remark = "衍生卡词缀",
    SkillLink = 45681
  },
  PVPDerivativeCardKeywords_8 = {
    Text = "PVPDerivativeCardKeywords_8",
    Remark = "衍生卡词缀",
    SkillLink = 45678
  },
  PVPDerivativeCardKeywords_9 = {
    Text = "PVPDerivativeCardKeywords_9",
    Remark = "衍生卡词缀",
    SkillLink = 45683
  },
  PVPDerivativeCardKeywords_10 = {
    Text = "PVPDerivativeCardKeywords_10",
    Remark = "衍生卡词缀",
    SkillLink = 45684
  },
  PVPDerivativeCardKeywords_11 = {
    Text = "PVPDerivativeCardKeywords_11",
    Remark = "衍生卡词缀",
    SkillLink = 19343
  },
  PVPDerivativeCardKeywords_12 = {
    Text = "PVPDerivativeCardKeywords_12",
    Remark = "衍生卡词缀",
    SkillLink = 19489
  },
  PVPDerivativeCardKeywords_13 = {
    Text = "PVPDerivativeCardKeywords_13",
    Remark = "衍生卡词缀",
    SkillLink = 45367
  },
  PVPDerivativeCardKeywords_14 = {
    Text = "PVPDerivativeCardKeywords_14",
    Remark = "衍生卡词缀",
    SkillLink = 45601
  },
  PVPDerivativeCardKeywords_15 = {
    Text = "PVPDerivativeCardKeywords_15",
    Remark = "衍生卡词缀",
    SkillLink = 70358
  },
  PVPDerivativeCardKeywords_16 = {
    Text = "PVPDerivativeCardKeywords_16",
    Remark = "衍生卡词缀",
    SkillLink = 89428
  },
  PVPDerivativeCardKeywords_17 = {
    Text = "PVPDerivativeCardKeywords_17",
    Remark = "衍生卡词缀",
    SkillLink = 89659
  },
  PVPDerivativeCardKeywords_18 = {
    Text = "PVPDerivativeCardKeywords_18",
    Remark = "衍生卡词缀",
    SkillLink = 117178
  },
  PVPDerivativeCardKeywords_19 = {
    Text = "PVPDerivativeCardKeywords_19",
    Remark = "衍生卡词缀",
    SkillLink = 117175
  },
  PVPDerivativeCardKeywords_20 = {
    Text = "PVPDerivativeCardKeywords_20",
    Remark = "衍生卡词缀",
    SkillLink = 117173
  },
  PVPDerivativeCardKeywords_21 = {
    Text = "PVPDerivativeCardKeywords_21",
    Remark = "衍生卡词缀",
    SkillLink = 45269
  },
  PVPDerivativeCardKeywords_22 = {
    Text = "PVPDerivativeCardKeywords_22",
    Remark = "衍生卡词缀",
    SkillLink = 19394
  },
  PVPDerivativeCardKeywords_23 = {
    Text = "PVPDerivativeCardKeywords_23",
    Remark = "衍生卡词缀",
    SkillLink = 19499
  },
  PVPDerivativeCardKeywords_24 = {
    Text = "PVPDerivativeCardKeywords_24",
    Remark = "衍生卡词缀"
  },
  PVPDerivativeCardKeywords_25 = {
    Text = "PVPDerivativeCardKeywords_25",
    Remark = "衍生卡词缀",
    SkillLink = 122656
  },
  PVPDerivativeCardKeywords_26 = {
    Text = "PVPDerivativeCardKeywords_26",
    Remark = "衍生卡词缀",
    SkillLink = 130944
  },
  PVPDerivativeCardKeywords_27 = {
    Text = "PVPDerivativeCardKeywords_27",
    Remark = "衍生卡词缀",
    SkillLink = 130947
  },
  PVPDerivativeCardKeywords_28 = {
    Text = "PVPDerivativeCardKeywords_28",
    Remark = "衍生卡词缀",
    SkillLink = 130928
  },
  PVPDerivativeCardKeywords_29 = {
    Text = "PVPDerivativeCardKeywords_29",
    Remark = "衍生卡词缀",
    SkillLink = 78915
  },
  PVPDerivativeCardKeywords_30 = {
    Text = "PVPDerivativeCardKeywords_30",
    Remark = "衍生卡词缀",
    SkillLink = 142874
  },
  PVPDerivativeCardKeywords_31 = {
    Text = "PVPDerivativeCardKeywords_31",
    Remark = "衍生卡词缀",
    SkillLink = 45252
  },
  PVPDerivativeCardKeywords_32 = {
    Text = "PVPDerivativeCardKeywords_32",
    Remark = "衍生卡词缀",
    SkillLink = 145562
  },
  PVPDerivativeCardKeywords_33 = {
    Text = "PVPDerivativeCardKeywords_33",
    Remark = "衍生卡词缀"
  },
  PVPDerivativeCardKeywords_34 = {
    Text = "PVPDerivativeCardKeywords_34",
    Remark = "衍生卡词缀"
  },
  PVPDerivativeCardKeywords_35 = {
    Text = "PVPDerivativeCardKeywords_35",
    Remark = "衍生卡词缀"
  },
  PVPDerivativeCardKeywords_36 = {
    Text = "PVPDerivativeCardKeywords_36",
    Remark = "衍生卡词缀"
  },
  MaxHPColour = {
    Text = "MaxHPColour",
    Remark = "PVP最大颜色词缀",
    Color = "greenword"
  },
  EnergyStorageColour = {
    Text = "EnergyStorageColour",
    Remark = "PVP蓄力颜色词缀",
    Color = "greenword"
  },
  TauntColour = {
    Text = "TauntColour",
    Remark = "PVP嘲讽颜色词缀",
    Color = "redword"
  },
  ReinforceColour = {
    Text = "ReinforceColour",
    Remark = "PVP加固颜色词缀",
    Color = "blueword"
  },
  ComaColour = {
    Text = "ComaColour",
    Remark = "PVP昏迷颜色词缀",
    Color = "orangeword"
  },
  StrengthenColour = {
    Text = "StrengthenColour",
    Remark = "PVP强化颜色词缀",
    Color = "orangeword"
  },
  PVPVulnerabilityIconColour = {
    Text = "PVPVulnerabilityIconColour",
    Remark = "PVP易伤词缀",
    Color = "redword"
  },
  PVPEmptinessColour = {
    Text = "PVPEmptinessColour",
    Remark = "PVP空虚颜色词缀",
    Color = "yellowword"
  },
  PVPfengsuoColour = {
    Text = "PVPfengsuoColour",
    Remark = "PVP爆发封锁颜色词缀",
    Color = "whiteword"
  },
  PVPCardLockColour = {
    Text = "PVPCardLockColour",
    Remark = "PVP卡牌封锁颜色词缀",
    Color = "whiteword"
  },
  PVPResurrectionColour = {
    Text = "PVPResurrectionColour",
    Remark = "PVP复活颜色词缀",
    Color = "greenword"
  },
  PVPredKeyword = {
    Text = "PVPredKeyword",
    Remark = "PVP红字词缀",
    Color = "redword"
  },
  PVPVoidKeyColour = {
    Text = "PVPVoidKeyColour",
    Remark = "PVP虚无颜色词缀",
    Color = "redword"
  },
  PVPBlessColour = {
    Text = "PVPBlessColour",
    Remark = "PVP赐福词缀颜色词缀",
    Color = "purpleword"
  },
  FeatureUnlockTitle = {
    Text = "FeatureUnlockTitle",
    Remark = "功能解锁弹窗标题",
    Color = "FeatureUnlockTitle",
    Size = 36
  },
  FeatureUnlockDesc = {
    Text = "FeatureUnlockDesc",
    Remark = "功能解锁描述",
    Color = "FeatureUnlockDesc",
    Size = 32
  },
  GrayState = {
    Text = "GrayState",
    Remark = "灰态",
    Color = "GrayState",
    Size = 24
  },
  O06_AFKeyWord1 = {
    Text = "O06_AFKeyWord1",
    Remark = "篡夺词缀",
    Color = "orangeword"
  },
  O06_AFKeyWord2 = {
    Text = "O06_AFKeyWord2",
    Remark = "蛰伏词缀",
    Color = "orangeword"
  },
  AwakerCard_24Now = {
    Text = "AwakerCard_24Now",
    Remark = "24当前人格高亮词缀"
  },
  AwakerCard_24Lost = {
    Text = "AwakerCard_24Lost",
    Remark = "24非当前人格高亮词缀",
    Color = "Color24CardLost"
  },
  RealDamage = {
    Text = "RealDamage",
    Remark = "固定伤害",
    Color = "orangeword",
    StateLink = 149418
  },
  FixedDamage = {
    Text = "FixedDamage",
    Remark = "纯粹伤害",
    Color = "orangeword",
    StateLink = 149652
  },
  TaskFinish = {
    Text = "TaskFinish",
    Remark = "完成态绿色",
    Color = "TaskFinish"
  },
  DayTime = {
    Text = "DayTime",
    Remark = "浅黑色",
    Color = "DayTime"
  },
  Gray1 = {
    Text = "Gray1",
    Remark = "灰色",
    Color = "Gray1"
  },
  OverLimitUtlSkillKeywords = {
    Text = "OverLimitUtlSkillKeywords",
    Remark = "超限爆发词缀",
    Color = "orangeword",
    StateLink = 54416
  },
  UltraPotencyKeywords = {
    Text = "UltraPotencyKeywords",
    Remark = "最终法则词缀",
    Color = "orangeword",
    StateLink = 127312
  },
  C05_yansheng1 = {
    Text = "C05_yansheng1",
    Remark = "欢乐骰子词缀",
    SkillLink = 57860
  },
  C05_yansheng2 = {
    Text = "C05_yansheng2",
    Remark = "终极欢乐骰子词缀",
    SkillLink = 57859
  },
  C05_zaowu = {
    Text = "C05_zaowu",
    Remark = "造物词缀",
    StateLink = 58447
  },
  Qunxingzhijiu = {
    Text = "Qunxingzhijiu",
    Remark = "群星之酒词缀",
    Color = "OrangeQuality,Dark",
    StateLink = 66522
  },
  Shiluozhimei = {
    Text = "Shiluozhimei",
    Remark = "失落之美词缀",
    Color = "SchoolQuialty,Dark",
    StateLink = 66559
  },
  Wushangrongchong = {
    Text = "Wushangrongchong",
    Remark = "无上荣宠词缀",
    Color = "OrangeQuality,Dark",
    StateLink = 66557
  },
  Chunzhiji = {
    Text = "Chunzhiji",
    Remark = "春之祭词缀",
    Color = "WhiteQuality,Dark",
    StateLink = 66561
  },
  Etong = {
    Text = "Etong",
    Remark = "恶童词缀",
    Color = "WhiteQuality,Dark",
    StateLink = 66558
  },
  Renyuleizhu = {
    Text = "Renyuleizhu",
    Remark = "人鱼泪珠词缀",
    Color = "WhiteQuality,Dark",
    StateLink = 66566
  },
  Huoxingzhusheqi = {
    Text = "Huoxingzhusheqi",
    Remark = "活性注射器词缀",
    Color = "WhiteQuality,Dark",
    StateLink = 66555
  },
  Zhanxindeqianbao = {
    Text = "Zhanxindeqianbao",
    Remark = "崭新的钱包词缀",
    Color = "WhiteQuality,Dark",
    StateLink = 66563
  },
  Jingmijishiqi = {
    Text = "Jingmijishiqi",
    Remark = "精密计时器词缀",
    Color = "WhiteQuality,Dark",
    StateLink = 66556
  },
  Canquemiankong = {
    Text = "Canquemiankong",
    Remark = "残缺面孔词缀",
    Color = "RedQuality,Dark",
    StateLink = 66553
  },
  Kuailechangpian = {
    Text = "Kuailechangpian",
    Remark = "快乐唱片词缀",
    Color = "RedQuality,Dark",
    StateLink = 66560
  },
  Xingdaozhihai = {
    Text = "Xingdaozhihai",
    Remark = "行道之骸词缀",
    Color = "RedQuality,Dark",
    StateLink = 66562
  },
  Biansejushufu = {
    Text = "Biansejushufu",
    Remark = "变色拘束服词缀",
    Color = "WhiteQuality,Dark",
    StateLink = 66565
  },
  Huaibiaojing = {
    Text = "Huaibiaojing",
    Remark = "怀表镜词缀",
    Color = "WhiteQuality,Dark",
    StateLink = 66564
  },
  Tongxunshebei = {
    Text = "Tongxunshebei",
    Remark = "通讯设备词缀",
    Color = "WhiteQuality,Dark",
    StateLink = 66554
  },
  Zhongsuo = {
    Text = "Zhongsuo",
    Remark = "重锁",
    Color = "WhiteQuality,Dark",
    StateLink = 67641
  },
  Jierizhufu = {
    Text = "Jierizhufu",
    Remark = "节日祝福",
    Color = "WhiteQuality,Dark",
    StateLink = 67645
  },
  Misagehuizhang = {
    Text = "Misagehuizhang",
    Remark = "弥萨格徽章",
    Color = "WhiteQuality,Dark",
    StateLink = 67703
  },
  Wwenmingzhiguang = {
    Text = "Wwenmingzhiguang",
    Remark = "文明之光",
    Color = "WhiteQuality,Dark",
    StateLink = 67620
  },
  Geyushan = {
    Text = "Geyushan",
    Remark = "鸽羽扇",
    Color = "WhiteQuality,Dark",
    StateLink = 67605
  },
  Baiyahui = {
    Text = "Baiyahui",
    Remark = "白鸦喙",
    Color = "WhiteQuality,Dark",
    StateLink = 67668
  },
  Yishengshoutixiang = {
    Text = "Yishengshoutixiang",
    Remark = "医生手提箱",
    Color = "WhiteQuality,Dark",
    StateLink = 67598
  },
  Shihengdetianping = {
    Text = "Shihengdetianping",
    Remark = "失衡的天平",
    Color = "WhiteQuality,Dark",
    StateLink = 67634
  },
  Meilishunjian = {
    Text = "Meilishunjian",
    Remark = "美丽瞬间",
    Color = "WhiteQuality,Dark",
    StateLink = 67612
  },
  Chansimanao = {
    Text = "Chansimanao",
    Remark = "缠丝玛瑙",
    Color = "WhiteQuality,Dark",
    StateLink = 67666
  },
  Meixueyuanli = {
    Text = "Meixueyuanli",
    Remark = "美学原理",
    Color = "WhiteQuality,Dark",
    StateLink = 67636
  },
  Shishengchangji = {
    Text = "Shishengchangji",
    Remark = "失声唱机",
    Color = "WhiteQuality,Dark",
    StateLink = 67625
  },
  Dingxiangluopan = {
    Text = "Dingxiangluopan",
    Remark = "定向罗盘",
    Color = "WhiteQuality,Dark",
    StateLink = 67673
  },
  Yixiangyoupiaojia = {
    Text = "Yixiangyoupiaojia",
    Remark = "异乡邮票夹",
    Color = "WhiteQuality,Dark",
    StateLink = 67662
  },
  Guaishecantui = {
    Text = "Guaishecantui",
    Remark = "怪蛇残蜕",
    Color = "OrangeQuality,Dark",
    StateLink = 67674
  },
  Xiushiliuyedao = {
    Text = "Xiushiliuyedao",
    Remark = "锈蚀柳叶刀",
    Color = "WhiteQuality,Dark",
    StateLink = 67660
  },
  Jisiquanzhang = {
    Text = "Jisiquanzhang",
    Remark = "祭司权杖",
    Color = "OrangeQuality,Dark",
    StateLink = 67603
  },
  Qiuzhidushulun = {
    Text = "Qiuzhidushulun",
    Remark = "求知读书轮",
    Color = "OrangeQuality,Dark",
    StateLink = 67670
  },
  Aerkanajilu = {
    Text = "Aerkanajilu",
    Remark = "阿尔卡纳记录",
    Color = "OrangeQuality,Dark",
    StateLink = 67626
  },
  Yuanxingdianchi = {
    Text = "Yuanxingdianchi",
    Remark = "原型电池",
    Color = "OrangeQuality,Dark",
    StateLink = 67667
  },
  Zaixiguangli = {
    Text = "Zaixiguangli",
    Remark = "在夕光里",
    Color = "OrangeQuality,Dark",
    StateLink = 67615
  },
  Womendejia = {
    Text = "Womendejia",
    Remark = "我们的家",
    Color = "OrangeQuality,Dark",
    StateLink = 67643
  },
  Riyuelunpan = {
    Text = "Riyuelunpan",
    Remark = "日月轮盘",
    Color = "OrangeQuality,Dark",
    StateLink = 67646
  },
  Beiyiwangzhezhixue = {
    Text = "Beiyiwangzhezhixue",
    Remark = "被遗忘者之血",
    Color = "OrangeQuality,Dark",
    StateLink = 67653
  },
  Wumingzhishenmiansha = {
    Text = "Wumingzhishenmiansha",
    Remark = "无名之神的面纱",
    Color = "OrangeQuality,Dark",
    StateLink = 67704
  },
  Qunmengzhige = {
    Text = "Qunmengzhige",
    Remark = "群氓之歌",
    Color = "OrangeQuality,Dark",
    StateLink = 67606
  },
  Wanxianglingzhimiyi = {
    Text = "Wanxianglingzhimiyi",
    Remark = "万象灵知秘仪",
    Color = "OrangeQuality,Dark",
    StateLink = 67657
  },
  Xiaoxiaoqiangbao = {
    Text = "Xiaoxiaoqiangbao",
    Remark = "小小襁褓",
    Color = "OrangeQuality,Dark",
    StateLink = 67607
  },
  Chenzhonghuakuang = {
    Text = "Chenzhonghuakuang",
    Remark = "沉重画框",
    Color = "OrangeQuality,Dark",
    StateLink = 67677
  },
  Guhuofengling = {
    Text = "Guhuofengling",
    Remark = "蛊惑风铃",
    Color = "RedQuality,Dark",
    StateLink = 67649
  },
  Guguaigouzhua = {
    Text = "Guguaigouzhua",
    Remark = "古怪钩爪",
    Color = "RedQuality,Dark",
    StateLink = 67656
  },
  Eyunyishiniao = {
    Text = "Eyunyishiniao",
    Remark = "厄运仪式鸟",
    Color = "RedQuality,Dark",
    StateLink = 67609
  },
  Guishulimao = {
    Text = "Guishulimao",
    Remark = "诡术礼帽",
    Color = "RedQuality,Dark",
    StateLink = 67637
  },
  Heizhu = {
    Text = "Heizhu",
    Remark = "黑烛",
    Color = "RedQuality,Dark",
    StateLink = 67631
  },
  Slbyan = {
    Text = "Slbyan",
    Remark = "时灵摆 · 眼",
    Color = "SchoolQuialty,Dark",
    StateLink = 67658
  },
  Slbyuyi = {
    Text = "Slbyuyi",
    Remark = "时灵摆 · 羽翼",
    Color = "SchoolQuialty,Dark",
    StateLink = 67665
  },
  Slbshuangsheng = {
    Text = "Slbshuangsheng",
    Remark = "时灵摆 · 双生",
    Color = "SchoolQuialty,Dark",
    StateLink = 67650
  },
  Slbyiyong = {
    Text = "Slbyiyong",
    Remark = "时灵摆 · 移涌",
    Color = "SchoolQuialty,Dark",
    StateLink = 67640
  },
  Slbbujie = {
    Text = "Slbbujie",
    Remark = "时灵摆 · 不洁",
    Color = "SchoolQuialty,Dark",
    StateLink = 67651
  },
  Slbbumian = {
    Text = "Slbbumian",
    Remark = "时灵摆 · 不眠",
    Color = "SchoolQuialty,Dark",
    StateLink = 67661
  },
  Slbtoushe = {
    Text = "Slbtoushe",
    Remark = "时灵摆 · 投射",
    Color = "SchoolQuialty,Dark",
    StateLink = 67599
  },
  Slbyanhua = {
    Text = "Slbyanhua",
    Remark = "时灵摆 · 衍化",
    Color = "SchoolQuialty,Dark",
    StateLink = 67604
  },
  Szemengbiaoxiang = {
    Text = "Szemengbiaoxiang",
    Remark = "受祝·噩梦表象",
    Color = "SchoolQuialty,Dark",
    StateLink = 67614
  },
  Szchongqunyishi = {
    Text = "Szchongqunyishi",
    Remark = "受祝·虫群意识",
    Color = "SchoolQuialty,Dark",
    StateLink = 67671
  },
  Szeyunyishiniao = {
    Text = "Szeyunyishiniao",
    Remark = "受祝·厄运仪式鸟",
    Color = "SchoolQuialty,Dark",
    StateLink = 67621
  },
  Szyishimingke = {
    Text = "Szyishimingke",
    Remark = "受祝·意识铭刻",
    Color = "SchoolQuialty,Dark",
    StateLink = 67619
  },
  Szguguaigouzhua = {
    Text = "Szguguaigouzhua",
    Remark = "受祝·古怪钩爪",
    Color = "SchoolQuialty,Dark",
    StateLink = 67639
  },
  Szqisaimanzhiwen = {
    Text = "Szqisaimanzhiwen",
    Remark = "受祝·七鳃鳗之吻",
    Color = "SchoolQuialty,Dark",
    StateLink = 67623
  },
  Szheizhu = {
    Text = "Szheizhu",
    Remark = "受祝·黑烛",
    Color = "SchoolQuialty,Dark",
    StateLink = 67600
  },
  Szxingdaozhihai = {
    Text = "Szxingdaozhihai",
    Remark = "受祝·行道之骸",
    Color = "SchoolQuialty,Dark",
    StateLink = 67611
  },
  Jiaqunxingzhijiu = {
    Text = "Jiaqunxingzhijiu",
    Remark = "群星之酒+",
    Color = "SchoolQuialty,Dark",
    StateLink = 67647
  },
  Jiatongxunshebei = {
    Text = "Jiatongxunshebei",
    Remark = "通讯设备+",
    Color = "SchoolQuialty,Dark",
    StateLink = 67635
  },
  Jiariyuelunpan = {
    Text = "Jiariyuelunpan",
    Remark = "日月轮盘+",
    Color = "SchoolQuialty,Dark",
    StateLink = 67675
  },
  Jiajisiquanzhang = {
    Text = "Jiajisiquanzhang",
    Remark = "祭司权杖+",
    Color = "SchoolQuialty,Dark",
    StateLink = 67638
  },
  Jiatuisezhaopian = {
    Text = "Jiatuisezhaopian",
    Remark = "褪色照片+",
    Color = "SchoolQuialty,Dark",
    StateLink = 67672
  },
  Yinbaichaifenji = {
    Text = "Yinbaichaifenji",
    Remark = "银白差分机",
    Color = "SchoolQuialty,Dark",
    StateLink = 67622
  },
  Jiaqunmengzhige = {
    Text = "Jiaqunmengzhige",
    Remark = "群氓之歌+",
    Color = "SchoolQuialty,Dark",
    StateLink = 67659
  },
  Shuaxinbaiyin = {
    Text = "Shuaxinbaiyin",
    Remark = "刷新白银",
    Color = "WhiteQuality,Dark"
  },
  Shuaxinhuangjin = {
    Text = "Shuaxinhuangjin",
    Remark = "刷新黄金",
    Color = "OrangeQuality,Dark"
  },
  Shuaxinzuzhou = {
    Text = "Shuaxinzuzhou",
    Remark = "刷新诅咒",
    Color = "RedQuality,Dark"
  },
  Shuaxinlengcai = {
    Text = "Shuaxinlengcai",
    Remark = "刷新棱彩",
    Color = "SchoolQuialty,Dark"
  },
  Zhennu = {
    Text = "Zhennu",
    Remark = "震怒",
    Color = "SchoolQuialty,Dark",
    SkillLink = 70015
  },
  Zhennu2 = {
    Text = "Zhennu2",
    Remark = "震怒Ⅱ",
    Color = "SchoolQuialty,Dark",
    SkillLink = 70013
  },
  Zhennu3 = {
    Text = "Zhennu3",
    Remark = "震怒Ⅲ",
    Color = "SchoolQuialty,Dark",
    SkillLink = 70014
  },
  Zhongmowuqiling = {
    Text = "Zhongmowuqiling",
    Remark = "终末",
    StateLink = 70443
  },
  Kuangre = {
    Text = "Kuangre",
    Remark = "狂热词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 94623
  },
  Guaiwuheiyu = {
    Text = "Guaiwuheiyu",
    Remark = "怪物黑羽词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 91759
  },
  Guaiwucanhai = {
    Text = "Guaiwucanhai",
    Remark = "怪物残骸",
    Color = "redword",
    Img = "Battle_Card_Buff_076",
    ImgPath = "Battle_Card",
    StateLink = 95967
  },
  Guaiwusiwangdikang = {
    Text = "Guaiwusiwangdikang",
    Remark = "怪物死亡抵抗",
    Color = "greenword",
    Img = "Battle_Card_Buff_012",
    ImgPath = "Battle_Card",
    StateLink = 94692
  },
  Duren = {
    Text = "Duren",
    Remark = "毒刃",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 95035
  },
  Kuangbao = {
    Text = "Kuangbao",
    Remark = "狂暴",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 95038
  },
  Baojidikang = {
    Text = "Baojidikang",
    Remark = "暴击抵抗",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 96358
  },
  Dongjie = {
    Text = "Dongjie",
    Remark = "冻结",
    Color = "orangeword",
    StateLink = 62338
  },
  Fennu = {
    Text = "Fennu",
    Remark = "愤怒",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 96357
  },
  Heat = {
    Text = "Heat",
    Remark = "热量",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 96732
  },
  Overload = {
    Text = "Overload",
    Remark = "爆燃超载",
    SkillLink = 98508
  },
  BurningColor = {
    Text = "BurningColor",
    Remark = "燃烧颜色",
    Color = "redword"
  },
  Kuangluan = {
    Text = "Kuangluan",
    Remark = "污染:蹈海者狂乱",
    Color = "orangeword",
    StateLink = 97119
  },
  Chaos = {
    Text = "Chaos",
    Remark = "混乱",
    StateLink = 96784
  },
  Daohaizheyishi = {
    Text = "Daohaizheyishi",
    Remark = "蹈海者之仪式生祭",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 96783
  },
  PrimaryColor = {
    Text = "PrimaryColor",
    Remark = "原色",
    StateLink = 98474
  },
  GreenWord = {
    Text = "GreenWord",
    Remark = "绿色",
    Color = "greenword"
  },
  LostWay = {
    Text = "LostWay",
    Remark = "迷失",
    StateLink = 98912
  },
  DecayDye = {
    Text = "DecayDye",
    Remark = "腐朽染料",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 99336
  },
  MindWall = {
    Text = "MindWall",
    Remark = "心灵壁垒",
    StateLink = 100327
  },
  BarrierCrash = {
    Text = "BarrierCrash",
    Remark = "壁垒崩解",
    StateLink = 100330
  },
  TrueConfess = {
    Text = "TrueConfess",
    Remark = "剖白",
    StateLink = 100328
  },
  ShadowSelf = {
    Text = "ShadowSelf",
    Remark = "人格阴影",
    StateLink = 100329
  },
  DarkEgo = {
    Text = "DarkEgo",
    Remark = "自我暗面",
    StateLink = 100326
  },
  FlickeringCandle = {
    Text = "FlickeringCandle",
    Remark = "微弱烛光",
    StateLink = 100621
  },
  LightOfTheLost = {
    Text = "LightOfTheLost",
    Remark = "迷航之光",
    StateLink = 100694
  },
  TeamUnique = {
    Text = "TeamUnique",
    Remark = "密契队伍唯一提示",
    Color = "orangeword",
    StateLink = 117154
  },
  FishLeapWords = {
    Text = "FishLeapWords",
    Remark = "鱼群飞跃",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 117889
  },
  Decay = {
    Text = "Decay",
    Remark = "腐朽",
    Color = "purpleword",
    Img = "Battle_Card_Buff_014",
    ImgPath = "Battle_Card",
    StateLink = 119960
  },
  Undercurrent = {
    Text = "Undercurrent",
    Remark = "暗流",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 120908
  },
  Abyssallock = {
    Text = "Abyssallock",
    Remark = "深渊之锁",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 119757
  },
  Abyssallock2 = {
    Text = "Abyssallock2",
    Remark = "临时深渊之锁",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 119749
  },
  BlueBold = {
    Text = "BlueBold",
    Remark = "蓝色+粗体",
    Color = "Blue,Light",
    Bold = 1
  },
  BoldBlue = {
    Text = "BoldBlue",
    Remark = "粗体+蓝色",
    Color = "Blue,Light",
    Bold = 1
  },
  BlueItalic = {
    Text = "BlueItalic",
    Remark = "蓝色+斜体",
    Color = "Blue,Light",
    Italic = 1
  },
  ItalicBlue = {
    Text = "ItalicBlue",
    Remark = "斜体+蓝色",
    Color = "Blue,Light",
    Italic = 1
  },
  BlueBig = {
    Text = "BlueBig",
    Remark = "蓝色+大号",
    Color = "Blue,Light",
    Size = 50
  },
  BigBlue = {
    Text = "BigBlue",
    Remark = "大号+蓝色",
    Color = "Blue,Light",
    Size = 50
  },
  BlueSmall = {
    Text = "BlueSmall",
    Remark = "蓝色+小号",
    Color = "Blue,Light",
    Size = 35
  },
  SmallBlue = {
    Text = "SmallBlue",
    Remark = "小号+蓝色",
    Color = "Blue,Light",
    Size = 35
  },
  BlueShake = {
    Text = "BlueShake",
    Remark = "蓝色+抖动",
    Color = "Blue,Light",
    Shake = 1
  },
  ShakeBlue = {
    Text = "ShakeBlue",
    Remark = "抖动+蓝色",
    Color = "Blue,Light",
    Shake = 1
  },
  ItalicRed = {
    Text = "ItalicRed",
    Remark = "斜体+红色",
    Color = "Red,Light",
    Italic = 1
  },
  BigRed = {
    Text = "BigRed",
    Remark = "大号+红色",
    Color = "Red,Light",
    Size = 50
  },
  RedSmall = {
    Text = "RedSmall",
    Remark = "红色+小号",
    Color = "Red,Light",
    Size = 35
  },
  SmallRed = {
    Text = "SmallRed",
    Remark = "小号+红色",
    Color = "Red,Light",
    Size = 35
  },
  ShakeRed = {
    Text = "ShakeRed",
    Remark = "抖动+红色",
    Color = "Red,Light",
    Shake = 1
  },
  YellowBold = {
    Text = "YellowBold",
    Remark = "黄色+粗体",
    Color = "Yellow,Light",
    Bold = 1
  },
  BoldYellow = {
    Text = "BoldYellow",
    Remark = "粗体+黄色",
    Color = "Yellow,Light",
    Bold = 1
  },
  YellowItalic = {
    Text = "YellowItalic",
    Remark = "黄色+斜体",
    Color = "Yellow,Light",
    Italic = 1
  },
  ItalicYellow = {
    Text = "ItalicYellow",
    Remark = "斜体+黄色",
    Color = "Yellow,Light",
    Italic = 1
  },
  YellowBig = {
    Text = "YellowBig",
    Remark = "黄色+大号",
    Color = "Yellow,Light",
    Size = 50
  },
  BigYellow = {
    Text = "BigYellow",
    Remark = "大号+黄色",
    Color = "Yellow,Light",
    Size = 50
  },
  YellowSmall = {
    Text = "YellowSmall",
    Remark = "黄色+小号",
    Color = "Yellow,Light",
    Size = 35
  },
  SmallYellow = {
    Text = "SmallYellow",
    Remark = "小号+黄色",
    Color = "Yellow,Light",
    Size = 35
  },
  YellowShake = {
    Text = "YellowShake",
    Remark = "黄色+抖动",
    Color = "Yellow,Light",
    Shake = 1
  },
  ShakeYellow = {
    Text = "ShakeYellow",
    Remark = "抖动+黄色",
    Color = "Yellow,Light",
    Shake = 1
  },
  LightGrayBold = {
    Text = "LightGrayBold",
    Remark = "灰蓝色+粗体",
    Color = "LightGray,Light",
    Bold = 1
  },
  BoldLightGray = {
    Text = "BoldLightGray",
    Remark = "粗体+灰蓝色",
    Color = "LightGray,Light",
    Bold = 1
  },
  LightGrayItalic = {
    Text = "LightGrayItalic",
    Remark = "灰蓝色+斜体",
    Color = "LightGray,Light",
    Italic = 1
  },
  ItalicLightGray = {
    Text = "ItalicLightGray",
    Remark = "斜体+灰蓝色",
    Color = "LightGray,Light",
    Italic = 1
  },
  LightGrayBig = {
    Text = "LightGrayBig",
    Remark = "灰蓝色+大号",
    Color = "LightGray,Light",
    Size = 50
  },
  BigLightGray = {
    Text = "BigLightGray",
    Remark = "大号+灰蓝色",
    Color = "LightGray,Light",
    Size = 50
  },
  LightGraySmall = {
    Text = "LightGraySmall",
    Remark = "灰蓝色+小号",
    Color = "LightGray,Light",
    Size = 35
  },
  SmallLightGray = {
    Text = "SmallLightGray",
    Remark = "小号+灰蓝色",
    Color = "LightGray,Light",
    Size = 35
  },
  LightGrayShake = {
    Text = "LightGrayShake",
    Remark = "灰蓝色+抖动",
    Color = "LightGray,Light",
    Shake = 1
  },
  ShakeLightGray = {
    Text = "ShakeLightGray",
    Remark = "抖动+灰蓝色",
    Color = "LightGray,Light",
    Shake = 1
  },
  BoldItalic = {
    Text = "BoldItalic",
    Remark = "粗体+斜体",
    Bold = 1,
    Italic = 1
  },
  ItalicBold = {
    Text = "ItalicBold",
    Remark = "斜体+粗体",
    Bold = 1,
    Italic = 1
  },
  BoldSmall = {
    Text = "BoldSmall",
    Remark = "粗体+小号",
    Bold = 1,
    Size = 35
  },
  SmallBold = {
    Text = "SmallBold",
    Remark = "小号+粗体",
    Bold = 1,
    Size = 35
  },
  BoldShake = {
    Text = "BoldShake",
    Remark = "粗体+抖动",
    Bold = 1,
    Shake = 1
  },
  ShakeBold = {
    Text = "ShakeBold",
    Remark = "抖动+粗体",
    Bold = 1,
    Shake = 1
  },
  ItalicBig = {
    Text = "ItalicBig",
    Remark = "斜体+大号",
    Italic = 1,
    Size = 50
  },
  ItalicSmall = {
    Text = "ItalicSmall",
    Remark = "斜体+小号",
    Italic = 1,
    Size = 35
  },
  SmallItalic = {
    Text = "SmallItalic",
    Remark = "小号+斜体",
    Italic = 1,
    Size = 35
  },
  ItalicShake = {
    Text = "ItalicShake",
    Remark = "斜体+抖动",
    Italic = 1,
    Shake = 1
  },
  ShakeItalic = {
    Text = "ShakeItalic",
    Remark = "抖动+斜体",
    Italic = 1,
    Shake = 1
  },
  BlueDel = {
    Text = "BlueDel",
    Remark = "蓝色+删除线",
    Color = "Blue,Light",
    DelLine = 1
  },
  RedDel = {
    Text = "RedDel",
    Remark = "红色+删除线",
    Color = "Red,Light",
    DelLine = 1
  },
  YellowDel = {
    Text = "YellowDel",
    Remark = "黄色+删除线",
    Color = "Yellow,Light",
    DelLine = 1
  },
  LightGrayDel = {
    Text = "LightGrayDel",
    Remark = "灰蓝色+删除线",
    Color = "LightGray,Light",
    DelLine = 1
  },
  BoldDel = {
    Text = "BoldDel",
    Remark = "粗体+删除线",
    DelLine = 1,
    Bold = 1
  },
  ItalicDel = {
    Text = "ItalicDel",
    Remark = "斜体+删除线",
    DelLine = 1,
    Italic = 1
  },
  BigDel = {
    Text = "BigDel",
    Remark = "大号+删除线",
    DelLine = 1,
    Size = 50
  },
  SmallDel = {
    Text = "SmallDel",
    Remark = "小号+删除线",
    DelLine = 1,
    Size = 35
  },
  ShakeDel = {
    Text = "ShakeDel",
    Remark = "抖动+删除线",
    DelLine = 1,
    Shake = 1
  },
  DelBlue = {
    Text = "DelBlue",
    Remark = "删除线+蓝色",
    Color = "Blue,Light",
    DelLine = 1
  },
  DelRed = {
    Text = "DelRed",
    Remark = "删除线+红色",
    Color = "Red,Light",
    DelLine = 1
  },
  DelYellow = {
    Text = "DelYellow",
    Remark = "删除线+黄色",
    Color = "Yellow,Light",
    DelLine = 1
  },
  DelLightGray = {
    Text = "DelLightGray",
    Remark = "删除线+灰蓝色",
    Color = "LightGray,Light",
    DelLine = 1
  },
  DelBold = {
    Text = "DelBold",
    Remark = "删除线+粗体",
    DelLine = 1,
    Bold = 1
  },
  DelItalic = {
    Text = "DelItalic",
    Remark = "删除线+斜体",
    DelLine = 1,
    Italic = 1
  },
  DelBig = {
    Text = "DelBig",
    Remark = "删除线+大号",
    DelLine = 1,
    Size = 50
  },
  DelSmall = {
    Text = "DelSmall",
    Remark = "删除线+小号",
    DelLine = 1,
    Size = 35
  },
  DelShake = {
    Text = "DelShake",
    Remark = "删除线+抖动",
    DelLine = 1,
    Shake = 1
  },
  SeastriderCurse = {
    Text = "SeastriderCurse",
    Remark = "蹈海者咒怨",
    Color = "orangeword",
    StateLink = 120929
  },
  FatePact = {
    Text = "FatePact",
    Remark = "命契",
    StateLink = 119105
  },
  BirthRitual = {
    Text = "BirthRitual",
    Remark = "降生仪式",
    Img = "Battle_Card_Buff_079",
    ImgPath = "Battle_Card",
    StateLink = 119108
  },
  Flaw = {
    Text = "Flaw",
    Remark = "破绽",
    Img = "Battle_Card_Buff_056",
    ImgPath = "Battle_Card",
    StateLink = 3768
  },
  BloodOath = {
    Text = "BloodOath",
    Remark = "血誓",
    StateLink = 61185
  },
  MutualAid1 = {
    Text = "MutualAid1",
    Remark = "互助契约：利莫里亚",
    StateLink = 119076
  },
  MutualAid2 = {
    Text = "MutualAid2",
    Remark = "互助契约：鱼群",
    StateLink = 117875
  },
  MutualAid3 = {
    Text = "MutualAid3",
    Remark = "互助契约：深海分殖体",
    StateLink = 118115
  },
  Seal = {
    Text = "Seal",
    Remark = "封印",
    Color = "purpleword",
    Img = "Battle_Card_Buff_073",
    ImgPath = "Battle_Card",
    StateLink = 122596
  },
  Seal1 = {
    Text = "Seal1",
    Remark = "封印颜色词缀",
    Color = "purpleword",
    ImgPath = "Battle_Card",
    StateLink = 122596
  },
  Monster_Fervor = {
    Text = "Monster_Fervor",
    Remark = "怪物茉夏狂热",
    Img = "Battle_Card_Buff_071",
    ImgPath = "Battle_Card",
    StateLink = 123177
  },
  MonsterExFlameKeywords = {
    Text = "MonsterExFlameKeywords",
    Remark = "怪物凯蒂古拉爆炎",
    Color = "redword",
    Img = "Battle_Card_Buff_057",
    ImgPath = "Battle_Card",
    StateLink = 98140
  },
  MonsterLizVerdantSpark = {
    Text = "MonsterLizVerdantSpark",
    Remark = "怪物莉兹翠绿火种",
    Color = "greenword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 126479
  },
  ExhaustionCounter = {
    Text = "ExhaustionCounter",
    Remark = "衰竭反制",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 117885
  },
  MonsterTimeBeacon = {
    Text = "MonsterTimeBeacon",
    Remark = "怪物环拉回环",
    Color = "whiteword",
    Img = "Battle_Card_Buff_038",
    ImgPath = "Battle_Card",
    StateLink = 127272
  },
  MonsterSightUnbound = {
    Text = "MonsterSightUnbound",
    Remark = "怪物环拉卡牌超越之目",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 127276
  },
  WhiteWord = {
    Text = "WhiteWord",
    Remark = "白色",
    Color = "whiteword"
  },
  BrokenCard = {
    Text = "BrokenCard",
    Color = "orangeword",
    Img = "Battle_Card_Buff_003",
    ImgPath = "Battle_Card",
    StateLink = 128028
  },
  Chapter5_Monster_Fervor1 = {
    Text = "Chapter5_Monster_Fervor1",
    Remark = "怪物冷蛛侍女白狂热",
    Img = "Battle_Card_Buff_071",
    ImgPath = "Battle_Card",
    StateLink = 128248
  },
  Chapter5_Monster_Fervor2 = {
    Text = "Chapter5_Monster_Fervor2",
    Remark = "怪物冷蛛侍女黑狂热",
    Img = "Battle_Card_Buff_071",
    ImgPath = "Battle_Card",
    StateLink = 128245
  },
  Chapter5_Monster_Fervor3 = {
    Text = "Chapter5_Monster_Fervor3",
    Remark = "怪物错乱的命运狂热",
    Img = "Battle_Card_Buff_071",
    ImgPath = "Battle_Card",
    StateLink = 128644
  },
  Chapter5_Monster_Fervor4 = {
    Text = "Chapter5_Monster_Fervor4",
    Remark = "怪物暗黑阿拉克涅狂热",
    Img = "Battle_Card_Buff_071",
    ImgPath = "Battle_Card",
    StateLink = 131123
  },
  Chapter5_Monster_Agitation = {
    Text = "Chapter5_Monster_Agitation",
    Remark = "躁动",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 131134
  },
  Chapter5_Monster_Support1 = {
    Text = "Chapter5_Monster_Support1",
    Remark = "孕育之理",
    StateLink = 59526
  },
  Chapter5_Monster_Support2 = {
    Text = "Chapter5_Monster_Support2",
    Remark = "智识之理",
    StateLink = 59520
  },
  Chapter5_Monster_Support3 = {
    Text = "Chapter5_Monster_Support3",
    Remark = "欢愉之理",
    StateLink = 59522
  },
  Alice1 = {Text = "Alice1", SkillLink = 140849},
  Alice2 = {Text = "Alice2", SkillLink = 140850},
  Alice3 = {Text = "Alice3", SkillLink = 140852},
  Alice4 = {Text = "Alice4", SkillLink = 140851},
  Yishiganshe = {
    Text = "Yishiganshe",
    Remark = "日服莉莉插画命轮意识干涉",
    Color = "orangeword",
    StateLink = 140856
  },
  Falltospace11 = {
    Text = "Falltospace11",
    SkillLink = 142806
  },
  Falltospace12 = {
    Text = "Falltospace12",
    SkillLink = 142809
  },
  Falltospace13 = {
    Text = "Falltospace13",
    SkillLink = 142808
  },
  Falltospace14 = {
    Text = "Falltospace14",
    SkillLink = 142803
  },
  Falltospace21 = {
    Text = "Falltospace21",
    SkillLink = 142804
  },
  Falltospace22 = {
    Text = "Falltospace22",
    SkillLink = 142805
  },
  Falltospace23 = {
    Text = "Falltospace23",
    SkillLink = 142802
  },
  Falltospace24 = {
    Text = "Falltospace24",
    SkillLink = 142807
  },
  Backupbody1 = {
    Text = "Backupbody1",
    SkillLink = 145442
  },
  Backupbody2 = {
    Text = "Backupbody2",
    SkillLink = 145441
  },
  Backupbody3 = {
    Text = "Backupbody3",
    SkillLink = 145439
  },
  Backupbody4 = {
    Text = "Backupbody4",
    SkillLink = 145440
  },
  Pangtuosihuodong_Attack = {
    Text = "Pangtuosihuodong_Attack",
    Remark = "庞托斯活动造物衍生卡攻击词缀",
    StateLink = 143542
  },
  Pangtuosihuodong_Defend = {
    Text = "Pangtuosihuodong_Defend",
    Remark = "庞托斯活动造物衍生卡防御词缀",
    StateLink = 143541
  },
  SacrificialMark = {
    Text = "SacrificialMark",
    Remark = "祭品印记",
    Color = "whiteword",
    StateLink = 145229
  },
  SacrificialMark1 = {
    Text = "SacrificialMark1",
    Remark = "祭品印记词缀",
    Color = "whiteword",
    Img = "Battle_Card_Buff_092",
    ImgPath = "Battle_Card",
    StateLink = 145710
  },
  WormGrowth = {
    Text = "WormGrowth",
    Remark = "蠕虫成长",
    Color = "redword",
    StateLink = 145228
  },
  WormGrowth1 = {
    Text = "WormGrowth1",
    Remark = "蠕虫成长词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_091",
    ImgPath = "Battle_Card",
    StateLink = 145709
  },
  WormGrowth2 = {
    Text = "WormGrowth2",
    Remark = "蠕虫成长启灵3词缀",
    Color = "redword",
    Img = "Battle_Card_Buff_091",
    ImgPath = "Battle_Card",
    StateLink = 149169
  },
  Recycle = {
    Text = "Recycle",
    Remark = "回收词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 146079
  },
  Blessing = {
    Text = "Blessing",
    Remark = "赐福词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 144494
  },
  BlessingNegativeEffect = {
    Text = "BlessingNegativeEffect",
    Remark = "赐福负面效果词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 144508
  },
  Bleesing_Delay = {
    Text = "Bleesing_Delay",
    Remark = "衍生卡词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 145628
  },
  Bleesing_Exaggerate = {
    Text = "Bleesing_Exaggerate",
    Remark = "衍生卡词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 145621
  },
  Bleesing_Negative = {
    Text = "Bleesing_Negative",
    Remark = "衍生卡词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 145623
  },
  Shimieluotanhuodong1 = {
    Text = "Shimieluotanhuodong1",
    Remark = "蚀灭萝坦活动衍生卡计数词缀",
    Color = "orangeword",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 146147
  },
  Shimieluotanhuodong2 = {
    Text = "Shimieluotanhuodong2",
    Remark = "蚀灭萝坦活动衍生卡计数",
    Color = "orangeword",
    StateLink = 146117
  },
  StatusApplier = {
    Text = "StatusApplier",
    Remark = "状态拥有者"
  },
  SkillName1 = {
    Text = "SkillName1",
    Remark = "槽位1技能名",
    SkillSlot = "Slot_Skill1"
  },
  SkillName2 = {
    Text = "SkillName2",
    Remark = "槽位2技能名",
    SkillSlot = "Slot_Skill2"
  },
  SkillName3 = {
    Text = "SkillName3",
    Remark = "槽位3技能名",
    SkillSlot = "Slot_Skill3"
  },
  AllyPosAwaker1Name = {
    Text = "AllyPosAwaker1Name",
    Remark = "友方一号位唤醒体的名字"
  },
  AllyPosAwaker2Name = {
    Text = "AllyPosAwaker2Name",
    Remark = "友方二号位唤醒体的名字"
  },
  AllyPosAwaker3Name = {
    Text = "AllyPosAwaker3Name",
    Remark = "友方三号位唤醒体的名字"
  },
  AllyPosAwaker4Name = {
    Text = "AllyPosAwaker4Name",
    Remark = "友方四号位唤醒体的名字"
  },
  EnemyPosAwaker1Name = {
    Text = "EnemyPosAwaker1Name",
    Remark = "敌方一号位唤醒体的名字"
  },
  EnemyPosAwaker2Name = {
    Text = "EnemyPosAwaker2Name",
    Remark = "敌方二号位唤醒体的名字"
  },
  EnemyPosAwaker3Name = {
    Text = "EnemyPosAwaker3Name",
    Remark = "敌方三号位唤醒体的名字"
  },
  EnemyPosAwaker4Name = {
    Text = "EnemyPosAwaker4Name",
    Remark = "敌方四号位唤醒体的名字"
  },
  LockMyEnemy = {
    Text = "LockMyEnemy",
    Remark = "锁定我的敌人"
  },
  MyLockedEnemy = {
    Text = "MyLockedEnemy",
    Remark = "我锁定的敌人"
  },
  Caroboo_Tips = {
    Text = "Caroboo_Tips",
    Remark = "卡拉布活动巧克力效果",
    StateLink = 147797
  },
  MonsterSinMarkKeywords = {
    Text = "MonsterSinMarkKeywords",
    Remark = "罪印词缀",
    Color = "purpleword",
    Img = "Battle_Card_Buff_078",
    ImgPath = "Battle_Card",
    StateLink = 147972
  },
  MonsterPainKeywords = {
    Text = "MonsterPainKeywords",
    Remark = "苦痛救赎词缀",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 147968
  },
  MonsterPolluxFever = {
    Text = "MonsterPolluxFever",
    Remark = "怪物波吕克斯狂热",
    Img = "Battle_Card_Buff_071",
    ImgPath = "Battle_Card",
    StateLink = 147974
  },
  InvincibleUntilRoused = {
    Text = "InvincibleUntilRoused",
    Remark = "怪物觉醒前无敌",
    Img = "Battle_Card_Buff_058",
    ImgPath = "Battle_Card",
    StateLink = 148020
  },
  MonsterB05EXFever = {
    Text = "MonsterB05EXFever",
    Remark = "怪物血希狂热",
    Img = "Battle_Card_Buff_071",
    ImgPath = "Battle_Card",
    StateLink = 148392
  },
  BloodOath_New = {
    Text = "BloodOath_New",
    Remark = "血誓",
    StateLink = 149140
  },
  MonsterB11_AFFull = {
    Text = "MonsterB11_AFFull",
    Remark = "饱餐",
    Img = "Battle_Card_Buff_091",
    ImgPath = "Battle_Card",
    StateLink = 149576
  },
  MonsterBless = {
    Text = "MonsterBless",
    Remark = "怪物卡拉布赐福词缀",
    Img = "Battle_Card_Buff_016",
    ImgPath = "Battle_Card",
    StateLink = 149931
  }
})
return WordsEffectConfig
