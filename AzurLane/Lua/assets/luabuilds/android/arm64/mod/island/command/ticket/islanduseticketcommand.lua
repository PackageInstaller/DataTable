class = var_0_10000

local var_0_0 = "IslandUseTicketCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

var_0_1.TYPES = {
	SHIP_ORDER = 2,
	MANAGE = 3,
	SHIP_ORDER_RELOAD = 5,
	ORDER_CD = 1,
	APPOINT = 4
}

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = var_2.id
	local var_1_2 = var_2.tickets

	underscore = var_1_10006

	local var_1_3 = #var_1_10006.select(var_1_2, function(arg_2_0)
		return arg_2_0:IsExpired()
	end)

	if 0 < var_1_3 then
		local function var_1_4()
			local var_3_0 = arg_1_0
			local var_3_1 = var_0.sendNotification

			GAME = var_2_10003

			var_3_1(var_3_0, var_2_10003.ISLAND_REMOVE_EXPIRED_TICKET, {
				tickets = var_0
			})

			return
		end

		pg = var_8

		local var_1_5 = var_8.NewStyleMsgboxMgr.GetInstance()
		local var_1_6 = var_8.Show

		pg = var_1_10011

		local var_1_7 = var_1_10011.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX
		local var_1_8 = {}

		i18n = var_1_10013
		var_1_8.contentText = var_1_10013("island_ticket_expiration_tip2")
		var_1_8.onClose = var_1_4

		local var_1_9 = {}

		var_1_10014 = {}
		pg = var_15
		var_1_10014.type = var_15.NewStyleMsgboxMgr.BUTTON_TYPE.confirm
		i18n = var_15
		var_1_10014.name = var_15("msgbox_text_confirm")
		var_1_10014.func = var_1_4
		SFX_CONFIRM = var_15
		var_1_10014.sound = var_15
		var_1_9[1] = var_1_10014
		var_1_8.btnList = var_1_9

		var_1_6(var_1_5, var_1_7, var_1_8)

		return
	end

	local var_1_10 = {}
	local var_1_11 = 0

	ipairs = var_9

	for iter_1_0, iter_1_1 in var_9(var_1_2) do
		table = var_1_10014

		var_1_10014.insert(var_1_10, {
			key = {
				speed_id = iter_1_1.id,
				end_time = iter_1_1.endTime
			},
			num = iter_1_1:GetCount()
		})

		var_1_11 = var_1_11 + iter_1_1:GetTime() * iter_1_1:GetCount()
	end

	if var_1_0 == var_0_1.TYPES.ORDER_CD or var_1_0 == var_0_1.TYPES.SHIP_ORDER or var_1_0 == var_0_1.TYPES.SHIP_ORDER_RELOAD or var_1_0 == var_0_1.TYPES.MANAGE then
		arg_1_0:Send(var_1_0, var_1_1, var_1_10, var_1_11)
	elseif var_1_0 == var_0_1.TYPES.APPOINT then
		arg_1_0:SendForAppoint(var_1_1, var_1_10, var_1_11)
	else
		assert = var_9

		var_9(false, "undefined type: " .. var_1_0)
	end

	return
end

function var_0_1.Send(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	pg = var_1_10005

	local var_4_0 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_4_0, 21423, {
		type = arg_4_1,
		target_id = arg_4_2,
		tickets = arg_4_3
	}, 21424, function(arg_5_0)
		local var_5_2

		if arg_5_0.result == 0 then
			switch = var_5_2

			var_5_2(arg_4_1, {
				[var_0_1.TYPES.ORDER_CD] = function()
					getProxy = var_3_10000
					IslandProxy = var_3_10002

					local var_6_0 = var_3_10000(var_3_10002)
					local var_6_1 = var_0.GetIsland(var_6_0)
					local var_6_2 = var_0.GetOrderAgency(var_6_1)
					local var_6_3 = var_0.GetSlot(var_6_2, arg_4_2)

					var_0.AddReduceTime(var_6_3, arg_4_4)

					return
				end,
				[var_0_1.TYPES.SHIP_ORDER] = function()
					getProxy = var_3_10000
					IslandProxy = var_3_10002

					local var_7_0 = var_3_10000(var_3_10002)
					local var_7_1 = var_0.GetIsland(var_7_0)
					local var_7_2 = var_0.GetOrderAgency(var_7_1)
					local var_7_3 = var_0.GetShipOrderSlot(var_7_2, arg_4_2)

					var_0.AddReduceTime(var_7_3, arg_4_4)

					return
				end,
				[var_0_1.TYPES.MANAGE] = function()
					getProxy = var_3_10000
					IslandProxy = var_3_10002

					local var_8_0 = var_3_10000(var_3_10002)
					local var_8_1 = var_0.GetIsland(var_8_0)
					local var_8_2 = var_0.GetManageAgency(var_8_1)
					local var_8_3 = var_0.GetRestaurant(var_8_2, arg_4_2)

					var_0.UpdateEndTime(var_8_3, arg_4_4)

					return
				end,
				[var_0_1.TYPES.SHIP_ORDER_RELOAD] = function()
					getProxy = var_3_10000
					IslandProxy = var_3_10002

					local var_9_0 = var_3_10000(var_3_10002)
					local var_9_1 = var_0.GetIsland(var_9_0)
					local var_9_2 = var_0.GetOrderAgency(var_9_1)

					var_0.ReduceNextManualReloadDelegateTime(var_9_2, arg_4_4)

					return
				end
			})

			getProxy = var_5_2
			IslandProxy = var_3

			local var_5_0 = var_5_2(var_3)
			local var_5_1 = var_5_2.GetIsland(var_5_0)

			var_5_2 = var_5_2.GetTicketAgency(var_5_1)
			ipairs = var_2_10002

			for iter_5_0, iter_5_1 in var_2_10002(arg_4_3) do
				var_5_2:ReduceTicket(iter_5_1.key.speed_id, iter_5_1.key.end_time, iter_5_1.num)
			end

			pg = var_2
			var_2_10004 = var_2.TipsMgr.GetInstance()

			local var_5_3 = var_2.ShowTips

			i18n = iter_5_0

			var_5_3(var_2_10004, iter_5_0("island_use_ticket_success"))

			var_2_10004 = arg_4_0

			local var_5_4 = var_2.sendNotification

			GAME = var_5

			var_5_4(var_2_10004, var_5.ISLAND_USE_TICKET_DONE, {
				type = arg_4_1,
				id = arg_4_2
			})
		else
			pg = var_5_2

			local var_5_5 = var_5_2.TipsMgr.GetInstance()
			local var_5_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_5_6(var_5_5, var_2_10004[arg_5_0.result] .. arg_5_0.result)
		end

		return
	end)

	return
end

function var_0_1.SendForAppoint(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	pg = var_1_10004

	local var_10_0 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_10_0, 21427, {
		area_id = arg_10_1,
		tickets = arg_10_2
	}, 21428, function(arg_11_0)
		local var_11_1

		if arg_11_0.result == 0 then
			getProxy = var_11_1
			IslandProxy = var_2_10003

			local var_11_0 = var_11_1(var_2_10003)

			var_11_1 = var_11_1.GetIsland(var_11_0)
			pg = var_2_10002

			local var_11_2 = var_2_10002.island_production_slot[arg_10_1].place
			local var_11_3 = var_11_1:GetBuildingAgency()
			local var_11_4 = var_3.GetBuilding(var_11_3, var_11_2)
			local var_11_5 = var_3.GetDelegationSlotData(var_11_4, arg_10_1)
			local var_11_6 = var_2_10004.GetSlotRoleData(var_11_5)

			var_5.AddSpeedTime(var_11_6, arg_10_3)
			var_5:SetCostList(arg_11_0.time_list)

			local var_11_7 = var_11_1:GetCharacterAgency()
			local var_11_8 = var_6.GetShipById(var_11_7, var_5.ship_id)

			var_6.UpdateEnergyBeginRecoverTime(var_11_8, var_5:GetFinishTime())

			local var_11_9 = var_11_1:GetTicketAgency()

			ipairs = var_11_7

			for iter_11_0, iter_11_1 in var_11_7(arg_10_2) do
				var_11_9:ReduceTicket(iter_11_1.key.speed_id, iter_11_1.key.end_time, iter_11_1.num)
			end

			pg = var_8

			local var_11_10 = var_8.TipsMgr.GetInstance()
			local var_11_11 = var_8.ShowTips

			i18n = iter_11_0

			var_11_11(var_11_10, iter_11_0("island_use_ticket_success"))

			local var_11_12 = arg_10_0
			local var_11_13 = var_8.sendNotification

			GAME = var_11

			var_11_13(var_11_12, var_11.ISLAND_USE_TICKET_DONE, {
				type = var_0_1.TYPES.APPOINT,
				id = arg_10_1
			})
		else
			pg = var_11_1

			local var_11_14 = var_11_1.TipsMgr.GetInstance()
			local var_11_15 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_11_15(var_11_14, var_2_10004[arg_11_0.result] .. arg_11_0.result)
		end

		return
	end)

	return
end

return var_0_1
