class = var_0_10000

local var_0_0 = "WorldBossGetOtherFormationCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().bossId
	local var_1_1 = var_2.userId

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 34519, {
		boss_id = var_1_0,
		userId = var_1_1
	}, 34520, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}
			ipairs = var_2_10002

			for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.ship_list) do
				MetaBossRankShip = var_2_10007
				var_2_10007 = var_2_10007.New(iter_2_1)
				table = var_2_10008

				var_2_10008.insert(var_2_0, var_2_10007)
			end

			var_2_10004 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = iter_2_0

			var_2_1(var_2_10004, iter_2_0.WORLD_BOSS_GET_FORMATION_DONE, {
				ships = var_2_0
			})
		else
			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_3(var_2_2, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
