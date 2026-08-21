local var_0_0 = class("EquipCodeImpeachCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(17607, {
		shipgroup = var_1_0.groupId,
		shareid = var_1_0.shareId,
		report_type = var_1_0.type
	}, 17608, function(arg_2_0)
		if arg_2_0.result == 0 then
			pg.m02:sendNotification(GAME.EQUIP_CODE_IMPEACH_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipcode_dislike_success"))
		elseif arg_2_0.result == -1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipcode_report_warning"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
