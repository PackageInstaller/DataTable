class = var_0_10000

local var_0_0 = "IslandShipOrderOpCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().op
	local var_1_1 = var_2.slotId
	local var_1_2 = var_2.index

	getProxy = var_1_10006
	IslandProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)
	local var_1_4 = var_6.GetIsland(var_1_3)
	local var_1_5 = var_6.GetOrderAgency(var_1_4)

	if not var_6.GetShipOrderSlot(var_1_5, var_1_1) then
		return
	end

	IslandShipOrder = var_1_5

	if var_1_0 == var_1_5.OP_TYPE_UNLOCK then
		arg_1_0:HandleUnlock(var_7)
	else
		IslandShipOrder = var_8

		if var_1_0 == var_8.OP_TYPE_GET_AWARD then
			arg_1_0:HandleGetAward(var_7)
		else
			IslandShipOrder = var_8

			if var_1_0 == var_8.OP_TYPE_LOADUP then
				arg_1_0:HandleLoadUp(var_7, var_1_2)
			else
				IslandShipOrder = var_8

				if var_1_0 == var_8.OP_TYPE_LOADUP_ALL then
					arg_1_0:HandleLoadUpAll(var_7)
				end
			end
		end
	end

	return
end

function var_0_1.HandleUnlock(arg_2_0, arg_2_1)
	if not arg_2_1:IsLock() then
		return
	end

	if not arg_2_1:CanUnlock() then
		return
	end

	local var_2_0 = arg_2_1
	local var_2_1 = arg_2_1.GetUnlockGold(var_2_0)

	Drop = var_2_0

	local var_2_2 = var_2_0.New(var_2_1)
	local var_2_4

	if var_3.getOwnedCount(var_2_2) < var_3.count then
		pg = var_2_4

		local var_2_3 = var_2_4.TipsMgr.GetInstance()

		var_2_4 = var_2_4.ShowTips
		i18n = var_1_10006

		var_2_4(var_2_3, var_1_10006("common_no_resource"))

		return
	end

	pg = var_2_4

	local var_2_5 = var_2_4.ConnectionMgr.GetInstance()
	local var_2_6 = var_4.Send
	local var_2_7 = 21408
	local var_2_8 = {}

	IslandShipOrder = var_1_10008
	var_2_8.type = var_1_10008.OP_TYPE_UNLOCK
	var_2_8.ship_slot_id = arg_2_1.id

	var_2_6(var_2_5, var_2_7, var_2_8, 21409, function(arg_3_0)
		local var_3_0

		if arg_3_0.result == 0 then
			IslandDropHelper = var_3_0
			var_3_0 = var_3_0.AddItems(arg_3_0)
			var_2_10003 = arg_2_0

			local var_3_1 = var_2.sendNotification

			GAME = var_2_10004

			var_3_1(var_2_10003, var_2_10004.CONSUME_ITEM, var_0)

			var_2_10003 = arg_2_1

			var_2.Init(var_2_10003, arg_3_0.slot, true)

			local var_3_3

			if arg_3_0.appoint_list then
				var_2_10003 = #var_2

				if 0 < var_2_10003 then
					var_2_10003 = {}
					ipairs = var_4

					for iter_3_0, iter_3_1 in var_4(arg_3_0.appoint_list) do
						local var_3_2 = iter_3_1.id

						IslandShipOrderDelegateSlot = var_2_10010
						var_2_10003[var_3_2] = var_2_10010.New(iter_3_1)
					end

					getProxy = var_4
					IslandProxy = var_3_3
					var_3_3 = var_4(var_3_3)
					var_3_3 = var_4.GetIsland(var_3_3)

					local var_3_4 = var_4.GetOrderAgency(var_3_3)

					var_4.AddDelegateSlotList(var_3_4, var_2_10003)
				end
			end

			local var_3_5 = arg_2_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_3_3

			local var_3_6 = var_3_3.ISLAND_SHIP_ORDER_OP_DONE
			local var_3_7 = {}

			IslandShipOrder = iter_3_0
			var_3_7.op = iter_3_0.OP_TYPE_UNLOCK
			var_3_7.dropData = var_3_0
			var_3_7.id = arg_2_1.id

			var_2_10003(var_3_5, var_3_6, var_3_7)
		else
			pg = var_3_0

			local var_3_8 = var_3_0.TipsMgr.GetInstance()
			local var_3_9 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_3_9(var_3_8, var_2_10003[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

function var_0_1.HandleGetAward(arg_4_0, arg_4_1)
	if not arg_4_1:IsFinished() then
		return
	end

	pg = var_2

	local var_4_0 = var_2.ConnectionMgr.GetInstance()
	local var_4_1 = var_2.Send
	local var_4_2 = 21408
	local var_4_3 = {}

	IslandShipOrder = var_1_10006
	var_4_3.type = var_1_10006.OP_TYPE_GET_AWARD
	var_4_3.ship_slot_id = arg_4_1.id

	var_4_1(var_4_0, var_4_2, var_4_3, 21409, function(arg_5_0)
		local var_5_0

		if arg_5_0.result == 0 then
			IslandDropHelper = var_5_0
			var_5_0 = var_5_0.AddItems(arg_5_0)
			var_2_10003 = arg_4_1

			var_2.Init(var_2_10003, arg_5_0.slot)

			var_2_10003 = arg_4_0

			local var_5_1 = var_2.sendNotification

			GAME = var_4

			local var_5_2 = var_4.ISLAND_SHIP_ORDER_OP_DONE
			local var_5_3 = {}

			IslandShipOrder = var_2_10006
			var_5_3.op = var_2_10006.OP_TYPE_GET_AWARD
			var_5_3.dropData = var_5_0
			var_5_3.id = arg_4_1.id

			var_5_1(var_2_10003, var_5_2, var_5_3)
		else
			pg = var_5_0

			local var_5_4 = var_5_0.TipsMgr.GetInstance()
			local var_5_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_5_5(var_5_4, var_2_10003[arg_5_0.result] .. arg_5_0.result)
		end

		return
	end)

	return
end

function var_0_1.HandleLoadUpAll(arg_6_0, arg_6_1)
	if not arg_6_1:CanTransport() then
		return
	end

	local var_6_0 = arg_6_1:GetOrder()
	local var_6_1 = 0
	local var_6_2 = {}
	local var_6_3 = {}
	local var_6_4 = {}

	ipairs = var_1_10007

	for iter_6_0, iter_6_1 in var_1_10007(var_6_0.consumeList) do
		local var_6_5 = var_6_0
		local var_6_6 = var_6_0.GetComsume(var_6_5, iter_6_0)

		Drop = var_6_5

		local var_6_7 = var_6_5.New(var_6_6)
		local var_6_8 = var_6_0:GetConsumeAwards(iter_6_0)

		if not var_6_0:ItemIsSubmited(iter_6_0) and var_6_7:getOwnedCount() >= var_6_7.count then
			var_6_1 = var_6_1 + var_6_8[2].count
			table = var_15

			var_15.insert(var_6_2, var_6_6.id)

			table = var_15

			var_15.insert(var_6_3, iter_6_0)

			table = var_15

			var_15.insert(var_6_4, var_6_7)
		end
	end

	local var_6_10

	if #var_6_3 <= 0 then
		pg = var_6_10

		local var_6_9 = var_6_10.TipsMgr.GetInstance()

		var_6_10 = var_6_10.ShowTips
		i18n = var_9

		var_6_10(var_6_9, var_9("common_no_resource"))

		return
	end

	pg = var_6_10

	local var_6_11 = var_6_10.ConnectionMgr.GetInstance()

	var_7.Send(var_6_11, 21416, {
		ship_slot_id = arg_6_1.id,
		item_id = var_6_2
	}, 21417, function(arg_7_0)
		local var_7_0

		if arg_7_0.result == 0 then
			IslandDropHelper = var_7_0
			var_7_0 = var_7_0.AddItems(arg_7_0, var_6_1)
			ipairs = var_2

			for iter_7_0, iter_7_1 in var_2(var_6_4) do
				local var_7_1 = arg_6_0

				var_2_10007 = var_2_10007.sendNotification
				GAME = var_2_10009

				var_2_10007(var_7_1, var_2_10009.CONSUME_ITEM, iter_7_1)
			end

			ipairs = var_2

			for iter_7_2, iter_7_3 in var_2(var_6_3) do
				local var_7_2 = var_6_0

				var_2_10007.MarkLoadUp(var_7_2, iter_7_3)
			end

			var_2_10003 = var_6_0

			if var_2.IsLoadUpAll(var_2_10003) and arg_7_0.get_time then
				local var_7_3 = arg_6_1

				var_2_10003.Submit(var_7_3, arg_7_0.get_time)
			end

			local var_7_4 = arg_6_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = iter_7_2

			local var_7_5 = iter_7_2.ISLAND_SHIP_ORDER_OP_DONE
			local var_7_6 = {
				isLoadUpAll = var_2
			}

			IslandShipOrder = var_2_10007
			var_7_6.op = var_2_10007.OP_TYPE_LOADUP
			var_7_6.dropData = var_7_0
			var_7_6.id = arg_6_1.id

			var_2_10003(var_7_4, var_7_5, var_7_6)
		else
			pg = var_7_0

			local var_7_7 = var_7_0.TipsMgr.GetInstance()
			local var_7_8 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_7_8(var_7_7, var_2_10003[arg_7_0.result] .. arg_7_0.result)
		end

		return
	end)

	return
end

function var_0_1.HandleLoadUp(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1:CanTransport() then
		return
	end

	local var_8_0 = arg_8_1:GetOrder()
	local var_8_1 = var_3.GetComsume(var_8_0, arg_8_2)

	Drop = var_8_0

	local var_8_2 = var_8_0.New(var_8_1)
	local var_8_3 = var_3:GetConsumeAwards(arg_8_2)
	local var_8_4

	if var_8_2:getOwnedCount() < var_8_2.count then
		pg = var_7
		var_8_4 = var_7.TipsMgr.GetInstance()

		local var_8_5 = var_7.ShowTips

		i18n = var_1_10009

		var_8_5(var_8_4, var_1_10009("common_no_resource"))

		return
	end

	local var_8_6 = var_8_3[2]

	pg = var_8_4

	local var_8_7 = var_8_4.ConnectionMgr.GetInstance()

	var_8.Send(var_8_7, 21416, {
		ship_slot_id = arg_8_1.id,
		item_id = {
			var_8_1.id
		}
	}, 21417, function(arg_9_0)
		local var_9_0

		if arg_9_0.result == 0 then
			IslandDropHelper = var_9_0
			var_9_0 = var_9_0.AddItems(arg_9_0, var_8_6.count)
			var_2_10003 = arg_8_0

			local var_9_1 = var_2.sendNotification

			GAME = var_2_10004

			var_9_1(var_2_10003, var_2_10004.CONSUME_ITEM, var_8_2)

			var_2_10003 = var_0

			var_2.MarkLoadUp(var_2_10003, arg_8_2)

			var_2_10003 = var_0

			if var_2.IsLoadUpAll(var_2_10003) and arg_9_0.get_time then
				local var_9_2 = arg_8_1

				var_2_10003.Submit(var_9_2, arg_9_0.get_time)
			end

			local var_9_3 = arg_8_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_5

			local var_9_4 = var_5.ISLAND_SHIP_ORDER_OP_DONE
			local var_9_5 = {
				isLoadUpAll = var_2
			}

			IslandShipOrder = var_2_10007
			var_9_5.op = var_2_10007.OP_TYPE_LOADUP
			var_9_5.dropData = var_9_0
			var_9_5.id = arg_8_1.id

			var_2_10003(var_9_3, var_9_4, var_9_5)
		else
			pg = var_9_0

			local var_9_6 = var_9_0.TipsMgr.GetInstance()
			local var_9_7 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_9_7(var_9_6, var_2_10003[arg_9_0.result] .. arg_9_0.result)
		end

		return
	end)

	return
end

return var_0_1
