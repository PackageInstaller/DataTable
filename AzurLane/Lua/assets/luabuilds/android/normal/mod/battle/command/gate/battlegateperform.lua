class = var_0_10000

local var_0_0 = var_0_10000("BattleGatePerform")

ys = var_1
var_1.Battle.BattleGatePerform = var_0_0
var_0_0.__name = "BattleGatePerform"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.stageId

	pg = var_1_10003

	local var_1_1 = var_1_10003.expedition_data_template[var_1_0].dungeon_id

	ys = var_1_10004

	local var_1_2

	if not var_1_10004.Battle.BattleDataFunction.GetDungeonTmpDataByID(var_1_1).fleet_prefab then
		var_1_2 = {}
	end

	local var_1_3 = {}

	if arg_1_0.mainFleetId then
		getProxy = var_6
		BayProxy = var_1_10007

		local var_1_4 = var_6(var_1_10007)

		getProxy = var_1_10007
		FleetProxy = var_1_10008
		var_1_10007 = var_1_10007(var_1_10008)

		if not arg_1_1.LegalFleet(arg_1_0.mainFleetId) then
			return
		end

		var_1_10009 = var_1_10007

		local var_1_5 = var_1_10007.getFleetById(var_1_10009, arg_1_0.mainFleetId)

		var_1_10010 = var_1_4
		var_1_10009 = var_1_4.getSortShipsByFleet(var_1_10010, var_1_5)
		ipairs = var_1_10010

		for iter_1_0, iter_1_1 in var_1_10010(var_1_10009) do
			var_1_3[#var_1_3 + 1] = iter_1_1.id
		end
	end

	local var_1_6 = {
		stageId = var_1_0
	}

	SYSTEM_PERFORM = var_1_10007
	var_1_6.system = var_1_10007
	var_1_6.memory = arg_1_0.memory
	var_1_6.exitCallback = arg_1_0.exitCallback
	var_1_6.prefabFleet = var_1_2
	var_1_6.mainFleetId = arg_1_0.mainFleetId

	if arg_1_0.memory then
		local var_1_7 = arg_1_1
		local var_1_8 = arg_1_1.sendNotification

		GAME = var_1_10009

		var_1_8(var_1_7, var_1_10009.BEGIN_STAGE_DONE, var_1_6)
	else
		local function var_1_9(arg_2_0)
			local var_2_0 = arg_1_1
			local var_2_1 = var_1.sendNotification

			GAME = var_2_10003

			local var_2_2 = var_2_10003.STORY_UPDATE
			local var_2_3 = {}

			tostring = var_2_10005
			var_2_3.storyId = var_2_10005(var_1_0)

			var_2_1(var_2_0, var_2_2, var_2_3)

			var_1_6.token = arg_2_0.key

			local var_2_4 = arg_1_1
			local var_2_5 = var_1.sendNotification

			GAME = var_2_2

			var_2_5(var_2_4, var_2_2.BEGIN_STAGE_DONE, var_1_6)

			return
		end

		local function var_1_10(arg_3_0)
			local var_3_0 = arg_1_1

			var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

			return
		end

		BeginStageCommand = var_1_10009

		local var_1_11 = var_1_10009.SendRequest

		SYSTEM_PERFORM = var_1_10010

		var_1_11(var_1_10010, var_1_3, {
			var_1_0
		}, var_1_9, var_1_10)
	end

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	if arg_4_0.memory then
		local var_4_0 = arg_4_1
		local var_4_1 = arg_4_1.sendNotification

		GAME = var_1_10004

		local var_4_2 = var_1_10004.FINISH_STAGE_DONE
		local var_4_3 = {}

		SYSTEM_PERFORM = var_1_10006
		var_4_3.system = var_1_10006

		var_4_1(var_4_0, var_4_2, var_4_3)
	else
		local var_4_4 = arg_4_1.GeneralPackage(arg_4_0, {})

		local function var_4_5(arg_5_0)
			print = var_2_10001

			var_2_10001(arg_4_0.exitCallback)

			local var_5_0 = arg_4_1
			local var_5_1 = var_1.sendNotification

			GAME = var_2_10003

			local var_5_2 = var_2_10003.FINISH_STAGE_DONE
			local var_5_3 = {}

			SYSTEM_PERFORM = var_2_10005
			var_5_3.system = var_2_10005
			var_5_3.exitCallback = arg_4_0.exitCallback

			var_5_1(var_5_0, var_5_2, var_5_3)

			return
		end

		local function var_4_6(arg_6_0)
			local var_6_0 = arg_4_1

			var_1.RequestFailStandardProcess(var_6_0, arg_6_0)

			return
		end

		arg_4_1:SendRequest(var_4_4, var_4_5, var_4_6)
	end

	return
end

return var_0_0
