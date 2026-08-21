local var_0_0 = {}
local var_0_1 = require("cjson")

function var_0_0.ShutDown()
	return
end

local var_0_2 = {
	[101] = {
		241,
		242,
		243,
		244
	},
	[102] = {
		245,
		2451,
		246,
		247
	},
	[103] = {
		2471,
		248,
		2481,
		249
	},
	[104] = {
		250
	},
	[105] = {
		2501
	},
	[106] = {
		251
	},
	[201] = {
		255
	}
}
local var_0_3 = ""
local var_0_4 = {}
local var_0_5 = ""
local var_0_6 = {}

function var_0_0.InGame()
	if RogueCard.RogueCardGameMain.Instance == nil then
		return false
	end

	return true
end

local function var_0_7(arg_3_0)
	return (var_0_1.decode(arg_3_0))
end

local function var_0_8(arg_4_0)
	return (var_0_1.encode(arg_4_0):gsub("{}", "[]"):gsub("{}", "[]"))
end

local function var_0_9(arg_5_0)
	local var_5_0 = {}

	if arg_5_0 == nil or arg_5_0 == "" then
		return var_5_0
	end

	if type(arg_5_0) == "table" then
		return arg_5_0
	end

	for iter_5_0 = 0, arg_5_0.Count - 1 do
		table.insert(var_5_0, arg_5_0[iter_5_0])
	end

	return var_5_0
end

local function var_0_10(arg_6_0, arg_6_1)
	if not arg_6_0 then
		return arg_6_1
	end

	local var_6_0 = {}

	if type(arg_6_0) == "table" then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
			var_6_0[iter_6_0] = iter_6_1
		end
	end

	return var_6_0
end

local function var_0_11(arg_7_0, arg_7_1)
	if arg_7_0 == nil then
		return arg_7_1
	end

	return arg_7_0
end

local function var_0_12(arg_8_0, arg_8_1)
	if arg_8_0 == nil then
		return arg_8_1
	end

	return arg_8_0
end

local function var_0_13(arg_9_0)
	if not arg_9_0 then
		return nil
	end

	return {
		suit = var_0_11(arg_9_0.suit, 0),
		rank = var_0_11(arg_9_0.rank, 0),
		enhance_id = var_0_11(arg_9_0.enhance_id, 0),
		tag_id = var_0_11(arg_9_0.tag_id, 0),
		effect_disable = var_0_11(arg_9_0.effect_disable, false),
		other_data = var_0_10(arg_9_0.other_data, {})
	}
end

local function var_0_14(arg_10_0)
	if not arg_10_0 then
		return nil
	end

	return {
		id = var_0_11(arg_10_0.id, 0),
		real_id = var_0_11(arg_10_0.real_id, 0),
		version_id = var_0_11(arg_10_0.version_id, 0),
		add_point = var_0_11(arg_10_0.add_point, 0),
		add_mutli = var_0_11(arg_10_0.add_mutli, 0),
		mul_ratio = var_0_11(arg_10_0.mul_ratio, 0),
		other_data = var_0_10(arg_10_0.other_data, {})
	}
end

function fillImpermanenceSaveDataFromProto(arg_11_0, arg_11_1)
	if not arg_11_0 then
		print("错误: proto数据为空")

		return arg_11_1
	end

	arg_11_1.cur_state = var_0_11(arg_11_0.cur_state, 0)
	arg_11_1.record_items = var_0_10(arg_11_0.record_items, {})
	arg_11_1.global_attr_dic = var_0_10(arg_11_0.global_attr_dic, {})
	arg_11_1.stage_id = var_0_11(arg_11_0.stage_id, 0)
	arg_11_1.cur_round = var_0_11(arg_11_0.cur_round, 0)
	arg_11_1.cur_stage_state = var_0_11(arg_11_0.cur_stage_state, 0)
	arg_11_1.hand_type_level = var_0_10(arg_11_0.hand_type_level, {})
	arg_11_1.gold = var_0_11(arg_11_0.gold, 0)
	arg_11_1.random_seed = var_0_11(arg_11_0.random_seed, 0)
	arg_11_1.deck_cards = {}

	if arg_11_0.deck_cards and type(arg_11_0.deck_cards) == "table" then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0.deck_cards) do
			local var_11_0 = var_0_13(iter_11_1)

			if var_11_0 then
				table.insert(arg_11_1.deck_cards, var_11_0)
			end
		end
	end

	arg_11_1.pile_cards = {}

	if arg_11_0.pile_cards and type(arg_11_0.pile_cards) == "table" then
		for iter_11_2, iter_11_3 in ipairs(arg_11_0.pile_cards) do
			local var_11_1 = var_0_13(iter_11_3)

			if var_11_1 then
				table.insert(arg_11_1.pile_cards, var_11_1)
			end
		end
	end

	arg_11_1.hand_cards = {}

	if arg_11_0.hand_cards and type(arg_11_0.hand_cards) == "table" then
		for iter_11_4, iter_11_5 in ipairs(arg_11_0.hand_cards) do
			local var_11_2 = var_0_13(iter_11_5)

			if var_11_2 then
				table.insert(arg_11_1.hand_cards, var_11_2)
			end
		end
	end

	arg_11_1.jokers = {}

	if arg_11_0.jokers and type(arg_11_0.jokers) == "table" then
		for iter_11_6, iter_11_7 in ipairs(arg_11_0.jokers) do
			local var_11_3 = var_0_14(iter_11_7)

			if var_11_3 then
				table.insert(arg_11_1.jokers, var_11_3)
			end
		end
	end

	arg_11_1.play_num = var_0_11(arg_11_0.play_num, 0)
	arg_11_1.discard_num = var_0_11(arg_11_0.discard_num, 0)
	arg_11_1.score = var_0_11(arg_11_0.score, 0)
	arg_11_1.target_score = var_0_11(arg_11_0.target_score, 0)
	arg_11_1.boss_target_score = var_0_11(arg_11_0.boss_target_score, 0)
	arg_11_1.round_play_num = var_0_11(arg_11_0.round_play_num, 0)
	arg_11_1.round_discard_num = var_0_11(arg_11_0.round_discard_num, 0)
	arg_11_1.shop_item_data_list = var_0_10(arg_11_0.shop_item_data_list, {})
	arg_11_1.shop_package_data_list = var_0_10(arg_11_0.shop_package_data_list, {})
	arg_11_1.cur_refresh_cost = var_0_11(arg_11_0.cur_refresh_cost, 0)
	arg_11_1.wu_chang_reset_num = var_0_11(arg_11_0.wu_chang_reset_num, 0)
	arg_11_1.white_wu_chang_id = var_0_11(arg_11_0.white_wu_chang_id, 0)
	arg_11_1.black_wu_chang_id = var_0_11(arg_11_0.black_wu_chang_id, 0)
	arg_11_1.weal_woe_refresh_num = var_0_11(arg_11_0.weal_woe_refresh_num, 0)
	arg_11_1.weal_list = var_0_10(arg_11_0.weal_list, {})
	arg_11_1.woe_list = var_0_10(arg_11_0.woe_list, {})
	arg_11_1.cur_woe_id = var_0_11(arg_11_0.cur_woe_id, 0)
	arg_11_1.is_other_suit = var_0_11(arg_11_0.is_other_suit, false)
	arg_11_1.is_better_straight = var_0_11(arg_11_0.is_better_straight, false)
	arg_11_1.is_always_wu_chang = var_0_11(arg_11_0.is_always_wu_chang, false)
	arg_11_1.is_disable_type = var_0_11(arg_11_0.is_disable_type, false)
	arg_11_1.disable_type = var_0_10(arg_11_0.disable_type, {})
	arg_11_1.is_only_type = var_0_11(arg_11_0.is_only_type, false)
	arg_11_1.only_type = var_0_11(arg_11_0.only_type, -1)
	arg_11_1.hand_trigger = var_0_11(arg_11_0.hand_trigger, false)
	arg_11_1.ignore_woe = var_0_11(arg_11_0.ignore_woe, false)
	arg_11_1.ignore_spade = var_0_11(arg_11_0.ignore_spade, false)
	arg_11_1.is_odd_even = var_0_11(arg_11_0.is_odd_even, false)
	arg_11_1.odd_value = var_0_11(arg_11_0.odd_value, 0)
	arg_11_1.even_value = var_0_11(arg_11_0.even_value, 0)
	arg_11_1.deck_id = var_0_11(arg_11_0.deck_id, 0)
	arg_11_1.difficulty = var_0_11(arg_11_0.difficulty, 0)
	arg_11_1.roll_back_num = var_0_11(arg_11_0.roll_back_num, 0)
	arg_11_1.other_data = var_0_10(arg_11_0.other_data, {})
	arg_11_1.settle_data = {}

	if arg_11_0.settle_data then
		local var_11_4 = arg_11_0.settle_data
		local var_11_5 = {}

		if var_11_4.hand_type_use_num and type(var_11_4.hand_type_use_num) == "table" then
			for iter_11_8, iter_11_9 in ipairs(var_11_4.hand_type_use_num) do
				var_11_5[iter_11_8] = iter_11_9
			end
		end

		local var_11_6 = {}

		if var_11_4.hand_type_contain_num and type(var_11_4.hand_type_contain_num) == "table" then
			for iter_11_10, iter_11_11 in ipairs(var_11_4.hand_type_contain_num) do
				var_11_6[iter_11_10] = iter_11_11
			end
		end

		local var_11_7 = {}

		if var_11_4.use_item_id and type(var_11_4.use_item_id) == "table" then
			for iter_11_12, iter_11_13 in ipairs(var_11_4.use_item_id) do
				var_11_7[iter_11_12] = iter_11_13
			end
		end

		local var_11_8 = {}

		if var_11_4.use_item_id and type(var_11_4.enhance_id) == "table" then
			for iter_11_14, iter_11_15 in ipairs(var_11_4.enhance_id) do
				var_11_8[iter_11_14] = iter_11_15
			end
		end

		local var_11_9 = {}

		if var_11_4.use_item_id and type(var_11_4.weal_woe_id) == "table" then
			for iter_11_16, iter_11_17 in ipairs(var_11_4.weal_woe_id) do
				var_11_9[iter_11_16] = iter_11_17
			end
		end

		arg_11_1.settle_data = {
			hand_type_use_num = var_11_5,
			hand_type_contain_num = var_11_6,
			use_item_id = var_11_7,
			enhance_id = var_11_8,
			weal_woe_id = var_11_9,
			most_hand_type = var_0_11(var_11_4.most_hand_type, 0),
			round = var_0_11(var_11_4.round, 0),
			max_score = var_0_11(var_11_4.max_score, 0),
			use_card_num = var_0_11(var_11_4.use_card_num, 0),
			discard_num = var_0_11(var_11_4.discard_num, 0),
			black_wu_chang_num = var_0_11(var_11_4.black_wu_chang_num, 0),
			white_wu_chang_num = var_0_11(var_11_4.white_wu_chang_num, 0),
			gain_gold_num = var_0_11(var_11_4.gain_gold_num, 0),
			score = var_0_11(var_11_4.score, 0),
			use_gold_num = var_0_11(var_11_4.use_gold_num, 0),
			gain_joker_num = var_0_11(var_11_4.gain_joker_num, 0),
			use_a_num = var_0_11(var_11_4.use_a_num, 0),
			use_enhance_num = var_0_11(var_11_4.use_enhance_num, 0)
		}
	end

	arg_11_1.cur_package_id = var_0_11(arg_11_0.cur_package_id, 0)
	arg_11_1.cur_package_wuchang = var_0_11(arg_11_0.cur_package_wuchang, 0)
	arg_11_1.last_package_num = var_0_11(arg_11_0.last_package_num, 0)
	arg_11_1.package_joker_id = var_0_10(arg_11_0.package_joker_id, {})
	arg_11_1.package_wuchang_id = var_0_10(arg_11_0.package_wuchang_id, {})
	arg_11_1.wu_chang_wait_cards = {}

	if arg_11_0.wu_chang_wait_cards and type(arg_11_0.wu_chang_wait_cards) == "table" then
		for iter_11_18, iter_11_19 in ipairs(arg_11_0.wu_chang_wait_cards) do
			local var_11_10 = var_0_13(iter_11_19)

			if var_11_10 then
				table.insert(arg_11_1.wu_chang_wait_cards, var_11_10)
			end
		end
	end

	return arg_11_1
end

function var_0_0.GetVolume()
	return manager.audio:GetMusicVolume()
end

function var_0_0.GetGuideData(arg_13_0)
	local var_13_0 = GameSetting[arg_13_0].value

	return GameSetting[arg_13_0].value
end

function var_0_0.CheckGuideData(arg_14_0)
	if GameSetting[arg_14_0] == nil then
		return false
	end

	return true
end

function var_0_0.CheckScorePause(arg_15_0)
	if manager and manager.guide and manager.guide:GetCurrentGuideStepID() == arg_15_0 then
		return true
	end

	return false
end

function var_0_0.CheckTeamMessage(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if manager and manager.notify then
		manager.notify:Invoke(ROGUE_CARD_GAME_CHECK_TEAM_MESSAGE, arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	end
end

function var_0_0.LuaSettle(arg_17_0)
	if manager and manager.notify then
		manager.notify:Invoke(ROGUE_CARD_GAME_SETTLE_MESSAGE, arg_17_0)
	end
end

function var_0_0.LuaCheckFinishMessage(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if not arg_18_3 then
		return
	end

	if manager and manager.notify then
		manager.notify:Invoke(ROGUE_CARD_GAME_FINISH_MESSAGE, arg_18_0, arg_18_1, arg_18_2)
	end
end

function var_0_0.GetSpeedUpData()
	return GameSetting.rogue_card_speed_up.value[2]
end

function var_0_0.GetScoreStageData()
	return GameSetting.rogue_card_max_round.value
end

function var_0_0.GetScoreDifficultData()
	return GameSetting.rogue_card_challenge_exponential_coefficient.value
end

function var_0_0.GetScoreRatioData()
	return GameSetting.rogue_card_exponential_coefficient.value
end

function var_0_0.GetChallengeScoreData()
	return {
		GameSetting.rogue_card_endless_target_score.value[1],
		GameSetting.rogue_card_max_score.value[1]
	}
end

function var_0_0.GetRollbackData()
	return GameSetting.rogue_card_restart.value
end

function var_0_0.OpenDeckInfo()
	JumpTools.OpenPageByJump("rogueCardGameDeckInfoView")
end

function var_0_0.OpenBattleInfo()
	JumpTools.OpenPageByJump("rogueCardGameBattleInfoView")
end

function var_0_0.SaveStageData(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = var_0_7(arg_27_1)

	RogueCardGameData:SaveStageData(arg_27_1, arg_27_0)
	RogueCardGameAction.SaveProgressPost(arg_27_0, var_27_0, arg_27_2)

	var_0_4 = var_27_0
	var_0_3 = arg_27_1
end

function var_0_0.SaveRollbackData(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = var_0_7(arg_28_1)

	RogueCardGameData:SaveRollbackData(arg_28_1, arg_28_0)
	RogueCardGameAction.SaveRollBackPost(arg_28_0, var_28_0)

	var_0_6 = var_28_0
	var_0_5 = arg_28_1
end

function var_0_0.SettleStage(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = {
		score = arg_29_1.maxScore,
		most_hand_type = arg_29_1.mostHandType,
		round = arg_29_1.round,
		max_score = arg_29_1.maxScore,
		use_card_num = arg_29_1.useCardNum,
		discard_num = arg_29_1.discardNum,
		black_wu_chang_num = arg_29_1.blackWuChangNum,
		white_wu_chang_num = arg_29_1.whiteWuChangNum,
		gain_gold_num = arg_29_1.gainGoldNum,
		use_item_id = var_0_9(arg_29_1.useItemID),
		hand_type_use_num = var_0_9(arg_29_3),
		hand_type_contain_num = var_0_9(arg_29_1.handTypeContainNum),
		enhance_id = var_0_9(arg_29_1.enhanceID),
		weal_woe_id = var_0_9(arg_29_1.wealWoeID),
		use_gold_num = arg_29_1.useGoldNum,
		gain_joker_num = arg_29_1.gainJokerNum,
		use_a_num = arg_29_1.useANum,
		use_enhance_num = arg_29_1.useEnhanceNum
	}

	if arg_29_0 == 1 then
		RogueCardGameAction.CompletePost(RogueCardGameTools.GetCurPostingId(), var_29_0, arg_29_0)
	else
		local var_29_1 = RogueCardGameTools.GetCurPostingId()

		RogueCardGameAction.InGameInterruptPost(var_29_1, arg_29_2)
	end
end

function var_0_0.ExitRogueCardGame(arg_30_0)
	if not arg_30_0 then
		local var_30_0 = getCurrentTrackingSaveData()
		local var_30_1 = var_0_12(var_30_0.settle_data, {})

		sendSettleTracking({
			is_finish = true,
			result = 3,
			stage_id = RogueCardGameTools.GetCurPostingId(),
			score = var_0_12(var_30_0.score, 0),
			round = var_0_12(var_30_0.cur_round, 0),
			hard = var_0_12(var_30_0.difficulty, 0),
			settle_data = var_30_1,
			save_data = var_30_0,
			buff_list = trackingArrayToString(buildTrackingBuffList(var_30_0, var_30_1)),
			use_seconds = resolveUseSeconds(nil, var_30_1, var_30_0)
		})

		local var_30_2 = RogueCardGameTools.GetCurPostingId()

		RogueCardGameAction.InGameInterruptPost(var_30_2)
	end

	var_0_0.FinishRogueCardGame(function()
		JumpTools.Back(nil, {
			isSettle = arg_30_0 or false
		})
	end)
end

function var_0_0.ExitRogueCardGameWithSettle(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	local var_32_0 = {
		score = arg_32_0.score,
		most_hand_type = arg_32_0.mostHandType,
		round = arg_32_0.round,
		max_score = arg_32_0.maxScore,
		use_card_num = arg_32_0.useCardNum,
		discard_num = arg_32_0.discardNum,
		black_wu_chang_num = arg_32_0.blackWuChangNum,
		white_wu_chang_num = arg_32_0.whiteWuChangNum,
		gain_gold_num = arg_32_0.gainGoldNum,
		use_item_id = var_0_9(arg_32_0.useItemID),
		hand_type_use_num = var_0_9(arg_32_5),
		hand_type_contain_num = var_0_9(arg_32_0.handTypeContainNum),
		enhance_id = var_0_9(arg_32_0.enhanceID),
		weal_woe_id = var_0_9(arg_32_0.wealWoeID),
		use_gold_num = arg_32_0.useGoldNum,
		gain_joker_num = arg_32_0.gainJokerNum,
		use_a_num = arg_32_0.useANum,
		use_enhance_num = arg_32_0.useEnhanceNum
	}

	if arg_32_3 == 1 then
		RogueCardGameAction.RogueCardChallengeSettle(arg_32_2, arg_32_1, var_32_0)
	else
		local var_32_1 = RogueCardGameTools.GetCurPostingId()

		RogueCardGameAction.InGameInterruptPost(var_32_1, arg_32_4)
	end
end

local var_0_15 = {
	diff = 0,
	isContinue = false,
	stageID = 0,
	deck = 0
}

function var_0_0.EnterRogueCardGame(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	var_0_15.stageID = arg_33_0
	var_0_15.deck = arg_33_1
	var_0_15.diff = arg_33_2
	var_0_15.isContinue = arg_33_3

	DestroyLua()
	RogueCardBridge.Launcher()
end

local var_0_16

function var_0_0.FinishRogueCardGame(arg_34_0)
	DestroyLua()

	var_0_16 = arg_34_0

	LuaExchangeHelper.GoToMain()
end

function var_0_0.FinishRogueCardGameCallback()
	gameContext:SetSystemLayer("home")

	if var_0_16 then
		var_0_16()
	end

	var_0_16 = nil
end

function var_0_0.OnStartGame()
	var_0_0.InitDatabase()

	local var_36_0 = var_0_15.stageID
	local var_36_1 = var_0_15.deck
	local var_36_2 = var_0_15.diff
	local var_36_3 = var_0_15.isContinue
	local var_36_4 = {
		effect_disable = false,
		rank = 0,
		enhance_id = 0,
		suit = 0,
		tag_id = 0,
		other_data = {}
	}
	local var_36_5 = {
		add_point = 0,
		real_id = 0,
		version_id = 0,
		id = 0,
		mul_ratio = 0,
		add_mutli = 0,
		other_data = {}
	}
	local var_36_6 = {
		discard_num = 0,
		use_a_num = 0,
		gain_gold_num = 0,
		max_score = 0,
		black_wu_chang_num = 0,
		use_card_num = 0,
		use_enhance_num = 0,
		white_wu_chang_num = 0,
		use_gold_num = 0,
		most_hand_type = 0,
		score = 0,
		gain_joker_num = 0,
		round = 0,
		hand_type_use_num = {},
		hand_type_contain_num = {},
		use_item_id = {},
		enhance_id = {},
		weal_woe_id = {}
	}
	local var_36_7 = {
		random_seed = 0,
		stage_id = 0,
		is_better_straight = false,
		target_score = 0,
		cur_state = 0,
		cur_stage_state = 0,
		gold = 0,
		ignore_woe = false,
		boss_target_score = 0,
		hand_trigger = false,
		cur_refresh_cost = 0,
		score = 0,
		play_num = 0,
		is_odd_even = false,
		is_disable_type = false,
		cur_package_id = 0,
		deck_id = 0,
		even_value = 0,
		cur_package_wuchang = 0,
		last_package_num = 0,
		only_type = -1,
		black_wu_chang_id = 0,
		cur_round = 0,
		round_play_num = 0,
		weal_woe_refresh_num = 0,
		white_wu_chang_id = 0,
		cur_woe_id = 0,
		round_discard_num = 0,
		odd_value = 0,
		ignore_spade = false,
		is_other_suit = false,
		difficulty = 0,
		is_only_type = false,
		wu_chang_reset_num = 0,
		is_always_wu_chang = false,
		roll_back_num = 0,
		discard_num = 0,
		record_items = {},
		global_attr_dic = {},
		hand_type_level = {},
		deck_cards = {},
		pile_cards = {},
		hand_cards = {},
		jokers = {},
		shop_item_data_list = {},
		shop_package_data_list = {},
		weal_list = {},
		woe_list = {},
		disable_type = {},
		other_data = {},
		package_joker_id = {},
		package_wuchang_id = {},
		wu_chang_wait_cards = {}
	}

	var_0_4 = RogueCardGameData:GetSaveData(var_36_0)

	if var_0_4 ~= nil and type(var_0_4) == "table" and next(var_0_4) ~= nil then
		fillImpermanenceSaveDataFromProto(var_0_4, var_36_7)

		var_0_3 = var_0_8(var_36_7)
		var_0_4 = var_0_7(var_0_3)
	else
		var_0_3 = ""
		var_0_4 = {}
	end

	var_0_6 = RogueCardGameData:GetRollbackData(var_36_0)

	if var_0_6 ~= nil and type(var_0_6) == "table" and next(var_0_6) ~= nil then
		fillImpermanenceSaveDataFromProto(var_0_6, var_36_7)

		var_0_5 = var_0_8(var_36_7)
		var_0_6 = var_0_7(var_0_5)
	else
		var_0_5 = ""
		var_0_6 = {}
	end

	if not var_36_3 then
		RogueCardGameAction.EnterRogueCardGame(var_36_0, var_36_1, var_36_2)
	else
		var_0_0.OnEnterRogueCardGame(var_36_0, var_36_1, var_36_2)
	end
end

function var_0_0.OnEnterRogueCardGame(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = RogueCardStageCfg[arg_37_0]
	local var_37_1
	local var_37_2

	if var_37_0 and var_37_0.type == 2 then
		var_37_1 = arg_37_1
		var_37_2 = arg_37_2
	else
		var_37_1 = 1
		var_37_2 = -1
	end

	JumpTools.OpenPageByJump("/rogueCardGameView")

	local var_37_3 = false

	if var_0_2[arg_37_0] ~= nil then
		for iter_37_0, iter_37_1 in ipairs(var_0_2[arg_37_0]) do
			if not GuideData:IsFinish(iter_37_1, true) and manager.guide:GetGuideIsOpen(iter_37_1) then
				var_37_3 = true

				break
			end
		end
	end

	if var_0_4 ~= nil and type(var_0_4) == "table" and table.length(var_0_4) ~= 0 then
		RogueCard.RogueCardDataManager.GameContinue(arg_37_0, var_0_3, var_0_5, var_37_3)
	else
		RogueCard.RogueCardDataManager.GameInit(arg_37_0, var_37_1, var_37_2, var_37_3)
	end
end

function var_0_0.InitDatabase()
	var_0_0.InitEffectDatabase()
	var_0_0.InitItemDatabase()
	var_0_0.InitEnhanceDatabase()
	var_0_0.InitPackageDatabase()
	var_0_0.InitStageDatabase()
	var_0_0.InitBossEffectDatabase()
	var_0_0.InitAttributeDatabase()
	var_0_0.InitHandtypeDatabase()
	var_0_0.InitDeckDatabase()
	var_0_0.InitDifficultyDatabase()
	var_0_0.InitClueDatabase()
	var_0_0.InitRecordData()
end

function var_0_0.InitEffectDatabase()
	local var_39_0 = {}

	for iter_39_0, iter_39_1 in ipairs(RogueCardEffectCfg.all) do
		local var_39_1 = RogueCardEffectCfg[iter_39_1]
		local var_39_2 = {}

		if var_39_1.param2 ~= "" then
			for iter_39_2, iter_39_3 in ipairs(var_39_1.param2) do
				if type(iter_39_3) == "table" then
					for iter_39_4, iter_39_5 in ipairs(iter_39_3) do
						table.insert(var_39_2, iter_39_5)
					end
				else
					table.insert(var_39_2, iter_39_3)
				end
			end
		end

		local var_39_3 = {
			id = var_39_1.id,
			moment = var_39_1.moment,
			condition = var_39_1.condition,
			action = var_39_1.action_type,
			param1 = var_39_1.param1 == "" and {} or var_39_1.param1,
			param2 = var_39_2,
			effective_reset_moment = var_39_1.effective_reset_moment,
			effective_time = var_39_1.effective_time,
			lifetime_grow_moment = var_39_1.lifetime_grow_moment,
			max_lifetime = var_39_1.max_lifetime
		}

		table.insert(var_39_0, var_39_3)
	end

	RogueCard.RogueCardDataManager.InitEffectData(var_39_0)
end

function var_0_0.InitItemDatabase()
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in ipairs(RogueCardItemCfg.all) do
		local var_40_1 = RogueCardItemCfg[iter_40_1]
		local var_40_2 = {
			id = var_40_1.id,
			type = var_40_1.type,
			name = var_40_1.name,
			desc = var_40_1.desc,
			rare = var_40_1.rare,
			effect_list = var_40_1.effect_list == "" and {} or var_40_1.effect_list,
			sell_price = var_40_1.sell_price,
			ex_desc = var_40_1.ex_desc,
			icon = var_40_1.icon,
			limit = var_40_1.limit,
			desc_value_type = var_40_1.desc_value_type,
			sort_priority = var_40_1.priority,
			is_no_copy = var_40_1.is_no_copy,
			tag = var_40_1.tag == "" and {} or var_40_1.tag
		}

		table.insert(var_40_0, var_40_2)
	end

	RogueCard.RogueCardDataManager.InitItemData(var_40_0)
end

function var_0_0.InitEnhanceDatabase()
	local var_41_0 = {}

	for iter_41_0, iter_41_1 in ipairs(RogueCardEnhanceCfg.all) do
		local var_41_1 = RogueCardEnhanceCfg[iter_41_1]
		local var_41_2 = {
			id = var_41_1.id,
			type = var_41_1.type,
			name = var_41_1.name,
			desc = var_41_1.desc,
			rare = var_41_1.rare,
			effect_list = var_41_1.effect_list == "" and {} or var_41_1.effect_list,
			ex_price = var_41_1.ex_price,
			icon = var_41_1.pic,
			sort_priority = var_41_1.priority
		}

		table.insert(var_41_0, var_41_2)
	end

	RogueCard.RogueCardDataManager.InitEnhanceData(var_41_0)
end

function var_0_0.InitPackageDatabase()
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in ipairs(RogueCardPackageCfg.all) do
		local var_42_1 = RogueCardPackageCfg[iter_42_1]
		local var_42_2 = {
			id = var_42_1.id,
			type = var_42_1.type,
			name = var_42_1.name,
			desc = var_42_1.desc,
			weight = var_42_1.weight,
			sell_price = var_42_1.sell_price,
			content = var_42_1.content == "" and {} or var_42_1.content,
			icon = var_42_1.icon,
			icon2 = var_42_1.icon2
		}

		table.insert(var_42_0, var_42_2)
	end

	RogueCard.RogueCardDataManager.InitPackageData(var_42_0)
end

function var_0_0.InitStageDatabase()
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in ipairs(RogueCardStageCfg.all) do
		local var_43_1 = RogueCardStageCfg[iter_43_1]
		local var_43_2 = {}
		local var_43_3 = {}

		for iter_43_2, iter_43_3 in ipairs(var_43_1.buff) do
			table.insert(var_43_2, iter_43_3[1])
			table.insert(var_43_3, iter_43_3[2])
		end

		local var_43_4 = {
			id = var_43_1.id,
			round = var_43_1.round,
			name = var_43_1.name,
			score_list = var_43_1.score_list == "" and {} or var_43_1.score_list,
			boss_weal = var_43_2,
			boss_woe = var_43_3,
			type = var_43_1.type,
			false_picture = var_43_1.false_picture,
			truth_picture = var_43_1.truth_picture,
			clue_group_id = var_43_1.clue_group_id
		}

		table.insert(var_43_0, var_43_4)
	end

	RogueCard.RogueCardDataManager.InitStageData(var_43_0)
end

function var_0_0.InitBossEffectDatabase()
	local var_44_0 = {}

	for iter_44_0, iter_44_1 in ipairs(RogueCardBossEffectCfg.all) do
		local var_44_1 = RogueCardBossEffectCfg[iter_44_1]
		local var_44_2 = {
			id = var_44_1.id,
			type = var_44_1.type,
			desc = var_44_1.desc,
			effect_list = var_44_1.effect_list == "" and {} or var_44_1.effect_list,
			coefficient = var_44_1.coefficient,
			max_num = var_44_1.max_num,
			weight = var_44_1.weight
		}

		table.insert(var_44_0, var_44_2)
	end

	RogueCard.RogueCardDataManager.InitBossEffectData(var_44_0)
end

function var_0_0.InitAttributeDatabase()
	local var_45_0 = {}

	for iter_45_0, iter_45_1 in ipairs(RogueCardAttributeCfg.all) do
		local var_45_1 = RogueCardAttributeCfg[iter_45_1]
		local var_45_2 = {
			id = var_45_1.id,
			default = var_45_1.default,
			max = var_45_1.max,
			min = var_45_1.min
		}

		table.insert(var_45_0, var_45_2)
	end

	RogueCard.RogueCardDataManager.InitAttributeData(var_45_0)
end

function var_0_0.InitHandtypeDatabase()
	local var_46_0 = {}

	for iter_46_0, iter_46_1 in ipairs(RogueCardHandTypeCfg.all) do
		local var_46_1 = RogueCardHandTypeCfg[iter_46_1]
		local var_46_2 = {
			id = var_46_1.id,
			name = var_46_1.name,
			desc = var_46_1.desc,
			base_score = var_46_1.base_value[1],
			base_multi = var_46_1.base_value[2],
			add_score = var_46_1.grow_value[1],
			add_multi = var_46_1.grow_value[2],
			exampleCard1 = var_46_1.example[1],
			exampleCard2 = var_46_1.example[2],
			exampleCard3 = var_46_1.example[3]
		}

		table.insert(var_46_0, var_46_2)
	end

	RogueCard.RogueCardDataManager.InitHandtypeData(var_46_0)
end

function var_0_0.InitDeckDatabase()
	local var_47_0 = {}

	for iter_47_0, iter_47_1 in ipairs(RogueCardDeckCfg.all) do
		local var_47_1 = RogueCardDeckCfg[iter_47_1]
		local var_47_2 = {
			id = var_47_1.id,
			deck = var_47_1.deck,
			name = var_47_1.name,
			desc = var_47_1.desc,
			effect_list = var_47_1.effect_list == "" and {} or var_47_1.effect_list,
			pic = var_47_1.pic,
			score_rate = var_47_1.score_rate
		}

		table.insert(var_47_0, var_47_2)
	end

	RogueCard.RogueCardDataManager.InitDeckData(var_47_0)
end

function var_0_0.InitDifficultyDatabase()
	local var_48_0 = {}

	for iter_48_0, iter_48_1 in ipairs(RogueCardDifficultyCfg.all) do
		local var_48_1 = RogueCardDifficultyCfg[iter_48_1]
		local var_48_2 = {
			id = var_48_1.id,
			desc = var_48_1.desc,
			effect_list = var_48_1.effect_list == "" and {} or var_48_1.effect_list,
			score_rate = var_48_1.score_rate
		}

		table.insert(var_48_0, var_48_2)
	end

	RogueCard.RogueCardDataManager.InitDifficultyData(var_48_0)
end

function var_0_0.InitClueDatabase()
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in ipairs(RogueCardClueCfg.all) do
		local var_49_1 = RogueCardClueCfg[iter_49_1]
		local var_49_2 = {
			id = var_49_1.id,
			group_id = var_49_1.group_id,
			round = var_49_1.round,
			type = var_49_1.type,
			clue = var_49_1.clue
		}

		table.insert(var_49_0, var_49_2)
	end

	RogueCard.RogueCardDataManager.InitClueData(var_49_0)
end

function var_0_0.InitRecordData()
	local var_50_0 = {}
	local var_50_1 = {}
	local var_50_2 = RogueCardGameData:GetJokerCardList()

	for iter_50_0, iter_50_1 in ipairs(var_50_2) do
		table.insert(var_50_0, iter_50_1)
	end

	local var_50_3 = RogueCardGameData:GetWhiteCardList()

	for iter_50_2, iter_50_3 in ipairs(var_50_3) do
		table.insert(var_50_0, iter_50_3)
	end

	local var_50_4 = RogueCardGameData:GetBlackCardList()

	for iter_50_4, iter_50_5 in ipairs(var_50_4) do
		table.insert(var_50_0, iter_50_5)
	end

	local var_50_5 = RogueCardGameData:GetEnhanceList()

	for iter_50_6, iter_50_7 in ipairs(var_50_5) do
		table.insert(var_50_1, iter_50_7)
	end

	RogueCard.RogueCardDataManager.InitRecordData(var_50_0, var_50_1)
end

local function var_0_17(arg_51_0, arg_51_1)
	if type(arg_51_0) ~= "table" or type(arg_51_1) ~= "table" then
		return arg_51_0
	end

	for iter_51_0, iter_51_1 in ipairs(arg_51_1) do
		table.insert(arg_51_0, iter_51_1)
	end

	return arg_51_0
end

local function var_0_18(arg_52_0)
	if type(arg_52_0) ~= "table" then
		return "[]"
	end

	return var_0_8(arg_52_0)
end

local function var_0_19(arg_53_0)
	if type(arg_53_0) ~= "table" then
		return {}
	end

	local var_53_0 = {}

	for iter_53_0, iter_53_1 in ipairs(arg_53_0) do
		if type(iter_53_1) == "table" then
			var_53_0[iter_53_0] = iter_53_1
		end
	end

	return var_53_0
end

local function var_0_20(arg_54_0)
	local var_54_0 = var_0_19(arg_54_0)

	if type(var_54_0) ~= "table" or #var_54_0 == 0 then
		return {}
	end

	return var_54_0
end

local function var_0_21(arg_55_0)
	local var_55_0 = RogueCardStageCfg and RogueCardStageCfg[arg_55_0]

	if var_55_0 and var_55_0.type == 2 then
		return 2
	end

	return 1
end

local function var_0_22(arg_56_0)
	if arg_56_0 == 2 then
		return tostring(var_0_12(RogueCardGameData and RogueCardGameData.GetChallengeBattleId and RogueCardGameData:GetChallengeBattleId(), 0))
	end

	return tostring(var_0_12(RogueCardGameData and RogueCardGameData.GetBattleId and RogueCardGameData:GetBattleId(), 0))
end

local function var_0_23(arg_57_0, arg_57_1, arg_57_2)
	if arg_57_0 ~= 2 then
		return 100
	end

	local var_57_0 = 100

	if not RogueCardDifficultyCfg then
		local var_57_1 = 100
	end

	local var_57_2 = RogueCardDifficultyCfg[arg_57_2]

	if var_57_2 == nil then
		local var_57_3 = 100
	end

	local var_57_4 = var_57_2.score_rate or 100
	local var_57_5 = 100

	if RogueCardDeckCfg and RogueCardDeckCfg[arg_57_1] and RogueCardDeckCfg[arg_57_1].score_rate ~= nil then
		var_57_5 = RogueCardDeckCfg[arg_57_1].score_rate
	end

	local var_57_6 = var_57_4 * var_57_5 / 100

	return var_0_12(var_57_6, 100)
end

local function var_0_24(arg_58_0)
	return {
		hero_id = var_0_12(arg_58_0.real_id, var_0_12(arg_58_0.id, 0)),
		buff1 = var_0_18({}),
		buff2 = var_0_18({}),
		buff3 = var_0_18(var_0_12(arg_58_0.version_id, 0) ~= 0 and {
			arg_58_0.version_id
		} or {})
	}
end

local function var_0_25(arg_59_0)
	local var_59_0 = arg_59_0 and arg_59_0.jokers
	local var_59_1 = {}

	if var_59_0 ~= nil then
		for iter_59_0, iter_59_1 in ipairs(var_0_9(var_59_0)) do
			local var_59_2 = var_0_24(iter_59_1)

			if var_59_2 then
				table.insert(var_59_1, var_59_2)
			end
		end

		return var_59_1
	end
end

local function var_0_26(arg_60_0)
	return arg_60_0.roll_back_num < GameSetting.rogue_card_restart.value[1]
end

local function var_0_27(arg_61_0)
	local var_61_0 = {}
	local var_61_1 = arg_61_0.difficulty

	for iter_61_0, iter_61_1 in ipairs(RogueCardDifficultyCfg.all) do
		local var_61_2 = RogueCardDifficultyCfg[iter_61_1]

		if iter_61_1 <= var_61_1 then
			for iter_61_2, iter_61_3 in ipairs(var_0_9(var_61_2.effect_list)) do
				table.insert(var_61_0, iter_61_3)
			end
		end
	end

	var_0_17(var_61_0, var_0_12(var_0_9(arg_61_0.weal_list), {}))
	var_0_17(var_61_0, var_0_12(var_0_9(arg_61_0.woe_list), {}))

	return var_61_0
end

local function var_0_28(arg_62_0)
	local var_62_0 = var_0_21(var_0_12(arg_62_0.stage_id, 0))

	return {
		activity_id = 4142701,
		polyhedron_id_str = var_0_22(var_62_0),
		combat_category = var_62_0,
		stage_id = var_0_12(arg_62_0.stage_id, 0),
		hard = var_0_12(arg_62_0.difficulty, 0),
		difficulty_point = var_0_23(var_62_0, var_0_12(arg_62_0.deck_id, 0), var_0_12(arg_62_0.difficulty, 0)),
		record_id = var_0_12(arg_62_0.deck_id, 0),
		param_id = var_0_12(arg_62_0.cur_stage_state, 0),
		round = var_0_12(arg_62_0.cur_round, 0),
		is_help = var_0_26(arg_62_0),
		other_arrayobject = var_0_20(var_0_25(arg_62_0)),
		coin_num = var_0_12(arg_62_0.gold, 0)
	}
end

function var_0_0.SendSettleTrackingPoint(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4, arg_63_5)
	local var_63_0 = {}
	local var_63_1 = 0

	if arg_63_3 == nil then
		var_63_0 = {
			arg_63_0.score or 0,
			arg_63_0.target_score or 0
		}
		var_63_1 = arg_63_0.other_data and arg_63_0.other_data[2] or 0
	else
		var_63_0 = {
			arg_63_3,
			arg_63_4
		}
		var_63_1 = arg_63_0.other_data and arg_63_0.other_data[1] or 0
	end

	local var_63_2 = var_0_28(arg_63_0)
	local var_63_3 = {
		activity_id = var_63_2.activity_id,
		polyhedron_id_str = var_63_2.polyhedron_id_str,
		combat_category = var_63_2.combat_category,
		stage_id = var_63_2.stage_id,
		hard = var_63_2.hard,
		difficulty_point = var_63_2.difficulty_point,
		record_id = var_63_2.record_id,
		param_id = var_63_2.param_id,
		round = var_63_2.round,
		is_finish = arg_63_1,
		result = arg_63_2,
		boss_hp_list = var_0_18(var_63_0),
		use_seconds = var_63_1,
		score = math.floor(arg_63_0.settle_data.score * (var_63_2.difficulty_point / 100)),
		is_help = var_63_2.is_help,
		coin_num = var_63_2.coin_num,
		other_arrayobject = var_0_20(var_63_2.other_arrayobject),
		buff_list = var_0_18(var_0_27(arg_63_0)),
		other_object = {
			play_num = var_0_12(arg_63_0.play_num, 0),
			discard_num = var_0_12(arg_63_0.discard_num, 0)
		},
		vary = arg_63_5
	}

	SDKTools.SendMessageToSDK("period_combat_over", var_63_3)
end

function var_0_0.SendHandCardPlayPoint(arg_64_0, arg_64_1, arg_64_2, arg_64_3, arg_64_4, arg_64_5, arg_64_6)
	local var_64_0 = {}
	local var_64_1 = var_0_9(arg_64_0)

	for iter_64_0, iter_64_1 in ipairs(var_64_1) do
		local var_64_2 = var_0_12(iter_64_1.rank, 0)
		local var_64_3 = var_0_12(iter_64_1.suit, 0)
		local var_64_4 = var_0_18(var_0_12(iter_64_1.enhance_id, 0) ~= 0 and {
			iter_64_1.enhance_id
		} or {})
		local var_64_5 = var_0_18(var_0_12(iter_64_1.tag_id, 0) ~= 0 and {
			iter_64_1.tag_id
		} or {})
		local var_64_6 = var_0_18({})

		if var_64_2 > 0 then
			table.insert(var_64_0, {
				card_id = var_64_2,
				type = var_64_3,
				buff1 = var_64_4,
				buff2 = var_64_5,
				buff3 = var_64_6
			})
		end
	end

	local var_64_7 = {}

	for iter_64_2, iter_64_3 in ipairs(var_0_9(arg_64_1.hand_cards) or {}) do
		local var_64_8 = var_0_12(iter_64_3.rank, 0)
		local var_64_9 = var_0_12(iter_64_3.suit, 0)
		local var_64_10 = var_0_18(var_0_12(iter_64_3.enhance_id, 0) ~= 0 and {
			iter_64_3.enhance_id
		} or {})
		local var_64_11 = var_0_18(var_0_12(iter_64_3.tag_id, 0) ~= 0 and {
			iter_64_3.tag_id
		} or {})
		local var_64_12 = var_0_18({})

		if var_64_8 > 0 then
			table.insert(var_64_7, {
				card_id = var_64_8,
				type = var_64_9,
				buff1 = var_64_10,
				buff2 = var_64_11,
				buff3 = var_64_12
			})
		end
	end

	if arg_64_4 == 1 then
		var_64_7 = var_0_17(var_64_7, var_64_0)
	end

	if arg_64_4 == 2 or arg_64_4 == 4 then
		for iter_64_4, iter_64_5 in ipairs(var_64_0) do
			local var_64_13 = var_0_12(iter_64_5.card_id, 0)
			local var_64_14 = var_0_12(iter_64_5.type, 0)
			local var_64_15 = var_0_18(var_0_12(iter_64_5.buff1, 0) ~= 0 and {
				iter_64_5.buff1
			} or {})
			local var_64_16 = var_0_18(var_0_12(iter_64_5.buff2, 0) ~= 0 and {
				iter_64_5.buff2
			} or {})
			local var_64_17 = var_0_18(var_0_12(iter_64_5.buff3, 0) ~= 0 and {
				iter_64_5.buff3
			} or {})

			if var_64_13 > 0 then
				for iter_64_6, iter_64_7 in ipairs(var_64_7) do
					local var_64_18 = var_0_12(iter_64_7.card_id, 0)
					local var_64_19 = var_0_12(iter_64_7.type, 0)
					local var_64_20 = var_0_18(var_0_12(iter_64_7.buff1, 0) ~= 0 and {
						iter_64_7.buff1
					} or {})
					local var_64_21 = var_0_18(var_0_12(iter_64_7.buff2, 0) ~= 0 and {
						iter_64_7.buff2
					} or {})
					local var_64_22 = var_0_18(var_0_12(iter_64_7.buff3, 0) ~= 0 and {
						iter_64_7.buff3
					} or {})

					if var_64_18 == var_64_13 and var_64_19 == var_64_14 and var_64_20 == var_64_15 and var_64_21 == var_64_16 and var_64_22 == var_64_17 then
						table.remove(var_64_7, iter_64_6)

						break
					end
				end
			end
		end
	end

	local var_64_23 = var_0_28(arg_64_1)
	local var_64_24 = {
		arg_64_2,
		arg_64_3
	}
	local var_64_25 = {
		is_finish = false,
		result = 3,
		vary = 0,
		activity_id = var_64_23.activity_id,
		polyhedron_id_str = var_64_23.polyhedron_id_str,
		combat_category = var_64_23.combat_category,
		stage_id = var_64_23.stage_id,
		hard = var_64_23.hard,
		difficulty_point = var_64_23.difficulty_point,
		record_id = var_64_23.record_id,
		param_id = var_64_23.param_id,
		round = var_64_23.round,
		opt = arg_64_4,
		boss_hp_list = var_0_18(var_64_24),
		earn_num = arg_64_5,
		other_object = {
			play_num = var_0_12(arg_64_1.play_num, 0),
			discard_num = var_0_12(arg_64_1.discard_num, 0)
		},
		params_list_arrayobject = var_0_20(var_64_7),
		params_select_arrayobject = var_0_20(var_64_0),
		group_id = var_0_12(arg_64_6, 0),
		is_help = var_64_23.is_help,
		coin_num = var_64_23.coin_num,
		other_arrayobject = var_0_20(var_64_23.other_arrayobject),
		buff_list = var_0_18(var_0_27(arg_64_1))
	}

	SDKTools.SendMessageToSDK("period_combat_over", var_64_25)
end

function var_0_0.SendShopTrackingPoint(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4, arg_65_5, arg_65_6, arg_65_7, arg_65_8, arg_65_9, arg_65_10)
	local var_65_0 = var_0_28(arg_65_0)
	local var_65_1 = var_0_9(arg_65_3)
	local var_65_2 = var_0_9(arg_65_4)
	local var_65_3 = var_0_9(arg_65_5)
	local var_65_4 = var_0_9(arg_65_6)
	local var_65_5 = {}

	for iter_65_0, iter_65_1 in ipairs(var_65_1) do
		local var_65_6 = {
			sequence_id = iter_65_0,
			type = var_0_12(var_65_2 and var_65_2[iter_65_0], 0),
			shop_id = iter_65_1,
			hero_id = var_0_12(var_65_2[iter_65_0] == 1 and iter_65_1 or 0, 0),
			cost = var_0_12(var_65_3 and var_65_3[iter_65_0], 0),
			version = var_0_12(var_65_4 and var_65_4[iter_65_0], 0),
			buff1 = var_0_18({}),
			buff2 = var_0_18({}),
			buff3 = var_65_2[iter_65_0] == 1 and var_65_4[iter_65_0] ~= 0 and var_0_18({
				var_65_4[iter_65_0]
			}) or var_0_18({})
		}

		table.insert(var_65_5, var_65_6)
	end

	local var_65_7 = var_0_9(arg_65_7)
	local var_65_8 = var_0_9(arg_65_8)
	local var_65_9 = var_0_9(arg_65_9)
	local var_65_10 = var_0_9(arg_65_10)
	local var_65_11 = {}

	for iter_65_2, iter_65_3 in ipairs(var_0_9(arg_65_7)) do
		local var_65_12 = {
			sequence_id = iter_65_2,
			type = var_0_12(var_65_8 and var_65_8[iter_65_2], 0),
			shop_id = iter_65_3,
			hero_id = var_0_12(var_65_8[iter_65_2] == 1 and iter_65_3 or 0, 0),
			cost = var_0_12(var_65_9 and var_65_9[iter_65_2], 0),
			version = var_0_12(var_65_10 and var_65_10[iter_65_2], 0),
			buff1 = var_0_18({}),
			buff2 = var_0_18({}),
			buff3 = var_65_8[iter_65_2] == 1 and var_65_10[iter_65_2] ~= 0 and var_0_18({
				var_65_10[iter_65_2]
			}) or var_0_18({})
		}

		table.insert(var_65_11, var_65_12)
	end

	local var_65_13 = {
		type = 1,
		activity_id = var_65_0.activity_id,
		polyhedron_id_str = var_65_0.polyhedron_id_str,
		combat_category = var_65_0.combat_category,
		stage_id = var_65_0.stage_id,
		hard = var_65_0.hard,
		difficulty_point = var_65_0.difficulty_point,
		record_id = var_65_0.record_id,
		param_id = var_65_0.param_id,
		round = var_65_0.round,
		opt = arg_65_1,
		is_help = var_65_0.is_help,
		coin_num = var_65_0.coin_num,
		other_arrayobject = var_0_20(var_65_0.other_arrayobject),
		params_list_arrayobject = var_0_20(var_65_5),
		params_select_arrayobject = var_0_20(var_65_11),
		vary = arg_65_2
	}

	SDKTools.SendMessageToSDK("activity_currency_opt", var_65_13)
end

function var_0_0.SendWuChangTrackingPoint(arg_66_0, arg_66_1, arg_66_2, arg_66_3, arg_66_4, arg_66_5)
	local var_66_0 = var_0_28(arg_66_0)
	local var_66_1 = {}
	local var_66_2 = var_0_9(arg_66_2)

	for iter_66_0, iter_66_1 in ipairs(var_66_2) do
		local var_66_3 = var_0_12(iter_66_1.rank, 0)
		local var_66_4 = var_0_12(iter_66_1.suit, 0)
		local var_66_5 = var_0_18(var_0_12(iter_66_1.enhance_id, 0) ~= 0 and {
			iter_66_1.enhance_id
		} or {})
		local var_66_6 = var_0_18(var_0_12(iter_66_1.tag_id, 0) ~= 0 and {
			iter_66_1.tag_id
		} or {})
		local var_66_7 = var_0_18({})

		if var_66_3 > 0 then
			table.insert(var_66_1, {
				card_id = var_66_3,
				type = var_66_4,
				buff1 = var_66_5,
				buff2 = var_66_6,
				buff3 = var_66_7
			})
		end
	end

	local var_66_8 = {}
	local var_66_9 = var_0_9(arg_66_3)

	for iter_66_2, iter_66_3 in ipairs(var_66_9) do
		local var_66_10 = var_0_12(iter_66_3.rank, 0)
		local var_66_11 = var_0_12(iter_66_3.suit, 0)
		local var_66_12 = var_0_18(var_0_12(iter_66_3.enhance_id, 0) ~= 0 and {
			iter_66_3.enhance_id
		} or {})
		local var_66_13 = var_0_18(var_0_12(iter_66_3.tag_id, 0) ~= 0 and {
			iter_66_3.tag_id
		} or {})
		local var_66_14 = var_0_18({})

		if var_66_10 > 0 then
			table.insert(var_66_8, {
				card_id = var_66_10,
				type = var_66_11,
				buff1 = var_66_12,
				buff2 = var_66_13,
				buff3 = var_66_14
			})
		end
	end

	local var_66_15 = var_0_9(arg_66_4)
	local var_66_16 = {
		arg_66_5
	}
	local var_66_17 = {
		params_list = var_66_15,
		select_list = var_66_16
	}
	local var_66_18 = var_0_18(var_66_17)
	local var_66_19 = string.gsub(var_66_18, "\\", "")
	local var_66_20 = string.gsub(var_66_19, "\"", "")
	local var_66_21 = string.gsub(var_66_20, "{", "[")
	local var_66_22 = string.gsub(var_66_21, "}", "]")
	local var_66_23 = {
		type = 2,
		vary = 0,
		activity_id = var_66_0.activity_id,
		polyhedron_id_str = var_66_0.polyhedron_id_str,
		combat_category = var_66_0.combat_category,
		stage_id = var_66_0.stage_id,
		hard = var_66_0.hard,
		difficulty_point = var_66_0.difficulty_point,
		record_id = var_66_0.record_id,
		param_id = var_66_0.param_id,
		round = var_66_0.round,
		is_help = var_66_0.is_help,
		coin_num = var_66_0.coin_num,
		other_arrayobject = var_0_20(var_66_0.other_arrayobject),
		other_data = var_66_22,
		opt = arg_66_1,
		params_list_arrayobject = var_0_20(var_66_1),
		params_select_arrayobject = var_0_20(var_66_8)
	}

	SDKTools.SendMessageToSDK("activity_currency_opt", var_66_23)
end

return var_0_0
