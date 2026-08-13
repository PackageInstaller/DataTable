class = var_0_10000

local var_0_0 = "ExtendStoreCapacityCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().isDiamond
	local var_1_1 = {}

	getProxy = var_1_10005
	PlayerProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getRawData(var_1_2)

	var_1_1[1] = var_5.GetExtendStoreCost(var_1_3)

	local var_1_6

	if not var_1_1[var_1_0 and 1 or 2] then
		pg = var_1_6

		local var_1_4 = var_1_6.TipsMgr.GetInstance()

		var_1_6.ShowTips(var_1_4, "level max")

		return
	elseif var_4:getOwnedCount() < var_4.count then
		pg = var_1_6

		local var_1_5 = var_1_6.TipsMgr.GetInstance()

		var_1_6 = var_1_6.ShowTips
		i18n = var_1_10007

		var_1_6(var_1_5, var_1_10007("common_no_x", var_4:getName()))

		return
	end

	pg = var_1_6

	local var_1_7 = var_1_6.ConnectionMgr.GetInstance()

	var_5.Send(var_1_7, 30010, {
		arg = var_4.id
	}, 30011, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			PlayerProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_2_10003 = var_1.getData(var_2_0)

			local var_2_1 = var_1.consume
			local var_2_2 = {}

			id2res = var_2_10005
			var_2_2[var_2_10005(var_0.id)] = var_0.count

			var_2_1(var_2_10003, var_2_2)

			var_1.mailStoreLevel = var_1.mailStoreLevel + 1
			getProxy = var_2
			PlayerProxy = var_2_10003
			var_2_10003 = var_2(var_2_10003)

			var_2.updatePlayer(var_2_10003, var_1)

			var_2_10003 = arg_1_0

			local var_2_3 = var_2.sendNotification

			GAME = var_4

			var_2_3(var_2_10003, var_4.EXTEND_STORE_CAPACITY_DONE)
		else
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_5(var_2_4, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
