local this = {}
local DotDef = {
  Menu = "Menu",
  Hero = "Hero",
  HeroNew = "HeroNew_%s",
  HeroGrade = "HeroGrade_%s",
  HeroSkill = "HeroSkill_%s",
  HeroSpirit = "HeroSpirit_%s",
  HeroJewel = "HeroJewel_%s",
  HeroJewelParent = "HeroJewel",
  HeroInfo = "HeroInfo_%s",
  HeroAcc = "HeroAcc_%s",
  HeroTalent = "HeroTalent_%s",
  HeroPresent = "HeroPresent_%s",
  HeroTalentAndJewelMenu = "HeroTalentAndJewelMenu_%s",
  HeroHead = "HeroHead_%s",
  HeroClothing = "HeroClothing_%s",
  Chat = "Chat",
  Friend = "Friend",
  FriendPrivateChat = "FriendPrivateChat",
  FriendChannelChat = "FriendChannelChat",
  FriendChannelWorldChat = "FriendChannelWorldChat",
  FriendApplication = "FriendApplication",
  FriendChannelTeamChat = "FriendChannelTeamChat",
  FriendPrivateChat_Player = "FriendPrivateChat_%s",
  FriendChatTip = "FriendChatTip",
  FriendChatTipBubble = "FriendChatTipBubble",
  FriendChatTipBackground = "FriendChatTipBackground",
  Mail = "Mail",
  SpecialShop = "SpecialShop",
  Achieve = "Achieve",
  PlayerInfo = "PlayerInfo",
  Title = "Title_%s",
  TitlePre = "TitlePre",
  TitleSuf = "TitleSuf",
  PlayerHead = "PlayerHead",
  PlayerHead_head = "PlayerHead_head_%s",
  PlayerHead_frame = "PlayerHead_frame_%s",
  PlayerHeadItem = "PlayerHead_%s",
  Activity = "Activity",
  AllActivity = "AllActivity",
  DairyActivity = "DairyActivity",
  WeeklyActivity = "WeeklyActivity",
  NoviceTask = "NoviceTask",
  GuideTaskManual = "GuideTaskManual",
  DuelTaskManual = "DuelTaskManual",
  WorldExplore = "WorldExplore_%s",
  Pet = "Pet",
  PetNew = "PetNew_%s",
  PetGeneMutation = "PetGeneMutation_%s",
  PetRankUp = "PetRankUp_%s",
  EntrustTask = "EntrustTask",
  EntrustTaskDifficulty = "EntrustTaskDifficulty_%s",
  EntrustTaskEnter = "EntrustTaskEnter",
  EntrustTrain = "EntrustTrain_%s",
  EntrustBattleTask = "EntrustBattleTask_%s",
  EntrustDoubleReward = "EntrustDoubleReward",
  EntrustStarReward = "EntrustStarReward",
  EntrustMultiTaskDifficulty = "EntrustMultiTaskDifficulty_%s",
  EntrustTrainEnter = "EntrustTrainEnter",
  EntrustGameActEnter = "EntrustGameActEnter",
  EntrustKiboDuelReward = "EntrustKiboDuelReward",
  CookNew = "CookNew_%s",
  Bag = "Bag",
  SpiritNew = "SpiritNew_%s",
  JewelNew = "JewelNew_%s",
  Home = "Home",
  HomeScience = "HomeScience",
  Announcement = "Announcement",
  AnnouncementActive = "Announcement_%s",
  MainCityHomeTechLevelShow = "MainCityHomeTechLevelShow",
  LevelUnlockHomeContent = "LevelUnlockHomeContent_%s",
  NewTask = "newTask_%s",
  NewTutorialGuide = "NewTutorialGuide_%s",
  NewTutorialActivityGuide = "NewTutorialActivityGuide_%s",
  NewEmoji = "NewEmoji_%s",
  NewEmojiType = "NewEmojiType_%s",
  Mount = "Mount",
  MountNew = "MountNew_%s",
  GameAct = "GameAct",
  GameAct_ActCenter = "GameAct_ActCenter",
  GameAct_New = "GameAct_New_%s",
  GameAct_Single_New = "GameAct_New_Single_%s",
  GameAct_Events = "GameAct_Events_%d",
  GameAct_EventsInCenter = "GameAct_EventsInCenter_%d",
  GameAct_Events_Reward = "GameAct_Events_Reward_%d",
  GameAct_Events_Battle = "GameAct_Events_Battle_%s",
  GameAct_Events_Submit = "GameAct_Events_Submit_%s",
  GameAct_Events_SubmitNew = "GameAct_Events_Submit",
  GameAct_Events_PtShop = "GameAct_Events_PtShop_%d",
  GameAct_Reward_Tab = "GameAct_Reward_Tab_%d",
  GameAct_Events_Group_Reward = "GameAct_Events_Reward_Group_%s",
  GameAct_Events_Kibo_Battle = "GameAct_Events_Kibo_Battle_%s",
  GameAct_Events_Kibo_Travel = "GameAct_Events_Kibo_Travel_%s",
  GameAct_Events_Survey_New = "GameAct_Events_Kibo_New_%s",
  GameAct_Events_Survey_Award = "GameAct_Events_Kibo_Award_%s",
  GameAct_Events_Redungeon = "GameAct_Events_Redungeon",
  GameAct_Scenario_PreTask = "GameAct_Scenario_PreTask_%s",
  PlayerDressItem = "PlayerDress_%s",
  PlayerDressEntrance = "PlayerDress",
  PlayerDressTab = "PlayerDressTab_%s",
  productionNew = "ProductionNew_%s",
  PetCatalog = "PetCatalog",
  Adventure = "Adventure",
  kiBoDuelAreaLevel = "kiBoDuelAreaLevel",
  Adventure_KiboDuelAreaLevel = "Adventure_KiboDuelAreaLevel",
  kiBoDuelAreaLevel_Reward = "kiBoDuelAreaLevel_Reward_%s",
  kiBoDuel_Skill = "kiBoDuel_Skill",
  kiBoDuel_Skill_New = "kiBoDuel_Skill_New_%s",
  KiboDuel_NPC_New = "KiboDuel_NPC_New_%s",
  SocialEmotion = "SocialEmotion",
  SocialEmotion_New = "SocialEmotion_New",
  JourneyTaskMainMenu = "JourneyTaskMainMenu",
  JourneyTask = "JourneyTask",
  JourneyTaskNew = "JourneyTask_New",
  KiboDuel_LevelGroup_New = "KiboDuel_Group_New_%s",
  BattlePassLua = "BattlePass_Lua",
  BattlePassMainMenu = "BattlePassMainMenu",
  IllustratedSoulEssence_New = "IllustratedSoulEssence_New_%s",
  IllustratedSoulEssence_Enter = "IllustratedSoulEssence_Enter",
  HandBook = "HandBook",
  HandBook_Character_New = "HandBook_Character_New",
  HandBook_Character_New_Item = "HandBook_Character_New_Item_%s",
  Gacha = "Gacha",
  Rogue = "Rogue",
  Shop = "Shop",
  Abbys = "Abbys_Lua",
  Setting = "Setting"
}

function this:initReddotConfs()
  local DotConf = {
    [DotDef.Menu] = {
      subNodes = {
        DotDef.Mail,
        DotDef.Setting,
        DotDef.PlayerInfo,
        DotDef.Hero,
        DotDef.Pet,
        DotDef.Bag,
        DotDef.Home,
        DotDef.EntrustTaskEnter,
        DotDef.PetCatalog,
        DotDef.Achieve,
        DotDef.JourneyTaskMainMenu,
        DotDef.BattlePassMainMenu,
        DotDef.Adventure,
        DotDef.kiBoDuelAreaLevel,
        DotDef.CookNew,
        DotDef.Friend
      }
    },
    [DotDef.Adventure] = {
      subNodes = {
        DotDef.Adventure_KiboDuelAreaLevel
      }
    },
    [DotDef.Hero] = {
      subNodes = {
        DotDef.HeroNew,
        DotDef.HeroTalentAndJewelMenu,
        DotDef.HeroHead
      }
    },
    [DotDef.Chat] = {
      subNodes = {
        DotDef.Friend,
        DotDef.FriendPrivateChat,
        DotDef.FriendChannelChat,
        DotDef.FriendChatTip
      }
    },
    [DotDef.Friend] = {
      subNodes = {
        DotDef.FriendApplication,
        DotDef.FriendPrivateChat_Player
      }
    },
    [DotDef.FriendPrivateChat] = {
      subNodes = {
        DotDef.FriendPrivateChat_Player
      }
    },
    [DotDef.FriendChannelChat] = {
      subNodes = {
        DotDef.FriendChannelTeamChat
      }
    },
    [DotDef.FriendChatTip] = {
      subNodes = {
        DotDef.FriendChatTipBubble,
        DotDef.FriendChatTipBackground
      }
    },
    [DotDef.SocialEmotion] = {
      subNodes = {
        DotDef.SocialEmotion_New
      }
    },
    [DotDef.HeroJewelParent] = {
      bindNodeName = DotDef.HeroJewelParent
    },
    [DotDef.HeroNew] = {
      listFunc = "getDotHeroNew"
    },
    [DotDef.HeroGrade] = {
      listFunc = "getDotHeroStar",
      unlock = L_SystemConst.enum.heroGrade
    },
    [DotDef.HeroSkill] = {
      listFunc = "getDotHeroSkill",
      unlock = L_SystemConst.enum.skill
    },
    [DotDef.HeroSpirit] = {
      listFunc = "getDotHeroSpirit",
      unlock = L_SystemConst.enum.soulEssence
    },
    [DotDef.HeroTalent] = {
      listFunc = "getDotHeroTalent",
      unlock = L_SystemConst.enum.heroTalent
    },
    [DotDef.HeroJewel] = {
      listFunc = "getDotHeroJewel",
      unlock = L_SystemConst.enum.accessory
    },
    [DotDef.HeroInfo] = {
      listFunc = "getDotHeroInfo",
      unlock = L_SystemConst.enum.heroData
    },
    [DotDef.HeroPresent] = {
      listFunc = "getDotHeroPresent",
      unlock = L_SystemConst.enum.present
    },
    [DotDef.FriendApplication] = {
      getFunc = "getDotFriendApplication",
      unlock = L_SystemConst.enum.friend
    },
    [DotDef.FriendPrivateChat_Player] = {
      listFunc = "getDotFriendPrivateChat",
      unlock = L_SystemConst.enum.chat
    },
    [DotDef.FriendChannelTeamChat] = {
      getFunc = "getDotTeamChat",
      unlock = L_SystemConst.enum.chat
    },
    [DotDef.Mail] = {bindNodeName = "Mail"},
    [DotDef.SpecialShop] = {
      getFunc = "getDotSpecialShop",
      unlock = L_SystemConst.enum.specialShop
    },
    [DotDef.Achieve] = {
      getFunc = "getDotAchieve",
      unlock = L_SystemConst.enum.achievement
    },
    [DotDef.PlayerInfo] = {
      subNodes = {
        DotDef.Title,
        DotDef.PlayerHead
      }
    },
    [DotDef.HeroTalentAndJewelMenu] = {
      listFunc = "dotHeroTalentAndJewel",
      unlock = L_SystemConst.enum.accessory
    },
    [DotDef.HeroTalentAndJewelMenu] = {
      listFunc = "dotHeroHead",
      unlock = L_SystemConst.enum.accessory
    },
    [DotDef.Title] = {
      listFunc = "getDotTitle",
      unlock = L_SystemConst.enum.playerCard
    },
    [DotDef.TitlePre] = {
      getFunc = "getDotTitlePre"
    },
    [DotDef.TitleSuf] = {
      getFunc = "getDotTitleSuf"
    },
    [DotDef.PlayerHead] = {
      subNodes = {
        DotDef.PlayerHeadItem
      }
    },
    [DotDef.PlayerHead_head] = {
      getFunc = "getDotPlayerHeadMain"
    },
    [DotDef.PlayerHead_frame] = {
      getFunc = "getDotPlayerHeadFrame"
    },
    [DotDef.PlayerHeadItem] = {
      listFunc = "getDotPlayerHead"
    },
    [DotDef.Activity] = {
      subNodes = {
        DotDef.AllActivity
      }
    },
    [DotDef.AllActivity] = {
      subNodes = {
        DotDef.DairyActivity,
        DotDef.WeeklyActivity
      }
    },
    [DotDef.DairyActivity] = {
      getFunc = "getDairyDotActivity",
      unlock = L_SystemConst.enum.activation
    },
    [DotDef.WeeklyActivity] = {
      getFunc = "getWeeklyDotActivity",
      unlock = L_SystemConst.enum.activation
    },
    [DotDef.NoviceTask] = {
      getFunc = "getNoviceTaskDot",
      unlock = L_SystemConst.enum.noviceTask
    },
    [DotDef.GuideTaskManual] = {
      getFunc = "getNoviceGuideTaskDot",
      unlock = L_SystemConst.enum.noviceTask
    },
    [DotDef.DuelTaskManual] = {
      getFunc = "getNoviceDuelTaskDot",
      unlock = L_SystemConst.enum.noviceDuelTask
    },
    [DotDef.WorldExplore] = {
      listFunc = "getDotWorldExplore"
    },
    [DotDef.Pet] = {
      subNodes = {
        DotDef.PetNew,
        DotDef.PetGeneMutation
      }
    },
    [DotDef.PetNew] = {
      listFunc = "getDotPetNew",
      unlock = L_SystemConst.enum.pet
    },
    [DotDef.PetGeneMutation] = {
      listFunc = "getDotPetGeneMutation",
      unlock = L_SystemConst.enum.pet
    },
    [DotDef.PetRankUp] = {
      listFunc = "getPetRankUp",
      unlock = L_SystemConst.enum.pet
    },
    [DotDef.EntrustTrainEnter] = {
      subNodes = {
        DotDef.EntrustTrain
      }
    },
    [DotDef.EntrustTask] = {
      subNodes = {
        DotDef.EntrustTaskDifficulty
      }
    },
    [DotDef.EntrustTaskEnter] = {
      bindNodeName = "DungeonEntrustEntrance",
      subNodes = {
        DotDef.Abbys
      }
    },
    [DotDef.EntrustTaskDifficulty] = {
      listFunc = "getDotEntrustTaskDifficulty",
      unlock = L_SystemConst.enum.entrustTask
    },
    [DotDef.EntrustTrain] = {
      listFunc = "getDotEntrustTrain",
      unlock = L_SystemConst.enum.entrustTask
    },
    [DotDef.EntrustBattleTask] = {
      listFunc = "getDotEntrustBattleTask",
      unlock = L_SystemConst.enum.entrustTask
    },
    [DotDef.EntrustDoubleReward] = {
      getFunc = "getDotEntrustDoubleReward",
      unlock = L_SystemConst.enum.entrustTask
    },
    [DotDef.EntrustStarReward] = {
      getFunc = "getDotEntrustStarReward",
      unlock = L_SystemConst.enum.entrustTask
    },
    [DotDef.EntrustKiboDuelReward] = {
      getFunc = "getDotEntrustKiboDuelReward",
      unlock = L_SystemConst.enum.petDuelTask
    },
    [DotDef.EntrustMultiTaskDifficulty] = {
      listFunc = "getDotEntrustMultiTaskDifficulty",
      unlock = L_SystemConst.enum.multiTeamDungeon
    },
    [DotDef.Bag] = {
      subNodes = {},
      unlock = L_SystemConst.enum.bag
    },
    [DotDef.SpiritNew] = {
      listFunc = "getDotSpiritNew"
    },
    [DotDef.JewelNew] = {
      listFunc = "getDotJewelNew"
    },
    [DotDef.NewTutorialGuide] = {
      listFunc = "getDotNewTutorialGuide"
    },
    [DotDef.Home] = {
      subNodes = {
        DotDef.HomeScience
      }
    },
    [DotDef.HomeScience] = {
      bindNodeName = "HomeTechnology"
    },
    [DotDef.Announcement] = {
      subNodes = {
        DotDef.AnnouncementActive
      }
    },
    [DotDef.AnnouncementActive] = {
      listFunc = "getDotAnnouncementActive",
      unlock = L_SystemConst.enum.announcemenet
    },
    [DotDef.MainCityHomeTechLevelShow] = {
      subNodes = {
        DotDef.LevelUnlockHomeContent
      }
    },
    [DotDef.LevelUnlockHomeContent] = {
      listFunc = "getDotHomeLevelNew"
    },
    [DotDef.NewEmoji] = {
      listFunc = "getDotNewEmoji",
      unlock = L_SystemConst.enum.chat
    },
    [DotDef.NewEmojiType] = {
      listFunc = "getDotNewEmojiType",
      unlock = L_SystemConst.enum.chat
    },
    [DotDef.Mount] = {
      subNodes = {
        DotDef.MountNew
      }
    },
    [DotDef.MountNew] = {
      listFunc = "getDotMountNew",
      unlock = L_SystemConst.enum.mount
    },
    [DotDef.GameAct_ActCenter] = {
      subNodes = {
        DotDef.GameAct_New,
        DotDef.GameAct_EventsInCenter,
        DotDef.GameAct_Single_New,
        DotDef.GameAct_Events_Kibo_Travel,
        DotDef.GameAct_Events_Survey_New,
        DotDef.GameAct_Events_Survey_Award,
        DotDef.GameAct_Events_Redungeon,
        DotDef.GameAct_Events_PtShop,
        DotDef.GameAct_Scenario_PreTask
      }
    },
    [DotDef.GameAct_New] = {
      listFunc = "getDotGameActNew",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_Single_New] = {
      listFunc = "getDotGameSingleActNew",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_Events_Reward] = {
      listFunc = "GetDotGameActEventsReward",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_EventsInCenter] = {
      listFunc = "getDotGameActEventsInCenter",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_Events_Battle] = {
      listFunc = "getDotGameActEventsBattle",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_Reward_Tab] = {
      listFunc = "getDotGameActRewardTab",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_Events_Submit] = {
      listFunc = "getDotGameActRewardTab",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_Events_SubmitNew] = {
      getFunc = "getGameEventCommit",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_Events_PtShop] = {
      listFunc = "GetDotGameActEventsPtShop",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_Events_Group_Reward] = {
      listFunc = "getDotGameActRewardTabGroup",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_Events_Kibo_Battle] = {
      listFunc = "getDotGameActKiboBattle",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_Events_Kibo_Travel] = {
      listFunc = "getDotGameActKiboTravel",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_Events_Survey_New] = {
      listFunc = "getDotGameActSurveyNew",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_Events_Survey_Award] = {
      listFunc = "getDotGameActSurveyAward",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_Events_Redungeon] = {
      getFunc = "getDotGameActRedungeon",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.GameAct_Scenario_PreTask] = {
      listFunc = "getDotGameActScenarioPreTask",
      unlock = L_SystemConst.enum.gameAct
    },
    [DotDef.productionNew] = {
      listFunc = "getDotAllProduction",
      unlock = L_SystemConst.enum.product
    },
    [DotDef.kiBoDuelAreaLevel_Reward] = {
      listFunc = "getkiBoDuelAreaLevelReward",
      unlock = L_SystemConst.enum.kiboDuelAreaLevel
    },
    [DotDef.kiBoDuelAreaLevel] = {
      getFunc = "getkiBoDuelAreaLevel",
      unlock = L_SystemConst.enum.kiboDuelAreaLevel
    },
    [DotDef.Adventure_KiboDuelAreaLevel] = {
      getFunc = "getkiBoDuelAreaLevel",
      unlock = L_SystemConst.enum.kiboDuelAreaLevel
    },
    [DotDef.kiBoDuel_Skill] = {
      subNodes = {
        DotDef.kiBoDuel_Skill_New
      }
    },
    [DotDef.kiBoDuel_Skill_New] = {
      listFunc = "getkiBoDuelUnlockSkill"
    },
    [DotDef.KiboDuel_NPC_New] = {
      listFunc = "getKiboDuelNewNpc"
    },
    [DotDef.PetCatalog] = {
      getFunc = "getPetCatalogDot",
      unlock = L_SystemConst.enum.petCatalog
    },
    [DotDef.JourneyTaskMainMenu] = {
      subNodes = {
        DotDef.JourneyTask
      }
    },
    [DotDef.JourneyTask] = {
      getFunc = "getJourneyTaskDot",
      unlock = L_SystemConst.enum.journeyTask
    },
    [DotDef.JourneyTaskNew] = {
      getFunc = "getJourneyNewTaskDot",
      unlock = L_SystemConst.enum.journeyTask
    },
    [DotDef.FriendChatTipBubble] = {
      bindNodeName = "FriendChatTipBubble"
    },
    [DotDef.FriendChatTipBackground] = {
      bindNodeName = "FriendChatTipBackground"
    },
    [DotDef.HeroHead] = {
      bindNodeName = DotDef.HeroHead
    },
    [DotDef.KiboDuel_LevelGroup_New] = {
      listFunc = "getKiboDuelGroupNew",
      unlock = L_SystemConst.enum.petDuelTask
    },
    [DotDef.BattlePassLua] = {bindNodeName = "BattlePass"},
    [DotDef.BattlePassMainMenu] = {
      subNodes = {
        DotDef.BattlePassLua
      }
    },
    [DotDef.HandBook] = {
      subNodes = {}
    },
    [DotDef.HandBook_Character_New] = {
      getFunc = "getHandBookCharacterNew"
    },
    [DotDef.HandBook_Character_New_Item] = {
      listFunc = "getHandBookCharacterNewItem"
    },
    [DotDef.IllustratedSoulEssence_Enter] = {
      subNodes = {
        DotDef.IllustratedSoulEssence_New
      }
    },
    [DotDef.IllustratedSoulEssence_New] = {
      listFunc = "getDotIllustratedSoulEssenceNew",
      unlock = L_SystemConst.enum.handbook
    },
    [DotDef.Gacha] = {
      bindNodeName = DotDef.Gacha
    },
    [DotDef.Rogue] = {bindNodeName = "RogueEntry"},
    [DotDef.Shop] = {
      getFunc = "getShopRed",
      unlock = L_SystemConst.enum.shop
    },
    [DotDef.Abbys] = {bindNodeName = "Abbys"},
    [DotDef.Setting] = {bindNodeName = "Setting"}
  }
  local EventConf = {
    {
      key = DotDef.HeroNew,
      store = L_HeroStore,
      event = L_HeroStore.event.heroSync
    },
    {
      key = DotDef.HeroSkill,
      store = L_HeroStore,
      event = L_HeroStore.event.heroSync
    },
    {
      key = DotDef.HeroSkill,
      store = L_ReddotStore,
      event = L_ReddotStore.event.refreshBag
    },
    {
      key = DotDef.HeroSpirit,
      store = L_HeroStore,
      event = L_HeroStore.event.heroSync
    },
    {
      key = DotDef.HeroSpirit,
      store = L_ReddotStore,
      event = L_ReddotStore.event.soulessenceUpdate
    },
    {
      key = DotDef.HeroSpirit,
      store = C_IntegrateMgr.SystemUnlockModule,
      event = C_IntegrateMgr.SystemUnlockModule.onDataChange
    },
    {
      key = DotDef.HeroJewel,
      store = L_HeroStore,
      event = L_HeroStore.event.heroSync
    },
    {
      key = DotDef.HeroJewel,
      store = L_ReddotStore,
      event = L_ReddotStore.event.refreshAccessoryList
    },
    {
      key = DotDef.HeroInfo,
      store = L_TaskStore,
      event = L_TaskStore.event.taskRealFinished
    },
    {
      key = DotDef.HeroInfo,
      store = L_HeroStore,
      event = L_HeroStore.event.favorLvChange
    },
    {
      key = DotDef.HeroInfo,
      store = L_HeroStore,
      event = L_HeroStore.event.heroSync
    },
    {
      key = DotDef.HeroInfo,
      store = L_HeroStore,
      event = L_HeroStore.event.heroDataSync
    },
    {
      key = DotDef.HeroTalent,
      store = L_HeroStore,
      event = L_HeroStore.event.heroSync
    },
    {
      key = DotDef.HeroTalent,
      store = L_ReddotStore,
      event = L_ReddotStore.event.refreshBag
    },
    {
      key = DotDef.HeroTalent,
      store = L_PlayerStore,
      event = L_PlayerStore.event.syncAttrInfoComplete
    },
    {
      key = DotDef.HeroTalentAndJewelMenu,
      store = L_HeroStore,
      event = L_HeroStore.event.heroSync
    },
    {
      key = DotDef.HeroTalentAndJewelMenu,
      store = L_ReddotStore,
      event = L_ReddotStore.event.refreshBag
    },
    {
      key = DotDef.HeroTalentAndJewelMenu,
      store = L_FormationStore,
      event = L_FormationStore.event.formationTeamRefresh
    },
    {
      key = DotDef.HeroTalentAndJewelMenu,
      store = L_ReddotStore,
      event = L_ReddotStore.event.refreshAccessoryList
    },
    {
      key = DotDef.HeroTalentAndJewelMenu,
      store = L_PlayerStore,
      event = L_PlayerStore.event.syncAttrInfoComplete
    },
    {
      key = DotDef.FriendApplication,
      store = L_FriendStore,
      event = L_FriendStore.event.refreshIdList
    },
    {
      key = DotDef.WeeklyActivity,
      store = L_ActivityTaskStore,
      event = L_ActivityTaskStore.event.refreshActivityReddot
    },
    {
      key = DotDef.DairyActivity,
      store = L_ActivityTaskStore,
      event = L_ActivityTaskStore.event.refreshActivityReddot
    },
    {
      key = DotDef.NoviceTask,
      store = L_NoviceTaskStore,
      event = L_NoviceTaskStore.event.refreshNoviceTaskReddot
    },
    {
      key = DotDef.GuideTaskManual,
      store = L_NoviceTaskStore,
      event = L_NoviceTaskStore.event.refreshNoviceTaskReddot
    },
    {
      key = DotDef.DuelTaskManual,
      store = L_NoviceTaskStore,
      event = L_NoviceTaskStore.event.refreshNoviceTaskReddot
    },
    {
      key = DotDef.PetNew,
      store = L_PetStore,
      event = L_PetStore.event.refreshNewPet
    },
    {
      key = DotDef.PetGeneMutation,
      store = L_PetStore,
      event = L_PetStore.event.refreshPet
    },
    {
      key = DotDef.EntrustTaskDifficulty,
      store = L_EntrustStore,
      event = L_EntrustStore.event.entrustInfoRefresh
    },
    {
      key = DotDef.EntrustTaskDifficulty,
      store = L_EntrustStore,
      event = L_EntrustStore.event.entrustRewardRefresh
    },
    {
      key = DotDef.EntrustTrain,
      store = L_EntrustStore,
      event = L_EntrustStore.event.entrustTrainRefresh
    },
    {
      key = DotDef.EntrustStarReward,
      store = L_EntrustStore,
      event = L_EntrustStore.event.entrustInfoRefresh
    },
    {
      key = DotDef.EntrustStarReward,
      store = L_EntrustStore,
      event = L_EntrustStore.event.entrustRewardRefresh
    },
    {
      key = DotDef.EntrustMultiTaskDifficulty,
      store = L_EntrustStore,
      event = L_EntrustStore.event.entrustInfoRefresh
    },
    {
      key = DotDef.EntrustMultiTaskDifficulty,
      store = L_MultiDungeonStore,
      event = L_MultiDungeonStore.event.syncMultiDungeonInfo
    },
    {
      key = DotDef.EntrustDoubleReward,
      store = L_GameEventStore,
      event = L_GameEventStore.event.gameEventSync
    },
    {
      key = DotDef.EntrustKiboDuelReward,
      store = L_EntrustStore,
      event = L_EntrustStore.event.entrustKiboInfoRefresh
    },
    {
      key = DotDef.EntrustKiboDuelReward,
      store = L_EntrustStore,
      event = L_EntrustStore.event.entrustRewardRefresh
    },
    {
      key = DotDef.PetRankUp,
      store = L_PetStore,
      event = L_PetStore.event.refreshPet
    },
    {
      key = DotDef.PetRankUp,
      store = L_ReddotStore,
      event = L_ReddotStore.event.refreshBag
    },
    {
      key = DotDef.PetRankUp,
      store = L_PlayerStore,
      event = L_PlayerStore.event.refreshAttr
    },
    {
      key = DotDef.SpiritNew,
      store = L_ReddotStore,
      event = L_ReddotStore.event.soulessenceUpdate
    },
    {
      key = DotDef.JewelNew,
      store = L_ReddotStore,
      event = L_ReddotStore.event.refreshAccessoryList
    },
    {
      key = DotDef.Mail,
      store = L_MailStore,
      event = L_MailStore.event.refreshMailRedInfo
    },
    {
      key = DotDef.WorldExplore,
      store = L_ReddotStore,
      event = L_ReddotStore.event.reddotUpdate
    },
    {
      key = DotDef.AnnouncementActive,
      store = L_AnnouncementStore,
      event = L_AnnouncementStore.event.refreshAnnouncementRedDot
    },
    {
      key = DotDef.LevelUnlockHomeContent,
      store = L_PlayerStore,
      event = L_PlayerStore.event.refreshBaseInfo
    },
    {
      key = DotDef.NewTutorialGuide,
      store = L_GuideStore,
      event = L_GuideStore.event.onUpdate
    },
    {
      key = DotDef.NewEmoji,
      store = L_ChatStore,
      event = L_ChatStore.event.refreshEmojiInfo
    },
    {
      key = DotDef.NewEmoji,
      store = L_ChatStore,
      event = L_ChatStore.event.refreshEmojiRedDot
    },
    {
      key = DotDef.NewEmojiType,
      store = L_ChatStore,
      event = L_ChatStore.event.refreshEmojiInfo
    },
    {
      key = DotDef.NewEmojiType,
      store = L_ChatStore,
      event = L_ChatStore.event.refreshEmojiRedDot
    },
    {
      key = DotDef.MountNew,
      store = L_MountStore,
      event = L_MountStore.event.unlockMountRide
    },
    {
      key = DotDef.GameAct_New,
      store = L_GameEventStore,
      event = L_GameEventStore.event.gameEventSync
    },
    {
      key = DotDef.GameAct_EventsInCenter,
      store = L_GameEventStore,
      event = L_GameEventStore.event.gameEventSync
    },
    {
      key = DotDef.GameAct_Single_New,
      store = L_GameEventStore,
      event = L_GameEventStore.event.gameEventRedDot
    },
    {
      key = DotDef.GameAct_Scenario_PreTask,
      store = L_GameEventStore,
      event = L_GameEventStore.event.gameEventSync
    },
    {
      key = DotDef.PlayerHead_head,
      store = L_PlayerDisplayStore,
      event = L_PlayerDisplayStore.event.dressItemSync
    },
    {
      key = DotDef.PlayerHead_frame,
      store = L_PlayerDisplayStore,
      event = L_PlayerDisplayStore.event.dressItemSync
    },
    {
      key = DotDef.kiBoDuelAreaLevel_Reward,
      store = L_PetDuelStore,
      event = L_PetDuelStore.event.refresh_areaInfo
    },
    {
      key = DotDef.kiBoDuelAreaLevel,
      store = L_PetDuelStore,
      event = L_PetDuelStore.event.refresh_areaInfo
    },
    {
      key = DotDef.Adventure_KiboDuelAreaLevel,
      store = L_PetDuelStore,
      event = L_PetDuelStore.event.refresh_areaInfo
    },
    {
      key = DotDef.kiBoDuel_Skill_New,
      store = L_PetDuelStore,
      event = L_PetDuelStore.event.refresh_unlockSkill
    },
    {
      key = DotDef.KiboDuel_NPC_New,
      store = L_PetDuelStore,
      event = L_PetDuelStore.event.areaLevel_changed
    },
    {
      key = DotDef.IllustratedSoulEssence_New,
      store = L_ReddotStore,
      event = L_ReddotStore.event.soulessenceUpdate
    },
    {
      key = DotDef.Shop,
      store = L_PlayerStore,
      event = L_PlayerStore.event.refreshAttr
    }
  }
  self.DotConf = DotConf
  self.EventConf = EventConf
end

this.DotDef = DotDef
return this
