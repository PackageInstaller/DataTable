local var_0_0 = {}

manager.net:Bind(83021, function(arg_1_0)
	ColorPuzzleData:SetFinishedLevels(arg_1_0.stage_completed_list)
end)

local var_0_1

function var_0_0.LevelClearAction(arg_2_0, arg_2_1)
	var_0_1 = arg_2_1
	arg_2_0.useseconds = math.floor(arg_2_0.useseconds)

	manager.net:SendWithLoadingNew(83024, arg_2_0, 83025, var_0_0.OnClearLevelCallback)
end

function var_0_0.OnClearLevelCallback(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		if arg_3_1.result == 1 then
			ColorPuzzleData:SetFinishedLevels(arg_3_0.finished_list)
		end

		ColorPuzzleData:UpdateLevelClearTime(arg_3_1.stage_id, arg_3_1.useseconds)

		if var_0_1 then
			var_0_1(arg_3_1, arg_3_0)

			var_0_1 = nil
		end
	else
		ShowTips(arg_3_0.result)
	end
end

function var_0_0.LevelResetAction(arg_4_0)
	arg_4_0.useseconds = math.floor(arg_4_0.useseconds)

	manager.net:Send(83024, arg_4_0, 83025)
end

return var_0_0
