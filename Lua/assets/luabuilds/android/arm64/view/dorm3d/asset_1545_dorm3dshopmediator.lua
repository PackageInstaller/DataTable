local Dorm3dShopMediator = class("Dorm3dShopMediator", import("view.base.ContextMediator"))

Dorm3dShopMediator.OPEN_DETAIL = "Dorm3dShopMediator.OPEN_DETAIL"
Dorm3dShopMediator.SHOW_SHOPPING_CONFIRM_WINDOW = "Dorm3dShopMediator.SHOW_SHOPPING_CONFIRM_WINDOW"
Dorm3dShopMediator.OPEN_ROOM_UNLOCK_WINDOW = "Dorm3dShopMediator.OPEN_ROOM_UNLOCK_WINDOW"
Dorm3dShopMediator.OPEN_DROP_LAYER = "Dorm3dShopMediator.OPEN_DROP_LAYER"

function Dorm3dShopMediator:register()
	self:bind(Dorm3dShopMediator.OPEN_DETAIL, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:addSubLayers(Context.New({
			viewComponent = Dorm3dShopDetailWindow,
			mediator = Dorm3dShopDetailMediator,
			data = {
				shopCfg = arg_2_1,
				groupId = arg_2_2,
				changeCount = arg_2_3
			}
		}))

		return
	end)
	self:bind(Dorm3dShopMediator.SHOW_SHOPPING_CONFIRM_WINDOW, function(arg_3_0, arg_3_1)
		self:addSubLayers(Context.New({
			viewComponent = Dorm3dShoppingConfirmWindow,
			mediator = Dorm3dShoppingConfirmWindowMediator,
			data = arg_3_1
		}))

		return
	end)
	self:bind(Dorm3dShopMediator.OPEN_ROOM_UNLOCK_WINDOW, function(arg_4_0, arg_4_1, arg_4_2)
		self:addSubLayers(Context.New({
			viewComponent = Dorm3dRoomUnlockWindow,
			mediator = Dorm3dRoomUnlockWindowMediator,
			data = {
				roomId = arg_4_1,
				groupId = arg_4_2
			}
		}))

		return
	end)
	self:bind(GAME.SHOPPING, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.SHOPPING, {
			id = arg_5_1.shopId,
			count = arg_5_1.count,
			silentTip = arg_5_1.silentTip
		})

		return
	end)
	self:bind(Dorm3dShopMediator.OPEN_DROP_LAYER, function(arg_6_0, arg_6_1, arg_6_2)
		self:addSubLayers(Context.New({
			viewComponent = Dorm3dAwardInfoLayer,
			mediator = Dorm3dAwardInfoMediator,
			data = {
				items = arg_6_1
			},
			onRemoved = arg_6_2
		}))

		return
	end)

	return
end

function Dorm3dShopMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		GAME.SHOPPING_DONE,
		GAME.APARTMENT_ROOM_INVITE_UNLOCK_DONE
	}
end

function Dorm3dShopMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == PlayerProxy.UPDATED then
		self.viewComponent:ShowResUI()
	elseif var_8_0 == GAME.SHOPPING_DONE then
		local var_8_2 = arg_8_1:getBody().awards

		for iter_8_0, iter_8_1 in ipairs(var_8_2) do
			iter_8_1.count = self.viewComponent.showCount
		end

		if var_8_2 and #var_8_2 > 0 then
			self.viewComponent:emit(Dorm3dShopMediator.OPEN_DROP_LAYER, var_8_2, function()
				return
			end)
		end

		self.viewComponent:SetPageBtns()
		self.viewComponent:RefreshPage()
	elseif var_8_0 == GAME.APARTMENT_ROOM_INVITE_UNLOCK_DONE then
		self.viewComponent:SetPageBtns()
		self.viewComponent:RefreshPage()
	end

	return
end

return Dorm3dShopMediator
