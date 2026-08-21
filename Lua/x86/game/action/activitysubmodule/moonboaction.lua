local var_0_0 = {}

manager.net:Bind(61005, function(arg_1_0)
	MoonBoData:SetData(arg_1_0)
end)

function var_0_0.GetMoonBo(arg_2_0, arg_2_1)
	manager.net:SendWithLoadingNew(61006, {
		activity_id = arg_2_1
	}, 61007, handler(arg_2_0, arg_2_0.OnMoonBoReward))
end

function var_0_0.OnMoonBoReward(arg_3_0, arg_3_1, arg_3_2)
	if isSuccess(arg_3_1.result) then
		MoonBoData:GetRewards(arg_3_1)
		manager.notify:Invoke(MOONBO_SUCCESS, {})
	else
		ShowTips(GetTips(arg_3_1.result))
	end
end

return var_0_0
