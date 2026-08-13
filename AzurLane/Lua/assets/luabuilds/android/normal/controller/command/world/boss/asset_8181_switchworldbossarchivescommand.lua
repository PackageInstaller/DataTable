class = var_0_10000

local var_0_0 = "SwitchWorldBossArchivesCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 34527, {
		boss_id = var_1_0
	}, 34528, function(arg_2_0)
		if arg_2_0.result == 0 then
			nowWorld = var_1

			local var_2_0 = var_1()

			var_2_10003 = var_1.GetBossProxy(var_2_0)

			var_1.SetArchivesId(var_2_10003, var_1_0)

			var_2_10003 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_4

			var_2_1(var_2_10003, var_4.SWITCH_WORLD_BOSS_ARCHIVES_DONE)
		else
			pg = var_1

			local var_2_2 = var_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_3(var_2_2, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
