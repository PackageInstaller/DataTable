local var_0_0 = {}

manager.net:Bind(14503, function(arg_1_0)
	OathAssignmentData:UpdateFromServerData(arg_1_0.assignment_list, arg_1_0.send_type)
end)

local function var_0_1()
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(WeddingCfg.all) do
		var_2_0[iter_2_1] = OathCollectionContentData:GetOathLevel(iter_2_1)
	end

	return var_2_0
end

function var_0_0.SubmitOathTask(arg_3_0)
	local var_3_0 = var_0_1()

	manager.net:SendWithLoadingNew(14512, {
		id = arg_3_0
	}, 14513, var_0_0.OnSubmitOathTask(var_3_0))
end

function var_0_0.OnSubmitOathTask(arg_4_0)
	return function(arg_5_0, arg_5_1)
		if isSuccess(arg_5_0.result) then
			local var_5_0 = mergeReward2(arg_5_0.reward_list or {})

			if #var_5_0 > 0 then
				getReward2(var_5_0)
			end

			local var_5_1 = var_0_1()

			for iter_5_0, iter_5_1 in pairs(var_5_1) do
				local var_5_2 = var_5_1[iter_5_0]

				if var_5_2 > (arg_4_0[iter_5_0] or var_5_2) then
					OathCollectionContentData:AddNewLevelUpdateMsg(iter_5_0)
				end
			end

			if OathCollectionContentData:HasNewLevelUpdateMsg() then
				manager.notify:Invoke(OATH_HERO_LV_UPDATE)
				manager.notify:Invoke(OATH_HERO_LEVEL_UP)
			end
		else
			ShowTips(arg_5_0.result)
		end
	end
end

return var_0_0
