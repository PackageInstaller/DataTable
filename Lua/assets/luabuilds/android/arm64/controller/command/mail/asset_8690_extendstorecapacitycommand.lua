local ExtendStoreCapacityCommand = class("ExtendStoreCapacityCommand", pm.SimpleCommand)

function ExtendStoreCapacityCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().isDiamond
	local var_1_1 = {}

	var_1_1[1] = getProxy(PlayerProxy):getRawData():GetExtendStoreCost()

	local var_1_2 = var_1_1[var_1_0 and 1 or 2]

	if not var_1_1[var_1_0 and 1 or 2] then
		pg.TipsMgr.GetInstance():ShowTips("level max")

		return
	elseif var_1_1[var_1_0 and 1 or 2]:getOwnedCount() < var_1_1[var_1_0 and 1 or 2].count then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_x", var_1_1[var_1_0 and 1 or 2]:getName()))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(30010, {
		arg = var_1_1[var_1_0 and 1 or 2].id
	}, 30011, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(PlayerProxy):getData()

			var_2_0:consume({
				[id2res(var_1_2.id)] = var_1_2.count
			})

			var_2_0.mailStoreLevel = var_2_0.mailStoreLevel + 1

			getProxy(PlayerProxy):updatePlayer(var_2_0)
			self:sendNotification(GAME.EXTEND_STORE_CAPACITY_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return ExtendStoreCapacityCommand
