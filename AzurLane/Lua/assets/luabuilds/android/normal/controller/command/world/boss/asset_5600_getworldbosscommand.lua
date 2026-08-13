class = var_0_10000

local var_0_0 = "GetWorldBossCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1:getBody() then
		var_1_0 = {}
	end

	local var_1_1 = var_1_0.callback

	nowWorld = var_1_10004

	if not var_1_10004().worldBossProxy then
		return
	end

	pg = var_5

	local var_1_2 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 34501, {
		type = 0
	}, 34502, function(arg_2_0)
		if var_0.worldBossProxy.currentBossLV ~= nil then
			var_1.currentBossLV = arg_2_0.self_boss_lv

			if var_1_1 then
				var_1_1()
			end

			return
		end

		var_1:Setup(arg_2_0)

		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_4

		var_2_1(var_2_0, var_4.WORLD_GET_BOSS_DONE)

		if not var_1:IsOpen() and var_1:GetSelfBoss() ~= nil then
			originalPrint = var_2

			var_2("Notification : boss is overtime")

			pg = var_2

			local var_2_2 = var_2.ConnectionMgr.GetInstance()

			var_2.Send(var_2_2, 34513, {
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

return var_0_1
