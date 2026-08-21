local var_0_0 = class("SubmitWBAwardCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = nowWorld():GetBossProxy()

	pg.ConnectionMgr.GetInstance():Send(34511, {
		boss_id = arg_1_1:getBody().bossId
	}, 34512, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_0:RemoveSelfBoss()
			var_1_0:ClearRank(var_0)
			arg_1_0:sendNotification(GAME.WORLD_BOSS_SUBMIT_AWARD_DONE, {
				items = PlayerConst.addTranDrop(arg_2_0.drops)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n1("领取失败") .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
