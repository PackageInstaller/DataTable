local NewBackYardShopMediator = class("NewBackYardShopMediator", import("...base.ContextMediator"))

NewBackYardShopMediator.ON_SHOPPING = "NewBackYardShopMediator:ON_SHOPPING"
NewBackYardShopMediator.ON_CHARGE = "NewBackYardShopMediator:ON_CHARGE"

function NewBackYardShopMediator:register()
	self:bind(NewBackYardShopMediator.ON_SHOPPING, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.BUY_FURNITURE, {
			furnitureIds = arg_2_1,
			type = arg_2_2
		})

		return
	end)
	self:bind(NewBackYardShopMediator.ON_CHARGE, function(arg_3_0, arg_3_1)
		if self.contextData.onDeattch then
			self.contextData.onDeattch = nil
		end

		local var_3_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(CourtYardMediator)

		if var_3_0 then
			var_3_0.data.skipToCharge = true
		end

		if arg_3_1 == PlayerConst.ResDiamond then
			self:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
				wrap = ChargeScene.TYPE_DIAMOND
			})
		elseif arg_3_1 == PlayerConst.ResDormMoney then
			self:sendNotification(GAME.GO_SCENE, SCENE.EVENT)
		end

		return
	end)
	self.viewComponent:SetDorm(getProxy(DormProxy):getRawData())
	self.viewComponent:SetPlayer(getProxy(PlayerProxy):getRawData())

	return
end

function NewBackYardShopMediator:remove()
	if self.contextData.onRemove then
		self.contextData.onRemove()
	end

	return
end

function NewBackYardShopMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.BUY_FURNITURE_DONE,
		DormProxy.DORM_UPDATEED
	}
end

function NewBackYardShopMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()

	if var_6_0 == PlayerProxy.UPDATED then
		self.viewComponent:PlayerUpdated((arg_6_1:getBody()))
	elseif var_6_0 == GAME.BUY_FURNITURE_DONE then
		self.viewComponent:FurnituresUpdated((arg_6_1:getType()))
	elseif var_6_0 == DormProxy.DORM_UPDATEED then
		self.viewComponent:DormUpdated(getProxy(DormProxy):getRawData())
	end

	return
end

return NewBackYardShopMediator
