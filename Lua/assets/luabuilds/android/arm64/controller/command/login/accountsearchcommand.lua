local var_0_0 = class("AccountSearchCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = var_1_0.update
	local var_1_3 = getProxy(UserProxy):getData()
	local var_1_4 = false

	for iter_1_0, iter_1_1 in pairs(getProxy(ServerProxy).data) do
		table.insert({}, function(arg_2_0)
			local var_2_0

			pg.SimpleConnectionMgr.GetInstance():Disconnect()
			pg.SimpleConnectionMgr.GetInstance():SetErrorCB(function()
				if not var_2_0 then
					var_1_4 = true

					var_1_2({
						isFail = true,
						id = iter_1_1.id
					})
					arg_2_0()
				end

				return
			end)
			pg.SimpleConnectionMgr.GetInstance():Connect(iter_1_1:getHost(), iter_1_1:getPort(), function()
				pg.SimpleConnectionMgr.GetInstance():Send(10026, {
					account_id = var_1_3.uid
				}, 10027, function(arg_5_0)
					if arg_5_0.user_id and arg_5_0.user_id ~= 0 and arg_5_0.level and arg_5_0.level > 0 then
						var_1_2({
							id = iter_1_1.id,
							user_id = arg_5_0.user_id,
							level = arg_5_0.level
						})
					else
						var_1_2({
							id = iter_1_1.id
						})
					end

					var_2_0 = iter_1_1.id

					arg_2_0()

					return
				end, nil, 0.5)

				return
			end, 0.5)

			return
		end)
	end

	seriesAsync({}, function()
		var_1_1()

		if var_1_4 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("query_role_fail_and_retry"))
		end

		return
	end)

	return
end

return var_0_0
