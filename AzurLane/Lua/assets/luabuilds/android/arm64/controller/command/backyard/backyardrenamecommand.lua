local var_0_0 = class("BackYardRenameCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(19016, {
		name = arg_1_1:getBody()
	}, 19017, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(DormProxy)
			local var_2_1 = var_2_0:getData()

			var_2_1:setName(var_0)
			var_2_0:updateDrom(var_2_1, BackYardConst.DORM_UPDATE_TYPE_NAME)
			arg_1_0:sendNotification(GAME.BACKYARD_RENAME_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_rename_success"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
