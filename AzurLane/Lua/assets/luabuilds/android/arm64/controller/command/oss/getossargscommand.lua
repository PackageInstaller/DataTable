class = var_0_10000

local var_0_0 = "GetOSSArgsCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().mode
	local var_1_1 = var_2.callback

	if var_1_0 == 1 then
		var_1_10005 = var_1_1

		local var_1_2 = {}

		OSS_ENDPOINT = var_1_10008
		var_1_2[1] = var_1_10008
		OSS_STS_URL = var_1_10008
		var_1_2[2] = var_1_10008

		var_1_10005(var_1_2, 0)
	elseif var_1_0 == 2 then
		pg = var_1_10005

		local var_1_3 = var_1_10005.ConnectionMgr.GetInstance()

		var_5.Send(var_1_3, 19103, {
			typ = 0
		}, 19104, function(arg_2_0)
			local var_2_0

			if arg_2_0.result == 0 then
				var_2_0 = var_1_1

				local var_2_1 = {}

				OSS_ENDPOINT = var_2_10004
				var_2_1[1] = var_2_10004
				var_2_1[2] = arg_2_0.access_id
				var_2_1[3] = arg_2_0.access_secret
				var_2_1[4] = arg_2_0.security_token

				var_2_0(var_2_1, arg_2_0.expire_time)
			else
				pg = var_2_0

				local var_2_2 = var_2_0.TipsMgr.GetInstance()
				local var_2_3 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_2_3(var_2_2, var_2_10004[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)
	end

	return
end

return var_0_1
