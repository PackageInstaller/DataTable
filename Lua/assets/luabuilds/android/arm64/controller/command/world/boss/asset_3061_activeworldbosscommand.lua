local ActiveWorldBossCommand = class("ActiveWorldBossCommand", pm.SimpleCommand)

function ActiveWorldBossCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.type

	pg.ConnectionMgr.GetInstance():Send(34521, {
		template_id = var_1_0.id
	}, 34522, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = nowWorld():GetBossProxy()

			var_2_0:RemoveSelfBoss()

			local var_2_1 = WorldBoss.New()

			var_2_1:Setup(arg_2_0.boss, getProxy(PlayerProxy):getData())
			var_2_1:UpdateBossType(WorldBoss.BOSS_TYPE_SELF)
			var_2_1:SetJoinTime(pg.TimeMgr.GetInstance():GetServerTime())

			if var_2_0.isSetup then
				var_2_0:ClearRank(var_2_1.id)
				var_2_0:UpdateCacheBoss(var_2_1)

				if var_1_1 == WorldBossConst.BOSS_TYPE_CURR then
					var_2_0:ConsumeSummonPt((WorldBossConst.GetCurrBossConsume()))
				elseif var_1_1 == WorldBossConst.BOSS_TYPE_ARCHIVES then
					var_2_0:ConsumeSummonPtOld((WorldBossConst.GetAchieveBossConsume()))
				end
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return ActiveWorldBossCommand
