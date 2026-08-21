local var_0_0 = class("ChapterBattleResultRequestCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.body or {}
	local var_1_1 = var_1_0.isSkipBattle

	pg.ConnectionMgr.GetInstance():Send(13106, {
		arg = 0
	}, 13105, function(arg_2_0)
		getProxy(ChapterProxy):OnBattleFinished(arg_2_0, var_1_1)
		existCall(var_1_0.callback)

		return
	end)

	return
end

return var_0_0
