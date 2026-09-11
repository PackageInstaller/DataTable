local AutoChessEffectRemoveShopDataTemplate = class("AutoChessEffectRemoveShopDataTemplate", (import("game.views.autoChess.dataTemplate.actionData.buffActionData.AutoChessEffectBaseDataTemplate")))

function AutoChessEffectRemoveShopDataTemplate:Init(arg_1_1)
	AutoChessEffectRemoveShopDataTemplate.super.Init(self, arg_1_1)

	self.removeShopIdList_ = {}

	self:InitRemoveShopIdList(arg_1_1.action_effect_info.shop_remove_uids)
end

function AutoChessEffectRemoveShopDataTemplate:InitRemoveShopIdList(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		table.insert(self.removeShopIdList_, iter_2_1)
	end
end

return AutoChessEffectRemoveShopDataTemplate
