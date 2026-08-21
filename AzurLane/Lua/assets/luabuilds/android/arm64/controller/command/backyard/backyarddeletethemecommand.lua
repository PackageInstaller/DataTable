local var_0_0 = class("BackYardDeleteThemeCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(DormProxy)

	if not getProxy(DormProxy):getThemeById(var_1_0) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_theme_no_exist"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(19022, {
		id = var_1_0
	}, 19023, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:deleteTheme(var_1_0)
			arg_1_0:sendNotification(GAME.DELETE_BACKYARD_THEME_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("backayrd_theme_delete_sucess"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("backayrd_theme_delete_erro"))
		end

		return
	end)

	return
end

return var_0_0
