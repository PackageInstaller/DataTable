local var_0_0 = ...
local var_0_1 = string
local var_0_2 = string.format
local var_0_3 = tostring
local DebugCommon = require("app.view.module.debug.common.DebugCommon")

return {
	_cache = {},
	_handlers = {
		OtherReturnPay = "OtherReturnPayHandler",
		BgBook = "MainSceneSkinHandler",
		Area = "AreaHandler",
		CrossActivity = "CrossActivityHandler",
		Retro = "RetroHandler",
		PlayerInfo = "PlayerInfoHandler",
		Tips = "TipsHandler",
		StoryCompletion = "StoryCompletionHandler",
		CommonPasscard = "CommonPasscardHandler",
		Storerating = "StoreratingHandler",
		Snapshot = "SnapShotHandler",
		AccountBind = "AccountBindHandler",
		NewSlg = "NewSlgHandler",
		Tower = "TowerHandler",
		GuildAlliance = "AllianceHandler",
		ContendTreasure = "RobTreasureHandler",
		CelebrationLogin = "CelebrationLoginHandler",
		City = "CityHandler",
		MainGrowth = "WarriorsOfFateHandler",
		Knight = "KnightHandler",
		Scroll = "WarriorsOfFateHandler",
		Recharge = "RechargeHandler",
		Equipment = "EquipHandler",
		PassCard = "PassCardHandler",
		ThemePasscard = "ThemePasscardHandler",
		PushGift = "PushGiftHandler",
		ThemeExplore = "ThemeExploreHandler",
		Common = "CoreHandler",
		ThemePV = "ThemePVHandler",
		Friend = "FriendHandler",
		ThemeAction = "ThemeActionHandler",
		NewYearWish = "NewYearWishHandler",
		ThemeDungeon = "ThemeDungeonHandler",
		DemonAutoBoss = "DemonBossHandler",
		FundActivity = "FundActivityHandler",
		DemonBoss = "DemonBossHandler",
		PasscardActivity = "PasscardActivityHandler",
		HomeLandTrain = "HomeLandTrainHandler",
		Bounty = "BountyHandler",
		Biography = "BiographyHandler",
		CultivateActivity = "CultivateActivityHandler",
		DeadBattle = "WushHandler",
		Precious = "PreciousHandler",
		Treasure = "TreasureHandler",
		ChiBi = "RedCliffHandler",
		Mail = "MailHandler",
		Exploration = "ExplorationHandler",
		Shop = "ShopHandler",
		WeeklyCompetition = "WeeklyCompetitionHandler",
		KnightBook = "KnightBookHandler",
		Lottery = "LotteryHandler",
		Arena = "ArenaHandler",
		NewRecruit = "RecruitHandler",
		Release = "ReleaseHandler",
		Recruit = "RecruitHandler",
		Voucher = "VoucherHandler",
		Dungeon = "DungeonHandler",
		DeadTower = "WushTowerHandler",
		Item = "ItemHandler",
		MiniGame = "MiniGameHandler",
		Formation = "FormationHandler",
		Festival = "FestivalHandler",
		UniteToken = "UniteTokenHandler",
		Screen = "ScreenHandler",
		Fragment = "FragmentHandler",
		Palace = "EchoLabHandler",
		Storm = "StormHandler",
		Wishpool = "WishpoolHandler",
		GuildWorship = "GuildWorshipHandler",
		SpiritHelp = "SpiritHelpHandler",
		Skin = "SkinHandler",
		Harmonious = "CensorHandler",
		GuildStatue = "GuildStatueHandler",
		Material = "MaterialHandler",
		GuideTask = "GuideTaskHandler",
		HandbookCompetition = "HandbookCompetitionHandler",
		GuildCompetition = "GuildActivityHandler",
		Gold = "DiamondExchangeHandler",
		LoginReward = "SevenDaysSignInHandler",
		WorldRedPacket = "WorldRedPacketHandler",
		LevelUp = "LevelUpHandler",
		ChiefArena = "ChiefArenaHandler",
		Phone = "BindPhoneHandler",
		Gene = "GeneHandler",
		NewSevendays = "SevenDaysHandler",
		Refund = "RefundHandler",
		Questionnaire = "QuestionnaireHandler",
		HarmoniousMystery = "HarmoniousMysteryHandler",
		FightingCapacity = "FightActivityHandler",
		Competition = "CompetitionHandler",
		H5Activity = "H5ActivityHandler",
		Welfarefund = "WelfarefundHandler",
		Eliminate = "GemHandler",
		MonthGacha = "MonthGachaHandler",
		GoldSaving = "GoldSavingHandler",
		ThemeBiography = "ThemeBiographyHandler",
		FriendRecommend = "FriendRecommendHandler",
		GVE = "GveHandler",
		Turntable = "TurntableHandler",
		Puzzle = "PuzzleHandler",
		TurnCard = "TurnCardHandler",
		Support = "ValentinesDayVoteHandler",
		GuildWar = "GuildWarHandler",
		FriendHelper = "FriendHelperHandler",
		GmActivityLogin = "GmActivityLoginHandler",
		Fog = "FogNightmareHandler",
		Interaction = "EasterEggHandler",
		UserBack = "UserBackHandler",
		Daily = "DailyReportHandler",
		WeddingVow = "WeddingVowHandler",
		Achievement = "AchievementHandler",
		OldPlayerBack = "OldPlayerBackHandler",
		FlushShop = "ShopFlushHandler",
		ShowKnight = "ShowKnightHandler",
		GuildDungeon = "GuildDungeonHandler",
		NewDemonBoss = "ThemeThirdBossHandler",
		DailyDungeon = "DailyDungeonHandler",
		Rerun = "ActivityReturnHandler",
		Guild = "GuildHandler",
		Tree = "TreeHandler",
		Rebel = "RebelHandler",
		RichMan = "RichManHandler",
		Handbook = "HandBookHandler",
		TeamBattle = "TeamBattleHandler",
		Dress = "DressHandler",
		CustomActivity = "CustomActivityHandler",
		Title = "TitleHandler",
		Guide = "GuideHandler",
		HomeInfoRemind = "HomeInfoRemindHandler",
		ExploreTreasure = "RobTreasureHandler",
		FurnitureRoom = "FurnitureRoomHandler",
		HallOfFame = "HallOfFameHandler",
		KnightTissue = "KnightTissueHandler",
		Chat = "ChatHandler",
		KnightFavorability = "KnightFavorabilityHandler",
		GetStamina = "GetStaminaHandler",
		SpaceTimeRecruit = "SpaceTimeRecruitHandler",
		SignIn = "SignInHandler",
		YoungAct = "YouthDayHandler",
		Reborn = "RebornHandler",
		KSoul = "KnightSoulHandler",
		DailyTask = "DailyTaskHandler",
		GuildBattle = "GuildFightHandler",
		Announce = "AnnounceHandler",
		Wrest = "WrestHandler",
		PresetFormation = "PresetFormationHandler",
		WeekGift = "WeekGiftHandler",
		MonsterSwitch = "MonsterSwitchHandler",
		BlockedActivity = "BlockedActivityHandler",
		ShopCar = "ShopCarHandler",
		Furnace = "SmelterHandler",
		MainTask = "MainTaskHandler",
		SpaceTimeDungeon = "NightMareHandler",
		Domain = "DomainHandler",
		PeakArena = "PeakArenaHandler",
		ServerPass = "ServerPassHandler",
		GroupBattle = "TeamPvpHandler",
		ActivityCommon = "RichHandler",
		Ancient = "AncientHandler",
		Richest = "RichHandler",
		VipLink = "VipLinkHandler",
		New = "NewHandler",
		BackReward = "ActivityRecallHandler",
		MysteryBoss = "MysteryBossHandler",
		Pet = "PetHandler",
		AbvertPage = "AbvertPageHandler",
		Action = "ActionHandler",
		Wing = "WingHandler",
		BulletScreen = "BulletScreenHandler",
		TalkShow = "ChatPropHandler",
		Mystery = "MysteryHandler",
		OrderWorld = "CommanderWorldHandler",
		Retrieve = "ActivityRecycleHandler",
		SuperVip = "SuperVipHandler",
		Holiday = "HolidayHandler",
		Card = "IncarnationHandler",
		WishShop = "WishShopHandler",
		WeChat = "ShareHandler",
		RpRain = "RedPacketRainHandler",
		Mine = "MineHandler",
		Activity = "ActivityCommonTaskHandler",
		Auction = "AuctionHandler",
		GuildBoss = "GuildBossHandler",
		Condition = "ConditionActivityHandler",
		GoldEquip = "TroopHandler",
		Artifact = "ArtifactHandler",
		OnlineGift = "OnlineGiftHandler",
		GodBox = "GodboxHandler",
		ReturnPayOperator = "RechargeHandler",
		ReturnPay = "RechargeHandler",
		StormCity = "StormCityHandler",
		Outpost = "OutpostHandler",
		ElderBoss = "ElderBossHandler",
		SplitDownload = "SplitDownloadHandler",
		Spire = "SpireHandler",
		Anniversary = "AnniversaryHandler",
		BlazingArena = "BlazingArenaHandler",
		NewDownload = "NewDownloadHandler",
		AbvertPageAward = "AbvertPageAwardHandler",
		Monopoly = "MonopolyHandler",
		Succuba = "SuccubaHandler",
		Pubg = "PubgHandler",
		WeddingActivity = "WeddingActivityHandler",
		RecycleCultivate = "RecycleCultivateHandler",
		SkinPart = "RoleSkinHandler",
		AllianceTrial = "AllianceTrialHandler"
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
