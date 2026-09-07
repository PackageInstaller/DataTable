ys = ys or {}

local var_0_0 = ys
local BattleFleetCardPuzzleDiscard = class("BattleFleetCardPuzzleDiscard")

ys.Battle.BattleFleetCardPuzzleDiscard = BattleFleetCardPuzzleDiscard
BattleFleetCardPuzzleDiscard.__name = "BattleFleetCardPuzzleDiscard"

function BattleFleetCardPuzzleDiscard:Ctor(arg_1_1, arg_1_2)
	self._cardPuzzleComponent = arg_1_1
	self._indexID = arg_1_2

	self:init()

	return
end

function BattleFleetCardPuzzleDiscard:GetIndexID()
	return self._indexID
end

function BattleFleetCardPuzzleDiscard:Dispose()
	return
end

function BattleFleetCardPuzzleDiscard:GetCardList()
	return self._discardList
end

function BattleFleetCardPuzzleDiscard:init()
	self._discardList = {}

	var_0_0.EventDispatcher.AttachEventDispatcher(self)
	var_0_0.Battle.BattleFleetCardPuzzleCardManageComponent.AttachCardManager(self)

	return
end

return
