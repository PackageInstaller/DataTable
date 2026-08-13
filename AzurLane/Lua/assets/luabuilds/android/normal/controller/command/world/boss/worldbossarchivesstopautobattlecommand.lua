class = var_0_10000

local var_0_0 = "WorldBossArchivesStopAutoBattleCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.type

	nowWorld = var_1_10005

	local var_1_2 = var_1_10005()
	local var_1_3 = var_5.GetBossProxy(var_1_2)

	if not var_5.GetSelfBoss(var_1_3) then
		return
	end

	local var_1_4 = var_6.hp
	local var_1_5 = var_5
	local var_1_6 = var_5.GetHighestDamage(var_1_5)

	pg = var_1_5

	local var_1_7 = var_1_5.ConnectionMgr.GetInstance()

	var_9.Send(var_1_7, 34525, {
		boss_id = var_1_0
	}, 34526, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1.ClearAutoBattle(var_2_0)

			if not arg_2_0.count then
				var_2_1 = 0
			end

			local var_2_2

			if not arg_2_0.damage then
				var_2_2 = 0
			end

			if not arg_2_0.oil then
				var_2_10003 = 0
			end

			local var_2_3 = arg_1_0
			local var_2_4 = var_4.sendNotification

			GAME = var_2_10006

			var_2_4(var_2_3, var_2_10006.WORLD_ARCHIVES_BOSS_STOP_AUTO_BATTLE_DONE, {
				cnt = var_2_1,
				damage = var_2_2,
				oil = var_2_10003
			})
		else
			pg = var_2_1

			local var_2_5 = var_2_1.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_6(var_2_5, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
