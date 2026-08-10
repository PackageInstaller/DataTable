local var_0_0 = {}

manager.net:Bind(61091, function(arg_1_0)
	PaperCutData:SetData(arg_1_0)
end)

function var_0_0.RequireReceive(arg_2_0, arg_2_1)
	manager.net:SendWithLoadingNew(61088, {
		id = arg_2_0
	}, 61089, function(arg_3_0)
		arg_2_1(arg_3_0)
	end)
end

function var_0_0.RequireComplete(arg_4_0, arg_4_1, arg_4_2)
	manager.net:SendWithLoadingNew(61086, {
		activity_id = arg_4_0,
		score = arg_4_1
	}, 61087, function(arg_5_0)
		if isSuccess(arg_5_0.result) then
			PaperCutData:SetScore(arg_4_0, arg_4_1)

			if arg_4_2 ~= nil then
				arg_4_2()
			end
		else
			ShowTips(arg_5_0.result)
		end
	end)
end

function var_0_0.Init(arg_6_0)
	local var_6_0 = ActivityData:GetActivityData(arg_6_0).subActivityIdList

	if #var_6_0 > 0 then
		local var_6_1 = {}
		local var_6_2 = {}

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			PaperCutCfg[iter_6_1].main_activity_id = arg_6_0

			local var_6_3 = ActivityPointRewardCfg.get_id_list_by_activity_id[iter_6_1]

			if var_6_3 ~= nil then
				for iter_6_2, iter_6_3 in ipairs(var_6_3) do
					local var_6_4 = ActivityPointRewardCfg[iter_6_3]

					PaperCutCfg[var_6_4.activity_id].task_id = iter_6_3
				end
			end

			var_6_1[#var_6_1 + 1] = string.format("%s_%s_%s_Select", RedPointConst.PAPER_CUT, arg_6_0, iter_6_1)
			var_6_2[#var_6_2 + 1] = string.format("%s_%s_%s_Reward", RedPointConst.PAPER_CUT, arg_6_0, iter_6_1)
		end

		local var_6_5 = string.format("%s_%s_Select", RedPointConst.PAPER_CUT, arg_6_0)
		local var_6_6 = string.format("%s_%s_Reward", RedPointConst.PAPER_CUT, arg_6_0)

		manager.redPoint:addGroup(var_6_5, var_6_1)
		manager.redPoint:addGroup(var_6_6, var_6_2)
		manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.PAPER_CUT, arg_6_0), {
			var_6_5,
			var_6_6
		})
	end
end

return var_0_0
