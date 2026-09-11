local AutoChessRoundBattleDataTemplate = class("AutoChessRoundBattleDataTemplate")

function AutoChessRoundBattleDataTemplate:Ctor()
	self.round = 0
	self.actionList = {}
end

function AutoChessRoundBattleDataTemplate:Init(arg_2_1)
	self.round = arg_2_1.group_id

	self:InitActionList(arg_2_1.action_list)
end

function AutoChessRoundBattleDataTemplate:InitActionList(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_1

		if iter_3_1.action_type ~= AutoChessConst.ACTION_TYPE.EFFECT then
			if AutoChessConst.ACTION_CONFIG[iter_3_1.action_type] then
				var_3_1 = AutoChessConst.ACTION_CONFIG[iter_3_1.action_type].dataClassName
			else
				Debug.LogError(string.format("未找到对应的行为数据类, actionType: %s", iter_3_1.action_type))
			end
		else
			if actionEffectType == AutoChessConst.ACTION_EFFECT_TYPE.GLOBAL_ATTR_BUFF then
				return
			end

			local var_3_2 = iter_3_1.action_effect_info.effect_enum

			if AutoChessConst.ACTION_EFFECT_CONFIG[iter_3_1.action_effect_info.effect_enum] then
				var_3_1 = AutoChessConst.ACTION_EFFECT_CONFIG[var_3_2].dataClassName
			else
				Debug.LogError(string.format("未找到对应的效果行为数据类, actionType: %s, actionEffectType: %s", iter_3_1.action_type, var_3_2))
			end
		end

		if var_3_1 then
			local var_3_3 = _G[var_3_1].New()

			var_3_3:Init(iter_3_1)
			var_3_3:SetRound(self.round)
			table.insert(self.actionList, var_3_3)
		end
	end

	table.sort(self.actionList, function(arg_4_0, arg_4_1)
		return arg_4_0.actionId < arg_4_1.actionId
	end)
end

return AutoChessRoundBattleDataTemplate
