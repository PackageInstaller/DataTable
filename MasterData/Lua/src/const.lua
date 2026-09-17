L_Const = L_Const or {}
require("proto.ProtoEnum")
require("settingConst")
L_Const.blockSize = 30
L_Const.errorCode = require("proto.ErrCode")
L_Const.frameScale = 60
L_Const.baseFov = 60
L_Const.oneDaySecond = 86400
L_Const.weatherSecondRate = 2400 / L_Const.oneDaySecond
L_Const.maxInt = 2147483647
L_Const.minInt = -2147483648

function L_Const.emptyFunction()
end

L_Const.emptyTable = table.empty
L_Const.enterGameWhiteMsg = {
  [MsgGenCode.CSProtoCreatePlayer] = true,
  [MsgGenCode.CSProtoAnnounceRequest] = true
}
L_Const.localCallBackErrorCode = -9999
L_Const.errorCodeTriggerType = {dialogBox = 1, flyMessage = 2}
L_Const.layer = {
  default = 0,
  water = 4,
  ui = 5,
  character = 7,
  hidden = 13,
  npc = 19,
  photo = 20
}
L_Const.sexType = {male = 1, female = 2}
L_Const.doTweenPathType = {
  Liner = 0,
  CatmullRom = 1,
  CubicBezier = 2
}
L_Const.modAvtarModule = {world = "World", uiPreview = "UIPreview"}
L_Const.groupType = {pve = 1}
L_Const.serverMoveType = {
  transfer = 1,
  jump = 2,
  dodge = 3,
  run = 4,
  walk = 5
}
L_Const.stateType = {
  free = "free",
  singeInteractive = "singleInteractive",
  doubleInteractive = "doubleInteractive",
  itemInteractive = "itemInteractive",
  mountInteractive = "mountInteractive",
  singlePhotoAction = "singlePhotoAction"
}
L_Const.stateStep = {
  inState = 1,
  actionFrame = 2,
  breakFrame = 3,
  leave = 4,
  replace = 5
}
L_Const.roleType = {
  unit = -1,
  hero = 1,
  boss = 3,
  mount = 4,
  pet = 5
}
L_Const.rankUpInfoType = {
  unitIdChange = 1,
  unlockInnerSkill = 2,
  unlockGeneSlot = 3,
  unlockGene = 4
}
L_Const.cameraSwitchMode = {null = 0, fadeIn = 1}
L_Const.interactiveType = {
  talk = 1,
  query = 2,
  photoPoint = 6,
  jumpFunction = 7,
  openUI = 8,
  transferScene = 10,
  transferPoint = 11,
  eggTakeup = 12,
  activateTransferPoint = 13,
  dungeonPhaseTransfer = 14,
  battle = 20,
  randomChest = 29,
  pickUpBook = 30,
  pickUpTask = 40,
  executeTask = 41,
  submitItemTask = 42,
  keepTaskTalk = 43,
  fixBuilding = 50,
  collect = 51,
  homeCropBox = 52,
  homeCropPet = 53,
  homeRanchBox = 54,
  wildBuffBuilding = 55,
  dungeonEntry = 60,
  suYaDungeonEntry = 61,
  enterBossField = 62,
  dungeonChest = 63,
  suYaDungeonChest = 64,
  worldBossChest = 65,
  transpointRecover = 66,
  playerCollect = 67,
  kiboDuel = 70,
  kiboDuelStory = 71,
  FreeView = 72,
  TransferHomeRoadsign = 73,
  bubble = 1001,
  rim = 1002
}
L_Const.petTimelineState = {
  Main = 1,
  Breed = 2,
  EggHouse = 3,
  Hatch = 4,
  Shop = 5
}
L_Const.petStage = {
  infancy = 1,
  growth = 2,
  maturation = 3,
  ultimate = 4
}
L_Const.petHouseTimeline = {
  BreedToMain = "BreedToMain",
  EgghouseToHatch = "EgghouseToHatch",
  EgghouseToMain = "EgghouseToMain",
  HatchToEgghouse = "HatchToEgghouse",
  MainToBreed = "MainToBreed",
  MainToEgghouse = "MainToEgghouse",
  MainToShop = "MainToShop",
  ShopToMain = "ShopToMain",
  MainLoop = "MainLoop",
  BreedLoop = "BreedLoop",
  EggHouseLoop = "EggHouseLoop",
  HatchLoop = "HatchLoop",
  ShopLoop = "ShopLoop"
}
L_Const.getPetShowType = {
  short = 1,
  middle = 2,
  long = 3
}
L_Const.playStatus = {
  normal = 0,
  battle = 1,
  mining = 2
}
L_Const.anim = {
  idle = "Idle",
  walk = "Walk",
  run = "Run",
  fastRun = "FastRun",
  dodge = "Dodge"
}
L_Const.callbackType = {
  success = 1,
  fail = 2,
  interrupt = 3
}
L_Const.cameraMode = {
  world = "world",
  story = "story",
  battle = "battle",
  fishing = "fishing",
  npShop = "npcShop",
  menu = "menu",
  dungeon = "dungeon",
  collection = "collection",
  uiScene = "uiScene",
  photo = "photo",
  photographPoint = "photographPoint",
  subItem = "subItem",
  homeBuild = "homeBuild",
  npcKiBoDuel = "npcKiBoDuel",
  npcEntrustTask = "npcEntrustTask"
}
L_Const.loadingMode = {
  base = "base",
  default = "default",
  scene = "scene",
  battleIn = "battleIn",
  blackCutIn = "blackCutIn",
  battleOut = "battleOut",
  saveFormation = "saveFormation",
  blackShow = "blackShow",
  whiteShow = "whiteShow"
}
L_Const.loadingShowType = {
  [1] = L_Const.loadingMode.default,
  [2] = L_Const.loadingMode.blackShow,
  [3] = L_Const.loadingMode.whiteShow
}
L_Const.loadingBgType = {
  none = 0,
  normal = 1,
  mask = 2
}
L_Const.axisType = {
  none = 0,
  emainMoveMent = 1,
  eChiyoPerformanceRotate = 2,
  eNavigate = 3,
  eCommonLStickMove = 4,
  eCommonScrollText = 5,
  eCommonRStickMove = 6,
  max = 7
}
L_Const.bigMapModule = {navigation = 1, freedom = 2}
L_Const.colorHtml = {
  white001 = "#ffffff",
  white002 = "#31792e",
  grey01 = "#706a72",
  grey02 = "#a79daa",
  grey03 = "#ddc2ba",
  grey04 = "#b3b3b3",
  grey05 = "#9b907b",
  grey001 = "#111a22",
  grey002 = "#24344e",
  grey003 = "#4f525d",
  grey004 = "#76777d",
  grey005 = "#acb6c3",
  grey006 = "#8b8c8f",
  grey007 = "#e1e1e1",
  grey008 = "#aaaaaa",
  grey009 = "#d5d5e3",
  grey010 = "#c1c1c1",
  grey011 = "#465156",
  grey012 = "#aa9d8f",
  grey013 = "#f4f5ea",
  grey014 = "#666972",
  grey015 = "#628395",
  grey016 = "#404040",
  grey017 = "#3e3b36",
  red01 = "#ffaab6",
  red001 = "#ff7e6d",
  red002 = "#b07373",
  red003 = "#ffa6a6",
  red005 = "#ef5743",
  red009 = "#ff848a",
  yellow0 = "#ffca11",
  yellow001 = "#fbdd95",
  yellow002 = "#ffbf35",
  yellow004 = "#9d814f",
  yellow005 = "#e0923e",
  yellow011 = "#ffae3b",
  yellow016 = "#605643",
  yellow017 = "#ffd65b",
  yellow020 = "#523e31",
  green01 = "#27e3a3",
  green001 = "#27ae89",
  green002 = "#96f9ff",
  green003 = "#a7ffa7",
  green004 = "#bcf6de",
  green007 = "#73c74a",
  green009 = "#2cfa93",
  blue001 = "#4C5E87",
  blue002 = "#a9c3fd",
  blue004 = "#c4e8ff",
  blue005 = "#3266b4",
  blue007 = "#2bc6ff",
  blue008 = "#4767df",
  blue010 = "#7ed6ff",
  blue013 = "#3ab3ff",
  blue015 = "#c2fff9",
  blue016 = "#6affea",
  purple002 = "#a264ff",
  purple003 = "#766c8b",
  purple004 = "#4a425b"
}
L_Const.pageRewardType = {
  normal = 1,
  battle = 2,
  parsed = 4
}
L_Const.moduleControl = {
  default = 0,
  world = 1,
  story = 2,
  battle = 3,
  ui = 4,
  other = 5,
  fly = 6,
  heroUltimateSkill = 7
}
L_Const.luaType = {
  number = "number",
  string = "string",
  boolean = "bool",
  func = "function",
  tab = "table"
}
L_Const.professionType = {
  [1] = "BSHero/tex_herodetail_icon_zhan",
  [2] = "BSHero/tex_herodetail_icon_ci",
  [3] = "BSHero/tex_herodetail_icon_gong",
  [4] = "BSHero/tex_herodetail_icon_fa",
  [5] = "BSHero/tex_herodetail_icon_fu"
}
L_Const.professionType_bw = {
  [1] = "BSCommon/tex_common_icon_jb_zs",
  [2] = "BSCommon/tex_common_icon_jb_ck",
  [3] = "BSCommon/tex_common_icon_jb_ss",
  [4] = "BSCommon/tex_common_icon_jb_fs",
  [5] = "BSCommon/tex_common_icon_jb_fz"
}
L_Const.battleType = {single = 0, multi = 1}
L_Const.battleResult = {
  Lose = 0,
  Win = 1,
  Interrupt = 2
}
L_Const.battleEntry = {
  world = 0,
  dungeon = 1,
  tower = 3
}
L_Const.battleAtt = {
  ATK = 1,
  MATK = 2,
  DEF = 3,
  MDEF = 4,
  MAXHP = 5,
  MAXSP = 6,
  CRI = 7,
  CRI_DMG = 8,
  SHOOT_DMGUP = 21,
  SUFFER_DMGDOWN = 22,
  SHOOT_HEALUP = 23,
  SUFFER_HEALUP = 24,
  PHYSICAL_SHOOTDMGUP = 25,
  PHYSICAL_SUFFERDMGDOWN = 26,
  MAGIC_SHOOTDMGDUP = 27,
  MAGIC_SUFFERDMGDOWN = 28,
  PERPIERCING = 29,
  PERMPIERCING = 30,
  LEECH = 31,
  REBOUND = 32,
  COLDDOWN = 33,
  MASS = 34,
  SPEED = 35,
  NORMAL_SHOOTDMGUP = 51,
  FIRE_SHOOTDMGUP = 52,
  WIND_SHOOTDMGUP = 53,
  EARTH_SHOOTDMGUP = 54,
  WOOD_SHOOTDMGUP = 55,
  ICE_SHOOTDMGUP = 56,
  WATER_SHOOTDMGUP = 57,
  ELEC_SHOOTDMGUP = 58,
  LIGHT_SHOOTDMGUP = 59,
  DARK_SHOOTDMGUP = 60,
  NORMAL_DEFENSE = 61,
  FIRE_DEFENSE = 62,
  WIND_DEFENSE = 63,
  EARTH_DEFENSE = 64,
  WOOD_DEFENSE = 65,
  ICE_DEFENSE = 66,
  WATER_DEFENSE = 67,
  ELEC_DEFENSE = 68,
  LIGHT_DEFENSE = 69,
  DARK_DEFENSE = 70,
  CRI_SUFFERDMGDOWN = 101,
  CRI_DEFENSE = 102,
  STEERINGSPEED = 103,
  BLOCKTHROWS = 104,
  SPGETUP = 105,
  SOLDIER_SUFFERAOEDMGDOWN = 106,
  PIERCING = 107,
  MPIERCING = 108,
  HPR_SEC = 109,
  SPR_SEC = 110,
  SHIELD = 111,
  THREAT = 112,
  SKILLPRIORITY = 113,
  WEEKNESS_VALUE = 201,
  MASTERY = 229,
  BREAK_VALUE = 230,
  FLY_LEVEL = 998,
  UNIT_TYPE = 999,
  PER_ATK = 1001,
  PER_MATK = 1002,
  PER_DEF = 1003,
  PER_MDEF = 1004,
  PER_MAXHP = 1005,
  PER_MASS = 1006,
  PER_SPEED = 1007,
  EXTRA_ATK = 2001,
  EXTRA_MATK = 2002,
  EXTRA_DEF = 2003,
  EXTRA_MDEF = 2004,
  EXTRA_MAXHP = 2005,
  EXTRA_MASS = 2006,
  EXTRA_SPEED = 2007
}
L_Const.battleBaseAtt = {
  L_Const.battleAtt.MAXHP,
  L_Const.battleAtt.ATK,
  L_Const.battleAtt.DEF,
  L_Const.battleAtt.MDEF
}
L_Const.battleResistanceAtt = {
  L_Const.battleAtt.CRI,
  L_Const.battleAtt.CRI_DMG,
  L_Const.battleAtt.SHOOT_HEALUP,
  L_Const.battleAtt.SUFFER_HEALUP,
  L_Const.battleAtt.PIERCING,
  L_Const.battleAtt.PERPIERCING,
  L_Const.battleAtt.MPIERCING,
  L_Const.battleAtt.PERMPIERCING,
  L_Const.battleAtt.PHYSICAL_SHOOTDMGUP,
  L_Const.battleAtt.PHYSICAL_SUFFERDMGDOWN,
  L_Const.battleAtt.MAGIC_SHOOTDMGDUP,
  L_Const.battleAtt.MAGIC_SUFFERDMGDOWN,
  L_Const.battleAtt.SHOOT_DMGUP,
  L_Const.battleAtt.SUFFER_DMGDOWN
}
L_Const.hpStackState = {
  Normal = 0,
  Show = 1,
  Cast = 2,
  Reduce = 3
}
L_Const.dungeonStory = {pre = 1, after = 2}
L_Const.heroData = {
  story = 1,
  voice = 2,
  drama = 3
}
L_Const.avatarTextureIndex = {
  painting = 1,
  half_raffle = 2,
  half_formation = 3,
  head = 4,
  head_circle = 5,
  head_talk = 6,
  head_big = 7,
  body = 8
}
L_Const.resourceIndexOfAvatarTextureInHeroTpl = {
  large = 1,
  mid = 2,
  small = 3,
  headBig = 4,
  FgetHasHero
}
L_Const.nationTextureIndex = {heroNation = 1, nationLarge = 2}
L_Const.avatarModelIndex = {UnitModel = 1, InstanceModel = 2}
L_Const.avatarAnimatorConfigIndex = {
  gmHeroView = 1,
  world = 2,
  uiPreview = 3,
  rootMotion = 6
}
L_Const.homeEntityTouchLimit = 2
L_Const.HomeEditorMode = {
  free = 1,
  photo = 2,
  editor = 3,
  playerEditor = 4
}
L_Const.HomeSetErrorType = {
  success = 1,
  inOtherSet = 2,
  outArea = 3,
  inBarrier = 4
}
L_Const.homeGridDataYOffset = 100000
L_Const.homeTitle = {}
L_Const.homeBuildingStatus = {
  bePlace = 1,
  interactive = 2,
  blend = 3,
  place = 4
}
L_Const.homeDecorationState = {normal = 1}
L_Const.homeActionLayer = L_Const.layer.character
L_Const.homeBuildingUpgradeStatus = {
  idle = 1,
  building = 2,
  upgrading = 3,
  finish = 4
}
L_Const.homeResidentMaxLevel = 5
L_Const.storyNpcState = {show = 0, hide = 1}
L_Const.dialogueStyleType = {
  normal = 0,
  continue = 1,
  leave = 2
}
L_Const.taskStatus = {
  unReceive = 0,
  canReceive = 1,
  underway = 2,
  complete = 3,
  rewarded = 4
}
L_Const.taskType = {
  main = 1,
  branch = 2,
  guide = 3,
  random = 7,
  activeTaskTagType = 9
}
L_Const.taskTabType = {
  main = 1,
  branch = 2,
  guide = 3,
  role = 4
}
L_Const.taskTraceTargetType = {
  guide = -2,
  birthPos = -1,
  targetEntity = 0,
  targetPos = 1
}
L_Const.taskTraceGuideType = {homeBuilding = 1}
L_Const.taskStatusName = {
  [L_Const.taskStatus.unReceive] = "ui_timeMessage_06",
  [L_Const.taskStatus.canReceive] = "ui_timeMessage_07",
  [L_Const.taskStatus.complete] = "ui_timeMessage_08",
  [L_Const.taskStatus.rewarded] = "ui_timeMessage_09",
  [L_Const.taskStatus.underway] = "ui_timeMessage_10"
}
L_Const.taskClientEvent = {
  npcInteractive = 1001,
  itemInteractive = 1002,
  dramComplete = 1003,
  storyEnd = 1004,
  timeChange = 1100,
  submitItem = 2501,
  openTaskStory = 2507,
  createNPC = 2704,
  deleteNPC = 2705,
  submitTypeItem = 2513,
  submitGroupItem = 2514,
  submitTaskItem = 2515
}
L_Const.taskServerEvent = {
  objInteractive = 2000,
  triggerEvent = 2001,
  killNpc = 2002,
  enterDungeon = 2003,
  level = 2004,
  getWeapon = 2005,
  taskBefore = 2007,
  taskEventAction = 2100,
  taskNpcAction = 2101,
  shopEvent = 7001,
  addNpc = 2704
}
L_Const.taskNodeType = {
  startNode = 10,
  actionNode = 20,
  remainActionNode = 21,
  conditionNode = 30,
  startConditionNode = 31,
  failConditionNode = 32,
  forceConditionNode = 33,
  branchConditionNode = 34,
  endNode = 50,
  jumpNode = 60
}
L_Const.taskNodeStatus = {
  none = -1,
  notExcute = 1,
  inExcute = 2,
  done = 3
}
L_Const.buffStateType = {
  none = 0,
  addBuff = 1,
  removeBuff = 2,
  updateBuff = 3
}
L_Const.weaponRarity = {
  n = 1,
  r = 1,
  sr = 3,
  ssr = 4
}
L_Const.EAssetType = {
  Scene = 1,
  Actor = 2,
  Timeline = 3,
  All = 4
}
L_Const.resType = {
  hero = 1,
  commonItem = 3,
  pet = 5,
  soulEssence = 9,
  currency = 10,
  mount = 12,
  homeBuilding = 13,
  petEgg = 14,
  accessory = 15,
  playerTitle = 17,
  stargift = 18,
  taskItem = 20,
  chatEmoji = 22,
  collectionTool = 24,
  mountSaddle = 25,
  playerDress = 26,
  warehouse = 27,
  book = 28,
  reputation = 29,
  petCustomized = 30,
  customAccessory = 33,
  cloth = 34,
  chatBg = 35,
  chatBubble = 36,
  petSkin = 37,
  heroCloth = 39,
  homeDormItem = 40,
  goods = "goods",
  enemy = "enemy",
  heroEncyclopedia = "heroEncyclopedia"
}
L_Const.dropItemType = {
  Normal = 0,
  Crystal = 1,
  HomeExp = 2,
  Custom = 3
}
L_Const.currencyType = {
  diamond = 1,
  gold = 2,
  stamina = 3,
  favorabilityDailyByFight = 4,
  accountExp = 10,
  heroExp = 11,
  weaponExp = 13,
  petExp = 14,
  homeExp = 15,
  freeExpBook = 21,
  catchForce = 22,
  weeklyDungeonCount = 104,
  natural = 101,
  tiedDiamond = 901,
  tiedDiamondExtend = 902,
  homeLevelExp = 1003,
  crystalKeyStone = 411,
  specialCrystalKeyStone = 412,
  staminaBuyTimeStamp = 200029,
  staminaRecover = 200030,
  staminaBuyTimes = 200031,
  trueCash = 99001
}
L_Const.shopGoodsType = {cashGoods = 1}
L_Const.newsTypeLibraryBookReadingId = 20015
L_Const.commonTag = {
  ACC_Weapon = 101,
  ACC_Coat = 102,
  ACC_Pants = 103,
  ACC_Earring = 104,
  ACC_Ring = 105,
  FOOD_All = 201,
  FOOD_Recover = 202,
  FOOD_Attack = 203,
  FOOD_Defend = 204,
  FOOD_Resurge = 205,
  BUILDING_PRODUCT = 301,
  BUILDING_MINZHAI = 302,
  BUILDING_DECORATION = 303,
  BUILDING_HECHENG = 401,
  BUILDING_YAOSHUI = 402,
  HOME_BUILDING = 501,
  HOME_SEED = 502,
  PLAYERCARD_Player = 3001,
  PLAYERCARD_Pet = 3002,
  INFO_DAMAGE = 6001,
  INFO_TAKEN = 6002,
  INFO_HEAL = 6003
}
L_Const.foodType = {
  heal = 1,
  reborn = 2,
  defence = 3,
  attack = 4
}
L_Const.quality = {
  n_ = 0,
  n = 1,
  r = 2,
  sr = 3,
  ssr = 4
}
L_Const.qualityList = {
  L_Const.quality.n_,
  L_Const.quality.n,
  L_Const.quality.r,
  L_Const.quality.sr,
  L_Const.quality.ssr
}
L_Const.qualityColor = {
  n = "#ffffff",
  r = "#488ff0 ",
  sr = "#cd9dff",
  ssr = "#ffbe67"
}
L_Const.accessoryQualityColor = {
  [L_Const.quality.n_] = "#A0AEB7",
  [L_Const.quality.n] = "#27AE89",
  [L_Const.quality.r] = "#3AB3FF",
  [L_Const.quality.sr] = "#A264FF",
  [L_Const.quality.ssr] = "#FFBF35"
}
L_Const.qualityToKey = {
  [L_Const.quality.n] = "n",
  [L_Const.quality.r] = "r",
  [L_Const.quality.sr] = "sr",
  [L_Const.quality.ssr] = "ssr"
}
L_Const.qualityPathType = {
  tipTitle = 1,
  cell = 2,
  dropReward = 3,
  cell1_frame = 4,
  cell1_bg = 5,
  cell2_frame = 6,
  cell2_bg = 7
}
L_Const.lvBgColor = {
  [L_Const.quality.n] = CS.UnityEngine.Color(1.0, 1.0, 1.0),
  [L_Const.quality.r] = CS.UnityEngine.Color(0.2823529411764706, 0.5607843137254902, 0.9411764705882353),
  [L_Const.quality.sr] = CS.UnityEngine.Color(0.803921568627451, 0.615686274509804, 1.0),
  [L_Const.quality.ssr] = CS.UnityEngine.Color(1.0, 0.7450980392156863, 0.403921568627451)
}
L_Const.rarityColor = {
  [L_Const.quality.n] = CS.UnityEngine.Color(1.0, 1.0, 1.0),
  [L_Const.quality.r] = CS.UnityEngine.Color(0.2823529411764706, 0.5607843137254902, 0.9411764705882353),
  [L_Const.quality.sr] = CS.UnityEngine.Color(0.803921568627451, 0.615686274509804, 1.0),
  [L_Const.quality.ssr] = CS.UnityEngine.Color(1.0, 0.7450980392156863, 0.403921568627451)
}
L_Const.qualityToWord = {
  [L_Const.quality.n] = "ui_rarityMessage_01",
  [L_Const.quality.r] = "ui_rarityMessage_02",
  [L_Const.quality.sr] = "ui_rarityMessage_03",
  [L_Const.quality.ssr] = "ui_rarityMessage_04"
}
L_Const.professionColorType = {circle = 1, square = 2}
L_Const.elementIconType = {
  main = 1,
  sub = 2,
  single = 3
}
L_Const.elementColor = {
  [1] = "#c2c2c2",
  [2] = "#e94f4e",
  [3] = "#ff8921",
  [4] = "#ffbf35",
  [5] = "#73c74a",
  [6] = "#1ab7fc",
  [7] = "#4d83ff",
  [8] = "#8761f4",
  [9] = "#fff3d7",
  [10] = "#9690a2"
}
L_Const.petElementColor = {
  [1] = "#e33435",
  [2] = "#1582b4",
  [3] = "#259492",
  [4] = "#5058ca",
  [5] = "#2a9c2c",
  [6] = "#c66313",
  [7] = "#9f832f",
  [8] = "#d77f0d",
  [9] = "#6b4aa9"
}
L_Const.petPuzzleType = {
  huo = 1,
  shui = 2,
  bing = 3,
  lei = 4,
  mu = 5,
  feng = 6,
  di = 7,
  guang = 8,
  an = 9
}
L_Const.petPuzzleState = {
  None = "None",
  WaitPuzzle = "WaitPuzzle",
  Puzzling = "Puzzling"
}
L_Const.petPuzzleAction = {
  EnterPuzzle = "EnterPuzzle",
  ExitPuzzle = "ExitPuzzle",
  UpdatePuzzle = "UpdatePuzzle",
  StartPuzzle = "StartPuzzle",
  EndPuzzle = "EndPuzzle"
}
L_Const.sortType = {
  default = "default",
  lv = "lv",
  quality = "quality",
  itemId = "itemId",
  count = "count",
  star = "star",
  stamina = "stamina",
  guid = "guid",
  geneValue = "geneValue"
}
L_Const.sortOrder = {ASC = "ASC", DESC = "DESC"}
L_Const.sortWayTxt = {
  [L_Const.sortType.default] = "ui_rarityMessage_05",
  [L_Const.sortType.lv] = "ui_pageHomeCenterPetStationedManage_01",
  [L_Const.sortType.quality] = "ui_rarityMessage_06",
  [L_Const.sortType.itemId] = "ui_rarityMessage_05",
  [L_Const.sortType.count] = "ui_rarityMessage_07",
  [L_Const.sortType.star] = "ui_rarityMessage_08",
  [L_Const.sortType.stamina] = "ui_systemMessage_29",
  [L_Const.sortType.guid] = "ui_systemMessage_30",
  [L_Const.sortType.geneValue] = "ui_systemMessage_31"
}
L_Const.miniMapSeeRadius = 50
L_Const.soldieEquipPosType = {
  weapon = 1,
  defend = 2,
  decoration = 3
}
L_Const.productType = {
  process = 1,
  cast = 2,
  cook = 3,
  handicraft = 4,
  carve = 5,
  alchemy = 6
}
L_Const.collectionDropType = {
  always = 1,
  possible = 2,
  rare = 3,
  hardly = 4
}
L_Const.screenShotType = {
  hearHeadImg = "head1",
  halfBodyImg = "head2",
  battleHeadImg = "head3",
  halfsHeadImg = "head4",
  circleHeadImg = "head5",
  paintImg = "head6",
  bodyImg = "head7"
}
L_Const.avatarTextureIndex2screenShotType = {
  [L_Const.avatarTextureIndex.painting] = L_Const.screenShotType.paintImg,
  [L_Const.avatarTextureIndex.half_raffle] = L_Const.screenShotType.halfBodyImg,
  [L_Const.avatarTextureIndex.half_formation] = L_Const.screenShotType.halfsHeadImg,
  [L_Const.avatarTextureIndex.head] = L_Const.screenShotType.hearHeadImg,
  [L_Const.avatarTextureIndex.head_circle] = L_Const.screenShotType.circleHeadImg,
  [L_Const.avatarTextureIndex.head_talk] = L_Const.screenShotType.battleHeadImg,
  [L_Const.avatarTextureIndex.body] = L_Const.screenShotType.bodyImg
}
L_Const.photoTakeMode = {normal = 1, street = 2}
L_Const.photoBevMode = {capture = 1, recording = 2}
L_Const.photoGroup = {
  weather = 1,
  time = 2,
  wind = 3,
  filter = 4,
  action = 5,
  face = 6,
  color = 7,
  param = 8,
  scene = 9,
  setting = 10,
  pet = 11,
  petAction = 12,
  petFace = 13,
  template = 14,
  lightArrange = 15,
  hero = 16,
  lightSetting = 17,
  lightParam = 18,
  situation = 19
}
L_Const.photoParam = {
  windDirection = 301,
  windForce = 302,
  filter0 = 401,
  filter1 = 402,
  filter2 = 403,
  filter3 = 404,
  filter4 = 405,
  filter5 = 406,
  filter6 = 407,
  idle = 501,
  personalAction = 502,
  defaultFace = 601,
  postExposure = 701,
  brightness = 702,
  hightlights = 703,
  shadows = 704,
  contrast = 705,
  saturation = 706,
  temperature = 707,
  whitebalancetint = 708,
  wideIntensity = 801,
  dof = 802,
  softlightIntensity = 803,
  vignetteIntensity = 804,
  grainIntensity = 805,
  rotation = 806,
  rate = 807,
  player = 1001,
  teamPlayer = 1002,
  otherPlayer = 1003,
  npc = 1004,
  pet = 1005,
  weapon = 1006,
  alpha = 1007,
  enemy = 1008,
  petHud = 1009,
  npcHud = 1010,
  highResolution = 1011,
  petDefAction = 1101,
  petDefFace = 1201,
  lightLimit = 1300,
  globalLightIntensity = 1701,
  charLightIntensity = 1801,
  charSkinSpecular = 1802
}
L_Const.photoParamType = {
  str = 1,
  int = 2,
  range = 3,
  boolean = 4,
  other = 5
}
L_Const.photoTemplateDataType = {
  none = 0,
  runtime = 1,
  config = 2,
  custom = 3
}
L_Const.photoTabType = {
  SIMPLE = 1,
  PROFESSIONAL = 2,
  ACTION = 3,
  FACE = 4
}
L_Const._photoLightOffset = C_Vector3(0, 0.2, 0)
L_Const.photoTemplateSettingParam = {
  player = "player",
  camera = "camera",
  weather = "weather",
  time = "time",
  wind = "wind",
  filter = "filter",
  action = "action",
  color = "color",
  parm = "parm",
  setting = "setting",
  face = "face",
  lightSetting = "lightSetting",
  lightParam = "lightParam"
}
L_Const.photoSwitchSceneSettingParam = {player = "player"}
L_Const.MOUNT_CD_TIME = 1.5
L_Const.MountRideCmd = {}
L_Const.playMountStatus = {
  none = 0,
  preMount = 1,
  startMount = 2,
  inMount = 3,
  preOutMount = 4,
  outMount = 5
}
L_Const.inMountStatus = {
  L_Const.playMountStatus.inMount,
  L_Const.playMountStatus.preOutMount
}
L_Const.behaviorRoleType = {
  control = 1,
  player = 2,
  npc = 3
}
L_Const.blendStyle = {
  cut = 0,
  easeInOut = 1,
  easeIn = 2,
  easeOut = 3,
  hardIn = 4,
  hardOut = 5,
  linear = 6,
  custom = 7
}
L_Const.blendStyleMode = {
  cut = "cut",
  easeInOut = "easeInOut",
  easeIn = "easeIn",
  easeOut = "easeOut",
  hardIn = "hardIn",
  hardOut = "hardOut",
  linear = "linear",
  custom = "custom"
}
L_Const.petPageType = {
  pagePetBreed = 1,
  pagePetFree = 2,
  moduleLease = 3,
  pageRentPet = 4
}
L_Const.shopType = {
  cityShop = 1000,
  npcShop = 2000,
  greenTicketShop = 3000,
  yellowTicketShop = 3010,
  petShop = 4000,
  chargeShop = 9000,
  giftShop = 9100
}
L_Const.heroTimelineState = {
  None = "None",
  Detail = "Detail",
  Equip = "Equip",
  Skill = "Skill",
  Select = "Select",
  Present = "Equip"
}
L_Const.heroDataModuleType = {
  Info = 1,
  Story = 2,
  Voice = 3,
  Drama = 4,
  Pet = 5
}
L_Const.topChangeHideLv = {lowMemory = 1, highMemory = 2}
L_Const.heroModuleType = {
  Property = "Property",
  Gift = "Gift",
  Skill = "Skill",
  Star = "Star",
  SoulEssence = "SoulEssence",
  Accessory = "Accessory",
  Data = "Data",
  FormationPet = "FormationPet",
  Talent = "Talent",
  Present = "Present",
  Grade = "Grade"
}
L_Const.heroPageType = {
  ListMode = 0,
  DetailMode = 1,
  PreviewMode = 2,
  HandBookMode = 3,
  SpritronPreviewMode = 4
}
L_Const.physicsVolumeType = {
  None = 0,
  MountArea = 1,
  SwimArea = 2
}
L_Const.worldShapeType = {
  None = 0,
  Cube = 1,
  Sphere = 2,
  Capsule = 3
}
L_Const.worldMountMove = {
  Fly = 1,
  Floor = 2,
  Water = 3
}
L_Const.worldMountAction = {Call = 1, Action = 2}
L_Const.worldMountAction = {Call = 1, Action = 2}
L_Const.worldMountActionType = {
  FlyCall = (L_Const.worldMountMove.Fly << 4) + L_Const.worldMountAction.Call,
  FlyAction = (L_Const.worldMountMove.Fly << 4) + L_Const.worldMountAction.Action,
  FloorCall = (L_Const.worldMountMove.Floor << 4) + L_Const.worldMountAction.Call,
  FloorAction = (L_Const.worldMountMove.Floor << 4) + L_Const.worldMountAction.Action,
  WaterCall = (L_Const.worldMountMove.Water << 4) + L_Const.worldMountAction.Call,
  WaterAction = (L_Const.worldMountMove.Water << 4) + L_Const.worldMountAction.Action
}
L_Const.friendOpType = {
  friend = 1,
  application = 2,
  blackList = 3
}
L_Const.friendOp = {
  add = 1,
  delete = 2,
  allAdd = 3,
  allDelete = 4
}
L_Const.chatType = {
  personal = 0,
  team = 1,
  world = 2,
  map = 3,
  city = 999,
  meeting = 99
}
L_Const.wwiseSoundGroup = {
  bgm = "RTPC_System_Volume_Music",
  worldSe = "RTPC_System_Volume_SFX",
  uiSe = "RTPC_System_Volume_SFX_System",
  cv = "RTPC_System_Volume_VO",
  all = "RTPC_System_Volume_ALL",
  time = "RTPC_System_Time"
}
L_Const.playerPath = {
  avatarPrefabFemalePath = "AVATAR_PREFAB_PATH_FEMALE",
  avatarPlayableFemalePath = "AVATAR_PLAYABLE_PATH_FEMALE",
  avatarAnimTemplateFemalePath = "AVATAR_ANIM_TEMPLATE_PATH_FEMALE",
  avatarPrefabMalePath = "AVATAR_PREFAB_PATH_MALE",
  avatarPlayableMalePath = "AVATAR_PLAYABLE_PATH_MALE",
  avatarAnimTemplateMalePath = "AVATAR_ANIM_TEMPLATE_PATH_MALE"
}
L_Const.createBattleType = {
  single = 1,
  team = 2,
  tower = 3
}
L_Const.itemResetTimeType = {
  selfReset = 1,
  standTimeReset = 2,
  standPeriod = 3
}
L_Const.commonTipsShowType = {
  OkCancel = 1,
  OnlyOk = 2,
  OnlyCancel = 3,
  OnlyClose = 4
}
L_Const.cvType = {
  Obtain = "obtain",
  Introduce = "introduce",
  AboutPlayer = "about_player",
  AboutHero = "about_self",
  AboutPet = "about_pet",
  AboutWorld = "about_world",
  Idle = "idle",
  IdleWeather = "idle_weather",
  JoinFormation = "forming",
  Detail = "information",
  LevelBreak = "level_break",
  StarUp = "same_unit_break",
  FoundRes = "resource_found",
  NearbyStrong = "strong_enemy",
  InteractNonProp = "item_required",
  FoundByEnemy = "found_by_enemy",
  EscapeFromEnemy = "escape_from_enemy",
  VictoryHighHP = "back_hp_high",
  VictoryMidHP = "back_hp_med",
  VictoryLowHP = "back_hp_low",
  HPWarning = "heal_warning",
  Dash = "dash",
  Jump = "jump",
  AcceptTask = "quest_take",
  CompleteTask = "quest_complete",
  Ride = "ride",
  AtkLight = "atk_light",
  AtkMedium = "atk_medium",
  AtkHeavy = "attack_heavy",
  LowHP = "hp_low",
  BeHit = "be_hit",
  BeHitStrong = "be_hit_strong",
  Dead = "down",
  BattleStart = "battle_start",
  BattleFailed = "battle_failed"
}
L_Const.cvPriority = {
  [L_Const.cvType.VictoryHighHP] = 2,
  [L_Const.cvType.VictoryMidHP] = 2,
  [L_Const.cvType.VictoryLowHP] = 2,
  [L_Const.cvType.FoundRes] = 3,
  [L_Const.cvType.FoundByEnemy] = 3,
  [L_Const.cvType.EscapeFromEnemy] = 3,
  [L_Const.cvType.AcceptTask] = 3,
  [L_Const.cvType.CompleteTask] = 4
}
L_Const.cvCD = {
  [L_Const.cvType.FoundRes] = {10, 15}
}
L_Const.C_ESkillSlotType = {
  None = 0,
  Attack = 1,
  Skill1 = 2,
  Skill2 = 3,
  UltraSkill = 4,
  CommandPetUltra = 5,
  CoopSkill = 11,
  AI_LEGAL_SLOT_RANGE = 100,
  Evade = 101,
  Jump = 102,
  ExitSkill = 201,
  EnterDash = 202,
  EnterSkill = 203,
  EvadeAttack = 204,
  PetUltraBlink = 205,
  PetUltra = 206,
  EvadeBoostAttack = 207,
  PlayerJointStrikeSkill = 208,
  Countermeasures = 209,
  AerialAttack = 301,
  JointStrikeSkill = 601
}
L_Const.EntityCustomEventId = {
  GraphInteractEvent = 100,
  UIOpenEvent = 105,
  UICloseEvent = 106,
  SuccessResultEvent = 107,
  FailedResultEvent = 108
}
L_Const.TriggerType = {Interact = 4}
L_Const.homeScienceNodeState = {
  lock = 1,
  unlock = 2,
  complete = 3
}
L_Const.commonRewardStatus = {
  complete = 1,
  notComp = 2,
  got = 3
}
L_Const.OneKeyBattleChangeType = {loop = 1, order = 2}
L_Const.mapNavPointIcon = "UI/Atlas/BSWorldMap/tex_bigmap_icon_kejinxing"
L_Const.mapNavPointId = 99999
L_Const.guidePointType = {task = 1, mapMark = 2}
L_Const.SaveKey_OneKeyBattleChangeType = "SaveKey_OneKeyBattleChangeType"
L_Const.gameActType = {
  [1] = "moduleImportantAct",
  [99] = "moduleAttendance"
}
L_Const.gameActEndType = {
  specifyTime = 1,
  permanent = 2,
  special = 3
}
L_Const.skillFuncType = {effect = 1, number = 2}
L_Const.cropAction = {
  Open = 1,
  Close = 2,
  Plant = 3,
  UnPlant = 4,
  Water = 5,
  Harvest = 6
}
L_Const.cropTargetType = {
  NONE = 0,
  EMPTY = 1,
  FIELD = 2,
  PLANT = 3,
  PLANT_HARVEST = 4
}
L_Const.cropUIButtonType = {
  FIELD = 1,
  CROP = 2,
  SUB = 3
}
L_Const.cropActionByType = {
  [L_Const.cropTargetType.NONE] = {},
  [L_Const.cropTargetType.EMPTY] = {
    L_Const.cropAction.Open,
    nil,
    nil
  },
  [L_Const.cropTargetType.FIELD] = {
    L_Const.cropAction.Water,
    L_Const.cropAction.Plant,
    L_Const.cropAction.Close
  },
  [L_Const.cropTargetType.PLANT] = {
    L_Const.cropAction.Water,
    nil,
    L_Const.cropAction.UnPlant
  },
  [L_Const.cropTargetType.PLANT_HARVEST] = {
    L_Const.cropAction.Water,
    L_Const.cropAction.Harvest,
    L_Const.cropAction.UnPlant
  }
}
L_Const.teleportBattleType = {standardBattle = 1, nowTeleportBattle = 2}
L_Const.BattleElementType = {buffElement = 8, stackElement = 15}
L_Const.starManualType = {
  material = 1,
  skill = 2,
  soulEssence = 3,
  equipment = 4,
  boss = 5
}
L_Const.SoulEssenceFullStar = 4
L_Const.SoulEssenceExpItemIds = {
  403000,
  403001,
  403002
}
L_Const.starManualModuleType = {
  [1] = "moduleDungeonList",
  [2] = "moduleDungeonList",
  [3] = "moduleDungeonList",
  [4] = "moduleDungeonList",
  [5] = "moduleDungeonList",
  [6] = "moduleStarManualBoss"
}
L_Const.ModuleInfo = {
  Empty = {
    moduleName = "core/ui/base/emptyModule"
  },
  CellIcon = {
    moduleName = "modulePages/cellIcon"
  },
  CellIconCircle = {
    moduleName = "modulePages/cellIconCircle"
  },
  CellIconBag = {
    moduleName = "modulePages/cellIconBag"
  },
  CellIconUnit = {
    moduleName = "modulePages/cellIconUnit"
  },
  CellBasicItem = {
    moduleName = "modulePages/CommonItem/cellBasicItem"
  },
  CellAddItem = {
    moduleName = "modulePages/CommonItem/cellAddItem"
  },
  CellIconRole = {
    moduleName = "modulePages/CellIconRole"
  },
  Button = {
    moduleName = "modulePages/moduleButton"
  },
  ButtonSingle = {
    moduleName = "modulePages/moduleButtonSingle"
  },
  CellText = {
    moduleName = "modulePages/cellText"
  },
  CellImageText = {
    moduleName = "modulePages/cellImageText"
  },
  SortFilterModule = {
    moduleName = "modulePages/sortFilter/moduleSortFilter"
  },
  FoYeFilterModule = {
    moduleName = "modulePages/filtrate/moduleFiltrate"
  },
  Currency = {
    moduleName = "modulePages/moduleCurrency"
  },
  CommonTop = {
    moduleName = "modulePages/moduleCommonTop"
  },
  SelectNum = {
    moduleName = "modulePages/moduleSelectNum"
  },
  CommonTipBoard = {
    moduleName = "modulePages/commonTip/moduleCommonTipBoard"
  },
  ModuleCommonTip = {
    moduleName = "modulePages/commonTip/moduleCommonTipBase"
  },
  CommonTabList = {
    moduleName = "modulePages/tabList/moduleCommonTabList"
  },
  FrameTexture = {
    moduleName = "modulePages/moduleFrameTexture"
  },
  ModuleBtn = {
    moduleName = "modulePages/btn/moduleBtn"
  }
}
local CONST_ModuleInfo = L_Const.ModuleInfo
L_Const.ModuleInfo = {}
setmetatable(L_Const.ModuleInfo, {
  __index = function(t, k)
    return table.clone(CONST_ModuleInfo[k])
  end
})
L_Const.ButtonType = {
  NONE = -1,
  BLUE = 1,
  BLACK = 2,
  GREY = 3,
  EMPTY = 4
}
L_Const.StandardButtonSize = C_Vector2(362, 78)
L_Const.homeDormManageSortType = {Time = 1, Like = 2}
L_Const.movementBtnType = {
  Jump = 1,
  Dodge = 2,
  Atk = 3,
  Fall = 5,
  MountFlyUp = 6,
  MountFlyDown = 7,
  MountDodge = 8,
  MountAtk = 9,
  MountJump = 10,
  MountSkill = 11
}
L_Const.movementBlockType = {
  default = 1,
  crop = 2,
  fly = 3,
  mount = 4
}
L_Const.homeCropEdgeType = {
  C = 1,
  I = 2,
  L = 3,
  U = 4,
  O = 5
}
L_Const.homeCropHudType = {
  None = 0,
  Grow = 1,
  Water = 2,
  Harvest = 3
}
L_Const.EntityPropertiesKey = {
  WalkAnim = "walkAnim",
  RunAnim = "runAnim",
  WalkSpeed = "walkSpeed",
  RunSpeed = "runSpeed",
  AlertHeavy = "alertHeavy",
  AlertWeak = "alertWeak",
  PerceiveTime = "perceiveTime",
  Dov = "dov",
  Fov = "fov",
  Exposed = "exposed",
  Aggressive = "aggressive",
  ChaseRadius = "chaseRadius",
  ChaseSpeed = "chaseSpeed",
  ChaseSpeedRatio = "chaseSpeedRatio",
  ChaseMotion = "chaseMotion",
  PatrolRadius = "patrolRadius",
  PatrolSpeed = "patrolSpeed",
  PatrolSpeedRatio = "patrolSpeedRatio",
  PatrolMotion = "patrolMotion",
  PatrolInterval = "patrolInterval",
  HatredRadius = "hatredRadius",
  BattleRadius = "battleRadius",
  HatredRadius = "hatredRadius",
  GoBackSpeed = "goBackSpeed",
  GoBackSpeedRatio = "goBackSpeedRatio",
  GoBackMotion = "goBackMotion",
  IsBeAttacked = "isBeAttacked"
}
L_Const.timelineDynamicBindType = {
  None = 0,
  EffectMaterialHelper = 1,
  EffectCommonHelper = 2,
  FollowTarget = 3,
  FollowTargetList = 4,
  EffectCommonHelper2 = 5
}
L_Const.timelineEventType = {
  None = 0,
  UI = 1,
  CustomEvent = 2
}
L_Const.scienceResearchErrorType = {
  None = 1,
  ResourceNotEnough = 2,
  PeopleNotEnough = 3
}
L_Const.homeAutoWaterEffects = {
  Water = "Water",
  Summon1 = "Summon1",
  Summon2 = "Summon2",
  Leave = "Leave"
}
L_Const.newPlayerStartSceneId = {newSceneId = 2001}
L_Const.Number2Roma = {
  [0] = "0",
  [1] = "Ⅰ",
  [2] = "Ⅱ",
  [3] = "Ⅲ",
  [4] = "Ⅳ",
  [5] = "Ⅴ",
  [6] = "Ⅵ",
  [7] = "Ⅶ",
  [8] = "Ⅷ",
  [9] = "Ⅸ",
  [10] = "Ⅹ",
  [11] = "Ⅺ",
  [12] = "Ⅻ"
}
L_Const.ShowNoMoreType = {curLogin = 1, today = 2}
L_Const.GuideSerializeId = {
  TestId = 0,
  PetCatalogGuide = 1,
  TransactionCenterGuide = 2,
  PetCatalogGuideChangePage = 3,
  productQuickPage = 4,
  JourneyType = 5,
  JourneyTaskScroll = 6,
  JourneyTaskPin = 7,
  MainMenu = 8,
  ProductCooking = 9,
  PetBoxFindCanMutationPet = 11
}
L_Const.mainMenuBgTabType = {
  Default = 0,
  CharacterSpirit = 1,
  StoryCg = 2,
  Dormitory = 3
}
L_Const.ShowNoMoreKey = {
  pageDungeonEntry_start = "pageDungeonEntry_start",
  technologyExp = "technologyExp_%d_%d"
}
L_Const.CommonTextBoxType = {
  Rename = 1,
  Signature = 2,
  PureNumber = 3,
  MultiPlayerCityLine = 4
}
L_Const.skillElementType = {none = 10}
L_Const.AnchorType = {
  TopLeft = 1,
  Top = 2,
  TopRight = 3,
  Left = 4,
  Middle = 5,
  Right = 6,
  BottomLeft = 7,
  Bottom = 8,
  BottomRight = 9
}
L_Const.AnnouncementShowType = {Normal = 0, OnlySystem = 1}
L_Const.AnnouncementType = {
  Active = 0,
  System = 1,
  Info = 2
}
L_Const.AnnouncementModuleType = {
  Empty = -1,
  Poster = 0,
  RichText = 1,
  Webview = 2
}
L_Const.AnchorCfg = {
  [L_Const.AnchorType.TopLeft] = {
    anchorMin = C_Vector2(0, 1),
    anchorMax = C_Vector2(0, 1),
    pivot = C_Vector2(1, 0)
  },
  [L_Const.AnchorType.Top] = {
    anchorMin = C_Vector2(0.5, 1),
    anchorMax = C_Vector2(0.5, 1),
    pivot = C_Vector2(0.5, 0)
  },
  [L_Const.AnchorType.TopRight] = {
    anchorMin = C_Vector2(1, 1),
    anchorMax = C_Vector2(1, 1),
    pivot = C_Vector2(0, 0)
  },
  [L_Const.AnchorType.Left] = {
    anchorMin = C_Vector2(0, 0.5),
    anchorMax = C_Vector2(0, 0.5),
    pivot = C_Vector2(1, 0.5)
  },
  [L_Const.AnchorType.Middle] = {
    anchorMin = C_Vector2(0.5, 0.5),
    anchorMax = C_Vector2(0.5, 0.5),
    pivot = C_Vector2(0.5, 0.5)
  },
  [L_Const.AnchorType.Right] = {
    anchorMin = C_Vector2(1, 0.5),
    anchorMax = C_Vector2(1, 0.5),
    pivot = C_Vector2(0, 0.5)
  },
  [L_Const.AnchorType.BottomLeft] = {
    anchorMin = C_Vector2(0, 0),
    anchorMax = C_Vector2(0, 0),
    pivot = C_Vector2(1, 1)
  },
  [L_Const.AnchorType.Bottom] = {
    anchorMin = C_Vector2(0.5, 0),
    anchorMax = C_Vector2(0.5, 0),
    pivot = C_Vector2(0.5, 1)
  },
  [L_Const.AnchorType.BottomRight] = {
    anchorMin = C_Vector2(1, 0),
    anchorMax = C_Vector2(1, 0),
    pivot = C_Vector2(0, 1)
  }
}
L_Const.worldBuffDurationType = {
  Permanent = 0,
  Time = 1,
  Count = 2
}
L_Const.mailCategory = {
  all = 1,
  unread = 2,
  collect = 3
}
L_Const.mailType = {type1 = 1, type2 = 2}
L_Const.mailJumpType = {commonJump = 1, questionLink = 3}
L_Const.commonJumpType = {
  Page = 1,
  HomeJump = 2,
  SuperLink = 3,
  MapCollectionTrace = 4,
  HomeHub = 5,
  DungeonEntrust = 6,
  FavorabilityHero = 7,
  FavorabilityGift = 8,
  BigMapCollection = 9,
  MallJump = 10,
  UseGift = 11,
  PageBigMap_SpecialPet = 99,
  PageBigMap_HomeTrace = 98
}
L_Const.mallJumpType = {
  goods2Mall = 1,
  goods2Buy = 2,
  shop2Mall = 3
}
L_Const.mailExtType = {url = "url"}
L_Const.buildInterType = {harvest = 1, product = 2}
L_Const.spritModules = {
  modulePreview = "modulePreview",
  moduleUpgrade = "moduleUpgrade",
  moduleSwitch = "moduleSwitch",
  moduleMaterialBag = "moduleMaterialBag"
}
L_Const.spiritMaterialBagType = {level = "level", star = "star"}
L_Const.soulEssenceUpgradeModules = {
  moduleSoulEssenceBasicInfo = "moduleSoulEssenceBasicInfo",
  moduleSoulEssenceBreak = "moduleSoulEssenceBreak",
  moduleSoulEssenceLevelUp = "moduleSoulEssenceLevelUp",
  moduleSoulEssenceStarUp = "moduleSoulEssenceStarUp"
}
L_Const.triggerGuideType = {
  rangeChecker = 1003,
  collection = 1008,
  funcUnlock = 3001,
  uiOpen = 3002,
  buildType = 3003,
  palyerLevel = 3004,
  switchScene = 3005,
  inHome = 3006,
  homeBuildingSet = 3011,
  journeyTaskRewarding = 3025,
  journeyTaskComplete = 3026,
  heroPageCurModuleChanged = 3016,
  satietyValueChanged = 3018,
  openShopPage = 3019,
  switchPetPage = 3020,
  onQuickItemBarShow = 3021,
  homeLvUpgrade = 3023,
  homeBuildProduct = 3024,
  petBoxHaveCanMutationPet = 3022,
  firstOpenPage = 3026,
  dungeonFirstWin = 3027,
  cvStateChanged = 3029,
  cvStaminaChanged = 3030,
  scenarioEndBookEnabled = 3031,
  scenarioEndlessOpen = 3032,
  cvTrainReadyBondTrain = 3033
}
L_Const.satietyOperationType = {minus = 0, add = 1}
L_Const.kiBoDuelEnum = {
  petCost = 304,
  costLimit = 305,
  costRecoverSpeed = 306,
  originalCost = 307
}
L_Const.quickRouletteType = {petPuzzle = 1, normal = 3}
L_Const.keyPressType = {
  none = 0,
  down = 1,
  press = 2,
  up = 3
}
L_Const.specialGuideCondition = {
  range = 1003,
  skillRelease = 2004,
  avoid = 2005,
  catchPet = 2016
}
L_Const.propetyShowType = {battlePosition = 1, attribute = 2}
L_Const.propertyDetail = {
  hero = 1001,
  equipment = 1002,
  kiBo = 1003,
  heroPreview = 1004
}
L_Const.propertyPageType = {
  hero = 1,
  equipment = 2,
  kiBo = 3,
  heroPreview = 4
}
L_Const.propertyDetailTab = {
  detail = 1,
  talent = 2,
  spirit = 3,
  equipment = 4
}
L_Const.BattleBlockType = {
  None = 0,
  FormationSetting = 1001,
  SpiritWearEntrance = 1002,
  EquipmentSwitchEntrance = 1003,
  PetEvolutionEntrance = 1004,
  PetReleaseEntrance = 1005,
  PetResetEntrance = 1006,
  SpiritResolveEntrance = 1007,
  EquipmentResolveEntrance = 1008,
  PhotographEntrance = 1009,
  HeroUpgrade = 1010,
  HeroStarUpgrade = 1011,
  HeroSkillUpgrade = 1012,
  EquipmentStrength = 1013,
  SpiritStrength = 1014,
  PetUpgrade = 1015,
  PlayerModChange = 1016,
  ChangeWorldLevel = 1017,
  EditMountRoulette = 1018,
  HeroRuneEquip = 1019,
  HeroRuneUpgrade = 1020,
  HeroFAVORExpAdd = 1021,
  OpenTaskView = 1022,
  SetTaskTrace = 1023,
  MapWorldLv = 1024,
  EquipmentChangeEntrance = 1025,
  EquipmentHomology = 1027
}
L_Const.logEventName = {
  guide = "guide",
  pet_carry = "pet_carry",
  guide_book = "guide_book",
  banner_click = "banner_click",
  camera_setup = "camera_setup",
  image_setup = "image_setup",
  resource_loading = "resource_loading",
  mail_click = "mail_click",
  client_performance = "client_performance",
  client_home_center = "client_home_center",
  setup_cs = "setup_cs",
  pet_formation_rec = "pet_formation_rec",
  client_verify_resource = "client_verify_resource",
  activity_page_center_click = "activity_page_center",
  camera = "camera"
}
L_Const.kiBoDuelLevelType = {
  player = 0,
  mix = 1,
  system = 2
}
L_Const.kiBoDuelCostStatus = {
  None = 0,
  Init = 1,
  RecoverCost = 2,
  MaxCost = 3
}
L_Const.submitItemShowType = {
  empty = 1,
  select = 2,
  submitTarget = 3,
  submitSubType = 4,
  waitAdd = 5,
  blackEmpty = 6
}
L_Const.showInfoTipsEntranceType = {
  none = -1,
  longClick = 0,
  click = 1
}
L_Const.kiBoDuelInfoType = {
  talentPrevious = "Q",
  talentNext = "E",
  skillPrevious = "Z",
  skillNext = "C"
}
L_Const.satietyColor = {
  [1] = "#c63e39",
  [2] = "#e29500",
  [3] = "#2ea29b"
}
L_Const.guideTriggerScene = {
  any = 0,
  world = 1,
  home = 2,
  dungeon = 3,
  metting = 5,
  kiBoDuel = 4,
  prologue = 6,
  homeDorm = 21,
  culMain = 29
}
L_Const.attrBaseName = {
  [L_Const.battleAtt.MAXHP] = "info_attr_basic_hp",
  [L_Const.battleAtt.ATK] = "info_attr_basic_atk",
  [L_Const.battleAtt.DEF] = "info_attr_basic_def",
  [L_Const.battleAtt.MDEF] = "info_attr_basic_mdef"
}
L_Const.snackBagType = {mount = 1, hero = 2}
L_Const.playerDressType = {
  head = 101,
  headFrame = 102,
  baseboard = 201,
  backboard = 202,
  hero = 203,
  pet = 204
}
L_Const.rewardShowType = {
  none = 0,
  fly = 1,
  half = 2,
  full = 3,
  special = 4,
  leftMiddle = 5
}
L_Const.kiboDuelMultiNotifyEnum = {specialKill = 1, shutDown = 2}
L_Const.trainTaskType = {
  dungeon = 1,
  hero = 2,
  kiBoDuel = 3
}
L_Const.blackPlayerTab = {blackList = 1, blockChatList = 2}
L_Const.runeComposeType = {
  target = 1,
  compose = 2,
  targetList = 3
}
L_Const.cellIconUnitType = {
  mainFormation = 0,
  quickTeamUp = 1,
  others = 2,
  teamUp = 3,
  selectPet = 4
}
L_Const.pivotType = {
  none = 0,
  left = 1,
  top = 2,
  right = 3,
  bottom = 4,
  topLeft = 5,
  topRight = 6,
  bottomRight = 7,
  bottomLeft = 8
}
L_Const.kiBoDuelBlockSlot = 0
L_Const.NestTrailLevelId = 901
L_Const.EntrustTypeEnum = {
  None = 0,
  AreaEntrust = 1,
  SpecialEntrust = 2,
  TrainTask = 3,
  EntrustAssemble = 4,
  PetDuel = 5,
  MultiCoopEntrust = 6,
  Rogue = 7
}
L_Const.EntrustTimelineState = {
  None = "None",
  Main = "start",
  Shop = "shop",
  End = "End"
}
L_Const.RogueEntryTimelineState = {
  Start = "start",
  Action1 = "action1",
  Action2 = "action2",
  Loop = "loop"
}
L_Const.FurnitureStateEnum = {
  HasGive = 0,
  Notbuy = 1,
  InBag = 2
}
L_Const.situationDataType = {
  hero = 1,
  pet = 2,
  camera = 3,
  env = 4,
  obj = 5,
  stamp = 6
}
L_Const.situationGroup = {
  hero = 1,
  obj = 2,
  pet = 3,
  env = 4,
  stamp = 5
}
L_Const.FrameLoadPriority = {
  Low = 1,
  Medium = 2,
  High = 3
}
L_Const.FrameLoadState = {
  Clone = 1,
  FromPool = 2,
  Break = 3
}
L_Const.SpecialAttList = {
  1,
  3,
  5,
  201,
  229,
  230
}
L_Const.FoodProductConst = {
  recent = 207,
  all = 201,
  satiety = 206,
  attack = 203,
  defend = 204
}
L_Const.RuneNodeType = {
  none = -1,
  leaf = 0,
  root = 1
}
L_Const.ScanLevel = {
  FIRST_LEVEL_SCAN = 1,
  SECOND_LEVEL_SCAN = 2,
  THIRDLY_LEVEL_SCAN = 3
}
L_Const.PetCultivate = {Ability = 1, Gene = 2}
L_Const.GameTplType = {
  int = 1,
  float = 2,
  string = 3,
  list_int = 4,
  list_float = 5,
  list_string = 6,
  dict_int_int = 7,
  bool = 8,
  condition = 9,
  reward = 10,
  list_list_int = 11
}
