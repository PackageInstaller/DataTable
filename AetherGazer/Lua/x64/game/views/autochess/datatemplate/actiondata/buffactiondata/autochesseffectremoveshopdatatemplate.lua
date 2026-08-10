local var_0_0 = import("game.views.autoChess.dataTemplate.actionData.buffActionData.AutoChessEffectBaseDataTemplate")
local var_0_1 = class("AutoChessEffectRemoveShopDataTemplate", var_0_0)

function var_0_1.Init(arg_1_0, arg_1_1)
	var_0_1.super.Init(arg_1_0, arg_1_1)

	arg_1_0.removeShopIdList_ = {}

	arg_1_0:InitRemoveShopIdList(arg_1_1.action_effect_info.shop_remove_uids)
end

function var_0_1.InitRemoveShopIdList(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		table.insert(arg_2_0.removeShopIdList_, iter_2_1)
	end
end

return var_0_1
