local ShipAddIntimacyAndMoneyCommand = class("ShipAddIntimacyAndMoneyCommand", pm.SimpleCommand)

function ShipAddIntimacyAndMoneyCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(DormProxy)
	local var_1_2 = var_1_1:getRawData():GetHasMoneyOrIntimacyShips()

	if #var_1_2 <= 0 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(19011, {
		id = 0
	}, 19012, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(BayProxy)
			local var_2_1 = getProxy(DormProxy):getRawData()
			local var_2_2 = {}
			local var_2_3 = {}
			local var_2_4 = 0

			for iter_2_0, iter_2_1 in ipairs(var_1_2) do
				local var_2_5 = var_2_0:RawGetShipById(iter_2_1.id)

				if iter_2_1:HasIntimacy() then
					table.insert(var_2_2, var_2_5)
				end

				if iter_2_1:HasMoney() then
					var_2_4 = var_2_4 + iter_2_1:GetMoney()

					table.insert(var_2_3, var_2_5)
				end

				var_2_1:HarvestInimacyAndMoney(iter_2_1.id)
			end

			var_1_1:updateDrom(var_2_1, BackYardConst.DORM_UPDATE_TYPE_SHIP)
			self:ShowIntimacyTip(var_2_2)
			self:ShowMoneyTip(var_2_3, var_2_4)
			self:sendNotification(GAME.BACKYARD_ONE_KEY_DONE, {
				shipIds = var_1_2
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

function ShipAddIntimacyAndMoneyCommand:ShowIntimacyTip(arg_3_1)
	if #arg_3_1 == 0 then
		return
	end

	if #arg_3_1 == 1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_shipAddInimacy_ok", arg_3_1[1]:getName()))

		return
	end

	if #arg_3_1 > 1 then
		table.sort(arg_3_1, function(arg_4_0, arg_4_1)
			return arg_4_0.groupId < arg_4_1.groupId
		end)

		local var_3_0 = table.concat(_.map(_.first(arg_3_1, 2), function(arg_5_0)
			return arg_5_0:getName()
		end), "、")

		if #arg_3_1 == 2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_shipAddInimacy_ok", var_3_0))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_shipAddInimacy_ships_ok", var_3_0))
		end

		return
	end

	return
end

function ShipAddIntimacyAndMoneyCommand:ShowMoneyTip(arg_6_1, arg_6_2)
	if #arg_6_1 == 0 then
		return
	end

	if #arg_6_1 == 1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_shipAddMoney_ok", arg_6_1[1]:getName(), arg_6_2))

		return
	end

	if #arg_6_1 > 1 then
		table.sort(arg_6_1, function(arg_7_0, arg_7_1)
			return arg_7_0.groupId < arg_7_1.groupId
		end)

		local var_6_0 = table.concat(_.map(_.first(arg_6_1, 2), function(arg_8_0)
			return arg_8_0:getName()
		end), "、")

		if #arg_6_1 == 2 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_shipAddMoney_ok", var_6_0, arg_6_2))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_shipAddMoney_ships_ok", var_6_0, arg_6_2))
		end
	end

	return
end

return ShipAddIntimacyAndMoneyCommand
