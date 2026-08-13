class = var_0_10000

local var_0_0 = "UserRegisterCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	assert = var_1_0
	isa = var_1_10004

	local var_1_2 = var_1_1

	User = var_1_10006

	var_1_0(var_1_10004(var_1_2, var_1_10006), "should be an instance of User")

	if var_1_1.type ~= 2 then
		originalPrint = var_3

		var_3("用户类型错误")

		return
	end

	originalPrint = var_3

	local var_1_3 = "connect to gateway - "

	NetConst = var_5

	local var_1_4 = var_5.GATEWAY_HOST
	local var_1_5 = ":"

	NetConst = var_1_10007

	var_3(var_1_3 .. var_1_4 .. var_1_5 .. var_1_10007.GATEWAY_PORT)

	pg = var_3

	local var_1_6 = var_3.ConnectionMgr.GetInstance()
	local var_1_7 = var_3.Connect

	NetConst = var_1_4

	local var_1_8 = var_1_4.GATEWAY_HOST

	NetConst = var_1_5

	var_1_7(var_1_6, var_1_8, var_1_5.GATEWAY_PORT, function()
		pg = var_2_10000

		local var_2_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_2_0, 10001, {
			account = var_1_1.arg1,
			password = var_1_1.arg2,
			mail_box = var_1_1.arg3
		}, 10002, function(arg_3_0)
			originalPrint = var_3_10001

			var_3_10001("disconnect from gateway...")

			pg = var_3_10001

			local var_3_0 = var_3_10001.ConnectionMgr.GetInstance()

			var_1.Disconnect(var_3_0)

			if arg_3_0.result == 0 then
				local var_3_1 = arg_1_0.facade
				local var_3_2 = var_1.sendNotification

				GAME = var_3_10003

				var_3_2(var_3_1, var_3_10003.USER_REGISTER_SUCCESS, var_1_1)
			else
				local var_3_3 = arg_1_0.facade
				local var_3_4 = var_1.sendNotification

				GAME = var_3_10003

				var_3_4(var_3_3, var_3_10003.USER_REGISTER_FAILED, arg_3_0.result)
			end

			return
		end, false)

		return
	end)

	return
end

return var_0_1
