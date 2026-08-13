class = var_0_10000

local var_0_0 = "MetaCharacterTacticsInfoRequestCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().idList
	local var_1_1 = ""

	ipairs = var_1_10005

	for iter_1_0, iter_1_1 in var_1_10005(var_1_0) do
		var_1_1 = var_1_1 .. iter_1_1 .. ", "
	end

	print = var_5

	var_5("63317 request tactics exp detail info:", var_1_1)

	pg = var_5

	local var_1_2 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 63317, {
		ship_id_list = var_1_0
	}, 63318, function(arg_2_0)
		print = var_2_10001

		var_2_10001("63318 requset success")

		getProxy = var_2_10001
		MetaCharacterProxy = var_2

		local var_2_0 = var_2_10001(var_2)

		if arg_2_0.info_list then
			ipairs = var_2_10003

			for iter_2_0, iter_2_1 in var_2_10003(var_2) do
				var_2_0:setMetaTacticsInfo(iter_2_1)
			end
		else
			errorMsg = var_2_10003

			var_2_10003("63318 error, data.info_list is null!")
		end

		return
	end)

	return
end

return var_0_1
