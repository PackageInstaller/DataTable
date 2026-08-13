class = var_0_10000

local var_0_0 = "BackYardRequestShipExpCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

var_0_1.isTipSettle = true

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	ContextProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.getCurrentContext(var_1_2).mediator.__cname

	CourtYardMediator = var_1_10005

	if var_1_3 ~= var_1_10005.__cname then
		return
	end

	pg = var_1_3

	local var_1_4 = var_1_3.ConnectionMgr.GetInstance()

	var_4.Send(var_1_4, 19026, {
		type = 0
	}, 19027, function(arg_2_0)
		getProxy = var_2_10001
		DormProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)
		local var_2_1 = var_1.getRawData(var_2_0)
		local var_2_2 = var_2.GetLastAddShipExpTime(var_2_1)

		var_2:consumeFood(arg_2_0.food)

		local var_2_3 = var_2
		local var_2_4 = var_2.UpdateLastAddShipExpTime

		pg = var_6

		local var_2_5 = var_6.TimeMgr.GetInstance()

		var_2_4(var_2_3, var_6.GetServerTime(var_2_5))
		var_2:UpdateNextSettlementShipExpTime(arg_2_0.next_timestamp)

		local var_2_6 = var_1
		local var_2_7 = var_1.updateDrom
		local var_2_8 = var_2

		BackYardConst = var_2_5

		var_2_7(var_2_6, var_2_8, var_2_5.DORM_UPDATE_TYPE_UPDATEFOOD)

		if arg_2_0.exp > 0 then
			local var_2_9 = var_2
			local var_2_10 = var_2.GetBayShipOnFloor

			DormShip = var_7

			local var_2_11 = var_2_10(var_2_9, var_7.FLOOR_1)

			getProxy = var_2_9
			BayProxy = var_7

			local var_2_12 = var_2_9(var_7)
			local var_2_13 = {}
			local var_2_14 = {}

			pairs = var_2_10009

			for iter_2_0, iter_2_1 in var_2_10009(var_2_11) do
				local var_2_15 = var_2_12:getShipById(iter_2_1.id)

				if var_2_12:getShipById(iter_2_1.id).level ~= var_15:getMaxLevel() then
					var_15:addExp(var_4)
					var_2_12:updateShip(var_15)

					local var_2_16 = arg_1_0
					local var_2_17 = var_16.sendNotification

					GAME = var_18

					var_2_17(var_2_16, var_18.BACKYARD_SHIP_EXP_ADDED, {
						id = var_15.id,
						exp = var_4
					})
				end

				var_2_13[var_15.id] = var_15
				var_2_14[var_2_15.id] = var_2_15
			end

			local var_2_18 = var_0_1.isTipSettle
			local var_2_19 = arg_1_0
			local var_2_20 = var_10.sendNotification

			DormProxy = iter_2_0

			var_2_20(var_2_19, iter_2_0.SHIPS_EXP_ADDED, {
				oldShips = var_2_14,
				newShips = var_2_13,
				exp = var_4,
				food = arg_2_0.food,
				time = var_2_2,
				isTipSettle = var_2_18
			})

			var_0_1.isTipSettle = false
		end

		var_1:SettlementShipExp()

		return
	end)

	return
end

return var_0_1
