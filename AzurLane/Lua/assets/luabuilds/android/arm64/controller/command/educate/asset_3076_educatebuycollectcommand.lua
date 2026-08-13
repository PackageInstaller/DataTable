class = var_0_10000

local var_0_0 = "EducateBuyCollectCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

var_0_1.TYPE = {
	POLAROID = 3,
	ENDING = 1,
	MEMORY = 2
}

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = var_2.id
	local var_1_2 = var_2.cost

	getProxy = var_1_10006
	PlayerProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4

	if var_6.getData(var_1_3).gold < var_1_2 then
		pg = var_1_4
		var_1_10010 = var_1_4.TipsMgr.GetInstance()
		var_1_4 = var_1_4.ShowTips
		i18n = var_1_10011

		var_1_4(var_1_10010, var_1_10011("common_no_resource"))

		return
	end

	getProxy = var_1_4
	EducateProxy = var_1_10010

	local var_1_5 = var_1_4(var_1_10010)

	if var_1_0 == var_0_1.TYPE.ENDING then
		table = var_9

		if var_9.contains(var_1_5:GetAllEndings(), var_1_1) then
			pg = var_9

			local var_1_6 = var_9.TipsMgr.GetInstance()
			local var_1_7 = var_9.ShowTips

			i18n = var_12

			var_1_7(var_1_6, var_12("common_already owned"))

			return
		end
	end

	if var_1_0 == var_0_1.TYPE.MEMORY then
		table = var_9

		if var_9.contains(var_1_5:GetMemories(), var_1_1) then
			pg = var_9

			local var_1_8 = var_9.TipsMgr.GetInstance()
			local var_1_9 = var_9.ShowTips

			i18n = var_12

			var_1_9(var_1_8, var_12("common_already owned"))

			return
		end
	end

	local var_1_11

	if var_1_0 == var_0_1.TYPE.POLAROID then
		table = var_1_11

		if var_1_11.contains(var_1_5:GetPolaroidList(), var_1_1) then
			pg = var_1_11

			local var_1_10 = var_1_11.TipsMgr.GetInstance()

			var_1_11 = var_1_11.ShowTips
			i18n = var_12

			var_1_11(var_1_10, var_12("common_already owned"))

			return
		end
	end

	pg = var_1_11

	local var_1_12 = var_1_11.ConnectionMgr.GetInstance()

	var_9.Send(var_1_12, 27049, {
		type = var_1_0,
		ids = var_1_1
	}, 27050, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_3.consume(var_2_0, {
				gold = var_1_2
			})

			local var_2_1 = var_0

			var_2_3.updatePlayer(var_2_1, var_0)

			switch = var_2_3

			var_2_3(var_1_0, {
				[var_0_1.TYPE.ENDING] = function()
					local var_3_0 = var_1_5

					var_0.AddEndingFromBuy(var_3_0, var_1_1)

					local var_3_1 = var_1_5

					var_0.AddEndingBuyCnt(var_3_1)

					return
				end,
				[var_0_1.TYPE.MEMORY] = function()
					local var_4_0 = var_1_5

					var_0.AddMemory(var_4_0, var_1_1)

					local var_4_1 = var_1_5

					var_0.AddMemoryBuyCnt(var_4_1)

					return
				end,
				[var_0_1.TYPE.POLAROID] = function()
					pg = var_3_10000

					local var_5_0 = var_3_10000.child_polaroid[var_1_1].group

					pg = var_1

					local var_5_1 = var_1.child_polaroid.get_id_list_by_group[var_5_0]

					ipairs = var_3_10002

					for iter_5_0, iter_5_1 in var_3_10002(var_5_1) do
						local var_5_2 = var_1_5

						var_7.AddPolaroid(var_5_2, iter_5_1)
					end

					local var_5_3 = var_1_5

					var_2.AddPolaroidBuyCnt(var_5_3)

					return
				end
			})

			pg = var_2_3

			local var_2_2 = var_2_3.TipsMgr.GetInstance()

			var_2_3 = var_2_3.ShowTips
			i18n = var_2_10004

			var_2_3(var_2_2, var_2_10004("child_buy_collect_success"))

			local var_2_4 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_2_10004

			var_2_3(var_2_4, var_2_10004.EDUCATE_BUY_COLLECT_DONE)
		else
			pg = var_2_3

			local var_2_5 = var_2_3.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_6(var_2_5, var_2_10004("educate buy collect error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
