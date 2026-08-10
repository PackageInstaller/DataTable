require("game.data.SPHeroChallengeDataTemplate")

local var_0_0 = singletonClass("SPHeroChallengeData")
local var_0_1
local var_0_2
local var_0_3
local var_0_4

var_0_0.activityCfg = {
	[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1] = {
		bossChapter = 703,
		bossActivityID = 242851,
		helpKey = "ACTIVITY_HERO_CHALLENGE_HELP",
		colorPuzzleActiVityTemplate = 287,
		operationEntrustNum = "activity_hero_challenge_task_condition",
		trainChapter = 702,
		barbuceActiVityID = 242861,
		enterView = "/spHeroChallengeMainView",
		maxEntrusNum = 3,
		storyChapter = 701,
		heroChipActivityID = 240045,
		taskActivityID = 240046,
		freeRefreshEntrustTime = GameSetting.activity_hero_challenge_task_free_refresh_num.value[1],
		waitEntrustListOpenCondition = GameSetting.activity_hero_challenge_task_line_num.value,
		shopID = ShopConst.SHOP_ID.SP_HERO_CHALLENGE_1,
		acceleratorTime = GameSetting.activity_hero_challenge_certificate_time.value[1],
		HeroChipTask = ActivityHeroChallengeCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].task_id,
		refreshEntrustCost = ActivityHeroChallengeCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].refresh_cost,
		heroID = ActivityHeroChallengeCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].hero_id,
		shopItemID = ActivityHeroChallengeCfg[ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1].shop_item_id or 216000001,
		maxChallengeTimes = GameSetting.activity_hero_challenge_max_num.value[1]
	}
}

function var_0_0.Init(arg_1_0)
	var_0_1 = nil
	var_0_2 = nil
	var_0_3 = {
		accelerateNum = 0,
		awardNum = 0
	}
	var_0_4 = nil
end

function var_0_0.InitEnterData(arg_2_0, arg_2_1)
	if var_0_2 == nil then
		var_0_2 = {}
	end

	if arg_2_1.activity_id then
		if var_0_2[arg_2_1.activity_id] then
			var_0_2[arg_2_1.activity_id]:InitData(arg_2_1)
		else
			var_0_2[arg_2_1.activity_id] = SPHeroChallengeActivityTemplate.New(arg_2_1)
		end
	end
end

function var_0_0.RefreshDormDailyZero(arg_3_0)
	if var_0_2 then
		for iter_3_0, iter_3_1 in ipairs(var_0_2) do
			iter_3_1:RefreshDormDailyZero()
		end
	end
end

function var_0_0.SetCurActivityID(arg_4_0, arg_4_1)
	var_0_1 = arg_4_1
end

function var_0_0.ExitCurSystem(arg_5_0)
	var_0_1 = nil
end

function var_0_0.DisposeActivityInfo(arg_6_0, arg_6_1)
	if var_0_2 and var_0_2[arg_6_1] then
		var_0_2[arg_6_1]:Dispose()

		var_0_2[arg_6_1] = nil
	end
end

function var_0_0.GetActivityID(arg_7_0)
	return var_0_1
end

function var_0_0.GetTotalInfo(arg_8_0)
	return var_0_2
end

function var_0_0.GetActivityData(arg_9_0, arg_9_1)
	if var_0_2 and var_0_2[arg_9_1] then
		return var_0_2[arg_9_1]
	end
end

function var_0_0.GetCurActivityInfo(arg_10_0)
	if var_0_1 then
		return var_0_2[var_0_1]
	end
end

function var_0_0.GetBrabuceGameAwardNum(arg_11_0)
	return var_0_3.awardNum or 0
end

function var_0_0.InitBarbuceAwardData(arg_12_0, arg_12_1)
	if var_0_3 then
		var_0_3.awardNum = arg_12_1
	end
end

function var_0_0.InitAccelerateData(arg_13_0, arg_13_1)
	if var_0_3 then
		var_0_3.accelerateNum = arg_13_1
	end
end

function var_0_0.GetBarbuceAccelerateNum(arg_14_0)
	local var_14_0 = 0

	if var_0_3 then
		var_14_0 = var_0_3.accelerateNum or 0
	end

	return var_14_0
end

function var_0_0.GetAccelerateNum(arg_15_0)
	return ItemTools.getItemNum(SpHeroChallengeConst.accelerateID)
end

function var_0_0.SavePageState(arg_16_0, arg_16_1)
	var_0_4 = arg_16_1
end

function var_0_0.GetPageState(arg_17_0)
	local var_17_0 = var_0_4

	var_0_4 = nil

	return var_17_0
end

return var_0_0
