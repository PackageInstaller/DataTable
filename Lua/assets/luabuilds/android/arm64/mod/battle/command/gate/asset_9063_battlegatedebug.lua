local BattleGateDebug = class("BattleGateDebug")

ys.Battle.BattleGateDebug = BattleGateDebug
BattleGateDebug.__name = "BattleGateDebug"

function BattleGateDebug:Entrance(arg_1_1)
	local var_1_0 = getProxy(FleetProxy):getFleetById(1)
	local var_1_1

	if var_1_0 == nil or var_1_0:isEmpty() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("stage_beginStage_error_fleetEmpty"))

		do return end

		var_1_1 = {
			mainFleetId = 1,
			prefabFleet = {}
		}
	end

	var_1_1.stageId = PROLOGUE_DUNGEON
	var_1_1.system = SYSTEM_DEBUG

	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, var_1_1)

	return
end

function BattleGateDebug.Exit()
	return
end

function BattleGateDebug:GetPreloadList()
	local var_3_0 = ys.Battle.BattleResourceManager.GetInstance()
	local var_3_1 = getProxy(FleetProxy)
	local var_3_2 = getProxy(BayProxy)
	local var_3_3 = {}

	for iter_3_0, iter_3_1 in ipairs((var_3_2:getShipsByFleet((var_3_1:getFleetById(self.mainFleetId))))) do
		table.insert(var_3_3, iter_3_1)
	end

	local var_3_4 = var_3_1:getFleetById(11)

	for iter_3_2, iter_3_3 in ipairs((var_3_4:getTeamByName(TeamType.Submarine))) do
		table.insert(var_3_3, (var_3_2:getShipById(iter_3_3)))
	end

	local var_3_5, var_3_6 = var_3_0.GetPlayerShipResource(var_3_3, self.system)

	for iter_3_4, iter_3_5 in ipairs((var_3_0.GetCommanderBuffRes(var_3_4:buildBattleBuffList()))) do
		table.insert(var_3_5, iter_3_5)
	end

	for iter_3_6, iter_3_7 in ipairs(pg.aircraft_template.all) do
		for iter_3_8, iter_3_9 in ipairs((var_3_0.GetAircraftResource(iter_3_7, {}))) do
			table.insert(var_3_5, iter_3_9)
		end
	end

	return var_3_5, var_3_6
end

return BattleGateDebug
