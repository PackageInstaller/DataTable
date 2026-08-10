local var_0_0 = import("game.views.autoChess.dataTemplate.actionData.buffActionData.AutoChessEffectBaseDataTemplate")
local var_0_1 = class("AutoChessEffectDamageDataTemplate", var_0_0)

function var_0_1.Init(arg_1_0, arg_1_1)
	var_0_1.super.Init(arg_1_0, arg_1_1)

	arg_1_0.targetHpChangeData = {}

	arg_1_0:InitTargetHpChangeData(arg_1_1.action_effect_info.target_list)
end

function var_0_1.InitTargetHpChangeData(arg_2_0, arg_2_1)
	arg_2_0.targetHpChangeData = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = {
			chessUid = iter_2_1.id,
			hpChange = iter_2_1.update_list[1].value
		}

		table.insert(arg_2_0.targetHpChangeData, var_2_0)
	end
end

return var_0_1
