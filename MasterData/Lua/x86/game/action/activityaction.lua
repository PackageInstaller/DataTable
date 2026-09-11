local var_0_0 = {}

manager.net:Bind(11001, function(arg_1_0)
	ActivityData:InitActivityData(arg_1_0)
	var_0_0.DealWithAllActivityData()
	ActivityRedPoint:OnActivityUpdate(arg_1_0.activity_list or {})
end)
manager.net:Bind(11003, function(arg_2_0)
	ActivityData:UpdateActivityData(arg_2_0.activity)
	ActivityRedPoint:OnActivityUpdate({
		arg_2_0.activity
	})
end)
manager.net:Bind(64031, function(arg_3_0)
	ActivityData:RefreshActivityTime(arg_3_0)
end)

local function var_0_1(arg_4_0, arg_4_1)
	if arg_4_0 == nil or #arg_4_0 == 0 then
		return nil
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		if iter_4_1.type == arg_4_1 then
			return iter_4_1
		end
	end
end

manager.net:Bind(40035, function(arg_5_0)
	ActivityData:InitActivitySuspendByControl(var_0_1(arg_5_0.sys_supend_list, 3), true)
end)

function var_0_0.DealWithAllActivityData()
	for iter_6_0, iter_6_1 in pairs((ActivityData:GetAllActivityData())) do
		var_0_0.DealWithActivityData(iter_6_1)
	end

	var_0_0.AfterDealWithActivityData()
end

function var_0_0:DealWithActivityData()
	local var_7_0 = ActivityTools.GetActivityType(self.id)

	if ActivityTemplateConst.MAIN_ACTIVITY == var_7_0 then
		var_0_0.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.DEMON == var_7_0 then
		SubDemonChallengeAction.Init()
		SubDemonChallengeAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.NEW_DEMON == var_7_0 then
		NewDemonChallengeAction.Init()
		NewDemonChallengeAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.TALENT_TREE == var_7_0 then
		TalentTreeAction.Init()
	elseif ActivityTemplateConst.BATTLE_FIRST_PASS == var_7_0 then
		BattleFirstPassAction.Init()
		BattleFirstPassAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.STORY == var_7_0 then
		var_0_0.InitStoryRedPoint(self.id)
	elseif ActivityTemplateConst.SOLO_CHALLENGE == var_7_0 then
		SoloChallengeAction.InitRedPoint(self.id)
	elseif ActivityTemplateConst.FISHING == var_7_0 then
		FishingAction.Init()
	elseif ActivityTemplateConst.LIMITED_CALCULATION == var_7_0 then
		LimitedCalculationAction.Init()
		LimitedCalculationAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.SKIN_EXCHANGE == var_7_0 then
		SkinExchangeAction.Init()
		SkinExchangeAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.SUMMER_ACTIVITY_PT == var_7_0 then
		SummerActivityPtAction.Init()
	elseif ActivityTemplateConst.ACTIVITY_PUZZLE == var_7_0 then
		PuzzleAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.COWBOY == var_7_0 then
		CowboyAction.Init()
		CowboyAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.ACTIVITY_RACE == var_7_0 then
		ActivityRaceAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.GUILD_ACTIVITY == var_7_0 then
		GuildActivityAction.Init()
	elseif ActivityTemplateConst.GUILD_ACTIVITY_SP == var_7_0 then
		GuildActivitySPAction.Init()
	elseif ActivityTemplateConst.XH1ST_SEAL == var_7_0 then
		XH1stSealAction.Init()
		XH1stSealAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.RACE_TRIAL == var_7_0 then
		RaceTrialAction.Init(self.id)
		RaceTrialAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.INFINITY_POOL_TASK == var_7_0 then
		var_0_0.InitInfinityPoolTaskRedPoint(self.id)
	elseif ActivityTemplateConst.MARDUK_SPECIAL == var_7_0 then
		MardukSpecialAction.Init(self.id)
	elseif ActivityTemplateConst.SURVIVE_SOLO == var_7_0 then
		SurviveSoloAction.Init(self.id)
		SurviveSoloAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.PAPER_CUT == var_7_0 then
		PaperCutAction.Init(self.id)
	elseif ActivityTemplateConst.SPRING_ANTITHETICAL_COUPLET == var_7_0 then
		AntitheticalCoupletAction.Init()
		AntitheticalCoupletAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.VALENTINE_GAME == var_7_0 or ActivityTemplateConst.INDIA_VALENTINE_GAME_V2 == var_7_0 then
		ValentineGameAction.Init()
		ValentineGameAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.ACTIVITY_AFFIX_SELECT == var_7_0 then
		ActivityAffixSelectAction.Init()
		ActivityAffixSelectAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.ACTIVITY_CULTIVATE_HERO == var_7_0 then
		CultivateHeroAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.ACTIVITY_PT_2 == var_7_0 then
		ActivityPt2Action.Init()
		ActivityPt2Action.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.ACTIVITY_SET == var_7_0 then
		var_0_0.InitActivitySetRedPoint(self.id)
	elseif ActivityTemplateConst.ACTIVITY_RECALL == var_7_0 then
		ActivityRecallAction.Init()
	elseif ActivityTemplateConst.SAIL_GAME == var_7_0 then
		SailGameAction.UpdateRedPoint(self.id)
	elseif ActivityTemplateConst.CHESS_ACTIVITY_CHINESE_ZONE == var_7_0 then
		RedPointData:UpdateRedPoint(self.id)
	elseif ActivityTemplateConst.ACTIVITY_2_2_WATER == var_7_0 then
		ActivityWaterAction.Init(self.id)
	elseif ActivityTemplateConst.ACTIVITY_FLIP_CARD == var_7_0 then
		XH3rdFlipCardAction:InitRedPointKey(self.id)
	elseif ActivityTemplateConst.ACTIVITY_SKIN_DRAW == var_7_0 then
		ActivitySkinDrawAction.Init()
		ActivitySkinDrawAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.ACTIVITY_OATH_DRAW_MAIN == var_7_0 then
		ActivityOathDrawAction.Init()
		ActivityOathDrawAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.JAPAN_SOLO_HEART_DEMON == var_7_0 then
		-- block empty
	elseif ActivityTemplateConst.ACTIVITY_INVITE == var_7_0 then
		InviteAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.DESTROY_BOX_GAME == var_7_0 then
		DestroyBoxGameAction.InitRedPoint(self.id)
	elseif ActivityTemplateConst.KAGUTSUCHI_ACTIVITY_PT_SCROLL == var_7_0 then
		ActivityPtScrollAction.Init()
		ActivityPtScrollAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.ACTIVITY_QUIZ == var_7_0 then
		ActivityQuizAction.Init()
		ActivityQuizAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.ACTIVITY_MEMORY == var_7_0 then
		ActivityMemoryAction.Init(self.id)
		ActivityMemoryAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.ACTIVITY_PUSH_BOX == var_7_0 then
		ActivityPushBoxAction.Init()
		ActivityPushBoxAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.HERO_LETTER == var_7_0 then
		ActivityHeroLetterAction.Init()
		ActivityHeroLetterAction.InitRedPointKey(self.id)
	elseif ActivityTemplateConst.ACTIVITY_USE_DUNDUN == var_7_0 then
		ActivityPointAction.InitDunDunRedPointKey(self.id)
	elseif ActivityTemplateConst.ACTIVITY_3_10_VALENTINEGAME_V3 == var_7_0 then
		ValentineGameAction.InitValentineGameV3RedPointKey(self.id)
	elseif ActivityTemplateConst.ACTIVITY_AUTO_COOK == var_7_0 then
		ActivityAutoCookAction.InitRedPoint(self.id)
	elseif var_7_0 == ActivityTemplateConst.ACTIVITY_BLOOD_CARD then
		BloodCardAction.InitRedPoint(self.id)
	elseif var_7_0 == ActivityTemplateConst.ACTIVITY_3_10_SANDPLAY_MAIN then
		QWorldAction.InitRedPoint(self.id)
	elseif var_7_0 == ActivityTemplateConst.SKIN_DISCOUNT_GIFT then
		SkinDiscountGiftAction.InitRedPoint(self.id)
	elseif ActivityTemplateConst.ACTIVITY_GOD_BOSS == var_7_0 then
		WeekBossAction.InitRedPointKey(self.id)
	elseif var_7_0 == ActivityTemplateConst.ACTIVITY_SKULD_MAIN then
		SkuldSystemAction.InitRedPoint()
	elseif var_7_0 == ActivityTemplateConst.ACTIVITY_SUMMER_PUB then
		SummerPubAction.InitRedPoint()
	elseif var_7_0 == ActivityTemplateConst.ASH_ACTIVITY_PUB then
		AshSystemAction.InitRedPoint()
	elseif var_7_0 == ActivityTemplateConst.ACTIVITY_AUTO_CHESS then
		AutoChessAction.InitRedPoint()
	elseif var_7_0 == ActivityTemplateConst.ACTIVITY_HODUR_MAIN then
		HodurAction.InitRedPoint()
	elseif var_7_0 == ActivityTemplateConst.ACTIVITY_AUTO_CHESS_4_8 then
		AutoChessMatchAction.InitRedPoint()
	elseif var_7_0 == ActivityTemplateConst.ICHIBAN then
		IchiBanAction.InitRedPoint(self.id)
	elseif var_7_0 == ActivityTemplateConst.PACHINKO then
		PaChinKoAction.InitRedPoint(self.id)
	elseif var_7_0 == ActivityTemplateConst.ANNIVERSARY_CELEBRATION_GIFT then
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in ipairs(ActivityTools.GetAllTaskSubActivityID(self.id)) do
			table.insert(var_7_1, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_7_1))

			local var_7_2 = "ANNIVERSARY_CELEBRATION_GIFT_REMIND_TASK_AVAILABLE" .. iter_7_1

			manager.redPoint:setTip("ANNIVERSARY_CELEBRATION_GIFT_REMIND_TASK_AVAILABLE" .. iter_7_1, TaskTools.IsAnyTaskNotCompleted(iter_7_1) and 1 or 0)
			table.insert(var_7_1, var_7_2)
		end

		manager.redPoint:addGroup(ActivityTools.GetRedPointKey(self.id) .. self.id, var_7_1)
	elseif var_7_0 == ActivityTemplateConst.ROGUE_CARD_GAME then
		RogueCardGameAction.InitRedPoint()
	elseif var_7_0 == ActivityTemplateConst.ACTIVITY_WULO_VEHICLE_BALL then
		VehicleBallAction.InitRedPoint()
	end
end

function var_0_0.AfterDealWithActivityData()
	SkuldTravelData:InitRedPointGroup()
end

manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_9_0)
	var_0_0.UpdateRedPoint(arg_9_0)
end)

function var_0_0.UpdateRedPoint(arg_10_0)
	local var_10_0 = ActivityTools.GetActivityType(arg_10_0)

	if var_10_0 == ActivityTemplateConst.ACTIVITY_PUZZLE then
		if ActivityData:GetActivityData(arg_10_0).stopTime <= manager.time:GetServerTime() then
			for iter_10_0, iter_10_1 in ipairs(ActivityCfg[arg_10_0].sub_activity_list) do
				manager.redPoint:setTip(string.format("%s_%s_%s_normal", RedPointConst.ACTIVITY_PUZZLE, arg_10_0, iter_10_1), 0)
				manager.redPoint:setTip(string.format("%s_%s_%s_video", RedPointConst.ACTIVITY_PUZZLE, arg_10_0, iter_10_1), 0)
			end
		end
	elseif arg_10_0 == ActivityConst.MOONBO then
		MoonBoData:FreshTime()
	elseif var_10_0 == ActivityTemplateConst.HERO_TRIAL and (manager.time:GetServerTime() < ActivityData:GetActivityData(arg_10_0).stopTime or true) then
		-- block empty
	elseif var_10_0 == ActivityTemplateConst.SKIN_TRIAL then
		SkinTrialAction.UpdateRedPoint(arg_10_0)
	elseif var_10_0 == ActivityTemplateConst.SUMMER_ACTIVITY_PT then
		SummerActivityPtAction.UpdateRedPoint(arg_10_0)
	elseif var_10_0 == ActivityTemplateConst.COWBOY then
		CowboyAction:CloseActivity(arg_10_0)
	elseif var_10_0 == ActivityTemplateConst.ACTIVITY_RACE then
		ActivityRaceAction.UpdateRedPoint(arg_10_0)
	elseif var_10_0 == ActivityTemplateConst.GUILD_ACTIVITY then
		GuildActivityAction.UpdateRedPoint(arg_10_0)
	elseif var_10_0 == ActivityTemplateConst.GUILD_ACTIVITY_SP then
		GuildActivitySPAction.UpdateRedPoint(arg_10_0)
	elseif var_10_0 == ActivityTemplateConst.DEMON then
		SubDemonChallengeAction.RefreshRedPoint(arg_10_0)
	elseif var_10_0 == ActivityTemplateConst.RACE_TRIAL then
		RaceTrialAction.UpdateRedPoint(arg_10_0)
	elseif var_10_0 == ActivityTemplateConst.STORY then
		local var_10_2 = ActivityTools.GetRedPointKey(arg_10_0) .. arg_10_0

		if ActivityData:GetActivityData(arg_10_0).stopTime <= manager.time:GetServerTime() then
			var_0_0.ClearRedPoint(arg_10_0)
			manager.redPoint:updateKey(var_10_2)
		elseif #(manager.redPoint:getchildKeys(var_10_2) or {}) <= 0 then
			var_0_0.InitStoryRedPoint(arg_10_0)
			manager.redPoint:updateKey(var_10_2)
			var_0_0.UpdateRedPointDLC_5_2(ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC)
		end

		TaskRedPoint:UpdateChapterPlot19RedTip()
	elseif var_10_0 == ActivityTemplateConst.STORY_STAGE then
		if ActivityData:GetActivityData(arg_10_0).stopTime <= manager.time:GetServerTime() then
			ActivityStoryAction.UpdateRedPoint(arg_10_0, 0)
		end
	elseif var_10_0 == ActivityTemplateConst.MAIN_STORY then
		if ActivityData:GetActivityData(arg_10_0).stopTime <= manager.time:GetServerTime() then
			for iter_10_2, iter_10_3 in ipairs(ActivityCfg[arg_10_0].sub_activity_list) do
				manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(iter_10_3), iter_10_3), 0)
			end
		end

		BattleStageAction.UpdateActivityRedPoint()
	elseif var_10_0 == ActivityTemplateConst.SUB_PLOT then
		BattleStageAction.UpdateSubPlotRedPoint()
	elseif var_10_0 == ActivityTemplateConst.ENDLESS then
		BattleStageAction.UpdateActivityRedPoint()
	elseif var_10_0 == ActivityTemplateConst.MARDUK_SPECIAL then
		if arg_10_0 == ActivityConst.FACTORY_MARDUK then
			MardukSpecialAction.UpdateRedPoint(arg_10_0)
		end

		if arg_10_0 == ActivityConst.ACTIVITY_2_2_SPECIAL then
			MardukSpecialAction.UpdateRedPoint(arg_10_0)
		end
	elseif var_10_0 == ActivityTemplateConst.SEQUENTIAL_BATTLE then
		if ActivityData:GetActivityData(arg_10_0).stopTime <= manager.time:GetServerTime() then
			SequentialBattleAction.OverActivity(arg_10_0)
		end
	elseif var_10_0 == ActivityTemplateConst.SEQUENTIAL_BATTLE_SUB then
		SequentialBattleAction.StopRedPoint(arg_10_0)
	elseif var_10_0 == ActivityTemplateConst.SPRING_FESTIVAL_GREETING then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_GREETING, arg_10_0), 0)
	elseif var_10_0 == ActivityTemplateConst.SPRING_FESTIVAL_RIDDLE then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SPRING_FESTIVAL_RIDDLE, arg_10_0))
	elseif arg_10_0 == ActivityConst.ACTIVITY_1_6 then
		SkuldTravelAction:CheckUnBindActivitySkuld()
		SkuldTravelAction:CheckUnBindChapterKey()
	elseif arg_10_0 == ActivityConst.CHESS_ACTIVITY_CHINESE_ZONE then
		RedPointData:UpdateRedPoint(arg_10_0)
	elseif ActivityTemplateConst.ACTIVITY_PROMOTINAL == var_10_0 then
		var_0_0.UpdatePromotinalRedPoint(arg_10_0)
	elseif ActivityTemplateConst.ACTIVITY_2_2_WATER_SCHEDULE == var_10_0 or ActivityTemplateConst.ACTIVITY_2_2_WATER == var_10_0 then
		ActivityWaterAction.UpdateRedPoint()
	elseif ActivityTemplateConst.LIMITED_CALCULATION == var_10_0 then
		LimitedCalculationAction:RefreshRedPoint(arg_10_0)
	elseif ActivityTemplateConst.SOLO_CHALLENGE == var_10_0 then
		SoloChallengeAction.CloseRedPoint(arg_10_0)
	elseif ActivityTemplateConst.ABYSS == var_10_0 then
		local var_10_3 = manager.time:GetServerTime() + 1

		if ActivityData:GetActivityData(arg_10_0).stopTime <= var_10_3 and var_10_3 >= AbyssData:GetRefreshTimestamp() then
			AbyssAction.UpdateRedPoints()
		end
	elseif ActivityTemplateConst.POLYHEDRON_ACTIVITY == var_10_0 then
		local var_10_4 = manager.time:GetServerTime() + 1

		if ActivityData:GetActivityData(arg_10_0).stopTime <= var_10_4 and var_10_4 >= ActivityData:GetActivityData((PolyhedronData:GetActivityID())).stopTime then
			PolyhedronAction.RefreshPolicyRedPoint()
			PolyhedronAction.CheckBeaconRedPoint()
			PolyhedronAction.CheckTerminalRedPoint()
			PolyhedronAction.RefreshHeroesRedPoint()
		end

		manager.notify:Invoke(MATRIX_UPDATE)
	elseif ActivityTemplateConst.MOON_CAKE_MAKE == var_10_0 then
		if not ActivityData:GetActivityIsOpen(arg_10_0) then
			MoonCakeAction.CloseCakeStageRedPoint(arg_10_0)
		end
	elseif ActivityTemplateConst.MOON_CAKE_PARTY == var_10_0 then
		if not ActivityData:GetActivityIsOpen(arg_10_0) then
			MoonCakeAction.ClosePartytageRedPoint(arg_10_0)
		end
	elseif ActivityTemplateConst.DESTROY_BOX_GAME == var_10_0 then
		DestroyBoxGameAction.UpdateMainActivityRedPoint(arg_10_0)
	elseif ActivityTemplateConst.DESTROY_BOX_GAME_STAGE == var_10_0 then
		DestroyBoxGameAction.UpdateRedPoint(arg_10_0)
	elseif ActivityTemplateConst.KAGUTSUCHI_ACTIVITY_PT_SCROLL == var_10_0 then
		ActivityPtScrollAction.RefreshRedPoint(arg_10_0)
	elseif ActivityTemplateConst.VALENTINE_GAME_LEVEL == var_10_0 or ActivityTemplateConst.INDIA_VALENTINE_GAME_V2_SUBACTIVITY == var_10_0 then
		ValentineGameAction:RefreshRedPoint(arg_10_0)
	elseif ActivityTemplateConst.ACTIVITY_QUIZ == var_10_0 then
		ActivityQuizAction.RefreshRedPoint(arg_10_0)
	elseif ActivityTemplateConst.ACTIVITY_MEMORY == var_10_0 then
		ActivityMemoryAction.RefreshRedPoint(arg_10_0)
	elseif ActivityTemplateConst.SURVIVE_SOLO == var_10_0 then
		SurviveSoloAction:RefreshRedPoint(arg_10_0)
	elseif ActivityTemplateConst.ACTIVITY_CULTIVATE_HERO == var_10_0 then
		CultivateHeroAction.RefreshRedPoint(arg_10_0)
	elseif ActivityTemplateConst.ACTIVITY_PUSH_BOX == var_10_0 then
		ActivityPushBoxAction.RefreshRedPoint(arg_10_0)
	elseif ActivityTemplateConst.HERO_LETTER == var_10_0 then
		ActivityHeroLetterAction.RefreshRedPoint(arg_10_0)
	elseif arg_10_0 == ActivityConst.SUMMER_CHESS_BOARD_ENTRY then
		ActivitySummerChessBoardAction.InitPageRedPoint(arg_10_0)
	elseif arg_10_0 == ActivityConst.SUMMER_CHESS_BOARD_MAIN then
		ActivitySummerChessBoardAction.InitMainRedPoint(arg_10_0)
	elseif ActivityTemplateConst.ACTIVITY_WHACK_MOLE == var_10_0 then
		WhackMoleAction.UpdateRedPoint(arg_10_0)
	elseif ActivityTemplateConst.ACTIVITY_AUTO_COOK == var_10_0 then
		ActivityAutoCookAction.UpdateRedPoint(arg_10_0)
	elseif ActivityTemplateConst.ACTIVITY_DRAW_BONUS == var_10_0 then
		DrawAction.UpdateRedPoint(arg_10_0)
	elseif ActivityTemplateConst.ACTIVITY_MUSIC == var_10_0 then
		MusicAction.InitMusicRedPoint(arg_10_0)
	elseif ActivityTemplateConst.ICHIBAN == var_10_0 then
		IchiBanAction.UpdateRedPoint(arg_10_0)
	elseif ActivityTemplateConst.PACHINKO == var_10_0 then
		PaChinKoAction.UpdateRedPoint(arg_10_0)
	end

	if SpringPreheatAction then
		SpringPreheatAction:RefreshRedPoint()
	end

	if HeroTrialData then
		HeroTrialData:RefreshRedData()
	end

	var_0_0.UpdateShopRedPoint(arg_10_0)
end

function var_0_0.InitRedPointKey(arg_11_0)
	local var_11_1 = {}

	if not ActivityCfg[arg_11_0].sub_activity_list or #ActivityCfg[arg_11_0].sub_activity_list == 0 then
		return
	end

	if arg_11_0 == ActivityConst.OSIRIS_ACTIVITY then
		manager.redPoint:addGroup(string.format("%s%s", RedPointConst.MAIN_ACTIVITY, arg_11_0), {
			string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ActivityConst.OSIRIS_TASK_DAILY),
			string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.OSIRIS_CHESS),
			RedPointConst.OSIRIS_DEMON,
			RedPointConst.OSIRIS_RACE_TRIAL,
			string.format("%s_%s", RedPointConst.HERO_TRIAL, ActivityConst.OSIRIS_HERO_TRIAL_STAGE)
		})

		return
	end

	for iter_11_0, iter_11_1 in ipairs(ActivityCfg[arg_11_0].sub_activity_list) do
		table.insert(var_11_1, ActivityTools.GetRedPointKey(iter_11_1) .. iter_11_1)
	end

	manager.redPoint:addGroup(RedPointConst.MAIN_ACTIVITY .. arg_11_0, var_11_1)
end

function var_0_0.InitSubRedPoint(arg_12_0)
	if #ActivityCfg[arg_12_0].sub_activity_list <= 0 then
		return
	end

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(ActivityCfg[arg_12_0].sub_activity_list) do
		var_0_0.InitSubRedPoint(iter_12_1)
		table.insert(var_12_0, ActivityTools.GetRedPointKey(iter_12_1) .. iter_12_1)
	end

	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(arg_12_0) .. arg_12_0, var_12_0)
end

function var_0_0.InitStoryRedPoint(arg_13_0)
	local var_13_0 = {}

	if ActivityCfg[arg_13_0] == nil then
		return
	end

	for iter_13_0, iter_13_1 in ipairs(ActivityCfg[arg_13_0].sub_activity_list) do
		if ActivityCfg[iter_13_1].activity_template == ActivityTemplateConst.STORY_STAGE or ActivityCfg[iter_13_1].activity_template == ActivityTemplateConst.SUB_PLOT or ActivityCfg[iter_13_1].activity_template == ActivityTemplateConst.MAIN_STORY or iter_13_1 == ActivityConst.ACTIVITY_NYA_SUMMER_RACE_SKIN_DLC then
			table.insert(var_13_0, ActivityTools.GetRedPointKey(iter_13_1) .. iter_13_1)
			var_0_0.InitSubRedPoint(iter_13_1)
		elseif ActivityCfg[iter_13_1].activity_template == ActivityTemplateConst.CHESS then
			table.insert(var_13_0, string.format("%s_%s", RedPointConst.WAR_CHESS, iter_13_1))
		end
	end

	if ActivityCfg[arg_13_0].activity_theme == ActivityConst.THEME.SUMMER then
		table.insert(var_13_0, string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityCfg[arg_13_0].activity_theme))

		local var_13_1 = {}

		for iter_13_2, iter_13_3 in ipairs(ActivityStoryCollect[ActivityCfg[arg_13_0].activity_theme].story_id) do
			table.insert(var_13_1, string.format("%s_%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityCfg[arg_13_0].activity_theme, iter_13_3))
		end

		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityCfg[arg_13_0].activity_theme), var_13_1)
		table.insert(var_13_0, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, 6010003))
	end

	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(arg_13_0) .. arg_13_0, var_13_0)
end

function var_0_0.ClearRedPoint(arg_14_0)
	manager.redPoint:addGroup(ActivityTools.GetRedPointKey(arg_14_0) .. arg_14_0, {}, true)
end

function var_0_0.InitInfinityPoolTaskRedPoint(arg_15_0)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(ActivityCfg[arg_15_0].sub_activity_list) do
		if ActivityCfg[iter_15_1].activity_template == ActivityTemplateConst.TASK then
			table.insert(var_15_0, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_15_1))
		end
	end

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.INFINITY_POOL_TASK, arg_15_0), var_15_0)
end

function var_0_0.InitActivitySetRedPoint(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(ActivityCfg[arg_16_0].sub_activity_list) do
		if ActivityCfg[iter_16_1].activity_template == ActivityTemplateConst.TASK then
			table.insert(var_16_0, string.format("%s_%s", RedPointConst.ACTIVITY_TASK, iter_16_1))
		elseif ActivityCfg[iter_16_1].activity_template == ActivityTemplateConst.ACTIVITY_SHOP then
			table.insert(var_16_0, string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, iter_16_1))
		end
	end

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_SET, arg_16_0), var_16_0)
end

function var_0_0.InitLoginShopRedPoint()
	for iter_17_0, iter_17_1 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_SHOP]) do
		if ActivityData:GetActivityIsOpen(iter_17_1) and manager.time:GetServerTime() + 259200 >= ActivityData:GetActivityData(iter_17_1).stopTime and ActivityShopCfg[iter_17_1] then
			for iter_17_2, iter_17_3 in ipairs(ShopListCfg[ActivityShopCfg[iter_17_1].shop_id].cost_id or {}) do
				if ItemTools.getItemNum(iter_17_3) > 0 then
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, iter_17_1), 1)

					break
				end
			end
		end
	end
end

function var_0_0.UpdateShopRedPoint(arg_18_0)
	if ActivityCfg[arg_18_0] == nil then
		print("no exist activity config :", acitvityID)

		return
	end

	if ActivityCfg[arg_18_0].activity_template == ActivityTemplateConst.ACTIVITY_SHOP and not ActivityData:GetActivityIsOpen(arg_18_0) then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SHOP, arg_18_0), 0)
	end
end

function var_0_0.UpdatePromotinalRedPoint(arg_19_0)
	local var_19_0 = string.format("%s%s", ActivityTools.GetRedPointKey(arg_19_0), arg_19_0)

	if not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_RANGE + arg_19_0) and ActivityTools.GetActivityStatus(arg_19_0) == 1 then
		manager.redPoint:setTip(var_19_0, 1)
	else
		manager.redPoint:setTip(var_19_0, 0)
	end
end

function var_0_0.OnLogin()
	manager.notify:Invoke(ON_LOGIN)
end

function var_0_0.OnLogout()
	PaperCutTool:OnLogout()
	SailGameTools.ShutDown()
	AutoChessTools.ShotDownBattle()
	RogueCardGameBridge.ShutDown()
end

function var_0_0.ReceivePointReward(arg_22_0)
	manager.net:SendWithLoadingNew(60054, {
		point_reward_id_list = arg_22_0
	}, 60055, var_0_0.OnReceivePointReward)
end

function var_0_0:OnReceivePointReward(arg_23_1)
	if isSuccess(self.result) then
		for iter_23_0, iter_23_1 in ipairs(arg_23_1.point_reward_id_list) do
			local var_23_0 = ActivityTools.GetActivityType(ActivityPointRewardCfg[iter_23_1].activity_id)

			if ActivityTemplateConst.LIMITED_CALCULATION == var_23_0 then
				LimitedCalculationAction:OnReceivePointReward(ActivityPointRewardCfg[iter_23_1].activity_id, ActivityPointRewardCfg[iter_23_1].id)
			elseif ActivityTemplateConst.SUB_SINGLE_MATRIX == var_23_0 then
				ActivityMatrixAction.OnReceivePointReward(ActivityPointRewardCfg[iter_23_1].activity_id, ActivityPointRewardCfg[iter_23_1].id)
			elseif ActivityTemplateConst.CHALLENGE_ROGUE_TEAM_SCORE == var_23_0 then
				ChallengeRogueTeamData:SetRewardedScoreList(ChallengeRogueTeamTools.GetTeamplateIDByActivityID(ActivityPointRewardCfg[iter_23_1].activity_id), {
					iter_23_1
				})
			end
		end

		getReward2(mergeReward2(self.reward_list))
		manager.notify:Invoke(ACTIVITY_REWARD_GET, {
			point_reward_id_list = arg_23_1.point_reward_id_list
		})
		manager.notify:CallUpdateFunc(RECEIVE_POINT_REWARD, arg_23_1.point_reward_id_list)
	else
		ShowTips(self.result)
	end
end

function var_0_0.ReceivePointRewardWithCallBack(arg_24_0, arg_24_1)
	manager.net:SendWithLoadingNew(60054, {
		point_reward_id_list = arg_24_0
	}, 60055, function(arg_25_0, arg_25_1)
		var_0_0.OnReceivePointRewardWithCallBack(arg_25_0, arg_25_1, arg_24_1)
	end)
end

function var_0_0:OnReceivePointRewardWithCallBack(arg_26_1, arg_26_2)
	if isSuccess(self.result) then
		for iter_26_0, iter_26_1 in ipairs(arg_26_1.point_reward_id_list) do
			local var_26_0 = ActivityTools.GetActivityType(ActivityPointRewardCfg[iter_26_1].activity_id)

			if ActivityTemplateConst.LIMITED_CALCULATION == var_26_0 then
				LimitedCalculationAction:OnReceivePointReward(ActivityPointRewardCfg[iter_26_1].activity_id, ActivityPointRewardCfg[iter_26_1].id)
			elseif ActivityTemplateConst.SUB_SINGLE_MATRIX == var_26_0 then
				ActivityMatrixAction.OnReceivePointReward(ActivityPointRewardCfg[iter_26_1].activity_id, ActivityPointRewardCfg[iter_26_1].id)
			end
		end

		getReward2(mergeReward2(self.reward_list))
		manager.notify:Invoke(ACTIVITY_REWARD_GET, {
			point_reward_id_list = arg_26_1.point_reward_id_list
		})
		manager.notify:CallUpdateFunc(RECEIVE_POINT_REWARD, arg_26_1.point_reward_id_list)

		if arg_26_2 then
			arg_26_2(arg_26_1.point_reward_id_list)
		end
	else
		ShowTips(self.result)
	end
end

function var_0_0.GetBonus(arg_27_0)
	manager.net:SendWithLoadingNew(60054, {
		point_reward_id_list = arg_27_0
	}, 60055, var_0_0.OnGetBonusCallback)
end

function var_0_0:OnGetBonusCallback(arg_28_1)
	if isSuccess(self.result) then
		getReward2(mergeReward2(self.reward_list))
		manager.notify:Invoke(ACTIVITY_REWARD_GET, {
			point_reward_id_list = arg_28_1.point_reward_id_list
		})
	else
		ShowTips(GetTips(self.result))
	end
end

function var_0_0.UpdateRedPointDLC_5_2(arg_29_0)
	local var_29_0 = AssignmentCfg.get_id_list_by_activity_id[arg_29_0] or {}
	local var_29_1 = 0

	for iter_29_0 = 1, 2 do
		if var_29_0[iter_29_0] then
			local var_29_2 = TaskData2:GetTask(var_29_0[iter_29_0])

			if var_29_2 and var_29_2.complete_flag < 1 and var_29_2.progress >= 1 then
				var_29_1 = var_29_1 + 1
			end
		end
	end

	local var_29_3 = string.format("%s%s", ActivityTools.GetRedPointKey(arg_29_0), arg_29_0)

	if var_29_1 > 0 then
		manager.redPoint:setTip(var_29_3, 1)
	else
		manager.redPoint:setTip(var_29_3, 0)
	end
end

return var_0_0
