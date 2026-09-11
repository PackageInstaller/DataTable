local AutoChessActionShopRefreshDataTemplate = class("AutoChessActionShopRefreshDataTemplate", (import("game.views.autoChess.dataTemplate.actionData.AutoChessActionBaseDataTemplate")))

function AutoChessActionShopRefreshDataTemplate:Init(arg_1_1)
	AutoChessActionShopRefreshDataTemplate.super.Init(self, arg_1_1)

	self.updateType_ = arg_1_1.shop_info.update_type
	self.shopItems_ = arg_1_1.shop_info.shop_items
	self.refreshShopItemList = {}

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

		table.insert(self.refreshShopItemList, var_1_0)
	end
end

return AutoChessActionShopRefreshDataTemplate
