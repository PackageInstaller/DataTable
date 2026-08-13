class = var_0_10000

local var_0_0 = "QuickExchangeBlueprintCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	BagProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = {}

	pg = var_1_10005

	local var_1_4 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_4, 15012, {
		use_list = var_1_1
	}, 15013, function(arg_2_0)
		ipairs = var_2_10001

		for iter_2_0, iter_2_1 in var_2_10001(arg_2_0.ret_list) do
			local var_2_0

			if iter_2_1.result == 0 then
				var_2_0 = var_1_1[iter_2_0]
				var_2_10008 = var_1_2

				var_7.removeItemById(var_2_10008, var_2_0.id, var_2_0.count)

				table = var_7

				local var_2_1 = var_7.mergeArray

				var_2_10008 = var_1_3
				PlayerConst = var_9
				var_1_3 = var_2_1(var_2_10008, var_9.addTranDrop(iter_2_1.drop_list))
			else
				pg = var_2_0

				local var_2_2 = var_2_0.TipsMgr.GetInstance()
				local var_2_3 = var_6.ShowTips

				errorTip = var_2_10008

				var_2_3(var_2_2, var_2_10008("", arg_2_0.result))
			end
		end

		local var_2_4 = arg_1_0
		local var_2_5 = var_1.sendNotification

		GAME = var_3

		var_2_5(var_2_4, var_3.QUICK_EXCHANGE_BLUEPRINT_DONE, var_1_3)

		return
	end)

	return
end

return var_0_1
