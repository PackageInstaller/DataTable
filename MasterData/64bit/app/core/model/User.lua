local User = class("User")
local Loader = require("app.core.utils.Loader")
local ErrorMessage = require("app.core.model.ErrorMessage")
local var_0_3 = g.core.config.role_info

function User:ctor()
	self._dataList = {}

	self:_initPrivateData()
	self:_initData()
end

function User:_initPrivateData()
	self._id = 0
	self._name = 0
	self._guideFastName = nil
	self._level = 1
	self._gold = 0
	self._vipLevel = 0
	self._fightValue = 0
	self._guildId = 0
	self._baseId = 0
	self._avataId = 0
	self._dressId = 0
	self._guideId = 0
	self._showId = 0
	self._createTime = 0
	self._sendCount = 0
	self._usedSceneId = 0
	self._assistantId = 0
	self._assistantDressId = 0
	self._nominateList = {}
	self._specialShowPlayed = {}
	self._free_gold = 0
	self._levelUp = false
	self._oldLevel = 0
	self._newLevel = 0
	self._headFrameIdDic = {}
	self._headIdDic = {}
	self._frameId = 0
	self._chatPropId = 0
	self._chatPropIdDic = {}
	self._savedLevel = 0
	self._changeFightValue = 0
	self._birthDay = ""
	self._birthdayTime = 0
	self._birthdaySetTimes = 0
	self._puzzleGameLevel = -1
	self._platUserId = 0
	self._allianceId = 0
	self._allianceName = ""
	self._isTips = {}
	self._serverCfg = nil

	self:_initGuideName()
end

function User:_initData()
	self._dataList = {
		{
			name = "resourceData",
			path = "app.view.common.model.ResourceData"
		},
		{
			name = "redPointData",
			path = "app.view.base.redPoint.model.RedPointData"
		},
		{
			name = "redPointRefreshCache",
			path = "app.view.base.redPoint.model.RedPointRefreshCache"
		},
		{
			name = "fragmentsData",
			path = "app.view.common.model.FragmentsData"
		},
		{
			name = "itemsData",
			path = "app.view.common.model.ItemsData"
		},
		{
			name = "bagData",
			path = "app.view.module.knightBag.model.BagData"
		},
		{
			name = "knightsData",
			path = "app.view.module.knight.model.KnightsData"
		},
		{
			name = "recruitData",
			path = "app.view.module.recruit.model.RecruitData"
		},
		{
			name = "rebornData",
			path = "app.view.module.reborn.model.RebornData"
		},
		{
			name = "wushData",
			path = "app.view.module.wush.model.WushData"
		},
		{
			name = "equipmentData",
			path = "app.view.module.equipAndTreasure.model.EquipmentData"
		},
		{
			name = "kingdomDataNew",
			path = "app.view.module.kingdom.model.KingdomData"
		},
		{
			name = "formationData",
			path = "app.view.module.lineUp.model.FormationData"
		},
		{
			name = "uniteTokenData",
			path = "app.view.module.uniteToken.model.UniteTokenData"
		},
		{
			name = "treasureData",
			path = "app.view.module.equipAndTreasure.model.TreasureData"
		},
		{
			name = "artifactData",
			path = "app.view.module.artifact.model.ArtifactData"
		},
		{
			name = "petsData",
			path = "app.view.module.pet.model.PetsData"
		},
		{
			name = "petHandBookData",
			path = "app.view.module.petHandbook.model.PetHandBookData"
		},
		{
			name = "petEquipData",
			path = "app.view.module.petEquip.model.PetEquipData"
		},
		{
			name = "incarnationData",
			path = "app.view.module.incarnation.model.IncarnationData"
		},
		{
			name = "wingData",
			path = "app.view.module.wing.model.WingData"
		},
		{
			name = "dungeonData",
			path = "app.view.module.dungeon.model.DungeonData"
		},
		{
			name = "bioData",
			path = "app.view.module.biography.model.BioData"
		},
		{
			name = "hlTrainData",
			path = "app.view.module.homeLandTrain.model.HLTrainData"
		},
		{
			name = "mailData",
			path = "app.view.module.mail.model.MailsData"
		},
		{
			name = "guildData",
			path = "app.view.module.guild.model.GuildData"
		},
		{
			name = "guildStatueData",
			path = "app.view.module.guildStatue.model.GuildStatueData"
		},
		{
			name = "shopData",
			path = "app.view.module.shop.model.ShopData"
		},
		{
			name = "shopFlushData",
			path = "app.view.module.shop.model.ShopFlushData"
		},
		{
			name = "cityData",
			path = "app.view.module.city.model.CityData"
		},
		{
			name = "activityDataManager",
			path = "app.view.module.activity.model.ActivityDataManager"
		},
		{
			name = "activityCollectData",
			path = "app.view.module.activity.model.ActivityCollectData"
		},
		{
			name = "dailyRechargeData",
			path = "app.view.module.activity.model.DailyRechargeData"
		},
		{
			name = "SignInData",
			path = "app.view.module.signIn.model.SignInData"
		},
		{
			name = "activityExchangeData",
			path = "app.view.module.activity.model.ActivityExchangeData"
		},
		{
			name = "activityMultiRechargeData",
			path = "app.view.module.activity.model.ActivityMultiRechargeData"
		},
		{
			name = "activityTaskData",
			path = "app.view.module.activity.model.ActivityTaskData"
		},
		{
			name = "sevenDaysData",
			path = "app.view.module.sevenDays.model.SevenDaysData"
		},
		{
			name = "guideTaskData",
			path = "app.view.module.guideTask.model.GuideTaskData"
		},
		{
			name = "dailyTaskData",
			path = "app.view.module.dailyTask.model.DailyTaskData"
		},
		{
			name = "rechargeData",
			path = "app.view.module.recharge.model.RechargeData"
		},
		{
			name = "rechargeGuideData",
			path = "app.view.module.recharge.model.RechargeGuideData"
		},
		{
			name = "firstChargeData",
			path = "app.view.module.firstCharge.model.FirstChargeData"
		},
		{
			name = "godboxData",
			path = "app.view.module.godbox.model.GodboxData"
		},
		{
			name = "storyData",
			path = "app.view.module.story.model.StoryData"
		},
		{
			name = "chatData",
			path = "app.view.module.chat.model.ChatData"
		},
		{
			name = "stormCityData",
			path = "app.view.module.storm.model.StormCityData"
		},
		{
			name = "stormData",
			path = "app.view.module.storm.model.StormData"
		},
		{
			name = "onlineGiftData",
			path = "app.view.module.activity.model.ActivityOnlineGiftData"
		},
		{
			name = "rebelData",
			path = "app.view.module.rebel.model.RebelData"
		},
		{
			name = "functionUnlockData",
			path = "app.view.common.model.FunctionUnlockData"
		},
		{
			name = "nightMareData",
			path = "app.view.common.model.NightMareData"
		},
		{
			name = "playerData",
			path = "app.view.common.model.PlayerData"
		},
		{
			name = "flushInfoData",
			path = "app.view.common.model.FlushInfoData"
		},
		{
			name = "guildBossData",
			path = "app.view.module.guild.model.GuildBossData"
		},
		{
			name = "friendData",
			path = "app.view.module.friend.model.FriendData"
		},
		{
			name = "dailyDungeonData",
			path = "app.view.module.dailyDungeon.model.DailyDungeonData"
		},
		{
			name = "handBookData",
			path = "app.view.module.handbook.model.HandBookData"
		},
		{
			name = "hallOfFameData",
			path = "app.view.module.hallOfFame.model.HallOfFameData"
		},
		{
			name = "sevenDaysSignInData",
			path = "app.view.module.sevenDaysSignIn.model.SevenDaysSignInData"
		},
		{
			name = "AuctionData",
			path = "app.view.module.auction.model.AuctionData"
		},
		{
			name = "ShareData",
			path = "app.view.module.share.model.ShareData"
		},
		{
			name = "activityDailyBoxData",
			path = "app.view.module.activity.model.ActivityDailyBoxData"
		},
		{
			name = "artifactHandBookData",
			path = "app.view.module.artifactHandBook.model.ArtifactHandBookData"
		},
		{
			name = "mineData",
			path = "app.view.module.mine.model.MineData"
		},
		{
			name = "battleResultData",
			path = "app.view.module.battleResult.model.BattleResultData"
		},
		{
			name = "ableFragmentData",
			path = "app.view.base.infoPop.model.AbleFragmentData"
		},
		{
			name = "commanderWorldData",
			path = "app.view.module.commanderWorld.model.CommanderWorldData"
		},
		{
			name = "privilegeData",
			path = "app.view.common.model.PrivilegeData"
		},
		{
			name = "arenaData",
			path = "app.view.module.arena.model.ArenaData"
		},
		{
			name = "peakArenaData",
			path = "app.view.module.peakArena.model.PeakArenaBaseData"
		},
		{
			name = "taskData",
			path = "app.view.module.task.model.TaskData"
		},
		{
			name = "knightFavoData",
			path = "app.view.module.knightFavorability.model.KnightFavoData"
		},
		{
			name = "warriorsOfFateData",
			path = "app.view.module.warriorsOfFate.model.WarriorsOfFateData"
		},
		{
			name = "plotReplayReviewData",
			path = "app.view.module.plotReplay.model.PlotReplayReviewData"
		},
		{
			name = "knightTissueData",
			path = "app.view.module.knightTissue.model.KnightTissueData"
		},
		{
			name = "illustrationData",
			path = "app.view.module.illustration.model.IllustrationData"
		},
		{
			name = "CampaignData",
			path = "app.view.module.campaign.model.CampaignData"
		},
		{
			name = "guildCampaignData",
			path = "app.view.module.guildCampaign.model.GuildCampaignData"
		},
		{
			name = "robTreasureData",
			path = "app.view.module.robTreasure.model.RobTreasureData"
		},
		{
			name = "skinData",
			path = "app.view.module.skin.model.SkinData"
		},
		{
			name = "redPacketData",
			path = "app.view.module.redPacket.model.RedPacketData"
		},
		{
			name = "guildWorshipData",
			path = "app.view.module.guild.model.GuildWorshipData"
		},
		{
			name = "accountAutheData",
			path = "app.view.module.user.model.AccountAutheData"
		},
		{
			name = "bindPhoneData",
			path = "app.view.module.user.model.BindPhoneData"
		},
		{
			name = "furnitureData",
			path = "app.view.module.furniture.model.FurnitureData"
		},
		{
			name = "guildDungeonData",
			path = "app.view.module.guildDungeon.model.GuildDungeonData"
		},
		{
			name = "achievementData",
			path = "app.view.module.achievement.model.AchievementData"
		},
		{
			name = "activityMonthCardData",
			path = "app.view.module.recharge.model.ActivityMonthCardData"
		},
		{
			name = "UserTitleData",
			path = "app.view.module.user.model.UserTitleData"
		},
		{
			name = "userAvatarFrameData",
			path = "app.view.module.user.model.UserAvatarFrameData"
		},
		{
			name = "GuildFightData",
			path = "app.view.module.guildFight.model.GuildFightData"
		},
		{
			name = "puzzleData",
			path = "app.view.module.puzzle.game.model.PuzzleData"
		},
		{
			name = "activityLevelUpData",
			path = "app.view.module.activity.model.ActivityLevelUpData"
		},
		{
			name = "activityMainLayerData",
			path = "app.view.module.activity.model.ActivityMainLayerData"
		},
		{
			name = "activityGetStaminaData",
			path = "app.view.module.activity.model.ActivityGetStaminaData"
		},
		{
			name = "homeInfoRemindData",
			path = "app.view.module.home.model.HomeInfoRemindData"
		},
		{
			name = "homeInfoRemindRewardData",
			path = "app.view.module.home.model.HomeInfoRemindRewardData"
		},
		{
			name = "homeInfoRemindTaskTimesData",
			path = "app.view.module.home.model.HomeInfoRemindTaskTimesData"
		},
		{
			name = "homeInfoRemindOthersData",
			path = "app.view.module.home.model.HomeInfoRemindOthersData"
		},
		{
			name = "homeData",
			path = "app.view.module.home.model.HomeData"
		},
		{
			name = "questionnaireData",
			path = "app.view.module.questionnaire.model.QuestionnaireData"
		},
		{
			name = "giftData",
			path = "app.view.module.recharge.model.GiftData"
		},
		{
			name = "skinGoodsData",
			path = "app.view.module.recharge.model.SkinGoodsData"
		},
		{
			name = "hotSaleData",
			path = "app.view.module.recharge.model.HotSaleData"
		},
		{
			name = "totalRechargeData",
			path = "app.view.module.totalRecharge.model.TotalRechargeData"
		},
		{
			name = "gmTotalRechargeData",
			path = "app.view.module.gmTotalRecharge.model.GmTotalRechargeData"
		},
		{
			name = "firstRechargeData",
			path = "app.view.module.firstRecharge.model.FirstRechargeData"
		},
		{
			name = "passCardData",
			path = "app.view.module.passCard.model.PassCardData"
		},
		{
			name = "pushGiftData",
			path = "app.view.module.pushGift.model.PushGiftData"
		},
		{
			name = "themeData",
			path = "app.view.module.summerTheme.model.ThemeDataMgr"
		},
		{
			name = "guideData",
			path = "app.view.module.guide.model.GuideData"
		},
		{
			name = "translateData",
			path = "app.core.translate.TranslateData"
		},
		{
			name = "towerData",
			path = "app.view.module.tower.model.TowerData"
		},
		{
			name = "towerHardData",
			path = "app.view.module.tower.model.TowerHardData"
		},
		{
			name = "activityFundData",
			path = "app.view.module.activity.model.ActivityFundData"
		},
		{
			name = "annoData",
			path = "app.view.module.announcement.model.AnnoData"
		},
		{
			name = "gameEntertainmentData",
			path = "app.view.module.gameEntertainment.model.GameEntertainmentData"
		},
		{
			name = "openScreenData",
			path = "app.view.module.openscreen.model.OpenScreenData"
		},
		{
			name = "playerInfoData",
			path = "app.view.module.playerInfo.model.PlayerInfoData"
		},
		{
			name = "userActiveSceneData",
			path = "app.view.module.user.model.UserActiveSceneData"
		},
		{
			name = "dailyReportData",
			path = "app.view.module.dailyReport.model.DailyReportData"
		},
		{
			name = "furnitureHandBookData",
			path = "app.view.module.furnitureHandBook.model.FurnitureHandBookData"
		},
		{
			name = "easterEggData",
			path = "app.view.module.easterEgg.model.EasterEggData"
		},
		{
			name = "signActivityData",
			path = "app.view.module.signActivity.model.SignActivityData"
		},
		{
			name = "guildWarData",
			path = "app.view.module.guildWar.model.GuildWarData"
		},
		{
			name = "activityInviteFriendData",
			path = "app.view.module.activity.model.ActivityInviteFriendData"
		},
		{
			name = "goldSavingData",
			path = "app.view.module.goldSaving.model.GoldSavingData"
		},
		{
			name = "h5ActivityData",
			path = "app.view.module.H5Activity.model.H5ActivityData"
		},
		{
			name = "newYearWishData",
			path = "app.view.module.newYearWish.model.NewYearWishData"
		},
		{
			name = "userBackData",
			path = "app.view.module.userBack.model.UserBackData"
		},
		{
			name = "fogNightmareData",
			path = "app.view.module.fogNightmare.model.data.FogNightmareData"
		},
		{
			name = "valentinesDayVoteData",
			path = "app.view.module.valentinesDayVote.model.data.ValentinesDayVoteData"
		},
		{
			name = "gveDataMgr",
			path = "app.view.module.gve.model.GveDataMgr"
		},
		{
			name = "themeBioData",
			path = "app.view.module.themeBio.model.ThemeBioData"
		},
		{
			name = "activityMonthGachaData",
			path = "app.view.module.activity.model.ActivityMonthGachaData"
		},
		{
			name = "activityPermanentRechargeData",
			path = "app.view.module.activity.model.ActivityPermanentRechargeData"
		},
		{
			name = "halfAnniversaryData",
			path = "app.view.module.halfAnniversary.model.HalfAnniversaryData"
		},
		{
			name = "mulFormationData",
			path = "app.view.module.lineUp.model.MulFormationData"
		},
		{
			name = "wushTowerData",
			path = "app.view.module.wushTower.model.WushTowerData"
		},
		{
			name = "userFestivalData",
			path = "app.view.module.user.model.UserFestivalData"
		},
		{
			name = "echoLabData",
			path = "app.view.module.echoLab.model.EchoLabData"
		},
		{
			name = "activityWishpoolData",
			path = "app.view.module.activity.model.ActivityWishpoolData"
		},
		{
			name = "spiritHelpData",
			path = "app.view.module.spiritHelp.model.SpiritHelpData"
		},
		{
			name = "competitionData",
			path = "app.view.module.competition.model.CompetitionData"
		},
		{
			name = "worldRedPacketData",
			path = "app.view.module.worldRedPacket.model.WorldRedPacketData"
		},
		{
			name = "crossServerArenaData",
			path = "app.view.module.crossServerArena.model.CrossServerArenaData"
		},
		{
			name = "geneData",
			path = "app.view.module.gene.model.GeneData"
		},
		{
			name = "redPacketRainData",
			path = "app.view.module.goldSaving.model.RedPacketRainData"
		},
		{
			name = "commanderWorldData",
			path = "app.view.module.commanderWorld.model.CommanderWorldData"
		},
		{
			name = "refundData",
			path = "app.view.module.refund.model.RefundData"
		},
		{
			name = "activityLifeTimeCardData",
			path = "app.view.module.activity.model.ActivityLifeTimeCardData"
		},
		{
			name = "phoenixGiftData",
			path = "app.view.module.phoenixGift.model.PhoenixGiftData"
		},
		{
			name = "commonCompetitionDataManager",
			path = "app.view.module.competition.common.model.CommonCompetitionDataManager"
		},
		{
			name = "hotSaleGMGiftData",
			path = "app.view.module.pushGift.model.HotSaleGMGiftData"
		},
		{
			name = "activityTapWelfareData",
			path = "app.view.module.activity.model.ActivityTapWelfareData"
		},
		{
			name = "activityBlackFiveData",
			path = "app.view.module.activity.model.ActivityBlackFiveData"
		},
		{
			name = "resouceBackData",
			path = "app.view.module.activity.model.ActivityResouceBackData"
		},
		{
			name = "doubleElevenData",
			path = "app.view.module.doubleEleven.model.DoubleElevenData"
		},
		{
			name = "knightSoulData",
			path = "app.view.module.knightSoul.model.KnightSoulData"
		},
		{
			name = "lotteryData",
			path = "app.view.module.lottery.model.LotteryData"
		},
		{
			name = "weeklyCompetitionMgrData",
			path = "app.view.module.weeklyCompetition.model.WeeklyCompetitionMgrData"
		},
		{
			name = "teamPvpData",
			path = "app.view.module.teamPVP.model.TeamPVPData"
		},
		{
			name = "explorationData",
			path = "app.view.module.exploration.model.ExplorationData"
		},
		{
			name = "redCliffData",
			path = "app.view.module.redCliff.model.RedCliffData"
		},
		{
			name = "preciousData",
			path = "app.view.module.precious.model.PreciousData"
		},
		{
			name = "cultivateDataMgr",
			path = "app.view.module.cultivate.model.CultivateDataMgr"
		},
		{
			name = "bountyData",
			path = "app.view.module.bounty.model.BountyData"
		},
		{
			name = "gmFundData",
			path = "app.view.module.newFund.model.GmFundData"
		},
		{
			name = "gmPassCardData",
			path = "app.view.module.newPassCard.model.GmPassCardData"
		},
		{
			name = "commonPassCardDataMgr",
			path = "app.view.module.commonPassCard.model.CommonPassCardDataMgr"
		},
		{
			name = "commonPassCardData",
			path = "app.view.module.commonPassCard.model.CommonPassCardData"
		},
		{
			name = "mysteryData",
			path = "app.view.module.mystery.model.MysteryData"
		},
		{
			name = "mysteryBossData",
			path = "app.view.module.mystery.model.MysteryBossData"
		},
		{
			name = "weddingData",
			path = "app.view.module.wedding.model.WeddingData"
		},
		{
			name = "summonOldPlayerData",
			path = "app.view.module.summonOldPlayer.model.SummonOldPlayerData"
		},
		{
			name = "snapShotCacheData",
			path = "app.view.base.snapShotCache.model.SnapShotCacheData"
		},
		{
			name = "activityReturnData",
			path = "app.view.module.activityReturn.model.ActivityReturnData"
		},
		{
			name = "richmanData",
			path = "app.view.module.richman.model.RichmanData"
		},
		{
			name = "treeData",
			path = "app.view.module.tree.model.TreeData"
		},
		{
			name = "teamBattleData",
			path = "app.view.module.teamBattle.model.TeamBattleData"
		},
		{
			name = "activityCelebrationLoginData",
			path = "app.view.module.activity.model.ActivityCelebrationLoginData"
		},
		{
			name = "allianceData",
			path = "app.view.module.alliance.model.AllianceData"
		},
		{
			name = "newSlgData",
			path = "app.view.module.slg.model.NewSlgBaseData"
		},
		{
			name = "newSlgDevelopData",
			path = "app.view.module.slg.model.NewSlgDevelopData"
		},
		{
			name = "newSlgSkillTreeData",
			path = "app.view.module.slg.model.NewSlgSkillTreeData"
		},
		{
			name = "retroData",
			path = "app.view.module.retro.model.RetroData"
		},
		{
			name = "areaMergeData",
			path = "app.view.module.areaMerge.model.AreaMergeData"
		},
		{
			name = "activityOtherReturnPayData",
			path = "app.view.module.activity.model.ActivityOtherReturnPayData"
		},
		{
			name = "allianceTrialData",
			path = "app.view.module.allianceTrial.model.AllianceTrialData"
		},
		{
			name = "roleSkinData",
			path = "app.view.module.roleSkin.model.RoleSkinData"
		},
		{
			name = "recycleCultivateData",
			path = "app.view.module.recycleCultivate.model.RecycleCultivateData"
		},
		{
			name = "weddingActivityData",
			path = "app.view.module.weddingActivity.model.WeddingActivityData"
		},
		{
			name = "pubgData",
			path = "app.view.module.pubg.model.PubgData"
		},
		{
			name = "succubaData",
			path = "app.view.module.succuba.model.SuccubaData"
		},
		{
			name = "monopolyDataMgr",
			path = "app.view.module.monopoly.model.MonopolyDataMgr"
		},
		{
			name = "abvertPageAwardData",
			path = "app.view.module.abvertPageAward.model.AbvertPageAwardData"
		},
		{
			name = "waitGameData",
			path = "upgrade.waitGame.model.WaitGameData"
		},
		{
			name = "blazingArenaData",
			path = "app.view.module.blazingArena.model.BlazingArenaData"
		},
		{
			name = "succubaLaunchData",
			path = "app.view.module.succubaLaunch.model.SuccubaLaunchData"
		},
		{
			name = "anniversaryData",
			path = "app.view.module.anniversary.model.AnniversaryData"
		},
		{
			name = "spireData",
			path = "app.view.module.spire.model.SpireData"
		},
		{
			name = "splitDownloadData",
			path = "app.view.module.splitDownload.model.SplitDownloadData"
		},
		{
			name = "elderBossData",
			path = "app.view.module.elderBoss.model.ElderBossData"
		},
		{
			name = "outpostData",
			path = "app.view.module.outpost.model.OutpostData"
		},
		{
			name = "releaseActivityData",
			path = "app.view.module.release.model.ReleaseActivityData"
		},
		{
			name = "domainData",
			path = "app.view.module.domain.model.DomainData"
		},
		{
			name = "serverPassActivityData",
			path = "app.view.module.serverPassActivity.model.ServerPassActivityData"
		},
		{
			name = "ancientsData",
			path = "app.view.module.ancients.model.AncientsData"
		},
		{
			name = "vipLinkData",
			path = "app.view.module.vipLink.model.VipLinkData"
		}
	}
	self.dayNotifyTool = Loader.dynamic("app.view.common.DayNotifyTool")

	for iter_3_0 = 1, #self._dataList do
		self[self._dataList[iter_3_0].name] = Loader.dynamic(self._dataList[iter_3_0].path)
	end
end

function User:delayLoadData(arg_4_1, arg_4_2)
	if not self[arg_4_1] then
		table.insert(self._dataList, {
			name = arg_4_1,
			path = arg_4_2
		})

		self[arg_4_1] = Loader.dynamic(arg_4_2)
	end
end

function User:resetData()
	self:_initPrivateData()

	for iter_5_0 = 1, #self._dataList do
		self[self._dataList[iter_5_0].name]:resetInstance()
	end

	dump("------------ User resetData end ------------")
end

function User:initDataOneByOne()
	self._curIndex = self._curIndex or 1
	self._mem = self._mem or g.core.utils.Tools.printCurMemery(self._curIndex)

	if self._curIndex > #self._dataList then
		dump("initDataOneByOne end")

		return
	end

	local var_6_0 = self._dataList[self._curIndex].name

	collectgarbage("collect")

	if self[var_6_0] and type(self[var_6_0].initData) == "function" then
		self[var_6_0]:initData()

		for iter_6_0, iter_6_1 in pairs(self[var_6_0]) do
			if type(iter_6_1) == "function" then
				dump(var_6_0 .. " " .. iter_6_0)
				self[var_6_0][iter_6_0](self[var_6_0])
			end
		end

		local var_6_1 = g.core.utils.Tools.printCurMemery(self._curIndex)

		dump(var_6_0 .. " " .. var_6_1 - self._mem)

		self._mem = var_6_1
	end

	self._curIndex = self._curIndex + 1
end

function User:clearData()
	for iter_7_0 = 1, #self._dataList do
		if self[self._dataList[iter_7_0].name] then
			setmetatable(self[self._dataList[iter_7_0].name], {})
		end
	end
end

function User:updateData(arg_8_1)
	self.isLevelChange = false

	if self._level ~= 0 and self._level ~= arg_8_1.level then
		self.isLevelChange = true
	end

	local var_8_0 = self._fightValue

	self._data = arg_8_1
	self._id = arg_8_1.id
	self._name = arg_8_1.name
	self._level = arg_8_1.level
	self._difGold = arg_8_1.gold - self._gold
	self._gold = arg_8_1.gold
	self._vipLevel = arg_8_1.vip_level
	self._fightValue = arg_8_1.fight_value
	self._guildId = arg_8_1.guild_id
	self._guildName = arg_8_1.guild_name
	self._baseId = arg_8_1.base_id
	self._avataId = arg_8_1.avata_id
	self._dressId = arg_8_1.dress_id
	self._frameId = arg_8_1.frame_id
	self._guideId = arg_8_1.guide_id
	self._showId = arg_8_1.show_id
	self._createTime = arg_8_1.create_time
	self._sendCount = arg_8_1.guild_send_count
	self._stormCityLord = arg_8_1.storm_city_lord
	self._free_gold = arg_8_1.gold_gift or 0

	if arg_8_1.show_knight_id then
		self._assistantId = arg_8_1.show_knight_id or 0
	end

	self._assistantDressId = arg_8_1.show_knight_dress or 0
	self._birthDay = arg_8_1.birthday or ""
	self._allianceId = arg_8_1.alliance_id
	self._allianceName = arg_8_1.alliance_name

	g.core.model.User.roleSkinData:updateWearData(arg_8_1.skin_part or {})

	if self._birthDay ~= "" then
		local var_8_1 = string.split(self._birthDay, "-")

		self._birthDay = string.format("%02d%02d", tonumber(var_8_1[1]), tonumber(var_8_1[2]))
	end

	self._birthdayTime = arg_8_1.birthday_time
	self._birthdaySetTimes = self._birthDay == "" and 0 or self._birthdayTime == 0 and 1 or 2

	if self._assistantId == 0 then
		self._assistantId = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.ASSISTANT_KNIGHT_ID).parameter
	end

	self:updateTitle(arg_8_1)
	self:setFlushFlag()
	ErrorMessage:setUserId(arg_8_1.id)
	g.core.platform.PlatformProxy:sendAdvVip()

	if arg_8_1.level > self._savedLevel and self._savedLevel > 0 then
		self._savedLevel = arg_8_1.level

		g.core.platform.PlatformProxy:levelUp()
	end

	if self._savedLevel == 0 then
		self._savedLevel = arg_8_1.level
	end

	if var_8_0 ~= 0 and var_8_0 ~= self._fightValue and g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.POWER_CHANGE_FEEDBACK) then
		self._changeFightValue = self._fightValue - var_8_0 > 20 and self._fightValue - var_8_0 or 0
	end

	self:setGuideFastName(self._name)
end

function User:updateWithLevelChange()
	if self.isLevelChange then
		g.core.model.User.goldSavingData:checkGoldSavingShow()
		g.core.service.ServiceManager:getServiceByName("LoopService"):addToLoopFuncList((handler(self.giftData, self.giftData.refreshInTime)))
		g.core.model.User.homeData:setNeedUpdateBanner(true)
		g.core.model.User.succubaLaunchData:checkSuccubaLaunchShow()

		self.isLevelChange = false
	end
end

function User:getChangeFightValue()
	self._changeFightValue = 0

	return self._changeFightValue
end

function User:setFlushFlag()
	if self._difGold ~= 0 then
		g.core.model.User.bagData:setFlushFlag()
	end
end

function User:updatePropFrame(arg_12_1)
	if not arg_12_1 then
		return
	end

	if arg_12_1.ids then
		for iter_12_0, iter_12_1 in ipairs(arg_12_1.ids) do
			self._headFrameIdDic[iter_12_1] = {
				expired_time = 0,
				id = iter_12_1
			}
		end
	end

	if arg_12_1.avata_ids then
		for iter_12_2, iter_12_3 in ipairs(arg_12_1.avata_ids) do
			self._headIdDic[iter_12_3] = {
				expired_time = 0,
				id = iter_12_3
			}
		end
	end

	if arg_12_1.limit_frames then
		for iter_12_4, iter_12_5 in ipairs(arg_12_1.limit_frames) do
			self._headFrameIdDic[iter_12_5.frame_id] = {
				id = iter_12_5.frame_id,
				expired_time = iter_12_5.expired_time
			}
		end
	end

	if arg_12_1.limit_avatas then
		for iter_12_6, iter_12_7 in ipairs(arg_12_1.limit_avatas) do
			self._headIdDic[iter_12_7.avata_id] = {
				id = iter_12_7.avata_id,
				expired_time = iter_12_7.expired_time
			}
		end
	end
end

function User:updatePropChat(arg_13_1)
	if not arg_13_1 then
		return
	end

	if arg_13_1.id then
		self._chatPropId = arg_13_1.id
	end

	if arg_13_1.shows then
		for iter_13_0, iter_13_1 in ipairs(arg_13_1.shows) do
			self._chatPropIdDic[iter_13_1.id] = iter_13_1
		end
	end
end

function User:getPropChat()
	return self._chatPropIdDic
end

function User:getPropChatById(arg_15_1)
	return self._chatPropIdDic[arg_15_1]
end

function User:getPropFrame()
	return self._headFrameIdDic
end

function User:getPropFrameById(arg_17_1)
	return self._headFrameIdDic[arg_17_1]
end

function User:getPropHead()
	return self._headIdDic
end

function User:getPropHeadById(arg_19_1)
	return self._headIdDic[arg_19_1]
end

function User:updateFrameOrHead(arg_20_1)
	if arg_20_1.type == 1 then
		if arg_20_1.frame ~= nil then
			self._frameId = arg_20_1.frame
		end
	elseif arg_20_1.type == 4 and arg_20_1.frame ~= nil then
		self._chatPropId = arg_20_1.frame
	end

	if arg_20_1.name ~= nil then
		self._name = arg_20_1.name

		self:setGuideFastName(self._name)
	end
end

function User:updateTitle(arg_21_1)
	self:checkNewTitle(arg_21_1.titles)

	self.titleId = arg_21_1.title_id or {}
	self.titles = arg_21_1.titles or {}
	self._titleInited = true

	self.UserTitleData:updateTitleDataByState()
end

function User:checkNewTitle(arg_22_1)
	arg_22_1 = arg_22_1 or {}

	local function var_22_0(arg_23_0)
		for iter_23_0, iter_23_1 in ipairs(self.titles) do
			if iter_23_1.id == arg_23_0 then
				return true
			end
		end

		return false
	end

	local function var_22_1(arg_24_0)
		for iter_24_0, iter_24_1 in ipairs(arg_22_1) do
			if iter_24_1.id == arg_24_0 then
				return true
			end
		end

		return false
	end

	if self._titleInited then
		for iter_22_0, iter_22_1 in ipairs(self.titles) do
			if not var_22_1(iter_22_1.id) then
				self.UserTitleData:setNewTitleId(iter_22_1.id)
				self.UserTitleData:setTitleState(true)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_AUTOPOP_TITLE, false, {
					active = false,
					id = iter_22_1.id
				})
			end
		end

		for iter_22_2, iter_22_3 in ipairs(arg_22_1) do
			if not var_22_0(iter_22_3.id) then
				self.UserTitleData:setTitleState(true)
				self.UserTitleData:setNewTitleId(iter_22_3.id)
				g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_AUTOPOP_TITLE, false, {
					active = true,
					id = iter_22_3.id
				})
			end
		end
	end
end

function User:getForeshowInfo()
	local var_25_0 = {}

	for iter_25_0 = 1, g.core.config.function_foreshow_info.getLength() do
		local var_25_1 = g.core.config.function_foreshow_info.indexOf(iter_25_0)

		if not g.core.common.ModuleUnlock:isModuleUnlock(var_25_1.function_id) and g.core.common.ModuleUnlock:isModuleForeShow(var_25_1.id) then
			table.insert(var_25_0, var_25_1)
		end
	end

	local var_25_2

	for iter_25_1, iter_25_2 in ipairs(var_25_0) do
		if not var_25_2 then
			var_25_2 = iter_25_2
		elseif iter_25_2.sort < var_25_2.sort then
			var_25_2 = iter_25_2
		end
	end

	return var_25_2
end

function User:getMaxLevel()
	local var_26_1 = var_0_3.get((var_0_3.getLength()))

	return (var_26_1 or nil) and var_26_1.level
end

function User:getLevelUpExp()
	if self._level < self:getMaxLevel() then
		return var_0_3.get(self._level).level_up_exp
	end

	return 0
end

function User:getNextLevelExp()
	if self._level < self:getMaxLevel() then
		return var_0_3.get(self._level + 1).level_up_exp
	end

	return 0
end

function User:getId()
	return self._id
end

function User:getName()
	if self._guideFastName == nil then
		return self._name
	end

	if self._level >= 7 then
		return self._name
	end

	if self:checkFirstGuideFinish() then
		return self._name
	end

	return self._guideFastName
end

function User:getLevel()
	return self._level
end

function User:getGold()
	return self._gold
end

function User:getFreeGold()
	return self._free_gold
end

function User:getVipLevel()
	return self._vipLevel
end

function User:getFightValue()
	return self._fightValue
end

function User:getGuildId()
	return self._guildId
end

function User:setGuildName(arg_37_1)
	if arg_37_1 and arg_37_1.guild then
		self._guildName = arg_37_1.guild.name
	end
end

function User:getGuildName()
	return self._guildName
end

function User:getBaseId()
	return self._baseId
end

function User:getAvataId()
	return self._avataId
end

function User:getDressId()
	return self._dressId
end

function User:getFrameId()
	return self._frameId
end

function User:getChatPropId()
	return self._chatPropId
end

function User:getUserData()
	return self._data
end

function User:getShowId()
	return self._showId
end

function User:getGuideId()
	return self._guideId
end

function User:setGuideId(arg_47_1)
	self._guideId = arg_47_1
end

function User:getAllTitles()
	return self.titles
end

function User:getAllWearingTitleIds()
	return self.titleId
end

function User:getDifGold()
	return self._difGold
end

function User:getCreateTime()
	return self._createTime
end

function User:getPuzzleGameLevel()
	return self._puzzleGameLevel
end

function User:setPuzzleGameLevel(arg_53_1)
	self._puzzleGameLevel = arg_53_1
end

function User:getSendCount()
	return self._sendCount
end

function User:setSendCount(arg_55_1)
	self._sendCount = arg_55_1
end

function User:getBirthday()
	return self._birthDay
end

function User:getBirthResetTimes()
	return self._birthdaySetTimes
end

function User:setPlatUserId(arg_58_1)
	self._platUserId = arg_58_1 or 0
end

function User:getPlatUserId()
	return self._platUserId
end

function User:getStormCityLordId()
	if g.core.model.User.stormCityData:isProcess() then
		self._stormCityLord = 0
	elseif self._stormCityLord == 0 then
		self._stormCityLord = g.core.model.User.stormCityData:calculateMyLordId()
	end

	return self._stormCityLord
end

function User:setStormCityLordId(arg_61_1)
	self._stormCityLord = arg_61_1
end

function User:packUser()
	local var_62_0 = clone(self._data)
	local var_62_1 = self.knightsData:getMainKnight()

	var_62_0.base_id = var_62_1:getBaseInfo().id
	var_62_0.show_knight_id = self:getAssistantId()
	var_62_0.show_knight_dress = self:getAssistantDressId()
	var_62_0.skin = var_62_1:getSkin()
	var_62_0.alliance_id = self._allianceId or 0
	var_62_0.alliance_name = self._allianceName or ""
	var_62_0.server_name = g.core.platform.ServerListProxy:getLoginServer().name

	return var_62_0
end

function User:isLevelUp()
	return self._levelUp, self._oldLevel, self._newLevel
end

function User:setLevelUp(arg_64_1, arg_64_2, arg_64_3)
	self._levelUp, self._oldLevel, self._newLevel = arg_64_1, arg_64_2, arg_64_3

	if arg_64_1 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
			tickType = 2,
			level = arg_64_3
		})
	end
end

function User:resetLevelUp()
	self._levelUp = false
end

function User:getAssistantId()
	if #self._nominateList > 0 then
		return self._nominateList[1].advanceId
	end

	if self._assistantId == 0 then
		self._assistantId = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.ASSISTANT_KNIGHT_ID).parameter
	end

	return self._assistantId
end

function User:getAssistantDressId()
	if #self._nominateList > 0 then
		return self._nominateList[1].skinId
	end

	return self._assistantDressId
end

function User:getAssistantResInfo()
	return self.knightsData:getKnightResInfo({
		knightId = self:getAssistantId(),
		skinId = self:getAssistantDressId()
	})
end

function User:getAssistantVoiceInfo()
	return self.knightsData:getKnightVoiceResInfo({
		knightId = self:getAssistantId(),
		skinId = self:getAssistantDressId()
	})
end

function User:getAssistantTempResInfo(arg_70_1, arg_70_2)
	return self.knightsData:getKnightResInfo({
		knightId = arg_70_1,
		skinId = arg_70_2
	})
end

function User:getAssistantTempVoiceInfo(arg_71_1, arg_71_2)
	return self.knightsData:getKnightVoiceResInfo({
		knightId = arg_71_1,
		skinId = arg_71_2
	})
end

function User:initNominateList(arg_72_1, arg_72_2)
	local AssistantCommon = require("app.view.module.assistant.common.AssistantCommon")
	local var_72_1 = g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.ASSISTANT_MAX_NOMINATE_NUM).parameter

	self._nominateList = {}
	arg_72_1 = arg_72_1 or {}

	for iter_72_0 = 1, #arg_72_1 do
		if arg_72_1[iter_72_0].knight_id then
			local var_72_2 = {
				advanceId = arg_72_1[iter_72_0].knight_id
			}

			var_72_2.skinId = arg_72_1[iter_72_0].skin_id or 0
			var_72_2.x = arg_72_1[iter_72_0].x or AssistantCommon.defaultData.assistantPos.x
			var_72_2.y = arg_72_1[iter_72_0].y or AssistantCommon.defaultData.assistantPos.y

			if arg_72_1[iter_72_0].scale then
				var_72_2.scale = arg_72_1[iter_72_0].scale / 10 or AssistantCommon.defaultData.assistantScale
			end

			var_72_2.bg = arg_72_1[iter_72_0].background or 1

			if var_72_1 > #self._nominateList then
				table.insert(self._nominateList, var_72_2)
			end
		end
	end

	if arg_72_2 then
		local var_72_3 = {}

		for iter_72_1 = 1, #self._nominateList do
			local var_72_4 = self:getAssistantTempResInfo(self._nominateList[iter_72_1].advanceId, self._nominateList[iter_72_1].skinId)

			for iter_72_2, iter_72_3 in pairs(self._specialShowPlayed) do
				if iter_72_2 == var_72_4.id then
					var_72_3[iter_72_2] = true
				end
			end
		end

		for iter_72_4, iter_72_5 in pairs(self._specialShowPlayed) do
			if not var_72_3[iter_72_4] then
				self._specialShowPlayed[iter_72_4] = nil
			end
		end
	end
end

function User:packNominateServerList()
	local var_73_0 = {}

	for iter_73_0 = 1, math.min(g.core.config.parameter_info.get(g.core.const.ConstMgr.PARAMETER_CONST.ASSISTANT_MAX_NOMINATE_NUM).parameter, #self._nominateList) do
		table.insert(var_73_0, {
			knight_id = self._nominateList[iter_73_0].advanceId,
			skin_id = self._nominateList[iter_73_0].skinId,
			x = self._nominateList[iter_73_0].x,
			y = self._nominateList[iter_73_0].y,
			scale = self._nominateList[iter_73_0].scale * 10,
			background = self._nominateList[iter_73_0].bg
		})
	end

	return var_73_0
end

function User:isInNominateList(arg_74_1)
	local var_74_0 = 0

	for iter_74_0 = 1, #self._nominateList do
		if arg_74_1 == self._nominateList[iter_74_0].advanceId then
			var_74_0 = iter_74_0

			break
		end
	end

	return var_74_0
end

function User:updateNominateInfo(arg_75_1, arg_75_2)
	arg_75_2 = arg_75_2 or {}

	local var_75_0 = self:isInNominateList(arg_75_1)

	if var_75_0 > 0 then
		for iter_75_0, iter_75_1 in pairs(arg_75_2) do
			self._nominateList[var_75_0][iter_75_0] = iter_75_1
		end
	end
end

function User:getNominateInfo(arg_76_1)
	local var_76_0 = self:isInNominateList(arg_76_1)

	if var_76_0 > 0 then
		return self._nominateList[var_76_0]
	end

	local AssistantCommon = require("app.view.module.assistant.common.AssistantCommon")

	return {
		bg = 1,
		skinId = 0,
		advanceId = arg_76_1,
		x = AssistantCommon.defaultData.assistantPos.x,
		y = AssistantCommon.defaultData.assistantPos.y,
		scale = AssistantCommon.defaultData.assistantScale
	}
end

function User:removeNominateByIndex(arg_77_1)
	if #self._nominateList > 1 and arg_77_1 <= #self._nominateList then
		table.remove(self._nominateList, arg_77_1)
	end

	return self._nominateList
end

function User:insertNominateByAdvanceId(arg_78_1)
	if self:isInNominateList(arg_78_1) == 0 then
		table.insert(self._nominateList, self:getNominateInfo(arg_78_1))
	end

	return self._nominateList
end

function User:getNominateList()
	if #self._nominateList == 0 then
		local var_79_0 = require("app.view.module.assistant.common.AssistantCommon").getAssistantData()

		table.insert(self._nominateList, {
			advanceId = self:getAssistantId(),
			skinId = self:getAssistantDressId(),
			x = var_79_0.assistantPos.x,
			y = var_79_0.assistantPos.y,
			scale = var_79_0.assistantScale,
			bg = self.userActiveSceneData:getSceneId()
		})
	end

	return self._nominateList
end

function User:getNominateInfoByIndex(arg_80_1)
	local var_80_0 = self:getNominateList()

	arg_80_1 = math.min(arg_80_1 or 1, #var_80_0)

	return var_80_0[arg_80_1]
end

function User:getLastAdvIndex()
	local var_81_0 = require("app.view.module.assistant.common.AssistantCommon").getAssistantData().advIndex or 1

	if var_81_0 > #self:getNominateList() then
		var_81_0 = 1
	end

	return var_81_0
end

function User:setSpecialShowPlayed(arg_82_1)
	if arg_82_1 then
		self._specialShowPlayed[arg_82_1] = true
	end
end

function User:isPlayedSpecialShowAction(arg_83_1)
	return self._specialShowPlayed[arg_83_1]
end

function User:getFightId()
	if self._dressId and self._dressId ~= 0 then
		return self._dressId
	else
		return g.core.config.knight_base_info.get(g.core.config.knight_info.get(self._baseId).advance_id).fight_id
	end
end

function User:isBoy()
	return (self:getUserUniqueAdvanceId() or 0) == 210000
end

function User:getUserUniqueAdvanceId()
	return (g.core.config.knight_info.fetch(self._baseId) or {}).advance_id
end

function User:isJoinGuild()
	if self._guildId and self._guildId > 0 then
		return true
	end

	return false
end

function User:isSelfById(arg_88_1)
	if arg_88_1 and self._id and self._id == arg_88_1 then
		return true
	end

	return false
end

function User:setIsNotTips(arg_89_1, arg_89_2)
	self._isTips[arg_89_1] = arg_89_2
end

function User:getIsNotTips(arg_90_1)
	return self._isTips[arg_90_1]
end

function User:_initGuideName()
	self._guideFastName = (g.core.common.Storage:load("guide_fast_name.json", false) or {}).guide_fast_name
end

function User:setGuideFastName(arg_92_1)
	self._guideFastName = arg_92_1

	g.core.common.Storage:save("guide_fast_name.json", {
		guide_fast_name = self._guideFastName
	}, false)
end

function User:checkFirstGuideFinish()
	local var_93_0 = self:getGuideId()
	local var_93_1 = json.decodeFileIfExists("guide/newbee_guide.json")

	if var_93_1 and #var_93_1 > 0 then
		for iter_93_0, iter_93_1 in pairs(var_93_1) do
			if iter_93_1.resetId ~= 99999 and var_93_0 == iter_93_1.stepId then
				return false
			end
		end
	end

	return true
end

function User:getAllianceId()
	return self._allianceId or 0
end

function User:setAllianceId(arg_95_1)
	self._allianceId = arg_95_1 or 0
end

function User:getAllianceName()
	return self._allianceName
end

function User:updateRoleSkinPart(arg_97_1, arg_97_2)
	self._data.skin_part = self._data.skin_part or {}
	self._data.skin_part[arg_97_1] = arg_97_2
end

function User:checkUserSkipBattle(arg_98_1, arg_98_2, arg_98_3, arg_98_4)
	local var_98_0 = g.core.config.battle_power_skip_info.get(arg_98_3)

	if var_98_0.skip == 1 then
		if arg_98_1 / arg_98_2 * 1000 >= var_98_0.proportion and (arg_98_4 and var_98_0.value ~= 0 or nil) and arg_98_4 <= var_98_0.value then
			return true
		end
	end

	return false
end

function User:updateServerConfig(arg_99_1)
	self._serverCfg = arg_99_1
end

function User:getBattleVideoUrl()
	return (self._serverCfg or nil) and (self._serverCfg.oss_cdn_url or "")
end

local var_0_4 = Loader.proxy(User.new())

function var_0_4.reset(arg_101_0)
	local var_101_0 = var_0_4:getClient()

	if var_101_0 then
		var_101_0:resetData()
	else
		var_0_4:setClient(User.new())
	end
end

function var_0_4.clear(arg_102_0)
	local var_102_0 = var_0_4:getClient()

	if var_102_0 then
		var_102_0:clearData()
	end

	var_0_4:clearClient()
end

return var_0_4
