local AutoChessEffectDamageDataTemplate = class("AutoChessEffectDamageDataTemplate", (import("game.views.autoChess.dataTemplate.actionData.buffActionData.AutoChessEffectBaseDataTemplate")))

function AutoChessEffectDamageDataTemplate:Init(arg_1_1)
	AutoChessEffectDamageDataTemplate.super.Init(self, arg_1_1)

	self.targetHpChangeData = {}

	self:InitTargetHpChangeData(arg_1_1.action_effect_info.target_list)
end

function AutoChessEffectDamageDataTemplate:InitTargetHpChangeData(arg_2_1)
	self.targetHpChangeData = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		table.insert(self.targetHpChangeData, {
			chessUid = iter_2_1.id,
			hpChange = iter_2_1.update_list[1].value
		})
	end
end

return AutoChessEffectDamageDataTemplate
