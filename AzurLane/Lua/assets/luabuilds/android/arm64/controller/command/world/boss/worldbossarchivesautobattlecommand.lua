class = var_0_10000

local var_0_0 = "WorldBossArchivesAutoBattleCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	nowWorld = var_1_0

	local var_1_2 = var_1_0()
	local var_1_3 = var_4.GetBossProxy(var_1_2)

	if not var_4.GetSelfBoss(var_1_3) or var_5:isDeath() then
		return
	end

	WorldBossConst = var_1_2

	local var_1_4 = var_1_2.GetAutoBattleOilConsume()

	getProxy = var_1_3
	PlayerProxy = var_1_10009

	local var_1_5 = var_1_3(var_1_10009)
	local var_1_6 = var_7.getRawData(var_1_5)
	local var_1_7 = var_7.getResource

	PlayerConst = var_1_10011

	local var_1_9

	if var_1_7(var_1_6, var_1_10011.ResOil) < var_1_4 then
		pg = var_1_9

		local var_1_8 = var_1_9.TipsMgr.GetInstance()

		var_1_9 = var_1_9.ShowTips
		i18n = var_11

		var_1_9(var_1_8, var_11("world_boss_auto_battle_no_oil"))

		return
	end

	pg = var_1_9

	local var_1_10 = var_1_9.ConnectionMgr.GetInstance()

	var_8.Send(var_1_10, 34523, {
		boss_id = var_1_1
	}, 34524, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			PlayerProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_2_10004 = var_1.getData(var_2_0)

			var_1.consume(var_2_10004, {
				oil = var_1_4
			})

			getProxy = var_2
			PlayerProxy = var_2_10004
			var_2_10004 = var_2(var_2_10004)

			var_2.updatePlayer(var_2_10004, var_1)

			var_2_10004 = var_0

			var_2.UpdateAutoBattleFinishTime(var_2_10004, arg_2_0.auto_fight_finish_time)

			var_2_10004 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_5

			var_2_1(var_2_10004, var_5.WORLD_ARCHIVES_BOSS_AUTO_BATTLE_DONE)
		else
			pg = var_1

			local var_2_2 = var_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_3(var_2_2, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
