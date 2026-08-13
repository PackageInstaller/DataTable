class = var_0_10000

local var_0_0 = var_0_10000("MonthSignPageTool")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._event = arg_1_1

	return
end

function var_0_0.onAcheve(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	local function var_2_1()
		if var_2_0 then
			coroutine = var_0

			if var_0.status(var_2_0) == "suspended" then
				coroutine = var_0

				local var_3_0, var_3_1 = var_0.resume(var_2_0)

				assert = var_2

				var_2(var_3_0, var_3_1)
			end
		end

		return
	end

	coroutine = var_1_10005
	var_2_0 = var_1_10005.create(function()
		table = var_2_10000

		local var_4_0 = var_2_10000.getCount(arg_2_1)

		if 0 < var_4_0 then
			getProxy = var_4_0
			ActivityProxy = var_2

			local var_4_1 = var_4_0(var_2)
			local var_4_2 = var_0.getActivityById

			ActivityConst = var_2_10003

			local var_4_3 = var_4_2(var_4_1, var_2_10003.MONTH_SIGN_ACTIVITY_ID)

			pg = var_1

			local var_4_4 = var_1.activity_month_sign[var_4_3.data2].resign_count

			pg = var_2

			local var_4_5 = var_2.TimeMgr.GetInstance()
			local var_4_6 = var_2.GetServerTime(var_4_5)

			pg = var_3

			local var_4_7 = var_3.TimeMgr.GetInstance()
			local var_4_8 = var_3.STimeDescS(var_4_7, var_4_6, "*t")
			local var_4_9

			if var_4_3:getSpecialData("reMonthSignDay") ~= nil then
				var_4_9 = arg_2_0

				if not arg_2_0.reMonthSignItems or not arg_2_0.reMonthSignItems then
					var_4_7 = {}
				end

				var_4_9.reMonthSignItems = var_4_7
				pairs = var_4_9

				for iter_4_0, iter_4_1 in var_4_9(arg_2_1) do
					table = var_2_10009

					var_2_10009.insert(arg_2_0.reMonthSignItems, iter_4_1)
				end

				var_4_9 = var_4_8.day

				if #var_4_3.data1_list < var_4_9 and var_4_3.data3 < var_4_4 then
					Timer = var_4_9
					iter_4_0 = var_4_9.New(function()
						arg_2_2()

						return
					end, 0.3, 1)

					var_4_9.Start(iter_4_0)

					return
				else
					local var_4_10 = arg_2_0._event

					var_4_9 = var_4_9.emit
					MonthSignPage = iter_4_0

					var_4_9(var_4_10, iter_4_0.SHOW_RE_MONTH_SIGN, arg_2_0.reMonthSignItems, var_2_1)

					arg_2_1 = arg_2_0.reMonthSignItems
				end
			else
				var_4_9 = arg_2_0
				var_4_9.reMonthSignItems = nil

				local var_4_11 = arg_2_0._event

				var_4_9 = var_4_9.emit
				BaseUI = iter_4_0

				var_4_9(var_4_11, iter_4_0.ON_AWARD, {
					items = arg_2_1,
					removeFunc = var_2_1
				})
			end

			coroutine = var_4_9

			var_4_9.yield()

			_ = var_4

			local var_4_12 = #var_4.filter(arg_2_1, function(arg_6_0)
				local var_6_0 = arg_6_0.type

				DROP_TYPE_SHIP = var_3_10002

				return var_6_0 == var_3_10002
			end)

			_ = var_4_7

			local var_4_13 = var_4_12 + #var_4_7.filter(arg_2_1, function(arg_7_0)
				local var_7_0 = arg_7_0.type

				DROP_TYPE_OPERATION = var_3_10002

				return var_7_0 == var_3_10002
			end)

			getProxy = var_6
			BayProxy = var_8

			local var_4_14 = var_6(var_8)
			local var_4_15 = var_6.getNewShip(var_4_14, true)

			_ = var_8

			var_8.each(var_5, function(arg_8_0)
				table = var_3_10001

				local var_8_0 = var_3_10001.insert
				local var_8_1 = var_4_15
				local var_8_2 = var_0

				var_8_0(var_8_1, var_4.getShipById(var_8_2, arg_8_0.id))

				return
			end)

			pg = var_8

			if var_8.gameset.award_ship_limit then
				pg = var_8

				local var_4_16

				if not var_8.gameset.award_ship_limit.key_value then
					var_4_16 = 20
				end

				if var_4_13 <= var_4_16 then
					math = var_4_14

					for iter_4_2 = var_4_14.max(1, #var_4_15 - var_4_13 + 1), #var_4_15 do
						var_2_10015 = arg_2_0._event

						local var_4_17 = var_13.emit

						ActivityMediator = var_2_10016
						var_2_10016 = var_2_10016.OPEN_LAYER
						Context = var_2_10017
						var_2_10017 = var_2_10017.New

						local var_4_18 = {}

						NewShipMediator = var_2_10020
						var_4_18.mediator = var_2_10020
						NewShipLayer = var_2_10020
						var_4_18.viewComponent = var_2_10020
						var_4_18.data = {
							ship = var_4_15[iter_4_2]
						}
						var_4_18.onRemoved = var_2_1

						var_4_17(var_2_10015, var_2_10016, var_2_10017(var_4_18))

						coroutine = var_4_17

						var_4_17.yield()
					end
				end

				pairs = var_4_14

				for iter_4_3, iter_4_4 in var_4_14(arg_2_1) do
					local var_4_19 = iter_4_4.type

					DROP_TYPE_SKIN = var_2_10015

					if var_4_19 == var_2_10015 then
						pg = var_4_19

						local var_4_20 = var_4_19.ship_skin_template[iter_4_4.id].skin_type

						ShipSkin = var_2_10015

						if var_4_20 == var_2_10015.SKIN_TYPE_REMAKE then
							-- block empty
						else
							local var_4_21 = arg_2_0._event

							var_4_20 = var_4_20.emit
							ActivityMediator = var_2_10017
							var_2_10017 = var_2_10017.OPEN_LAYER
							Context = var_2_10018
							var_2_10018 = var_2_10018.New

							local var_4_22 = {}

							NewSkinMediator = var_2_10021
							var_4_22.mediator = var_2_10021
							NewSkinLayer = var_2_10021
							var_4_22.viewComponent = var_2_10021
							var_4_22.data = {
								skinId = iter_4_4.id
							}
							var_4_22.onRemoved = var_2_1

							var_4_20(var_4_21, var_2_10017, var_2_10018(var_4_22))
						end

						coroutine = var_4_20

						var_4_20.yield()
					end
				end

				if arg_2_2 then
					arg_2_2()
				end

				return
			end
		end
	end)

	var_2_1()

	return
end

return var_0_0
