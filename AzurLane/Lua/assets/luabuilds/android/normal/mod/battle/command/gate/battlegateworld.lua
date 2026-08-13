class = var_0_10000

local var_0_0 = var_0_10000("BattleGateWorld")

ys = var_1
var_1.Battle.BattleGateWorld = var_0_0
var_0_0.__name = "BattleGateWorld"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	nowWorld = var_1_10002

	local var_1_0 = var_1_10002()

	BeginStageCommand = var_1_10003

	if var_1_10003.DockOverload() then
		var_1_10004 = var_1_0

		var_1_0.TriggerAutoFight(var_1_10004, false)

		return
	end

	getProxy = var_3
	PlayerProxy = var_1_10004

	local var_1_1 = var_3(var_1_10004)

	getProxy = var_1_10004
	BayProxy = var_1_10005

	local var_1_2 = var_1_10004(var_1_10005)

	pg = var_1_10005

	local var_1_3 = var_1_10005.battle_cost_template

	SYSTEM_WORLD = var_1_10006

	local var_1_4 = var_1_3[var_1_10006].oil_cost > 0
	local var_1_5 = {}
	local var_1_6 = 0
	local var_1_7 = 0
	local var_1_8 = 0
	local var_1_9 = 0
	local var_1_10 = var_1_0:GetActiveMap()
	local var_1_11 = var_12.GetFleet(var_1_10)
	local var_1_12 = var_13.GetShipVOs(var_1_11, false)

	ipairs = var_1_11

	for iter_1_0, iter_1_1 in var_1_11(var_1_12) do
		var_1_5[#var_1_5 + 1] = iter_1_1.id
	end

	local var_1_13, var_1_14 = var_13:GetCost()
	local var_1_15 = var_1_13.gold
	local var_1_16 = var_1_13.oil
	local var_1_17 = var_1_13.gold + var_1_14.gold
	local var_1_18 = var_1_13.oil + var_1_14.oil
	local var_1_19 = var_1_1:getData()

	if var_1_4 and var_1_19.oil < var_1_18 then
		pg = var_18
		iter_1_1 = var_18.TipsMgr.GetInstance()

		local var_1_20 = var_18.ShowTips

		i18n = var_1_10020

		var_1_20(iter_1_1, var_1_10020("stage_beginStage_error_noResource"))

		return
	end

	local var_1_21 = arg_1_0.stageId

	pg = iter_1_1

	local var_1_22 = iter_1_1.expedition_data_template[var_1_21].dungeon_id

	ys = var_1_10020

	local var_1_23 = var_1_10020.Battle.BattleDataFunction.GetDungeonTmpDataByID(var_1_22).fleet_prefab
	local var_1_24 = arg_1_0.hpRate

	arg_1_1.ShipVertify()

	local function var_1_25(arg_2_0)
		if var_1_4 then
			local var_2_0 = var_1_19

			var_1.consume(var_2_0, {
				gold = 0,
				oil = var_1_16
			})
		end

		local var_2_1 = var_0.enter_energy_cost

		if 0 < var_2_1 then
			exFlag = var_2_1

			if not var_2_1 then
				pg = var_2_1

				local var_2_2 = var_2_1.gameset.battle_consume_energy.key_value

				ipairs = var_2

				for iter_2_0, iter_2_1 in var_2(var_1_12) do
					iter_2_1:cosumeEnergy(var_2_2)

					local var_2_3 = var_1_2

					var_7.updateShip(var_2_3, iter_2_1)
				end
			end
		end

		local var_2_4 = var_1_1

		var_1.updatePlayer(var_2_4, var_1_19)

		local var_2_5 = {
			prefabFleet = var_1_23,
			stageId = var_1_21
		}

		SYSTEM_WORLD = var_2
		var_2_5.system = var_2
		var_2_5.token = arg_2_0.key
		var_2_5.hpRate = var_1_24

		local var_2_6 = arg_1_1
		local var_2_7 = var_2.sendNotification

		GAME = var_2_10004

		var_2_7(var_2_6, var_2_10004.BEGIN_STAGE_DONE, var_2_5)

		return
	end

	local function var_1_26(arg_3_0)
		local var_3_0 = arg_1_1

		var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

		return
	end

	BeginStageCommand = var_1_10024

	local var_1_27 = var_1_10024.SendRequest

	SYSTEM_WORLD = var_1_10025

	var_1_27(var_1_10025, var_1_5, {
		var_1_21
	}, var_1_25, var_1_26)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	if arg_4_1.CheaterVertify() then
		return
	end

	pg = var_2

	local var_4_0 = var_2.battle_cost_template

	SYSTEM_WORLD = var_1_10003

	local var_4_1 = var_4_0[var_1_10003]
	local var_4_2 = arg_4_0.statistics._battleScore
	local var_4_3 = 0
	local var_4_4 = {}

	nowWorld = var_1_10006

	local var_4_5 = var_1_10006()
	local var_4_6 = var_6.GetActiveMap(var_4_5)
	local var_4_7 = var_7.GetFleet(var_4_6)
	local var_4_8 = var_8.GetShipVOs(var_4_7, true)
	local var_4_9, var_4_10 = var_8:GetCost()
	local var_4_11 = var_4_10.oil

	if arg_4_0.statistics.submarineAid then
		local var_4_12 = var_7
		local var_4_13 = var_7.GetSubmarineFleet(var_4_12)

		assert = var_4_12

		var_4_12(var_4_13, "submarine fleet not exist.")

		local var_4_14 = var_4_13
		local var_4_15 = var_4_13.GetTeamShipVOs

		TeamType = var_14

		local var_4_16 = var_4_15(var_4_14, var_14.Submarine, true)

		ipairs = var_4_14

		for iter_4_0, iter_4_1 in var_4_14(var_4_16) do
			if arg_4_0.statistics[iter_4_1.id] then
				table = var_18

				var_18.insert(var_4_8, iter_4_1)
			end
		end

		local var_4_17, var_4_18 = var_4_13:GetCost()

		var_4_11 = var_4_11 + var_4_18.oil
	end

	local var_4_19 = arg_4_1.GeneralPackage(arg_4_0, var_4_8)

	local function var_4_20(arg_5_0)
		arg_4_1.addShipsExp(arg_5_0.ship_exp_list, arg_4_0.statistics, true)

		local var_5_0 = arg_4_1.GenerateCommanderExp
		local var_5_1 = arg_5_0
		local var_5_2 = var_0
		local var_5_3 = var_0
		local var_5_4 = var_5_0(var_5_1, var_5_2, var_4.GetSubmarineFleet(var_5_3))

		arg_4_0.statistics.mvpShipID = arg_5_0.mvp

		local var_5_5 = arg_4_1
		local var_5_6, var_5_7 = var_2.GeneralLoot(var_5_5, arg_5_0)
		local var_5_8 = var_4_2

		ys = var_5_3

		local var_5_9 = var_5_8 > var_5_3.Battle.BattleConst.BattleScore.C
		local var_5_10 = arg_4_1.GeneralPlayerCosume

		SYSTEM_WORLD = var_2_10006

		local var_5_11 = var_5_9
		local var_5_12 = var_4_11
		local var_5_13 = arg_5_0.player_exp

		exFlag = var_2_10010

		var_5_10(var_2_10006, var_5_11, var_5_12, var_5_13, var_2_10010)

		arg_4_0.hpDropInfo = arg_5_0.hp_drop_info

		local var_5_14 = {}

		SYSTEM_WORLD = var_6
		var_5_14.system = var_6
		var_5_14.statistics = arg_4_0.statistics
		var_5_14.score = var_4_2
		var_5_14.drops = var_5_6
		var_5_14.commanderExps = var_5_4
		var_5_14.result = arg_5_0.result
		var_5_14.extraDrops = var_5_7

		local var_5_15 = arg_4_1
		local var_5_16 = var_6.sendNotification

		GAME = var_5_12

		var_5_16(var_5_15, var_5_12.FINISH_STAGE_DONE, var_5_14)

		local var_5_17 = var_0

		var_6.WriteBack(var_5_17, var_5_9, arg_4_0)

		return
	end

	arg_4_1:SendRequest(var_4_19, var_4_20)

	return
end

function var_0_0.GetPreloadList(arg_6_0)
	local var_6_0 = {}
	local var_6_1

	ys = var_1_10003

	local var_6_2 = var_1_10003.Battle.BattleResourceManager.GetInstance()

	nowWorld = var_1_10004

	local var_6_3 = var_1_10004()
	local var_6_4 = var_4.GetActiveMap(var_6_3)
	local var_6_5 = var_5.GetFleet(var_6_4)

	ipairs = var_6_4

	for iter_6_0, iter_6_1 in var_6_4(var_6_5:GetShipVOs(true)) do
		table = var_1_10012

		var_1_10012.insert(var_6_0, iter_6_1)
	end

	local var_6_6, var_6_7 = var_5:getFleetBattleBuffs(var_6_5)

	if var_4:GetSubAidFlag() == true then
		local var_6_8 = var_5:GetSubmarineFleet()
		local var_6_9 = var_10.GetTeamShipVOs

		TeamType = var_1_10013

		local var_6_10 = var_6_9(var_6_8, var_1_10013.Submarine, false)

		ipairs = var_6_8

		for iter_6_2, iter_6_3 in var_6_8(var_6_10) do
			table = var_1_10017

			var_1_10017.insert(var_6_0, iter_6_3)
		end

		local var_6_11, var_6_12 = var_5:getFleetBattleBuffs(var_10)

		ipairs = var_14

		for iter_6_4, iter_6_5 in var_14(var_6_11) do
			table = var_1_10019

			var_1_10019.insert(var_6_6, iter_6_5)
		end

		ipairs = var_14

		for iter_6_6, iter_6_7 in var_14(var_6_12) do
			table = var_1_10019

			var_1_10019.insert(var_6_7, iter_6_7)
		end
	end

	local var_6_13, var_6_14 = var_6_2.GetPlayerShipResource(var_6_0, arg_6_0.system)
	local var_6_15 = var_5:GetChapterAuraBuffs()
	local var_6_16 = var_5
	local var_6_17 = var_5.GetChapterAidBuffs(var_6_16)

	pairs = var_6_16

	for iter_6_8, iter_6_9 in var_6_16(var_6_17) do
		ipairs = var_1_10019

		for iter_6_10, iter_6_11 in var_1_10019(iter_6_9) do
			table = var_1_10024

			var_1_10024.insert(var_6_15, iter_6_11)
		end
	end

	local var_6_18 = var_6_2.GetResFromBuffList(var_6_15)

	ipairs = var_14

	for iter_6_12, iter_6_13 in var_14(var_6_18) do
		table = var_1_10019

		var_1_10019.insert(var_6_13, iter_6_13)
	end

	local var_6_19 = var_5:GetCell(var_6_5.row, var_6_5.column)
	local var_6_20 = var_14.GetStageEnemy(var_6_19)

	table = var_6_19

	local var_6_21 = var_6_19.mergeArray
	local var_6_22 = var_6_20:GetBattleLuaBuffs()
	local var_6_23 = var_5
	local var_6_24 = var_5.GetBattleLuaBuffs

	WorldMap = var_1_10020

	local var_6_25 = var_6_21(var_6_22, var_6_24(var_6_23, var_1_10020.FactionEnemy, var_6_20))

	ipairs = var_16

	for iter_6_14, iter_6_15 in var_16(var_6_25) do
		table = var_21

		var_21.insert(var_6_6, iter_6_15)
	end

	local var_6_26 = var_6_2.GetResFromBuffIDList(var_6_6)

	ipairs = var_16

	for iter_6_16, iter_6_17 in var_16(var_6_26) do
		table = var_21

		var_21.insert(var_6_13, iter_6_17)
	end

	local var_6_27 = var_6_2.GetCommanderBuffRes(var_6_7)

	ipairs = var_16

	for iter_6_18, iter_6_19 in var_16(var_6_27) do
		table = var_21

		var_21.insert(var_6_13, iter_6_19)
	end

	return var_6_13, var_6_14
end

return var_0_0
