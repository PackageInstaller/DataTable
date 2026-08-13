class = var_0_10000

local var_0_0 = "PrayPoolBuildCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().pooltype
	local var_1_1 = var_2.shipIDList

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()
	local var_1_3 = var_5.Send
	local var_1_4 = 11202
	local var_1_5 = {
		cmd = 1
	}

	ActivityConst = var_1_10009
	var_1_5.activity_id = var_1_10009.ACTIVITY_PRAY_POOL
	var_1_5.arg1 = var_1_0
	var_1_5.arg2 = var_1_1[1]
	var_1_5.arg3 = var_1_1[2]
	var_1_5.arg_list = {}

	var_1_3(var_1_2, var_1_4, var_1_5, 11203, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			getProxy = var_2_1
			PrayProxy = var_2_10002

			local var_2_0 = var_2_1(var_2_10002)

			var_2_1 = var_2_1.updatePageState
			PrayProxy = var_2_10003

			var_2_1(var_2_0, var_2_10003.STAGE_BUILD_SUCCESS)

			local var_2_2 = arg_1_0

			var_2_1 = var_2_1.sendNotification
			PrayPoolConst = var_2_10003
			var_2_10003 = var_2_10003.BUILD_PRAY_POOL_SUCCESS
			PrayProxy = var_2_10004

			var_2_1(var_2_2, var_2_10003, var_2_10004.STAGE_BUILD_SUCCESS)

			pg = var_2_1

			local var_2_3 = var_2_1.TipsMgr.GetInstance()

			var_2_1 = var_2_1.ShowTips
			i18n = var_2_10003

			var_2_1(var_2_3, var_2_10003("tip_pray_build_pool_success"))
		else
			pg = var_2_1

			local var_2_4 = var_2_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			i18n = var_2_10003

			var_2_5(var_2_4, var_2_10003("tip_pray_build_pool_fail"))
		end

		return
	end)

	return
end

return var_0_1
