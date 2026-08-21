ys = ys or {}

local var_0_9 = class("BattleFleetCardPuzzleDeck")

ys.Battle.BattleFleetCardPuzzleDeck = var_0_9
var_0_9.__name = "BattleFleetCardPuzzleDeck"
var_0_9.OP_ADD_TO = "add"
var_0_9.OP_SHUFFLE_TO = "shuffle"
var_0_9.NOT_INIT_SHUFFLE = 0

function var_0_9.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._cardPuzzleComponent = arg_1_1
	arg_1_0._indexID = arg_1_2

	arg_1_0:init()

	return
end

function var_0_9.GetIndexID(arg_2_0)
	return arg_2_0._indexID
end

function var_0_9.Dispose(arg_3_0)
	return
end

function var_0_9.GetCardList(arg_4_0)
	return arg_4_0._cardList
end

function var_0_9.init(arg_5_0)
	arg_5_0._cardList = {}

	var_0.EventDispatcher.AttachEventDispatcher(arg_5_0)
	var_0.Battle.BattleFleetCardPuzzleCardManageComponent.AttachCardManager(arg_5_0)

	return
end

return
