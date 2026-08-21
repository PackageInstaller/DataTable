local var_0_0 = {}

manager.net:Bind(79301, function(arg_1_0)
	AdvanceMonsterTestData:SetData(arg_1_0)
end)

function var_0_0.SaveCustomList(arg_2_0, arg_2_1, arg_2_2)
	AdvanceMonsterTestData:SaveCustomList(arg_2_1, arg_2_2)

	local var_2_0 = {
		activity_id = ActivityConst.ACTIVITY_ADVANCE_MONSTER_TEST,
		stage_id = arg_2_1,
		affix_list = arg_2_2
	}

	manager.net:SendWithLoadingNew(79302, var_2_0, 79303, handler(arg_2_0, arg_2_0.OnSaveCustomList))
end

function var_0_0.OnSaveCustomList(arg_3_0, arg_3_1, arg_3_2)
	if isSuccess(arg_3_1.result) then
		-- block empty
	else
		ShowTips(arg_3_1.result)
	end
end

return var_0_0
