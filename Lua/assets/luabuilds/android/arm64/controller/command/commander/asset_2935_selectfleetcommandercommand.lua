local SelectFleetCommanderCommand = class("SelectFleetCommanderCommand", pm.SimpleCommand)

function SelectFleetCommanderCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.fleetId
	local var_1_2 = var_1_0.pos
	local var_1_3 = var_1_0.commanderId
	local var_1_4 = var_1_0.callback
	local var_1_5 = getProxy(FleetProxy):getFleetById(var_1_0.fleetId)
	local var_1_6 = var_1_5:getCommanderByPos(var_1_0.pos)
	local var_1_7 = var_1_5:getCommanders()
	local var_1_9

	if not var_1_6 or var_1_6.id ~= var_1_3 then
		local var_1_8 = getProxy(CommanderProxy):getCommanderById(var_1_3)

		for iter_1_0, iter_1_1 in pairs(var_1_7) do
			if iter_1_1.groupId == var_1_8.groupId and iter_1_0 ~= var_1_0.pos and var_1_3 ~= iter_1_1.id then
				pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_select_same_group"))

				return
			end
		end

		var_1_9 = {}

		local var_1_10 = true
	end

	local var_1_11, var_1_12 = (function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs((getProxy(FleetProxy):getCommanders())) do
			if iter_2_1.fleetId ~= var_1_1 and iter_2_1.commanderId == arg_2_0 then
				return true, iter_2_1
			end
		end

		return false
	end)(var_1_3)

	if var_1_11 then
		table.insert(var_1_9, function(arg_4_0)
			local var_4_0 = var_1_12.pos == 1 and i18n("commander_main_pos") or i18n("commander_assistant_pos")

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("comander_repalce_tip", Fleet.DEFAULT_NAME[var_1_12.fleetId], var_4_0),
				onYes = function()
					pg.m02:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
						commanderId = 0,
						fleetId = var_1_12.fleetId,
						pos = var_1_12.pos,
						callback = arg_4_0
					})

					return
				end,
				onNo = function()
					var_1_10 = false

					arg_4_0()

					return
				end
			})

			return
		end)
	end

	local var_1_13, var_1_14 = (function(arg_3_0)
		if var_1_7[var_1_2 == 2 and 1 or 2] and var_1_7[var_1_2 == 2 and 1 or 2].id == arg_3_0 then
			return true, var_1_2 == 2 and 1 or 2
		end

		return false
	end)(var_1_3)

	if var_1_13 then
		table.insert(var_1_9, function(arg_7_0)
			pg.m02:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
				commanderId = 0,
				fleetId = var_1_1,
				pos = var_1_14,
				callback = arg_7_0
			})

			return
		end)
	end

	table.insert(var_1_9, function(arg_8_0)
		if var_1_10 then
			pg.m02:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
				fleetId = var_1_1,
				pos = var_1_2,
				commanderId = var_1_3,
				callback = function(arg_9_0)
					arg_8_0()

					return
				end
			})
		else
			arg_8_0()
		end

		return
	end)
	seriesAsync(var_1_9, var_1_4)

	return
end

return SelectFleetCommanderCommand
