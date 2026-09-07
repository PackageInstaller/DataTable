local DailiyQuickBattleCommand = class("DailiyQuickBattleCommand", pm.SimpleCommand)

function DailiyQuickBattleCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.dailyLevelId
	local var_1_2 = var_1_0.stageId
	local var_1_3 = var_1_0.cnt
	local var_1_4 = getProxy(DailyLevelProxy)

	if (var_1_4.data[var_1_0.dailyLevelId] or 0) + var_1_0.cnt > pg.expedition_daily_template[var_1_0.dailyLevelId].limit_time then
		pg.TipsMgr.GetInstance():ShowTips(i18n("dailyLevel_restCount_notEnough"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(40007, {
		system = SYSTEM_ROUTINE,
		id = var_1_0.stageId,
		cnt = var_1_0.cnt
	}, 40008, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.reward_list) do
				table.insertto(var_2_0, PlayerConst.addTranDrop(iter_2_1.drop_list))
				table.insertto(var_2_0, underscore.map(PlayerConst.addTranDrop(iter_2_1.extra_drop_list or {}), function(arg_3_0)
					arg_3_0.riraty = true

					return arg_3_0
				end))
			end

			var_1_4.data[var_1_1] = (var_1_4.data[var_1_1] or 0) + var_1_3

			self:sendNotification(GAME.DAILY_LEVEL_QUICK_BATTLE_DONE, {
				awards = var_2_0,
				stageId = var_1_2,
				dailyLevelId = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return DailiyQuickBattleCommand
