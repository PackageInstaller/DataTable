local var_0_0 = {
	IsBirthdayToday = function()
		local var_1_0, var_1_1 = PlayerData:GetPlayerBrithday()

		return manager.time:GetIsSameDate(var_1_0, var_1_1)
	end
}

function var_0_0.IsShowBirthdayPop()
	return var_0_0.IsBirthdayToday() and (BirthdayCfg[#BirthdayCfg] or nil) and not manager.story:IsStoryPlayed(BirthdayCfg[#BirthdayCfg].story_id) and not BirthData:GetPopShowState()
end

return var_0_0
