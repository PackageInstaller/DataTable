local var_0_0 = class("ActivityBossPageUpdateCommond", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	if not var_1_1 or var_1_1:isEnd() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(26031, {
		act_id = var_1_1.id
	}, 26032, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

			if not var_1_1 or var_1_1:isEnd() then
				return
			end

			var_1_1:UpdatePublicData(arg_2_0)
			getProxy(ActivityProxy):updateActivity(var_1_1)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
