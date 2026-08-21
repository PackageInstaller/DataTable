local var_0_0 = class("DailiyQuickBattleCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.stageId
	local var_1_2 = var_1_0.cnt
	local var_1_3 = getProxy(DailyLevelProxy).data[var_1_0.dailyLevelId] or 0

	if var_1_3 + var_1_0.cnt > pg.expedition_daily_template[var_1_0.dailyLevelId].limit_time then
		pg.TipsMgr.GetInstance():ShowTips(i18n("dailyLevel_restCount_notEnough"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(40007, {
		system = SYSTEM_ROUTINE,
		id = var_1_0.stageId,
		cnt = var_1_0.cnt
	}, 40008, function(arg_2_0)
		if arg_2_0.result == 0 then
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.reward_list) do
				table.insertto({}, PlayerConst.addTranDrop(iter_2_1.drop_list))
				table.insertto({}, underscore.map(PlayerConst.addTranDrop(var_2_1), function(arg_3_0)
					arg_3_0.riraty = true

					return arg_3_0
				end))
			end

			local var_2_2 = var_0.data[var_0] or 0

			var_0.data[var_0] = var_2_2 + var_1_2

			arg_1_0:sendNotification(GAME.DAILY_LEVEL_QUICK_BATTLE_DONE, {
				awards = {},
				stageId = var_1_1,
				dailyLevelId = var_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
