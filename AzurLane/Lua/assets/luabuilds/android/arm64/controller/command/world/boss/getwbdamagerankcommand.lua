local var_0_0 = class("GetWBDamageRankCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.bossId
	local var_1_2 = var_1_0.callback

	if not var_1_0.bossId or var_1_0.bossId == 0 then
		if var_1_0.callback then
			var_1_0.callback()
		end

		return
	end

	local var_1_3 = getProxy(PlayerProxy)
	local var_1_4 = var_1_3:getRawData().id

	pg.ConnectionMgr.GetInstance():Send(34505, {
		boss_id = var_1_0.bossId
	}, 34506, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.rank_list) do
			table.insert({}, {
				id = iter_2_1.id,
				name = iter_2_1.name,
				damage = iter_2_1.damage,
				isSelf = var_1_4 == iter_2_1.id
			})
		end

		table.sort({}, function(arg_3_0, arg_3_1)
			return arg_3_0.damage > arg_3_1.damage
		end)
		nowWorld():GetBossProxy():SetRank(var_1_1, {})

		if var_1_2 then
			var_1_2(#{})
		end

		arg_1_0:sendNotification(GAME.WORLD_GET_BOSS_RANK_DONE, {
			bossId = var_1_1
		})

		return
	end)

	return
end

return var_0_0
