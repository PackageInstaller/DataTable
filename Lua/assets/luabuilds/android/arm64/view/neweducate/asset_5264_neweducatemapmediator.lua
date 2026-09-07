local NewEducateMapMediator = class("NewEducateMapMediator", import("view.newEducate.base.NewEducateContextMediator"))

NewEducateMapMediator.ON_SITE_NORMAL = "NewEducateMapMediator.ON_SITE_NORMAL"
NewEducateMapMediator.ON_SITE_EVENT = "NewEducateMapMediator.ON_SITE_EVENT"
NewEducateMapMediator.ON_SITE_SHIP = "NewEducateMapMediator.ON_SITE_SHIP"
NewEducateMapMediator.ON_SHOPPING = "NewEducateMapMediator.ON_SHOPPING"
NewEducateMapMediator.ON_REFRESH_SHOP = "NewEducateMapMediator.ON_REFRESH_SHOP"
NewEducateMapMediator.ON_UPGRADE_NORMAL = "NewEducateMapMediator.ON_UPGRADE_NORMAL"
NewEducateMapMediator.ON_SHIP_UPGRADE_LEVEL = "NewEducateMapMediator.ON_SHIP_UPGRADE_LEVEL"

function NewEducateMapMediator:register()
	self:bind(NewEducateMapMediator.ON_SITE_NORMAL, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.NEW_EDUCATE_MAP_NORMAL, {
			id = self.contextData.char.id,
			normalId = arg_2_1
		})

		return
	end)
	self:bind(NewEducateMapMediator.ON_SITE_EVENT, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.NEW_EDUCATE_MAP_EVENT, {
			id = self.contextData.char.id,
			eventId = arg_3_1
		})

		return
	end)
	self:bind(NewEducateMapMediator.ON_SITE_SHIP, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.NEW_EDUCATE_MAP_SHIP, {
			id = self.contextData.char.id,
			shipId = arg_4_1
		})

		return
	end)
	self:bind(NewEducateMapMediator.ON_SHOPPING, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.NEW_EDUCATE_SHOPPING, {
			id = self.contextData.char.id,
			goodId = arg_5_1,
			num = arg_5_2 or 1
		})

		return
	end)
	self:bind(NewEducateMapMediator.ON_REFRESH_SHOP, function(arg_6_0)
		self:sendNotification(GAME.NEW_EDUCATE_REFRESH_SHOP, {
			id = self.contextData.char.id
		})

		return
	end)
	self:bind(NewEducateMapMediator.ON_UPGRADE_NORMAL, function(arg_7_0, arg_7_1, arg_7_2)
		self:sendNotification(GAME.NEW_EDUCATE_UPGRADE_NORMAL_SITE, {
			id = self.contextData.char.id,
			normalId = arg_7_1,
			callback = arg_7_2
		})

		return
	end)

	return
end

function NewEducateMapMediator:listNotificationInterests()
	return {
		NewEducateProxy.RESOURCE_UPDATED,
		NewEducateProxy.ATTR_UPDATED,
		NewEducateProxy.PERSONALITY_UPDATED,
		NewEducateProxy.TALENT_UPDATED,
		NewEducateProxy.STATUS_UPDATED,
		NewEducateProxy.TAROT_UPDATED,
		GAME.NEW_EDUCATE_NODE_START,
		GAME.NEW_EDUCATE_NEXT_NODE,
		GAME.NEW_EDUCATE_SHOPPING_DONE,
		GAME.NEW_EDUCATE_REFRESH_SHOP_DONE,
		GAME.NEW_EDUCATE_REFRESH_DONE,
		GAME.NEW_EDUCATE_MAP_NORMAL_DONE,
		GAME.NEW_EDUCATE_MAP_EVENT_DONE,
		GAME.NEW_EDUCATE_MAP_SHIP_DONE,
		GAME.NEW_EDUCATE_CHECK_PRIORITY_FSM,
		NewEducateMapMediator.ON_SHIP_UPGRADE_LEVEL
	}
end

function NewEducateMapMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == NewEducateProxy.RESOURCE_UPDATED then
		self.viewComponent:OnResUpdate()
	elseif var_9_0 == NewEducateProxy.ATTR_UPDATED then
		self.viewComponent:OnAttrUpdate()
	elseif var_9_0 == NewEducateProxy.PERSONALITY_UPDATED then
		self.viewComponent:OnPersonalityUpdate(var_9_1.number, var_9_1.oldTag)
	elseif var_9_0 == NewEducateProxy.TALENT_UPDATED then
		self.viewComponent:OnTalentUpdate()
	elseif var_9_0 == NewEducateProxy.STATUS_UPDATED then
		self.viewComponent:OnStatusUpdate()
	elseif var_9_0 == NewEducateProxy.TAROT_UPDATED then
		self.viewComponent:OnTarotUpdate()
	elseif var_9_0 == GAME.NEW_EDUCATE_NODE_START then
		self.viewComponent:OnNodeStart(var_9_1.node)
	elseif var_9_0 == GAME.NEW_EDUCATE_NEXT_NODE then
		self.viewComponent:OnNextNode(var_9_1)
	elseif var_9_0 == GAME.NEW_EDUCATE_SHOPPING_DONE then
		seriesAsync({
			function(arg_10_0)
				if not var_9_1.isUpgradeEntry then
					self.viewComponent:emit(NewEducateBaseUI.ON_DROP, {
						items = var_9_1.drops,
						removeFunc = arg_10_0
					})
				else
					arg_10_0()
				end

				return
			end
		}, function()
			self.viewComponent:OnShoppingDone()

			return
		end)
	elseif var_9_0 == GAME.NEW_EDUCATE_REFRESH_SHOP_DONE then
		self.viewComponent:OnRefreshShopDone()
	elseif var_9_0 == GAME.NEW_EDUCATE_REFRESH_DONE then
		self.viewComponent:emit(NewEducateBaseUI.GO_SCENE, SCENE.NEW_EDUCATE, {
			id = var_9_1.id
		})
	elseif var_9_0 == GAME.NEW_EDUCATE_MAP_NORMAL_DONE then
		self:StartNodeWithCheckDrops(var_9_1)
	elseif var_9_0 == GAME.NEW_EDUCATE_MAP_EVENT_DONE then
		self:StartNodeWithCheckDrops(var_9_1)
	elseif var_9_0 == GAME.NEW_EDUCATE_MAP_SHIP_DONE then
		self:StartNodeWithCheckDrops(var_9_1)
	elseif var_9_0 == NewEducateMapMediator.ON_SHIP_UPGRADE_LEVEL then
		self.viewComponent:UpdateShipLv()
	elseif var_9_0 == GAME.NEW_EDUCATE_CHECK_PRIORITY_FSM then
		self:CheckPriorityState()
	end

	return
end

function NewEducateMapMediator:StartNodeWithCheckDrops(arg_12_1)
	if #arg_12_1.drops == 0 then
		self.viewComponent:OnNodeStart(arg_12_1.node)
	else
		self.viewComponent:emit(NewEducateBaseUI.ON_DROP, {
			items = arg_12_1.drops,
			removeFunc = function()
				self.viewComponent:OnNodeStart(arg_12_1.node)

				return
			end
		})
	end

	return
end

return NewEducateMapMediator
