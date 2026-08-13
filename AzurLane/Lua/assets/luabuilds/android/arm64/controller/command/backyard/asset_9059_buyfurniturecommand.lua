class = var_0_10000

local var_0_0 = "BuyFurnitureCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().furnitureIds
	local var_1_1 = var_2.type

	getProxy = var_1_10005
	DormProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	getProxy = var_1_10006
	PlayerProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4 = var_6.getData(var_1_3)

	if #var_1_0 == 0 or not var_1_1 then
		return
	end

	local var_1_5 = 0

	ipairs = var_1_3

	for iter_1_0, iter_1_1 in var_1_3(var_1_0) do
		Furniture = var_1_10014

		local var_1_6 = var_1_10014.New({
			id = iter_1_1
		})

		if not var_1_10014.inTime(var_1_6) then
			pg = var_1_10015

			local var_1_7 = var_1_10015.TipsMgr.GetInstance()

			var_1_10015 = var_1_10015.ShowTips
			i18n = var_1_10018

			var_1_10015(var_1_7, var_1_10018("buy_furniture_overtime"))

			return
		elseif var_1_1 == 4 then
			var_1_10015 = var_1_10014:getPrice(4)
			assert = var_16
			var_1_10018 = 0 < var_1_10015

			var_16(var_1_10018, "furniture price should more than zero>>" .. var_1_10014.id)

			var_1_5 = var_1_5 + var_1_10015
		elseif var_1_1 == 6 then
			var_1_10015 = var_1_10014:getPrice(6)
			assert = var_16
			var_1_10018 = 0 < var_1_10015

			var_16(var_1_10018, "furniture price should more than zero>>" .. var_1_10014.id)

			var_1_5 = var_1_5 + var_1_10015
		end
	end

	if var_1_4:getResById(var_1_1) < var_1_5 then
		pg = var_9

		local var_1_8 = var_9.TipsMgr.GetInstance()
		local var_1_9 = var_9.ShowTips

		i18n = var_12

		var_1_9(var_1_8, var_12("common_no_resource"))

		return
	end

	local function var_1_10()
		pg = var_2_10000

		local var_2_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_2_0, 19006, {
			furniture_id = var_1_0,
			currency = var_1_1
		}, 19007, function(arg_3_0)
			local var_3_1

			if arg_3_0.result == 0 then
				local var_3_0 = var_1_4

				var_3_1 = var_3_1.consume
				var_3_10004 = {}
				id2res = var_3_10005
				var_3_10004[var_3_10005(var_1_1)] = var_1_5

				var_3_1(var_3_0, var_3_10004)

				local var_3_2 = var_0

				var_3_1.updatePlayer(var_3_2, var_1_4)

				var_3_1 = var_1_0[1]
				pg = var_3_10002

				if var_3_10002.furniture_data_template[var_3_1] then
					local var_3_3 = var_2.themeId

					if 0 < var_3_3 then
						local var_3_4 = var_1_2

						var_3.ResetSystemTheme(var_3_4, var_2.themeId)
					end
				end

				local var_3_5 = var_1_2
				local var_3_6 = var_3.getRawData(var_3_5)

				var_3.AddFurnitrues(var_3_6, var_1_0)

				local var_3_7 = var_1_2

				var_3_10004 = var_3_10004.updateDrom

				local var_3_8 = var_3

				BackYardConst = var_3_10008

				var_3_10004(var_3_7, var_3_8, var_3_10008.DORM_UPDATE_TYPE_FURNITURE)

				ipairs = var_3_10004

				for iter_3_0, iter_3_1 in var_3_10004(var_1_0) do
					-- block empty
				end

				PlayerConst = var_3_10004
				var_3_10004 = var_3_10004.UpdateLinkActivity
				underscore = var_6

				var_3_10004(var_6.map(var_1_0, function(arg_4_0)
					Drop = var_4_10001

					local var_4_0 = var_4_10001.New
					local var_4_1 = {
						count = 1
					}

					DROP_TYPE_FURNITURE = var_4_10004
					var_4_1.type = var_4_10004
					var_4_1.id = arg_4_0

					return var_4_0(var_4_1)
				end))

				local var_3_9 = arg_1_0

				var_3_10004 = var_3_10004.sendNotification
				GAME = iter_3_0

				local var_3_10 = iter_3_0.BUY_FURNITURE_DONE
				local var_3_11 = var_1_2

				var_3_10004(var_3_9, var_3_10, var_8.getData(var_3_11), var_1_0)

				pg = var_3_10004

				local var_3_12 = var_3_10004.TipsMgr.GetInstance()

				var_3_10004 = var_3_10004.ShowTips
				i18n = var_3_10

				var_3_10004(var_3_12, var_3_10("common_buy_success"))
			else
				pg = var_3_1

				local var_3_13 = var_3_1.TipsMgr.GetInstance()
				local var_3_14 = var_1.ShowTips

				errorTip = var_3_10004

				var_3_14(var_3_13, var_3_10004("backyard_buyFurniture_error", arg_3_0.result))
			end

			return
		end)

		return
	end

	if var_1_1 == 4 then
		i18n = var_10

		local var_1_11 = var_10("word_furniture")

		if #var_1_0 == 1 then
			Furniture = var_1_14

			local var_1_12 = var_1_14.New({
				id = var_1_0[1]
			})

			var_1_11 = var_1_14.getConfig(var_1_12, "name")
		end

		_BackyardMsgBoxMgr = var_1_14

		local var_1_14

		if var_1_14 then
			_BackyardMsgBoxMgr = var_1_14

			local var_1_13 = var_1_14

			var_1_14 = var_1_14.Show

			local var_1_15 = {}

			i18n = var_1_10015
			var_1_15.content = var_1_10015("charge_scene_buy_confirm_backyard", var_1_5, var_1_11)

			function var_1_15.onYes()
				var_1_10()

				return
			end

			var_1_14(var_1_13, var_1_15)
		else
			pg = var_1_14

			local var_1_16 = var_1_14.MsgboxMgr.GetInstance()
			local var_1_17 = var_11.ShowMsgBox
			local var_1_18 = {}

			i18n = var_1_10015
			var_1_18.content = var_1_10015("charge_scene_buy_confirm", var_1_5, var_1_11)

			function var_1_18.onYes()
				var_1_10()

				return
			end

			var_1_17(var_1_16, var_1_18)
		end
	else
		var_1_10()
	end

	return
end

return var_0_1
