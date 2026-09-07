local IslandUseTicketCommand = class("IslandUseTicketCommand", pm.SimpleCommand)

IslandUseTicketCommand.TYPES = {
	SHIP_ORDER = 2,
	MANAGE = 3,
	SHIP_ORDER_RELOAD = 5,
	ORDER_CD = 1,
	APPOINT = 4
}

function IslandUseTicketCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = underscore.select(var_1_0.tickets, function(arg_2_0)
		return arg_2_0:IsExpired()
	end)

	if #var_1_1 > 0 then
		local function var_1_2()
			self:sendNotification(GAME.ISLAND_REMOVE_EXPIRED_TICKET, {
				tickets = var_1_1
			})

			return
		end

		pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
			contentText = i18n("island_ticket_expiration_tip2"),
			onClose = var_1_2,
			btnList = {
				{
					type = pg.NewStyleMsgboxMgr.BUTTON_TYPE.confirm,
					name = i18n("msgbox_text_confirm"),
					func = var_1_2,
					sound = SFX_CONFIRM
				}
			}
		})

		return
	end

	local var_1_3 = {}
	local var_1_4 = 0

	for iter_1_0, iter_1_1 in ipairs(var_1_0.tickets) do
		table.insert(var_1_3, {
			key = {
				speed_id = iter_1_1.id,
				end_time = iter_1_1.endTime
			},
			num = iter_1_1:GetCount()
		})

		var_1_4 = var_1_4 + iter_1_1:GetTime() * iter_1_1:GetCount()
	end

	if var_1_0.type == IslandUseTicketCommand.TYPES.ORDER_CD or var_1_0.type == IslandUseTicketCommand.TYPES.SHIP_ORDER or var_1_0.type == IslandUseTicketCommand.TYPES.SHIP_ORDER_RELOAD or var_1_0.type == IslandUseTicketCommand.TYPES.MANAGE then
		self:Send(var_1_0.type, var_1_0.id, var_1_3, var_1_4)
	elseif var_1_0.type == IslandUseTicketCommand.TYPES.APPOINT then
		self:SendForAppoint(var_1_0.id, var_1_3, var_1_4)
	else
		assert(false, "undefined type: " .. var_1_0.type)
	end

	return
end

function IslandUseTicketCommand:Send(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	pg.ConnectionMgr.GetInstance():Send(21423, {
		type = arg_4_1,
		target_id = arg_4_2,
		tickets = arg_4_3
	}, 21424, function(arg_5_0)
		if arg_5_0.result == 0 then
			switch(arg_4_1, {
				[IslandUseTicketCommand.TYPES.ORDER_CD] = function()
					getProxy(IslandProxy):GetIsland():GetOrderAgency():GetSlot(arg_4_2):AddReduceTime(arg_4_4)

					return
				end,
				[IslandUseTicketCommand.TYPES.SHIP_ORDER] = function()
					getProxy(IslandProxy):GetIsland():GetOrderAgency():GetShipOrderSlot(arg_4_2):AddReduceTime(arg_4_4)

					return
				end,
				[IslandUseTicketCommand.TYPES.MANAGE] = function()
					getProxy(IslandProxy):GetIsland():GetManageAgency():GetRestaurant(arg_4_2):UpdateEndTime(arg_4_4)

					return
				end,
				[IslandUseTicketCommand.TYPES.SHIP_ORDER_RELOAD] = function()
					getProxy(IslandProxy):GetIsland():GetOrderAgency():ReduceNextManualReloadDelegateTime(arg_4_4)

					return
				end
			})

			local var_5_0 = getProxy(IslandProxy):GetIsland():GetTicketAgency()

			for iter_5_0, iter_5_1 in ipairs(arg_4_3) do
				var_5_0:ReduceTicket(iter_5_1.key.speed_id, iter_5_1.key.end_time, iter_5_1.num)
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("island_use_ticket_success"))
			self:sendNotification(GAME.ISLAND_USE_TICKET_DONE, {
				type = arg_4_1,
				id = arg_4_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_5_0.result] .. arg_5_0.result)
		end

		return
	end)

	return
end

function IslandUseTicketCommand:SendForAppoint(arg_10_1, arg_10_2, arg_10_3)
	pg.ConnectionMgr.GetInstance():Send(21427, {
		area_id = arg_10_1,
		tickets = arg_10_2
	}, 21428, function(arg_11_0)
		if arg_11_0.result == 0 then
			local var_11_0 = getProxy(IslandProxy):GetIsland()
			local var_11_1 = var_11_0:GetBuildingAgency():GetBuilding(pg.island_production_slot[arg_10_1].place):GetDelegationSlotData(arg_10_1):GetSlotRoleData()

			var_11_1:AddSpeedTime(arg_10_3)
			var_11_1:SetCostList(arg_11_0.time_list)
			var_11_0:GetCharacterAgency():GetShipById(var_11_1.ship_id):UpdateEnergyBeginRecoverTime(var_11_1:GetFinishTime())

			local var_11_2 = var_11_0:GetTicketAgency()

			for iter_11_0, iter_11_1 in ipairs(arg_10_2) do
				var_11_2:ReduceTicket(iter_11_1.key.speed_id, iter_11_1.key.end_time, iter_11_1.num)
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("island_use_ticket_success"))
			self:sendNotification(GAME.ISLAND_USE_TICKET_DONE, {
				type = IslandUseTicketCommand.TYPES.APPOINT,
				id = arg_10_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_11_0.result] .. arg_11_0.result)
		end

		return
	end)

	return
end

return IslandUseTicketCommand
