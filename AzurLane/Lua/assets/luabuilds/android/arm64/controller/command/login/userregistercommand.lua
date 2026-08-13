class = var_0_10000

local var_0_0 = "UserRegisterCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	assert = var_1_10003
	isa = var_1_10005

	local var_1_1 = var_1_0

	User = var_1_10008

	var_1_10003(var_1_10005(var_1_1, var_1_10008), "should be an instance of User")

	if var_1_0.type ~= 2 then
		originalPrint = var_3

		var_3("用户类型错误")

		return
	end

	originalPrint = var_3

	local var_1_2 = "connect to gateway - "

	NetConst = var_6

	local var_1_3 = var_6.GATEWAY_HOST
	local var_1_4 = ":"

	NetConst = var_1_10008

	var_3(var_1_2 .. var_1_3 .. var_1_4 .. var_1_10008.GATEWAY_PORT)

	pg = var_3

	local var_1_5 = var_3.ConnectionMgr.GetInstance()
	local var_1_6 = var_3.Connect

	NetConst = var_1_3

	local var_1_7 = var_1_3.GATEWAY_HOST

	NetConst = var_1_4

	var_1_6(var_1_5, var_1_7, var_1_4.GATEWAY_PORT, function()
		pg = var_2_10000

		local var_2_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_2_0, 10001, {
			account = var_1_0.arg1,
			password = var_1_0.arg2,
			mail_box = var_1_0.arg3
		}, 10002, function(arg_3_0)
			originalPrint = var_3_10001

			var_3_10001("disconnect from gateway...")

			pg = var_3_10001

			local var_3_0 = var_3_10001.ConnectionMgr.GetInstance()

			var_1.Disconnect(var_3_0)

			if arg_3_0.result == 0 then
				local var_3_1 = arg_1_0.facade
				local var_3_2 = var_1.sendNotification

				GAME = var_3_10004

				var_3_2(var_3_1, var_3_10004.USER_REGISTER_SUCCESS, var_1_0)
			else
				local var_3_3 = arg_1_0.facade
				local var_3_4 = var_1.sendNotification

				GAME = var_3_10004

				var_3_4(var_3_3, var_3_10004.USER_REGISTER_FAILED, arg_3_0.result)
			end

			return
		end, false)

		return
	end)

	return
end

return var_0_1
