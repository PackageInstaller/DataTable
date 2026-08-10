local var_0_0 = import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")
local var_0_1 = class("AutoChessActionGlobalAttrDataTemplate", var_0_0)

function var_0_1.Init(arg_1_0, arg_1_1)
	var_0_1.super.Init(arg_1_0, arg_1_1)

	arg_1_0.attrList_ = {}

	arg_1_0:InitGlobalAttrData(arg_1_1.attr_list)
end

function var_0_1.InitGlobalAttrData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		table.insert(arg_2_0.attrList_, {
			key = iter_2_1.key,
			value = iter_2_1.value
		})
	end
end

return var_0_1
