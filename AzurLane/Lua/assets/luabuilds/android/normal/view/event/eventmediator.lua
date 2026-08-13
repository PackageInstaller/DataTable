require = var_0_10000

local var_0_0 = var_0_10000("view/event/EventConst")

class = EventConst

local var_0_1 = "EventMediator"

import = var_0_10002

local var_0_2 = var_0(var_0_1, var_0_10002("..base.ContextMediator"))

function var_0_2.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	EventConst = var_1_10003

	var_1_1(var_1_0, var_1_10003.EVENT_LIST_UPDATE, function(arg_2_0)
		local var_2_0 = arg_1_0

		var_1.updateEventList(var_2_0, true)

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	EventConst = var_3

	var_1_3(var_1_2, var_3.EVENT_OPEN_DOCK, function(arg_3_0, arg_3_1)
		if not arg_1_0.contextData.selectedEventId then
			return
		end

		getProxy = var_2
		BayProxy = var_2_10003

		local var_3_0 = var_2(var_2_10003)
		local var_3_1 = var_2.getRawData(var_3_0)
		local var_3_2 = {}

		pairs = var_2_10005

		for iter_3_0, iter_3_1 in var_2_10005(var_3_1) do
			table = var_2_10010

			if var_2_10010.contains(arg_3_1.template.ship_type, iter_3_1:getShipType()) then
				var_2_10011 = iter_3_1

				if iter_3_1.isActivityNpc(var_2_10011) then
					table = var_2_10010

					var_2_10010.insert(var_3_2, iter_3_0)
				end
			end
		end

		local var_3_3 = arg_1_0
		local var_3_4, var_3_5, var_3_6 = var_5.getDockCallbackFuncs(var_3_3, arg_3_1)
		local var_3_7 = arg_1_0
		local var_3_8 = var_8.sendNotification

		GAME = var_2_10010

		local var_3_9 = var_2_10010.GO_SCENE

		SCENE = var_2_10011

		local var_3_10 = var_2_10011.DOCKYARD
		local var_3_11 = {
			selectedMin = 1,
			useBlackBlock = true,
			selectedMax = 6,
			ignoredIds = var_3_2
		}
		local var_3_12

		if not arg_3_1 or not arg_3_1.shipIds then
			var_3_12 = {}
		end

		var_3_11.selectedIds = var_3_12
		var_3_11.onShip = var_3_4
		var_3_11.confirmSelect = var_3_5
		var_3_11.onSelected = var_3_6
		i18n = var_3_12
		var_3_11.leftTopInfo = var_3_12("word_operation")
		ShipStatus = var_13
		var_3_11.hideTagFlags = var_13.TAG_HIDE_EVENT
		ShipStatus = var_13
		var_3_11.blockTagFlags = var_13.TAG_BLOCK_EVENT

		var_3_8(var_3_7, var_3_9, var_3_10, var_3_11)

		return
	end)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.bind

	EventConst = var_3

	var_1_5(var_1_4, var_3.EVENT_FLUSH_ALL, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10003

		var_4_1(var_4_0, var_2_10003.EVENT_FLUSH_ALL)

		return
	end)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.bind

	EventConst = var_3

	var_1_7(var_1_6, var_3.EVENT_START, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.EVENT_START, {
			event = arg_5_1
		})

		return
	end)

	local var_1_8 = arg_1_0
	local var_1_9 = arg_1_0.bind

	EventConst = var_3

	var_1_9(var_1_8, var_3.EVENT_GIVEUP, function(arg_6_0, arg_6_1)
		pg = var_2_10002

		local var_6_0 = var_2_10002.MsgboxMgr.GetInstance()
		local var_6_1 = var_2.ShowMsgBox
		local var_6_2 = {}

		i18n = var_2_10005
		var_6_2.content = var_2_10005("event_confirm_giveup")

		function var_6_2.onYes()
			local var_7_0 = arg_1_0
			local var_7_1 = var_0.sendNotification

			GAME = var_3_10002

			var_7_1(var_7_0, var_3_10002.EVENT_GIVEUP, {
				id = arg_6_1.id
			})

			return
		end

		var_6_1(var_6_0, var_6_2)

		return
	end)

	local var_1_10 = arg_1_0
	local var_1_11 = arg_1_0.bind

	EventConst = var_3

	var_1_11(var_1_10, var_3.EVENT_FINISH, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10004

		var_8_1(var_8_0, var_2_10004.EVENT_FINISH, {
			id = arg_8_1.id
		})

		return
	end)
	arg_1_0:updateEventList(false, arg_1_0.contextData.eventList)

	return
end

function var_0_2.listNotificationInterests(arg_9_0)
	local var_9_0 = {}

	GAME = var_1_10002
	var_9_0[1] = var_1_10002.EVENT_LIST_UPDATE
	GAME = var_2
	var_9_0[2] = var_2.EVENT_FINISH_UPDATE
	GAME = var_2
	var_9_0[3] = var_2.EVENT_SHOW_AWARDS

	return var_9_0
end

function var_0_2.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1
	local var_10_2 = arg_10_1.getBody(var_10_1)

	GAME = var_10_1

	if var_10_0 == var_10_1.EVENT_LIST_UPDATE then
		var_1_10005 = arg_10_0

		arg_10_0.updateEventList(var_1_10005, true)
	else
		GAME = var_4

		if var_10_0 == var_4.EVENT_FINISH_UPDATE then
			var_1_10005 = arg_10_0

			arg_10_0.updateEventList(var_1_10005, true)
		else
			GAME = var_4

			if var_10_0 == var_4.EVENT_SHOW_AWARDS then
				local var_10_3

				coroutine = var_1_10005

				var_1_10005.wrap(function()
					if #var_10_2.oldShips > 0 then
						local var_11_0 = arg_10_0.viewComponent
						local var_11_1 = var_0.emit

						BaseUI = var_2_10002
						var_2_10002 = var_2_10002.ON_SHIP_EXP

						local var_11_2 = {}

						pg = var_2_10004
						var_11_2.title = var_2_10004.collection_template[var_10_2.eventId].title
						var_11_2.oldShips = var_10_2.oldShips
						var_11_2.newShips = var_10_2.newShips
						var_11_2.isCri = var_10_2.isCri

						var_11_1(var_11_0, var_2_10002, var_11_2, var_10_3)

						coroutine = var_11_1

						var_11_1.yield()
					end

					local var_11_3 = arg_10_0.viewComponent
					local var_11_4 = var_0.emit

					BaseUI = var_2_10002

					var_11_4(var_11_3, var_2_10002.ON_ACHIEVE, var_10_2.awards)

					return
				end)()
			end
		end
	end

	return
end

function var_0_2.updateEventList(arg_12_0, arg_12_1, arg_12_2)
	getProxy = var_1_10003
	BayProxy = var_1_10004

	local var_12_0 = var_1_10003(var_1_10004)

	getProxy = var_1_10004
	EventProxy = var_1_10005

	local var_12_1 = var_1_10004(var_1_10005)

	var_12_1.virgin = false
	arg_12_0.contextData.eventList = arg_12_2 or var_12_1:getEventList()

	local var_12_2 = arg_12_0.viewComponent

	var_5.setEventList(var_12_2, arg_12_0.contextData.eventList)

	if arg_12_1 then
		var_12_2 = arg_12_0.viewComponent

		var_5.updateAll(var_12_2, arg_12_1)
	end

	getProxy = var_5
	SettingsProxy = var_12_2

	local var_12_3 = var_5(var_12_2)

	if var_5.ShouldShowEventActHelp(var_12_3) then
		_ = var_5

		if var_5.any(arg_12_0.contextData.eventList, function(arg_13_0)
			return arg_13_0:IsActivityType()
		end) then
			getProxy = var_5
			SettingsProxy = var_6

			local var_12_4 = var_5(var_6)

			var_5.MarkEventActHelpFlag(var_12_4)

			pg = var_5

			local var_12_5 = var_5.MsgboxMgr.GetInstance()
			local var_12_6 = var_5.ShowMsgBox
			local var_12_7 = {}

			MSGBOX_TYPE_HELP = var_1_10008
			var_12_7.type = var_1_10008
			pg = var_1_10008
			var_12_7.helps = var_1_10008.gametip.help_act_event.tip

			var_12_6(var_12_5, var_12_7)
		end
	end

	return
end

function var_0_2.getDockCallbackFuncs(arg_14_0, arg_14_1)
	local function var_14_0(arg_15_0, arg_15_1, arg_15_2)
		ShipStatus = var_2_10003

		local var_15_0, var_15_1 = var_2_10003.ShipStatusCheck("inEvent", arg_15_0, arg_15_1)

		if not var_15_0 then
			return var_15_0, var_15_1
		end

		getProxy = var_5
		BayProxy = var_6

		local var_15_2 = var_5(var_6)

		ipairs = var_6

		for iter_15_0, iter_15_1 in var_6(arg_15_2) do
			local var_15_3 = var_15_2:getShipById(iter_15_1)
			local var_15_4 = arg_15_0

			if arg_15_0.isSameKind(var_15_4, var_15_3) then
				local var_15_5 = false

				i18n = var_15_4

				local var_15_6 = var_15_4("ship_formationMediator_changeNameError_sameShip")

				return
			end
		end

		return true
	end

	local function var_14_1(arg_16_0, arg_16_1, arg_16_2)
		arg_16_1()

		return
	end

	local function var_14_2(arg_17_0)
		local var_17_0 = arg_14_1

		var_1.setShipIds(var_17_0, arg_17_0)

		return
	end

	return var_14_0, var_14_1, var_14_2
end

return var_0_2
