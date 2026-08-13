class = var_0_10000

local var_0_0 = "IslandAccessOpCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1
	local var_1_2 = {}

	getProxy = var_1_10005
	IslandProxy = var_1_10006

	local var_1_3 = var_1_10005(var_1_10006)
	local var_1_4 = var_5.GetIsland(var_1_3)
	local var_1_5 = var_5.GetAccessAgency(var_1_4)
	local var_1_6 = var_1_0.op

	IslandConst = var_1_10007

	local var_1_7

	if var_1_6 == var_1_10007.ACCESS_OP_ADD_WHITELIST then
		IslandConst = var_1_6
		var_1_1 = var_1_6.ACCESS_OP_SET_WHITELIST
		var_1_7 = arg_1_0
		var_1_2 = arg_1_0.AddWhiteList(var_1_7, var_1_5, var_1_0.list)
	else
		var_1_6 = var_1_0.op
		IslandConst = var_1_7

		local var_1_8

		if var_1_6 == var_1_7.ACCESS_OP_DEL_WHITELIST then
			IslandConst = var_1_6
			var_1_1 = var_1_6.ACCESS_OP_SET_WHITELIST
			var_1_8 = arg_1_0
			var_1_2 = arg_1_0.RemoveWhiteList(var_1_8, var_1_5, var_1_0.list)
		else
			var_1_6 = var_1_0.op
			IslandConst = var_1_8

			local var_1_9

			if var_1_6 == var_1_8.ACCESS_OP_ADD_BLACKLIST then
				IslandConst = var_1_6
				var_1_1 = var_1_6.ACCESS_OP_KICKANDBLACKLIST
				var_1_9 = arg_1_0
				var_1_2 = arg_1_0.AddBlackList(var_1_9, var_1_5, var_1_0.list)
			else
				var_1_6 = var_1_0.op
				IslandConst = var_1_9

				if var_1_6 == var_1_9.ACCESS_OP_DEL_BLACKLIST then
					IslandConst = var_1_6
					var_1_1 = var_1_6.ACCESS_OP_SET_BLACKLIST
					var_1_2 = arg_1_0:RemoveBlackList(var_1_5, var_1_0.list)
				else
					var_1_1 = var_1_0.op
					var_1_2 = var_1_0.list
				end
			end
		end
	end

	assert = var_1_6

	var_1_6(var_1_1 and var_1_2, "op or list is nil")

	pg = var_1_6

	local var_1_10 = var_1_6.island_set.whit_list_max_cnt.key_value_int

	IslandConst = var_7

	local var_1_12

	if var_1_1 == var_7.ACCESS_OP_SET_WHITELIST then
		if var_1_10 < #var_1_2 then
			pg = var_1_12

			local var_1_11 = var_1_12.TipsMgr.GetInstance()

			var_1_12 = var_1_12.ShowTips
			i18n = var_1_10009

			var_1_12(var_1_11, var_1_10009("island_white_list_full"))

			return
		end
	else
		IslandConst = var_1_12

		if var_1_1 == var_1_12.ACCESS_OP_SET_BLACKLIST then
			if var_1_10 < #var_1_2 then
				pg = var_1_12

				local var_1_13 = var_1_12.TipsMgr.GetInstance()

				var_1_12 = var_1_12.ShowTips
				i18n = var_1_10009

				var_1_12(var_1_13, var_1_10009("island_black_list_full"))

				return
			end
		else
			IslandConst = var_1_12

			if var_1_1 == var_1_12.ACCESS_OP_KICKANDBLACKLIST and var_1_10 < #var_1_2 then
				pg = var_1_12

				local var_1_14 = var_1_12.TipsMgr.GetInstance()

				var_1_12 = var_1_12.ShowTips
				i18n = var_1_10009

				var_1_12(var_1_14, var_1_10009("island_black_list_full"))

				IslandConst = var_1_12
				var_1_1 = var_1_12.ACCESS_OP_KICK
			end
		end
	end

	seriesAsync = var_1_12

	var_1_12({
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.Send(var_2_0, var_1_5, var_1_1, var_1_2, arg_2_0)

			return
		end,
		function(arg_3_0)
			local var_3_0 = arg_1_0
			local var_3_1, var_3_2, var_3_3 = var_1.CheckReSend(var_3_0, var_1_5, var_1_1, var_1_2)

			if not var_3_1 then
				arg_3_0()

				return
			end

			local var_3_4 = arg_1_0

			var_4.Send(var_3_4, var_1_5, var_3_2, var_3_3, arg_3_0)

			return
		end
	}, function()
		local var_4_0 = arg_1_0
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		var_4_1(var_4_0, var_2_10002.ISLAND_ACCESS_OP_DONE, {
			op = var_1_1,
			clientOp = var_1_0.op
		})

		return
	end)

	return
end

function var_0_1.CheckReSend(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = false
	local var_5_1
	local var_5_2 = {}

	IslandConst = var_1_10007

	local var_5_4

	if arg_5_2 == var_1_10007.ACCESS_OP_SET_WHITELIST then
		local var_5_3 = arg_5_1

		var_5_4 = arg_5_1.GetBlackList(var_5_3)
		ipairs = var_5_3

		for iter_5_0, iter_5_1 in var_5_3(var_5_4) do
			table = var_1_10013

			if var_1_10013.contains(arg_5_3, iter_5_1) then
				var_5_0 = true
				IslandConst = var_1_10013
				var_5_1 = var_1_10013.ACCESS_OP_SET_BLACKLIST
			else
				table = var_1_10013

				var_1_10013.insert(var_5_2, iter_5_1)
			end
		end

		goto label_5_0
	end

	IslandConst = var_5_4

	if arg_5_2 ~= var_5_4.ACCESS_OP_SET_BLACKLIST then
		IslandConst = var_7

		if arg_5_2 == var_7.ACCESS_OP_KICKANDBLACKLIST then
			local var_5_5 = arg_5_1
			local var_5_6 = arg_5_1.GetWhiteList(var_5_5)

			ipairs = var_5_5

			for iter_5_2, iter_5_3 in var_5_5(var_5_6) do
				table = var_1_10013

				if var_1_10013.contains(arg_5_3, iter_5_3) then
					var_5_0 = true
					IslandConst = var_1_10013
					var_5_1 = var_1_10013.ACCESS_OP_SET_WHITELIST
				else
					table = var_1_10013

					var_1_10013.insert(var_5_2, iter_5_3)
				end
			end
		end

		::label_5_0::

		return var_5_0, var_5_1, var_5_2
	end
end

function var_0_1.Send(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	pg = var_1_10005

	local var_6_0 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_6_0, 21302, {
		cmd = arg_6_2,
		user_id_list = arg_6_3
	}, 21303, function(arg_7_0)
		local var_7_0

		if arg_7_0.result == 0 then
			var_7_0 = arg_6_2
			IslandConst = var_2_10002

			local var_7_1

			if var_7_0 == var_2_10002.ACCESS_OP_SET_WHITELIST then
				var_7_1 = arg_6_1

				var_7_0.SetWhiteList(var_7_1, arg_6_3)
			else
				var_7_0 = arg_6_2
				IslandConst = var_7_1

				local var_7_2

				if var_7_0 == var_7_1.ACCESS_OP_SET_BLACKLIST then
					var_7_2 = arg_6_1

					var_7_0.SetBlackList(var_7_2, arg_6_3)
				else
					var_7_0 = arg_6_2
					IslandConst = var_7_2

					if var_7_0 == var_7_2.ACCESS_OP_KICK then
						-- block empty
					else
						var_7_0 = arg_6_2
						IslandConst = var_2

						if var_7_0 == var_2.ACCESS_OP_KICKANDBLACKLIST then
							local var_7_3 = arg_6_1

							var_7_0.AddBlackList(var_7_3, arg_6_3)
						end
					end
				end
			end

			arg_6_4()

			pg = var_7_0

			local var_7_4 = var_7_0.TipsMgr.GetInstance()

			var_7_0 = var_7_0.ShowTips
			i18n = var_2_10003

			var_7_0(var_7_4, var_2_10003("island_visit_tip6"))
		else
			pg = var_7_0

			local var_7_5 = var_7_0.TipsMgr.GetInstance()
			local var_7_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_7_6(var_7_5, var_2_10003[arg_7_0.result] .. arg_7_0.ret)
		end

		return
	end)

	return
end

function var_0_1.AddWhiteList(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}

	ipairs = var_1_10004

	for iter_8_0, iter_8_1 in var_1_10004(arg_8_1:GetWhiteList()) do
		table = var_1_10009

		var_1_10009.insert(var_8_0, iter_8_1)
	end

	ipairs = var_4

	for iter_8_2, iter_8_3 in var_4(arg_8_2) do
		table = var_1_10009

		if not var_1_10009.contains(var_8_0, iter_8_3) then
			table = var_1_10009

			var_1_10009.insert(var_8_0, iter_8_3)
		end
	end

	return var_8_0
end

function var_0_1.RemoveWhiteList(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}

	ipairs = var_1_10004

	for iter_9_0, iter_9_1 in var_1_10004(arg_9_1:GetWhiteList()) do
		table = var_1_10009

		var_1_10009.insert(var_9_0, iter_9_1)
	end

	for iter_9_2 = #var_9_0, 1, -1 do
		local var_9_1 = var_9_0[iter_9_2]

		table = var_1_10009

		if var_1_10009.contains(arg_9_2, var_9_1) then
			table = var_1_10009

			var_1_10009.remove(var_9_0, iter_9_2)
		end
	end

	return var_9_0
end

function var_0_1.AddBlackList(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = {}

	ipairs = var_1_10004

	for iter_10_0, iter_10_1 in var_1_10004(arg_10_1:GetBlackList()) do
		table = var_1_10009

		var_1_10009.insert(var_10_0, iter_10_1)
	end

	ipairs = var_4

	for iter_10_2, iter_10_3 in var_4(arg_10_2) do
		table = var_1_10009

		if not var_1_10009.contains(var_10_0, iter_10_3) then
			table = var_1_10009

			var_1_10009.insert(var_10_0, iter_10_3)
		end
	end

	return var_10_0
end

function var_0_1.RemoveBlackList(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}

	ipairs = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10004(arg_11_1:GetBlackList()) do
		table = var_1_10009

		var_1_10009.insert(var_11_0, iter_11_1)
	end

	for iter_11_2 = #var_11_0, 1, -1 do
		local var_11_1 = var_11_0[iter_11_2]

		table = var_1_10009

		if var_1_10009.contains(arg_11_2, var_11_1) then
			table = var_1_10009

			var_1_10009.remove(var_11_0, iter_11_2)
		end
	end

	return var_11_0
end

return var_0_1
