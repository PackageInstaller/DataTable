local var_0_0 = class("GetWorldBossCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() or {}
	local var_1_1 = var_1_0.callback

	if not nowWorld().worldBossProxy then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(34501, {
		type = 0
	}, 34502, function(arg_2_0)
		if var_0.worldBossProxy.currentBossLV ~= nil then
			var_0.worldBossProxy.currentBossLV = arg_2_0.self_boss_lv

			if var_1_1 then
				var_1_1()
			end

			return
		end

		var_0.worldBossProxy:Setup(arg_2_0)
		arg_1_0:sendNotification(GAME.WORLD_GET_BOSS_DONE)

		if not var_0.worldBossProxy:IsOpen() and var_0.worldBossProxy:GetSelfBoss() ~= nil then
			originalPrint("Notification : boss is overtime")
			pg.ConnectionMgr.GetInstance():Send(34513, {
				type = 0
			}, 34514, function(arg_3_0)
				return
			end)
		end

		if var_1_1 then
			var_1_1()
		end

		return
	end)

	return
end

return var_0_0
