local var_0_0 = ...
local var_0_1 = string
local var_0_2 = string.format
local var_0_3 = tostring
local DebugCommon = require("app.view.module.debug.common.DebugCommon")

return {
	_cache = {},
	_handlers = {
		Outpost = "OutpostHandler",
		Shop = "ShopHandler",
		ExploreTreasure = "RobTreasureHandler",
		DemonBoss = "DemonBossHandler",
		FightingCapacity = "FightActivityHandler",
		Artifact = "ArtifactHandler",
		WeddingActivity = "WeddingActivityHandler",
		AbvertPage = "AbvertPageHandler",
		MainGrowth = "WarriorsOfFateHandler",
		BulletScreen = "BulletScreenHandler",
		Item = "ItemHandler",
		GuildWorship = "GuildWorshipHandler",
		GuildCompetition = "GuildActivityHandler",
		Daily = "DailyReportHandler",
		ThemeDungeon = "ThemeDungeonHandler",
		Title = "TitleHandler",
		Questionnaire = "QuestionnaireHandler",
		Mystery = "MysteryHandler",
		Reborn = "RebornHandler",
		SpaceTimeRecruit = "SpaceTimeRecruitHandler",
		ShowKnight = "ShowKnightHandler",
		Friend = "FriendHandler",
		Eliminate = "GemHandler",
		Rebel = "RebelHandler",
		RichMan = "RichManHandler",
		SuperVip = "SuperVipHandler",
		Mail = "MailHandler",
		NewSevendays = "SevenDaysHandler",
		Chat = "ChatHandler",
		ThemePasscard = "ThemePasscardHandler",
		NewRecruit = "RecruitHandler",
		GuildWar = "GuildWarHandler",
		StormCity = "StormCityHandler",
		Storm = "StormHandler",
		ActivityCommon = "RichHandler",
		Dress = "DressHandler",
		Card = "IncarnationHandler",
		City = "CityHandler",
		WeekGift = "WeekGiftHandler",
		Wrest = "WrestHandler",
		WeChat = "ShareHandler",
		GuildBattle = "GuildFightHandler",
		Bounty = "BountyHandler",
		LevelUp = "LevelUpHandler",
		GodBox = "GodboxHandler",
		Support = "ValentinesDayVoteHandler",
		UserBack = "UserBackHandler",
		NewYearWish = "NewYearWishHandler",
		Announce = "AnnounceHandler",
		Retrieve = "ActivityRecycleHandler",
		BackReward = "ActivityRecallHandler",
		Puzzle = "PuzzleHandler",
		GVE = "GveHandler",
		MonthGacha = "MonthGachaHandler",
		Condition = "ConditionActivityHandler",
		FriendRecommend = "FriendRecommendHandler",
		DeadTower = "WushTowerHandler",
		Screen = "ScreenHandler",
		Treasure = "TreasureHandler",
		Wishpool = "WishpoolHandler",
		PasscardActivity = "PasscardActivityHandler",
		Exploration = "ExplorationHandler",
		BgBook = "MainSceneSkinHandler",
		HandbookCompetition = "HandbookCompetitionHandler",
		Domain = "DomainHandler",
		Gene = "GeneHandler",
		Knight = "KnightHandler",
		Refund = "RefundHandler",
		HarmoniousMystery = "HarmoniousMysteryHandler",
		Recruit = "RecruitHandler",
		WeeklyCompetition = "WeeklyCompetitionHandler",
		HallOfFame = "HallOfFameHandler",
		Tower = "TowerHandler",
		HomeLandTrain = "HomeLandTrainHandler",
		Material = "MaterialHandler",
		Skin = "SkinHandler",
		Harmonious = "CensorHandler",
		FlushShop = "ShopFlushHandler",
		FundActivity = "FundActivityHandler",
		GuildAlliance = "AllianceHandler",
		Rerun = "ActivityReturnHandler",
		Wing = "WingHandler",
		BlockedActivity = "BlockedActivityHandler",
		GuideTask = "GuideTaskHandler",
		NewDownload = "NewDownloadHandler",
		SpaceTimeDungeon = "NightMareHandler",
		Holiday = "HolidayHandler",
		Competition = "CompetitionHandler",
		FurnitureRoom = "FurnitureRoomHandler",
		CustomActivity = "CustomActivityHandler",
		NewDemonBoss = "ThemeThirdBossHandler",
		DemonAutoBoss = "DemonBossHandler",
		DailyTask = "DailyTaskHandler",
		Interaction = "EasterEggHandler",
		GuildBoss = "GuildBossHandler",
		Precious = "PreciousHandler",
		CrossActivity = "CrossActivityHandler",
		PeakArena = "PeakArenaHandler",
		Snapshot = "SnapShotHandler",
		OtherReturnPay = "OtherReturnPayHandler",
		NewSlg = "NewSlgHandler",
		Tips = "TipsHandler",
		CelebrationLogin = "CelebrationLoginHandler",
		Retro = "RetroHandler",
		Area = "AreaHandler",
		CommonPasscard = "CommonPasscardHandler",
		Welfarefund = "WelfarefundHandler",
		PresetFormation = "PresetFormationHandler",
		Lottery = "LotteryHandler",
		GroupBattle = "TeamPvpHandler",
		MysteryBoss = "MysteryBossHandler",
		RecycleCultivate = "RecycleCultivateHandler",
		Guide = "GuideHandler",
		Activity = "ActivityCommonTaskHandler",
		Action = "ActionHandler",
		ReturnPayOperator = "RechargeHandler",
		Succuba = "SuccubaHandler",
		Recharge = "RechargeHandler",
		HomeInfoRemind = "HomeInfoRemindHandler",
		Monopoly = "MonopolyHandler",
		Equipment = "EquipHandler",
		Fragment = "FragmentHandler",
		VipLink = "VipLinkHandler",
		Dungeon = "DungeonHandler",
		TeamBattle = "TeamBattleHandler",
		Storerating = "StoreratingHandler",
		BlazingArena = "BlazingArenaHandler",
		Anniversary = "AnniversaryHandler",
		Spire = "SpireHandler",
		ReturnPay = "RechargeHandler",
		Formation = "FormationHandler",
		PlayerInfo = "PlayerInfoHandler",
		ThemeExplore = "ThemeExploreHandler",
		Turntable = "TurntableHandler",
		OrderWorld = "CommanderWorldHandler",
		SplitDownload = "SplitDownloadHandler",
		Common = "CoreHandler",
		GoldSaving = "GoldSavingHandler",
		TurnCard = "TurnCardHandler",
		WeddingVow = "WeddingVowHandler",
		Mine = "MineHandler",
		Pet = "PetHandler",
		ChiefArena = "ChiefArenaHandler",
		TalkShow = "ChatPropHandler",
		ElderBoss = "ElderBossHandler",
		Scroll = "WarriorsOfFateHandler",
		StoryCompletion = "StoryCompletionHandler",
		Release = "ReleaseHandler",
		UniteToken = "UniteTokenHandler",
		GoldEquip = "TroopHandler",
		MonsterSwitch = "MonsterSwitchHandler",
		MainTask = "MainTaskHandler",
		MiniGame = "MiniGameHandler",
		WorldRedPacket = "WorldRedPacketHandler",
		ServerPass = "ServerPassHandler",
		Ancient = "AncientHandler",
		Handbook = "HandBookHandler",
		New = "NewHandler",
		GuildStatue = "GuildStatueHandler",
		AbvertPageAward = "AbvertPageAwardHandler",
		DailyDungeon = "DailyDungeonHandler",
		CultivateActivity = "CultivateActivityHandler",
		WishShop = "WishShopHandler",
		GuildDungeon = "GuildDungeonHandler",
		YoungAct = "YouthDayHandler",
		AccountBind = "AccountBindHandler",
		Palace = "EchoLabHandler",
		Biography = "BiographyHandler",
		GetStamina = "GetStaminaHandler",
		GmActivityLogin = "GmActivityLoginHandler",
		OnlineGift = "OnlineGiftHandler",
		H5Activity = "H5ActivityHandler",
		KnightFavorability = "KnightFavorabilityHandler",
		SignIn = "SignInHandler",
		Tree = "TreeHandler",
		Fog = "FogNightmareHandler",
		ThemeAction = "ThemeActionHandler",
		Pubg = "PubgHandler",
		Phone = "BindPhoneHandler",
		DeadBattle = "WushHandler",
		ChiBi = "RedCliffHandler",
		PushGift = "PushGiftHandler",
		KSoul = "KnightSoulHandler",
		Guild = "GuildHandler",
		ContendTreasure = "RobTreasureHandler",
		Gold = "DiamondExchangeHandler",
		FriendHelper = "FriendHelperHandler",
		OldPlayerBack = "OldPlayerBackHandler",
		Voucher = "VoucherHandler",
		RpRain = "RedPacketRainHandler",
		Auction = "AuctionHandler",
		ShopCar = "ShopCarHandler",
		PassCard = "PassCardHandler",
		Furnace = "SmelterHandler",
		SpiritHelp = "SpiritHelpHandler",
		ThemePV = "ThemePVHandler",
		Festival = "FestivalHandler",
		KnightTissue = "KnightTissueHandler",
		Arena = "ArenaHandler",
		SkinPart = "RoleSkinHandler",
		AllianceTrial = "AllianceTrialHandler",
		KnightBook = "KnightBookHandler",
		LoginReward = "SevenDaysSignInHandler",
		Achievement = "AchievementHandler",
		Richest = "RichHandler",
		ThemeBiography = "ThemeBiographyHandler"
	},
	onNetEvent = function(self, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RET_MSG_ASYNC, true, arg_1_2, arg_1_3)

		local var_1_0 = g.core.network.proto.list[var_0_3(arg_1_2)]

		assert(var_1_0, "Invalid msg id: " .. var_0_3(arg_1_2))

		local var_1_1 = var_0_2("%s2C_%s", var_1_0[2], var_1_0[1])
		local var_1_2 = self._cache["on_" .. var_1_1]

		if not self._cache["on_" .. var_1_1] then
			assert(self._handlers[var_1_0[5]], "Invalid handler named: " .. tostring(self._handlers[var_1_0[5]]))

			local var_1_3 = import("." .. self._handlers[var_1_0[5]], var_0_0)

			assert(var_1_3["on_" .. var_1_1], "Could not found the function named: " .. tostring("on_" .. var_1_1))

			self._cache["on_" .. var_1_1] = handler(var_1_3, var_1_3["on_" .. var_1_1])
			var_1_2 = self._cache["on_" .. var_1_1]
		end

		if var_1_2 then
			if config.DEBUG_VERSION then
				self:_dumpProto(var_1_1, arg_1_3)
			end

			if arg_1_2 ~= g.core.network.proto.MSG_G2C_KeepAlive and arg_1_2 ~= g.core.network.proto.MSG_S2C_SyncTime then
				g.core.platform.BuglyProxy:trace(g.core.const.ConstMgr.BuglyTagConst.MSG_RECV, var_0_1.format("recv msg: %s, name: %s, ret: %s, sid: %s, cid: %s", tostring(arg_1_2), var_1_1, arg_1_3.ret and tostring(arg_1_3.ret) or "nil", tostring(arg_1_4), tostring(arg_1_5)))
			end

			xpcall(function()
				var_1_2(arg_1_2, arg_1_3)
			end, function(arg_3_0)
				if config.DEBUG_VERSION then
					require("app.view.module.debug.pop.ErrorMessagePop").popErrorWin(arg_3_0)
				else
					release_print("Warning！handle msg error, named: " .. var_1_1 .. "error is : ")
					release_print(arg_3_0)
				end
			end)
		else
			print("Warning！Unprocess msg named: " .. var_1_1)
			print(debug.traceback())
		end
	end,
	_dumpProto = function(arg_4_0, arg_4_1, arg_4_2)
		if not DebugCommon.getDebugGlobalValueByKey("proto_dump") then
			return
		end

		if arg_4_1 == "G2C_KeepAlive" then
			-- block empty
		else
			dump(arg_4_2, arg_4_1)
		end
	end,
	onMsgProcess = function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_2.ret == nil then
			return true
		end

		local var_5_0 = arg_5_2.ret

		if arg_5_2.ret == g.core.network.proto.RET_OK then
			return true
		end

		local var_5_1 = g.core.network.proto.list[var_0_3(arg_5_1)]

		assert(var_5_1, "Invalid msg id: " .. var_0_3(arg_5_1))
		dump(arg_5_2, var_0_1.format("Error! msgId: %s, msgName: %s", arg_5_1, (var_0_2("%s2C_%s", var_5_1[2], var_5_1[1]))))

		if arg_5_1 ~= g.core.network.proto.MSG_G2C_Login and arg_5_1 ~= g.core.network.proto.MSG_S2C_City_HandleTrouble then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_RET_ERROR, false, var_5_0, arg_5_1)
		end

		return false
	end,
	replaceCacheFuncWithPatch = function(self, arg_6_1, arg_6_2)
		if type(arg_6_1) ~= "string" then
			g.core.log:info("--------       Invalid funcName !!     ------------")
		elseif type(arg_6_2) ~= "function" then
			g.core.log:info("--------       Invalid func !!     ------------")
		else
			self._cache[arg_6_1] = arg_6_2
		end
	end
}
