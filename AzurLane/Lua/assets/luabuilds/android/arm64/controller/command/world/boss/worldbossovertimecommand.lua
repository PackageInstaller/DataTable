local var_0_0 = class("WorldBossOverTimeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = nowWorld().worldBossProxy
	local var_1_2 = var_1_1:GetSelfBoss()

	if var_1_2 and var_1_2:IsExpired() then
		if var_1_2:isDeath() then
			arg_1_0:sendNotification(GAME.WORLD_BOSS_SUBMIT_AWARD, {
				bossId = var_1_2.id
			})
		else
			pg.ConnectionMgr.GetInstance():Send(34513, {
				type = 0
			}, 34514, function(arg_2_0)
				if arg_2_0.result == 0 then
					-- block empty
				end

				return
			end)
		end

		var_1_1:ClearRank(var_1_2.id)
		var_1_1:RemoveSelfBoss()
		arg_1_0:sendNotification(GAME.WORLD_SELF_BOSS_OVERTIME_DONE)
	end

	return
end

return var_0_0
