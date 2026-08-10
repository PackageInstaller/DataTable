local var_0_0 = {}

manager.net:Bind(11055, function(arg_1_0)
	SkinTrialData:InitData(arg_1_0)
	manager.notify:Invoke(SKIN_TRIAL_UPDATE)
end)

function var_0_0.UpdateRedPoint(arg_2_0)
	if not ActivityData:GetActivityIsOpen(arg_2_0) then
		if ActivitySkinTrialCfg.get_id_list_by_activity_id[arg_2_0] ~= nil then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, arg_2_0), 0)
		else
			local var_2_0 = ActivityData:GetActivityData(arg_2_0).subActivityIdList

			if var_2_0 ~= nil then
				for iter_2_0, iter_2_1 in ipairs(var_2_0) do
					manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, iter_2_1), 0)
				end
			end
		end
	end
end

function var_0_0.RequestSkinTrialReward(arg_3_0)
	local var_3_0 = {
		cfg_id = arg_3_0
	}

	manager.net:SendWithLoadingNew(11066, var_3_0, 11067, var_0_0.OnRewardSuccess)
end

function var_0_0.OnRewardSuccess(arg_4_0, arg_4_1)
	SkinTrialData:OnRewardSuccess(arg_4_1.cfg_id)

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.item_list) do
		table.insert(var_4_0, {
			id = iter_4_1.id,
			num = iter_4_1.num
		})
	end

	getReward(var_4_0)
	manager.notify:Invoke(SKIN_TRIAL_UPDATE)
end

return var_0_0
