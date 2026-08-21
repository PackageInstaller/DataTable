local var_0_0 = class("BattleGateDebug")

ys.Battle.BattleGateDebug = var_0_0
var_0_0.__name = "BattleGateDebug"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(FleetProxy):getFleetById(1)

	if var_1_0 == nil or var_1_0:isEmpty() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_fleetEmpty"))

		return
	end

	;({
		mainFleetId = 1,
		prefabFleet = {}
	}).stageId = PROLOGUE_DUNGEON
	;({
		mainFleetId = 1,
		prefabFleet = {}
	}).system = SYSTEM_DEBUG

	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		mainFleetId = 1,
		prefabFleet = {}
	})

	return
end

function var_0_0.Exit()
	return
end

function var_0_0.GetPreloadList(arg_3_0)
	local var_3_0 = ys.Battle.BattleResourceManager.GetInstance()
	local var_3_1 = getProxy(FleetProxy)
	local var_3_2 = getProxy(BayProxy)

	for iter_3_0, iter_3_1 in ipairs((var_3_2:getShipsByFleet((var_3_1:getFleetById(arg_3_0.mainFleetId))))) do
		table.insert({}, iter_3_1)
	end

	local var_3_3 = var_3_1:getFleetById(11)

	for iter_3_2, iter_3_3 in ipairs((var_3_3:getTeamByName(TeamType.Submarine))) do
		table.insert({}, (var_3_2:getShipById(iter_3_3)))
	end

	local var_3_4, var_3_5 = var_3_0.GetPlayerShipResource({}, arg_3_0.system)

	for iter_3_4, iter_3_5 in ipairs((var_3_0.GetCommanderBuffRes(var_3_3:buildBattleBuffList()))) do
		table.insert(var_3_4, iter_3_5)
	end

	for iter_3_6, iter_3_7 in ipairs(pg.aircraft_template.all) do
		for iter_3_8, iter_3_9 in ipairs((var_3_0.GetAircraftResource(iter_3_7, {}))) do
			table.insert(var_3_4, iter_3_9)
		end
	end

	return var_3_4, var_3_5
end

return var_0_0
