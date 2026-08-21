local var_0_0 = class("UnlockCryptolaliaCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = getProxy(PlayerProxy):getRawData()
	local var_1_3

	for iter_1_0, iter_1_1 in ipairs((var_1_2:GetCryptolaliaList())) do
		if iter_1_1.id == var_1_0.id then
			var_1_3 = iter_1_1

			break
		end
	end

	if not var_1_3 or not var_1_3:IsLock() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	if not var_1_3:InTime() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

		return
	end

	local var_1_4 = var_1_3:GetCost(var_1_0.costType)

	if var_1_2:getResById(var_1_4.id) < var_1_4.count then
		if var_1_0.costType == Cryptolalia.COST_TYPE_TICKET then
			pg.TipsMgr.GetInstance():ShowTips(i18n("cryptolalia_no_ticket"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))
		end

		return
	end

	pg.ConnectionMgr.GetInstance():Send(16205, {
		id = var_1_0.id,
		cost_type = var_1_0.costType
	}, 16206, function(arg_2_0)
		if arg_2_0.ret == 0 then
			local var_2_0 = getProxy(PlayerProxy):getData()

			var_2_0:UnlockCryptolalia(var_1_1)
			var_2_0:consume({
				[id2res(var_1_4.id)] = var_1_4.count
			})
			getProxy(PlayerProxy):updatePlayer(var_2_0)
			pg.TipsMgr.GetInstance():ShowTips(i18n("cryptolalia_exchange_success"))
			arg_1_0:sendNotification(GAME.UNLOCK_CRYPTOLALIA_DONE, {
				id = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.ret] .. arg_2_0.ret)
		end

		return
	end)

	return
end

return var_0_0
