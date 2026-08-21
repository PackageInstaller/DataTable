ys = ys or {}

local var_0_6 = ys.Battle.BattleCardPuzzleConfig
local var_0_8 = ys.Battle.BattleDataFunction
local var_0_10 = class("BattleFleetCardPuzzleMoveDeck")

ys.Battle.BattleFleetCardPuzzleMoveDeck = var_0_10
var_0_10.__name = "BattleFleetCardPuzzleMoveDeck"

function var_0_10.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._cardPuzzleComponent = arg_1_1
	arg_1_0._indexID = arg_1_2

	arg_1_0:init()

	return
end

function var_0_10.CustomConfig(arg_2_0, arg_2_1)
	arg_2_0._generateRate = var_0_8.GetPuzzleDungeonTemplate(arg_2_1).move_recovery

	return
end

function var_0_10.GetIndexID(arg_3_0)
	return arg_3_0._indexID
end

function var_0_10.Dispose(arg_4_0)
	return
end

function var_0_10.GetCardList(arg_5_0)
	return arg_5_0._moveCardList
end

function var_0_10.Update(arg_6_0, arg_6_1)
	arg_6_0:update(arg_6_1)

	return
end

function var_0_10.init(arg_7_0)
	arg_7_0._moveCardList = {}

	var_0.EventDispatcher.AttachEventDispatcher(arg_7_0)
	var_0.Battle.BattleFleetCardPuzzleCardManageComponent.AttachCardManager(arg_7_0)

	arg_7_0._attrManager = arg_7_0._cardPuzzleComponent:GetAttrManager()
	arg_7_0._generateRate = var_0_6.moveCardGenerateSpeedPerSecond
	arg_7_0._maxMoveCard = var_0_6.BASE_MAX_MOVE
	arg_7_0._generating = 0

	arg_7_0:updateTimeStamp()

	return
end

function var_0_10.updateTimeStamp(arg_8_0)
	arg_8_0._lastUpdateTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function var_0_10.update(arg_9_0, arg_9_1)
	if arg_9_0:GetLength() < arg_9_0._maxMoveCard + arg_9_0._attrManager:GetCurrent("MoveExtra") then
		arg_9_0._generating = (arg_9_1 - arg_9_0._lastUpdateTimeStamp) * arg_9_0._generateRate + arg_9_0._generating
	end

	arg_9_0:updateTimeStamp()

	return
end

function var_0_10.GetGeneratePorcess(arg_10_0)
	return arg_10_0._generating
end

function var_0_10.TryPlayTopMoveCard(arg_11_0)
	local var_11_0 = arg_11_0:GetLength()

	if var_11_0 > 0 then
		return arg_11_0:GetCardList()[var_11_0]
	end

	return
end

function var_0_10.RestartGenrate(arg_12_0)
	arg_12_0._generating = 0

	return
end

return
