class = var_0_10000

local var_0_0 = "MusicUnlockCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().musicID
	local var_1_1 = var_2.unlockCBFunc

	getProxy = var_1_10005
	AppreciateProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	getProxy = var_1_10006
	BagProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)

	getProxy = var_1_10007
	PlayerProxy = var_1_10009

	local var_1_4 = var_1_10007(var_1_10009)
	local var_1_5 = var_7.getData(var_1_4)
	local var_1_6 = var_1_2:getMusicUnlockMaterialByID(var_1_0)

	pairs = var_1_4

	for iter_1_0, iter_1_1 in var_1_4(var_1_6) do
		local var_1_7 = iter_1_1.type

		DROP_TYPE_RESOURCE = var_1_10016

		if var_1_7 == var_1_10016 then
			if var_1_5:getResById(iter_1_1.id) < iter_1_1.count then
				pg = var_15

				local var_1_8 = var_15.TipsMgr.GetInstance()
				local var_1_9 = var_15.ShowTips

				i18n = var_18

				var_1_9(var_1_8, var_18("common_no_resource"))

				return
			end
		else
			local var_1_10 = iter_1_1.type

			DROP_TYPE_ITEM = var_1_10016

			if var_1_10 == var_1_10016 and var_1_3:getItemCountById(iter_1_1.id) < iter_1_1.count then
				pg = var_15

				local var_1_11 = var_15.TipsMgr.GetInstance()
				local var_1_12 = var_15.ShowTips

				i18n = var_18

				var_1_12(var_1_11, var_18("common_no_item_1"))

				return
			end
		end
	end

	pg = var_10

	local var_1_13 = var_10.ConnectionMgr.GetInstance()

	var_10.Send(var_1_13, 17503, {
		id = var_1_0
	}, 17504, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2

			var_2_2.addMusicIDToUnlockList(var_2_0, var_1_0)

			local var_2_1 = var_1_2

			var_2_2 = var_2_2.getMusicUnlockMaterialByID(var_2_1, var_1_0)
			pairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(var_2_2) do
				local var_2_3 = iter_2_1.type

				DROP_TYPE_RESOURCE = var_2_10008

				if var_2_3 == var_2_10008 then
					local var_2_4 = var_1_5
					local var_2_5 = var_7.consume
					local var_2_6 = {}

					id2res = var_2_10011
					var_2_6[var_2_10011(iter_2_1.id)] = iter_2_1.count

					var_2_5(var_2_4, var_2_6)

					local var_2_7 = var_0

					var_7.updatePlayer(var_2_7, var_1_5)
				else
					local var_2_8 = iter_2_1.type

					DROP_TYPE_ITEM = var_2_10008

					if var_2_8 == var_2_10008 then
						local var_2_9 = var_1_3

						var_7.removeItemById(var_2_9, iter_2_1.id, iter_2_1.count)
					end
				end
			end

			if var_1_1 then
				var_1_1()
			end
		else
			pg = var_2_2

			local var_2_10 = var_2_2.TipsMgr.GetInstance()
			local var_2_11 = var_1.ShowTips
			local var_2_12 = "UnLock Fail, Code:"

			tostring = iter_2_0

			var_2_11(var_2_10, var_2_12 .. iter_2_0(arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
