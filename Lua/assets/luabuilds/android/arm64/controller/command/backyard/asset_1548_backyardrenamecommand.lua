local BackYardRenameCommand = class("BackYardRenameCommand", pm.SimpleCommand)

function BackYardRenameCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(19016, {
		name = var_1_0
	}, 19017, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(DormProxy)
			local var_2_1 = var_2_0:getData()

			var_2_1:setName(var_1_0)
			var_2_0:updateDrom(var_2_1, BackYardConst.DORM_UPDATE_TYPE_NAME)
			self:sendNotification(GAME.BACKYARD_RENAME_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_rename_success"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return BackYardRenameCommand
