local var_0_0 = import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")
local var_0_1 = class("AutoChessActionShopRefreshDataTemplate", var_0_0)

function var_0_1.Init(arg_1_0, arg_1_1)
	var_0_1.super.Init(arg_1_0, arg_1_1)

	arg_1_0.updateType_ = arg_1_1.shop_info.update_type
	arg_1_0.shopItems_ = arg_1_1.shop_info.shop_items
	arg_1_0.refreshShopItemList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.shop_info.update_val or {}) do
		local var_1_0 = {
			uniqueId = iter_1_1.uid,
			buffId = iter_1_1.source_buff_id
		}

		for iter_1_2, iter_1_3 in pairs(iter_1_1.value_list) do
			if iter_1_3.key == AutoChessConst.CHESS_ATTRI_KEY.ATK then
				var_1_0.attackChange = iter_1_3.value
			elseif iter_1_3.key == AutoChessConst.CHESS_ATTRI_KEY.HP then
				var_1_0.hpChange = iter_1_3.value
			elseif iter_1_3.key == AutoChessConst.CHESS_ATTRI_KEY.EXPERIENCE then
				var_1_0.expChange = iter_1_3.value
			end
		end

		table.insert(arg_1_0.refreshShopItemList, var_1_0)
	end
end

return var_0_1
