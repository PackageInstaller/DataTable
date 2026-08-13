class = var_0_10000

local var_0_0 = "AccountSearchCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = var_2.update

	getProxy = var_1_10005
	UserProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getData(var_1_2)

	getProxy = var_1_2
	ServerProxy = var_1_10008

	local var_1_4 = var_1_2(var_1_10008).data
	local var_1_5 = {}
	local var_1_6 = false

	pairs = var_1_10010

	for iter_1_0, iter_1_1 in var_1_10010(var_1_4) do
		table = var_1_10015

		var_1_10015.insert(var_1_5, function(arg_2_0)
			local var_2_0 = iter_1_1
			local var_2_1 = var_1.getHost(var_2_0)
			local var_2_2 = iter_1_1
			local var_2_3 = var_2.getPort(var_2_2)
			local var_2_4

			pg = var_2_10004

			local var_2_5 = var_2_10004.SimpleConnectionMgr.GetInstance()

			var_4.Disconnect(var_2_5)

			pg = var_4

			local var_2_6 = var_4.SimpleConnectionMgr.GetInstance()

			var_4.SetErrorCB(var_2_6, function()
				if not var_2_4 then
					var_1_6 = true

					var_1_1({
						isFail = true,
						id = iter_1_1.id
					})
					arg_2_0()
				end

				return
			end)

			pg = var_4

			local var_2_7 = var_4.SimpleConnectionMgr.GetInstance()

			var_4.Connect(var_2_7, var_2_1, var_2_3, function()
				pg = var_3_10000

				local var_4_0 = var_3_10000.SimpleConnectionMgr.GetInstance()

				var_0.Send(var_4_0, 10026, {
					account_id = var_1_3.uid
				}, 10027, function(arg_5_0)
					if arg_5_0.user_id and arg_5_0.user_id ~= 0 and arg_5_0.level and arg_5_0.level > 0 then
						var_1_1({
							id = iter_1_1.id,
							user_id = arg_5_0.user_id,
							level = arg_5_0.level
						})
					else
						var_1_1({
							id = iter_1_1.id
						})
					end

					var_2_4 = iter_1_1.id

					arg_2_0()

					return
				end, nil, 0.5)

				return
			end, 0.5)

			return
		end)
	end

	seriesAsync = var_10

	var_10(var_1_5, function()
		var_1_0()

		if var_1_6 then
			pg = var_0

			local var_6_0 = var_0.TipsMgr.GetInstance()
			local var_6_1 = var_0.ShowTips

			i18n = var_2_10002

			var_6_1(var_6_0, var_2_10002("query_role_fail_and_retry"))
		end

		return
	end)

	return
end

return var_0_1
