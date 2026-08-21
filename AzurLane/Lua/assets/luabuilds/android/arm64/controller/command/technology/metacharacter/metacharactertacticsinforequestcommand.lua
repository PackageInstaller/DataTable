local var_0_0 = class("MetaCharacterTacticsInfoRequestCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().idList
	local var_1_1 = ""

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		var_1_1 = var_1_1 .. iter_1_1 .. ", "
	end

	print("63317 request tactics exp detail info:", var_1_1)
	pg.ConnectionMgr.GetInstance():Send(63317, {
		ship_id_list = var_1_0
	}, 63318, function(arg_2_0)
		print("63318 requset success")

		local var_2_0 = getProxy(MetaCharacterProxy)

		if arg_2_0.info_list then
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.info_list) do
				var_2_0:setMetaTacticsInfo(iter_2_1)
			end
		else
			errorMsg("63318 error, data.info_list is null!")
		end

		return
	end)

	return
end

return var_0_0
