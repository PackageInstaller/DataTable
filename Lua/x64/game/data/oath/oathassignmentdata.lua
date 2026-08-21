local var_0_0 = singletonClass("OathAssignmentData")

function var_0_0.Init(arg_1_0)
	arg_1_0.oathAssignmentData = {}
end

function var_0_0.UpdateOneHeroAllTaskRed(arg_2_0, arg_2_1)
	local var_2_0 = WeddingAssignmentCfg.get_id_list_by_hero_id[arg_2_1]
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		var_2_1 = OathSupportData:UpdateOathTaskRedData(iter_2_1, var_2_1)
	end

	OathSupportData:UpdateOathTaskRedPoint(var_2_1)
	manager.notify:Invoke(OATH_TASK_UPDATE)
end

function var_0_0.UpdateFromServerData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.oathAssignmentData = arg_3_0.oathAssignmentData or {}

	local var_3_0 = OathSupportData:GetOathTaskRedInitList()

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0:UpdateOathAssignment(iter_3_1)

		var_3_0 = OathSupportData:UpdateOathTaskRedData(iter_3_1.id, var_3_0)
	end

	OathSupportData:UpdateOathTaskRedPoint(var_3_0)
	manager.notify:Invoke(OATH_TASK_UPDATE)
end

function var_0_0.UpdateOathAssignment(arg_4_0, arg_4_1)
	local var_4_0 = WeddingAssignmentCfg[arg_4_1.id].wedding_hero

	arg_4_0.oathAssignmentData[arg_4_1.id] = {
		id = arg_4_1.id,
		progress = arg_4_1.progress,
		status = arg_4_1.complete_flag,
		expired_timestamp = arg_4_1.expired_timestamp
	}
end

function var_0_0.GetOathAssignmentByID(arg_5_0, arg_5_1)
	if not arg_5_0.oathAssignmentData[arg_5_1] then
		arg_5_0.oathAssignmentData[arg_5_1] = {
			status = 0,
			expired_timestamp = 0,
			progress = 0,
			id = arg_5_1
		}
	end

	return arg_5_0.oathAssignmentData[arg_5_1]
end

function var_0_0.GetOathAssignmentHeroLevelProgress(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = WeddingAssignmentCfg.get_id_list_by_hero_id[arg_6_1]
	local var_6_1 = 0
	local var_6_2 = 0

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_3 = WeddingAssignmentCfg[iter_6_1]

		if var_6_3 and var_6_3.wedding_level == arg_6_2 then
			var_6_1 = var_6_1 + 1

			local var_6_4 = arg_6_0:GetOathAssignmentByID(iter_6_1)

			if var_6_4 and var_6_4.status == 1 then
				var_6_2 = var_6_2 + 1
			end
		end
	end

	return var_6_2, var_6_1
end

return var_0_0
