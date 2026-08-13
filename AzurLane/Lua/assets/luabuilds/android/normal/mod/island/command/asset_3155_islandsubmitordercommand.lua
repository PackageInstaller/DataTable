class = var_0_10000

local var_0_0 = "IslandSubmitOrderCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().slotId

	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetIsland(var_1_1)
	local var_1_3 = var_4.GetOrderAgency(var_1_2)
	local var_1_4 = var_4.GetSlot(var_1_3, var_1_0)

	if not var_5.CanSubmit(var_1_4) then
		pg = var_6

		local var_1_5 = var_6.TipsMgr.GetInstance()
		local var_1_6 = var_6.ShowTips

		i18n = var_1_10008

		var_1_6(var_1_5, var_1_10008("common_no_resource"))

		return
	end

	local var_1_7 = var_5:GetOrder()

	if var_6.IsUrgency(var_1_7) then
		arg_1_0:HandleUrgencyOrder(var_5)
	else
		local var_1_8 = var_5:GetOrder()

		if var_6.IsFirm(var_1_8) then
			arg_1_0:HandleFirmOrder(var_5)
		else
			arg_1_0:HandleCommonOrder(var_5)
		end
	end

	return
end

function var_0_1.HandleUrgencyOrder(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_2_0 = var_1_10002(var_1_10003)
	local var_2_1 = var_2.GetIsland(var_2_0)
	local var_2_2 = var_2.GetOrderAgency(var_2_1)

	pg = var_2_1

	local var_2_3 = var_2_1.ConnectionMgr.GetInstance()

	var_3.Send(var_2_3, 21405, {
		slot_id = arg_2_1.id
	}, 21406, function(arg_3_0)
		local var_3_1

		if arg_3_0.result == 0 then
			local var_3_0 = arg_2_0

			var_3_1 = var_3_1.HandleDrops(var_3_0, arg_2_1)
			var_2_10003 = arg_2_0

			var_2.HandleConsume(var_2_10003, arg_2_1)

			var_2_10003 = var_2_2

			var_2.RemoveSlot(var_2_10003, arg_2_1.id)

			var_2_10003 = var_2_2

			var_2.IncUrgencyFinishCnt(var_2_10003)

			var_2_10003 = var_2_2

			var_2.RecordNextCanSubmitTime(var_2_10003)

			var_2_10003 = var_2_2

			local var_3_2 = var_2.AddExp
			local var_3_3 = arg_2_1
			local var_3_4 = var_4.GetOrder(var_3_3)

			var_3_2(var_2_10003, var_4.GetExpValue(var_3_4))

			var_2_10003 = arg_2_0

			local var_3_5 = var_2.sendNotification

			GAME = var_4

			var_3_5(var_2_10003, var_4.ISLAND_SUBMIT_ORDER_DONE, {
				dropData = var_3_1,
				slotId = arg_2_1.id
			})

			pg = var_3_5
			var_2_10003 = var_3_5.GameTrackerMgr.GetInstance()

			local var_3_6 = var_2.Record

			GameTrackerBuilder = var_4

			local var_3_7 = var_4.BuildIslandSubmitOrder

			IslandOrder = var_5

			var_3_6(var_2_10003, var_3_7(var_5.TYPE_URGENCY, arg_2_1.id))
		else
			pg = var_3_1

			local var_3_8 = var_3_1.TipsMgr.GetInstance()
			local var_3_9 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_3_9(var_3_8, var_2_10003[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

function var_0_1.HandleCommonOrder(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)
	local var_4_1 = var_2.GetIsland(var_4_0)
	local var_4_2 = var_2.GetOrderAgency(var_4_1)

	pg = var_4_1

	local var_4_3 = var_4_1.ConnectionMgr.GetInstance()

	var_3.Send(var_4_3, 21401, {
		slot_id = arg_4_1.id
	}, 21402, function(arg_5_0)
		local var_5_1

		if arg_5_0.result == 0 then
			local var_5_0 = arg_4_0

			var_5_1 = var_5_1.HandleDrops(var_5_0, arg_4_1)
			var_2_10003 = arg_4_0

			var_2.HandleConsume(var_2_10003, arg_4_1)

			if arg_5_0.slot then
				var_2_10003 = arg_4_1

				var_2.Flush(var_2_10003, arg_5_0.slot)
			else
				var_2_10003 = var_4_2

				var_2.RemoveSlot(var_2_10003, arg_4_1.id)
			end

			var_2_10003 = var_4_2

			var_2.IncFinishCnt(var_2_10003)

			var_2_10003 = var_4_2

			var_2.RecordNextCanSubmitTime(var_2_10003)

			var_2_10003 = var_4_2

			local var_5_2 = var_2.AddExp
			local var_5_3 = arg_4_1
			local var_5_4 = var_4.GetOrder(var_5_3)

			var_5_2(var_2_10003, var_4.GetExpValue(var_5_4))

			var_2_10003 = arg_4_0

			local var_5_5 = var_2.sendNotification

			GAME = var_4

			var_5_5(var_2_10003, var_4.ISLAND_SUBMIT_ORDER_DONE, {
				dropData = var_5_1,
				slotId = arg_4_1.id
			})

			pg = var_5_5
			var_2_10003 = var_5_5.GameTrackerMgr.GetInstance()

			local var_5_6 = var_2.Record

			GameTrackerBuilder = var_4

			local var_5_7 = var_4.BuildIslandSubmitOrder

			IslandOrder = var_5

			var_5_6(var_2_10003, var_5_7(var_5.TYPE_NORMAL, arg_4_1.id))

			IslandTaskHelper = var_5_6

			local var_5_8 = var_5_6.UpdateRuntimeTaskByTargetType

			IslandTaskTargetType = var_2_10003

			var_5_8(var_2_10003.ORDER_DAILY)
		else
			pg = var_5_1

			local var_5_9 = var_5_1.TipsMgr.GetInstance()
			local var_5_10 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_5_10(var_5_9, var_2_10003[arg_5_0.result] .. arg_5_0.result)
		end

		return
	end)

	return
end

function var_0_1.HandleFirmOrder(arg_6_0, arg_6_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10003

	local var_6_0 = var_1_10002(var_1_10003)
	local var_6_1 = var_2.GetIsland(var_6_0)
	local var_6_2 = var_2.GetOrderAgency(var_6_1)

	pg = var_6_1

	local var_6_3 = var_6_1.ConnectionMgr.GetInstance()

	var_3.Send(var_6_3, 21414, {
		order_id = arg_6_1.id
	}, 21415, function(arg_7_0)
		local var_7_1

		if arg_7_0.result == 0 then
			local var_7_0 = arg_6_0

			var_7_1 = var_7_1.HandleDrops(var_7_0, arg_6_1)
			var_2_10003 = arg_6_0

			var_2.HandleConsume(var_2_10003, arg_6_1)

			var_2_10003 = arg_6_0

			var_2.HandleFirmActivityOrder(var_2_10003, arg_6_1)

			var_2_10003 = var_6_2

			var_2.RemoveSlot(var_2_10003, arg_6_1.id)

			var_2_10003 = var_6_2

			var_2.RecordNextCanSubmitTime(var_2_10003)

			var_2_10003 = arg_6_1

			local var_7_2 = var_2.GetOrder(var_2_10003)

			isa = var_2_10003

			local var_7_3 = var_7_2

			IslandFirmActivityOrder = var_2_10005

			if not var_2_10003(var_7_3, var_2_10005) then
				local var_7_4 = var_6_2

				var_2_10003.AddExp(var_7_4, var_7_2:GetExpValue())
			end

			local var_7_5 = arg_6_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_2_10005

			var_2_10003(var_7_5, var_2_10005.ISLAND_SUBMIT_ORDER_DONE, {
				dropData = var_7_1,
				slotId = arg_6_1.id
			})

			pg = var_2_10003

			local var_7_6 = var_2_10003.GameTrackerMgr.GetInstance()

			var_2_10003 = var_2_10003.Record
			GameTrackerBuilder = var_5

			local var_7_7 = var_5.BuildIslandSubmitOrder

			IslandOrder = var_6

			var_2_10003(var_7_6, var_7_7(var_6.TYPE_FORM, arg_6_1.id))
		else
			pg = var_7_1

			local var_7_8 = var_7_1.TipsMgr.GetInstance()
			local var_7_9 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_7_9(var_7_8, var_2_10003[arg_7_0.result] .. arg_7_0.result)
		end

		return
	end)

	return
end

function var_0_1.HandleDrops(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:GetOrder()
	local var_8_1, var_8_2 = var_2.GetAwardItemAndExp(var_8_0)

	IslandDropHelper = var_1_10005

	return (var_1_10005.AddItems({
		drop_list = var_8_1
	}, var_8_2))
end

function var_0_1.HandleConsume(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:GetOrder()
	local var_9_1 = var_2.GetConsume(var_9_0)

	ipairs = var_9_0

	for iter_9_0, iter_9_1 in var_9_0(var_9_1) do
		local var_9_2 = arg_9_0
		local var_9_3 = arg_9_0.sendNotification

		GAME = var_1_10010

		var_9_3(var_9_2, var_1_10010.CONSUME_ITEM, iter_9_1)
	end

	return
end

function var_0_1.HandleFirmActivityOrder(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1
	local var_10_1 = arg_10_1.GetOrder(var_10_0)

	isa = var_10_0

	local var_10_2 = var_10_1

	IslandFirmActivityOrder = var_1_10005

	if var_10_0(var_10_2, var_1_10005) then
		local var_10_3 = var_10_1

		if var_10_1.getConfig(var_10_3, "next_order") == 0 then
			getProxy = var_3
			IslandProxy = var_10_3
			var_10_3 = var_3(var_10_3)
			var_10_3 = var_3.GetIsland(var_10_3)

			local var_10_4 = var_3.GetOrderAgency(var_10_3)

			var_3.AddFinishedActGroupId(var_10_4, var_10_1:GetActivityId(), var_10_1:GetGroupId())
		end

		IslandTaskHelper = var_3

		local var_10_5 = var_3.UpdateRuntimeTaskByTargetType

		IslandTaskTargetType = var_10_3

		var_10_5(var_10_3.ACTIVITY_ORDER)
	end

	return
end

return var_0_1
