class = var_0_10000

local var_0_0 = "BuildShipImmediatelyCommand"

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

	if #var_1_10006.filter(var_1_1, function(arg_2_0)
		local var_2_0 = var_1_2
		local var_2_1 = var_1.getBuildShip(var_2_0, arg_2_0).state

		BuildShip = var_2_0

		return var_2_1 ~= var_2_0.FINISH
	end) == 0 then
		existCall = var_6

		var_6(var_2.callback)

		return
	end

	getProxy = var_6
	BagProxy = var_7

	local var_1_3 = var_6(var_7)
	local var_1_4 = var_6.getItemCountById

	ITEM_ID_EQUIP_QUICK_FINISH = var_1_10009

	local var_1_6

	if var_1_4(var_1_3, var_1_10009) == 0 then
		pg = var_1_3

		local var_1_5 = var_1_3.TipsMgr.GetInstance()

		var_1_3 = var_1_3.ShowTips
		i18n = var_1_10010

		var_1_3(var_1_5, var_1_10010("common_no_item_1"))

		return
	else
		underscore = var_1_3
		var_1_6 = var_1_3.slice(var_1_6, 1, var_7)
	end

	pg = var_1_3

	local var_1_7 = var_1_3.ConnectionMgr.GetInstance()

	var_8.Send(var_1_7, 12008, {
		type = var_1_0,
		pos_list = var_1_6
	}, 12009, function(arg_3_0)
		local var_3_0 = {}

		ipairs = var_2_10002

		for iter_3_0, iter_3_1 in var_2_10002(arg_3_0.pos_list) do
			local var_3_1 = var_0
			local var_3_2 = var_7.removeItemById

			ITEM_ID_EQUIP_QUICK_FINISH = var_2_10009

			var_3_2(var_3_1, var_2_10009, 1)

			local var_3_3 = var_1_2

			var_2_10009 = var_7.getBuildShip(var_3_3, iter_3_1)

			var_7.finish(var_2_10009)

			var_2_10009 = var_1_2

			var_8.finishBuildShip(var_2_10009, iter_3_1)
		end

		local var_3_5, var_3_6

		if arg_3_0.result == 0 then
			pg = var_3_5

			local var_3_4 = var_3_5.TipsMgr.GetInstance()

			var_3_5 = var_3_5.ShowTips
			i18n = var_3_6
			var_3_6 = var_3_6("word_speedUp")
			i18n = var_5

			var_3_5(var_3_4, var_3_6 .. var_5("word_succeed"))

			local var_3_7 = arg_1_0

			var_3_5 = var_3_5.sendNotification
			GAME = var_3_6

			var_3_5(var_3_7, var_3_6.BUILD_SHIP_IMMEDIATELY_DONE)

			existCall = var_3_5

			var_3_5(var_0.callback)
		else
			pg = var_3_5

			local var_3_8 = var_3_5.TipsMgr.GetInstance()
			local var_3_9 = var_2.ShowTips

			errorTip = var_3_6

			var_3_9(var_3_8, var_3_6("ship_buildShipImmediately", arg_3_0.result))
		end

		return
	end)

	return
end

return var_0_1
