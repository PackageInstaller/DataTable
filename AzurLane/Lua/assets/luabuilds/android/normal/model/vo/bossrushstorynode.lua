class = var_0_10000

local var_0_0 = "BossRushStoryNode"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.TRIGGER_TYPE = {
	PT_GOT = 1,
	HIDE_READED = 4,
	STORY_READED = 3,
	SERIES_PASSED = 2
}
var_0_1.NODE_TYPE = {
	BATTLE = 3,
	LOCATION = 4,
	NORMAL = 1,
	EVENT = 2
}
var_0_1.REPEATABLE_KEY = "repeatable"

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_series_enemy_story
end

function var_0_1.Ctor(arg_2_0, arg_2_1, ...)
	var_0_1.super.Ctor(arg_2_0, arg_2_1, ...)

	arg_2_0.configId = arg_2_0.id

	return
end

function var_0_1.GetTriggers(arg_3_0)
	local var_3_0 = (function(arg_4_0)
		type = var_2_10001

		if var_2_10001(arg_4_0) ~= "table" then
			return {}
		end

		return arg_4_0
	end)(arg_3_0:getConfig("trigger_type"))
	local var_3_1 = var_1(arg_3_0:getConfig("trigger_value"))
	local var_3_2 = {}

	for iter_3_0 = 1, #var_3_0 do
		table = var_1_10009

		var_1_10009.insert(var_3_2, {
			type = var_3_0[iter_3_0],
			value = var_3_1[iter_3_0]
		})
	end

	return var_3_2
end

function var_0_1.IsActive(arg_5_0, arg_5_1, arg_5_2)
	underscore = var_1_10003

	return var_1_10003.all(arg_5_0:GetTriggers(), function(arg_6_0)
		switch = var_2_10001

		return var_2_10001(arg_6_0.type, {
			[var_0_1.TRIGGER_TYPE.PT_GOT] = function()
				return arg_5_2.data1 >= arg_6_0.value
			end,
			[var_0_1.TRIGGER_TYPE.SERIES_PASSED] = function()
				BossRushSeriesData = var_3_10000

				local var_8_0 = var_3_10000.New({
					id = arg_6_0.value,
					actId = arg_5_1.id
				})

				return var_0.IsUnlock(var_8_0, arg_5_1)
			end,
			[var_0_1.TRIGGER_TYPE.STORY_READED] = function()
				local var_9_0 = var_0_1.New({
					id = arg_6_0.value
				})

				return var_0.IsReaded(var_9_0)
			end,
			[var_0_1.TRIGGER_TYPE.HIDE_READED] = function()
				local var_10_0 = var_0_1.New({
					id = arg_6_0.value
				})

				return not var_0.IsReaded(var_10_0)
			end
		}, function()
			return false
		end)
	end)
end

function var_0_1.IsReaded(arg_12_0)
	local var_12_0 = arg_12_0

	if arg_12_0.GetStory(var_12_0) and var_1 ~= "" then
		tobool = var_12_0
		pg = var_1_10003

		local var_12_1 = var_1_10003.NewStoryMgr.GetInstance()

		return var_12_0(var_3.IsPlayed(var_12_1, var_1))
	else
		return true
	end

	return
end

function var_0_1.GetType(arg_13_0)
	return arg_13_0:getConfig("type")
end

function var_0_1.GetName(arg_14_0)
	return arg_14_0:getConfig("name")
end

function var_0_1.GetIconName(arg_15_0)
	return arg_15_0:getConfig("icon")
end

function var_0_1.GetStory(arg_16_0)
	return arg_16_0:getConfig("story")
end

function var_0_1.GetActiveLink(arg_17_0)
	return arg_17_0:getConfig("line")
end

function var_0_1.GetCleanBG(arg_18_0)
	noEmptyStr = var_1_10001

	return var_1_10001(arg_18_0:getConfig("change_background"))
end

function var_0_1.GetCleanBGM(arg_19_0)
	noEmptyStr = var_1_10001

	return var_1_10001(arg_19_0:getConfig("change_bgm"))
end

function var_0_1.GetCleanAnimator(arg_20_0)
	noEmptyStr = var_1_10001

	return var_1_10001(arg_20_0:getConfig("change_prefab"))
end

function var_0_1.GetParams(arg_21_0, arg_21_1)
	noEmptyStr = var_1_10002

	if not var_1_10002(arg_21_0:getConfig("params")) then
		return nil
	end

	ipairs = var_3

	for iter_21_0, iter_21_1 in var_3(var_2) do
		if iter_21_1[1] == arg_21_1 then
			return iter_21_1
		end
	end

	return nil
end

function var_0_1.IsRecrew(arg_22_0)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.getConfig(var_22_0, "label_key")

	type = var_22_0

	if var_22_0(var_22_1) ~= "table" then
		return nil
	end

	StoryStep = var_2

	local var_22_2 = var_2.GetGlobalFlagKey(var_22_1.flagID) .. var_22_1.flagIndex

	PlayerPrefs = var_3

	if not var_3.HasKey(var_22_2) then
		return nil
	end

	PlayerPrefs = var_3

	return var_3.GetInt(var_22_2) > 0
end

return var_0_1
