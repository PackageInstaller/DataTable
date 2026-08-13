class = var_0_10000

local var_0_0 = "WorldBossOverTimeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	nowWorld = var_1_0

	local var_1_2 = var_1_0().worldBossProxy

	if var_4.GetSelfBoss(var_1_2) and var_5:IsExpired() then
		local var_1_4

		if var_5:isDeath() then
			local var_1_3 = arg_1_0

			var_1_4 = arg_1_0.sendNotification
			GAME = var_1_10008

			var_1_4(var_1_3, var_1_10008.WORLD_BOSS_SUBMIT_AWARD, {
				bossId = var_5.id
			})
		else
			pg = var_1_4

			local var_1_5 = var_1_4.ConnectionMgr.GetInstance()

			var_6.Send(var_1_5, 34513, {
				type = 0
			}, 34514, function(arg_2_0)
				if arg_2_0.result == 0 then
					-- block empty
				end

				return
			end)
		end

		var_4:ClearRank(var_5.id)
		var_4:RemoveSelfBoss()

		local var_1_6 = arg_1_0
		local var_1_7 = arg_1_0.sendNotification

		GAME = var_8

		var_1_7(var_1_6, var_8.WORLD_SELF_BOSS_OVERTIME_DONE)
	end

	return
end

return var_0_1
