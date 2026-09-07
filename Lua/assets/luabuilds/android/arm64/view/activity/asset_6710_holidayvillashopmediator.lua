local HolidayVillaShopMediator = class("HolidayVillaShopMediator", import("..base.ContextMediator"))

HolidayVillaShopMediator.OPEN_GOODS_WINDOW = "HolidayVillaShopMediator.OPEN_GOODS_WINDOW"

function HolidayVillaShopMediator:register()
	self.viewComponent:setShop(self.contextData.shop)
	self.viewComponent:setPlayer(getProxy(PlayerProxy):getData())
	self:bind(HolidayVillaShopMediator.OPEN_GOODS_WINDOW, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			mediator = HolidayVillaShopWindowMediator,
			viewComponent = HolidayVillaShopWindowLayer,
			data = {
				activityId = self.contextData.shop.activityId,
				shop = self.contextData.shop,
				goods = arg_2_1
			}
		}))

		return
	end)

	return
end

function HolidayVillaShopMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.ISLAND_SHOPPING_DONE] = function(arg_4_0, arg_4_1)
			local var_4_0 = arg_4_1:getBody()
			local var_4_1 = {}

			if #var_4_0.awards > 0 then
				table.insert(var_4_1, function(arg_5_0)
					arg_4_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_0.awards, arg_5_0)

					return
				end)
			end

			seriesAsync(var_4_1, function()
				arg_4_0.viewComponent:refreshGoodsCard(var_4_0.goodsId)

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

return HolidayVillaShopMediator
