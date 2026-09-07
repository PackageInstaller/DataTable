local WorldBossGetOtherFormationCommand = class("WorldBossGetOtherFormationCommand", pm.SimpleCommand)

function WorldBossGetOtherFormationCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(34519, {
		boss_id = var_1_0.bossId,
		userId = var_1_0.userId
	}, 34520, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = {}

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.ship_list) do
				table.insert(var_2_0, (MetaBossRankShip.New(iter_2_1)))
			end

			self:sendNotification(GAME.WORLD_BOSS_GET_FORMATION_DONE, {
				ships = var_2_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return WorldBossGetOtherFormationCommand
