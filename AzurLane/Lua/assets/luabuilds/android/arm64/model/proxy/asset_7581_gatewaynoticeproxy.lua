class = var_0_10000

local var_0_0 = "GatewayNoticeProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0.data = {}

	return
end

function var_0_1.getGatewayNotices(arg_2_0, arg_2_1)
	local var_2_0 = {}

	ipairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(arg_2_0.data) do
		if not arg_2_1 or not iter_2_1.isRead then
			table = var_1_10008

			var_1_10008.insert(var_2_0, iter_2_1)
		end
	end

	return var_2_0
end

function var_0_1.setGatewayNotices(arg_3_0, arg_3_1)
	arg_3_0.data = {}
	ipairs = var_2

	for iter_3_0, iter_3_1 in var_2(arg_3_1) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_3_0 = arg_3_0.data

		GatewayNotice = var_1_10010

		var_1_10007(var_3_0, var_1_10010.New(iter_3_1))
	end

	return
end

return var_0_1
