local var_0_0 = class("GuildRank")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.weekScore = 0
	arg_1_0.monthScore = 0
	arg_1_0.totalScore = 0

	return
end

function var_0_0.GetName(arg_2_0)
	return arg_2_0.name
end

function var_0_0.SetName(arg_3_0, arg_3_1)
	arg_3_0.name = arg_3_1

	return
end

function var_0_0.SetWeekScore(arg_4_0, arg_4_1)
	arg_4_0.weekScore = arg_4_1

	return
end

function var_0_0.SetMonthScore(arg_5_0, arg_5_1)
	arg_5_0.monthScore = arg_5_1

	return
end

function var_0_0.SetTotalScore(arg_6_0, arg_6_1)
	arg_6_0.totalScore = arg_6_1

	return
end

function var_0_0.SetScore(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 1 then
		arg_7_0:SetWeekScore(arg_7_2)
	elseif arg_7_1 == 2 then
		arg_7_0:SetMonthScore(arg_7_2)
	elseif arg_7_1 == 3 then
		arg_7_0:SetTotalScore(arg_7_2)
	end

	return
end

function var_0_0.GetWeekScore(arg_8_0)
	return arg_8_0.weekScore
end

function var_0_0.GetMonthScore(arg_9_0)
	return arg_9_0.monthScore
end

function var_0_0.GetTotalScore(arg_10_0)
	return arg_10_0.totalScore
end

function var_0_0.GetScore(arg_11_0, arg_11_1)
	if arg_11_1 == 0 then
		return arg_11_0:GetWeekScore()
	elseif arg_11_1 == 1 then
		return arg_11_0:GetMonthScore()
	elseif arg_11_1 == 2 then
		return arg_11_0:GetTotalScore()
	end

	return
end

return var_0_0
