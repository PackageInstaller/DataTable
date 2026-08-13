class = var_0_10000

local var_0_0 = "ChargeFailedCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().payId
	local var_1_1 = var_2.code

	if not var_1_0 then
		return
	end

	if var_1_1 then
		type = var_1_10005

		if var_1_10005(var_1_1) ~= "number" then
			return
		end

		pg = var_1_10005

		local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()
		local var_1_3 = var_5.Send
		local var_1_4 = 11510
		local var_1_5 = {}

		tostring = var_1_10010
		var_1_5.pay_id = var_1_10010(var_1_0)
		math = var_10
		var_1_5.code = var_10.abs(var_1_1)

		var_1_3(var_1_2, var_1_4, var_1_5)

		return
	end
end

return var_0_1
