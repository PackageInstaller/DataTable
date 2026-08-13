class = var_0_10000

local var_0_0 = "BuildShipImmediatelyCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1:getBody().type then
		var_1_0 = 1
	end

	local var_1_1 = var_2.pos_list

	getProxy = var_1_10005
	BuildShipProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	underscore = var_1_10006

	if #var_1_10006.filter(var_1_1, function(arg_2_0)
		local var_2_0 = var_1_2
		local var_2_1 = var_1.getBuildShip(var_2_0, arg_2_0).state

		BuildShip = var_2_10002

		return var_2_1 ~= var_2_10002.FINISH
	end) == 0 then
		existCall = var_6

		var_6(var_2.callback)

		return
	end

	getProxy = var_6
	BagProxy = var_1_6

	local var_1_3 = var_6(var_1_6)
	local var_1_4 = var_6.getItemCountById

	ITEM_ID_EQUIP_QUICK_FINISH = var_1_10010

	local var_1_6, var_1_7

	if var_1_4(var_1_3, var_1_10010) == 0 then
		pg = var_1_6

		local var_1_5 = var_1_6.TipsMgr.GetInstance()

		var_1_6 = var_1_6.ShowTips
		i18n = var_1_10011

		var_1_6(var_1_5, var_1_10011("common_no_item_1"))

		return
	else
		underscore = var_1_6
		var_1_7 = var_1_6.slice(var_1_7, 1, var_7)
	end

	pg = var_1_6

	local var_1_8 = var_1_6.ConnectionMgr.GetInstance()

	var_8.Send(var_1_8, 12008, {
		type = var_1_0,
		pos_list = var_1_7
	}, 12009, function(arg_3_0)
		local var_3_0 = {}

		ipairs = var_2_10002

		for iter_3_0, iter_3_1 in var_2_10002(arg_3_0.pos_list) do
			local var_3_1 = var_0
			local var_3_2 = var_7.removeItemById

			ITEM_ID_EQUIP_QUICK_FINISH = var_2_10010

			var_3_2(var_3_1, var_2_10010, 1)

			local var_3_3 = var_1_2

			var_2_10010 = var_7.getBuildShip(var_3_3, iter_3_1)

			var_7.finish(var_2_10010)

			var_2_10010 = var_1_2

			var_8.finishBuildShip(var_2_10010, iter_3_1)
		end

		local var_3_5

		if arg_3_0.result == 0 then
			pg = var_3_5

			local var_3_4 = var_3_5.TipsMgr.GetInstance()

			var_3_5 = var_3_5.ShowTips
			i18n = iter_3_0
			iter_3_0 = iter_3_0("word_speedUp")
			i18n = iter_3_1

			var_3_5(var_3_4, iter_3_0 .. iter_3_1("word_succeed"))

			local var_3_6 = arg_1_0

			var_3_5 = var_3_5.sendNotification
			GAME = iter_3_0

			var_3_5(var_3_6, iter_3_0.BUILD_SHIP_IMMEDIATELY_DONE)

			existCall = var_3_5

			var_3_5(var_0.callback)
		else
			pg = var_3_5

			local var_3_7 = var_3_5.TipsMgr.GetInstance()
			local var_3_8 = var_2.ShowTips

			errorTip = iter_3_0

			var_3_8(var_3_7, iter_3_0("ship_buildShipImmediately", arg_3_0.result))
		end

		return
	end)

	return
end

return var_0_1
