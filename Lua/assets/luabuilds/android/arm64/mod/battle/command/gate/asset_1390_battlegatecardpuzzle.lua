local BattleGateCardPuzzle = class("BattleGateCardPuzzle")

ys.Battle.BattleGateCardPuzzle = BattleGateCardPuzzle
BattleGateCardPuzzle.__name = "BattleGateCardPuzzle"

function BattleGateCardPuzzle:Entrance(arg_1_1)
	local var_1_0 = self.combatID
	local var_1_1 = ys.Battle.BattleDataFunction.GetPuzzleDungeonTemplate(self.combatID)
	local var_1_2 = var_1_1.dungeon_id
	local var_1_3 = {
		CardPuzzleShip.New({
			configId = var_1_1.scout_id
		}),
		CardPuzzleShip.New({
			configId = var_1_1.main_id
		})
	}
	local var_1_4 = var_1_1.deck
	local var_1_5 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_1.relic) do
		table.insert(var_1_5, CardPuzzleGift.New({
			configId = iter_1_1
		}))
	end

	;(function(arg_2_0)
		arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
			hp = 1,
			cardPuzzleFleet = var_1_3,
			prefabFleet = {},
			cards = var_1_4,
			relics = var_1_5,
			stageId = var_1_2,
			system = SYSTEM_CARDPUZZLE,
			puzzleCombatID = var_1_0
		})

		return
	end)()

	return
end

function BattleGateCardPuzzle:Exit(arg_3_1)
	if self.statistics._battleScore >= ys.Battle.BattleConst.BattleScore.S then
		local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_CARD_PUZZLE)

		arg_3_1:sendNotification(GAME.ACT_CARD_PUZZLE, {
			cmd = 1,
			activity_id = var_3_0 and var_3_0.id,
			arg1 = self.puzzleCombatID
		})
	end

	arg_3_1:sendNotification(GAME.FINISH_STAGE_DONE, {
		system = SYSTEM_CARDPUZZLE,
		score = self.statistics._battleScore
	})

	return
end

function BattleGateCardPuzzle:GetPreloadList()
	local var_4_0 = {}
	local var_4_1 = {}
	local var_4_2 = ys.Battle.BattleResourceManager.GetInstance()

	for iter_4_0, iter_4_1 in ipairs(self.cards) do
		local var_4_3 = ys.Battle.BattleDataFunction.GetCardRes(ys.Battle.BattleDataFunction.GetPuzzleCardDataTemplate(iter_4_1).effect[1])

		for iter_4_2, iter_4_3 in ipairs(var_4_3) do
			table.insert(var_4_3, iter_4_3)
		end
	end

	for iter_4_4, iter_4_5 in ipairs(self.cardPuzzleFleet) do
		local var_4_4 = ys.Battle.BattleDataFunction.GetPuzzleShipDataTemplate((iter_4_5:getConfig("id")))

		table.insert(var_4_1, var_4_4.skin_id)
		table.insert(var_4_0, var_4_2.GetShipResource(var_4_4.id, var_4_4.skin_id, true))
	end

	table.insert(var_4_0, var_4_2.GetUIPath("CardTowerCardCombat"))
	table.insert(var_4_0, var_4_2.GetFXPath("kapai_weizhi"))

	return var_4_0, var_4_1
end

return BattleGateCardPuzzle
