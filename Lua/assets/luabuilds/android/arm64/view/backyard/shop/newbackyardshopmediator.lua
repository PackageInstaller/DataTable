local var_0_0 = class("NewBackYardShopMediator", import("...base.ContextMediator"))

var_0_0.ON_SHOPPING = "NewBackYardShopMediator:ON_SHOPPING"
var_0_0.ON_CHARGE = "NewBackYardShopMediator:ON_CHARGE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_SHOPPING, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.BUY_FURNITURE, {
			furnitureIds = arg_2_1,
			type = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_CHARGE, function(arg_3_0, arg_3_1)
		if arg_1_0.contextData.onDeattch then
			arg_1_0.contextData.onDeattch = nil
		end

		local var_3_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(CourtYardMediator)

		if var_3_0 then
			var_3_0.data.skipToCharge = true
		end

		if arg_3_1 == PlayerConst.ResDiamond then
			arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
				wrap = ChargeScene.TYPE_DIAMOND
			})
		elseif arg_3_1 == PlayerConst.ResDormMoney then
			arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.EVENT)
		end

		return
	end)
	arg_1_0.viewComponent:SetDorm(getProxy(DormProxy):getRawData())
	arg_1_0.viewComponent:SetPlayer(getProxy(PlayerProxy):getRawData())

	return
end

function var_0_0.remove(arg_4_0)
	if arg_4_0.contextData.onRemove then
		arg_4_0.contextData.onRemove()
	end

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		PlayerProxy.UPDATED,
		GAME.BUY_FURNITURE_DONE,
		DormProxy.DORM_UPDATEED
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()

	if var_6_0 == PlayerProxy.UPDATED then
		arg_6_0.viewComponent:PlayerUpdated((arg_6_1:getBody()))
	elseif var_6_0 == GAME.BUY_FURNITURE_DONE then
		arg_6_0.viewComponent:FurnituresUpdated((arg_6_1:getType()))
	elseif var_6_0 == DormProxy.DORM_UPDATEED then
		arg_6_0.viewComponent:DormUpdated(getProxy(DormProxy):getRawData())
	end

	return
end

return var_0_0
