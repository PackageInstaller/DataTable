local BeginStageCommand = class("BeginStageCommand", pm.SimpleCommand)

function BeginStageCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	ys.Battle.BattleGate.Gates[var_1_0.system].Entrance(var_1_0, self)

	return
end

function BeginStageCommand:RequestFailStandardProcess(arg_2_1)
	if arg_2_1.result == 10 then
		pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[10])
	else
		pg.TipsMgr.GetInstance():ShowTips(errorTip("stage_beginStage", arg_2_1.result))
		self:sendNotification(GAME.BEGIN_STAGE_ERRO, arg_2_1.result)
	end

	return
end

function BeginStageCommand:SendRequest(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	pg.ConnectionMgr.GetInstance():Send(40001, {
		system = self,
		ship_id_list = arg_3_1,
		data = arg_3_2[1],
		data2 = arg_3_2[2],
		other_ship_id_list = arg_3_5 or {}
	}, 40002, function(arg_4_0)
		if arg_4_0.result == 0 then
			arg_3_3(arg_4_0)
		else
			arg_3_4(arg_4_0)
		end

		return
	end)

	return
end

function BeginStageCommand.DockOverload()
	if getProxy(BayProxy):getShipCount() >= getProxy(PlayerProxy):getData():getMaxShipBag() then
		NoPosMsgBox(i18n("switch_to_shop_tip_noDockyard"), openDockyardClear, gotoChargeScene, openDockyardIntensify)

		return true
	end

	return false
end

function BeginStageCommand:LegalFleet()
	local var_6_0 = getProxy(FleetProxy):getFleetById(self)

	if var_6_0 == nil or var_6_0:isEmpty() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_fleetEmpty"))

		return false
	end

	local var_6_1, var_6_2 = var_6_0:isLegalToFight()

	if var_6_1 ~= true then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_teamEmpty", Fleet.C_TEAM_NAME[var_6_1], var_6_2))

		return false
	end

	return true
end

function BeginStageCommand.ShipVertify()
	for iter_7_0, iter_7_1 in pairs((getProxy(BayProxy):getRawData())) do
		if not iter_7_1:attrVertify() then
			BattleVertify.playerShipVertifyFail = true

			break
		end
	end

	return
end

return BeginStageCommand
