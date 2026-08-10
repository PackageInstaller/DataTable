local var_0_0 = import("game.views.autoChess.dataTemplate.actionData.buffActionData.AutoChessEffectBaseDataTemplate")
local var_0_1 = class("AutoChessEffectAddBuffDataTemplate", var_0_0)

function var_0_1.Init(arg_1_0, arg_1_1)
	var_0_1.super.Init(arg_1_0, arg_1_1)

	arg_1_0.addBuffDataList = {}

	arg_1_0:InitAddBuffData(arg_1_1.action_effect_info.add_buff_info)
end

function var_0_1.InitAddBuffData(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = {
			targetType = iter_2_1.target_type,
			targetUid = iter_2_1.target_uid
		}
		local var_2_1 = AutoChessBuffDataTemplate.New()

		var_2_1:Init(iter_2_1.buff_info)

		var_2_0.targetBuffData = var_2_1

		table.insert(arg_2_0.addBuffDataList, var_2_0)
	end
end

return var_0_1
