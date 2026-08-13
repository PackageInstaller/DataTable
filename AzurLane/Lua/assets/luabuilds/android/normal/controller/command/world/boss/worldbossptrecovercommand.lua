class = var_0_10000

local var_0_0 = "WorldBossPtRecoverCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	nowWorld = var_1_10002

	local var_1_0 = var_1_10002()
	local var_1_1 = var_2.GetBossProxy(var_1_0)

	if var_3.isMaxPt(var_1_1) then
		return
	end

	local var_1_2 = var_3
	local var_1_3 = var_3.GetNextReconveTime(var_1_2)

	pg = var_1_2

	local var_1_4 = var_1_2.TimeMgr.GetInstance()
	local var_1_5 = var_5.GetServerTime(var_1_4)
	local var_1_6 = var_3:GetRecoverPtTime()

	if var_1_3 <= var_1_5 then
		local var_1_7 = var_1_5 - var_1_3

		var_1_10009 = var_3

		var_3.increasePt(var_1_10009)

		var_1_10009 = var_3

		if not var_3.isMaxPt(var_1_10009) then
			while var_1_6 <= var_1_7 do
				var_1_10009 = var_3

				var_3.increasePt(var_1_10009)

				var_1_7 = var_1_7 - var_1_6
			end

			local var_1_8 = var_1_5 + (var_1_6 - var_1_7)

			var_3:updatePtTime(var_1_8)
		end
	end

	local var_1_9 = arg_1_0
	local var_1_10 = arg_1_0.sendNotification

	GAME = var_1_10009

	var_1_10(var_1_9, var_1_10009.WORLD_BOSS_PT_RECOVER_DONE)

	return
end

return var_0_1
