class = var_0_10000

local var_0_0 = "CheckWorldBossStateCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().bossId
	local var_1_1 = var_2.callback

	tonumber = var_1_10005

	local var_1_2

	if not var_2.time then
		var_1_2 = 0
	end

	local var_1_3 = var_1_10005(var_1_2)
	local var_1_4 = var_2.failedCallback

	local function var_1_5()
		getProxy = var_2_10000
		ChatProxy = var_2_10001

		local var_2_0 = var_2_10000(var_2_10001)
		local var_2_1 = var_0.GetMessagesByUniqueId(var_2_0, var_1_0 .. "_" .. var_1_3)

		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(var_2_1) do
			iter_2_1.args.isDeath = true

			var_0:UpdateMsg(iter_2_1)
		end

		getProxy = var_2
		GuildProxy = var_3

		local var_2_2 = var_2(var_3)
		local var_2_3 = var_2.GetMessagesByUniqueId(var_2_2, var_1_0 .. "_" .. var_1_3)

		ipairs = var_2_2

		for iter_2_2, iter_2_3 in var_2_2(var_2_3) do
			iter_2_3.args.isDeath = true

			var_2:UpdateMsg(iter_2_3)
		end

		if var_1_4 then
			var_1_4()
		end

		return
	end

	print = var_1_10008

	var_1_10008("boss id", var_1_0, " time:", var_1_3)

	pg = var_1_10008

	local var_1_6 = var_1_10008.ConnectionMgr.GetInstance()

	var_8.Send(var_1_6, 34515, {
		boss_id = var_1_0,
		last_time = var_1_3
	}, 34516, function(arg_3_0)
		if arg_3_0.result == 0 then
			if var_1_1 then
				var_1_1()
			end
		elseif arg_3_0.result == 1 then
			var_1_5()

			pg = var_1

			local var_3_0 = var_1.TipsMgr.GetInstance()
			local var_3_1 = var_1.ShowTips

			i18n = var_2_10003

			var_3_1(var_3_0, var_2_10003("world_boss_none"))
		elseif arg_3_0.result == 3 then
			var_1_5()

			pg = var_1

			local var_3_2 = var_1.TipsMgr.GetInstance()
			local var_3_3 = var_1.ShowTips

			i18n = var_2_10003

			var_3_3(var_3_2, var_2_10003("world_boss_none"))
		elseif arg_3_0.result == 6 then
			var_1_5()

			pg = var_1

			local var_3_4 = var_1.TipsMgr.GetInstance()
			local var_3_5 = var_1.ShowTips

			i18n = var_2_10003

			var_3_5(var_3_4, var_2_10003("world_max_challenge_cnt"))
		else
			local var_3_7

			if arg_3_0.result == 20 then
				var_1_5()

				pg = var_3_7

				local var_3_6 = var_3_7.TipsMgr.GetInstance()

				var_3_7 = var_3_7.ShowTips
				i18n = var_2_10003

				var_3_7(var_3_6, var_2_10003("world_boss_none"))
			else
				pg = var_3_7

				local var_3_8 = var_3_7.TipsMgr.GetInstance()
				local var_3_9 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10003

				var_3_9(var_3_8, var_2_10003[arg_3_0.result] .. arg_3_0.result)
			end
		end

		return
	end)

	return
end

return var_0_1
