local var_0_0 = {}

manager.notify:RegistListener(MATERIAL_MODIFY, function(arg_1_0)
	for iter_1_0, iter_1_1 in pairs(PaChinKoSignCfg.get_id_list_by_activity_id) do
		if PaChinKoSignCfg[iter_1_1[1]].ball_id == arg_1_0 then
			var_0_0.UpdateRedPoint(iter_1_0)
		end
	end
end)
manager.net:Bind(84321, function(arg_2_0)
	PaChinKoData:InitPaChinKoData(arg_2_0)
end)

function var_0_0.SendTriggerLevel(arg_3_0, arg_3_1, arg_3_2)
	manager.net:SendWithLoadingNew(84322, {
		activity_id = arg_3_0,
		type = arg_3_1
	}, 84323, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			PaChinKoData:AddPachinKoReward(arg_3_0, arg_4_0.id)
			var_0_0.UpdateRedPoint(arg_3_0)
			arg_3_2(arg_4_0.id)
		else
			ShowTips(arg_4_0.result)
		end
	end)
end

function var_0_0.InitRedPoint(arg_5_0)
	local var_5_0 = var_0_0.GetRedList(arg_5_0)

	manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(arg_5_0), arg_5_0), var_5_0)
end

function var_0_0.UpdateRedPoint(arg_6_0)
	local var_6_0 = ActivityData:GetActivityData(arg_6_0)
	local var_6_1 = manager.time:GetServerTime() + 1
	local var_6_2 = PaChinKoTools.IsGetAllHightReward(arg_6_0)

	if var_6_1 >= var_6_0.stopTime then
		-- block empty
	elseif var_6_1 >= var_6_0.startTime then
		local var_6_3 = PaChinKoTools.GetCurrencyID(arg_6_0)

		if ItemTools.getItemNum(var_6_3) > 0 and var_6_2 == false then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_PACHINKO .. "_" .. arg_6_0, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_PACHINKO .. "_" .. arg_6_0, 0)

	if var_6_2 then
		local var_6_4 = var_0_0.GetRedList(arg_6_0)

		manager.redPoint:delGroup(string.format("%s%s", ActivityTools.GetRedPointKey(arg_6_0), arg_6_0), var_6_4)
	end
end

function var_0_0.GetRedList(arg_7_0)
	local var_7_0 = PaChinKoTools.GetTaskActivityID(arg_7_0)

	return {
		RedPointConst.ACTIVITY_TASK .. "_" .. var_7_0,
		RedPointConst.ACTIVITY_PACHINKO .. "_" .. arg_7_0
	}
end

return var_0_0
