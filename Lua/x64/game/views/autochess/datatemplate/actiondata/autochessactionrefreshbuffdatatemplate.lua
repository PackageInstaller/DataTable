local var_0_0 = import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")
local var_0_1 = class("AutoChessActionRefreshBuffDataTemplate", var_0_0)

function var_0_1.Init(arg_1_0, arg_1_1)
	var_0_1.super.Init(arg_1_0, arg_1_1)
	arg_1_0:RefreshBuffData(arg_1_1.buff_info)
end

function var_0_1.RefreshBuffData(arg_2_0, arg_2_1)
	arg_2_0.refreshBuffDataList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = AutoChessBuffDataTemplate.New()

		var_2_0:Init(iter_2_1)
		table.insert(arg_2_0.refreshBuffDataList, var_2_0)
	end
end

return var_0_1
