local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:get_activity_story_info(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	if arg_1_1 == 173 then
		return self:get_activity_story_info_with_permanent(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	end

	local var_1_0 = self:getActivityObj(arg_1_1)

	if not var_1_0 then
		return
	end

	return var_1_0:get_activity_story_info(arg_1_2, arg_1_3, arg_1_4)
end

function activity_base_manager:get_activity_story_reward(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	local var_2_0 = self:getActivityObj(arg_2_1)

	if not var_2_0 then
		return
	end

	return var_2_0:get_activity_story_reward(arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
end

function activity_base_manager:get_activity_story_jump(arg_3_1, arg_3_2)
	local var_3_0 = self:getActivityObj(arg_3_1)

	if not var_3_0 then
		return
	end

	return var_3_0:get_activity_story_jump(arg_3_2, callback)
end

function activity_base_manager.get_activity_story_info_with_permanent(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local task_data = require("data.task_data")
	local var_4_1 = require("data.activity_story." .. require("data.activity_conf_data")[arg_4_1].story)

	if not arg_4_3 then
		local var_4_2 = 1
		local var_4_3 = {}

		while var_4_1[var_4_2 .. "-1"] do
			if var_4_1[var_4_2 .. "-1"].showtype == arg_4_2 then
				table.insert(var_4_3, {
					stat = 4,
					id = var_4_1[var_4_2 .. "-1"].id,
					name = var_4_1[var_4_2 .. "-1"].name,
					simple = var_4_1[var_4_2 .. "-1"].desc,
					talkid = var_4_1[var_4_2 .. "-1"].talkid,
					des = var_4_1[var_4_2 .. "-1"].name
				})
			end

			var_4_2 = var_4_2 + 1
		end

		activity_base_manager:fireEvent(activity_base_manager.activityEventId.ACTIVITY_STORY_INFO_UPDATE, {
			chapter = arg_4_3,
			showType = arg_4_2,
			dataList = var_4_3
		})
	else
		local var_4_4 = 1
		local var_4_5 = {}

		while var_4_1[arg_4_3 .. "-" .. var_4_4] do
			if var_4_1[arg_4_3 .. "-" .. var_4_4].showtype == arg_4_2 then
				table.insert(var_4_5, {
					stat = 4,
					id = var_4_1[arg_4_3 .. "-" .. var_4_4].id,
					name = var_4_1[arg_4_3 .. "-" .. var_4_4].name,
					simple = var_4_1[arg_4_3 .. "-" .. var_4_4].desc,
					talkid = var_4_1[arg_4_3 .. "-" .. var_4_4].talkid,
					des = var_4_1[arg_4_3 .. "-" .. var_4_4].name
				})
			end

			var_4_4 = var_4_4 + 1
		end

		activity_base_manager:fireEvent(activity_base_manager.activityEventId.ACTIVITY_STORY_INFO_UPDATE, {
			chapter = arg_4_3,
			showType = arg_4_2,
			dataList = var_4_5
		})
	end
end
