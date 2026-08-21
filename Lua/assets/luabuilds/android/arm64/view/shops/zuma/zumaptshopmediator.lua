local var_0_0 = class("ZumaPTShopMediator", import("...base.ContextMediator"))

var_0_0.OPEN_ZUMA_PT_SHOP_BUY_WINDOW = "ZumaPTShopMediator.OPEN_ZUMA_PT_SHOP_BUY_WINDOW"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.OPEN_ZUMA_PT_SHOP_BUY_WINDOW, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ZumaPTShopWindowMediator,
			viewComponent = ZumaPTShopWindowLayer,
			data = {
				actShopVO = arg_1_0.viewComponent.actShopVO,
				goodVO = arg_2_1
			}
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.ISLAND_SHOPPING_DONE,
		GAME.USE_ITEM_DONE,
		PlayerProxy.UPDATED
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == GAME.ISLAND_SHOPPING_DONE then
		if #arg_4_1:getBody().awards > 0 then
			table.insert({}, function(arg_5_0)
				arg_4_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_0.awards, arg_5_0)

				return
			end)
		end

		seriesAsync({}, function()
			arg_4_0.viewComponent:updateTplByGoodID(var_0.goodsId)

			return
		end)
	elseif var_4_0 == GAME.USE_ITEM_DONE then
		local var_4_2 = arg_4_1:getBody().drops

		if #var_4_2 > 0 then
			arg_4_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_2)
		end
	elseif var_4_0 == PlayerProxy.UPDATED then
		arg_4_0.viewComponent:updatePTPanel()
	end

	return
end

return var_0_0
