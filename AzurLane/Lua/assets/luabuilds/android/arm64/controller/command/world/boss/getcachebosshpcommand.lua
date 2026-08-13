class = var_0_10000

local var_0_0 = "GetCacheBossHpCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).callback

	nowWorld = var_1_0

	local var_1_2 = var_1_0()
	local var_1_3 = var_4.GetBossProxy(var_1_2)

	if not var_5.GetCacheBossList(var_1_3) or #var_6 == 0 then
		if var_1_1 then
			var_1_1()
		end

		return
	end

	_ = var_1_2

	local var_1_4 = var_1_2.map(var_6, function(arg_2_0)
		return arg_2_0.id
	end)

	pg = var_1_3

	local var_1_5 = var_1_3.ConnectionMgr.GetInstance()

	var_8.Send(var_1_5, 34517, {
		boss_id = var_1_4
	}, 34518, function(arg_3_0)
		pairs = var_2_10001

		for iter_3_0, iter_3_1 in var_2_10001(arg_3_0.list) do
			local var_3_0 = var_0

			if var_6.GetCacheBoss(var_3_0, iter_3_1.id) then
				var_6:UpdateHp(iter_3_1.hp)
				var_6:SetRankCnt(iter_3_1.rank_count)
			end
		end

		if var_1_1 then
			var_1_1()
		end

		return
	end)

	return
end

return var_0_1
