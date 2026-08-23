local var_0_0 = g.core.model.User.bioData
local var_0_1 = g.core.model.User.resourceData

return {
	compareMissionTalk = function(self, arg_1_1)
		if self.unlock ~= arg_1_1.unlock then
			return not self.unlock
		end

		if self.finish ~= arg_1_1.finish then
			return not self.finish
		end

		local var_1_0 = var_0_0:getChain(self.chain)
		local var_1_1 = var_0_0:getChain(arg_1_1.chain)

		if var_1_0.type ~= var_1_1.type then
			return var_1_0.type < var_1_1.type
		end

		return false
	end,
	checkMission = function(self, arg_2_1)
		arg_2_1 = arg_2_1 or 1

		if self.type ~= 1 then
			return true
		end

		if var_0_0:getChain(self.chain).type ~= 1 then
			return true
		end

		if arg_2_1 > var_0_1:getBioGraphie() then
			require("app.view.base.infoPop.BasePlayNumPop").createBuy(g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.BIOGRAPHIE)

			return false
		end

		if var_0_1:getVit() < self.cost * arg_2_1 then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
				type = g.core.common.Goods.TYPE_ITEM,
				value = g.core.common.Goods.ITEM.TYPE_STAMINA_PILL,
				shopId = g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.STAMINA_PILL
			}), {
				touchDisappear = true
			})

			return false
		end

		if self.attack_count >= self.attempts then
			if not require("app.view.base.component.BaseBuyPop").createExtraReset({
				pid = 4,
				vid = 4,
				count = self.reset_count,
				callback = function()
					g.core.network.GameNetProxy:send_C2S_Biography_ResetMissionCount({
						id = self.id
					})
				end
			}) then
				g.core.module.ModuleManager:tip(g.core.lang:get(302019))
			end

			return false
		end

		return true
	end,
	checkBioLeftCountIsEnough = function(arg_4_0)
		if (arg_4_0 and arg_4_0 or 1) > g.core.model.User.resourceData:getBioGraphie() then
			g.core.module.ModuleManager:tip(g.core.lang:get(302097))

			return false
		end

		return true
	end
}
