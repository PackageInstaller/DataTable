class = var_0_10000

local var_0_0 = "ActivityManualSignCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().activity_id

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)

	if var_4.getActivityById(var_1_1, var_1_0) then
		local var_1_2 = var_4

		if var_4.isEnd(var_1_2) then
			pg = var_1_1
			var_1_2 = var_1_1.TipsMgr.GetInstance()

			local var_1_3 = var_5.ShowTips

			i18n = var_1_10007

			var_1_3(var_1_2, var_1_10007("common_activity_end"))

			return
		end

		local var_1_4 = var_2.cmd

		ManualSignActivity = var_1_2

		if var_1_4 == var_1_2.OP_GET_AWARD and not var_4:AnyAwardCanGet() then
			pg = var_5

			local var_1_5 = var_5.TipsMgr.GetInstance()
			local var_1_6 = var_5.ShowTips

			i18n = var_1_10007

			var_1_6(var_1_5, var_1_10007("common_error") .. "1")

			return
		end

		local var_1_7 = {}
		local var_1_8 = var_2.cmd

		ManualSignActivity = var_1_10007

		if var_1_8 == var_1_10007.OP_GET_AWARD then
			var_1_7 = var_4:GetCanGetAwardIndexList()
		end

		pg = var_1_8

		local var_1_9 = var_1_8.ConnectionMgr.GetInstance()

		var_6.Send(var_1_9, 11202, {
			activity_id = var_1_0,
			cmd = var_2.cmd,
			arg1 = var_2.arg1,
			arg2 = var_2.arg2,
			arg_list = var_1_7,
			kvargs1 = var_2.kvargs1
		}, 11203, function(arg_2_0)
			local var_2_0

			if arg_2_0.result == 0 then
				PlayerConst = var_2_0
				var_2_0 = var_2_0.GetTranAwards(var_0, arg_2_0)

				local var_2_1 = var_0.cmd

				ManualSignActivity = var_2_10003

				if var_2_1 == var_2_10003.OP_SIGN then
					var_2_10003 = arg_1_0

					var_2.HandleSign(var_2_10003, var_1_0)
				else
					local var_2_2 = var_0.cmd

					ManualSignActivity = var_2_10003

					if var_2_2 == var_2_10003.OP_GET_AWARD then
						var_2_10003 = arg_1_0

						var_2.HandleGetAward(var_2_10003, var_1_0)
					end
				end

				var_2_10003 = arg_1_0

				local var_2_3 = var_2.sendNotification

				GAME = var_2_10004

				var_2_3(var_2_10003, var_2_10004.ACT_MANUAL_SIGN_DONE, {
					awards = var_2_0,
					id = var_1_0
				})
			else
				pg = var_2_0

				local var_2_4 = var_2_0.TipsMgr.GetInstance()
				local var_2_5 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10003

				var_2_5(var_2_4, var_2_10003[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)

		return
	end
end

function var_0_1.HandleSign(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_3_0 = var_1_10002(var_1_10003)
	local var_3_1 = var_2.getActivityById(var_3_0, arg_3_1)

	var_3.Signed(var_3_1)
	var_2:updateActivity(var_3)

	return
end

function var_0_1.HandleGetAward(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)
	local var_4_1 = var_2.getActivityById(var_4_0, arg_4_1)

	var_3.GetAllAwards(var_4_1)
	var_2:updateActivity(var_3)

	return
end

return var_0_1
