class = var_0_10000

local var_0_0 = "BeginStageCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).system

	ys = var_1_0

	var_1_0.Battle.BattleGate.Gates[var_1_1].Entrance(var_2, arg_1_0)

	return
end

function var_0_1.RequestFailStandardProcess(arg_2_0, arg_2_1)
	local var_2_1

	if arg_2_1.result == 10 then
		pg = var_2_1

		local var_2_0 = var_2_1.TipsMgr.GetInstance()

		var_2_1 = var_2_1.ShowTips
		ERROR_MESSAGE = var_1_10005

		var_2_1(var_2_0, var_1_10005[10])
	else
		pg = var_2_1

		local var_2_2 = var_2_1.TipsMgr.GetInstance()
		local var_2_3 = var_2.ShowTips

		errorTip = var_1_10005

		var_2_3(var_2_2, var_1_10005("stage_beginStage", arg_2_1.result))

		local var_2_4 = arg_2_0
		local var_2_5 = arg_2_0.sendNotification

		GAME = var_5

		var_2_5(var_2_4, var_5.BEGIN_STAGE_ERRO, arg_2_1.result)
	end

	return
end

function var_0_1.SendRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = arg_3_5 or {}
	local var_3_1 = {
		system = arg_3_0,
		ship_id_list = arg_3_1,
		data = arg_3_2[1],
		data2 = arg_3_2[2],
		other_ship_id_list = var_3_0
	}

	pg = var_8

	local var_3_2 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_3_2, 40001, var_3_1, 40002, function(arg_4_0)
		if arg_4_0.result == 0 then
			arg_3_3(arg_4_0)
		else
			arg_3_4(arg_4_0)
		end

		return
	end)

	return
end

function var_0_1.DockOverload()
	getProxy = var_1_10000
	PlayerProxy = var_1_10002

	local var_5_0 = var_1_10000(var_1_10002)
	local var_5_1 = var_0.getData(var_5_0)

	getProxy = var_1_10002
	BayProxy = var_1_10004

	local var_5_2 = var_1_10002(var_1_10004)
	local var_5_3 = var_2.getShipCount(var_5_2)
	local var_5_4 = var_5_1

	if var_5_1.getMaxShipBag(var_5_4) <= var_5_3 then
		NoPosMsgBox = var_4
		i18n = var_5_4

		local var_5_5 = var_5_4("switch_to_shop_tip_noDockyard")

		openDockyardClear = var_1_10007
		gotoChargeScene = var_8
		openDockyardIntensify = var_1_10009

		var_4(var_5_5, var_1_10007, var_8, var_1_10009)

		return true
	end

	return false
end

function var_0_1.LegalFleet(arg_6_0)
	getProxy = var_1_10001
	FleetProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)

	if var_1.getFleetById(var_6_0, arg_6_0) == nil or var_2:isEmpty() then
		pg = var_1_10003

		local var_6_1 = var_1_10003.TipsMgr.GetInstance()
		local var_6_2 = var_3.ShowTips

		i18n = var_1_10006

		var_6_2(var_6_1, var_1_10006("stage_beginStage_error_fleetEmpty"))

		return false
	end

	local var_6_3 = var_2
	local var_6_4, var_6_5 = var_2.isLegalToFight(var_6_3)

	if var_6_4 ~= true then
		pg = var_6_3

		local var_6_6 = var_6_3.TipsMgr.GetInstance()
		local var_6_7 = var_5.ShowTips

		i18n = var_1_10008

		local var_6_8 = "stage_beginStage_error_teamEmpty"

		Fleet = var_1_10011

		var_6_7(var_6_6, var_1_10008(var_6_8, var_1_10011.C_TEAM_NAME[var_6_4], var_6_5))

		return false
	end

	return true
end

function var_0_1.ShipVertify()
	getProxy = var_1_10000
	BayProxy = var_1_10002

	local var_7_0 = var_1_10000(var_1_10002)
	local var_7_1 = var_0.getRawData(var_7_0)

	pairs = var_1_10002

	for iter_7_0, iter_7_1 in var_1_10002(var_7_1) do
		if not iter_7_1:attrVertify() then
			BattleVertify = var_7
			var_7.playerShipVertifyFail = true

			break
		end
	end

	return
end

return var_0_1
