L_Const = L_Const or {}
L_Const.WorldObjectType = {
  Npc = 1,
  Monster = 2,
  Item = 3,
  Enviroment = 4,
  TransferPointSmall = 11,
  TransferPointBig = 12,
  TransferMargin = 13,
  FixedEnemies = 50,
  RandomEnemies = 51,
  Puzzle = 101,
  HomeBarrier = 201,
  SuYaDungeonEntry = 301,
  Collection = 302,
  DungeonTransfer = 303,
  DungeonRewardPoint = 304
}
L_Const.WorldNode = CS.Lens.Gameplay.Modules.Azur.WorldConst.Node
L_Const.worldNodeHideType = {LuaHideScene = 0, LuaUIControlHide = 1}
L_Const.entityHideSource = {
  Story = 8,
  UI = 9,
  LuaUI = 50000,
  TransformIntoKibo = 50001
}
L_Const.entityHideChannle = {
  Logic = 1,
  Visible = 2,
  All = 3
}
L_Const.worldObjType = {
  tag = 1000,
  item = 2000,
  npc = 3000,
  boss = 3001,
  petNpc = 3002
}
L_Const.worldId = {
  mainCity = 1,
  xuanjiRoom = 2,
  lebeCity1 = 3,
  lebeCity2 = 4,
  charluluVillage = 5,
  home = 999,
  newHome = 10000,
  gm = 9999
}
L_Const.worldModule = {
  main = C_EWorldType.World,
  whiteBox = C_EWorldType.WhiteBox,
  prologue = C_EWorldType.Prologue,
  dungeon = C_EWorldType.Dungeon,
  multiDungeon = C_EWorldType.MultiDungeon,
  multipleWorld = C_EWorldType.MultipleWorld,
  home = C_EWorldType.Home,
  homeBase = C_EWorldType.HomeBase,
  meeting = C_EWorldType.World,
  bigBattleWorld = C_EWorldType.BigBattleWorld,
  levelSimulator = C_EWorldType.LevelSimulator,
  interim = C_EWorldType.Interim,
  kiBoDuel = C_EWorldType.KiboDuel,
  storySimulator = C_EWorldType.StorySimulator,
  kiboDuelSimulator = C_EWorldType.KiboDuelSimulator,
  purifySimulator = C_EWorldType.PurifySimulator,
  photo = C_EWorldType.Photo,
  homeDorm = C_EWorldType.HomeDorm,
  rogue = C_EWorldType.Rogue,
  nestCoop = C_EWorldType.NestCoop,
  kiboDuelArena = C_EWorldType.KiboDuelArena,
  culTrial = C_EWorldType.CulTrial,
  homeStory = C_EWorldType.HomeStory,
  culMain = C_EWorldType.CulMain
}
L_Const.skillType = {
  none = 0,
  attack = 1,
  skill1 = 2,
  skill2 = 3,
  ultraSkill = 4,
  coopSkill = 11,
  dodge = 101,
  jump = 102,
  climb = 103,
  exitSkill = 201,
  enterDash = 202,
  enterSkill = 203,
  KiBoVersusCommonSkill1 = 701,
  KiBoVersusCommonSkill2 = 702
}
L_Const.moveMode = {normal = 0, freedom = 1}
L_Const.fsmType = {
  none = C_EFsmStateType.None,
  born = C_EFsmStateType.Born,
  idle = C_EFsmStateType.Idle,
  skill = C_EFsmStateType.Skill,
  move = C_EFsmStateType.Move,
  hit = C_EFsmStateType.Hit,
  stun = C_EFsmStateType.Stun,
  knockUp = C_EFsmStateType.KnockUp,
  knockBack = C_EFsmStateType.KnockBack,
  down = C_EFsmStateType.Down,
  stand = C_EFsmStateType.Stand,
  dead = C_EFsmStateType.Dead,
  engage = C_EFsmStateType.Engage,
  victory = C_EFsmStateType.Victory,
  defeat = C_EFsmStateType.Defeat,
  runOver = C_EFsmStateType.RunOver,
  jump = C_EFsmStateType.Jump,
  dodge = C_EFsmStateType.Dodge,
  rotate = C_EFsmStateType.Rotate,
  fall = C_EFsmStateType.Fall,
  run = C_EFsmStateType.Run,
  jump_Loop = C_EFsmStateType.Jump_Loop,
  jumpGroup = C_EFsmStateType.JumpGroup,
  runFast = C_EFsmStateType.FastRun,
  skillGroup = C_EFsmStateType.SkillGroup,
  dodgeGroup = C_EFsmStateType.DodgeGroup,
  animatorDodge = C_EFsmStateType.AnimatorDodge,
  weakBreak = C_EFsmStateType.WeakBreak,
  engageBehind = C_EFsmStateType.EngageBehind,
  weakGroup = C_EFsmStateType.WeakGroup,
  weakEnd = C_EFsmStateType.WeakEnd,
  ground = C_EFsmStateType.Ground,
  evade = C_EFsmStateType.Evade,
  heavyHit = C_EFsmStateType.HeavyHit,
  tankMode = C_EFsmStateType.TankMode,
  swimGroup = 100,
  swimingIdle = 101,
  swimingUnder = 102,
  swimingOn = 103,
  swim = C_EFsmStateType.Swim,
  personal = C_EFsmStateType.Personal
}
L_Const.agentResult = {
  success = 0,
  repath = 1,
  interrupt = 2
}
L_Const.animParam = {
  running = "Running",
  runOver = "RunOver",
  fall = "Fall",
  walk = "Walk",
  swiming = "Swiming",
  swimingOn = "SwimingOn",
  climb = "Climb"
}
L_Const.anim = {
  idle = "Idle",
  action = "Action",
  run = "Run"
}
L_Const.animIndex = {
  none = -1,
  idle = C_CsAnimator.StringToHash("Idle"),
  jump = C_CsAnimator.StringToHash("Jump"),
  run = C_CsAnimator.StringToHash("Run"),
  dodge = C_CsAnimator.StringToHash("Dodge"),
  walk = C_CsAnimator.StringToHash("Walk"),
  runOverR = C_CsAnimator.StringToHash("RunOverR"),
  runOverL = C_CsAnimator.StringToHash("RunOverL"),
  fastRun = C_CsAnimator.StringToHash("FastRun"),
  swimingIdle = C_CsAnimator.StringToHash("SwimingIdle"),
  swimingOn = C_CsAnimator.StringToHash("SwimingOn"),
  swimingUnder = C_CsAnimator.StringToHash("SwimingUnder")
}
L_Const.gameMode = {
  world = 1,
  battle = 2,
  story = 3
}
L_Const.gameBlend = {normal = 1, suspend = 2}
L_Const.setControlType = {
  normal = 1,
  formation = 2,
  outMount = 3,
  monsterChange = 4
}
L_Const.enemyType = {
  boss = 1,
  elite = 2,
  normal = 3
}
L_Const.guideId = {
  build = 301,
  plant = 302,
  house = 303,
  science = 304,
  product = 305
}
L_Const.elementType = {
  changeProperty = C_BattleElementType.ChangePropertyElement,
  buff = C_BattleElementType.BuffElement,
  stack = C_BattleElementType.StackElement
}
L_Const.buffType = {
  buff = 1,
  debuff = 2,
  stackBuff = 3,
  stackDebuff = 4
}
L_Const.commonCondition = {
  playerLevel = 2004,
  RegionPhotoTimes = 13033,
  ExplorePhoto = 13059
}
L_Const.photoExploreSpawner = 30127
L_Const.petTye = {worldPet = 0, battlePet = 1}
L_Const.worldPointType = {birth = 1, transfer = 2}
L_Const.battleBuffAttr = {
  attrFire = 1,
  attrWind = 2,
  attrSoil = 3,
  attrWood = 4,
  attrIced = 5,
  attrWater = 6,
  attrLightning = 7,
  attrLight = 8,
  attrDark = 9
}
L_Const.skillBorderIcon = {
  [0] = C_Color(0.5450980392156862, 0.6039215686274509, 0.8, 1.0),
  [1] = C_Color(0.5450980392156862, 0.6039215686274509, 0.8, 1.0),
  [2] = C_Color(0.8980392156862745, 0.7019607843137254, 0.3686274509803922, 1.0),
  [3] = C_Color(0.6588235294117647, 0.7764705882352941, 0.792156862745098, 1.0),
  [4] = C_Color(0.6588235294117647, 0.7764705882352941, 0.792156862745098, 1.0)
}
L_Const.nations = {other = 99}
L_Const.REFRESH_PET = true
L_Const.validModulesRoulette = {
  L_Const.worldModule.main,
  L_Const.worldModule.home,
  L_Const.worldModule.homeBase,
  L_Const.worldModule.homeDorm
}
