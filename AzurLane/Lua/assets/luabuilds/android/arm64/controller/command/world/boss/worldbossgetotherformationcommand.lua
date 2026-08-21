local var_0_0 = class("WorldBossGetOtherFormationCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(34519, {
		boss_id = var_1_0.bossId,
		userId = var_1_0.userId
	}, 34520, function(arg_2_0)
		if arg_2_0.result == 0 then
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.ship_list) do
				table.insert({}, (MetaBossRankShip.New(iter_2_1)))
			end

			arg_1_0:sendNotification(GAME.WORLD_BOSS_GET_FORMATION_DONE, {
				ships = {}
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
