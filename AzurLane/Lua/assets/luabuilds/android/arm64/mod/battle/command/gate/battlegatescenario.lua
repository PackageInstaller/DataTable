class = var_0_10000

local var_0_0 = var_0_10000("BattleGateScenario")

ys = var_0_10001
var_0_10001.Battle.BattleGateScenario = var_0_0
var_0_0.__name = "BattleGateScenario"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	BeginStageCommand = var_1_10002

	local var_1_0

	if var_1_10002.DockOverload() then
		getProxy = var_1_0
		ChapterProxy = var_1_10004
		var_1_10004 = var_1_0(var_1_10004)
		var_1_0 = var_1_0.StopAutoFight
		ChapterConst = var_1_10005

		var_1_0(var_1_10004, var_1_10005.AUTOFIGHT_STOP_REASON.DOCK_OVERLOADED)

		return
	end

	getProxy = var_1_0
	PlayerProxy = var_1_10004

	local var_1_1 = var_1_0(var_1_10004)

	getProxy = var_1_10003
	BayProxy = var_1_10005

	local var_1_2 = var_1_10003(var_1_10005)

	pg = var_1_10004

	local var_1_3 = var_1_10004.battle_cost_template

	SYSTEM_SCENARIO = var_1_10005

	local var_1_4 = var_1_3[var_1_10005].oil_cost > 0
	local var_1_5 = {}
	local var_1_6 = 0
	local var_1_7 = 0
	local var_1_8 = 0
	local var_1_9 = 0

	getProxy = var_1_10011
	ChapterProxy = var_1_10013

	local var_1_10 = var_1_10011(var_1_10013)
	local var_1_11 = var_11.getActiveChapter(var_1_10).fleet
	local var_1_12 = var_13.getShips(var_1_11, false)

	ipairs = var_1_10015

	for iter_1_0, iter_1_1 in var_1_10015(var_1_12) do
		var_1_5[#var_1_5 + 1] = iter_1_1.id
	end

	local var_1_13, var_1_14 = var_12:getFleetCost(var_13, arg_1_0.stageId)
	local var_1_15 = var_1_13.gold
	local var_1_16 = var_1_13.oil
	local var_1_17 = var_1_13.gold + var_1_14.gold
	local var_1_18 = var_1_13.oil + var_1_14.oil
	local var_1_19 = var_1_1
	local var_1_20 = var_1_1.getData(var_1_19)

	if var_1_4 and var_1_20.oil < var_1_18 then
		getProxy = var_18
		ChapterProxy = var_1_10020
		var_1_10020 = var_18(var_1_10020)

		local var_1_21 = var_18.StopAutoFight

		ChapterConst = var_1_10021

		var_1_21(var_1_10020, var_1_10021.AUTOFIGHT_STOP_REASON.OIL_LACK)

		ItemTipPanel = var_1_21

		if not var_1_21.ShowOilBuyTip(var_1_18) then
			pg = var_18
			var_1_10020 = var_18.TipsMgr.GetInstance()

			local var_1_22 = var_18.ShowTips

			i18n = var_21

			var_1_22(var_1_10020, var_21("stage_beginStage_error_noResource"))
		end

		return
	end

	local var_1_23 = arg_1_0.stageId

	pg = var_1_19

	local var_1_24 = var_1_19.expedition_data_template[var_1_23].dungeon_id

	ys = var_1_10020

	local var_1_25 = var_1_10020.Battle.BattleDataFunction.GetDungeonTmpDataByID(var_1_24).fleet_prefab

	arg_1_1.ShipVertify()

	local var_1_26
	local var_1_27 = var_12:getPlayType()

	ChapterConst = var_1_10023

	if var_1_27 == var_1_10023.TypeExtra then
		var_1_26 = true
	end

	local var_1_28 = var_12:GetExtraCostRate()

	local function var_1_29(arg_2_0)
		if var_1_4 then
			local var_2_0 = var_1_20

			var_1.consume(var_2_0, {
				gold = 0,
				oil = var_1_16
			})
		end

		if var_0.enter_energy_cost > 0 and not var_1_26 then
			pg = var_1

			local var_2_1 = var_1.gameset.battle_consume_energy.key_value * var_1_28

			ipairs = var_2

			for iter_2_0, iter_2_1 in var_2(var_1_5) do
				local var_2_2 = var_1_2

				if var_7.getShipById(var_2_2, iter_2_1) then
					var_7:cosumeEnergy(var_2_1)

					local var_2_3 = var_1_2

					var_8.updateShip(var_2_3, var_7)
				end
			end
		end

		local var_2_4 = var_1_1

		var_1.updatePlayer(var_2_4, var_1_20)

		local var_2_5 = {
			prefabFleet = var_1_25,
			stageId = var_1_23
		}

		SYSTEM_SCENARIO = var_2
		var_2_5.system = var_2
		var_2_5.token = arg_2_0.key
		var_2_5.exitCallback = arg_2_0.exitCallback

		local var_2_6 = arg_1_1
		local var_2_7 = var_2.sendNotification

		GAME = iter_2_0

		var_2_7(var_2_6, iter_2_0.BEGIN_STAGE_DONE, var_2_5)

		return
	end

	local function var_1_30(arg_3_0)
		local var_3_0 = arg_1_1

		var_1.RequestFailStandardProcess(var_3_0, arg_3_0)

		getProxy = var_1
		ChapterProxy = var_3_0

		local var_3_1 = var_1(var_3_0)
		local var_3_2 = var_1.StopAutoFight

		ChapterConst = var_4

		var_3_2(var_3_1, var_4.AUTOFIGHT_STOP_REASON.UNKNOWN)

		return
	end

	BeginStageCommand = var_1_10025

	local var_1_31 = var_1_10025.SendRequest

	SYSTEM_SCENARIO = var_1_10027

	var_1_31(var_1_10027, var_1_5, {
		var_1_23
	}, var_1_29, var_1_30)

	return
end

function var_0_0.Exit(arg_4_0, arg_4_1)
	if arg_4_1.CheaterVertify() then
		return
	end

	pg = var_2

	local var_4_0 = var_2.battle_cost_template

	SYSTEM_SCENARIO = var_1_10003

	local var_4_1 = var_4_0[var_1_10003]

	getProxy = var_1_10003
	FleetProxy = var_1_10005

	local var_4_2 = var_1_10003(var_1_10005)

	getProxy = var_1_10004
	ChapterProxy = var_1_10006

	local var_4_3 = var_1_10004(var_1_10006)
	local var_4_4 = arg_4_0.statistics._battleScore
	local var_4_5 = 0
	local var_4_6 = 0
	local var_4_7 = {}
	local var_4_8 = var_4_3
	local var_4_9 = var_4_3.getActiveChapter(var_4_8)
	local var_4_10 = var_9.getPlayType(var_4_9)

	ChapterConst = var_4_8

	local var_4_11 = var_4_10 == var_4_8.TypeExtra
	local var_4_12 = var_9.fleet
	local var_4_13 = var_11.getShips(var_4_12, true)

	ipairs = var_1_10013

	for iter_4_0, iter_4_1 in var_1_10013(var_4_13) do
		table = var_1_10018

		var_1_10018.insert(var_4_7, iter_4_1)
	end

	local var_4_14 = arg_4_0.stageId
	local var_4_15, var_4_16 = var_9:getFleetCost(var_11, var_4_14)
	local var_4_17 = var_4_16.gold
	local var_4_18 = var_4_16.oil
	local var_4_19 = var_9
	local var_4_20 = var_9.GetExtraCostRate(var_4_19)

	if arg_4_0.statistics.submarineAid then
		local var_4_21 = var_9

		if var_9.GetSubmarineFleet(var_4_21) then
			var_4_19 = 0
			ipairs = var_4_21

			local var_4_22 = var_17
			local var_4_23 = var_17.getShipsByTeam

			TeamType = var_1_10024

			for iter_4_2, iter_4_3 in var_4_21(var_4_23(var_4_22, var_1_10024.Submarine, true)) do
				if arg_4_0.statistics[iter_4_3.id] then
					table = var_24

					var_24.insert(var_4_7, iter_4_3)

					var_4_19 = var_4_19 + iter_4_3:getEndBattleExpend()
				end
			end

			if var_4_11 then
				var_4_19 = 0
			end

			math = var_19
			var_4_18 = var_4_18 + var_19.min(var_4_19, var_9:GetLimitOilCost(true)) * var_4_20
		else
			originalPrint = var_4_19

			var_4_19("finish stage error: can not find submarine fleet.")
		end
	end

	ys = var_17

	local var_4_24 = var_4_4 > var_17.Battle.BattleConst.BattleScore.C

	var_9:writeBack(var_4_24, arg_4_0)
	var_4_3:updateChapter(var_9)

	local var_4_25 = arg_4_1.GeneralPackage(arg_4_0, var_4_7)

	local function var_4_26(arg_5_0)
		arg_4_1.addShipsExp(arg_5_0.ship_exp_list, arg_4_0.statistics, true)

		local var_5_0 = arg_4_1.GenerateCommanderExp
		local var_5_1 = arg_5_0
		local var_5_2 = var_4_3
		local var_5_3 = var_4.getActiveChapter(var_5_2).fleet
		local var_5_4 = var_0
		local var_5_5 = var_5_0(var_5_1, var_5_3, var_5.GetSubmarineFleet(var_5_4))

		arg_4_0.statistics.mvpShipID = arg_5_0.mvp

		local var_5_6 = arg_4_1
		local var_5_7, var_5_8 = var_2.GeneralLoot(var_5_6, arg_5_0)
		local var_5_9 = arg_4_1.GeneralPlayerCosume

		SYSTEM_SCENARIO = var_5_2

		var_5_9(var_5_2, var_4_24, var_4_18, arg_5_0.player_exp, var_4_11)

		local var_5_10 = {}

		SYSTEM_SCENARIO = var_5
		var_5_10.system = var_5
		var_5_10.statistics = arg_4_0.statistics
		var_5_10.score = var_4_4
		var_5_10.drops = var_5_7
		var_5_10.commanderExps = var_5_5
		var_5_10.result = arg_5_0.result
		var_5_10.extraDrops = var_5_8
		var_5_10.exitCallback = arg_4_0.exitCallback

		local var_5_11 = var_4_3

		var_5.updateActiveChapterShips(var_5_11)

		local var_5_12 = var_4_3
		local var_5_13 = var_5.getActiveChapter(var_5_12)

		var_5.writeDrops(var_5_13, var_5_7)

		local var_5_14 = var_4_3

		var_6.updateChapter(var_5_14, var_5)

		PlayerConst = var_6

		if var_6.CanDropItem(var_5_7) then
			local var_5_15 = {}

			ipairs = var_5_12

			for iter_5_0, iter_5_3 in var_5_12(var_5_7) do
				table = var_2_10012

				var_2_10012.insert(var_5_15, iter_5_3)
			end

			ipairs = var_7

			for iter_5_2, iter_5_3 in var_7(var_5_8) do
				iter_5_3.riraty = true
				table = var_12

				var_12.insert(var_5_15, iter_5_3)
			end

			getProxy = var_7
			ChapterProxy = var_9

			local var_5_16 = var_7(var_9)

			if var_7.getActiveChapter(var_5_16, true) then
				local var_5_17 = var_7

				if var_7.isLoop(var_5_17) then
					getProxy = var_8
					ChapterProxy = var_5_17

					local var_5_18 = var_8(var_5_17)

					var_8.AddExtendChapterDataArray(var_5_18, var_7.id, "TotalDrops", var_5_15)
				end

				var_7:writeDrops(var_5_15)
			end
		end

		local var_5_19 = var_4_3
		local var_5_20 = var_6.getLastUnlockMap(var_5_19).id
		local var_5_21 = var_4_3
		local var_5_22 = var_7.getLastUnlockMap(var_5_21).id

		Map = var_5_19

		if var_5_19.lastMap and var_5_22 ~= var_5_20 and var_5_20 < var_5_22 then
			Map = var_8
			var_8.autoNextPage = true
		end

		local var_5_23 = arg_4_1
		local var_5_24 = var_8.sendNotification

		GAME = iter_5_3

		var_5_24(var_5_23, iter_5_3.CHAPTER_BATTLE_RESULT_REQUEST, {
			callback = function()
				local var_6_0 = arg_4_1
				local var_6_1 = var_0.sendNotification

				GAME = var_3_10003

				var_6_1(var_6_0, var_3_10003.FINISH_STAGE_DONE, var_5_10)

				return
			end
		})

		return
	end

	arg_4_1:SendRequest(var_4_25, var_4_26)

	return
end

function var_0_0.GetPreloadList(arg_7_0)
	local var_7_0 = {}
	local var_7_1

	getProxy = var_1_10003
	ChapterProxy = var_1_10005

	local var_7_2 = var_1_10003(var_1_10005)
	local var_7_3 = var_3.getActiveChapter(var_7_2)

	ys = var_1_10005

	local var_7_4 = var_1_10005.Battle.BattleResourceManager.GetInstance()
	local var_7_5 = var_7_3.fleet
	local var_7_6 = var_6.getShips(var_7_5, false)

	ipairs = var_1_10008

	for iter_7_0, iter_7_1 in var_1_10008(var_7_6) do
		table = var_1_10013

		var_1_10013.insert(var_7_0, iter_7_1)
	end

	local var_7_7, var_7_8 = var_7_3:getFleetBattleBuffs(var_6)
	local var_7_9 = var_3.GetChapterAuraBuffs(var_7_3)
	local var_7_10 = var_3.GetChapterAidBuffs(var_7_3)

	pairs = var_12

	for iter_7_2, iter_7_3 in var_12(var_7_10) do
		ipairs = var_1_10017

		for iter_7_4, iter_7_11 in var_1_10017(iter_7_3) do
			table = var_1_10022

			var_1_10022.insert(var_7_9, iter_7_11)
		end
	end

	local var_7_11, var_7_12 = var_3.getSubAidFlag(var_7_3, arg_7_0.stageId)

	if var_7_11 == true or var_7_11 > 0 then
		local var_7_13 = var_7_12
		local var_7_14 = var_7_12.getShipsByTeam

		TeamType = var_1_10017

		local var_7_15 = var_7_14(var_7_13, var_1_10017.Submarine, false)

		ipairs = var_15

		for iter_7_6, iter_7_7 in var_15(var_7_15) do
			table = iter_7_4

			iter_7_4.insert(var_7_0, iter_7_7)
		end

		local var_7_16 = var_7_3
		local var_7_17, var_7_18 = var_7_3.getFleetBattleBuffs(var_7_16, var_7_12)

		ipairs = var_7_16

		for iter_7_8, iter_7_11 in var_7_16(var_7_17) do
			table = var_1_10022

			var_1_10022.insert(var_7_7, iter_7_11)
		end

		ipairs = var_17

		for iter_7_10, iter_7_11 in var_17(var_7_18) do
			table = var_1_10022

			var_1_10022.insert(var_7_8, iter_7_11)
		end
	end

	local var_7_19, var_7_20 = var_7_4.GetPlayerShipResource(var_7_0, arg_7_0.system)
	local var_7_21 = var_7_4.GetCommanderBuffRes(var_7_8)

	ipairs = var_16

	for iter_7_12, iter_7_13 in var_16(var_7_21) do
		table = iter_7_11

		iter_7_11.insert(var_7_19, iter_7_13)
	end

	local var_7_22 = var_7_4.GetResFromBuffIDList(var_7_7)

	ipairs = var_16

	for iter_7_14, iter_7_15 in var_16(var_7_22) do
		table = iter_7_11

		iter_7_11.insert(var_7_19, iter_7_15)
	end

	local var_7_23 = var_7_4.GetResFromBuffList(var_7_9)

	ipairs = var_16

	for iter_7_16, iter_7_17 in var_16(var_7_23) do
		table = iter_7_11

		iter_7_11.insert(var_7_19, iter_7_17)
	end

	return var_7_19, var_7_20
end

return var_0_0
