local ZumaPTShopMediator = class("ZumaPTShopMediator", import("...base.ContextMediator"))

ZumaPTShopMediator.OPEN_ZUMA_PT_SHOP_BUY_WINDOW = "ZumaPTShopMediator.OPEN_ZUMA_PT_SHOP_BUY_WINDOW"

function ZumaPTShopMediator:register()
	self:bind(ZumaPTShopMediator.OPEN_ZUMA_PT_SHOP_BUY_WINDOW, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			mediator = ZumaPTShopWindowMediator,
			viewComponent = ZumaPTShopWindowLayer,
			data = {
				actShopVO = self.viewComponent.actShopVO,
				goodVO = arg_2_1
			}
		}))

		return
	end)

	return
end

function ZumaPTShopMediator:listNotificationInterests()
	return {
		GAME.ISLAND_SHOPPING_DONE,
		GAME.USE_ITEM_DONE,
		PlayerProxy.UPDATED
	}
end

function ZumaPTShopMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == GAME.ISLAND_SHOPPING_DONE then
		local var_4_2 = arg_4_1:getBody()
		local var_4_3 = {}

		if #var_4_2.awards > 0 then
			table.insert(var_4_3, function(arg_5_0)
				self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_2.awards, arg_5_0)

				return
			end)
		end

		seriesAsync(var_4_3, function()
			self.viewComponent:updateTplByGoodID(var_4_2.goodsId)

			return
		end)
	elseif var_4_0 == GAME.USE_ITEM_DONE then
		local var_4_4 = arg_4_1:getBody().drops

		if #var_4_4 > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_4)
		end
	elseif var_4_0 == PlayerProxy.UPDATED then
		self.viewComponent:updatePTPanel()
	end

	return
end

return ZumaPTShopMediator
