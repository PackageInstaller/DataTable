local var_0_0 = class("BossRushStoryNode", import("model.vo.BaseVO"))

var_0_0.TRIGGER_TYPE = {
	PT_GOT = 1,
	HIDE_READED = 4,
	STORY_READED = 3,
	SERIES_PASSED = 2
}
var_0_0.NODE_TYPE = {
	BATTLE = 3,
	LOCATION = 4,
	NORMAL = 1,
	EVENT = 2
}
var_0_0.REPEATABLE_KEY = "repeatable"

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_series_enemy_story
end

function var_0_0.Ctor(arg_2_0, arg_2_1, ...)
	var_0_0.super.Ctor(arg_2_0, arg_2_1, ...)

	arg_2_0.configId = arg_2_0.id

	return
end

function var_0_0.GetTriggers(arg_3_0)
	local var_3_0 = (function(arg_4_0)
		if type(arg_4_0) ~= "table" then
			return {}
		end

		return arg_4_0
	end)(arg_3_0:getConfig("trigger_type"))
	local var_3_1 = (function(arg_4_0)
		if type(arg_4_0) ~= "table" then
			return {}
		end

		return arg_4_0
	end)(arg_3_0:getConfig("trigger_value"))

	for iter_3_0 = 1, #var_3_0 do
		table.insert({}, {
			type = var_3_0[iter_3_0],
			value = var_3_1[iter_3_0]
		})
	end

	return {}
end

function var_0_0.IsActive(arg_5_0, arg_5_1, arg_5_2)
	return underscore.all(arg_5_0:GetTriggers(), function(arg_6_0)
		return switch(arg_6_0.type, {
			[var_0_0.TRIGGER_TYPE.PT_GOT] = function()
				return arg_5_2.data1 >= arg_6_0.value
			end,
			[var_0_0.TRIGGER_TYPE.SERIES_PASSED] = function()
				return BossRushSeriesData.New({
					id = arg_6_0.value,
					actId = arg_5_1.id
				}):IsUnlock(arg_5_1)
			end,
			[var_0_0.TRIGGER_TYPE.STORY_READED] = function()
				return var_0_0.New({
					id = arg_6_0.value
				}):IsReaded()
			end,
			[var_0_0.TRIGGER_TYPE.HIDE_READED] = function()
				return not var_0_0.New({
					id = arg_6_0.value
				}):IsReaded()
			end
		}, function()
			return false
		end)
	end)
end

function var_0_0.IsReaded(arg_12_0)
	local var_12_0 = arg_12_0:GetStory()

	if var_12_0 and var_12_0 ~= "" then
		return tobool(pg.NewStoryMgr.GetInstance():IsPlayed(var_12_0))
	else
		return true
	end

	return
end

function var_0_0.GetType(arg_13_0)
	return arg_13_0:getConfig("type")
end

function var_0_0.GetName(arg_14_0)
	return arg_14_0:getConfig("name")
end

function var_0_0.GetIconName(arg_15_0)
	return arg_15_0:getConfig("icon")
end

function var_0_0.GetStory(arg_16_0)
	return arg_16_0:getConfig("story")
end

function var_0_0.GetActiveLink(arg_17_0)
	return arg_17_0:getConfig("line")
end

function var_0_0.GetCleanBG(arg_18_0)
	return noEmptyStr(arg_18_0:getConfig("change_background"))
end

function var_0_0.GetCleanBGM(arg_19_0)
	return noEmptyStr(arg_19_0:getConfig("change_bgm"))
end

function var_0_0.GetCleanAnimator(arg_20_0)
	return noEmptyStr(arg_20_0:getConfig("change_prefab"))
end

function var_0_0.GetParams(arg_21_0, arg_21_1)
	local var_21_0 = noEmptyStr(arg_21_0:getConfig("params"))

	if not var_21_0 then
		return nil
	end

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if iter_21_1[1] == arg_21_1 then
			return iter_21_1
		end
	end

	return nil
end

function var_0_0.IsRecrew(arg_22_0)
	local var_22_0 = arg_22_0:getConfig("label_key")

	if type(var_22_0) ~= "table" then
		return nil
	end

	local var_22_1 = StoryStep.GetGlobalFlagKey(var_22_0.flagID) .. var_22_0.flagIndex

	if not PlayerPrefs.HasKey(var_22_1) then
		return nil
	end

	return PlayerPrefs.GetInt(var_22_1) > 0
end

return var_0_0
