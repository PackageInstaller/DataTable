local var_0_0 = {
	IsBirthdayToday = function()
		local var_1_0, var_1_1 = PlayerData:GetPlayerBrithday()

		return manager.time:GetIsSameDate(var_1_0, var_1_1)
	end
}

function var_0_0.IsShowBirthdayPop()
	local var_2_0 = var_0_0.IsBirthdayToday()
	local var_2_1 = false
	local var_2_2 = not BirthData:GetPopShowState()
	local var_2_3 = BirthdayCfg[#BirthdayCfg]

	if var_2_3 then
		local var_2_4 = var_2_3.story_id

		var_2_1 = not manager.story:IsStoryPlayed(var_2_4)
	end

	return var_2_0 and var_2_1 and var_2_2
end

return var_0_0
