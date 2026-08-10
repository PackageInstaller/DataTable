local var_0_0 = class("AutoChessRoundBattleDataTemplate")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.round = 0
	arg_1_0.actionList = {}
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.round = arg_2_1.group_id

	arg_2_0:InitActionList(arg_2_1.action_list)
end

function var_0_0.InitActionList(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = iter_3_1.action_type
		local var_3_1
		local var_3_2

		if var_3_0 ~= AutoChessConst.ACTION_TYPE.EFFECT then
			if AutoChessConst.ACTION_CONFIG[var_3_0] then
				var_3_2 = AutoChessConst.ACTION_CONFIG[var_3_0].dataClassName
			else
				Debug.LogError(string.format("未找到对应的行为数据类, actionType: %s", var_3_0))
			end
		else
			if actionEffectType == AutoChessConst.ACTION_EFFECT_TYPE.GLOBAL_ATTR_BUFF then
				return
			end

			local var_3_3 = iter_3_1.action_effect_info.effect_enum

			if AutoChessConst.ACTION_EFFECT_CONFIG[var_3_3] then
				var_3_2 = AutoChessConst.ACTION_EFFECT_CONFIG[var_3_3].dataClassName
			else
				Debug.LogError(string.format("未找到对应的效果行为数据类, actionType: %s, actionEffectType: %s", var_3_0, var_3_3))
			end
		end

		if var_3_2 then
			local var_3_4 = _G[var_3_2].New()

			var_3_4:Init(iter_3_1)
			var_3_4:SetRound(arg_3_0.round)
			table.insert(arg_3_0.actionList, var_3_4)
		end
	end

	table.sort(arg_3_0.actionList, function(arg_4_0, arg_4_1)
		return arg_4_0.actionId < arg_4_1.actionId
	end)
end

return var_0_0
