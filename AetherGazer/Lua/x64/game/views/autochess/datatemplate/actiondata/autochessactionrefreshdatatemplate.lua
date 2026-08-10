local var_0_0 = import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")
local var_0_1 = class("AutoChessActionRefreshDataTemplate", var_0_0)

function var_0_1.Init(arg_1_0, arg_1_1)
	var_0_1.super.Init(arg_1_0, arg_1_1)
	arg_1_0:InitChessList(arg_1_1)
end

function var_0_1.InitChessList(arg_2_0, arg_2_1)
	arg_2_0.refreshChessList = {}
	arg_2_0.oldChessList = {}

	local var_2_0 = arg_2_1.chess_list

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = AutoChessItemDataTemplate.New()

		var_2_1:Init(iter_2_1)
		table.insert(arg_2_0.refreshChessList, var_2_1)

		local var_2_2 = AutoChessData:GetChessData(var_2_1.uniqueId)

		if var_2_2 then
			arg_2_0.oldChessList[var_2_1.uniqueId] = var_2_2
		end
	end
end

return var_0_1
