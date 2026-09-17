local var_0_0 = DeviceManager.platform == "windows" and setmetatable({}, {
	__index = function(arg_1_0, arg_1_1)
		return function(...)
			return
		end
	end
}) or require("controller.MobClickForLua")

local function var_0_1(arg_3_0, arg_3_1, arg_3_2)
	require("network.network"):rpc("push_analys_event", {
		event = arg_3_0,
		keys = arg_3_1,
		values = arg_3_2
	})
end

local function var_0_2(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = {}

	if arg_4_1 then
		for iter_4_0, iter_4_1 in pairs(arg_4_1) do
			table.insert(var_4_0, tostring(iter_4_0))
			table.insert(var_4_1, tostring(iter_4_1))
		end
	end

	var_0_1(arg_4_0, var_4_0, var_4_1)
end

local function var_0_3(arg_5_0, arg_5_1)
	require("network.network"):rpc("push_thinkingdata_event", {
		event = arg_5_0,
		data = arg_5_1
	})
end

local function var_0_4(arg_6_0, arg_6_1)
	var_0_3(arg_6_0, (arg_6_1 or nil) and json.encode(arg_6_1))
end

local var_0_6 = 2
local var_0_7 = 3
local var_0_8 = {
	clickMajorVote = 2,
	click_score_enter = 1,
	click_change_show_girl_btn = 1,
	bosstower_fail = 1,
	purchase6 = 1,
	daily_sign_success = 1,
	trainQuick = 1,
	BAH_pass_adventure = 1,
	enterImageRoleFile = 2,
	entercitymap = 1,
	getspringfestivalword = 1,
	dorm_click_buy_dress_bnt = 1,
	BAH_main_layer_click = 1,
	breakSuccess = 1,
	marketBuySuccess = 1,
	get_score_lsvictor = 1,
	strengthen_weapon = 1,
	click_popshowgirl = 2,
	unlock_research = 1,
	purchase8888100 = 1,
	trainRoomFinish = 1,
	score_store_change = 1,
	enter_liuli_welfare_explore = 1,
	liuli_repair_single = 1,
	reset_core = 1,
	join_vocal_concert = 1,
	finish_patrol = 1,
	update_array_fightgirl = 1,
	buy_liuli_giftpackage = 1,
	sendBarrage = 1,
	begin_patrol = 1,
	change_furniture = 1,
	refreshMarket = 1,
	click_soul_servant_info = 1,
	click_mail_enter = 1,
	update_array_assistgirl = 1,
	sing_liuli = 1,
	score_tzsuccess = 1,
	fightBigBossSuccess = 1,
	LevelUp = 1,
	clickSwitchPlayer = 1,
	arean_tzfail = 1,
	click_pop_equip_attr_layer_defence = 1,
	sharegame = 1,
	liuli_buy_explore_times = 1,
	click_weapon_star_up_btn = 1,
	enterUserCenter = 1,
	clickPlayback = 2,
	enterPhotoHorcrux = 2,
	dorm_move_away = 1,
	set_component = 1,
	collect_recipe_slot = 1,
	cdk_exchange_success = 1,
	clickSkip = 2,
	clickFightFailBtn = 1,
	dorm_buy_dress_success = 1,
	update_arena_defence_servant = 1,
	enterPhoto = 2,
	clickSwitchPlayerSuccess = 1,
	click_pop_equip_skill_layer = 1,
	clickBarrage = 1,
	midassuccess = 1,
	click_arean_renshu = 1,
	changeCVVoiceVolume = 1,
	unlock_cur_recipe_slot = 1,
	adver_yuansu_fail = 1,
	decomposeSuccess = 1,
	recollections_save = 1,
	completeTask = 1,
	adver_zhiye_buy = 1,
	StrengthenSuccess1 = 1,
	enterNotice = 2,
	enter_liuli_plot_explore = 1,
	equip_click_servant_head_image = 1,
	click_explore_plotnpc = 1,
	click_servant_change_skin_layer = 1,
	dorm_settle_in = 1,
	buyWeight5 = 1,
	getNewServant = 1,
	trigger_favor_plot = 1,
	click_getmail = 1,
	click_area_flash = 1,
	recollections_read = 1,
	adver_zhiye_fail = 1,
	cancel_patrol = 1,
	purchase3 = 1,
	change_showgirl = 1,
	clickGetWayBtn = 1,
	BAH_buy_explore_times = 1,
	click_sure_souxun = 1,
	click_liuli_giftpackage = 1,
	purchase8806299 = 1,
	main_line_task_reward = 1,
	servant_change_skin_layer_buy_skin = 1,
	marry_with_major = 1,
	sellSuccess5 = 1,
	clickAuto = 1,
	signSpringFestival = 1,
	game_settings = 1,
	clickMarketItem = 1,
	add_array = 1,
	recollections_share = 1,
	get_activity_proceed_award = 1,
	quick_finish_patrol = 1,
	purchase8806603 = 1,
	main_layer_show_girl = 1,
	clickFightBoss = 1,
	clickCvBtn = 2,
	shopBuySuccess = 1,
	main_layer_into_liuli_activity = 1,
	click_opinion_feedback = 1,
	purchase8806211 = 1,
	click_dropinfo_guji = 1,
	purchase5 = 1,
	fightBigBossFail = 1,
	goto_gain_break_item = 1,
	changeHeadImage = 1,
	purchase7 = 1,
	purchase8806601 = 1,
	gain_favor_coin = 1,
	click_shouqu_guji = 1,
	update_arena_defence_horcrux = 1,
	get_collection_reward = 1,
	adver_wuzi_fail = 1,
	towerDefenceEntrnace = 2,
	marketSellSuccess = 1,
	purchase8806201 = 1,
	changeEffectVoiceVolume = 1,
	purchase1 = 1,
	click_birthday_barrage = 2,
	click_birthday_right = 2,
	event = 1,
	changeNickname = 1,
	on_open_notice = 2,
	click_birthday_expansion = 2,
	fightBigBoss = 1,
	purchase8888103 = 1,
	purchase8888105 = 1,
	purchase8806221 = 1,
	trainFinish = 1,
	adver_zhiye_enter = 1,
	school_area_getID = 1,
	push_settings = 1,
	decomposeSuccess1 = 1,
	guideProceed = 1,
	twist_ten_success = 1,
	click_souxun_guji = 1,
	towerDefenceSuccess = 2,
	changeSign = 1,
	servant_set_skin = 1,
	switchTowerDefence = 2,
	servant_upgrade_core_by_equiplayer = 1,
	score_flash_success = 1,
	trainDispatch = 1,
	click_activityall_enter = 1,
	BAH_activity_finish_level = 1,
	score_tzfail = 1,
	start_lab_recipe = 1,
	enterPhotoStudent = 2,
	unlock_room = 1,
	purchaseSuccess = 1,
	unlock_cur_research_slot = 1,
	adver_yuansu_buy = 1,
	send_gift = 1,
	click_bosstower = 1,
	favor_twist_one = 1,
	click_bug_feedback = 1,
	gain_liuli_by_activity = 1,
	click_pop_equip_attr_layer = 1,
	falling_game_score = 1,
	clickShopItem = 1,
	clickPurchaseItem = 1,
	click_arean_enter = 1,
	fight_result_layer_look_story = 2,
	bosstower_sucess = 1,
	replace_role_weapon = 1,
	sellSuccess4 = 1,
	favor_twist_ten = 1,
	sellSuccess6 = 1,
	adver_wuzi_buy = 1,
	enter_explore_by_plotnpc = 1,
	towerDefenceFail = 2,
	area_buy_time = 1,
	click_birthday_left = 2,
	upgrade_weapon = 1,
	friend_fight_result = 1,
	trainSuccess = 1,
	servant_break_out = 1,
	removeTrain = 1,
	entermidas = 1,
	enterNoticeIn = 1,
	gain_daily_task_reward = 1,
	servant_strengthen = 1,
	link_click_activity = 1,
	click_invite_share = 2,
	purchase8888102 = 1,
	click_activityall_items = 1,
	click_birthday_scroll = 2,
	adver_wuzi_enter = 1,
	adver_yuansu_enter_kaohe = 1,
	battlepassAward = 1,
	completeSpringFestivalCollect = 1,
	buyWeight6 = 1,
	finish_liuli_explore = 1,
	purchase2 = 1,
	click_equiplayer = 1,
	purchase4 = 1,
	gain_new_servant_by_twist = 1,
	set_hangup_array = 1,
	purchase8806602 = 1,
	enterTalk = 2,
	explore_success = 2,
	click_pop_equip_skill_layer_skillinfo = 1,
	getNewDress = 1,
	entergamesuccess = 1,
	player_update_class = 1,
	explore_fail = 1,
	twist_one_success = 1,
	entergame = 1,
	explore_cancel = 1,
	dorm_click_dress = 1,
	click_join_liuli_plot = 1,
	servant_upgrade_core = 1,
	buyWeight4 = 1,
	changeMedal = 1,
	click_birthday_furniture = 2,
	changeBGMVoiceVolume = 1,
	click_birthday_skin = 2,
	click_cachbag_guji = 1,
	talkSkip = 2,
	get_activity_task_award = 1,
	area_tzsuccess = 1,
	purchase8888104 = 1,
	soul_servant_info_playvoice = 1,
	enterPurchaseLayer = 1,
	fightBigBossSurrender = 1,
	click_fight_patrol_bnt = 1
}

var_0_8.clickStory = 3
var_0_8.clickActivityEntranceType = 3
var_0_8.clickSupermarketLayer = 3
var_0_8.clickPopWindowsX = 3
var_0_8.clickAutoFight = 3
var_0_8.clickCompareGame = 3
var_0_8.clickReturnDetail = 3
var_0_8.sheepGameScore = 3
var_0_8.ActivityMainLayer = 3
var_0_8.ActivityPopBaseLayer = 3
var_0_8.PopTapVoteLayer = 3
var_0_8.click_recharge_shop_limit = 3
var_0_8.click_shop_limit_new = 3
var_0_8.show_appstar_and_debug = 3
var_0_8.activityJumpTo = 3
var_0_8.clickNoviceSummaryLayer = 3
var_0_8.click_expedition_reset = 3
var_0_8.expedition_battle_fail = 3
var_0_8.expedition_battle_success = 3
var_0_8.expedition_first_1_chapter = 3
var_0_8.expedition_first_2_chapter = 3
var_0_8.expedition_first_3_chapter = 3
var_0_8.expedition_twice_2_chapter = 3
var_0_8.expedition_twice_3_chapter = 3
var_0_8.expedition_3_chapter_student_less_4 = 3
var_0_8.expedition_3_chapter_student_more_8 = 3
var_0_8.expedition_shop_buy_item = 3
var_0_8.click_mail_url = 3
var_0_8.clickWeixin = 3
var_0_8.clickWeibo = 3
var_0_8.clickBilibili = 3
var_0_8.clickBtnContract = 3
var_0_8.clickBtnContract = 3
var_0_8.clickPopWindowsbtn = 3
var_0_8.go_activity_survey = 3
var_0_8.quick_entrance_btn = 3
var_0_8.guide_type_selection = 3
var_0_8.begin_guide = 3
var_0_8.beach_defense_join = 3
var_0_8.beach_defense_exit = 3
var_0_8.flopchoose = 3
var_0_8.dice_goto_next = 3
var_0_8.create_new_player = 3
var_0_8.activityroulette_choose = 3
var_0_8.worldbossfight_begin = 3
var_0_8.worldbossfight_result = 3
var_0_8.player_select_guide = 3
var_0_8.process_payment = 3

local function var_0_9()
	return
end

local var_0_10 = setmetatable({}, {
	__index = function(arg_8_0, arg_8_1)
		if var_0_8[arg_8_1] then
			local function var_8_0(arg_9_0)
				if var_0_8[arg_8_1] == var_0_6 then
					pcall(var_0_2, arg_8_1, arg_9_0)
				elseif var_0_8[arg_8_1] == var_0_7 then
					pcall(var_0_4, arg_8_1, arg_9_0)
				end
			end

			arg_8_0[arg_8_1] = var_8_0

			return var_8_0
		else
			arg_8_0[arg_8_1] = var_0_9

			return var_0_9
		end
	end
})

function var_0_10.startAnalytic(arg_10_0)
	var_0_0.profileSignIn(arg_10_0)
end

function var_0_10.setUserLevel(arg_11_0)
	return
end

function var_0_10.pay(arg_12_0, arg_12_1, arg_12_2)
	var_0_0.pay(arg_12_0, arg_12_1, arg_12_2)
end

function var_0_10:fightBigBoss()
	var_0_0.startLevel(self.mode_chapter)
	var_0_0.event("fightBigBoss", self)
	pcall(var_0_2, "fightBigBoss", self)
end

function var_0_10:fightBigBossSuccess()
	var_0_0.finishLevel(self.mode_chapter)

	local var_14_0 = 0
	local var_14_1

	for iter_14_0 = 1, 4 do
		if self.servants[iter_14_0].fight_girl then
			var_14_0 = var_14_0 + 1
			var_14_1 = not var_14_1 and self.servants[iter_14_0].fight_girl_level or math.max(var_14_1, self.servants[iter_14_0].fight_girl_level)
		end
	end

	local var_14_2 = {
		mode_chapter = self.mode_chapter,
		rolenum = self.rolenum,
		grade = self.grade,
		class = self.class,
		star = self.star,
		servantinarray = var_14_0,
		maxfightlevel = var_14_1,
		servant1 = self.servants[1].fight_girl,
		servant2 = self.servants[2].fight_girl,
		servant3 = self.servants[3].fight_girl,
		servant4 = self.servants[4].fight_girl,
		assist_girl1 = self.servants[1].assist_girl,
		assist_girl2 = self.servants[2].assist_girl,
		assist_girl3 = self.servants[3].assist_girl,
		assist_girl4 = self.servants[4].assist_girl
	}

	if self.isrefight then
		var_0_0.event("fightBigBossSuccess", var_14_2)
		pcall(var_0_2, "fightBigBossSuccess", var_14_2)
	else
		var_0_0.event("firstFightBigBossSuccess", var_14_2)
		pcall(var_0_2, "firstFightBigBossSuccess", var_14_2)
	end
end

function var_0_10:fightBigBossFail()
	var_0_0.failLevel(self.mode_chapter)

	local var_15_0 = 0
	local var_15_1

	for iter_15_0 = 1, 4 do
		if self.servants[iter_15_0].fight_girl then
			var_15_0 = var_15_0 + 1
			var_15_1 = not var_15_1 and self.servants[iter_15_0].fight_girl_level or math.max(var_15_1, self.servants[iter_15_0].fight_girl_level)
		end
	end

	local var_15_2 = {
		mode_chapter = self.mode_chapter,
		rolenum = self.rolenum,
		grade = self.grade,
		class = self.class,
		servantinarray = var_15_0,
		maxfightlevel = var_15_1,
		servant1 = self.servants[1].fight_girl,
		servant2 = self.servants[2].fight_girl,
		servant3 = self.servants[3].fight_girl,
		servant4 = self.servants[4].fight_girl,
		assist_girl1 = self.servants[1].assist_girl,
		assist_girl2 = self.servants[2].assist_girl,
		assist_girl3 = self.servants[3].assist_girl,
		assist_girl4 = self.servants[4].assist_girl
	}

	var_0_0.event("fightBigBossFail", var_15_2)
	pcall(var_0_2, "fightBigBossFail", var_15_2)
end

function var_0_10:fightBigBossSurrender()
	var_0_0.failLevel(self.mode_chapter)

	local var_16_0 = 0
	local var_16_1

	for iter_16_0 = 1, 4 do
		if self.servants[iter_16_0].fight_girl then
			var_16_0 = var_16_0 + 1
			var_16_1 = not var_16_1 and self.servants[iter_16_0].fight_girl_level or math.max(var_16_1, self.servants[iter_16_0].fight_girl_level)
		end
	end

	local var_16_2 = {
		mode_chapter = self.mode_chapter,
		rolenum = self.rolenum,
		grade = self.grade,
		class = self.class,
		servantinarray = var_16_0,
		maxfightlevel = var_16_1,
		servant1 = self.servants[1].fight_girl,
		servant2 = self.servants[2].fight_girl,
		servant3 = self.servants[3].fight_girl,
		servant4 = self.servants[4].fight_girl
	}

	var_0_0.event("fightBigBossSurrender", var_16_2)
	pcall(var_0_2, "fightBigBossSurrender", var_16_2)
end

function var_0_10:fightNormalBossSuccess()
	local var_17_0 = 0
	local var_17_1

	for iter_17_0 = 1, 4 do
		if self.servants[iter_17_0].fight_girl then
			var_17_0 = var_17_0 + 1
			var_17_1 = not var_17_1 and self.servants[iter_17_0].fight_girl_level or math.max(var_17_1, self.servants[iter_17_0].fight_girl_level)
		end
	end

	local var_17_2 = {
		mode_chapter = self.mode_chapter,
		rolenum = self.rolenum,
		grade = self.grade,
		class = self.class,
		servantinarray = var_17_0,
		maxfightlevel = var_17_1,
		servant1 = self.servants[1].fight_girl,
		servant2 = self.servants[2].fight_girl,
		servant3 = self.servants[3].fight_girl,
		servant4 = self.servants[4].fight_girl
	}

	var_0_0.event("fightNormalBossSuccess", var_17_2)
	pcall(var_0_2, "fightNormalBossSuccess", var_17_2)
end

function var_0_10:fightNormalBossFail()
	local var_18_0 = 0
	local var_18_1

	for iter_18_0 = 1, 4 do
		if self.servants[iter_18_0].fight_girl then
			var_18_0 = var_18_0 + 1
			var_18_1 = not var_18_1 and self.servants[iter_18_0].fight_girl_level or math.max(var_18_1, self.servants[iter_18_0].fight_girl_level)
		end
	end

	local var_18_2 = {
		mode_chapter = self.mode_chapter,
		rolenum = self.rolenum,
		grade = self.grade,
		class = self.class,
		servantinarray = var_18_0,
		maxfightlevel = var_18_1,
		servant1 = self.servants[1].fight_girl,
		servant2 = self.servants[2].fight_girl,
		servant3 = self.servants[3].fight_girl,
		servant4 = self.servants[4].fight_girl
	}

	var_0_0.event("fightNormalBossFail", var_18_2)
	pcall(var_0_2, "fightNormalBossFail", var_18_2)
end

function var_0_10:fightAdventureSuccess()
	local var_19_0 = 0
	local var_19_1

	for iter_19_0 = 1, 4 do
		if self.servants[iter_19_0].fight_girl then
			var_19_0 = var_19_0 + 1
			var_19_1 = not var_19_1 and self.servants[iter_19_0].fight_girl_level or math.max(var_19_1, self.servants[iter_19_0].fight_girl_level)
		end
	end

	local var_19_2 = {
		mode_chapter = self.mode_chapter,
		rolenum = self.rolenum,
		grade = self.grade,
		class = self.class,
		servantinarray = var_19_0,
		maxfightlevel = var_19_1,
		servant1 = self.servants[1].fight_girl,
		servant2 = self.servants[2].fight_girl,
		servant3 = self.servants[3].fight_girl,
		servant4 = self.servants[4].fight_girl,
		star = self.star
	}

	if self.isfirstpass then
		var_0_0.event("firstAdventureSuccess" .. self.mode, var_19_2)
		pcall(var_0_2, "firstAdventureSuccess" .. self.mode, var_19_2)
	else
		var_0_0.event("adventureSuccess" .. self.mode, var_19_2)
		pcall(var_0_2, "adventureSuccess" .. self.mode, var_19_2)
	end
end

function var_0_10:fightAdventureFail()
	local var_20_0 = 0
	local var_20_1

	for iter_20_0 = 1, 4 do
		if self.servants[iter_20_0].fight_girl then
			var_20_0 = var_20_0 + 1
			var_20_1 = not var_20_1 and self.servants[iter_20_0].fight_girl_level or math.max(var_20_1, self.servants[iter_20_0].fight_girl_level)
		end
	end

	local var_20_2 = {
		mode_chapter = self.mode_chapter,
		rolenum = self.rolenum,
		grade = self.grade,
		class = self.class,
		servantinarray = var_20_0,
		maxfightlevel = var_20_1,
		servant1 = self.servants[1].fight_girl,
		servant2 = self.servants[2].fight_girl,
		servant3 = self.servants[3].fight_girl,
		servant4 = self.servants[4].fight_girl
	}

	var_0_0.event("adventureFail" .. self.mode, var_20_2)
	pcall(var_0_2, "adventureFail" .. self.mode, var_20_2)
end

return var_0_10
