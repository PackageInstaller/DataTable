SKILL_OTHER_ACTION_TAG = 10020
SIDE_LEFT = 1
SIDE_RIGHT = 2
RESET_TIME = 4
BATTLE_GRID_PIXEL = 100
BATTLE_Y_POS = 240
BATTLE_HURT_OFFSET = 40
BATTLE_CENTER_OFFSET = 75
BATTLE_PHASE_LENGTH_1 = 1200
BATTLE_PHASE_LENGTH_2 = 2000
BATTLE_PHASE_LENGTH_3 = 2500
BATTLE_PHASE_LENGTH_4 = 3000
BATTLE_PHASE_LENGTH_5 = 3500
TILEMAP_CHILD_TAG = 99
FLASH_MSG_TAG = 100
BATTLE_MASK_TAG = 88
BATTLE_BEAUTY_BG_TAG = 100
BATTLE_CUTIN_BG_TAG = 110
NETWORK_TIPS_TAG = 1000
PLOT_HERO_TALK = 11
PLOT_CARD_TALK = 12
NEW_GUIDE_LAYER_TAG = 9999
NETWORK_WAITING_TAG = 10000
MRUNNING_MSG_TAG = 11000
BLUR_MASK_TAG = 1126
TOPBAR_LAYER_ORDER = 100
POPUP_LAYER_ORDER = 1000
GM_LAYER_ORDER = 2000
MSGBOX_LAYER_ORDER = 9000
NEW_GUIDE_LAYER_ORDER = 15000
NETWORK_WAITING_ORDER = 20000
TOUCH_MASK_ORDER = 100000
COLOR_BG_ORDER = -700
EFFECT_UNDER_ORDER = -600
RIGHT_PLAYER_ORDER = -500
LEFT_PLAYER_ORDER = -400
EFFECT_ABOVE_ORDER = -300
FLOOR_LAYER_ORDER = 1000
DISPLAY_ABOVE_ORDER = 10
DISPLAY_UNDER_ORDER = -10
MAP_ABOVE_ORDER = 1000
MAP_UNDER_ORDER = -1000
MAX_QUALITY_LEVEL = 5
MAX_VIP = 15
MAX_EQUIP_LEVEL = 100
MAX_EQUIP_EVOL = 16
MAX_EQUIP_STAR = 6
MAX_TOWER_FLOOR = 300
TOWER_ID_BEGIN = 30000
TRAIL_ID_BEGIN = 40000
BOSS_ID_BEGIN = 50000
YUANZHENG_ID_BEGIN = 60000
PRACTICE_ID_BEGIN = 70000
MAX_HALO_LEVEL = 100
HERO_CHANGE_STAR = 6
MonsterType = {
  Boss = 1,
  Assault = 2,
  Maker = 3,
  Dregs = 4,
  Eat = 5,
  Ghost = 6
}
StageType = {
  Common = 1,
  Arrange = 2,
  WeakArrange = 3,
  Supply = 4,
  Power = 5,
  Select = 6,
  Cross = 7,
  RandSelect = 8,
  OnceArrange = 9,
  SupplyMaterial = 10,
  SupplyStep = 11,
  Box = 12,
  Cure = 13,
  attrUp = 14,
  WeakEnemyArrange = 15
}
ExploreType = {
  Common = 1,
  Born = 2,
  Score = 3,
  Cure = 4,
  Item = 5,
  Cross = 6,
  Enemy = 7,
  Event = 8
}
ExploreItemType = {
  Bomb = 1,
  Weak = 2,
  Slow = 3,
  Invincible = 4,
  Forbiden = 5,
  Victory = 6,
  Dice1 = 7,
  Dice2 = 8,
  Dice3 = 9,
  Dice4 = 10,
  Dice5 = 11,
  Dice6 = 12,
  DiceAll = 13,
  Fight = 14
}
RoomEvent = {
  move = 1,
  useItem = 2,
  playerOnStage = 3,
  playerStart = 4,
  playerEnd = 5,
  playerExit = 6,
  playerDice = 7,
  playerFight = 8,
  eventCross = 9,
  eventFight = 10,
  eventScore = 11,
  eventItem = 12,
  eventCure = 13,
  addScore = 14,
  updateMap = 15,
  addMainList = 16,
  addWaitList = 17,
  playerRevive = 18,
  playerTalk = 19,
  addHealth = 20
}
carbonType = {
  Normal = 10000,
  Special = 20000,
  Tower = 30000,
  Trial = 40000,
  Worldboss = 50000,
  Yz = 60000
}
ROUND = {
  [7] = true
}
AttsEnum = {
  hp = 1,
  atk = 2,
  phyDef = 3,
  hit = 4,
  miss = 5,
  crit = 6,
  atkSpeed = 7,
  critHurt = 8,
  resist = 9,
  trueAtk = 10,
  atkResist = 11,
  hitResist = 12,
  critResist = 13,
  critHurtResist = 14,
  tebao = 15,
  tekang = 16
}
AttsEnumEx = {
  [1] = "hp",
  [2] = "atk",
  [3] = "phyDef",
  [4] = "hit",
  [5] = "miss",
  [6] = "crit",
  [7] = "atkSpeed",
  [8] = "critHurt",
  [9] = "resist",
  [10] = "trueAtk",
  [11] = "atkResist",
  [12] = "hitResist",
  [13] = "critResist",
  [14] = "critHurtResist",
  [15] = "tebao",
  [16] = "tekang"
}
AttrsHide = {
  [5] = true,
  [6] = true,
  [8] = true,
  [12] = true
}
AttrDesc = {
  [1] = "生命",
  [2] = "攻击",
  [3] = "防御",
  [4] = "命中",
  [5] = "闪避",
  [6] = "暴击",
  [7] = "攻速",
  [8] = "暴伤",
  [9] = "抵抗",
  [10] = "固定攻击",
  [11] = "攻击减免",
  [12] = "命中抗性",
  [13] = "坚韧",
  [14] = "暴伤抗性",
  [15] = "特暴",
  [16] = "特抗"
}
FitmentDesc = {
  [2] = "家具",
  [3] = "墙饰",
  [4] = "地毯"
}
BattleType = {
  First = 0,
  PvE = 1,
  PvP = 2,
  Tower = 3,
  Train = 4,
  ZoneBoss = 5,
  Pk_Pvp = 6,
  Expedition = 7,
  Namepad = 8,
  Practice = 9,
  Moon = 10,
  Lty = 11,
  Paradise = 12,
  MJ = 13,
  Sauce = 14,
  EJ = 15,
  Worldboss = 16,
  Union = 17,
  ShenYuan = 18,
  RouGe = 19,
  NewWorldboss = 20,
  ActCarbon = 21
}
ItemType = {
  RandGiftClose = 1,
  RandGiftOpen = 2,
  Material1 = 3,
  Material2 = 4,
  Material3 = 5,
  Material4 = 6,
  HeroSkin = 7,
  Ring = 8,
  Hero = 9,
  QuickProp = 10,
  BuildDraw = 11,
  Diamond = 12,
  Medel = 13,
  EnergyItem = 14,
  Seed = 15,
  QuickPlant = 16,
  JobPerfer = 17,
  LoveItem = 18,
  HeadFarme = 19,
  HeadIcon = 20,
  HomeSkin = 21,
  Equip = 22,
  Proof = 23,
  Dress = 24,
  Build = 25,
  HeroBag = 26,
  EquipBag = 27,
  GiftBag = 28,
  TeamBag = 29,
  HeroBuild = 30,
  EquipBuild = 31,
  PvpCoin = 32,
  ChooseBox = 33,
  DrawCoin = 34,
  ActivityCoin = 35,
  DinerBox = 36,
  Fitment = 37,
  DinerCar = 38,
  Accessory = 39,
  DinerCarNum = 40,
  DinerBoxNum = 41,
  AccMaterial = 42,
  DinerCoin = 43,
  PangCi = 44,
  Menu = 45,
  StoryKey = 46,
  TreeItem = 47,
  Sauce = 48,
  Monster = 49,
  RandSauce = 50,
  MultItem = 51,
  UnionKey = 55,
  TalkFarme = 56,
  Pendent = 57,
  LoveExp = 58,
  AwakeHero = 59,
  InnateItem = 61,
  RandHeadFrame = 62,
  NewEquip = 63,
  JobItem = 201
}
ItemStartId = {
  hero = 1000,
  equip = 2000,
  sauce = 3000,
  monster = 4000,
  awakeHero = 330000,
  newEquip = 50000
}
GlobalEffectRes = {
  "ui/battle/skill/touch.plist",
  "ui/battle/skill/dispose.plist",
  "ui/battle/skill/suan.plist",
  "ui/battle/skill/tian.plist",
  "ui/battle/skill/xian.plist",
  "ui/battle/skill/la.plist",
  "ui/battle/skill/yan.plist",
  "ui/battle/skill/btn_eff.plist"
}
GlobalSpineRes = {
  "spineEff/sp_juqi_hou",
  "spineEff/sp_juqi_qian"
}
HeroType = {
  legend = 1,
  diamond = 2,
  normal = 3,
  lowStar = 4,
  monster = 5,
  npc = 6,
  beauty = 7
}
TitleData = {
  [1] = "主\n食",
  [2] = "主\n菜",
  [3] = "副\n菜",
  [4] = "甜\n点",
  [5] = "头\n盘",
  [6] = "汤\n饮"
}
BuffAtts = {
  [1] = "Hp",
  [2] = "Atk",
  [3] = "PhyDef",
  [4] = "Hit",
  [5] = "Miss",
  [6] = "Crit",
  [7] = "AtkSpeed",
  [8] = "CritHurt",
  [9] = "Resist",
  [10] = "TrueAtk",
  [11] = "AtkResist",
  [12] = "HitResist",
  [13] = "CritResist",
  [14] = "CritHurtResist",
  [15] = "TeBao",
  [16] = "TeKang"
}
EditStatus = {normal = 0, fitment = 1}
EntityType = {
  hero = 1,
  fitment = 2,
  wallItem = 3,
  rug = 4
}
WallSide = {left = 1, right = 2}
RuleFrontNames = {
  [1] = "等级",
  [2] = "队伍",
  [3] = "星级",
  [4] = "品质",
  [5] = "美味度",
  [6] = "好感度",
  [7] = "觉醒"
}
RuleFrontType = {
  [1] = "level",
  [2] = "team",
  [3] = "star",
  [4] = "quality",
  [5] = "battle",
  [6] = "love",
  [7] = "awake"
}
EquipFrontNames = {
  [1] = "稀有度",
  [2] = "改造次数",
  [3] = "强化等级",
  [4] = "获得时间"
}
EquipFrontType = {
  [1] = "star",
  [2] = "wash",
  [3] = "strength",
  [4] = "time"
}
SauceFrontNames = {
  [1] = "稀有度",
  [2] = "进阶等级"
}
SauceFrontType = {
  [1] = "star",
  [2] = "advance"
}
RuleAfterDesc = {
  [1] = "降序",
  [2] = "升序"
}
RuleAfterType = {
  [1] = "Desc",
  [2] = "Asc"
}
LtyTitleName = "终焉之乡"
AutumnTitleName = "巫毒地宫"
TongXingZhengName = "次元通行证"
Activity30Title = "便当盒邮购"
Activity40Title = "五星限时烹饪"
Activity42Title = "自助火锅"
Activity47Title = "正义之狮7日签到"
Activity75Title = "春晓烧烤摊·复刻"
Activity103Title = "信的目的地"
