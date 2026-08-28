local Enum = {
  Depot = {
    Item = 1,
    Material = 2,
    Equipment = 3,
    Warehouse = 4,
    FridgeItem = 5,
    TrainWeapon = 6,
    Key = 7,
    Keepsake = 8,
    WareGoods = 9
  },
  ItemType = {Item = 1, Material = 2},
  Sort = {
    Level = 1,
    Quality = 2,
    Time = 3
  },
  LevelSort = {LevelDesc = 1, LevelAsc = 2},
  QualitySort = {QualityDesc = 3, QualityAsc = 4},
  TimeSort = {TimeDesc = 5, TimeAsc = 6},
  DrawCard = {
    One = 1,
    Ten = 2,
    OneSkip = 3
  },
  OpenTip = {Depot = 1, NoDepot = 2},
  ItemModType = {Use = 1, Jump = 2},
  ItemUseType = {
    Regular = 0,
    Select = 1,
    Random = 2
  },
  CampType = {
    All = 0,
    Camp_1 = 1,
    Camp_2 = 2,
    Camp_3 = 3,
    Camp_4 = 4,
    Camp_5 = 5
  },
  CommonFilterType = {
    SquadView = 1,
    OtherSort = 2,
    SettlementView = 3
  },
  SortType = {
    level = 1,
    rarity = 2,
    time = 3,
    combat = 4,
    filter = 5
  },
  Ease = {
    Unset = 0,
    Linear = 1,
    InSine = 2,
    OutSine = 3,
    InOutSine = 4,
    InQuad = 5,
    OutQuad = 6,
    InOutQuad = 7,
    InCubic = 8,
    OutCubic = 9,
    InOutCubic = 10,
    InQuart = 11,
    OutQuart = 12,
    InOutQuart = 13,
    InQuint = 14,
    OutQuint = 15,
    InOutQuint = 16,
    InExpo = 17,
    OutExpo = 18,
    InOutExpo = 19,
    InCirc = 20,
    OutCirc = 21,
    InOutCirc = 22,
    InElastic = 23,
    OutElastic = 24,
    InOutElastic = 25,
    InBack = 26,
    OutBack = 27,
    InOutBack = 28,
    InBounce = 29,
    OutBounce = 30,
    InOutBounce = 31,
    Flash = 32,
    InFlash = 33,
    OutFlash = 34,
    InOutFlash = 35
  },
  BattleLevelMod = {
    base = "\229\159\186\231\161\128\229\133\179\229\141\161",
    college = "\229\173\166\233\153\162\229\133\179\229\141\161",
    resource = "\232\181\132\230\186\144\229\133\179\229\141\161",
    arena = "\231\171\158\230\138\128\229\156\186",
    plot = "\229\137\167\230\131\133\229\133\179",
    challenge = "\232\175\149\231\130\188\229\156\186"
  },
  QuestRarity = {
    low = "low",
    middle = "middle",
    high = "high",
    super = "super"
  },
  QuestRarityNum = {
    low = 1,
    middle = 2,
    high = 3,
    super = 4
  },
  QuestListDefine = {
    All = 0,
    BattlePassQuest = 1,
    SomeOneStationQuest = 2,
    AllStationQuest = 3
  },
  HomeSkillEnum = {
    HaggleSuccessRate = "HaggleSuccessRate",
    RiseSuccessRate = "RiseSuccessRate",
    HaggleRange = "HaggleRange",
    RiseRange = "RiseRange",
    AddHaggleNum = "AddHaggleNum",
    AddRiseNum = "AddRiseNum",
    AddQty = "AddQty",
    TaxCuts = "TaxCuts",
    AddSpeed = "AddSpeed",
    AddSuccessRate = "AddSuccessRate",
    AddSpecQty = "AddSpecQty",
    AddTypeQty = "AddTypeQty",
    ReduceBargainFailEnergy = "ReduceBargainFailEnergy",
    OneForAll = "OneForAll",
    AddSpeedPercentage = "AddSpeedPercentage",
    AddTrust = "AddTrust",
    AccelerationBrakingPerformance = "AccelerationBrakingPerformance",
    RiseEnergyLimited = "RiseEnergyLimited",
    AddEnergyMax = "AddEnergyMax",
    AddComfort = "AddComfort",
    AddPetScores = "AddPetScores",
    AddPlantScores = "AddPlantScores",
    AddFoodScores = "AddFoodScores",
    AddFishScores = "AddFishScores",
    AddPlayScores = "AddPlayScores",
    AddMedicalScores = "AddMedicalScores",
    RiseFliersSaveLimited = "RiseFliersSaveLimited",
    ReduceEscapeEnergy = "ReduceEscapeEnergy",
    RiseElectricLimited = "RiseElectricLimited",
    RiseElectricMax = "RiseElectricMax",
    RiseDurabilityLimited = "RiseDurabilityLimited",
    RiseRushLimited = "RiseRushLimited",
    RiseSpaceLimited = "RiseSpaceLimited",
    RiseBentoEnergy = "RiseBentoEnergy",
    ReduceRepairCost = "ReduceRepairCost",
    RisePetLoveGains = "RisePetLoveGains",
    ReducePetFoodConsume = "ReducePetFoodConsume",
    AddDeterrence = "AddDeterrence",
    ReduceBuyPassCost = "ReduceBuyPassCost",
    AddColoudness = "AddColoudness",
    AddBalloonSR = "AddBalloonSR",
    AddBargainNum = "AddBargainNum",
    OneOfUs = "OneOfUs",
    FirstBargain = "FirstBargain",
    AfterBargainFail = "AfterBargainFail",
    HomeBattleBuff = "HomeBattleBuff",
    RiseWorkshopOutput = "RiseWorkshopOutput",
    RisePrisonExtraRate = "RisePrisonExtraRate",
    AddEntrustReward = "AddEntrustReward",
    AddRecycleReward = "AddRecycleReward",
    RiseTrashStagingLimited = "RiseTrashStagingLimited",
    AddTieVal = "AddTieVal",
    AddTrailerFreeNum = "AddTrailerFreeNum",
    AddTrailerSpeed = "AddTrailerSpeed"
  },
  TrainWeaponTagEnum = {
    ElectricCost = "ElectricCost",
    TrainSpeed = "TrainSpeed",
    RiseSpaceLimited = "RiseSpaceLimited",
    RushSpeed = "RushSpeed",
    RiseRushLimited = "RiseRushLimited",
    RiseRushUseTime = "RiseRushUseTime",
    RiseDurabilityLimited = "RiseDurabilityLimited",
    AddColoudness = "AddColoudness",
    AddDeterrence = "AddDeterrence",
    TrainHP = "TrainHP",
    PassengerNum = "PassengerNum",
    TrainStartAddSpeed = "TrainStartAddSpeed",
    TrainStoptAddSpeed = "TrainStoptAddSpeed",
    MonsterClickDistance = "MonsterClickDistance",
    BoxClickDistance = "BoxClickDistance",
    TrainWeaponImpact = "TrainWeaponImpact",
    TrainWeaponDurability = "TrainWeaponDurability",
    TrainAddSpeedBuff = "TrainAddSpeedBuff",
    AutoPickGoods = "AutoPickGoods",
    TrainBattleBuff = "TrainBattleBuff",
    AddBalloonSR = "AddBalloonSR",
    GoodsOverVal = "GoodsOverVal",
    EffectLineList = "EffectLineList",
    PrisonerBackPack = "PrisonerBackPack",
    AsternSpeed = "AsternSpeed",
    LightingTimeAdd = "LightingTimeAdd",
    TrainWeaponAtk = "TrainWeaponAtk"
  },
  TrainStateEnter = {
    None = 0,
    DriveNew = 1,
    Refresh = 2,
    ApplicationQuit = 3,
    BattleFinish = 4,
    FirstLogin = 5,
    Arrive = 6
  },
  NPCTalkDataEnum = {
    PlayerName = "PlayerName",
    BuySuddenRise = "BuySuddenRise",
    BuySuddenDrop = "BuySuddenDrop",
    SellSuddenRise = "SellSuddenRise",
    SellSuddenDrop = "SellSuddenDrop",
    Drop = "Drop",
    Rise = "Rise",
    RareGoods = "RareGoods"
  },
  GuideNoUpdateLimitDataEnum = {
    LevelId = "LevelId",
    CheckLevelMod = "CheckLevelMod"
  },
  TrainBorn = {Start = 1, End = 2},
  FlierConditionShowType = {
    showLockLv = 1,
    showNeedClean = 2,
    functionLock = 3,
    lefLetLock = 4,
    magazineLock = 5,
    channelLock = 6
  },
  EFurLightColorType = {
    Red = "Red",
    Yellow = "Yellow",
    Green = "Green",
    Cyan = "Cyan",
    Blue = "Blue",
    Purple = "Purple"
  },
  EFurLightColor = {
    Red = Color(1, 0.5529411764705883, 0.5254901960784314, 1),
    Yellow = Color(1, 0.8352941176470589, 0.5254901960784314, 1),
    Green = Color(0.5411764705882353, 1, 0.5254901960784314, 1),
    Cyan = Color(0.5254901960784314, 1, 0.9882352941176471, 1),
    Blue = Color(0.5254901960784314, 0.5764705882352941, 1, 1),
    Purple = Color(1, 0.5254901960784314, 0.9607843137254902, 1)
  },
  EFurLightMaterialPath = {
    Red = "Home/Furniture/3D/Home_Furniture_DanRenChuang/Materials/Home_Furniture_DanRenChuang_dengdai_red",
    Yellow = "Home/Furniture/3D/Home_Furniture_DanRenChuang/Materials/Home_Furniture_DanRenChuang_dengdai_yellow",
    Green = "Home/Furniture/3D/Home_Furniture_DanRenChuang/Materials/Home_Furniture_DanRenChuang_dengdai_green",
    Cyan = "Home/Furniture/3D/Home_Furniture_DanRenChuang/Materials/Home_Furniture_DanRenChuang_dengdai_cyan",
    Blue = "Home/Furniture/3D/Home_Furniture_DanRenChuang/Materials/Home_Furniture_DanRenChuang_dengdai_blue",
    Purple = "Home/Furniture/3D/Home_Furniture_DanRenChuang/Materials/Home_Furniture_DanRenChuang_dengdai_purple"
  },
  EFurLightColorRotate = {
    Red = 0,
    Yellow = -60,
    Green = -120,
    Cyan = 180,
    Blue = 120,
    Purple = 60
  },
  Sex = {Female = 0, Male = 1},
  DriveState = {
    Stop = 0,
    InStation = -1,
    Driving = -2,
    Arrive = -3
  },
  Announcement = {
    Start = 0,
    Arriving = 1,
    Arrive = 2,
    Enter = 3
  },
  ESkinType = {
    Suit = 12600691,
    Up = 12600689,
    Bottom = 12600690,
    Shoes = 12600693,
    Head = 12600687,
    Face = 12600688,
    Eye = 12600624,
    FaceCover = 12601659,
    Hair = 12600362
  },
  ESkinNude = {
    Up = 85500007,
    Bottom = 85500008,
    Shoes = 85500027
  },
  ESkinHairType = {
    Default = "Default",
    Hat = "Hat",
    FaceCover = "FaceCover"
  },
  BookSortEnemy = {
    All = "",
    Elites = 12601047,
    Boss = 12601048
  },
  EQuestState = {
    UnFinish = 0,
    Finish = 1,
    Receive = 2,
    Lock = 3
  },
  EPrisonerSortType = {
    State = 0,
    Efficiency = 1,
    Energy = 2,
    DayCount = 3
  },
  StateSort = {State = 0},
  EfficiencySort = {EfficiencyDesc = 1, EfficiencyAsc = 2},
  EnergySort = {EnergyDesc = 3, EnergyAsc = 4},
  DayCountSort = {DayCountDesc = 5, DayCountAsc = 6},
  CoachBagTagToFurBagKey = {
    [12601230] = "furniture",
    [12601231] = "facility"
  },
  KabaneriEnum = {
    CurHP = "CurHP",
    HpMax = "HpMax",
    Strike = "Strike",
    Speed = "Speed",
    Shield = "Shield",
    WhosYourDaddy = "WhosYourDaddy",
    Defence = "Defence"
  },
  GiveLikeType = {Revenue = "revenue", Other = "other"}
}
return Enum
