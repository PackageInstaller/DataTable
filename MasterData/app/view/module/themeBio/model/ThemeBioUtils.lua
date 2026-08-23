local var_0_0 = g.core.model.User.resourceData
local var_0_1 = g.core.model.User.themeData

return {
	checkMission = function(self, arg_1_1, arg_1_2)
		arg_1_1 = arg_1_1 or 1

		if self.type ~= 1 then
			return true
		end

		local var_1_0 = var_0_1:getThemeData(arg_1_2)

		if not var_1_0 then
			return true
		end

		if var_1_0:getThemeBioData():getChain(self.chain).type ~= 1 then
			return true
		end

		if var_0_0:getVit() < self.cost * arg_1_1 then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
				type = g.core.common.Goods.TYPE_ITEM,
				value = g.core.common.Goods.ITEM.TYPE_STAMINA_PILL,
				shopId = g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.STAMINA_PILL
			}), {
				touchDisappear = true
			})

			return false
		end

		return true
	end
}
