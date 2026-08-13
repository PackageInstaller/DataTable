class = var_0_10000

local var_0_0 = "BuildCommaderCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.callback
	local var_1_2 = var_2.tip

	getProxy = var_1_10006
	CommanderProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)
	local var_1_4 = var_6.getPoolById(var_1_3, var_1_0)

	getProxy = var_1_3
	PlayerProxy = var_9

	local var_1_5 = var_1_3(var_9)
	local var_1_6 = var_8.getData(var_1_5)

	getProxy = var_1_5
	BagProxy = var_1_10010

	local var_1_7 = var_1_5(var_1_10010)
	local var_1_8 = var_1_4:getConsume()
	local var_1_9 = {}

	ipairs = var_1_10012

	for iter_1_0, iter_1_1 in var_1_10012(var_1_8) do
		local var_1_10 = iter_1_1[1]

		DROP_TYPE_RESOURCE = var_1_10018

		if var_1_10 == var_1_10018 then
			var_1_10018 = var_1_6

			if var_1_6.getResById(var_1_10018, iter_1_1[2]) < iter_1_1[3] then
				pg = var_1_10018

				local var_1_11 = var_1_10018.TipsMgr.GetInstance()

				var_1_10018 = var_1_10018.ShowTips
				i18n = var_1_10020

				var_1_10018(var_1_11, var_1_10020("common_no_resource"))

				return
			end
		else
			var_1_10 = iter_1_1[1]
			DROP_TYPE_ITEM = var_1_10018

			if var_1_10 == var_1_10018 then
				var_1_10 = iter_1_1[2]

				if var_1_7:getItemCountById(var_1_10) < iter_1_1[3] then
					pg = var_19
					var_1_10020 = var_19.TipsMgr.GetInstance()

					local var_1_12 = var_19.ShowTips

					i18n = var_1_10021

					var_1_12(var_1_10020, var_1_10021("common_no_item_1"))

					return
				end
			end
		end

		Drop = var_1_10

		local var_1_13 = var_1_10.Create(iter_1_1)

		table = var_1_10018

		var_1_10018.insert(var_1_9, var_1_13)
	end

	pg = var_12

	local var_1_14 = var_12.ConnectionMgr.GetInstance()

	var_12.Send(var_1_14, 25002, {
		boxid = var_1_0
	}, 25003, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			CommanderBox = var_2_0
			var_2_0 = var_2_0.New(arg_2_0.box)
			var_2_10003 = var_0

			var_2.updateBox(var_2_10003, var_2_0)

			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(var_1_9) do
				local var_2_1 = arg_1_0
				local var_2_2 = var_7.sendNotification

				GAME = var_2_10009

				var_2_2(var_2_1, var_2_10009.CONSUME_ITEM, iter_2_1)
			end

			var_2_10003 = arg_1_0

			local var_2_3 = var_2.sendNotification

			GAME = var_4

			var_2_3(var_2_10003, var_4.COMMANDER_ON_BUILD_DONE)

			if var_1_2 then
				pg = var_2
				var_2_10003 = var_2.TipsMgr.GetInstance()

				local var_2_4 = var_2.ShowTips

				i18n = var_4

				var_2_4(var_2_10003, var_4("commander_build_done"))
			end
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			i18n = var_2_10003

			var_2_6(var_2_5, var_2_10003("commander_build_erro", arg_2_0.result))
		end

		if var_1_1 then
			var_1_1()
		end

		return
	end)

	return
end

return var_0_1
