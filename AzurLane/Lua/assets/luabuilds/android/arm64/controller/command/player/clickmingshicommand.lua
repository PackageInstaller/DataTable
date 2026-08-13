class = var_0_10000

local var_0_0 = "ClickMingShiCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	var_4.mingshiCount = var_3.getData(var_1_1).mingshiCount + 1
	getProxy = var_5
	ActivityProxy = var_1_10007

	local var_1_2 = var_5(var_1_10007)
	local var_1_3 = var_5.getActivityById

	mingshiActivityId = var_1_10008

	if var_1_3(var_1_2, var_1_10008) then
		local var_1_4 = var_5

		if not var_5.isEnd(var_1_4) then
			LOCK_CLICK_MINGSHI = var_6

			if not var_6 then
				getProxy = var_6
				TaskProxy = var_1_4

				local var_1_5 = var_6(var_1_4)

				if var_6.getmingshiTaskID(var_1_5, var_4.mingshiCount) > 0 then
					local var_1_6 = arg_1_0
					local var_1_7 = arg_1_0.sendNotification

					GAME = var_1_10010

					local var_1_8 = var_1_10010.ACTIVITY_OPERATION
					local var_1_9 = {
						cmd = 1
					}

					mingshiActivityId = var_1_10012
					var_1_9.activity_id = var_1_10012

					var_1_7(var_1_6, var_1_8, var_1_9)
				end
			end
		end
	end

	if var_4.mingshiflag >= 2 then
		var_3:updatePlayer(var_4)

		return
	end

	pg = var_6

	local var_1_10 = var_6.ConnectionMgr.GetInstance()

	var_6.Send(var_1_10, 11506, {
		state = 0
	}, 11507, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_0.chargeExp = var_0.chargeExp + 5
			var_0.mingshiflag = var_0.mingshiflag + 1

			local var_2_0 = arg_1_0
			local var_2_1 = var_1.sendNotification

			GAME = var_2_10004

			var_2_1(var_2_0, var_2_10004.CLICK_MING_SHI_SUCCESS)
		else
			var_0.mingshiflag = 2
		end

		local var_2_2 = var_0

		var_1.updatePlayer(var_2_2, var_0)

		return
	end)

	return
end

return var_0_1
