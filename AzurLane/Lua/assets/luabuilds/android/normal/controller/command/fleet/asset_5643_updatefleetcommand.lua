class = var_0_10000

local var_0_0 = "UpdateFleetCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().fleet
	local var_1_1 = var_2.callback

	assert = var_1_10005
	isa = var_1_10006

	local var_1_2 = var_1_0

	Fleet = var_1_10008

	var_1_10005(var_1_10006(var_1_2, var_1_10008), "should be an instance of Fleet")

	getProxy = var_1_10005
	PlayerProxy = var_6

	local var_1_3 = var_1_10005(var_6)

	getProxy = var_6
	FleetProxy = var_7

	local var_1_4 = var_6(var_7)

	if var_6.getFleetById(var_1_4, var_1_0.id) == nil then
		return
	end

	local var_1_5 = {}

	_ = var_9

	var_9.each(var_1_0.vanguardShips, function(arg_2_0)
		var_1_5[#var_1_5 + 1] = arg_2_0

		return
	end)

	_ = var_9

	var_9.each(var_1_0.mainShips, function(arg_3_0)
		var_1_5[#var_1_5 + 1] = arg_3_0

		return
	end)

	_ = var_9

	var_9.each(var_1_0.subShips, function(arg_4_0)
		var_1_5[#var_1_5 + 1] = arg_4_0

		return
	end)

	pg = var_9

	local var_1_6 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_6, 12102, {
		id = var_1_0.id,
		ship_list = var_1_5
	}, 12103, function(arg_5_0)
		local var_5_0

		if arg_5_0.result == 0 then
			var_5_0 = var_1_0
			var_5_0.name = var_0.name

			local var_5_1 = var_0

			var_5_0.updateFleet(var_5_1, var_1_0)

			local var_5_2 = var_1_0

			if var_5_0.isEmpty(var_5_2) and var_1_3.combatFleetId == var_1_0.id then
				var_5_0 = var_1_3
				var_5_0.combatFleetId = 1
			end

			local var_5_3 = arg_1_0

			var_5_0 = var_5_0.sendNotification
			GAME = var_2_10003

			var_5_0(var_5_3, var_2_10003.UPDATE_FLEET_DONE, var_1_0.id)
		else
			pg = var_5_0

			local var_5_4 = var_5_0.TipsMgr.GetInstance()
			local var_5_5 = var_1.ShowTips

			errorTip = var_2_10003

			var_5_5(var_5_4, var_2_10003("fleet_updateFleet", arg_5_0.result))
		end

		if var_1_1 ~= nil then
			var_1_1()
		end

		return
	end)

	return
end

return var_0_1
