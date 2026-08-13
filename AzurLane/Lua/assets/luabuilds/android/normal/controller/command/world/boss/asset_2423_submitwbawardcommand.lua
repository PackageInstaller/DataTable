class = var_0_10000

local var_0_0 = "SubmitWBAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().bossId

	nowWorld = var_1_10004

	local var_1_1 = var_1_10004()
	local var_1_2 = var_4.GetBossProxy(var_1_1)

	pg = var_1_1

	local var_1_3 = var_1_1.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 34511, {
		boss_id = var_1_0
	}, 34512, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.drops)
			var_2_10003 = var_1_2

			var_2.RemoveSelfBoss(var_2_10003)

			var_2_10003 = var_1_2

			var_2.ClearRank(var_2_10003, var_1_0)

			var_2_10003 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_4

			var_2_1(var_2_10003, var_4.WORLD_BOSS_SUBMIT_AWARD_DONE, {
				items = var_2_0
			})
		else
			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			i18n1 = var_2_10003

			var_2_3(var_2_2, var_2_10003("领取失败") .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
