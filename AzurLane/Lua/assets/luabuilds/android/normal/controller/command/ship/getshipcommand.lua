class = var_0_10000

local var_0_0 = "GetShipCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1:getBody().type then
		var_1_0 = 1
	end

	local var_1_1 = var_2.pos_list

	getProxy = var_1_10005
	BuildShipProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	underscore = var_1_10006

	local var_1_3, var_1_4

	if #var_1_10006.filter(var_1_1, function(arg_2_0)
		local var_2_0 = var_1_2
		local var_2_1 = var_1.getBuildShip(var_2_0, arg_2_0).state

		BuildShip = var_2_0

		return var_2_1 == var_2_0.FINISH
	end) == 0 then
		pg = var_1_4
		var_1_3 = var_1_4.TipsMgr.GetInstance()
		var_1_4 = var_1_4.ShowTips
		i18n = var_8

		var_1_4(var_1_3, var_8("ship_getShip_error_notFinish"))

		return
	end

	getProxy = var_1_4
	BayProxy = var_1_3

	local var_1_5 = var_1_4(var_1_3)

	getProxy = var_1_3
	PlayerProxy = var_8

	local var_1_6 = var_1_3(var_8)
	local var_1_7 = var_7.getData(var_1_6)
	local var_1_8 = var_8.getMaxShipBag(var_1_7)
	local var_1_9 = var_1_5
	local var_1_10

	if var_1_8 - var_1_5.getShipCount(var_1_9) <= 0 then
		NoPosMsgBox = var_9
		i18n = var_1_9
		var_1_9 = var_1_9("switch_to_shop_tip_noDockyard")
		openDockyardClear = var_11
		gotoChargeScene = var_1_10012
		openDockyardIntensify = var_1_10013

		var_9(var_1_9, var_11, var_1_10012, var_1_10013)

		return
	else
		underscore = var_9
		var_1_10 = var_9.slice(var_1_10, 1, var_8)
	end

	local var_1_11 = {}

	table = var_1_9

	var_1_9.insert(var_1_11, function(arg_3_0)
		pg = var_2_10001

		local var_3_0 = var_2_10001.ConnectionMgr.GetInstance()

		var_1.Send(var_3_0, 12043, {
			type = 0
		}, 12044, function(arg_4_0)
			local var_4_0 = {}

			ipairs = var_3_10002

			for iter_4_0, iter_4_1 in var_3_10002(arg_4_0.infoList) do
				var_4_0[iter_4_1.pos] = iter_4_1.tid
			end

			local var_4_1 = arg_3_0

			underscore = var_3

			var_4_1(var_3.map(var_1_10, function(arg_5_0)
				return var_4_0[arg_5_0]
			end))

			return
		end)

		return
	end)

	table = var_10

	var_10.insert(var_1_11, function(arg_6_0, arg_6_1)
		local var_6_0 = {}

		ipairs = var_2_10003

		for iter_6_0, iter_6_1 in var_2_10003(arg_6_1) do
			PaintingGroupConst = var_2_10008

			var_2_10008.AddPaintingNameByShipConfigID(var_6_0, iter_6_1)
		end

		local var_6_1 = {
			isShowBox = true,
			paintingNameList = var_6_0,
			finishFunc = arg_6_0
		}

		PaintingGroupConst = var_4

		var_4.PaintingDownload(var_6_1)

		return
	end)

	seriesAsync = var_10

	var_10(var_1_11, function()
		local var_7_0 = var_1_2
		local var_7_1 = var_0.getBuildShip(var_7_0, var_1_10[1]).type

		pg = var_7_0

		local var_7_2 = var_7_0.ConnectionMgr.GetInstance()

		var_1.Send(var_7_2, 12025, {
			type = var_1_0,
			pos_list = var_1_10
		}, 12026, function(arg_8_0)
			local var_8_0 = {}

			ipairs = var_3_10002

			for iter_8_0, iter_8_1 in var_3_10002(arg_8_0.ship_list) do
				local var_8_1 = var_1_2

				var_7.removeBuildShipByIndex(var_8_1, var_1_10[1])

				Ship = var_7

				local var_8_2 = var_7.New(iter_8_1)

				table = var_8

				var_8.insert(var_8_0, var_8_2)

				if var_8_2:isMetaShip() and not var_8_2.virgin then
					Player = var_8

					if var_8.isMetaShipNeedToTrans(var_8_2.configId) then
						MetaCharacterConst = var_8

						if var_8.addReMetaTransItem(var_8_2) then
							var_8_2:setReMetaSpecialItemVO(var_8)
						end

						goto label_8_0
					end
				end

				do
					local var_8_3 = var_1_5

					var_8.addShip(var_8_3, var_8_2)
				end

				::label_8_0::
			end

			if #var_8_0 > 0 then
				local var_8_4 = var_1_2

				var_2.setBuildShipState(var_8_4)

				local var_8_5 = arg_1_0
				local var_8_6 = var_2.sendNotification

				GAME = var_4

				var_8_6(var_8_5, var_4.GET_SHIP_DONE, {
					ships = var_8_0,
					type = var_7_1
				})
			end

			if arg_8_0.result == 0 then
				-- block empty
			else
				pg = var_2

				local var_8_7 = var_2.TipsMgr.GetInstance()
				local var_8_8 = var_2.ShowTips

				errorTip = var_4

				var_8_8(var_8_7, var_4("ship_getShip", arg_8_0.result))
			end

			return
		end)

		return
	end)

	return
end

return var_0_1
