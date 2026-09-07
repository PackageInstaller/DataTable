local ActivitySpStoryNode = class("ActivitySpStoryNode", import("model.vo.BaseVO"))

function ActivitySpStoryNode:bindConfigTable()
	return pg.activity_sp_story
end

ActivitySpStoryNode.NODE_TYPE = {
	OPTION_BRANCH = 3,
	UNRELEASED = 99,
	STORY = 1,
	BATTLE = 2
}

function ActivitySpStoryNode:GetType()
	return self:getConfig("story_type")
end

function ActivitySpStoryNode:GetStoryName()
	return self:getConfig("story")
end

function ActivitySpStoryNode:GetDisplayName()
	return self:getConfig("name")
end

function ActivitySpStoryNode:GetPreNodes()
	local var_5_0 = self:getConfig("pre_event")

	if type(var_5_0) ~= "table" then
		return {}
	end

	return var_5_0
end

function ActivitySpStoryNode:IsOptionNode()
	local var_6_0

	_.each(self:GetUnlockConditions(), function(arg_7_0)
		if arg_7_0[1] == ActivitySpStoryNode.CONDITION.PRE_OPTION then
			var_6_0 = true
		end

		return
	end)

	return nil
end

function ActivitySpStoryNode:GetPreEvent()
	local var_8_0 = _.detect(self:GetUnlockConditions(), function(arg_9_0)
		return arg_9_0[1] == ActivitySpStoryNode.CONDITION.PRE_PASSED or arg_9_0[1] == ActivitySpStoryNode.CONDITION.PRE_OPTION
	end)

	if var_8_0 and var_8_0[2] and var_8_0[2] > 0 then
		return var_8_0[2]
	end

	return 0
end

ActivitySpStoryNode.CONDITION = {
	TASK_FINISHED = 6,
	PRE_PASSED = 4,
	PRE_OPTION = 5,
	PASSCHAPTER = 2,
	PT = 3,
	TIME = 1
}

function ActivitySpStoryNode:GetUnlockConditions()
	local var_10_0 = self:getConfig("lock")

	if type(var_10_0) ~= "table" then
		return {}
	end

	return var_10_0
end

function ActivitySpStoryNode:GetUnlockDesc()
	return self:getConfig("unlock_conditions")
end

function ActivitySpStoryNode:GetCleanBG()
	return self:getConfig("change_background")
end

function ActivitySpStoryNode:GetCleanBGM()
	return self:getConfig("change_bgm")
end

function ActivitySpStoryNode:GetCleanAnimator()
	local var_14_0 = self:getConfig("change_prefab")

	if var_14_0 == "" then
		var_14_0 = nil
	end

	return var_14_0
end

function ActivitySpStoryNode:IsRecrew()
	local var_15_0 = self:getConfig("label_key")

	if type(var_15_0) ~= "table" then
		return nil
	end

	local var_15_1 = StoryStep.GetGlobalFlagKey(var_15_0.flagID) .. var_15_0.flagIndex

	if not PlayerPrefs.HasKey(var_15_1) then
		return false
	end

	return PlayerPrefs.GetInt(var_15_1) > 0
end

function ActivitySpStoryNode:GetOptionBranchByStoryName(arg_16_1)
	local var_16_0

	for iter_16_0, iter_16_1 in pairs(pg.activity_sp_story) do
		if iter_16_1.story == self then
			var_16_0 = iter_16_0
		end
	end

	local var_16_1

	for iter_16_2, iter_16_3 in pairs(pg.activity_sp_story) do
		if iter_16_3.lock then
			_.each(iter_16_3.lock, function(arg_17_0)
				if arg_17_0[1] == ActivitySpStoryNode.CONDITION.PRE_OPTION and arg_17_0[2] == var_16_0 and arg_17_0[3] == arg_16_1 then
					var_16_1 = iter_16_3
				end

				return
			end)
		end
	end

	return nil
end

return ActivitySpStoryNode
