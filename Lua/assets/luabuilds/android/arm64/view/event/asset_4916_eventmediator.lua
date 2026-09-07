EventConst = require("view/event/EventConst")

local EventMediator = class("EventMediator", import("..base.ContextMediator"))

function EventMediator:register()
	self:bind(EventConst.EVENT_LIST_UPDATE, function(arg_2_0)
		self:updateEventList(true)

		return
	end)
	self:bind(EventConst.EVENT_OPEN_DOCK, function(arg_3_0, arg_3_1)
		if not self.contextData.selectedEventId then
			return
		end

		local var_3_0 = {}

		for iter_3_0, iter_3_1 in pairs((getProxy(BayProxy):getRawData())) do
			if not table.contains(arg_3_1.template.ship_type, iter_3_1:getShipType()) or iter_3_1:isActivityNpc() then
				table.insert(var_3_0, iter_3_0)
			end
		end

		local var_3_1, var_3_2, var_3_3 = self:getDockCallbackFuncs(arg_3_1)
		local var_3_4 = GAME.GO_SCENE
		local var_3_5 = SCENE.DOCKYARD
		local var_3_6 = {
			selectedMin = 1,
			useBlackBlock = true,
			selectedMax = 6,
			ignoredIds = var_3_0
		}

		if arg_3_1 then
			var_3_6.selectedIds = arg_3_1.shipIds or {}
		end

		var_3_6.onShip = var_3_1
		var_3_6.confirmSelect = var_3_2
		var_3_6.onSelected = var_3_3
		var_3_6.leftTopInfo = i18n("word_operation")
		var_3_6.hideTagFlags = ShipStatus.TAG_HIDE_EVENT
		var_3_6.blockTagFlags = ShipStatus.TAG_BLOCK_EVENT

		self:sendNotification(var_3_4, var_3_5, var_3_6)

		return
	end)
	self:bind(EventConst.EVENT_FLUSH_ALL, function(arg_4_0)
		self:sendNotification(GAME.EVENT_FLUSH_ALL)

		return
	end)
	self:bind(EventConst.EVENT_START, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.EVENT_START, {
			event = arg_5_1
		})

		return
	end)
	self:bind(EventConst.EVENT_GIVEUP, function(arg_6_0, arg_6_1)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("event_confirm_giveup"),
			onYes = function()
				self:sendNotification(GAME.EVENT_GIVEUP, {
					id = arg_6_1.id
				})

				return
			end
		})

		return
	end)
	self:bind(EventConst.EVENT_FINISH, function(arg_8_0, arg_8_1)
		self:sendNotification(GAME.EVENT_FINISH, {
			id = arg_8_1.id
		})

		return
	end)
	self:updateEventList(false, self.contextData.eventList)

	return
end

function EventMediator:listNotificationInterests()
	return {
		GAME.EVENT_LIST_UPDATE,
		GAME.EVENT_FINISH_UPDATE,
		GAME.EVENT_SHOW_AWARDS
	}
end

function EventMediator:handleNotification(arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()

	if var_10_0 == GAME.EVENT_LIST_UPDATE then
		self:updateEventList(true)
	elseif var_10_0 == GAME.EVENT_FINISH_UPDATE then
		self:updateEventList(true)
	elseif var_10_0 == GAME.EVENT_SHOW_AWARDS then
		local var_10_2

		var_10_2 = coroutine.wrap(function()
			if #var_10_1.oldShips > 0 then
				self.viewComponent:emit(BaseUI.ON_SHIP_EXP, {
					title = pg.collection_template[var_10_1.eventId].title,
					oldShips = var_10_1.oldShips,
					newShips = var_10_1.newShips,
					isCri = var_10_1.isCri
				}, var_10_2)
				coroutine.yield()
			end

			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_10_1.awards)

			return
		end)

		;(nil)()
	end

	return
end

function EventMediator:updateEventList(arg_12_1, arg_12_2)
	local var_12_0 = getProxy(BayProxy)
	local var_12_1 = getProxy(EventProxy)

	var_12_1.virgin = false
	self.contextData.eventList = arg_12_2 or var_12_1:getEventList()

	self.viewComponent:setEventList(self.contextData.eventList)

	if arg_12_1 then
		self.viewComponent:updateAll(arg_12_1)
	end

	if getProxy(SettingsProxy):ShouldShowEventActHelp() and _.any(self.contextData.eventList, function(arg_13_0)
		return arg_13_0:IsActivityType()
	end) then
		getProxy(SettingsProxy):MarkEventActHelpFlag()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.help_act_event.tip
		})
	end

	return
end

function EventMediator:getDockCallbackFuncs(arg_14_1)
	return function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0, var_15_1 = ShipStatus.ShipStatusCheck("inEvent", arg_15_0, arg_15_1)

		if not var_15_0 then
			return var_15_0, var_15_1
		end

		local var_15_2 = getProxy(BayProxy)

		for iter_15_0, iter_15_1 in ipairs(arg_15_2) do
			if arg_15_0:isSameKind((var_15_2:getShipById(iter_15_1))) then
				local var_15_4 = i18n("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end, function(arg_16_0, arg_16_1, arg_16_2)
		arg_16_1()

		return
	end, function(arg_17_0)
		arg_14_1:setShipIds(arg_17_0)

		return
	end
end

return EventMediator
