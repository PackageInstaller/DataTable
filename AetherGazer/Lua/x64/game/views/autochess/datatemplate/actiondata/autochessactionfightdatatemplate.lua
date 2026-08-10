local var_0_0 = import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")
local var_0_1 = class("AutoChessActionFightDataTemplate", var_0_0)

function var_0_1.Init(arg_1_0, arg_1_1)
	var_0_1.super.Init(arg_1_0, arg_1_1)
	arg_1_0:InitFightDataList(arg_1_1)
end

function var_0_1.InitFightDataList(arg_2_0, arg_2_1)
	arg_2_0.fightDataList = {}

	local var_2_0 = arg_2_1.action_battle_info.action_list

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = {
			chessUniquiId = iter_2_1.key,
			hpChange = iter_2_1.value
		}

		table.insert(arg_2_0.fightDataList, var_2_1)
	end
end

return var_0_1
