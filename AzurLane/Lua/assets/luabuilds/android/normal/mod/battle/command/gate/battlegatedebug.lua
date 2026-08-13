class = var_0_10000

local var_0_0 = var_0_10000("BattleGateDebug")

ys = var_1
var_1.Battle.BattleGateDebug = var_0_0
var_0_0.__name = "BattleGateDebug"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)

	if var_2.getFleetById(var_1_0, 1) == nil or var_3:isEmpty() then
		pg = var_1_0

		local var_1_1 = var_1_0.TipsMgr.GetInstance()

		var_1_0 = var_1_0.ShowTips
		i18n = var_1_10006

		var_1_0(var_1_1, var_1_10006("stage_beginStage_error_fleetEmpty"))

		return
	end

	PROLOGUE_DUNGEON = var_1_0

	local var_1_2 = {
		mainFleetId = 1,
		prefabFleet = {},
		stageId = var_1_0
	}

	SYSTEM_DEBUG = var_6
	var_1_2.system = var_6

	local var_1_3 = arg_1_1
	local var_1_4 = arg_1_1.sendNotification

	GAME = var_1_10008

	var_1_4(var_1_3, var_1_10008.BEGIN_STAGE_DONE, var_1_2)

	return
end

function var_0_0.Exit()
	return
end

function var_0_0.GetPreloadList(arg_3_0)
	ys = var_1_10001

	local var_3_0 = var_1_10001.Battle.BattleResourceManager.GetInstance()

	getProxy = var_1_10002
	FleetProxy = var_1_10003

	local var_3_1 = var_1_10002(var_1_10003)

	getProxy = var_1_10003
	BayProxy = var_1_10004

	local var_3_2 = var_1_10003(var_1_10004)
	local var_3_3 = {}
	local var_3_4 = var_3_1:getFleetById(arg_3_0.mainFleetId)
	local var_3_5 = var_3_2
	local var_3_6 = var_3_2.getShipsByFleet(var_3_5, var_3_4)

	ipairs = var_3_5

	for iter_3_0, iter_3_1 in var_3_5(var_3_6) do
		table = var_1_10012

		var_1_10012.insert(var_3_3, iter_3_1)
	end

	local var_3_7 = var_3_1:getFleetById(11)
	local var_3_8 = var_7.getTeamByName

	TeamType = iter_3_0

	local var_3_9 = var_3_8(var_3_7, iter_3_0.Submarine)

	ipairs = var_3_7

	for iter_3_2, iter_3_3 in var_3_7(var_3_9) do
		local var_3_10 = var_3_2
		local var_3_11 = var_3_2.getShipById(var_3_10, iter_3_3)

		table = var_3_10

		var_3_10.insert(var_3_3, var_3_11)
	end

	local var_3_12, var_3_13 = var_3_0.GetPlayerShipResource(var_3_3, arg_3_0.system)
	local var_3_14 = var_3_0.GetCommanderBuffRes(var_7:buildBattleBuffList())

	ipairs = var_12

	for iter_3_4, iter_3_5 in var_12(var_3_14) do
		table = var_1_10017

		var_1_10017.insert(var_3_12, iter_3_5)
	end

	pg = var_12

	local var_3_15 = var_12.aircraft_template.all

	ipairs = var_13

	for iter_3_6, iter_3_7 in var_13(var_3_15) do
		local var_3_16 = var_3_0.GetAircraftResource(iter_3_7, {})

		ipairs = var_19

		for iter_3_8, iter_3_9 in var_19(var_3_16) do
			table = var_1_10024

			var_1_10024.insert(var_3_12, iter_3_9)
		end
	end

	return var_3_12, var_3_13
end

return var_0_0
