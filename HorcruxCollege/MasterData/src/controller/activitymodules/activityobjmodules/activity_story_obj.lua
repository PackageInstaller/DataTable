local network = require("network.network")
local activity_manager = require("controller.activity_manager")
local task_data = require("data.task_data")
local activity_conf_data = require("data.activity_conf_data")
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 3

function ACTIVITY_OBJ_NEW:initModuleStory(arg_1_1)
	self._storyData = require("data.activity_story." .. activity_conf_data[self._id].story)
end

function ACTIVITY_OBJ_NEW:getStoryDes(arg_2_1)
	if arg_2_1.stat == var_0_5 then
		local var_2_0 = split(split(self._storyData[arg_2_1.id].starttime, " ")[1], "-")

		return string.format(L_AVAON_VISUAL.tips_3, var_2_0[1], var_2_0[2], var_2_0[3])
	end

	if arg_2_1.stat == var_0_6 then
		return task_data[self._storyData[arg_2_1.id].taskid].name
	end

	return ""
end

function ACTIVITY_OBJ_NEW:get_activity_story_info(arg_3_1, arg_3_2)
	network:rpc("get_activity_story_info", {
		activityid = self._id,
		showtype = arg_3_1,
		chapter = arg_3_2
	}, function(arg_4_0)
		if arg_4_0.result ~= 1 then
			return
		end

		local var_4_0 = false
		local var_4_1 = {}

		for iter_4_0, iter_4_1 in ipairs(arg_4_0.storylist) do
			table.insert(var_4_1, {
				id = iter_4_1.id,
				stat = iter_4_1.stat,
				name = self._storyData[iter_4_1.id].name,
				simple = self._storyData[iter_4_1.id].desc,
				talkid = self._storyData[iter_4_1.id].talkid,
				des = self:getStoryDes(iter_4_1)
			})

			if iter_4_1.stat == var_0_4 then
				var_4_0 = true
			end
		end

		activity_manager:updateActivityAlert("story", self._id, var_4_0)
		activity_manager:fireEvent(activity_manager.activityEventId.ACTIVITY_STORY_INFO_UPDATE, {
			chapter = arg_3_2,
			showType = arg_3_1,
			dataList = var_4_1
		})
	end)
end

function ACTIVITY_OBJ_NEW:get_activity_story_reward(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	network:rpc("get_activity_story_reward", {
		activityid = self._id,
		storyid = arg_5_1,
		isskip = arg_5_4
	}, function(arg_6_0)
		if arg_6_0.result ~= 1 then
			return
		end

		global_gain(arg_6_0)
		self:get_activity_story_info(arg_5_2, arg_5_3)
	end)
end

function ACTIVITY_OBJ_NEW:get_activity_story_jump(arg_7_1)
	if self._storyData[arg_7_1].taskid then
		return task_data[self._storyData[arg_7_1].taskid].jump
	end
end
