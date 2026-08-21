local var_0_0 = class("ChargeFailedCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if not var_1_0.payId then
		return
	end

	if not var_1_0.code or type(var_1_0.code) ~= "number" then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(11510, {
		pay_id = tostring(var_1_0.payId),
		code = math.abs(var_1_0.code)
	})

	return
end

return var_0_0
