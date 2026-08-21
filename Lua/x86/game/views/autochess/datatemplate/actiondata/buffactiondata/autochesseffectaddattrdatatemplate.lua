local var_0_0 = import("game.views.autoChess.dataTemplate.actionData.buffActionData.AutoChessEffectBaseDataTemplate")
local var_0_1 = class("AutoChessEffectAddAttrDataTemplate", var_0_0)

function var_0_1.Init(arg_1_0, arg_1_1)
	var_0_1.super.Init(arg_1_0, arg_1_1)

	arg_1_0.targetAttributeDataList = {}

	arg_1_0:InitTargetAttributeData(arg_1_1.action_effect_info.target_list)
end

function var_0_1.InitTargetAttributeData(arg_2_0, arg_2_1)
	arg_2_0.targetAttributeDataList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = {
			chessUid = iter_2_1.id,
			attrData = AutoChessItemAttributeDataTemplate.New()
		}

		var_2_0.attrData:Init(iter_2_1.update_list, iter_2_1.temp_id)
		table.insert(arg_2_0.targetAttributeDataList, var_2_0)
	end
end

return var_0_1
