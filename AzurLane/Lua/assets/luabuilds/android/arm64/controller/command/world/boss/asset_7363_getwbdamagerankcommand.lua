class = var_0_10000

local var_0_0 = "GetWBDamageRankCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().bossId
	local var_1_1 = var_2.callback

	if not var_1_0 or var_1_0 == 0 then
		if var_1_1 then
			var_1_1()
		end

		return
	end

	getProxy = var_1_10005
	PlayerProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3 = var_5.getRawData(var_1_2).id

	pg = var_1_10006

	local var_1_4 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_4, 34505, {
		boss_id = var_1_0
	}, 34506, function(arg_2_0)
		local var_2_0 = {}

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.rank_list) do
			table = var_2_10007

			var_2_10007.insert(var_2_0, {
				id = iter_2_1.id,
				name = iter_2_1.name,
				damage = iter_2_1.damage,
				isSelf = var_1_3 == iter_2_1.id
			})
		end

		table = var_2

		var_2.sort(var_2_0, function(arg_3_0, arg_3_1)
			return arg_3_0.damage > arg_3_1.damage
		end)

		nowWorld = var_2

		local var_2_1 = var_2()
		local var_2_2 = var_2.GetBossProxy(var_2_1)

		var_3.SetRank(var_2_2, var_1_0, var_2_0)

		if var_1_1 then
			var_1_1(#var_2_0)
		end

		local var_2_3 = arg_1_0
		local var_2_4 = var_4.sendNotification

		GAME = var_7

		var_2_4(var_2_3, var_7.WORLD_GET_BOSS_RANK_DONE, {
			bossId = var_1_0
		})

		return
	end)

	return
end

return var_0_1
