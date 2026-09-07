local GetCacheBossHpCommand = class("GetCacheBossHpCommand", pm.SimpleCommand)

function GetCacheBossHpCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = nowWorld():GetBossProxy()
	local var_1_2 = var_1_1:GetCacheBossList()
	local var_1_3

	if not var_1_2 or #var_1_2 == 0 then
		if var_1_0 then
			var_1_0()
		end

		do return end

		var_1_3 = {}
	end

	var_1_3.boss_id = _.map(var_1_2, function(arg_2_0)
		return arg_2_0.id
	end)

	pg.ConnectionMgr.GetInstance():Send(34517, var_1_3, 34518, function(arg_3_0)
		for iter_3_0, iter_3_1 in pairs(arg_3_0.list) do
			local var_3_0 = var_1_1:GetCacheBoss(iter_3_1.id)

			if var_3_0 then
				var_3_0:UpdateHp(iter_3_1.hp)
				var_3_0:SetRankCnt(iter_3_1.rank_count)
			end
		end

		if var_1_0 then
			var_1_0()
		end

		return
	end)

	return
end

return GetCacheBossHpCommand
