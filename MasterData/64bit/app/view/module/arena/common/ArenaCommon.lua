local var_0_0 = {}
local var_0_1 = g.core.common.Goods

function var_0_0.checkLeftCount(arg_1_0, arg_1_1)
	arg_1_0 = arg_1_0 or 1

	local var_1_0 = g.core.model.User.shopData:getLeftCount(1)

	if var_1_0 < arg_1_0 or var_1_0 == 0 then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
			type = var_0_1.TYPE_ITEM,
			value = var_0_1.ITEM.TYPE_ARENA_TOKEN,
			shopId = g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.ARENA_TOKEN
		}), {
			touchDisappear = true
		})

		return false
	end

	return true
end

return var_0_0
