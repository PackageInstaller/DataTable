local AutoChessEffectAddBuffDataTemplate = class("AutoChessEffectAddBuffDataTemplate", (import("game.views.autoChess.dataTemplate.actionData.buffActionData.AutoChessEffectBaseDataTemplate")))

function AutoChessEffectAddBuffDataTemplate:Init(arg_1_1)
	AutoChessEffectAddBuffDataTemplate.super.Init(self, arg_1_1)

	self.addBuffDataList = {}

	self:InitAddBuffData(arg_1_1.action_effect_info.add_buff_info)
end

function AutoChessEffectAddBuffDataTemplate:InitAddBuffData(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = {
			targetType = iter_2_1.target_type,
			targetUid = iter_2_1.target_uid
		}
		local var_2_1 = AutoChessBuffDataTemplate.New()

		var_2_1:Init(iter_2_1.buff_info)

		var_2_0.targetBuffData = var_2_1

		table.insert(self.addBuffDataList, var_2_0)
	end
end

return AutoChessEffectAddBuffDataTemplate
