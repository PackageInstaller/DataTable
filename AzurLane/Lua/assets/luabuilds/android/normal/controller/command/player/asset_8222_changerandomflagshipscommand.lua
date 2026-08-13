class = var_0_10000

local var_0_0 = "ChangeRandomFlagShipsCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().addList
	local var_1_1 = var_2.deleteList
	local var_1_2 = {}

	ipairs = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10006({
		{
			var_1_0,
			1
		},
		{
			var_1_1,
			-1
		}
	}) do
		unpack = var_1_10011

		local var_1_3

		var_1_10011, var_1_3 = var_1_10011(iter_1_1)
		ipairs = var_1_10013

		for iter_1_2, iter_1_3 in var_1_10013(var_1_10011) do
			defaultValue = var_1_10018
			var_1_2[iter_1_3] = var_1_10018(var_1_2[iter_1_3], 0) + var_1_3
		end
	end

	getProxy = var_6
	BayProxy = var_7

	local var_1_4 = var_6(var_7)
	local var_1_5 = var_6.getRandomFlagShipPhantomMarks(var_1_4)

	ipairs = var_1_4

	for iter_1_4, iter_1_5 in var_1_4(var_1_5) do
		if var_1_2[iter_1_5] then
			var_1_2[iter_1_5] = var_1_2[iter_1_5] + 1
		end
	end

	local var_1_6 = {}

	pairs = var_8

	for iter_1_6, iter_1_7 in var_8(var_1_2) do
		math = var_1_10013

		if iter_1_7 == var_1_10013.clamp(iter_1_7, 0, 1) then
			ShipPhantom = var_1_10013

			local var_1_7

			var_1_10013, var_1_7 = var_1_10013.UnpackMark(iter_1_6)
			table = var_1_10015

			var_1_10015.insert(var_1_6, {
				ship_id = var_1_10013,
				shadow = var_1_7,
				flag = iter_1_7
			})
		end
	end

	local var_1_8 = 300

	math = var_9

	local var_1_9 = var_9.ceil(#var_1_6 / var_1_8)
	local var_1_10 = {}

	for iter_1_8 = 1, var_1_9 do
		table = var_1_10015

		var_1_10015.insert(var_1_10, function(arg_2_0)
			local var_2_0 = arg_1_0
			local var_2_1 = var_1.Send

			underscore = var_2_10003

			var_2_1(var_2_0, var_2_10003.slice(var_1_6, (iter_1_8 - 1) * var_1_8 + 1, var_1_8), arg_2_0)

			return
		end)
	end

	seriesAsync = var_11

	var_11(var_1_10, function()
		if #var_1_0 > 0 then
			pg = var_0

			local var_3_0 = var_0.TipsMgr.GetInstance()
			local var_3_1 = var_0.ShowTips

			i18n = var_2_10002

			var_3_1(var_3_0, var_2_10002("random_ship_custom_mode_add_shadow_complete"))
		end

		if #var_1_1 > 0 then
			pg = var_0

			local var_3_2 = var_0.TipsMgr.GetInstance()
			local var_3_3 = var_0.ShowTips

			i18n = var_2_10002

			var_3_3(var_3_2, var_2_10002("random_ship_custom_mode_remove_shadow_complete"))
		end

		local var_3_4 = arg_1_0
		local var_3_5 = var_0.sendNotification

		GAME = var_2_10002

		var_3_5(var_3_4, var_2_10002.CHANGE_RANDOM_SHIPS_DONE)

		return
	end)

	return
end

function var_0_1.Send(arg_4_0, arg_4_1, arg_4_2)
	pg = var_1_10003

	local var_4_0 = var_1_10003.ConnectionMgr.GetInstance()
	local var_4_1 = var_3.Send
	local var_4_2 = 12208
	local var_4_3 = {}

	underscore = var_1_10007
	var_4_3.ship_shadow_list = var_1_10007.map(arg_4_1, function(arg_5_0)
		return {
			key = arg_5_0.ship_id,
			value1 = arg_5_0.shadow,
			value2 = arg_5_0.flag
		}
	end)

	var_4_1(var_4_0, var_4_2, var_4_3, 12209, function(arg_6_0)
		if arg_6_0.result == 0 then
			getProxy = var_1
			BayProxy = var_2_10002

			local var_6_0 = var_1(var_2_10002)

			var_1.updateRandomFlagShips(var_6_0, arg_4_1)
		else
			pg = var_1

			local var_6_1 = var_1.TipsMgr.GetInstance()
			local var_6_2 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_6_2(var_6_1, var_2_10003[arg_6_0.result] .. arg_6_0.result)
		end

		if arg_4_2 then
			arg_4_2()
		end

		return
	end)

	return
end

return var_0_1
