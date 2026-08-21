local var_0_0 = class("HolidayVillaShopMediator", import("..base.ContextMediator"))

var_0_0.OPEN_GOODS_WINDOW = "HolidayVillaShopMediator.OPEN_GOODS_WINDOW"

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:setShop(arg_1_0.contextData.shop)
	arg_1_0.viewComponent:setPlayer(getProxy(PlayerProxy):getData())
	arg_1_0:bind(var_0_0.OPEN_GOODS_WINDOW, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = HolidayVillaShopWindowMediator,
			viewComponent = HolidayVillaShopWindowLayer,
			data = {
				activityId = arg_1_0.contextData.shop.activityId,
				shop = arg_1_0.contextData.shop,
				goods = arg_2_1
			}
		}))

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_3_0)
	arg_3_0.handleDic = {
		[GAME.ISLAND_SHOPPING_DONE] = function(arg_4_0, arg_4_1)
			if #arg_4_1:getBody().awards > 0 then
				table.insert({}, function(arg_5_0)
					arg_4_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_0.awards, arg_5_0)

					return
				end)
			end

			seriesAsync({}, function()
				arg_4_0.viewComponent:refreshGoodsCard(var_0.goodsId)

				return
			end)
			arg_4_0.viewComponent:refreshAllGoodsCard()
			arg_4_0.viewComponent:setPlayer(getProxy(PlayerProxy):getData())

			return
		end,
		[GAME.USE_ITEM_DONE] = function(arg_7_0, arg_7_1)
			local var_7_0 = arg_7_1:getBody().drops

			if #var_7_0 > 0 then
				arg_7_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_7_0)
			end

			return
		end,
		[PlayerProxy.UPDATED] = function(arg_8_0, arg_8_1)
			arg_8_0.viewComponent:setPlayer((arg_8_1:getBody()))

			return
		end
	}

	return
end

return var_0_0
