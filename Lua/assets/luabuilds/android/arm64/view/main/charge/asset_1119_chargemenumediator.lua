local ChargeMenuMediator = class("ChargeMenuMediator", import("...base.ContextMediator"))

ChargeMenuMediator.GO_SKIN_SHOP = "ChargeMenuMediator:GO_SKIN_SHOP"
ChargeMenuMediator.GO_SUPPLY_SHOP = "ChargeMenuMediator:GO_SUPPLY_SHOP"
ChargeMenuMediator.GO_CHARGE_SHOP = "ChargeMenuMediator:GO_CHARGE_SHOP"

function ChargeMenuMediator:register()
	self:bindEvent()

	return
end

function ChargeMenuMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.CHARGE_SUCCESS,
		GAME.SHOPPING_DONE,
		GAME.REMOVE_LAYER_DONE
	}
end

function ChargeMenuMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	if var_3_0 == PlayerProxy.UPDATED then
		self.viewComponent:updatePlayerRes(var_3_1)
	elseif var_3_0 == GAME.CHARGE_SUCCESS or var_3_0 == GAME.SHOPPING_DONE then
		self.viewComponent:FlushBanner()

		if self.viewComponent.lookUpIndex then
			pg.m02:sendNotification(GAME.TRACK, TrackConst.GetTrackData(TrackConst.SYSTEM_SHOP, TrackConst.ACTION_BUY_RECOMMEND, self.viewComponent.lookUpIndex))
		end

		if var_3_0 == GAME.CHARGE_SUCCESS then
			self.viewComponent:OnChargeSuccess((Goods.Create({
				shop_id = var_3_1.shopId
			}, Goods.TYPE_CHARGE)))
		end
	elseif var_3_0 == GAME.REMOVE_LAYER_DONE then
		self.viewComponent:OnRemoveLayer(var_3_1)
	end

	return
end

function ChargeMenuMediator:bindEvent()
	self:bind(ChargeMenuMediator.GO_SKIN_SHOP, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	self:bind(ChargeMenuMediator.GO_SUPPLY_SHOP, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, arg_6_1)

		return
	end)
	self:bind(ChargeMenuMediator.GO_CHARGE_SHOP, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
			warp = arg_7_1
		})

		return
	end)

	return
end

return ChargeMenuMediator
