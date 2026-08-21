local var_0_0 = class("SelectFleetCommanderCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.pos
	local var_1_2 = var_1_0.commanderId
	local var_1_3 = var_1_0.callback
	local var_1_4 = getProxy(FleetProxy):getFleetById(var_1_0.fleetId)
	local var_1_5 = var_1_4:getCommanderByPos(var_1_0.pos)
	local var_1_6 = var_1_4:getCommanders()
	local var_1_8

	if not var_1_5 or var_1_5.id ~= var_1_2 then
		local var_1_7 = getProxy(CommanderProxy):getCommanderById(var_1_2)

		for iter_1_0, iter_1_1 in pairs((var_1_4:getCommanders())) do
			if iter_1_1.groupId == var_1_7.groupId and iter_1_0 ~= var_1_0.pos and var_1_2 ~= iter_1_1.id then
				pg.TipsMgr.GetInstance():ShowTips(i18n("commander_can_not_select_same_group"))

				return
			end
		end

		var_1_8 = true
	end

	local var_1_9, var_1_10 = (function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs((getProxy(FleetProxy):getCommanders())) do
			if iter_2_1.fleetId ~= var_0 and iter_2_1.commanderId == arg_2_0 then
				return true, iter_2_1
			end
		end

		return false
	end)(var_1_2)

	if var_1_9 then
		table.insert({}, function(arg_4_0)
			local var_4_0 = var_1_10.pos == 1 and i18n("commander_main_pos") or i18n("commander_assistant_pos")

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("comander_repalce_tip", Fleet.DEFAULT_NAME[var_1_10.fleetId], var_4_0),
				onYes = function()
					pg.m02:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
						commanderId = 0,
						fleetId = var_1_10.fleetId,
						pos = var_1_10.pos,
						callback = arg_4_0
					})

					return
				end,
				onNo = function()
					var_1_8 = false

					arg_4_0()

					return
				end
			})

			return
		end)
	end

	local var_1_11, var_1_12 = (function(arg_3_0)
		local var_3_0 = var_1_1 == 2 and 1 or 2
		local var_3_1 = var_1_6[var_1_1 == 2 and 1 or 2]

		if var_1_6[var_1_1 == 2 and 1 or 2] and var_3_1.id == arg_3_0 then
			return true, var_3_0
		end

		return false
	end)(var_1_2)

	if var_1_11 then
		table.insert({}, function(arg_7_0)
			pg.m02:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
				commanderId = 0,
				fleetId = var_0,
				pos = var_1_12,
				callback = arg_7_0
			})

			return
		end)
	end

	table.insert({}, function(arg_8_0)
		if var_1_8 then
			pg.m02:sendNotification(GAME.COOMMANDER_EQUIP_TO_FLEET, {
				fleetId = var_0,
				pos = var_1_1,
				commanderId = var_1_2,
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
	seriesAsync({}, var_1_3)

	return
end

return var_0_0
