local var_0_0 = import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")
local var_0_1 = class("AutoChessActionDeadDataTemplate", var_0_0)

function var_0_1.Init(arg_1_0, arg_1_1)
	var_0_1.super.Init(arg_1_0, arg_1_1)
	arg_1_0:InitDeadList(arg_1_1)
end

function var_0_1.InitDeadList(arg_2_0, arg_2_1)
	arg_2_0.deadChessList = {}

	local var_2_0 = arg_2_1.action_dead_info.uid_list

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		arg_2_0.deadChessList[#arg_2_0.deadChessList + 1] = iter_2_1
	end
end

return var_0_1
