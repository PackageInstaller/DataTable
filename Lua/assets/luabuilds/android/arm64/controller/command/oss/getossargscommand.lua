local var_0_0 = class("GetOSSArgsCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	if var_1_0.mode == 1 then
		var_1_0.callback({
			OSS_ENDPOINT,
			OSS_STS_URL
		}, 0)
	elseif var_1_0.mode == 2 then
		pg.ConnectionMgr.GetInstance():Send(19103, {
			typ = 0
		}, 19104, function(arg_2_0)
			if arg_2_0.result == 0 then
				var_1_1({
					OSS_ENDPOINT,
					arg_2_0.access_id,
					arg_2_0.access_secret,
					arg_2_0.security_token
				}, arg_2_0.expire_time)
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)
	end

	return
end

return var_0_0
