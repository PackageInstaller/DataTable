local var_0_0 = class("BattleGateCardPuzzle")

ys.Battle.BattleGateCardPuzzle = var_0_0
var_0_0.__name = "BattleGateCardPuzzle"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	local var_1_0 = ys.Battle.BattleDataFunction.GetPuzzleDungeonTemplate(arg_1_0.combatID)
	local var_1_1 = var_1_0.dungeon_id
	local var_1_2 = {
		CardPuzzleShip.New({
			configId = var_1_0.scout_id
		}),
		CardPuzzleShip.New({
			configId = var_1_0.main_id
		})
	}
	local var_1_3 = var_1_0.deck
	local var_1_4 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.relic) do
		table.insert({}, CardPuzzleGift.New({
			configId = iter_1_1
		}))
	end

	;(function(arg_2_0)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			hp = 1,
			cardPuzzleFleet = var_1_2,
			prefabFleet = {},
			cards = var_1_3,
			relics = var_1_4,
			stageId = var_1_1,
			system = SYSTEM_CARDPUZZLE,
			puzzleCombatID = var_0
		})

		return
	end)()

	return
end

function var_0_0.Exit(arg_3_0, arg_3_1)
	if arg_3_0.statistics._battleScore >= ys.Battle.BattleConst.BattleScore.S then
		local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CARD_PUZZLE)

		arg_3_1:sendNotification(GAME.ACT_CARD_PUZZLE, {
			cmd = 1,
			activity_id = var_3_0 and var_3_0.id,
			arg1 = arg_3_0.puzzleCombatID
		})
	end

	arg_3_1:sendNotification(GAME.FINISH_STAGE_DONE, {
		system = SYSTEM_CARDPUZZLE,
		score = arg_3_0.statistics._battleScore
	})

	return
end

function var_0_0.GetPreloadList(arg_4_0)
	local var_4_0 = ys.Battle.BattleResourceManager.GetInstance()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.cards) do
		local var_4_1 = ys.Battle.BattleDataFunction.GetCardRes(ys.Battle.BattleDataFunction.GetPuzzleCardDataTemplate(iter_4_1).effect[1])

		for iter_4_2, iter_4_3 in ipairs(var_4_1) do
			table.insert(var_4_1, iter_4_3)
		end
	end

	for iter_4_4, iter_4_5 in ipairs(arg_4_0.cardPuzzleFleet) do
		local var_4_2 = ys.Battle.BattleDataFunction.GetPuzzleShipDataTemplate((iter_4_5:getConfig("id")))

		table.insert({}, var_4_2.skin_id)
		table.insert({}, var_4_0.GetShipResource(var_4_2.id, var_4_2.skin_id, true))
	end

	table.insert({}, var_4_0.GetUIPath("CardTowerCardCombat"))
	table.insert({}, var_4_0.GetFXPath("kapai_weizhi"))

	return {}, {}
end

return var_0_0
