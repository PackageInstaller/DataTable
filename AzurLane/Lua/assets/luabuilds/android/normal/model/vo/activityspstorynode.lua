class = var_0_10000

local var_0_0 = "ActivitySpStoryNode"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_sp_story
end

var_0_1.NODE_TYPE = {
	OPTION_BRANCH = 3,
	UNRELEASED = 99,
	STORY = 1,
	BATTLE = 2
}

function var_0_1.GetType(arg_2_0)
	return arg_2_0:getConfig("story_type")
end

function var_0_1.GetStoryName(arg_3_0)
	return arg_3_0:getConfig("story")
end

function var_0_1.GetDisplayName(arg_4_0)
	return arg_4_0:getConfig("name")
end

function var_0_1.GetPreNodes(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.getConfig(var_5_0, "pre_event")

	type = var_5_0

	if var_5_0(var_5_1) ~= "table" then
		return {}
	end

	return var_5_1
end

function var_0_1.IsOptionNode(arg_6_0)
	local var_6_0 = arg_6_0:GetUnlockConditions()
	local var_6_1

	_ = var_1_10003

	var_1_10003.each(var_6_0, function(arg_7_0)
		if arg_7_0[1] == var_0_1.CONDITION.PRE_OPTION then
			var_6_1 = true
		end

		return
	end)

	return var_6_1
end

function var_0_1.GetPreEvent(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.GetUnlockConditions(var_8_0)

	_ = var_8_0

	if var_8_0.detect(var_8_1, function(arg_9_0)
		return arg_9_0[1] == var_0_1.CONDITION.PRE_PASSED or arg_9_0[1] == var_0_1.CONDITION.PRE_OPTION
	end) and var_2[2] and var_2[2] > 0 then
		return var_2[2]
	end

	return 0
end

var_0_1.CONDITION = {
	TASK_FINISHED = 6,
	PRE_PASSED = 4,
	PRE_OPTION = 5,
	PASSCHAPTER = 2,
	PT = 3,
	TIME = 1
}

function var_0_1.GetUnlockConditions(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.getConfig(var_10_0, "lock")

	type = var_10_0

	if var_10_0(var_10_1) ~= "table" then
		return {}
	end

	return var_10_1
end

function var_0_1.GetUnlockDesc(arg_11_0)
	return arg_11_0:getConfig("unlock_conditions")
end

function var_0_1.GetCleanBG(arg_12_0)
	return arg_12_0:getConfig("change_background")
end

function var_0_1.GetCleanBGM(arg_13_0)
	return arg_13_0:getConfig("change_bgm")
end

function var_0_1.GetCleanAnimator(arg_14_0)
	local var_14_0

	if arg_14_0:getConfig("change_prefab") == "" then
		var_14_0 = nil
	end

	return var_14_0
end

function var_0_1.IsRecrew(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.getConfig(var_15_0, "label_key")

	type = var_15_0

	if var_15_0(var_15_1) ~= "table" then
		return nil
	end

	StoryStep = var_2

	local var_15_2 = var_2.GetGlobalFlagKey(var_15_1.flagID) .. var_15_1.flagIndex

	PlayerPrefs = var_3

	if not var_3.HasKey(var_15_2) then
		return false
	end

	PlayerPrefs = var_3

	return var_3.GetInt(var_15_2) > 0
end

function var_0_1.GetOptionBranchByStoryName(arg_16_0, arg_16_1)
	pg = var_1_10002

	local var_16_0 = var_1_10002.activity_sp_story
	local var_16_1

	pairs = var_1_10004

	for iter_16_0, iter_16_1 in var_1_10004(var_16_0) do
		if iter_16_1.story == arg_16_0 then
			var_16_1 = iter_16_0
		end
	end

	local var_16_2

	pairs = var_5

	for iter_16_2, iter_16_3 in var_5(var_16_0) do
		if iter_16_3.lock then
			_ = var_10

			var_10.each(iter_16_3.lock, function(arg_17_0)
				if arg_17_0[1] == var_0_1.CONDITION.PRE_OPTION and arg_17_0[2] == var_16_1 and arg_17_0[3] == arg_16_1 then
					var_16_2 = iter_16_3
				end

				return
			end)
		end
	end

	return var_16_2
end

return var_0_1
