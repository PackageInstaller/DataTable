local AllEnum = {}
AllEnum.ChannelName = {
  BanShu = "NPPA",
  Dev = "Default",
  Official = "Official"
}
AllEnum.Language = {
  CN = "zh_CN",
  TW = "zh_TW",
  JP = "ja_JP",
  EN = "en_US",
  KR = "ko_KR"
}
AllEnum.LanguageInfo = {
  {
    AllEnum.Language.CN,
    "简中",
    "_cn"
  },
  {
    AllEnum.Language.TW,
    "繁中",
    "_tw"
  },
  {
    AllEnum.Language.JP,
    "日语",
    "_jp"
  },
  {
    AllEnum.Language.EN,
    "英语",
    "_en"
  },
  {
    AllEnum.Language.KR,
    "韩语",
    "_kr"
  }
}
AllEnum.SortingLayerName = {
  HUD = "HUD",
  UI = "UI",
  UI_Top = "UI Top",
  UI_Video = " UI Video",
  Overlay = "Overlay"
}
AllEnum.Const = {MAX_TEAM_COUNT = 6, ICON_SCALE = 0.68}
AllEnum.CoinItemId = {
  Gold = 1,
  Jade = 2,
  STONE = 3,
  FREESTONE = 4,
  Energy = 20,
  WorldClassExp = 21,
  RogueHardCoreTick = 28,
  StarTowerSweepTick = 29,
  StarTowerSweepTickLimit = 30,
  PresentsFragment = 6,
  BossCruTickets = 10,
  FixedRogCurrency = 11,
  FRRewardCurrency = 12,
  NormalSingleTicket = 501,
  LimitedSingleTicket = 502,
  DailyQuestActive = 61,
  WeeklyQuestActive = 63,
  TraceHunt = 37,
  SoldierCurrency = 40,
  Furniture = 701,
  AutoDecisionToken = 42,
  SoldierHp = 40
}
AllEnum.QuestStatus = {Undone = false, Done = true}
AllEnum.CharHeadIconSurfix = {
  GC = "_GC",
  GD = "_GD",
  L = "_L",
  LS = "_LS",
  S = "_S",
  SS = "_SS",
  SK = "_SK",
  XL = "_XL",
  XXL = "_XXL",
  XXLS = "_XXLS",
  GOODS = "_GOODS",
  QM = "_QM",
  QS = "_QS",
  Q = "_Q",
  QSS = "_QSS"
}
AllEnum.CharHeadIconSurfixAutoFit = {
  _L = {
    _L = {w = 140, h = 152},
    _LS = {w = 70, h = 76}
  },
  _S = {
    _S = {w = 256, h = 256},
    _SS = {w = 128, h = 128}
  },
  _XXL = {
    _XXL = {w = 192, h = 192},
    _XXLS = {w = 96, h = 96}
  }
}
AllEnum.EET = {
  [GameEnum.elementType.WE] = "WEE",
  [GameEnum.elementType.FE] = "FEE",
  [GameEnum.elementType.SE] = "SEE",
  [GameEnum.elementType.AE] = "AEE",
  [GameEnum.elementType.LE] = "LEE",
  [GameEnum.elementType.DE] = "DEE"
}
AllEnum.CharAttr = {
  {
    sKey = "Hp",
    nGroup = 1,
    sLanguageId_Simple = "Attr_Hp_Simple"
  },
  {
    sKey = "Atk",
    nGroup = 2,
    sLanguageId_Simple = "Attr_Atk_Simple"
  },
  {
    sKey = "Def",
    nGroup = 3,
    sLanguageId_Simple = "Attr_Def_Simple"
  },
  {
    sKey = "CritRate",
    nGroup = 4,
    bPercent = true
  },
  {
    sKey = "CritPower",
    nGroup = 5,
    bPercent = true
  },
  {
    sKey = "Suppress",
    nGroup = 6,
    bPercent = true
  },
  {
    sKey = "UltraEnergy",
    nGroup = 7
  },
  {
    sKey = "EnergyEfficiency",
    nGroup = 7,
    bPercent = true
  },
  {
    sKey = "EnergyConvRatio",
    nGroup = 7,
    bPercent = true
  },
  {sKey = "DefPierce", nGroup = 8},
  {
    sKey = "DefIgnore",
    nGroup = 8,
    bPercent = true
  },
  {
    sKey = "WEE",
    nGroup = 9,
    bPercent = true,
    nEET = GameEnum.elementType.WE
  },
  {
    sKey = "WEP",
    nGroup = 9,
    nEET = GameEnum.elementType.WE
  },
  {
    sKey = "WEI",
    nGroup = 9,
    bPercent = true,
    nEET = GameEnum.elementType.WE
  },
  {
    sKey = "FEE",
    nGroup = 10,
    bPercent = true,
    nEET = GameEnum.elementType.FE
  },
  {
    sKey = "FEP",
    nGroup = 10,
    nEET = GameEnum.elementType.FE
  },
  {
    sKey = "FEI",
    nGroup = 10,
    bPercent = true,
    nEET = GameEnum.elementType.FE
  },
  {
    sKey = "SEE",
    nGroup = 11,
    bPercent = true,
    nEET = GameEnum.elementType.SE
  },
  {
    sKey = "SEP",
    nGroup = 11,
    nEET = GameEnum.elementType.SE
  },
  {
    sKey = "SEI",
    nGroup = 11,
    bPercent = true,
    nEET = GameEnum.elementType.SE
  },
  {
    sKey = "AEE",
    nGroup = 12,
    bPercent = true,
    nEET = GameEnum.elementType.AE
  },
  {
    sKey = "AEP",
    nGroup = 12,
    nEET = GameEnum.elementType.AE
  },
  {
    sKey = "AEI",
    nGroup = 12,
    bPercent = true,
    nEET = GameEnum.elementType.AE
  },
  {
    sKey = "LEE",
    nGroup = 13,
    bPercent = true,
    nEET = GameEnum.elementType.LE
  },
  {
    sKey = "LEP",
    nGroup = 13,
    nEET = GameEnum.elementType.LE
  },
  {
    sKey = "LEI",
    nGroup = 13,
    bPercent = true,
    nEET = GameEnum.elementType.LE
  },
  {
    sKey = "DEE",
    nGroup = 14,
    bPercent = true,
    nEET = GameEnum.elementType.DE
  },
  {
    sKey = "DEP",
    nGroup = 14,
    nEET = GameEnum.elementType.DE
  },
  {
    sKey = "DEI",
    nGroup = 14,
    bPercent = true,
    nEET = GameEnum.elementType.DE
  },
  {sKey = "AtkSpd", bPercent = true},
  {sKey = "WER"},
  {sKey = "SER"},
  {sKey = "AER"},
  {sKey = "FER"},
  {sKey = "LER"},
  {sKey = "DER"},
  {sKey = "EET"}
}
AllEnum.AttachAttr = {
  {sKey = "Hp"},
  {sKey = "Atk"},
  {sKey = "Def"},
  {sKey = "CritRate", bPercent = true},
  {
    sKey = "CritResistance",
    bPercent = true
  },
  {sKey = "CritPower", bPercent = true},
  {sKey = "HitRate", bPercent = true},
  {sKey = "Evd", bPercent = true},
  {sKey = "DefPierce"},
  {sKey = "DefIgnore", bPercent = true},
  {sKey = "WEE", bPercent = true},
  {sKey = "WEP"},
  {sKey = "WEI", bPercent = true},
  {sKey = "WER"},
  {sKey = "FEE", bPercent = true},
  {sKey = "FEP"},
  {sKey = "FEI", bPercent = true},
  {sKey = "FER"},
  {sKey = "SEE", bPercent = true},
  {sKey = "SEP"},
  {sKey = "SEI", bPercent = true},
  {sKey = "SER"},
  {sKey = "AEE", bPercent = true},
  {sKey = "AEP"},
  {sKey = "AEI", bPercent = true},
  {sKey = "AER"},
  {sKey = "LEE", bPercent = true},
  {sKey = "LEP"},
  {sKey = "LEI", bPercent = true},
  {sKey = "LER"},
  {sKey = "DEE", bPercent = true},
  {sKey = "DEP"},
  {sKey = "DEI", bPercent = true},
  {sKey = "DER"},
  {sKey = "Toughness"},
  {sKey = "Suppress", bPercent = true},
  {sKey = "NORMALDMG", bPercent = true},
  {sKey = "SKILLDMG", bPercent = true},
  {sKey = "ULTRADMG", bPercent = true},
  {sKey = "OTHERDMG", bPercent = true},
  {
    sKey = "RCDNORMALDMG",
    bPercent = true
  },
  {
    sKey = "RCDSKILLDMG",
    bPercent = true
  },
  {
    sKey = "RCDULTRADMG",
    bPercent = true
  },
  {
    sKey = "RCDOTHERDMG",
    bPercent = true
  },
  {sKey = "MARKDMG", bPercent = true},
  {sKey = "SUMMONDMG", bPercent = true},
  {
    sKey = "RCDSUMMONDMG",
    bPercent = true
  },
  {
    sKey = "PROJECTILEDMG",
    bPercent = true
  },
  {
    sKey = "RCDPROJECTILEDMG",
    bPercent = true
  },
  {sKey = "GENDMG"},
  {sKey = "DMGPLUS"},
  {sKey = "FINALDMG"},
  {
    sKey = "FINALDMGPLUS"
  },
  {sKey = "WEERCD"},
  {sKey = "FEERCD"},
  {sKey = "SEERCD"},
  {sKey = "AEERCD"},
  {sKey = "LEERCD"},
  {sKey = "DEERCD"},
  {sKey = "GENDMGRCD"},
  {sKey = "DMGPLUSRCD"},
  {
    sKey = "NormalCritRate"
  },
  {
    sKey = "SkillCritRate"
  },
  {
    sKey = "UltraCritRate"
  },
  {
    sKey = "MarkCritRate"
  },
  {
    sKey = "SummonCritRate"
  },
  {
    sKey = "ProjectileCritRate"
  },
  {
    sKey = "OtherCritRate"
  },
  {
    sKey = "NormalCritPower"
  },
  {
    sKey = "SkillCritPower"
  },
  {
    sKey = "UltraCritPower"
  },
  {
    sKey = "MarkCritPower"
  },
  {
    sKey = "SummonCritPower"
  },
  {
    sKey = "ProjectileCritPower"
  },
  {
    sKey = "OtherCritPower"
  },
  {
    sKey = "ToughnessDamageAdjust"
  },
  {
    sKey = "EnergyConvRatio",
    bPercent = true,
    bPlayer = true
  },
  {
    sKey = "EnergyEfficiency",
    bPercent = true,
    bPlayer = true
  }
}
AllEnum.SoldierCharAttr = {
  {sKey = "Energy"},
  {
    sKey = "InitialEnergy"
  },
  {sKey = "Recovery"}
}
AllEnum.CharConfigType = {
  Attr = 1,
  Char = 2,
  Skill = 3
}
AllEnum.SkillSlotStrEnum = {
  [GameEnum.skillSlotType.A] = tostring(GameEnum.skillSlotType.A),
  [GameEnum.skillSlotType.B] = tostring(GameEnum.skillSlotType.B),
  [GameEnum.skillSlotType.C] = tostring(GameEnum.skillSlotType.C),
  [GameEnum.skillSlotType.D] = tostring(GameEnum.skillSlotType.D),
  [GameEnum.skillSlotType.NORMAL] = tostring(GameEnum.skillSlotType.NORMAL)
}
AllEnum.SkillLvPowerFactor = {
  [0] = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0
  },
  [1] = {
    [1] = 0,
    [2] = 90,
    [3] = 100,
    [4] = 120,
    [5] = 80
  },
  [2] = {
    [1] = 0,
    [2] = 135,
    [3] = 150,
    [4] = 180,
    [5] = 120
  },
  [3] = {
    [1] = 0,
    [2] = 180,
    [3] = 200,
    [4] = 240,
    [5] = 160
  },
  [4] = {
    [1] = 0,
    [2] = 225,
    [3] = 250,
    [4] = 300,
    [5] = 200
  }
}
AllEnum.WorldMapNodeType = {
  Mainline = 1,
  Roguelike = 2,
  Branchline = 3,
  Rogueboss = 4,
  FixedRoguelike = 5,
  Prologue = 6,
  DailyInstance = 7,
  TravelerDuel = 8,
  InfinityTower = 9,
  EquipmentInstance = 10,
  VamireSurvivor = 11,
  ScoreBoss = 12,
  SkillInstance = 13,
  Trial = 14,
  JointDrill = 15,
  ActivityLevels = 16,
  ActivityStory = 17,
  TraceHunt = 18
}
AllEnum.FrameColor_New = {
  [0] = "0",
  [GameEnum.itemRarity.SSR] = "5",
  [GameEnum.itemRarity.SR] = "4",
  [GameEnum.itemRarity.R] = "3",
  [GameEnum.itemRarity.M] = "2",
  [GameEnum.itemRarity.N] = "1"
}
AllEnum.BoardFrameColor = {
  [0] = "0",
  [GameEnum.itemRarity.SSR] = "5",
  [GameEnum.itemRarity.SR] = "4",
  [GameEnum.itemRarity.R] = "3",
  [GameEnum.itemRarity.M] = "0",
  [GameEnum.itemRarity.N] = "0"
}
AllEnum.FrameType_New = {
  Item = "rare_item_a_",
  ItemS = "rare_item_b_",
  ItemSS = "rare_item_c_",
  CharList = "rare_list_",
  CharFrame = "rare_character_",
  BoardFrame = "rare_mainchara_",
  VestigePerk = "rare_vestige_xintiao_",
  RareBag = "rare_bag_",
  Outfit = "rare_fengjing_",
  OutfitPortrait = "rare_scenery_card_",
  PresentsSide = "rare_gift_side_",
  PresentsEllipse = "rare_gift_ellipse_",
  PresentsDB = "rare_gift_db_",
  PresentsCircle = "rare_gift_circle_",
  SuperscriptDB = "rare_outfit_",
  Talent = "rare_talent_",
  SlotPerk = "rare_vestige_slot_",
  ThemePerk = "rare_vestige_theme_",
  ExclusivePerk = "db_weapon_perk_",
  Text = "rare_character_text_",
  BuildRank = "rare_build_",
  BuildRankDB = "rare_build_db_",
  BuildFormation = "rare_team_build_db_",
  ShopGoods = "db_shop_character_",
  MallGoods = "db_mall_character_",
  DiscList = "rare_outfit_list_",
  FateCard = "rare_vestige_fatecard_",
  FateCardS = "rare_vestige_fatecard_icon_",
  Potential = "rare_vestige_card_",
  PotentialS = "rare_vestige_card_s_",
  StarTowerFateCard = "rare_vestige_fatecard_icon_",
  HarmonySkillL = "rare_outfit_skill_l_",
  HarmonySkillS = "rare_outfit_skill_s_",
  RandomProperty = "rare_chargem_db_a_",
  RandomPropertyLock = "rare_chargem_db_b_",
  DiscLimitS = "rare_outfit_exceed_s_",
  DiscLimitL = "rare_outfit_exceed_l_",
  DiscFrameL = "rare_outfit_team_l_",
  DiscFrameS = "rare_outfit_team_s_",
  DormFurniture = "db2_pack_"
}
AllEnum.BuildGrade = {
  S = 3,
  A = 2,
  B = 1,
  C = 0
}
AllEnum.BuildSource = {
  Normal = 1,
  Trial = 2,
  LimitedTrial = 3
}
AllEnum.BuildModifierState = {
  NotModified = 0,
  PotentialModified = 1,
  NoteModified = 2,
  CannotModify = 3
}
AllEnum.FrameColor = {
  [GameEnum.itemRarity.SSR] = "5",
  [GameEnum.itemRarity.SR] = "4",
  [GameEnum.itemRarity.R] = "3",
  [GameEnum.itemRarity.M] = "2",
  [GameEnum.itemRarity.N] = "1"
}
local colorAll = Color(0.996, 0.694, 0.945, 1)
local colorOrange = Color(0.996, 0.757, 0.341, 1)
local colorPurple = Color(0.588, 0.6, 0.996, 1)
local colorBlue = Color(0.435, 0.812, 0.996, 1)
local colorWhite = Color(0.804, 0.804, 0.804, 1)
AllEnum.RarityColor = {
  [GameEnum.itemRarity.SSR] = colorAll,
  [GameEnum.itemRarity.SR] = colorOrange,
  [GameEnum.itemRarity.R] = colorPurple,
  [GameEnum.itemRarity.M] = colorBlue,
  [GameEnum.itemRarity.N] = colorWhite
}
AllEnum.FrameType = {
  Item = "daoju",
  CharList = "juese",
  OutfitList = "lizhuang_a_",
  OutfitPortrait = "lizhuang_b_",
  OutfitCharInfo = "lizhuang_c_",
  TipFrame = "lizhuang_d_",
  PresentsAttr = "liwu_a_",
  PresentsMaster = "liwu_b_",
  Perk = "perk_"
}
AllEnum.OutfitIconSurfix = {
  ListGrid = "_a",
  Item = "_b",
  CharInfo = "_c",
  OutInfo = "_d",
  Gacha = "_gacha"
}
AllEnum.Actor2DType = {Normal = 1, FullScreen = 2}
AllEnum.Disc2DType = {
  Base = 1,
  Main = 2,
  L2D = 3
}
AllEnum.StoryAvgType = {
  Preview = 0,
  PureAvg = 1,
  BeforeBattle = 2,
  AfterBattle = 3,
  Plot = 4
}
AllEnum.LevelResult = {
  Succeed = 0,
  Failed = 1,
  Teleporter = 2
}
AllEnum.TipPosition = {
  Top = 1,
  Bottom = 2,
  Right = 3,
  Left = 4
}
AllEnum.BattleAnimSetting = {
  DayOnce = 1,
  Open = 2,
  Close = 3
}
AllEnum.BattleHudDamageSetting = {
  Default = 1,
  Merge = 2,
  Close = 3
}
AllEnum.CharacterScreenType = {Rare = 1, Element = 2}
AllEnum.LoginTime = {
  Today = 1,
  Yesday = 2,
  Date = 3
}
AllEnum.PresentsCircleRarityColor = {
  [GameEnum.itemRarity.SSR] = Color(0.7764705882352941, 0.9568627450980393, 0.9333333333333333, 1),
  [GameEnum.itemRarity.SR] = Color(1, 0.984313725490196, 0.8313725490196079, 0.6),
  [GameEnum.itemRarity.R] = Color(0.7529411764705882, 0.984313725490196, 1, 0.6),
  [GameEnum.itemRarity.M] = Color(0.8509803921568627, 1, 0.9333333333333333, 0.6),
  [GameEnum.itemRarity.N] = Color(1, 1, 1, 0.6)
}
AllEnum.RewardGachaType = {
  [GameEnum.itemRarity.SSR] = "icon_roguegacha_01%s",
  [GameEnum.itemRarity.SR] = "icon_roguegacha_02%s",
  [GameEnum.itemRarity.R] = "icon_roguegacha_03%s",
  [GameEnum.itemRarity.M] = "icon_roguegacha_04%s"
}
AllEnum.SortType = {
  Level = 1,
  Rarity = 2,
  ElementType = 3,
  Id = 4,
  Skill = 5,
  Affinity = 6,
  Time = 7
}
AllEnum.CharSortField = {
  [AllEnum.SortType.Level] = "Level",
  [AllEnum.SortType.Rarity] = "Rare",
  [AllEnum.SortType.ElementType] = "EET",
  [AllEnum.SortType.Id] = "nId",
  [AllEnum.SortType.Time] = "CreateTime",
  [AllEnum.SortType.Skill] = "SkillLevel",
  [AllEnum.SortType.Affinity] = "Favorability"
}
AllEnum.DiscSortField = {
  [AllEnum.SortType.Level] = "nLevel",
  [AllEnum.SortType.Rarity] = "nRarity",
  [AllEnum.SortType.Time] = "nCreateTime",
  [AllEnum.SortType.ElementType] = "nEET",
  [AllEnum.SortType.Id] = "nId"
}
AllEnum.SkillElementColor = {
  [GameEnum.elementType.WE] = "#4e9fd8",
  [GameEnum.elementType.FE] = "#ef522e",
  [GameEnum.elementType.SE] = "#a1673d",
  [GameEnum.elementType.AE] = "#87bf10",
  [GameEnum.elementType.LE] = "#f3b521",
  [GameEnum.elementType.DE] = "#b15f9f"
}
AllEnum.SkillElementBgColor = {
  [GameEnum.elementType.WE] = "#3432ad",
  [GameEnum.elementType.FE] = "#791834",
  [GameEnum.elementType.SE] = "#552611",
  [GameEnum.elementType.AE] = "#186e30",
  [GameEnum.elementType.LE] = "#ac4b20",
  [GameEnum.elementType.DE] = "#561466"
}
AllEnum.ElementIconType = {
  Skill = "db_common_element_skill_",
  Icon = "icon_common_property_",
  SkillEx = "rare_character_skill_",
  VestigeSkill = "rare_vestige_skill_",
  SpPotential = "Sp_Potential_0"
}
AllEnum.MessageBox = {
  Confirm = 1,
  Alert = 2,
  Tips = 3,
  Desc = 4,
  Item = 5,
  ItemList = 6,
  PlainText = 7,
  Char = 8
}
AllEnum.SuccessBar = {
  Blue = 1,
  Yellow = 2,
  Purple = 3
}
AllEnum.PerkState = {
  Replace = 1,
  New = 2,
  Max = 3,
  Up = 4
}
AllEnum.MallToggle = {
  MonthlyCard = 1,
  Package = 2,
  Gem = 3,
  Shop = 4,
  Skin = 5,
  Recommend = 6,
  Furniture = 7,
  Activity = 8
}
AllEnum.AvgBubbleShowType = {Avg = 1, Voice = 2}
AllEnum.SkillTypeShow = {
  [1] = {
    iconIndex = 1,
    bgIconIndex = 1,
    sLanguageId = "Char_Skill_Type_1",
    bgColor = "#4f658f"
  },
  [2] = {
    iconIndex = 2,
    bgIconIndex = 2,
    sLanguageId = "Char_Skill_Type_2",
    bgColor = "#4a59b0"
  },
  [3] = {
    iconIndex = 4,
    bgIconIndex = 4,
    sLanguageId = "Char_Skill_Type_3",
    bgColor = "#4a59b0"
  },
  [4] = {
    iconIndex = 3,
    bgIconIndex = 3,
    sLanguageId = "Char_Skill_Type_4",
    bgColor = "#c545a2"
  }
}
AllEnum.CharBgPanelShowType = {
  None = 0,
  L2D = 1,
  Weapon = 2
}
AllEnum.RedDotType = {Single = 1, Number = 2}
AllEnum.UIDragType = {
  DragStart = 1,
  Drag = 2,
  DragEnd = 3
}
AllEnum.DailyInstanceState = {
  None = 0,
  Open = 1,
  Not_OpenDay = 2,
  Not_WorldClass = 3,
  Not_MainLine = 4,
  Not_HardUnlock = 5
}
AllEnum.EquipmentInstanceState = {
  None = 0,
  Open = 1,
  Not_OpenDay = 2,
  Not_WorldClass = 3,
  Not_MainLine = 4,
  Not_HardUnlock = 5
}
AllEnum.SkillInstanceState = {
  None = 0,
  Open = 1,
  Not_WorldClass = 2,
  Not_HardUnlock = 3
}
AllEnum.RogueBossLevelState = {
  None = 0,
  Open = 1,
  Not_OpenDay = 2,
  Not_RogueLike = 3,
  Not_MainLine = 4,
  Not_HardUnlock = 5
}
AllEnum.CraftingToggle = {Material = 1, Presents = 2}
AllEnum.ActQuestStatus = {
  Complete = 1,
  UnComplete = 2,
  Received = 3
}
AllEnum.PhoneChatState = {
  None = 0,
  Complete = 1,
  New = 2,
  UnComplete = 3
}
AllEnum.EnhancedPerkState = {
  On = 1,
  Off = 2,
  Lock = 3,
  Complete = 4
}
AllEnum.SideBaner = {
  Achievement = 1,
  DictionaryReward = 2,
  DictionaryEntry = 3,
  Favour = 4,
  Item = 5
}
AllEnum.RMBOrderType = {Mall = 1, BattlePass = 2}
AllEnum.AvgLogType = {
  Talk = 1,
  Choice = 2,
  Voiceover = 3,
  PhoneMsg = 4,
  PhoneMsgChoice = 5,
  Thought = 6
}
AllEnum.DiscTab = {
  Info = 1,
  Development = 2,
  BreakLimit = 3,
  Music = 4
}
AllEnum.DiscSucBar = {
  Upgrade = 1,
  Advance = 2,
  BreakLimit = 3,
  BreakLimitAll = 4
}
AllEnum.EquipmentType = {
  [GameEnum.equipmentType.Square] = {
    Language = "Equipment_Type_Square",
    Icon = "Icon/ZZZOther/equip_a_mini"
  },
  [GameEnum.equipmentType.Circle] = {
    Language = "Equipment_Type_Circle",
    Icon = "Icon/ZZZOther/equip_b_mini"
  },
  [GameEnum.equipmentType.Pentagon] = {
    Language = "Equipment_Type_Pentagon",
    Icon = "Icon/ZZZOther/equip_c_mini"
  }
}
AllEnum.EquipmentToggle = {Basic = 1, Upgrade = 2}
AllEnum.EquipmentSlot = {
  [1] = GameEnum.equipmentType.Square,
  [2] = GameEnum.equipmentType.Circle,
  [3] = GameEnum.equipmentType.Pentagon
}
AllEnum.EquipmentRarity_Star = {
  [0] = 0,
  [GameEnum.itemRarity.SSR] = 5,
  [GameEnum.itemRarity.SR] = 4,
  [GameEnum.itemRarity.R] = 3,
  [GameEnum.itemRarity.M] = 2,
  [GameEnum.itemRarity.N] = 1
}
AllEnum.MainViewCorner = {
  Role = 1,
  Disc = 2,
  Recruit = 3,
  Mainline = 4,
  Dorm = 6
}
AllEnum.EffectType = {
  Affinity = 1,
  Talent = 2,
  Outfit = 3,
  FateCard = 4,
  Potential = 5,
  Equipment = 6
}
AllEnum.ElementColor = {
  [GameEnum.elementType.WE] = Color(0.27450980392156865, 0.5607843137254902, 0.7607843137254902),
  [GameEnum.elementType.FE] = Color(0.8549019607843137, 0.28627450980392155, 0.1568627450980392),
  [GameEnum.elementType.SE] = Color(0.5215686274509804, 0.3254901960784314, 0.1843137254901961),
  [GameEnum.elementType.AE] = Color(0.37254901960784315, 0.5647058823529412, 0.043137254901960784),
  [GameEnum.elementType.LE] = Color(0.8823529411764706, 0.596078431372549, 0.09803921568627451),
  [GameEnum.elementType.DE] = Color(0.5372549019607843, 0.27058823529411763, 0.5490196078431373),
  [GameEnum.elementType.NONE] = Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764)
}
AllEnum.PotentialRarityCfg = {
  [GameEnum.itemRarity.SSR] = {sColor = "#9b77e3"},
  [GameEnum.itemRarity.SR] = {sColor = "#db8104"},
  [GameEnum.itemRarity.R] = {sColor = "#325e7c"}
}
AllEnum.PotentialElementColor = {
  [GameEnum.elementType.WE] = {sColor = "#4784af"},
  [GameEnum.elementType.FE] = {sColor = "#c1493a"},
  [GameEnum.elementType.SE] = {sColor = "#845640"},
  [GameEnum.elementType.AE] = {sColor = "#7a9c6c"},
  [GameEnum.elementType.LE] = {sColor = "#c68c3e"},
  [GameEnum.elementType.DE] = {sColor = "#a05793"}
}
AllEnum.NoteTypeCfg = {}
AllEnum.StarTowerRoomName = {
  [GameEnum.starTowerRoomType.BattleRoom] = {
    Color = "#ebaf3c",
    Icon = "zs_vestige_map_icon_1",
    SweepIcon = "zs_fastBattle_map_icon_1",
    Language = "StarTower_BattleRoomName"
  },
  [GameEnum.starTowerRoomType.EliteBattleRoom] = {
    Color = "#f07c3a",
    Icon = "zs_vestige_map_icon_2",
    SweepIcon = "zs_fastBattle_map_icon_2",
    Language = "StarTower_EliteBattleRoomName"
  },
  [GameEnum.starTowerRoomType.BossRoom] = {
    Color = "#e44d49",
    Icon = "zs_vestige_map_icon_3",
    SweepIcon = "zs_fastBattle_map_icon_3",
    Language = "StarTower_BossRoomName"
  },
  [GameEnum.starTowerRoomType.FinalBossRoom] = {
    Color = "#e44d49",
    Icon = "zs_vestige_map_icon_3",
    SweepIcon = "zs_fastBattle_map_icon_3",
    Language = "StarTower_FinalBossRoomName"
  },
  [GameEnum.starTowerRoomType.DangerRoom] = {
    Color = "#e44d49",
    Icon = "zs_vestige_map_icon_3",
    SweepIcon = "zs_fastBattle_map_icon_3",
    Language = "StarTower_DangerRoomName"
  },
  [GameEnum.starTowerRoomType.HorrorRoom] = {
    Color = "#e44d49",
    Icon = "zs_vestige_map_icon_8",
    SweepIcon = "zs_fastBattle_map_icon_8",
    Language = "StarTower_HorrorRoomName"
  },
  [GameEnum.starTowerRoomType.ShopRoom] = {
    Color = "#1aa989",
    Icon = "zs_vestige_map_icon_5",
    SweepIcon = "zs_fastBattle_map_icon_5",
    Language = "StarTower_ShopRoomName"
  },
  [GameEnum.starTowerRoomType.EventRoom] = {
    Color = "#41a4c9",
    Icon = "zs_vestige_map_icon_6",
    SweepIcon = "zs_fastBattle_map_icon_6",
    Language = "StarTower_EventRoomName"
  }
}
AllEnum.PotentialIconSurfix = {A = "_A", B = "_B"}
AllEnum.PotentialIconSizeSurfix = {S = "_S", M = "_M"}
AllEnum.PotentialCornerIcon = {
  [GameEnum.potentialCornerType.Diamond] = {
    sIconA = "Icon/Potential/Potential_Diamond_A",
    sIconB = "Icon/Potential/Potential_Diamond_B"
  },
  [GameEnum.potentialCornerType.Triangle] = {
    sIconA = "Icon/Potential/Potential_Triangle_A",
    sIconB = "Icon/Potential/Potential_Triangle_B"
  },
  [GameEnum.potentialCornerType.Round] = {
    sIconA = "Icon/Potential/Potential_Round_A",
    sIconB = "Icon/Potential/Potential_Round_B"
  }
}
AllEnum.StarTowerDepotTog = {
  Potential = 1,
  DiscSkill = 2,
  CharInfo = 3,
  ItemList = 4
}
AllEnum.DiscSkillType = {Common = 1, Passive = 2}
AllEnum.Char_Element = {
  [GameEnum.elementType.WE] = {
    sLanguage = "T_Element_Attr_1",
    icon = "icon_common_property_1",
    nSort = 1
  },
  [GameEnum.elementType.FE] = {
    sLanguage = "T_Element_Attr_2",
    icon = "icon_common_property_2",
    nSort = 2
  },
  [GameEnum.elementType.SE] = {
    sLanguage = "T_Element_Attr_3",
    icon = "icon_common_property_3",
    nSort = 3
  },
  [GameEnum.elementType.AE] = {
    sLanguage = "T_Element_Attr_4",
    icon = "icon_common_property_4",
    nSort = 4
  },
  [GameEnum.elementType.LE] = {
    sLanguage = "T_Element_Attr_5",
    icon = "icon_common_property_5",
    nSort = 5
  },
  [GameEnum.elementType.DE] = {
    sLanguage = "T_Element_Attr_6",
    icon = "icon_common_property_6",
    nSort = 6
  }
}
AllEnum.Char_Rarity = {
  [GameEnum.characterGrade.SR] = {nSort = 2},
  [GameEnum.characterGrade.SSR] = {nSort = 1}
}
AllEnum.Char_PowerStyle = {
  [GameEnum.characterJobClass.Vanguard] = {sLanguage = 101},
  [GameEnum.characterJobClass.Balance] = {sLanguage = 102},
  [GameEnum.characterJobClass.Support] = {sLanguage = 103}
}
AllEnum.Char_TacticalStyle = {
  [201] = {sLanguage = 201},
  [202] = {sLanguage = 202},
  [203] = {sLanguage = 203},
  [204] = {sLanguage = 204},
  [205] = {sLanguage = 205}
}
AllEnum.Char_AffiliatedForces = {
  [301] = {sLanguage = 301},
  [302] = {sLanguage = 302},
  [303] = {sLanguage = 303},
  [304] = {sLanguage = 304},
  [305] = {sLanguage = 305},
  [306] = {sLanguage = 306},
  [307] = {sLanguage = 307},
  [308] = {sLanguage = 308},
  [309] = {sLanguage = 309},
  [310] = {sLanguage = 310},
  [311] = {sLanguage = 311},
  [312] = {sLanguage = 312},
  [314] = {sLanguage = 314},
  [315] = {sLanguage = 315},
  [316] = {sLanguage = 316},
  [317] = {sLanguage = 317},
  [318] = {sLanguage = 318}
}
AllEnum.Star_Rarity = {
  [GameEnum.itemRarity.R] = {nSort = 3},
  [GameEnum.itemRarity.SR] = {nSort = 2},
  [GameEnum.itemRarity.SSR] = {nSort = 1}
}
AllEnum.Star_Note = {
  [90011] = {nSort = 1},
  [90012] = {nSort = 2},
  [90013] = {nSort = 3},
  [90014] = {nSort = 4},
  [90015] = {nSort = 5},
  [90016] = {nSort = 6},
  [90017] = {nSort = 7},
  [90018] = {nSort = 8},
  [90019] = {nSort = 9},
  [90020] = {nSort = 10},
  [90021] = {nSort = 11},
  [90022] = {nSort = 12},
  [90023] = {nSort = 13}
}
AllEnum.Star_Element = {
  [GameEnum.elementType.WE] = {
    sLanguage = "T_Element_Attr_1",
    icon = "icon_common_property_1",
    nSort = 1
  },
  [GameEnum.elementType.FE] = {
    sLanguage = "T_Element_Attr_2",
    icon = "icon_common_property_2",
    nSort = 2
  },
  [GameEnum.elementType.SE] = {
    sLanguage = "T_Element_Attr_3",
    icon = "icon_common_property_3",
    nSort = 3
  },
  [GameEnum.elementType.AE] = {
    sLanguage = "T_Element_Attr_4",
    icon = "icon_common_property_4",
    nSort = 4
  },
  [GameEnum.elementType.LE] = {
    sLanguage = "T_Element_Attr_5",
    icon = "icon_common_property_5",
    nSort = 5
  },
  [GameEnum.elementType.DE] = {
    sLanguage = "T_Element_Attr_6",
    icon = "icon_common_property_6",
    nSort = 6
  },
  [GameEnum.elementType.NONE] = {
    sLanguage = "T_Element_Attr_7",
    icon = "icon_common_property_7",
    nSort = 7
  }
}
AllEnum.Star_Tag = {
  [800] = {sLanguage = 800},
  [801] = {sLanguage = 801},
  [802] = {sLanguage = 802},
  [803] = {sLanguage = 803},
  [804] = {sLanguage = 804},
  [805] = {sLanguage = 805},
  [806] = {sLanguage = 806},
  [807] = {sLanguage = 807},
  [808] = {sLanguage = 808},
  [809] = {sLanguage = 809},
  [810] = {sLanguage = 810},
  [811] = {sLanguage = 811},
  [812] = {sLanguage = 812},
  [813] = {sLanguage = 813},
  [817] = {sLanguage = 817},
  [818] = {sLanguage = 818},
  [823] = {sLanguage = 823}
}
AllEnum.Equip_Rarity = {
  [GameEnum.itemRarity.R] = {},
  [GameEnum.itemRarity.SR] = {},
  [GameEnum.itemRarity.SSR] = {}
}
AllEnum.Equip_Type = {
  [GameEnum.equipmentType.Square] = {
    sLanguage = "Equipment_Type_Square",
    icon = "Icon/ZZZOther/equip_a_mini"
  },
  [GameEnum.equipmentType.Circle] = {
    sLanguage = "Equipment_Type_Circle",
    icon = "Icon/ZZZOther/equip_b_mini"
  },
  [GameEnum.equipmentType.Pentagon] = {
    sLanguage = "Equipment_Type_Pentagon",
    icon = "Icon/ZZZOther/equip_c_mini"
  }
}
AllEnum.Equip_Theme_Square = {
  [120081] = {sLanguage = 120081},
  [120641] = {sLanguage = 120641},
  [120571] = {sLanguage = 120571}
}
AllEnum.Equip_Theme_Circle = {
  [120011] = {sLanguage = 120011},
  [120021] = {sLanguage = 120021},
  [120561] = {sLanguage = 120561}
}
AllEnum.Equip_Theme_Pentagon = {
  [120031] = {sLanguage = 120031},
  [120091] = {sLanguage = 120091},
  [120581] = {sLanguage = 120581}
}
AllEnum.Equip_PowerStyle = {
  [101] = {sLanguage = 101, nSort = 2},
  [102] = {sLanguage = 102, nSort = 3},
  [103] = {sLanguage = 103, nSort = 4},
  [104] = {sLanguage = 104, nSort = 1}
}
AllEnum.Equip_TacticalStyle = {
  [201] = {sLanguage = 201, nSort = 2},
  [202] = {sLanguage = 202, nSort = 3},
  [203] = {sLanguage = 203, nSort = 4},
  [204] = {sLanguage = 204, nSort = 5},
  [205] = {sLanguage = 205, nSort = 6},
  [206] = {sLanguage = 206, nSort = 1}
}
AllEnum.Equip_AffiliatedForces = {
  [301] = {sLanguage = 301, nSort = 2},
  [302] = {sLanguage = 302, nSort = 3},
  [303] = {sLanguage = 303, nSort = 4},
  [304] = {sLanguage = 304, nSort = 5},
  [305] = {sLanguage = 305, nSort = 6},
  [306] = {sLanguage = 306, nSort = 7},
  [307] = {sLanguage = 307, nSort = 8},
  [308] = {sLanguage = 308, nSort = 9},
  [309] = {sLanguage = 309, nSort = 10},
  [310] = {sLanguage = 310, nSort = 11},
  [311] = {sLanguage = 311, nSort = 12},
  [312] = {sLanguage = 312, nSort = 13},
  [313] = {sLanguage = 313, nSort = 1}
}
AllEnum.Equip_Match = {
  [1] = {
    sLanguage = "Equipment_Filter_Match_Count_1",
    nSort = 1
  },
  [2] = {
    sLanguage = "Equipment_Filter_Match_Count_2",
    nSort = 2
  },
  [3] = {
    sLanguage = "Equipment_Filter_Match_Count_3",
    nSort = 3
  },
  [4] = {
    sLanguage = "Equipment_Filter_Match_Count_4",
    nSort = 4
  }
}
AllEnum.ChooseOption = {
  Char_Element = 1,
  Char_Rarity = 2,
  Char_PowerStyle = 3,
  Char_TacticalStyle = 4,
  Char_AffiliatedForces = 5,
  Star_Rarity = 10,
  Star_Note = 11,
  Star_Element = 13,
  Star_Tag = 14,
  Equip_Rarity = 20,
  Equip_Type = 21,
  Equip_Theme_Square = 22,
  Equip_Theme_Circle = 23,
  Equip_Theme_Pentagon = 24,
  Equip_PowerStyle = 25,
  Equip_TacticalStyle = 26,
  Equip_AffiliatedForces = 27,
  Equip_Match = 28
}
AllEnum.OptionLayout = {
  Normal = 1,
  NormalWithIcon = 2,
  Image = 3
}
AllEnum.ChooseOptionCfg = {
  [AllEnum.ChooseOption.Char_Element] = {
    sLanguage = "Filter_Element",
    layout = AllEnum.OptionLayout.NormalWithIcon,
    items = AllEnum.Char_Element
  },
  [AllEnum.ChooseOption.Char_Rarity] = {
    sLanguage = "Filter_Rare",
    layout = AllEnum.OptionLayout.Image,
    items = AllEnum.Char_Rarity
  },
  [AllEnum.ChooseOption.Char_PowerStyle] = {
    sLanguage = "Filter_Tag1",
    layout = AllEnum.OptionLayout.Normal,
    items = AllEnum.Char_PowerStyle
  },
  [AllEnum.ChooseOption.Char_TacticalStyle] = {
    sLanguage = "Filter_Tag2",
    layout = AllEnum.OptionLayout.Normal,
    items = AllEnum.Char_TacticalStyle
  },
  [AllEnum.ChooseOption.Char_AffiliatedForces] = {
    sLanguage = "Filter_Tag3",
    layout = AllEnum.OptionLayout.Normal,
    items = AllEnum.Char_AffiliatedForces
  },
  [AllEnum.ChooseOption.Star_Rarity] = {
    sLanguage = "Filter_Rare",
    layout = AllEnum.OptionLayout.Image,
    items = AllEnum.Star_Rarity
  },
  [AllEnum.ChooseOption.Star_Note] = {
    sLanguage = "Filter_Note",
    layout = AllEnum.OptionLayout.NormalWithIcon,
    items = AllEnum.Star_Note
  },
  [AllEnum.ChooseOption.Star_Element] = {
    sLanguage = "Filter_Element",
    layout = AllEnum.OptionLayout.NormalWithIcon,
    items = AllEnum.Star_Element
  },
  [AllEnum.ChooseOption.Star_Tag] = {
    sLanguage = "Filter_Tag1",
    layout = AllEnum.OptionLayout.Normal,
    items = AllEnum.Star_Tag
  },
  [AllEnum.ChooseOption.Equip_Rarity] = {
    sLanguage = "Filter_Rare",
    layout = AllEnum.OptionLayout.Image,
    items = AllEnum.Equip_Rarity
  },
  [AllEnum.ChooseOption.Equip_Type] = {
    sLanguage = "Filter_EquipmentType",
    layout = AllEnum.OptionLayout.NormalWithIcon,
    items = AllEnum.Equip_Type
  },
  [AllEnum.ChooseOption.Equip_Theme_Square] = {
    sLanguage = "Equipment_Filter_Main_Attr",
    layout = AllEnum.OptionLayout.Normal,
    items = AllEnum.Equip_Theme_Square
  },
  [AllEnum.ChooseOption.Equip_Theme_Circle] = {
    sLanguage = "Equipment_Filter_Main_Attr",
    layout = AllEnum.OptionLayout.Normal,
    items = AllEnum.Equip_Theme_Circle
  },
  [AllEnum.ChooseOption.Equip_Theme_Pentagon] = {
    sLanguage = "Equipment_Filter_Main_Attr",
    layout = AllEnum.OptionLayout.Normal,
    items = AllEnum.Equip_Theme_Pentagon
  },
  [AllEnum.ChooseOption.Equip_PowerStyle] = {
    sLanguage = "Filter_Tag1",
    layout = AllEnum.OptionLayout.Normal,
    items = AllEnum.Equip_PowerStyle
  },
  [AllEnum.ChooseOption.Equip_TacticalStyle] = {
    sLanguage = "Filter_Tag2",
    layout = AllEnum.OptionLayout.Normal,
    items = AllEnum.Equip_TacticalStyle
  },
  [AllEnum.ChooseOption.Equip_AffiliatedForces] = {
    sLanguage = "Filter_Tag3",
    layout = AllEnum.OptionLayout.Normal,
    items = AllEnum.Equip_AffiliatedForces
  },
  [AllEnum.ChooseOption.Equip_Match] = {
    sLanguage = "Equipment_Filter_Match_Count",
    layout = AllEnum.OptionLayout.Normal,
    items = AllEnum.Equip_Match
  }
}
AllEnum.OptionType = {
  Char = 1,
  Disc = 2,
  Equipment = 3
}
AllEnum.RewardType = {
  First = 1,
  Three = 2,
  Extra = 3,
  Double = 4
}
AllEnum.FormationEnterType = {
  MainLine = 0,
  FixedRoguelike = 1,
  StarTower = 2
}
AllEnum.RegionBossFormationType = {
  RegionBoss = 1,
  TravelerDuel = 2,
  DailyInstance = 3,
  InfinityTower = 4,
  EquipmentInstance = 5,
  Story = 6,
  Vampire = 7,
  ScoreBoss = 8,
  SkillInstance = 9,
  WeeklyCopies = 10,
  JointDrill = 11,
  ActivityLevels = 12,
  ActivityStory = 13,
  JointDrill_2 = 14,
  TraceHunt = 15,
  ScoreBoss_GM = 16
}
AllEnum.EnergyPanelType = {
  Main = 1,
  BuyConfirm = 2,
  ItemUse = 3,
  BatteryUse = 4
}
AllEnum.TokenBuyPanelType = {
  Main = 1,
  BuyConfirm = 2,
  ItemUse = 3
}
AllEnum.DispatchState = {
  CanAccept = 0,
  Accepting = 1,
  Complete = 2,
  Done = 3
}
AllEnum.PopUpType = {
  DailyCheckIn = 1,
  MonthlyCard = 2,
  Activity = 3,
  ActivityLogin = 4,
  NewChat = 5,
  FuncUnlock = 6,
  WorldClass = 7
}
AllEnum.GamepadUIType = {
  Xbox = 1,
  PS = 2,
  Keyboard = 3,
  Mouse = 4,
  Other = 5
}
AllEnum.StarTowerBookPanelType = {
  Main = 1,
  Potential = 2,
  FateCard = 3,
  Event = 4,
  Affinity = 5
}
AllEnum.FateCardBookStatus = {
  Lock = 1,
  UnLock = 2,
  Collect = 3
}
AllEnum.BookQuestStatus = {
  Complete = 1,
  UnComplete = 2,
  Received = 3
}
AllEnum.DatingEventStatus = {
  Lock = 1,
  Unlock = 2,
  Received = 3
}
AllEnum.DatingKrTags = {
  ["1"] = {
    ["==KR1=="] = "는",
    ["==KR2=="] = "가",
    ["==KR3=="] = "를",
    ["==KR4=="] = "와"
  },
  ["2"] = {
    ["==KR1=="] = "은",
    ["==KR2=="] = "이",
    ["==KR3=="] = "을",
    ["==KR4=="] = "과"
  }
}
AllEnum.KrTags = {
  ["1"] = {
    [1] = "가",
    [2] = "는",
    [3] = "를",
    [4] = "와"
  },
  ["2"] = {
    [1] = "이",
    [2] = "은",
    [3] = "을",
    [4] = "과"
  }
}
AllEnum.PotentialCardType = {
  StarTower = 1,
  CharInfo = 2,
  Book = 3,
  TowerDefense = 4,
  Detial = 5
}
AllEnum.PhoneTogType = {
  Chat = 1,
  Dating = 2,
  Gift = 3
}
AllEnum.ReceivePropsTitle = {Common = 1, Dating = 2}
AllEnum.DiscSkillIconSurfix = {
  Small = "_S",
  Corner = "_jb",
  S_Light = "_S_Light"
}
AllEnum.QuestPanelTab = {
  GuideQuest = 1,
  DailyQuest = 2,
  WeeklyQuest = 3,
  WorldClass = 4
}
AllEnum.QuestNewbieTab = {TeamFormation = 1, Tutorial = 2}
AllEnum.StarTowerFastBattleBg = {
  Bg_L = "bg_fastBattle_%s_l",
  Bg_R = "bg_fastBattle_%s_r",
  Flag = "zs_fastBattle_%s"
}
AllEnum.FateCardBundleIcon = {L = "_L", S = "_S"}
AllEnum.WorldClassType = {LevelUp = 1, Advance = 2}
AllEnum.ShopCondSource = {
  ResidentGoods = 1,
  ResidentShop = 2,
  MallShop = 3,
  MallPackage = 4
}
AllEnum.AnnType = {
  ActivityAnn = 1,
  SystemAnn = 2,
  Other1 = 3,
  Other2 = 4
}
AllEnum.StarTowerTipsType = {
  ItemTip = 1,
  DiscTip = 2,
  FateCardTip = 3,
  NoteTip = 4,
  NPCAffinity = 5
}
AllEnum.UI_SORTING_ORDER = {
  StarTowerSweepPopup = 29000,
  StarTowerSweepDetail = 29100,
  StarTowerAutoDecisionSetting = 29800,
  StarTowerAutoDecisionTokenBuy = 30100,
  AVG_Bubble = 298,
  AVG_ST = 299,
  StarTowerAutoDecisionHUD = 29700,
  Guide = 32000,
  GMMonsterAI = 32760,
  GMTool = 32760,
  Transition = 32761,
  ProVideo = 32762,
  MessageBox = 32763,
  BuiltinUICanvas = -32768,
  Tips = 32764,
  TipsEx = 32765,
  BuiltIn_Alert = 32766,
  BuiltIn_Connecting = 32767,
  BuiltIn_Block = 32767,
  Player_Info = 32764,
  LampNotice = 32764,
  MessageBoxOverlay = 32764,
  BlackEdge = 32765,
  _FPSCounter = 32766,
  TouchEffectUI = 32767
}
AllEnum.PhoneMsgType = {
  ReceiveMsg = 0,
  ReplyMsg = 1,
  ReplyChoiceMgs = 2,
  ReceiveImgMsg = 3,
  ReplyImgMsg = 4,
  SystemMsg = 5,
  InputingMsgLeft = 6,
  InputingMsgRight = 7
}
AllEnum.CharAdvancePreview = {
  LevelMax = 1,
  SkillLevelMax = 2,
  SkinUnlock = 3
}
AllEnum.DiscBgSurfix = {
  Main = "_M",
  L2d = "_L",
  Image = "_B",
  Card = "_G"
}
AllEnum.BossBloodType = {
  Single = 1,
  Multiple = 2,
  JointDrill_Mode_2 = 3
}
AllEnum.JointDrillResultType = {
  Success = 1,
  BattleEnd = 2,
  Retreat = 3,
  ChallengeEnd = 4
}
AllEnum.JointDrillLevelStartType = {
  Start = 1,
  Continue = 2,
  ChangeLevel = 3,
  Restart = 4
}
AllEnum.ActivityMainType = {Activity = 1, ActivityGroup = 2}
AllEnum.TutorialLevelLockType = {
  None = 1,
  WorldClass = 2,
  PreLevel = 3
}
AllEnum.JointDrillActStatus = {
  WaitStart = 1,
  Start = 2,
  WaitClose = 3,
  Closed = 4
}
AllEnum.DiscReadType = {DiscStory = 1, DiscAvg = 2}
AllEnum.BattleHudType = {Sector = 1, Horizontal = 2}
AllEnum.ActivityThemeFuncIndex = {
  MiniGame = 1,
  Task = 2,
  Story = 3,
  Shop = 4,
  Level = 5,
  FateCard = 6,
  TrekkerVersus = 7
}
AllEnum.CgSurfix = {Main = "_M", Image = ""}
AllEnum.Cg2DType = {Base = 1, L2D = 2}
AllEnum.CharSkinSource = {
  [GameEnum.skinSourceType.ACTIVITY] = "Skin_Unlock_Activity",
  [GameEnum.skinSourceType.TIMELIMIT] = "Skin_Unlock_Shop",
  [GameEnum.skinSourceType.ADVANCE] = "Skin_Unlock_Advance",
  [GameEnum.skinSourceType.BATTLEPASS] = "Skin_Unlock_Battlepass"
}
AllEnum.StorySetStatus = {
  Lock = 1,
  UnLock = 2,
  Received = 3
}
AllEnum.LevelMenuResourceList = {
  [1] = GameEnum.OpenFuncType.DailyInstance,
  [2] = GameEnum.OpenFuncType.RegionBoss,
  [3] = GameEnum.OpenFuncType.SkillInstance,
  [4] = GameEnum.OpenFuncType.CharGemInstance
}
AllEnum.CookieModeIcon = {
  [GameEnum.CookiePackModel.CookiePackNormalModel] = "/SpriteAtlas/Sprite/zs_activity_cookie_s_01",
  [GameEnum.CookiePackModel.CookiePackPathsModel] = "/SpriteAtlas/Sprite/zs_activity_cookie_s_02",
  [GameEnum.CookiePackModel.CookiePackRhythmlModel] = "/SpriteAtlas/Sprite/zs_activity_cookie_s_03"
}
AllEnum.TransitionStatus = {
  IsPlayingInAnim = 1,
  InAnimDone = 2,
  IsPlayingOutAnim = 3,
  OutAnimDone = 4
}
AllEnum.HandBookTab = {
  Skin = 1,
  Disc = 2,
  MainScreenCG = 3
}
AllEnum.PenguinCardSuitSprite = {
  [GameEnum.PenguinBaseCardSuit.Blue] = "icon_PengCard_Water",
  [GameEnum.PenguinBaseCardSuit.Red] = "icon_PengCard_Fire",
  [GameEnum.PenguinBaseCardSuit.Green] = "icon_PengCard_Wind"
}
AllEnum.GoldenSpyHitAreaType = {Circle = 1, Rectangle = 2}
AllEnum.TrekkerVersusDuelSelfInfo = {
  NameKey = "TD_SelfName",
  Icon = "UI_Activity/_600002/head_172_duel"
}
AllEnum.PreselectionPanelType = {
  Create = 1,
  Preview = 2,
  Edit = 3,
  SystemPreview = 4
}
AllEnum.GoldenSpyBuffType = {
  ActiveBuff = 1,
  DelayBuff = 2,
  UnactiveBuff = 3
}
AllEnum.GoldenSpyHookType = {Normal = 1, FishingHook = 2}
AllEnum.GamepadIconSuffix = {Light = "", Dark = "_2"}
AllEnum.SoldierHandbookType = {
  Character = 1,
  Partner = 2,
  Boss = 3,
  StrategyCard = 4
}
AllEnum.SoliderNoteTypeCfg = {
  [GameEnum.soldierNodeType.Event] = {
    Icon = "SoldierNodeType_Event",
    Language = "SoldierNodeType_Event"
  },
  [GameEnum.soldierNodeType.Battle] = {
    Icon = "SoldierNodeType_Battle",
    Language = "SoldierNodeType_Battle"
  },
  [GameEnum.soldierNodeType.MidBossBattle] = {
    Icon = "SoldierNodeType_MidBossBattle",
    Language = "SoldierNodeType_MidBossBattle"
  },
  [GameEnum.soldierNodeType.FinalBossBattle] = {
    Icon = "SoldierNodeType_FinalBossBattle",
    Language = "SoldierNodeType_FinalBossBattle"
  }
}
AllEnum.SoldierChessIconSurfix = {
  S = "_S",
  M = "_M",
  L = "_L",
  XL = "_XL",
  Fight = "_Fight",
  Sup = "_Sup"
}
AllEnum.SoldierPartnerLevelIcon = {
  [GameEnum.PartnerLevelQuality.None] = {
    bg = "PartnerQuality_00",
    levelIcon = "PartnerLevelQuality_00"
  },
  [GameEnum.PartnerLevelQuality.Copper] = {
    bg = "PartnerQuality_01",
    levelIcon = "PartnerLevelQuality_01"
  },
  [GameEnum.PartnerLevelQuality.Silver] = {
    bg = "PartnerQuality_02",
    levelIcon = "PartnerLevelQuality_02"
  },
  [GameEnum.PartnerLevelQuality.Gold] = {
    bg = "PartnerQuality_03",
    levelIcon = "PartnerLevelQuality_03"
  },
  [GameEnum.PartnerLevelQuality.Color] = {
    bg = "PartnerQuality_04",
    levelIcon = "PartnerLevelQuality_04"
  },
  [GameEnum.PartnerLevelQuality.Special] = {
    bg = "PartnerQuality_05",
    levelIcon = "PartnerLevelQuality_05"
  }
}
AllEnum.SoldierChessRarityIcon = {
  [GameEnum.ChessRarity.White] = "ChessQuality_01",
  [GameEnum.ChessRarity.Green] = "ChessQuality_02",
  [GameEnum.ChessRarity.Blue] = "ChessQuality_03",
  [GameEnum.ChessRarity.Purple] = "ChessQuality_04",
  [GameEnum.ChessRarity.Gold] = "ChessQuality_05",
  [GameEnum.ChessRarity.Color] = "ChessQuality_05"
}
AllEnum.SoldierStrategyCardRarityIcon = {
  [GameEnum.itemRarity.N] = "StrategyCardQuality_01",
  [GameEnum.itemRarity.M] = "StrategyCardQuality_02",
  [GameEnum.itemRarity.R] = "StrategyCardQuality_03"
}
AllEnum.SoldierItemRarityIcon = {
  [GameEnum.itemRarity.N] = "SoldierItemQuality_01",
  [GameEnum.itemRarity.M] = "SoldierItemQuality_02",
  [GameEnum.itemRarity.R] = "SoldierItemQuality_03",
  [GameEnum.itemRarity.SR] = "SoldierItemQuality_04",
  [GameEnum.itemRarity.SSR] = "SoldierItemQuality_05"
}
AllEnum.SoldierPositionStr = {
  [GameEnum.SoldierPositionType.FightPosition] = {
    sLanguageId = "Soldier_Handbook_Vanguard",
    sIcon = ""
  },
  [GameEnum.SoldierPositionType.SupportPosition] = {
    sLanguageId = "Soldier_Handbook_Support",
    sIcon = ""
  }
}
AllEnum.SoldierResultType = {
  NodeSuccess = 1,
  NodeFail = 2,
  ChallengeSuccess = 3,
  ChallengeFail = 4
}
AllEnum.SoldierRewardSource = {
  Apply = 1,
  EventBattle = 2,
  Battle = 3,
  CardWipe = 4
}
AllEnum.SoldierCardType = {
  UnknownCard = "Undefined",
  StartedCard = "Starter",
  StrategyCard = "Strategy"
}
AllEnum.SoldierPositionType = {
  Fight = 1,
  Support = 2,
  Waiting = 3,
  Other = 4
}
AllEnum.TrialMode = {ActivityTrial = 1, SkinTrial = 2}
AllEnum.ReengagementTog = {
  Signin = 1,
  Task = 2,
  DoubleDrop = 3,
  ShopMall = 4,
  BDTrial = 5
}
AllEnum.MainlineLastEndState = {
  None = 0,
  WaitUnlock = 1,
  Unlock = 2,
  Readed = 3,
  Fobidden = 4
}
AllEnum.SoldierTechBattleEffect = {
  [GameEnum.SoldierTechBattleEffect.FinalDamageUp] = {
    sIcon = "",
    sLanguageId = "Soldier_Tech_Node_FinalDamageUp"
  },
  [GameEnum.SoldierTechBattleEffect.FinalDamageReduceUp] = {
    sIcon = "",
    sLanguageId = "Soldier_Tech_Node_FinalDamageReduceUp"
  },
  [GameEnum.SoldierTechBattleEffect.SkillCritRateUp] = {
    sIcon = "",
    sLanguageId = "Soldier_Tech_Node_SkillCritRateUp"
  },
  [GameEnum.SoldierTechBattleEffect.SkillFinalDamageUp] = {
    sIcon = "",
    sLanguageId = "Soldier_Tech_Node_SkillFinalDamageUp"
  }
}
AllEnum.SoldierBossSkillType = {
  [GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_1] = {
    sIcon = "",
    sLanguageId = "Soldier_RoleSkillType_1"
  },
  [GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_2] = {
    sIcon = "",
    sLanguageId = "Soldier_RoleSkillType_2"
  },
  [GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_3] = {
    sIcon = "",
    sLanguageId = "Soldier_RoleSkillType_3"
  },
  [GameEnum.SoldierRoleSkillType.SoldierRoleSkillType_4] = {
    sIcon = "",
    sLanguageId = "Soldier_RoleSkillType_4"
  }
}
AllEnum.SoldierPersonalityLevelIconByStr = {
  S = "UI/Soldier/SpriteAtlas/Common/PersonalityGrade_S",
  A = "UI/Soldier/SpriteAtlas/Common/PersonalityGrade_A",
  ["A+"] = "UI/Soldier/SpriteAtlas/Common/PersonalityGrade_A+",
  B = "UI/Soldier/SpriteAtlas/Common/PersonalityGrade_B",
  ["B+"] = "UI/Soldier/SpriteAtlas/Common/PersonalityGrade_B+",
  C = "UI/Soldier/SpriteAtlas/Common/PersonalityGrade_C",
  ["C+"] = "UI/Soldier/SpriteAtlas/Common/PersonalityGrade_C+"
}
AllEnum.SoldierPersonalityLevelIconByEnum = {
  [GameEnum.SoldierPersonalityGrade.PersonalityGrade_1] = "UI/Soldier/SpriteAtlas/Common/PersonalityGrade_S",
  [GameEnum.SoldierPersonalityGrade.PersonalityGrade_2] = "UI/Soldier/SpriteAtlas/Common/PersonalityGrade_A+",
  [GameEnum.SoldierPersonalityGrade.PersonalityGrade_3] = "UI/Soldier/SpriteAtlas/Common/PersonalityGrade_A",
  [GameEnum.SoldierPersonalityGrade.PersonalityGrade_4] = "UI/Soldier/SpriteAtlas/Common/PersonalityGrade_B+",
  [GameEnum.SoldierPersonalityGrade.PersonalityGrade_5] = "UI/Soldier/SpriteAtlas/Common/PersonalityGrade_B",
  [GameEnum.SoldierPersonalityGrade.PersonalityGrade_6] = "UI/Soldier/SpriteAtlas/Common/PersonalityGrade_C+",
  [GameEnum.SoldierPersonalityGrade.PersonalityGrade_7] = "UI/Soldier/SpriteAtlas/Common/PersonalityGrade_C"
}
AllEnum.SoldierPersonalityDB = {
  [0] = "UI/Soldier/SpriteAtlas/Event/db_soldier_common_event_1",
  [GameEnum.SoldierRolePersonality.Personality_Analysis] = "UI/Soldier/SpriteAtlas/Event/db_soldier_common_event_2",
  [GameEnum.SoldierRolePersonality.Personality_Intuition] = "UI/Soldier/SpriteAtlas/Event/db_soldier_common_event_3",
  [GameEnum.SoldierRolePersonality.Personality_Chaos] = "UI/Soldier/SpriteAtlas/Event/db_soldier_common_event_4"
}
AllEnum.StarTowerAutoDecisionSettings = {
  AutoDecisionEnable = 0,
  PresetFirstSwitch = 10101,
  PresetOnlySwitch = 10102,
  PotentialSort = 10201,
  PotentialRerollSwitch = 10301,
  PotentialRerollCoinNumSelector = 10302,
  ShopFirstChoose = 20101,
  ShopUpgradeDropdown = 20201,
  ShopSort = 20301,
  ShopCoinRerollSwitch = 20401,
  ShopCoinNumSelector = 20402,
  ShopFinalRerollSwitch = 20403,
  ShopFinalAllInSwitch = 20404,
  EventTendency = 30101,
  EventSort = 30201
}
AllEnum.GuideType = {Dorm = 1, Soldier = 2}
AllEnum.SoldierDiscAddType = {BuffCard = 1, TechNode = 2}
AllEnum.SoldierEventEffectRewardType = {
  Next = "Next",
  GainCoin = "GainCoin",
  LossCoin = "LossCoin",
  Chess = "Chess",
  Hp = "Hp",
  Card = "Card",
  CardEffect = "CardEffect",
  LoseAllCoin = "LoseAllCoin"
}
return AllEnum
