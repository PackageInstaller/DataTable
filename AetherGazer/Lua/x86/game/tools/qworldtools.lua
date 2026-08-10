local var_0_0 = {}

QWorldMessageType = {
	TASK = 9,
	TALK = 3,
	FIND_ROUTE = 8,
	ENTER = 1,
	EXIT = 2,
	IN_TASK_BEHAVIOUR = 5,
	TAG_OPERATION = 7,
	TALK_BRANCH = 4,
	FURNITURE_INTERACT = 6
}

function var_0_0.SendMessageToSDK(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	if arg_1_2 == QWorldMessageType.ENTER or arg_1_2 == QWorldMessageType.EXIT then
		local var_1_0 = QWorldData:GetCachedPosition()
		local var_1_1 = {
			var_1_0[1],
			",",
			var_1_0[2],
			",",
			var_1_0[3]
		}

		SDKTools.SendMessageToSDK("activity_sandplay_act", {
			activity_id = arg_1_0,
			stage_id = arg_1_1,
			type = arg_1_2,
			params_select = arg_1_3,
			location_id = table.concat(var_1_1),
			params_list = arg_1_4,
			param_id = arg_1_5
		})
	else
		local var_1_2 = QWorldLuaBridge.GetPlayer().transform.position
		local var_1_3 = {
			var_1_2.x,
			",",
			var_1_2.y,
			",",
			var_1_2.z
		}

		SDKTools.SendMessageToSDK("activity_sandplay_act", {
			activity_id = arg_1_0,
			stage_id = arg_1_1,
			type = arg_1_2,
			params_select = arg_1_3,
			location_id = table.concat(var_1_3),
			params_list = arg_1_4,
			param_id = arg_1_5
		})
	end
end

function var_0_0.CheckTagCanOpen(arg_2_0)
	local var_2_0 = SandplayTagCfg[arg_2_0]
	local var_2_1 = true

	if not var_2_0 then
		var_2_1 = false
	else
		if var_2_0.activityId > 0 then
			var_2_1 = var_2_1 and ActivityData:GetActivityIsOpen(var_2_0.activityId)
		end

		if var_2_0.questId > 0 then
			var_2_1 = var_2_1 and QWorldQuestTool.IsSubQuestFinish(var_2_0.questId)
		end
	end

	return var_2_1
end

return var_0_0
