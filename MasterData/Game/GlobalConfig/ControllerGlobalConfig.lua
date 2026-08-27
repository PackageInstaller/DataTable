ControllerTypeId = {
  SectorController = 1,
  OasisController = 2,
  Shop = 4,
  Factory = 5,
  Task = 6,
  Mail = 7,
  Setting = 8,
  Dorm = 9,
  Avg = 10,
  Formation = 12,
  AvgPlay = 13,
  TimePass = 14,
  HomeController = 15,
  Login = 16,
  Lottery = 17,
  Cv = 18,
  StrategyOverview = 19,
  BuildingQueue = 21,
  BattlePass = 22,
  Skin = 23,
  Pay = 24,
  ActivityFrame = 25,
  CommanderSkill = 26,
  SectorTaskCtrl = 27,
  PayGift = 28,
  RecommeFormation = 29,
  GameNotice = 30,
  BattleResultAftertTeatment = 31,
  DailyDungeonLevelCtrl = 32,
  DormFight = 33,
  ShowCharacter = 34,
  DungeonTower = 35,
  SectorII = 36,
  WhiteDay = 37,
  ActRefreshDungeon = 38,
  ActivityComeback = 39,
  ActivityTask = 40,
  ActivityRound = 41,
  Share = 42,
  ActivityCarnival = 43,
  HandBook = 44,
  HistoryTinyGameActivity = 45,
  ActivityDailyChallenge = 46,
  ActivitySectorIII = 47,
  ActivityTaskLimit = 48,
  ActivitySignInMiniGame = 49,
  ActivityHeroGrow = 50,
  ActivityHallowmas = 51,
  ActivityKeyExertion = 52,
  ActivitySpring = 53,
  ActivityLobbyCtrl = 54,
  ActivityWinter23 = 55,
  ActivityInvitation = 56,
  SmashingPenguins = 57,
  ActivitySeason = 58,
  ActivityBrotatoLobby = 59,
  ActivityCarnival23 = 60,
  SectorLevelChapter = 70,
  LuckyRaffle = 71,
  ActivityAnniversary23 = 72,
  ShowCharacterSkin = 10086,
  DormFight = 101,
  EventWeeklyQA = 102,
  EventAngelaGift = 103,
  ActivitySaveMoney = 104,
  ChatSystem = 105,
  MiniGameMusic = 106,
  VowSystem = 107,
  ActivityDivergent = 108,
  ActivityExplorationFund = 109,
  ShortTheatre = 110,
  FlipCard = 111,
  ActBlackHole = 112,
  EventLadderGift = 113,
  Fairy = 120,
  ActivityCardSet = 121,
  ActivitySkinLimit = 122,
  ActSteinsGateMiniGame = 123,
  Activity23SteinsGate = 124,
  ActivityHazeGift = 125,
  EventDrawLottery = 126,
  ActivitySpring24 = 127,
  ActivityCollectFortune = 128,
  ActivityHeroGrowV3 = 129,
  ActSigninLiveStreamCtrl = 130,
  ActivityCarnival24 = 131,
  ActivityBond = 132,
  DunSixHeroTower = 133,
  DeliverySimulator = 134,
  ActDeliverySimulator = 135,
  ActAnniversary24 = 136
}
ControllerGlobalConfig = {
  [ControllerTypeId.HomeController] = {
    ControllerClass = require("Game.Home.HomeController")
  },
  [ControllerTypeId.SectorController] = {
    ControllerClass = require("Game.Sector.SectorController")
  },
  [ControllerTypeId.OasisController] = {
    ControllerClass = require("Game.Oasis.OasisController")
  },
  [ControllerTypeId.Shop] = {
    ControllerClass = require("Game.Shop.ShopController")
  },
  [ControllerTypeId.Factory] = {
    ControllerClass = require("Game.Factory.FactoryController")
  },
  [ControllerTypeId.Task] = {
    ControllerClass = require("Game.Task.TaskController")
  },
  [ControllerTypeId.Mail] = {
    ControllerClass = require("Game.Mail.New_MailController")
  },
  [ControllerTypeId.Setting] = {
    ControllerClass = require("Game.Setting.SettingController")
  },
  [ControllerTypeId.Dorm] = {
    ControllerClass = require("Game.Dorm.DormController")
  },
  [ControllerTypeId.Avg] = {
    ControllerClass = require("Game.Avg.AvgController")
  },
  [ControllerTypeId.AvgPlay] = {
    ControllerClass = require("Game.Avg.AvgPlayController")
  },
  [ControllerTypeId.Formation] = {
    ControllerClass = require("Game.Formation.FormationController")
  },
  [ControllerTypeId.TimePass] = {
    ControllerClass = require("Game.TimePass.TimePassController")
  },
  [ControllerTypeId.Login] = {
    ControllerClass = require("Game.Login.LoginController")
  },
  [ControllerTypeId.Lottery] = {
    ControllerClass = require("Game.Lottery.LotteryController")
  },
  [ControllerTypeId.Cv] = {
    ControllerClass = require("Game.CharacterVoice.CharacterVoiceController")
  },
  [ControllerTypeId.StrategyOverview] = {
    ControllerClass = require("Game.StrategyOverview.StrategyOverviewController")
  },
  [ControllerTypeId.ActivityFrame] = {
    ControllerClass = require("Game.ActivityFrame.ActivityFrameController")
  },
  [ControllerTypeId.BuildingQueue] = {
    ControllerClass = require("Game.Oasis.BuildingQueueCtrl")
  },
  [ControllerTypeId.Pay] = {
    ControllerClass = require("Game.Pay.PayController")
  },
  [ControllerTypeId.BattlePass] = {
    ControllerClass = require("Game.BattlePass.BattlePassController")
  },
  [ControllerTypeId.Skin] = {
    ControllerClass = require("Game.Skin.SkinController")
  },
  [ControllerTypeId.CommanderSkill] = {
    ControllerClass = require("Game.CommanderSkill.CommanderSkillCtrl")
  },
  [ControllerTypeId.SectorTaskCtrl] = {
    ControllerClass = require("Game.Sector.SectorTask.SectorTaskController")
  },
  [ControllerTypeId.PayGift] = {
    ControllerClass = require("Game.PayGift.PayGiftController")
  },
  [ControllerTypeId.RecommeFormation] = {
    ControllerClass = require("Game.Formation.RecommeFormationController")
  },
  [ControllerTypeId.GameNotice] = {
    ControllerClass = require("Game.GameNotice.GameNoticeController")
  },
  [ControllerTypeId.DailyDungeonLevelCtrl] = {
    ControllerClass = require("Game.DailyDungeon.DailyDungeonLevelCtrl")
  },
  [ControllerTypeId.BattleResultAftertTeatment] = {
    ControllerClass = require("Game.BattleResult.BattleResultAftertTeatmentCtrl")
  },
  [ControllerTypeId.ShowCharacter] = {
    ControllerClass = require("Game.ShowCharacter.ShowCharacterCtrl")
  },
  [ControllerTypeId.DungeonTower] = {
    ControllerClass = require("Game.DungeonCenter.DungeonTowerController")
  },
  [ControllerTypeId.SectorII] = {
    ControllerClass = require("Game.ActivitySectorII.ActivitySectorIICtrl")
  },
  [ControllerTypeId.ShowCharacterSkin] = {
    ControllerClass = require("Game.ShowCharacterSkin.ShowCharacterSkinController")
  },
  [ControllerTypeId.WhiteDay] = {
    ControllerClass = require("Game.ActivityWhiteDay.ActivityWhiteDayController")
  },
  [ControllerTypeId.ActivityComeback] = {
    ControllerClass = require("Game.ActivityComeback.ActivityComebackController")
  },
  [ControllerTypeId.ActivityTask] = {
    ControllerClass = require("Game.ActivityFrame.ActivityTaskController")
  },
  [ControllerTypeId.ActivityRound] = {
    ControllerClass = require("Game.ActivityRound.ActivityRoundController")
  },
  [ControllerTypeId.ActRefreshDungeon] = {
    ControllerClass = require("Game.ActivityRefreshDun.ActRefreshDunController")
  },
  [ControllerTypeId.Share] = {
    ControllerClass = require("Game.Share.ShareController")
  },
  [ControllerTypeId.ActivityCarnival] = {
    ControllerClass = require("Game.ActivityCarnival.ActivityCarnivalController")
  },
  [ControllerTypeId.HandBook] = {
    ControllerClass = require("Game.HandBook.HandBookController")
  },
  [ControllerTypeId.HistoryTinyGameActivity] = {
    ControllerClass = require("Game.ActivityHistoryTinyGame.ActivityHistoryTinyGameController")
  },
  [ControllerTypeId.ActivityDailyChallenge] = {
    ControllerClass = require("Game.ActivityDailyChallenge.ActivityDailyChallengeController")
  },
  [ControllerTypeId.ActivitySectorIII] = {
    ControllerClass = require("Game.ActivitySectorIII.ActivitySectorIIIController")
  },
  [ControllerTypeId.ActivityTaskLimit] = {
    ControllerClass = require("Game.ActivityLimitTask.ActivityLimitTaskCtrl")
  },
  [ControllerTypeId.ActivitySignInMiniGame] = {
    ControllerClass = require("Game.ActivitySignInMiniGame.ActivitySignInMiniGameCtrl")
  },
  [ControllerTypeId.ActivityHeroGrow] = {
    ControllerClass = require("Game.ActivityHeroGrow.ActivityHeroGrowController")
  },
  [ControllerTypeId.ActivityHallowmas] = {
    ControllerClass = require("Game.ActivityHallowmas.ActivityHallowmasController")
  },
  [ControllerTypeId.ActivityKeyExertion] = {
    ControllerClass = require("Game.ActivityKeyExertion.ActivityKeyExertionController")
  },
  [ControllerTypeId.ActivityLobbyCtrl] = {
    ControllerClass = require("Game.ActivityLobby.ActivityLobbyCtrl")
  },
  [ControllerTypeId.ActivitySpring] = {
    ControllerClass = require("Game.ActivitySpring.ActivitySpringController")
  },
  [ControllerTypeId.ActivityWinter23] = {
    ControllerClass = require("Game.ActivityWinter23.Data.ActivityWinter23Controller")
  },
  [ControllerTypeId.DormFight] = {
    ControllerClass = require("Game.DormFight.DormFightCtrl")
  },
  [ControllerTypeId.ActivityInvitation] = {
    ControllerClass = require("Game.ActivityInvitation.Data.ActivityInvitationController")
  },
  [ControllerTypeId.SmashingPenguins] = {
    ControllerClass = require("Game.TinyGames.SmashingPenguins.SmashingPenguinsController")
  },
  [ControllerTypeId.EventWeeklyQA] = {
    ControllerClass = require("Game.EventWeeklyQA.EventWeeklyQAController")
  },
  [ControllerTypeId.EventAngelaGift] = {
    ControllerClass = require("Game.EventAngelaGift.EventAngelaGiftController")
  },
  [ControllerTypeId.ActivityCarnival23] = {
    ControllerClass = require("Game.ActivityCarnival23.ActivityCarnival23Controller")
  },
  [ControllerTypeId.SectorLevelChapter] = {
    ControllerClass = require("Game.Sector.SectorLevelChapterController")
  },
  [ControllerTypeId.ActivityBrotatoLobby] = {
    ControllerClass = require("Game.ActivityBrotatoLobby.ActivityBrotatoLobbyCtrl")
  },
  [ControllerTypeId.ActivitySeason] = {
    ControllerClass = require("Game.ActivitySeason.ActivitySeasonController")
  },
  [ControllerTypeId.ActivitySaveMoney] = {
    ControllerClass = require("Game.ActivitySaveMoney.ActivitySaveMoneyController")
  },
  [ControllerTypeId.LuckyRaffle] = {
    ControllerClass = require("Game.ActivityLuckyRaffle.ActivityLuckyRaffleController")
  },
  [ControllerTypeId.ChatSystem] = {
    ControllerClass = require("Game.ChatSystem.Controller.ChatSystemController")
  },
  [ControllerTypeId.ActivityCardSet] = {
    ControllerClass = require("Game.ActivityCardSet.ActivityCardSetCtrl")
  },
  [ControllerTypeId.MiniGameMusic] = {
    ControllerClass = require("Game.TinyGames.Music.MiniGameMusicController")
  },
  [ControllerTypeId.ActivityDivergent] = {
    ControllerClass = require("Game.ActivityDivergent.ActivityDivergentController")
  },
  [ControllerTypeId.VowSystem] = {
    ControllerClass = require("Game.VowSystem.VowSystemCtrl")
  },
  [ControllerTypeId.ActivityExplorationFund] = {
    ControllerClass = require("Game.ActivityExplorationFund.ActivityExplorationFundController")
  },
  [ControllerTypeId.ShortTheatre] = {
    ControllerClass = require("Game.ActivityShortTheatre.ActivityShortTheatreCtrl")
  },
  [ControllerTypeId.ActivityAnniversary23] = {
    ControllerClass = require("Game.ActivityAnniversary23.ActivityAnniversary23Controller")
  },
  [ControllerTypeId.FlipCard] = {
    ControllerClass = require("Game.ActivityFlipCard.ActivityFlipCardController")
  },
  [ControllerTypeId.ActBlackHole] = {
    ControllerClass = require("Game.ActivityBlackHole.ActivityBlackHoleController")
  },
  [ControllerTypeId.EventLadderGift] = {
    ControllerClass = require("Game.EventLadderGift.EventLadderGiftController")
  },
  [ControllerTypeId.Fairy] = {
    ControllerClass = require("Game.Fairy.FairyController")
  },
  [ControllerTypeId.ActivitySkinLimit] = {
    ControllerClass = require("Game.ActivitySkinLimit.ActivitySkinLimitController")
  },
  [ControllerTypeId.ActSteinsGateMiniGame] = {
    ControllerClass = require("Game.ActivitySteinsGateMiniGame.ActivitySteinsGateMiniGameCtrl")
  },
  [ControllerTypeId.Activity23SteinsGate] = {
    ControllerClass = require("Game.Activity23SteinsGate.Activity23SteinsGateController")
  },
  [ControllerTypeId.ActivityHazeGift] = {
    ControllerClass = require("Game.ActivityHazeGift.ActivityHazeGiftController")
  },
  [ControllerTypeId.EventDrawLottery] = {
    ControllerClass = require("Game.EventDrawLottery.EventDrawLotteryController")
  },
  [ControllerTypeId.ActivitySpring24] = {
    ControllerClass = require("Game.ActivitySpring24.ActivitySpring24Controller")
  },
  [ControllerTypeId.ActivityCollectFortune] = {
    ControllerClass = require("Game.ActivityCollectFortune.ActivityCollectFortuneController")
  },
  [ControllerTypeId.ActivityHeroGrowV3] = {
    ControllerClass = require("Game.ActivityHeroGrowV3.ActiviryHeroGrowV3Ctrl")
  },
  [ControllerTypeId.ActSigninLiveStreamCtrl] = {
    ControllerClass = require("Game.ActSignInLiveStream.ActSigninLiveStreamCtrl")
  },
  [ControllerTypeId.ActivityCarnival24] = {
    ControllerClass = require("Game.ActivityCarnival24.ActivityCarnival24Controller")
  },
  [ControllerTypeId.ActivityBond] = {
    ControllerClass = require("Game.ActivityBond.ActivityBondCtrl")
  },
  [ControllerTypeId.DunSixHeroTower] = {
    ControllerClass = require("Game.DungeonCenter.SixHeroTower.DunSixHeroCtrl")
  },
  [ControllerTypeId.DeliverySimulator] = {
    ControllerClass = require("Game.ActivityDeliverySimulator.Ctrl.DeliverySimulatorCtrl")
  },
  [ControllerTypeId.ActDeliverySimulator] = {
    ControllerClass = require("Game.ActivityDeliverySimulator.ActMain.Ctrl.ActDeliverySimulatorCtrl")
  },
  [ControllerTypeId.ActAnniversary24] = {
    ControllerClass = require("Game.ActivityAnniversary24.ActAnniversary24Ctrl")
  }
}
