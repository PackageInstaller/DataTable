ys = ys or {}

local var_0_0 = ys
local BattleFleetCardPuzzleDeck = class("BattleFleetCardPuzzleDeck")

ys.Battle.BattleFleetCardPuzzleDeck = BattleFleetCardPuzzleDeck
BattleFleetCardPuzzleDeck.__name = "BattleFleetCardPuzzleDeck"
BattleFleetCardPuzzleDeck.OP_ADD_TO = "add"
BattleFleetCardPuzzleDeck.OP_SHUFFLE_TO = "shuffle"
BattleFleetCardPuzzleDeck.NOT_INIT_SHUFFLE = 0

function BattleFleetCardPuzzleDeck:Ctor(arg_1_1, arg_1_2)
	self._cardPuzzleComponent = arg_1_1
	self._indexID = arg_1_2

	self:init()

	return
end

function BattleFleetCardPuzzleDeck:GetIndexID()
	return self._indexID
end

function BattleFleetCardPuzzleDeck:Dispose()
	return
end

function BattleFleetCardPuzzleDeck:GetCardList()
	return self._cardList
end

function BattleFleetCardPuzzleDeck:init()
	self._cardList = {}

	var_0_0.EventDispatcher.AttachEventDispatcher(self)
	var_0_0.Battle.BattleFleetCardPuzzleCardManageComponent.AttachCardManager(self)

	return
end

return
