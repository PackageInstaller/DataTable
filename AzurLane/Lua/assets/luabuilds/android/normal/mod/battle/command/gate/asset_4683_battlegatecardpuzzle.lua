class = var_0_10000

local var_0_0 = var_0_10000("BattleGateCardPuzzle")

ys = var_1
var_1.Battle.BattleGateCardPuzzle = var_0_0
var_0_0.__name = "BattleGateCardPuzzle"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.combatID

	ys = var_1_10003

	local var_1_1 = var_1_10003.Battle.BattleDataFunction.GetPuzzleDungeonTemplate(var_1_0).dungeon_id
	local var_1_2 = {}

	CardPuzzleShip = var_1_10006
	var_1_2[1] = var_1_10006.New({
		configId = var_3.scout_id
	})
	CardPuzzleShip = var_6
	var_1_2[2] = var_6.New({
		configId = var_3.main_id
	})

	local var_1_3 = var_3.deck
	local var_1_4 = {}

	ipairs = var_8

	for iter_1_0, iter_1_1 in var_8(var_3.relic) do
		table = var_1_10013
		var_1_10013 = var_1_10013.insert

		local var_1_5 = var_1_4

		CardPuzzleGift = var_1_10015

		var_1_10013(var_1_5, var_1_10015.New({
			configId = iter_1_1
		}))
	end

	;(function(arg_2_0)
		local var_2_0 = {
			hp = 1,
			cardPuzzleFleet = var_1_2,
			prefabFleet = {},
			cards = var_1_3,
			relics = var_1_4,
			stageId = var_1_1
		}

		SYSTEM_CARDPUZZLE = var_2
		var_2_0.system = var_2
		var_2_0.puzzleCombatID = var_1_0

		local var_2_1 = arg_1_1
		local var_2_2 = var_2.sendNotification

		GAME = var_2_10004

		var_2_2(var_2_1, var_2_10004.BEGIN_STAGE_DONE, var_2_0)

		return
	end)()

	return
end

function var_0_0.Exit(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.statistics._battleScore

	ys = var_1_10003

	if var_1_10003.Battle.BattleConst.BattleScore.S <= var_3_0 then
		getProxy = var_3
		ActivityProxy = var_1_10004
		var_1_10004 = var_3(var_1_10004)

		local var_3_1 = var_3.getActivityByType

		ActivityConst = var_1_10005

		local var_3_2 = var_3_1(var_1_10004, var_1_10005.ACTIVITY_TYPE_CARD_PUZZLE)
		local var_3_3 = arg_3_1

		var_1_10004 = arg_3_1.sendNotification
		GAME = var_1_10006

		var_1_10004(var_3_3, var_1_10006.ACT_CARD_PUZZLE, {
			cmd = 1,
			activity_id = var_3_2 and var_3_2.id,
			arg1 = arg_3_0.puzzleCombatID
		})
	end

	local var_3_4 = {}

	SYSTEM_CARDPUZZLE = var_1_10004
	var_3_4.system = var_1_10004
	var_3_4.score = var_3_0

	local var_3_5 = arg_3_1
	local var_3_6 = arg_3_1.sendNotification

	GAME = var_1_10006

	var_3_6(var_3_5, var_1_10006.FINISH_STAGE_DONE, var_3_4)

	return
end

function var_0_0.GetPreloadList(arg_4_0)
	local var_4_0 = {}
	local var_4_1 = {}

	ys = var_1_10003

	local var_4_2 = var_1_10003.Battle.BattleResourceManager.GetInstance()
	local var_4_3 = arg_4_0.cards

	ipairs = var_1_10005

	for iter_4_0, iter_4_1 in var_1_10005(var_4_3) do
		ys = var_1_10010
		var_1_10010 = var_1_10010.Battle.BattleDataFunction.GetPuzzleCardDataTemplate(iter_4_1).effect[1]
		ys = var_11

		local var_4_4 = var_11.Battle.BattleDataFunction.GetCardRes(var_1_10010)

		ipairs = var_12

		for iter_4_2, iter_4_3 in var_12(var_4_4) do
			table = var_1_10017

			var_1_10017.insert(var_4_4, iter_4_3)
		end
	end

	ipairs = var_5

	for iter_4_4, iter_4_5 in var_5(arg_4_0.cardPuzzleFleet) do
		local var_4_5 = iter_4_5
		local var_4_6 = iter_4_5.getConfig(var_4_5, "id")

		ys = var_4_5

		local var_4_7 = var_4_5.Battle.BattleDataFunction.GetPuzzleShipDataTemplate(var_4_6)

		table = var_12

		var_12.insert(var_4_1, var_4_7.skin_id)

		table = var_12

		var_12.insert(var_4_0, var_4_2.GetShipResource(var_4_7.id, var_4_7.skin_id, true))
	end

	table = var_5

	var_5.insert(var_4_0, var_4_2.GetUIPath("CardTowerCardCombat"))

	table = var_5

	var_5.insert(var_4_0, var_4_2.GetFXPath("kapai_weizhi"))

	return var_4_0, var_4_1
end

return var_0_0
