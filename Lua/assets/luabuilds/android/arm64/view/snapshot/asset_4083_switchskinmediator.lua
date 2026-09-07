local SwitchSkinMediator = class("SwitchSkinMediator", import("..base.ContextMediator"))

SwitchSkinMediator.CHANGE_SKIN = "SwitchSkinMediator:CHANGE_SKIN"
SwitchSkinMediator.BUY_ITEM = "SwitchSkinMediator:BUY_ITEM"
SwitchSkinMediator.UPDATE_SKINCONFIG = "SwitchSkinMediator:UPDATE_SKINCONFIG"
SwitchSkinMediator.BUY_ITEM_BY_ACT = "SwitchSkinMediator:BUY_ITEM_BY_ACT"

function SwitchSkinMediator:register()
	self.shipVO = self.contextData.shipVO

	if self.shipVO then
		self.viewComponent:setShip(self.shipVO)
		self.viewComponent:setSkinList((getProxy(ShipSkinProxy):getSkinList()))
	end

	self:bind(SwitchSkinMediator.BUY_ITEM_BY_ACT, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.SKIN_COUPON_SHOPPING, {
			shopId = arg_2_1,
			cnt = arg_2_2
		})

		return
	end)
	self:bind(SwitchSkinMediator.CHANGE_SKIN, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0, var_3_1 = ShipPhantom.UnpackMark(arg_3_1)

		self:sendNotification(GAME.SET_SHIP_SKIN, {
			shipId = var_3_0,
			phantomId = var_3_1,
			skinId = arg_3_2
		})

		return
	end)
	self:bind(SwitchSkinMediator.BUY_ITEM, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.SKIN_SHOPPIGN, {
			id = arg_4_1,
			count = arg_4_2
		})

		return
	end)
	self:bind(SwitchSkinMediator.UPDATE_SKINCONFIG, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.UPDATE_SKINCONFIG, {
			skinId = arg_5_1
		})

		return
	end)

	return
end

function SwitchSkinMediator:listNotificationInterests()
	return {
		ShipSkinProxy.SHIP_SKINS_UPDATE,
		GAME.SKIN_SHOPPIGN_DONE,
		GAME.SKIN_COUPON_SHOPPING_DONE,
		GAME.CHANGE_SKIN_UPDATE
	}
end

function SwitchSkinMediator:handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getName()

	if var_7_0 == GAME.SKIN_SHOPPIGN_DONE or var_7_0 == GAME.SKIN_COUPON_SHOPPING_DONE then
		local var_7_1 = pg.shop_template[arg_7_1:getBody().id]

		if pg.shop_template[arg_7_1:getBody().id] and var_7_1.genre == ShopArgs.SkinShop then
			self:addSubLayers(Context.New({
				mediator = NewSkinMediator,
				viewComponent = NewSkinLayer,
				data = {
					skinId = var_7_1.effect_args[1]
				}
			}))
		end
	elseif var_7_0 == ShipSkinProxy.SHIP_SKINS_UPDATE then
		self.viewComponent:setSkinList((getProxy(ShipSkinProxy):getSkinList()))
		self.viewComponent:openSelectSkinPanel()
	elseif var_7_0 == GAME.CHANGE_SKIN_UPDATE then
		self.viewComponent:setShip(self.contextData.shipVO)
		self.viewComponent:setSkinList((getProxy(ShipSkinProxy):getSkinList()))
		self.viewComponent:openSelectSkinPanel()
	end

	return
end

return SwitchSkinMediator
