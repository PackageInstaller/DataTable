local var_0_0 = class("ChangeRandomFlagShipsCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	for iter_1_0, iter_1_1 in ipairs({
		{
			var_1_0.addList,
			1
		},
		{
			var_1_0.deleteList,
			-1
		}
	}) do
		local var_1_1, var_1_2 = unpack(iter_1_1)

		for iter_1_2, iter_1_3 in ipairs(var_1_1) do
			({})[iter_1_3] = defaultValue(({})[iter_1_3], 0) + var_1_2
		end
	end

	for iter_1_4, iter_1_5 in ipairs((getProxy(BayProxy):getRandomFlagShipPhantomMarks())) do
		if ({})[iter_1_5] then
			({})[iter_1_5] = ({})[iter_1_5] + 1
		end
	end

	local var_1_3 = {}

	for iter_1_6, iter_1_7 in pairs({}) do
		if iter_1_7 == math.clamp(iter_1_7, 0, 1) then
			local var_1_4, var_1_5 = ShipPhantom.UnpackMark(iter_1_6)

			table.insert({}, {
				ship_id = var_1_4,
				shadow = var_1_5,
				flag = iter_1_7
			})
		end
	end

	for iter_1_8 = 1, math.ceil(#{} / 300) do
		table.insert({}, function(arg_2_0)
			arg_1_0:Send(underscore.slice(var_1_3, (iter_1_8 - 1) * var_0 + 1, var_0), arg_2_0)

			return
		end)
	end

	seriesAsync({}, function()
		if #var_0 > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("random_ship_custom_mode_add_shadow_complete"))
		end

		if #var_0 > 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("random_ship_custom_mode_remove_shadow_complete"))
		end

		arg_1_0:sendNotification(GAME.CHANGE_RANDOM_SHIPS_DONE)

		return
	end)

	return
end

function var_0_0.Send(arg_4_0, arg_4_1, arg_4_2)
	pg.ConnectionMgr.GetInstance():Send(12208, {
		ship_shadow_list = underscore.map(arg_4_1, function(arg_5_0)
			return {
				key = arg_5_0.ship_id,
				value1 = arg_5_0.shadow,
				value2 = arg_5_0.flag
			}
		end)
	}, 12209, function(arg_6_0)
		if arg_6_0.result == 0 then
			getProxy(BayProxy):updateRandomFlagShips(arg_4_1)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_6_0.result] .. arg_6_0.result)
		end

		if arg_4_2 then
			arg_4_2()
		end

		return
	end)

	return
end

return var_0_0
