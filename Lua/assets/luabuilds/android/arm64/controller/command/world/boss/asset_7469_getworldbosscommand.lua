local GetWorldBossCommand = class("GetWorldBossCommand", pm.SimpleCommand)

function GetWorldBossCommand:execute(arg_1_1)
	local var_1_0 = (arg_1_1:getBody() or {}).callback
	local var_1_1 = nowWorld()

	if not var_1_1.worldBossProxy then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(34501, {
		type = 0
	}, 34502, function(arg_2_0)
		if var_1_1.worldBossProxy.currentBossLV ~= nil then
			var_1_1.worldBossProxy.currentBossLV = arg_2_0.self_boss_lv

			if var_1_0 then
				var_1_0()
			end

			return
		end

		var_1_1.worldBossProxy:Setup(arg_2_0)
		self:sendNotification(GAME.WORLD_GET_BOSS_DONE)

		if not var_1_1.worldBossProxy:IsOpen() and var_1_1.worldBossProxy:GetSelfBoss() ~= nil then
			originalPrint("Notification : boss is overtime")
			pg.ConnectionMgr.GetInstance():Send(34513, {
				type = 0
			}, 34514, function(arg_3_0)
				return
			end)
		end

		if var_1_0 then
			var_1_0()
		end

		return
	end)

	return
end

return GetWorldBossCommand
