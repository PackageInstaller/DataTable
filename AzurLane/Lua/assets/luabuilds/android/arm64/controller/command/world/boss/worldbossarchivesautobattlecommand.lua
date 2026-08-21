local var_0_0 = class("WorldBossArchivesAutoBattleCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = nowWorld():GetBossProxy()
	local var_1_1 = nowWorld():GetBossProxy():GetSelfBoss()

	if not var_1_1 or var_1_1:isDeath() then
		return
	end

	if WorldBossConst.GetAutoBattleOilConsume() > getProxy(PlayerProxy):getRawData():getResource(PlayerConst.ResOil) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("world_boss_auto_battle_no_oil"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(34523, {
		boss_id = arg_1_1:getBody().id
	}, 34524, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(PlayerProxy):getData()

			var_2_0:consume({
				oil = var_0
			})
			getProxy(PlayerProxy):updatePlayer(var_2_0)
			var_1_0:UpdateAutoBattleFinishTime(arg_2_0.auto_fight_finish_time)
			arg_1_0:sendNotification(GAME.WORLD_ARCHIVES_BOSS_AUTO_BATTLE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
