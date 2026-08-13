class = var_0_10000

local var_0_0 = "ActiveWorldBossCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.type

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 34521, {
		template_id = var_1_0
	}, 34522, function(arg_2_0)
		if arg_2_0.result == 0 then
			nowWorld = var_1

			local var_2_0 = var_1()

			var_2_10003 = var_1.GetBossProxy(var_2_0)

			var_1.RemoveSelfBoss(var_2_10003)

			WorldBoss = var_2

			local var_2_1 = var_2.New()

			var_2_10003 = var_2.Setup

			local var_2_2 = arg_2_0.boss

			getProxy = var_2_10006
			PlayerProxy = var_2_10007

			local var_2_3 = var_2_10006(var_2_10007)

			var_2_10003(var_2_1, var_2_2, var_6.getData(var_2_3))

			local var_2_4 = var_2

			var_2_10003 = var_2.UpdateBossType
			WorldBoss = var_2_2

			var_2_10003(var_2_4, var_2_2.BOSS_TYPE_SELF)

			local var_2_5 = var_2

			var_2_10003 = var_2.SetJoinTime
			pg = var_5

			local var_2_6 = var_5.TimeMgr.GetInstance()

			var_2_10003(var_2_5, var_5.GetServerTime(var_2_6))

			if var_1.isSetup then
				var_1:ClearRank(var_2.id)

				local var_2_7 = var_1

				var_1.UpdateCacheBoss(var_2_7, var_2)

				var_2_10003 = var_1_1
				WorldBossConst = var_2_7

				if var_2_10003 == var_2_7.BOSS_TYPE_CURR then
					WorldBossConst = var_2_10003
					var_2_10003 = var_2_10003.GetCurrBossConsume()

					var_1:ConsumeSummonPt(var_2_10003)
				else
					var_2_10003 = var_1_1
					WorldBossConst = var_4

					if var_2_10003 == var_4.BOSS_TYPE_ARCHIVES then
						WorldBossConst = var_2_10003
						var_2_10003 = var_2_10003.GetAchieveBossConsume()

						var_1:ConsumeSummonPtOld(var_2_10003)
					end
				end
			end
		else
			pg = var_1

			local var_2_8 = var_1.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_9(var_2_8, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
