local PrayPoolBuildCommand = class("PrayPoolBuildCommand", pm.SimpleCommand)

function PrayPoolBuildCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		activity_id = ActivityConst.ACTIVITY_PRAY_POOL,
		arg1 = var_1_0.pooltype,
		arg2 = var_1_0.shipIDList[1],
		arg3 = var_1_0.shipIDList[2],
		arg_list = {}
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(PrayProxy):updatePageState(PrayProxy.STAGE_BUILD_SUCCESS)
			self:sendNotification(PrayPoolConst.BUILD_PRAY_POOL_SUCCESS, PrayProxy.STAGE_BUILD_SUCCESS)
			pg.TipsMgr.GetInstance():ShowTips(i18n("tip_pray_build_pool_success"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("tip_pray_build_pool_fail"))
		end

		return
	end)

	return
end

return PrayPoolBuildCommand
