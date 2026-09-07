local ProposeMediator = class("ProposeMediator", import("..base.ContextMediator"))

ProposeMediator.ON_PROPOSE = "ProposeMediator.ON_PROPOSE"
ProposeMediator.RENAME_SHIP = "ProposeMediator.RENAME_SHIP"
ProposeMediator.HIDE_SHIP_MAIN_WORD = "ShipMainMediator.HIDE_SHIP_MAIN_WORD"
ProposeMediator.EXCHANGE_TIARA = "ProposeMediator.EXCHANGE_TIARA"
ProposeMediator.REGISTER_SHIP = "ProposeMediator.REGISTER_SHIP"
ProposeMediator.GIFT_SHIP = "ProposeMediaotr.GIFT_SHIP"

function ProposeMediator:register()
	if self.contextData.shipId then
		self.viewComponent:setShip((getProxy(BayProxy):getShipById(self.contextData.shipId)))
	elseif self.contextData.review then
		self.viewComponent:setShipGroupID(self.contextData.group.id)
		self.viewComponent:setWeddingReviewSkinID(self.contextData.skinID)
	end

	self.viewComponent:setBagProxy((getProxy(BagProxy)))
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))
	self:bind(ProposeMediator.ON_PROPOSE, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.PROPOSE_SHIP, {
			shipId = arg_2_1
		})

		return
	end)
	self:bind(ProposeMediator.RENAME_SHIP, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.RENAME_SHIP, {
			shipId = arg_3_1,
			name = arg_3_2
		})

		return
	end)
	self:bind(ProposeMediator.HIDE_SHIP_MAIN_WORD, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.HIDE_Ship_MAIN_SCENE_WORD)

		return
	end)
	self:bind(ProposeMediator.EXCHANGE_TIARA, function(arg_5_0)
		self:sendNotification(GAME.PROPOSE_EXCHANGE_RING)

		return
	end)
	self:bind(ProposeMediator.REGISTER_SHIP, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.PROPOSE_REGISTER_SHIP, {
			shipId = arg_6_1
		})

		return
	end)
	self:bind(ProposeMediator.GIFT_SHIP, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIP_GIFT, {
			shipID = arg_7_1
		})

		return
	end)

	return
end

function ProposeMediator:listNotificationInterests()
	return {
		GAME.PROPOSE_SHIP_DONE,
		GAME.RENAME_SHIP_DONE,
		GAME.PROPOSE_EXCHANGE_RING_DONE,
		GAME.PROPOSE_REGISTER_SHIP_DONE
	}
end

function ProposeMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == GAME.PROPOSE_SHIP_DONE then
		local var_9_2 = var_9_1.ship:getProposeSkin()

		if var_9_2 then
			self:sendNotification(GAME.SET_SHIP_SKIN, {
				phantomId = 0,
				hideTip = true,
				shipId = var_9_1.ship.id,
				skinId = var_9_2.id
			})
		end

		self.viewComponent:setShip(var_9_1.ship)
		self.viewComponent:RingFadeout()
	elseif var_9_0 == GAME.RENAME_SHIP_DONE then
		self.viewComponent:closeView()
	elseif var_9_0 == GAME.PROPOSE_EXCHANGE_RING_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1.items, function()
			self.viewComponent:onUpdateItemCount()

			return
		end)
	elseif var_9_0 == GAME.PROPOSE_REGISTER_SHIP_DONE and self.viewComponent.afterRegisterCall then
		self.viewComponent.afterRegisterCall()
	end

	return
end

return ProposeMediator
