local AutoChessEffectAddAttrDataTemplate = class("AutoChessEffectAddAttrDataTemplate", (import("game.views.autoChess.dataTemplate.actionData.buffActionData.AutoChessEffectBaseDataTemplate")))

function AutoChessEffectAddAttrDataTemplate:Init(arg_1_1)
	AutoChessEffectAddAttrDataTemplate.super.Init(self, arg_1_1)

	self.targetAttributeDataList = {}

	self:InitTargetAttributeData(arg_1_1.action_effect_info.target_list)
end

function AutoChessEffectAddAttrDataTemplate:InitTargetAttributeData(arg_2_1)
	self.targetAttributeDataList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = {
			chessUid = iter_2_1.id,
			attrData = AutoChessItemAttributeDataTemplate.New()
		}

		var_2_0.attrData:Init(iter_2_1.update_list, iter_2_1.temp_id)
		table.insert(self.targetAttributeDataList, var_2_0)
	end
end

return AutoChessEffectAddAttrDataTemplate
