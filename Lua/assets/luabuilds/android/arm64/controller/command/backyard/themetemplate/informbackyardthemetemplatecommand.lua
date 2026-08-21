local var_0_0 = class("InformBackYardThemeTemplateCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if getProxy(PlayerProxy):getRawData().level < 20 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("inform_level_limit"))

		return
	end

	local var_1_1 = var_1_0.uid
	local var_1_2 = var_1_0.tid
	local var_1_3 = 0

	for iter_1_0, iter_1_1 in ipairs(var_1_0.content) do
		var_1_3 = iter_1_1 + var_1_3
	end

	local var_1_4 = getProxy(DormProxy)
	local var_1_5 = var_1_4:GetShopThemeTemplateById(var_1_0.tid) or var_1_4:GetCollectionThemeTemplateById(var_1_0.tid)

	if not var_1_5 or not var_1_5.name then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(19129, {
		target_id = var_1_1,
		target_name = var_1_0.playerName,
		theme_id = var_1_0.tid,
		theme_name = var_1_5.name,
		reason = var_1_3
	}, 19130, function(arg_2_0)
		if arg_2_0.result == 0 then
			table.insert(getProxy(ChatProxy).informs, var_1_1 .. var_1_2)
			arg_1_0:sendNotification(GAME.INFORM_THEME_TEMPLATE_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("inform_sueecss"))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
