local var_0_0 = {}

manager.net:Bind(83021, function(arg_1_0)
	ColorPuzzleData:SetFinishedLevels(arg_1_0.stage_completed_list)
end)

local var_0_1

function var_0_0:LevelClearAction(arg_2_1)
	var_0_1 = arg_2_1
	self.useseconds = math.floor(self.useseconds)

	manager.net:SendWithLoadingNew(83024, self, 83025, var_0_0.OnClearLevelCallback)
end

function var_0_0:OnClearLevelCallback(arg_3_1)
	if isSuccess(self.result) then
		if arg_3_1.result == 1 then
			ColorPuzzleData:SetFinishedLevels(self.finished_list)
		end

		ColorPuzzleData:UpdateLevelClearTime(arg_3_1.stage_id, arg_3_1.useseconds)

		if var_0_1 then
			var_0_1(arg_3_1, self)

			var_0_1 = nil
		end
	else
		ShowTips(self.result)
	end
end

function var_0_0:LevelResetAction()
	self.useseconds = math.floor(self.useseconds)

	manager.net:Send(83024, self, 83025)
end

return var_0_0
