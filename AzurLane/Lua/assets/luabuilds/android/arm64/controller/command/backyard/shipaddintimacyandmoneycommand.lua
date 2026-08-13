class = var_0_10000

local var_0_0 = "ShipAddIntimacyAndMoneyCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	DormProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.getRawData(var_1_1)

	if #var_4.GetHasMoneyOrIntimacyShips(var_1_2) <= 0 then
		return
	end

	pg = var_6

	local var_1_3 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 19011, {
		id = 0
	}, 19012, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			BayProxy = var_2_10003
			var_2_0 = var_2_0(var_2_10003)
			getProxy = var_2_10002
			DormProxy = var_2_10004
			var_2_10004 = var_2_10002(var_2_10004)

			local var_2_1 = var_2.getRawData(var_2_10004)
			local var_2_2 = {}

			var_2_10004 = {}

			local var_2_3 = 0

			ipairs = var_2_10006

			for iter_2_0, iter_2_1 in var_2_10006(var_0) do
				local var_2_4 = iter_2_1.id
				local var_2_5 = var_2_0:RawGetShipById(var_2_4)

				if iter_2_1:HasIntimacy() then
					table = var_13

					var_13.insert(var_2_2, var_2_5)
				end

				if iter_2_1:HasMoney() then
					var_2_3 = var_2_3 + iter_2_1:GetMoney()
					table = var_13

					var_13.insert(var_2_10004, var_2_5)
				end

				var_2_1:HarvestInimacyAndMoney(var_2_4)
			end

			local var_2_6 = var_0
			local var_2_7 = var_6.updateDrom
			local var_2_8 = var_2_1

			BackYardConst = iter_2_1

			var_2_7(var_2_6, var_2_8, iter_2_1.DORM_UPDATE_TYPE_SHIP)

			local var_2_9 = arg_1_0

			var_6.ShowIntimacyTip(var_2_9, var_2_2)

			local var_2_10 = arg_1_0

			var_6.ShowMoneyTip(var_2_10, var_2_10004, var_2_3)

			local var_2_11 = arg_1_0
			local var_2_12 = var_6.sendNotification

			GAME = var_9

			var_2_12(var_2_11, var_9.BACKYARD_ONE_KEY_DONE, {
				shipIds = var_0
			})
		else
			pg = var_2_0

			local var_2_13 = var_2_0.TipsMgr.GetInstance()
			local var_2_14 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_14(var_2_13, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function var_0_1.ShowIntimacyTip(arg_3_0, arg_3_1)
	if #arg_3_1 == 0 then
		return
	end

	if #arg_3_1 == 1 then
		local var_3_0 = arg_3_1[1]

		pg = var_1_10003

		local var_3_1 = var_1_10003.TipsMgr.GetInstance()
		local var_3_2 = var_3.ShowTips

		i18n = var_1_10006

		var_3_2(var_3_1, var_1_10006("backyard_shipAddInimacy_ok", var_3_0:getName()))

		return
	end

	local var_3_3 = #arg_3_1

	if 1 < var_3_3 then
		table = var_3_3

		var_3_3.sort(arg_3_1, function(arg_4_0, arg_4_1)
			return arg_4_0.groupId < arg_4_1.groupId
		end)

		_ = var_2

		local var_3_4 = var_2.first(arg_3_1, 2)

		_ = var_3

		local var_3_5 = var_3.map(var_3_4, function(arg_5_0)
			return arg_5_0:getName()
		end)

		table = var_4

		local var_3_6 = var_4.concat(var_3_5, "、")
		local var_3_8

		if #arg_3_1 == 2 then
			pg = var_3_8

			local var_3_7 = var_3_8.TipsMgr.GetInstance()

			var_3_8 = var_3_8.ShowTips
			i18n = var_1_10008

			var_3_8(var_3_7, var_1_10008("backyard_shipAddInimacy_ok", var_3_6))
		else
			pg = var_3_8

			local var_3_9 = var_3_8.TipsMgr.GetInstance()
			local var_3_10 = var_5.ShowTips

			i18n = var_1_10008

			var_3_10(var_3_9, var_1_10008("backyard_shipAddInimacy_ships_ok", var_3_6))
		end

		return
	end

	return
end

function var_0_1.ShowMoneyTip(arg_6_0, arg_6_1, arg_6_2)
	if #arg_6_1 == 0 then
		return
	end

	if #arg_6_1 == 1 then
		local var_6_0 = arg_6_1[1]

		pg = var_1_10004

		local var_6_1 = var_1_10004.TipsMgr.GetInstance()
		local var_6_2 = var_4.ShowTips

		i18n = var_1_10007

		var_6_2(var_6_1, var_1_10007("backyard_shipAddMoney_ok", var_6_0:getName(), arg_6_2))

		return
	end

	local var_6_3 = #arg_6_1

	if 1 < var_6_3 then
		table = var_6_3

		var_6_3.sort(arg_6_1, function(arg_7_0, arg_7_1)
			return arg_7_0.groupId < arg_7_1.groupId
		end)

		_ = var_3

		local var_6_4 = var_3.first(arg_6_1, 2)

		_ = var_4

		local var_6_5 = var_4.map(var_6_4, function(arg_8_0)
			return arg_8_0:getName()
		end)

		table = var_5

		local var_6_6 = var_5.concat(var_6_5, "、")
		local var_6_8

		if #arg_6_1 == 2 then
			pg = var_6_8

			local var_6_7 = var_6_8.TipsMgr.GetInstance()

			var_6_8 = var_6_8.ShowTips
			i18n = var_1_10009

			var_6_8(var_6_7, var_1_10009("backyard_shipAddMoney_ok", var_6_6, arg_6_2))
		else
			pg = var_6_8

			local var_6_9 = var_6_8.TipsMgr.GetInstance()
			local var_6_10 = var_6.ShowTips

			i18n = var_1_10009

			var_6_10(var_6_9, var_1_10009("backyard_shipAddMoney_ships_ok", var_6_6, arg_6_2))
		end
	end

	return
end

return var_0_1
