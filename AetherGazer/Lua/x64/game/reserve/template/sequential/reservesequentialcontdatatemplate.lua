local var_0_0 = import("game.reserve.ReserveContDataTemplate")
local var_0_1 = class("ReserveSequentialContDataTemplate", var_0_0)

function var_0_1.SetAffix(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_0.team_dic[arg_1_1] then
		arg_1_0.team_dic[arg_1_1]:SetAffix(arg_1_2, arg_1_3)
	end
end

function var_0_1.SetAffixList(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0.team_dic[arg_2_1] then
		arg_2_0.team_dic[arg_2_1]:SetAffixList(arg_2_2)
	end
end

function var_0_1.GetAffixList(arg_3_0, arg_3_1)
	if arg_3_0.team_dic[arg_3_1] then
		return arg_3_0.team_dic[arg_3_1]:GetAffixList()
	else
		return {}
	end
end

return var_0_1
