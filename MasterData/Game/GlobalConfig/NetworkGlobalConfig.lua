require("Framework.Network.NetworkProto")
NetworkTypeID = {
  Hero = 1,
  Lottery = 2,
  Building = 3,
  Shop = 5,
  Sector = 6,
  Object = 7,
  Task = 8,
  Factory = 9,
  Exploration = 10,
  AchivLevel = 11,
  ItemRoom = 12,
  StoreRoom = 14,
  EventRoom = 15,
  ResetRoom = 16,
  Mail = 17,
  Login = 18,
  Arithmetic = 19,
  Dorm = 20,
  HeroEnter = 21,
  Effector = 22,
  Friendship = 23,
  BattleDungeon = 24,
  Debug = 25,
  Avg = 26,
  CommanderSkill = 27,
  BattlePass = 28,
  DailySignIn = 29,
  ActivityFrame = 30,
  Pay = 31,
  CDKey = 32,
  EventNoviceSign = 33,
  PayGift = 34,
  Warehouse = 35,
  Friend = 36,
  TimingProduct = 37,
  ActivitySectorI = 38,
  DungeonTower = 39,
  DungeonSectorII = 40,
  FlappyBird = 41,
  WhiteDay = 42,
  AdjCustom = 43,
  TinyGame = 44,
  RefreshDun = 45,
  ActivityRound = 46,
  GameDamie = 47,
  ActivityCarnival = 48,
  ActivityHistoryTinyGame = 49,
  ActivityDailyChallenge = 50,
  ActivitySectorIII = 51,
  ActivitySignInMiniGame = 52,
  SpecWeapon = 53,
  HeroGrow = 54,
  ActivityHallowmas = 55,
  ActivityKeyExertion = 56,
  ActivitySpring = 57,
  Share = 58,
  WarChess = 60,
  DormFight = 61,
  Invitation = 62,
  EventWeeklyQA = 63,
  ActivitySeason = 64,
  ActivitySaveMoney = 65,
  ActivityLuckyRaffle = 66,
  ChatSystem = 67,
  Interact = 68,
  ActivityDivergent = 69,
  Milestone = 70,
  ActivityExplorationFund = 71,
  ShortTheatre = 72,
  FlipCard = 73,
  Fairy = 74,
  CardSet = 75,
  Vow = 76,
  ActivityBlackHole = 77,
  EventDrawLottery = 78,
  Spring24 = 79,
  ActivityCollectFortune = 80,
  HeroGrowV3 = 81,
  ActSigninLiveStream = 82,
  Reinforce = 83,
  GM = 999
}
NetworkGlobalConfig = {
  [NetworkTypeID.Hero] = {
    NetworkClass = require("Game.Hero.HeroNetworkCtrl")
  },
  [NetworkTypeID.Lottery] = {
    NetworkClass = require("Game.Lottery.LotteryNetworkCtrl")
  },
  [NetworkTypeID.Building] = {
    NetworkClass = require("Game.Oasis.BuildingNetworkCtrl")
  },
  [NetworkTypeID.Shop] = {
    NetworkClass = require("Game.Shop.ShopNetworkCtrl")
  },
  [NetworkTypeID.Sector] = {
    NetworkClass = require("Game.Sector.SectorNetworkCtrl")
  },
  [NetworkTypeID.Object] = {
    NetworkClass = require("Game.PlayerData.ObjectNetworkCtrl")
  },
  [NetworkTypeID.Task] = {
    NetworkClass = require("Game.Task.TaskNetworkCtrl")
  },
  [NetworkTypeID.Factory] = {
    NetworkClass = require("Game.Factory.FactoryNetworkCtrl")
  },
  [NetworkTypeID.Exploration] = {
    NetworkClass = require("Game.Exploration.ExplorationNetworkCtrl")
  },
  [NetworkTypeID.AchivLevel] = {
    NetworkClass = require("Game.Achievement.AchivLevelNetworkCtrl")
  },
  [NetworkTypeID.ItemRoom] = {
    NetworkClass = require("Game.Exploration.ItemRoomNetworkCtrl")
  },
  [NetworkTypeID.StoreRoom] = {
    NetworkClass = require("Game.Exploration.StoreRoomNetworkCtrl")
  },
  [NetworkTypeID.EventRoom] = {
    NetworkClass = require("Game.Exploration.EventRoomNetworkCtrl")
  },
  [NetworkTypeID.ResetRoom] = {
    NetworkClass = require("Game.Exploration.ResetRoomNetworkCtrl")
  },
  [NetworkTypeID.Mail] = {
    NetworkClass = require("Game.Mail.MailNetworkCtrl")
  },
  [NetworkTypeID.Login] = {
    NetworkClass = require("Game.Login.LoginNetWorkCtrl")
  },
  [NetworkTypeID.Arithmetic] = {
    NetworkClass = require("Game.Arithmetic.ArithmeticNetwork")
  },
  [NetworkTypeID.Dorm] = {
    NetworkClass = require("Game.Dorm.DormNetworkCtrl")
  },
  [NetworkTypeID.HeroEnter] = {
    NetworkClass = require("Game.HeroEnter.HeroEnterNetworkCtrl")
  },
  [NetworkTypeID.Effector] = {
    NetworkClass = require("Game.Effector.EffectorNetworkCtrl")
  },
  [NetworkTypeID.Friendship] = {
    NetworkClass = require("Game.Friendship.FriendshipNetworkCtrl")
  },
  [NetworkTypeID.BattleDungeon] = {
    NetworkClass = require("Game.BattleDungeon.BattleDungeonNetworkCtrl")
  },
  [NetworkTypeID.Debug] = {
    NetworkClass = require("Game.Debug.DebugNetworkCtrl")
  },
  [NetworkTypeID.Avg] = {
    NetworkClass = require("Game.Avg.AvgNetwork")
  },
  [NetworkTypeID.CommanderSkill] = {
    NetworkClass = require("Game.CommanderSkill.CommanderSkillNetworkCtrl")
  },
  [NetworkTypeID.BattlePass] = {
    NetworkClass = require("Game.BattlePass.BattlePassNetworkCtrl")
  },
  [NetworkTypeID.Pay] = {
    NetworkClass = require("Game.Pay.PayNetworkCtrl")
  },
  [NetworkTypeID.GM] = {
    NetworkClass = require("Game.GM.GMNetworkCtrl")
  },
  [NetworkTypeID.DailySignIn] = {
    NetworkClass = require("Game.DailySignIn.DailySignInNetworkCtrl")
  },
  [NetworkTypeID.ActivityFrame] = {
    NetworkClass = require("Game.ActivityFrame.ActivityFrameNetworkCtrl")
  },
  [NetworkTypeID.CDKey] = {
    NetworkClass = require("Game.Setting.CDKeyNetworkCtrl")
  },
  [NetworkTypeID.EventNoviceSign] = {
    NetworkClass = require("Game.EventNoviceSign.EventNoviceSignNetwork")
  },
  [NetworkTypeID.PayGift] = {
    NetworkClass = require("Game.PayGift.PayGiftNetworkController")
  },
  [NetworkTypeID.Warehouse] = {
    NetworkClass = require("Game.Warehouse.WarehouseNetwork")
  },
  [NetworkTypeID.Friend] = {
    NetworkClass = require("Game.Friend.FriendNetworkCtrl")
  },
  [NetworkTypeID.TimingProduct] = {
    NetworkClass = require("Game.PlayerData.TimingProduct.TimingProductNetwork")
  },
  [NetworkTypeID.ActivitySectorI] = {
    NetworkClass = require("Game.ActivitySectorI.ActivitySectorINetworkCtrl")
  },
  [NetworkTypeID.DungeonTower] = {
    NetworkClass = require("Game.DungeonCenter.Network.DungeonTowerNetworkCtrl")
  },
  [NetworkTypeID.DungeonSectorII] = {
    NetworkClass = require("Game.DungeonCenter.Network.DungeonSectorIINetworkCtrl")
  },
  [NetworkTypeID.FlappyBird] = {
    NetworkClass = require("Game.TinyGames.FlappyBird.Ctrl.FlappyBirdNetWorkCtrl")
  },
  [NetworkTypeID.AdjCustom] = {
    NetworkClass = require("Game.AdjCustom.AdjCustomNetworkCtrl")
  },
  [NetworkTypeID.WhiteDay] = {
    NetworkClass = require("Game.ActivityWhiteDay.ActivityWhiteDayNetworkCtrl")
  },
  [NetworkTypeID.TinyGame] = {
    NetworkClass = require("Game.TinyGames.TinyGameNetworkCtrl")
  },
  [NetworkTypeID.ActivityRound] = {
    NetworkClass = require("Game.ActivityRound.ActivityRoundNetworkCtrl")
  },
  [NetworkTypeID.RefreshDun] = {
    NetworkClass = require("Game.ActivityRefreshDun.ActRefreshNetorkCtrl")
  },
  [NetworkTypeID.GameDamie] = {
    NetworkClass = require("Game.TinyGames.Damie.Ctrl.DamieNetWorkCtrl")
  },
  [NetworkTypeID.ActivityCarnival] = {
    NetworkClass = require("Game.ActivityCarnival.ActivityCarnivalNetworkCtrl")
  },
  [NetworkTypeID.ActivityHistoryTinyGame] = {
    NetworkClass = require("Game.ActivityHistoryTinyGame.ActivityHistoryTinyGameNetCtrl")
  },
  [NetworkTypeID.ActivityDailyChallenge] = {
    NetworkClass = require("Game.ActivityDailyChallenge.ActivityDailyChallengeNetworkCtrl")
  },
  [NetworkTypeID.Share] = {
    NetworkClass = require("Game.Share.ShareNetWorkCtrl")
  },
  [NetworkTypeID.WarChess] = {
    NetworkClass = require("Game.WarChess.Network.WarChessNetworkCtrl")
  },
  [NetworkTypeID.ActivitySectorIII] = {
    NetworkClass = require("Game.ActivitySectorIII.ActivitySectorIIINetwork")
  },
  [NetworkTypeID.ActivitySignInMiniGame] = {
    NetworkClass = require("Game.ActivitySignInMiniGame.ActivitySignInMiniGameNetorkCtrl")
  },
  [NetworkTypeID.SpecWeapon] = {
    NetworkClass = require("Game.SpecWeapon.SpecWeaponNetwork")
  },
  [NetworkTypeID.HeroGrow] = {
    NetworkClass = require("Game.ActivityHeroGrow.ActivityHeroGrowNetwork")
  },
  [NetworkTypeID.HeroGrowV3] = {
    NetworkClass = require("Game.ActivityHeroGrowV3.ActivityHeroGrowV3NetCtrl")
  },
  [NetworkTypeID.ActivityHallowmas] = {
    NetworkClass = require("Game.ActivityHallowmas.ActivityHallowmasNetwork")
  },
  [NetworkTypeID.ActivityKeyExertion] = {
    NetworkClass = require("Game.ActivityKeyExertion.ActivityKeyExertionNetwork")
  },
  [NetworkTypeID.ActivitySpring] = {
    NetworkClass = require("Game.ActivitySpring.ActivitySpringNetwork")
  },
  [NetworkTypeID.DormFight] = {
    NetworkClass = require("Game.DormFight.DormFightNetworkCtrl")
  },
  [NetworkTypeID.Invitation] = {
    NetworkClass = require("Game.ActivityInvitation.Data.ActivityInvitationNetwork")
  },
  [NetworkTypeID.EventWeeklyQA] = {
    NetworkClass = require("Game.EventWeeklyQA.EventWeeklyQANetWork")
  },
  [NetworkTypeID.ActivitySeason] = {
    NetworkClass = require("Game.ActivitySeason.ActivitySeasonNetworkController")
  },
  [NetworkTypeID.ActivitySaveMoney] = {
    NetworkClass = require("Game.ActivitySaveMoney.ActivitySaveMoneyNetworkController")
  },
  [NetworkTypeID.ActivityLuckyRaffle] = {
    NetworkClass = require("Game.ActivityLuckyRaffle.ActivityLuckyRaffleNetWork")
  },
  [NetworkTypeID.ChatSystem] = {
    NetworkClass = require("Game.ChatSystem.Controller.ChatSystemNetController")
  },
  [NetworkTypeID.CardSet] = {
    NetworkClass = require("Game.CardSet.CardSetNetWorkCtrl")
  },
  [NetworkTypeID.Interact] = {
    NetworkClass = require("Game.ActivityLobby.Interact.ActivityInteractNetWork")
  },
  [NetworkTypeID.Milestone] = {
    NetworkClass = require("Game.MileStone.MilestoneNetworkCtrl")
  },
  [NetworkTypeID.ActivityDivergent] = {
    NetworkClass = require("Game.ActivityDivergent.ActivityDivergentNetWork")
  },
  [NetworkTypeID.ActivityExplorationFund] = {
    NetworkClass = require("Game.ActivityExplorationFund.ActivityExplorationFundNetWork")
  },
  [NetworkTypeID.ShortTheatre] = {
    NetworkClass = require("Game.ActivityShortTheatre.ActivityShortTheatreNetWorkCtrl")
  },
  [NetworkTypeID.FlipCard] = {
    NetworkClass = require("Game.ActivityFlipCard.ActivityFlipCardNetwork")
  },
  [NetworkTypeID.Fairy] = {
    NetworkClass = require("Game.Fairy.FairyNetworkCtrl")
  },
  [NetworkTypeID.Vow] = {
    NetworkClass = require("Game.VowSystem.VowSystemNetwork")
  },
  [NetworkTypeID.ActivityBlackHole] = {
    NetworkClass = require("Game.ActivityBlackHole.ActivityBlackHoleNetworkCtrl")
  },
  [NetworkTypeID.EventDrawLottery] = {
    NetworkClass = require("Game.EventDrawLottery.EventDrawLotteryNetCtrl")
  },
  [NetworkTypeID.Spring24] = {
    NetworkClass = require("Game.ActivitySpring24.ActivitySpring24NetCtrl")
  },
  [NetworkTypeID.ActivityCollectFortune] = {
    NetworkClass = require("Game.ActivityCollectFortune.ActivityCollectFortuneNetworkCtrl")
  },
  [NetworkTypeID.Reinforce] = {
    NetworkClass = require("Game.Reinforce.ReinforceNetCtrl")
  },
  [NetworkTypeID.ActSigninLiveStream] = {
    NetworkClass = require("Game.ActSignInLiveStream.ActSigninLiveStreamNetWork")
  }
}
