local IslandShipOrderOpCommand = class("IslandShipOrderOpCommand", pm.SimpleCommand)

function IslandShipOrderOpCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(IslandProxy):GetIsland():GetOrderAgency():GetShipOrderSlot(var_1_0.slotId)

	if not var_1_1 then
		return
	end

	if var_1_0.op == IslandShipOrder.OP_TYPE_UNLOCK then
		self:HandleUnlock(var_1_1)
	elseif var_1_0.op == IslandShipOrder.OP_TYPE_GET_AWARD then
		self:HandleGetAward(var_1_1)
	elseif var_1_0.op == IslandShipOrder.OP_TYPE_LOADUP then
		self:HandleLoadUp(var_1_1, var_1_0.index)
	elseif var_1_0.op == IslandShipOrder.OP_TYPE_LOADUP_ALL then
		self:HandleLoadUpAll(var_1_1)
	end

	return
end

function IslandShipOrderOpCommand:HandleUnlock(arg_2_1)
	if not arg_2_1:IsLock() then
		return
	end

	if not arg_2_1:CanUnlock() then
		return
	end

	local var_2_0 = Drop.New((arg_2_1:GetUnlockGold()))

	if var_2_0:getOwnedCount() < var_2_0.count then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21408, {
		type = IslandShipOrder.OP_TYPE_UNLOCK,
		ship_slot_id = arg_2_1.id
	}, 21409, function(arg_3_0)
		if arg_3_0.result == 0 then
			self:sendNotification(GAME.CONSUME_ITEM, var_2_0)
			arg_2_1:Init(arg_3_0.slot, true)

			if arg_3_0.appoint_list and #arg_3_0.appoint_list > 0 then
				local var_3_0 = {}

				for iter_3_0, iter_3_1 in ipairs(arg_3_0.appoint_list) do
					var_3_0[iter_3_1.id] = IslandShipOrderDelegateSlot.New(iter_3_1)
				end

				getProxy(IslandProxy):GetIsland():GetOrderAgency():AddDelegateSlotList(var_3_0)
			end

			self:sendNotification(GAME.ISLAND_SHIP_ORDER_OP_DONE, {
				op = IslandShipOrder.OP_TYPE_UNLOCK,
				dropData = IslandDropHelper.AddItems(arg_3_0),
				id = arg_2_1.id
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

function IslandShipOrderOpCommand:HandleGetAward(arg_4_1)
	if not arg_4_1:IsFinished() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(21408, {
		type = IslandShipOrder.OP_TYPE_GET_AWARD,
		ship_slot_id = arg_4_1.id
	}, 21409, function(arg_5_0)
		if arg_5_0.result == 0 then
			arg_4_1:Init(arg_5_0.slot)
			self:sendNotification(GAME.ISLAND_SHIP_ORDER_OP_DONE, {
				op = IslandShipOrder.OP_TYPE_GET_AWARD,
				dropData = IslandDropHelper.AddItems(arg_5_0),
				id = arg_4_1.id
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_5_0.result] .. arg_5_0.result)
		end

		return
	end)

	return
end

function IslandShipOrderOpCommand:HandleLoadUpAll(arg_6_1)
	if not arg_6_1:CanTransport() then
		return
	end

	local var_6_0 = arg_6_1:GetOrder()
	local var_6_1 = 0
	local var_6_2 = {}
	local var_6_3 = {}
	local var_6_4 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0.consumeList) do
		local var_6_5 = var_6_0:GetComsume(iter_6_0)
		local var_6_6 = Drop.New(var_6_5)

		if not var_6_0:ItemIsSubmited(iter_6_0) and var_6_6:getOwnedCount() >= var_6_6.count then
			var_6_1 = var_6_1 + var_6_0:GetConsumeAwards(iter_6_0)[2].count

			table.insert(var_6_2, var_6_5.id)
			table.insert(var_6_3, iter_6_0)
			table.insert(var_6_4, var_6_6)
		end
	end

	if #var_6_3 <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(21416, {
		ship_slot_id = arg_6_1.id,
		item_id = var_6_2
	}, 21417, function(arg_7_0)
		if arg_7_0.result == 0 then
			for iter_7_0, iter_7_1 in ipairs(var_6_4) do
				self:sendNotification(GAME.CONSUME_ITEM, iter_7_1)
			end

			for iter_7_2, iter_7_3 in ipairs(var_6_3) do
				var_6_0:MarkLoadUp(iter_7_3)
			end

			local var_7_0 = var_6_0:IsLoadUpAll()

			if var_7_0 and arg_7_0.get_time then
				arg_6_1:Submit(arg_7_0.get_time)
			end

			self:sendNotification(GAME.ISLAND_SHIP_ORDER_OP_DONE, {
				isLoadUpAll = var_7_0,
				op = IslandShipOrder.OP_TYPE_LOADUP,
				dropData = IslandDropHelper.AddItems(arg_7_0, var_6_1),
				id = arg_6_1.id
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_7_0.result] .. arg_7_0.result)
		end

		return
	end)

	return
end

function IslandShipOrderOpCommand:HandleLoadUp(arg_8_1, arg_8_2)
	if not arg_8_1:CanTransport() then
		return
	end

	local var_8_0 = arg_8_1:GetOrder()
	local var_8_1 = var_8_0:GetComsume(arg_8_2)
	local var_8_2 = Drop.New(var_8_1)

	if var_8_2:getOwnedCount() < var_8_2.count then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	local var_8_3 = var_8_0:GetConsumeAwards(arg_8_2)[2]

	pg.ConnectionMgr.GetInstance():Send(21416, {
		ship_slot_id = arg_8_1.id,
		item_id = {
			var_8_1.id
		}
	}, 21417, function(arg_9_0)
		if arg_9_0.result == 0 then
			self:sendNotification(GAME.CONSUME_ITEM, var_8_2)
			var_8_0:MarkLoadUp(arg_8_2)

			local var_9_0 = var_8_0:IsLoadUpAll()

			if var_9_0 and arg_9_0.get_time then
				arg_8_1:Submit(arg_9_0.get_time)
			end

			self:sendNotification(GAME.ISLAND_SHIP_ORDER_OP_DONE, {
				isLoadUpAll = var_9_0,
				op = IslandShipOrder.OP_TYPE_LOADUP,
				dropData = IslandDropHelper.AddItems(arg_9_0, var_8_3.count),
				id = arg_8_1.id
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_9_0.result] .. arg_9_0.result)
		end

		return
	end)

	return
end

return IslandShipOrderOpCommand
