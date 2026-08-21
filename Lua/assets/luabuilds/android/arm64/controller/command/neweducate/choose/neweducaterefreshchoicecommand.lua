local var_0_0 = class("NewEducateRefreshChoiceCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.idx
	local var_1_2 = getProxy(NewEducateProxy):GetCurChar()

	if getProxy(NewEducateProxy):GetCurChar():GetResByType(NewEducateChar.RES_TYPE.REFRESH_CHOICE) <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(29105, {
		id = var_1_0.id,
		index = var_1_0.idx
	}, 29106, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM():GetPriorityState()

			var_2_0:UpdataData(arg_2_0.cache)
			getProxy(NewEducateProxy):Cost({
				number = 1,
				type = NewEducateConst.DROP_TYPE.RES,
				id = var_1_2:GetResIdByType(NewEducateChar.RES_TYPE.REFRESH_CHOICE)
			})
			arg_1_0:sendNotification(GAME.NEW_EDUCATE_REFRESH_CHOICE_DONE, {
				idx = var_1_1,
				newId = var_2_0:GetChoices()[var_1_1]
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_RefreshChoice_Error: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
