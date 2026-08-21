local var_0_0 = class("ActivitySpStoryNode", import("model.vo.BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_sp_story
end

var_0_0.NODE_TYPE = {
	OPTION_BRANCH = 3,
	UNRELEASED = 99,
	STORY = 1,
	BATTLE = 2
}

function var_0_0.GetType(arg_2_0)
	return arg_2_0:getConfig("story_type")
end

function var_0_0.GetStoryName(arg_3_0)
	return arg_3_0:getConfig("story")
end

function var_0_0.GetDisplayName(arg_4_0)
	return arg_4_0:getConfig("name")
end

function var_0_0.GetPreNodes(arg_5_0)
	local var_5_0 = arg_5_0:getConfig("pre_event")

	if type(var_5_0) ~= "table" then
		return {}
	end

	return var_5_0
end

function var_0_0.IsOptionNode(arg_6_0)
	local var_6_0

	_.each(arg_6_0:GetUnlockConditions(), function(arg_7_0)
		if arg_7_0[1] == var_0_0.CONDITION.PRE_OPTION then
			var_6_0 = true
		end

		return
	end)

	return nil
end

function var_0_0.GetPreEvent(arg_8_0)
	local var_8_0 = _.detect(arg_8_0:GetUnlockConditions(), function(arg_9_0)
		return arg_9_0[1] == var_0_0.CONDITION.PRE_PASSED or arg_9_0[1] == var_0_0.CONDITION.PRE_OPTION
	end)

	if var_8_0 and var_8_0[2] and var_8_0[2] > 0 then
		return var_8_0[2]
	end

	return 0
end

var_0_0.CONDITION = {
	TASK_FINISHED = 6,
	PRE_PASSED = 4,
	PRE_OPTION = 5,
	PASSCHAPTER = 2,
	PT = 3,
	TIME = 1
}

function var_0_0.GetUnlockConditions(arg_10_0)
	local var_10_0 = arg_10_0:getConfig("lock")

	if type(var_10_0) ~= "table" then
		return {}
	end

	return var_10_0
end

function var_0_0.GetUnlockDesc(arg_11_0)
	return arg_11_0:getConfig("unlock_conditions")
end

function var_0_0.GetCleanBG(arg_12_0)
	return arg_12_0:getConfig("change_background")
end

function var_0_0.GetCleanBGM(arg_13_0)
	return arg_13_0:getConfig("change_bgm")
end

function var_0_0.GetCleanAnimator(arg_14_0)
	local var_14_0 = arg_14_0:getConfig("change_prefab")

	if var_14_0 == "" then
		var_14_0 = nil
	end

	return var_14_0
end

function var_0_0.IsRecrew(arg_15_0)
	local var_15_0 = arg_15_0:getConfig("label_key")

	if type(var_15_0) ~= "table" then
		return nil
	end

	local var_15_1 = StoryStep.GetGlobalFlagKey(var_15_0.flagID) .. var_15_0.flagIndex

	if not PlayerPrefs.HasKey(var_15_1) then
		return false
	end

	return PlayerPrefs.GetInt(var_15_1) > 0
end

function var_0_0.GetOptionBranchByStoryName(arg_16_0, arg_16_1)
	local var_16_0

	for iter_16_0, iter_16_1 in pairs(pg.activity_sp_story) do
		if iter_16_1.story == arg_16_0 then
			var_16_0 = iter_16_0
		end
	end

	local var_16_1

	for iter_16_2, iter_16_3 in pairs(pg.activity_sp_story) do
		if iter_16_3.lock then
			_.each(iter_16_3.lock, function(arg_17_0)
				if arg_17_0[1] == var_0_0.CONDITION.PRE_OPTION and arg_17_0[2] == var_16_0 and arg_17_0[3] == arg_16_1 then
					var_16_1 = iter_16_3
				end

				return
			end)
		end
	end

	return nil
end

return var_0_0
